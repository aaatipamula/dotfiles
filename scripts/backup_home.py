#!/usr/bin/python3

from typing import List, Tuple
from argparse import ArgumentParser
from pathlib import Path
from datetime import datetime
from fnmatch import fnmatch
from os import makedirs
import tarfile
import logging
import sys

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format="%(levelname)s: %(message)s"
)

logger = logging.getLogger(__name__)

# Setup the parser
parser = ArgumentParser(
    prog="Backup Home",
    description="Backup all the files in my home directory",
)
parser.add_argument(
    "-v",
    "--verbose",
    action='store_true',
    help="Print debug logs",
)
parser.add_argument(
    "-u",
    "--dry-run",
    action='store_true',
    help="List the file about to be backed up without backing up",
)
parser.add_argument(
    "-s", 
    "--source-dir",
    type=Path,
    nargs=1,
    help="Directory to back up, defaults to  ~/",
)
parser.add_argument(
    "-d", 
    "--destination-dir",
    type=Path,
    nargs=1,
    help="Destination directory to back up, defaults to ~/.backups",
)
parser.add_argument(
    "--ignore-file",
    type=Path,
    nargs=1,
    help="Destination to ignore file, defaults to ~/.backup_exclude",
)

# Defaults for arguments
class BackupArgs:
    def __init__(self) -> None:
        self.verbose: bool = False
        self.dry_run: bool = False
        self.source_dir: Path = Path.home()
        self.destination_dir: Path = Path.home() / ".backups/"
        self.ignore_file: Path = Path.home() / ".backup_exclude"

IGNORE_DIRS = ["node_modules", ".venv", ".next"]

# Read the backup ignore file and collect globbing rules
def collect_ignore_patterns(ignore_file: Path) -> List[str]:
    ignore_rule_list: List[str] = [".*"] # Always ignore dotfiles

    # Read backup_ignore file
    try:
        with open(ignore_file, "r") as file:
            logger.info("Found ignore file")
            for line in file:
                line = line.split("#")[0].strip()
                if line:
                    logger.debug(f"Adding rule ({line})")
                    ignore_rule_list.append(line)
    except FileNotFoundError:
        logger.error(f"Invalid path to ignore file - {ignore_file}")
        exit(1)

    return ignore_rule_list

# Check if a file matches the glob for any rule
def is_ignored(file: Path, ignore_rules: List[str]) -> bool:
    return any(fnmatch(file.name, rule) for rule in ignore_rules)

# Collect a list of top-level files to actually back up
def collect_backup_files(source_dir: Path, ignore_rules: List[str]) -> List[Path]:
    return [file for file in source_dir.iterdir() if not is_ignored(file, ignore_rules)]

# Ignore files which contain any ignored directories
def contains_ignored(file: Path) -> bool:
    return any(dirname in file.parts for dirname in IGNORE_DIRS)

# Expand directories to include all their files
def expand_files(file_list: List[Path]) -> List[Path]:
    all_files = []
    for path in file_list:
        if path.is_dir():
            all_files.extend(
                f for f in path.rglob("*")
                if f.is_file() and not contains_ignored(f)
            )
        else:
            all_files.append(path)

    return all_files

def generate_timestamp(fmt: str = "%Y%m%d_%H%M%S") -> str:
    return datetime.now().strftime(fmt)

def create_archive(file_list: List[Path], destination: Path):
    # Create the parent directories they don't exist
    if not destination.parent.is_dir():
        makedirs(destination, mode=0o711)

    # expand directories to include all their files
    all_files = expand_files(file_list)
    total = len(all_files)

    try:
        logging.info(f"Creating archive at {destination}")
        with tarfile.open(destination, "w:gz") as tar:
            for i, file in enumerate(all_files, 1):
                tar.add(file, recursive=False)
                percent = (i / total) * 100
                print(f"\r{i}/{total} ({percent:.1f}%) - {file.name:<30}", end="", flush=True)
    except tarfile.TarError as e:
        logging.error("Something went wrong trying to create tar archive")
        logging.error(str(e))

    print()

def main():
    args = parser.parse_args(sys.argv[1::], namespace=BackupArgs())

    if args.verbose:
        logger.setLevel(logging.DEBUG)

    # Collect files to backup
    ignore_rules = collect_ignore_patterns(args.ignore_file)
    backup_list = collect_backup_files(args.source_dir, ignore_rules)

    # Dry run
    if args.dry_run:
        all_files = expand_files(backup_list)
        total = len(all_files)
        logger.debug(f"{len(backup_list)} top-level files are to be backed up to {args.destination_dir}:")
        logger.debug(f"{total} total files are to be backed up:\n")
        for file in backup_list:
            logger.debug(f"* {file}")
        return

    destination_file = args.destination_dir / f"{generate_timestamp()}.tar.gz"
    create_archive(backup_list, destination_file)

if __name__ == "__main__":
    main()

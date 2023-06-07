#!/bin/bash
set -euo pipefail
set -x

# define variables
python_bin=/usr/bin/python3
datetime=$(date +'%Y%m%d%H%M%S')

# cd to correct directory
cd /usr/local/bin/ipranges/

# start downloaders
bash google/downloader.sh
bash amazon/downloader.sh
bash microsoft/downloader.sh
bash oracle/downloader.sh
bash digitalocean/downloader.sh
bash bing/downloader.sh
bash github/downloader.sh
bash facebook/downloader.sh
bash twitter/downloader.sh
bash linode/downloader.sh

# create all-in-one ranges
cat apple/ipv4.txt google/ipv4.txt amazon/ipv4.txt microsoft/ipv4.txt oracle/ipv4.txt digitalocean/ipv4.txt bing/ipv4.txt github/ipv4.txt facebook/ipv4.txt twitter/ipv4.txt linode/ipv4.txt telegram/ipv4.txt | sort -h | uniq > all/ipv4.txt
cat google/ipv6.txt amazon/ipv6.txt microsoft/ipv6.txt digitalocean/ipv6.txt github/ipv6.txt facebook/ipv6.txt twitter/ipv6.txt linode/ipv6.txt telegram/ipv6.txt | sort -h | uniq > all/ipv6.txt


# merge ipv4
$python_bin utils/merge.py --source=apple/ipv4.txt | sort -h > apple/ipv4_merged.txt
$python_bin utils/merge.py --source=google/ipv4.txt | sort -h > google/ipv4_merged.txt
$python_bin utils/merge.py --source=amazon/ipv4.txt | sort -h > amazon/ipv4_merged.txt
$python_bin utils/merge.py --source=microsoft/ipv4.txt | sort -h > microsoft/ipv4_merged.txt
$python_bin utils/merge.py --source=oracle/ipv4.txt | sort -h > oracle/ipv4_merged.txt
$python_bin utils/merge.py --source=digitalocean/ipv4.txt | sort -h > digitalocean/ipv4_merged.txt
$python_bin utils/merge.py --source=bing/ipv4.txt | sort -h > bing/ipv4_merged.txt
$python_bin utils/merge.py --source=github/ipv4.txt | sort -h > github/ipv4_merged.txt
$python_bin utils/merge.py --source=facebook/ipv4.txt | sort -h > facebook/ipv4_merged.txt
$python_bin utils/merge.py --source=twitter/ipv4.txt | sort -h > twitter/ipv4_merged.txt
$python_bin utils/merge.py --source=linode/ipv4.txt | sort -h > linode/ipv4_merged.txt
$python_bin utils/merge.py --source=telegram/ipv4.txt | sort -h > telegram/ipv4_merged.txt
$python_bin utils/merge.py --source=all/ipv4.txt | sort -h > all/ipv4_merged.txt

# merge ipv6
$python_bin utils/merge.py --source=google/ipv6.txt | sort -h > google/ipv6_merged.txt
$python_bin utils/merge.py --source=amazon/ipv6.txt | sort -h > amazon/ipv6_merged.txt
$python_bin utils/merge.py --source=microsoft/ipv6.txt | sort -h > microsoft/ipv6_merged.txt
# oracle not provide ipv6
$python_bin utils/merge.py --source=digitalocean/ipv6.txt | sort -h > digitalocean/ipv6_merged.txt
# bing not provide ipv6
$python_bin utils/merge.py --source=github/ipv6.txt | sort -h > github/ipv6_merged.txt
$python_bin utils/merge.py --source=facebook/ipv6.txt | sort -h > facebook/ipv6_merged.txt
$python_bin utils/merge.py --source=twitter/ipv6.txt | sort -h > twitter/ipv6_merged.txt
$python_bin utils/merge.py --source=linode/ipv6.txt | sort -h > linode/ipv6_merged.txt
$python_bin utils/merge.py --source=telegram/ipv6.txt | sort -h > telegram/ipv6_merged.txt
$python_bin utils/merge.py --source=all/ipv6.txt | sort -h > all/ipv6_merged.txt


# commit and push
git add .
git commit -m $datetime
git push

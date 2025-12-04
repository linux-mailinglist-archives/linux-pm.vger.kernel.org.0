Return-Path: <linux-pm+bounces-39217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E716CA51EC
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E8030B209B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68534A764;
	Thu,  4 Dec 2025 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj1v18XN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B4345CAC
	for <linux-pm@vger.kernel.org>; Thu,  4 Dec 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876582; cv=none; b=ul1gYKOOQoxWOrS/Jo0aNwf7RCDrBrMKgp4gb3CKH/kq44vFLXTj6snYum37ylu7jPc/X2kBydPoQ5adr9GBAHrRpIS2LTRv++2Z+RpyV+jaICNv3P7bZ3hWZiJ5+mfFwYBw4pjAzXJH2La+6elksXbgJj7LBsqpo7mdHvbDsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876582; c=relaxed/simple;
	bh=i5RlmtxXCdWtwZB3hf9A8JL1M1/AKu+ssjIASvWZXBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kGzIcBb2IOfe+FZx8EGxv26yomXpE/fcvhsWVIWA3Yc7/XAYEqnaBMdqWb6An8xO8LJCzyVAx92FW3yDgaV9rtuDHC/NNh3ih1TbjcuKIXnFb0IJkuPr2EaUUOMXAqprzvkTwtKK4sxHZIq8mHqbp3j7Wj+qJ0FR3bD1JcTzDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj1v18XN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso1548560b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2025 11:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764876580; x=1765481380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/50DzzGGuZCmEfhhyIsQODb6cUpEszW9hVXDiA/0gbE=;
        b=Lj1v18XNFyxOIJx8SYQEWzyt8NkMwTaj3L/ehU6Hm5d6ieUwpolZMiVX/QYGlsSk/B
         ++L5X4up7r5UNdNcw/HwV79YSdXqx1Sfa56A6uTsllgMsGW6pC/9EAT1CtDQdORzu24+
         mgdryYhuwFu2CBmaOEGY2oCJJOMFuZZMfJeBRtAxIXL+PgOpbdeNq7opOXYNvgh49rGW
         oLKenGgGn4FWtpj6f9iXrKtdGvyMmFwpWy+FbPpIGY9LRqjD77pIam9sxT30oEMmakKn
         J9D170x0wQ6hm9nKA2L99Ex5FKk+fdyaV1TtcDpoOU8lCciSsbzcDgRHK8d35zXaolCb
         dHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764876580; x=1765481380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/50DzzGGuZCmEfhhyIsQODb6cUpEszW9hVXDiA/0gbE=;
        b=PZrFEQb57kKVM1oH8yr/j+rzcGoz8sIeEUp6RtVydyl6SPDg/2v/TNt9y1ayzbFtnD
         JUVF4DwkAnwn3LZLUkXgBbgaA/83wAX4z9uRze835knC5K8bsWVR5e4KWmtJJvqEKJMi
         IJLDmZL92wjbrPoOQCGiLR8++m0t7vfEBy+1shHnA2VCi1SOw/VFrD+e5NFiB3NZO9wl
         dCx+6Vph1O5Q9hestFqdjcngrvvoKoCGuTxchxMFB3m484XBaUPd2jtU4ngmFqdSmDGs
         Yc3F3A7K+nzSjk3wMystHUFGFZDl0vC756OkGvsNAj+sQckdjrQE78utG0x/KgduZp49
         LX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYqGlrMK4DwzGIEtO+2MxdQc6ElPoiVz3ep1UGKY8uKXD8tC9HwKQUb6E6G58XGoFtkinIh7w3jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpiowqs/lyBsVZgBStsuB4VK9e58mRt1EDcnC9kVbQ9bqpzfi
	SVnS5lOVex44otsyk95UgthMwjXaf3LMqqwFqGPrtvxObXLu199TUVQB
X-Gm-Gg: ASbGnctgzWM3y6+dEb6vQG6ZIrCCN9Iy8rVsL5NTtscLA0HcNcV2rZLz68WZowPpVHX
	v/9Yy1UC/r+spddhEV9wwZT2KSfVQQL41PHMHBIFWXQRVE6Q2hOwFIfWlRKKJo63SmINrhs0cHa
	Ql1m2GXuMuO6VvyXydNL+UmNT9PnMcMDi50lfUZeyrSIfxXmjGgXFzTxen8v12GJSWFStjCUYiN
	OuYxLKc+gz1jRzxdj8UXJoB6XUm6XrE9scdXlJjTQox0yGjXB3cFty9xG8T+hWirEQEb29sHhwl
	ki0gUbWKxqadlbWbd7QMZBW2emWlmnSXpg356KOQpqGaF+zFKvY7/HKDweh0fkiboc+jT0yH5mQ
	X9stsjrBrsfI8yjkQ4Qwz6uYruzVvUE6l7dC2pDPxDyEwRzxLacvw7XlKtQBju5jtrEI2ceXzut
	Nm06RVpg3sb3yaIZDQL2ceF5aa7/7J+zPwXB21mWzawIL1xU+Y
X-Google-Smtp-Source: AGHT+IF+2CfReFeq8hvspaAgpVnWK4HktTpnrfb9z1IuPTDozQBneIgBBx+omJly5DQDoOr9RFkKyA==
X-Received: by 2002:a05:6a20:734d:b0:334:7e78:7030 with SMTP id adf61e73a8af0-364032d799cmr4983387637.8.1764876579753;
        Thu, 04 Dec 2025 11:29:39 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3b5a9sm2552926a12.9.2025.12.04.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:29:39 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH v4 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
Date: Fri, 05 Dec 2025 03:29:08 +0800
Message-Id: <20251205-swap-table-p2-v4-0-cb7e28a26a40@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXhMWkC/2XO0QrCIBTG8VcJrzPUM3V11XtEF07PmlBuzGHF2
 Ls3R1Cty+/A788ZScTeYySHzUh6TD76Nsyj2G6IbUy4IPVu3kQwITljmsa76ehgqivSTlDtgJU
 KpYXSkNl0Pdb+sfRO53k3Pg5t/1zyiefruyT2q1LilFFwBdRQKbQgjgMGi2HY2fZGciuJj+d8/
 UkS2WsNDBUa5eS/hy8v5NpD9lDLotZMG2l//TRNLxykUUEsAQAA
X-Change-ID: 20251007-swap-table-p2-7d3086e5c38a
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
 David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764876574; l=8814;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=i5RlmtxXCdWtwZB3hf9A8JL1M1/AKu+ssjIASvWZXBQ=;
 b=UJFtVp18Ijq5QeH5ZU3bL5PKApkxQYMRCCQifrUtxMCdnJ6K/xkLqRsVG/0SOgg4Yd5FjqVbT
 nCRZxdRnv1XANkY9Ea8KY5Apizf29tmEz2ByoebeLZoT3RerziEvVzw
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=

This series removes the SWP_SYNCHRONOUS_IO swap cache bypass swapin code and
special swap flag bits including SWAP_HAS_CACHE, along with many historical
issues. The performance is about ~20% better for some workloads, like
Redis with persistence. This also cleans up the code to prepare for
later phases, some patches are from a previously posted series.

Swap cache bypassing and swap synchronization in general had many
issues. Some are solved as workarounds, and some are still there [1]. To
resolve them in a clean way, one good solution is to always use swap
cache as the synchronization layer [2]. So we have to remove the swap
cache bypass swap-in path first. It wasn't very doable due to
performance issues, but now combined with the swap table, removing
the swap cache bypass path will instead improve the performance,
there is no reason to keep it.

Now we can rework the swap entry and cache synchronization following
the new design. Swap cache synchronization was heavily relying on
SWAP_HAS_CACHE, which is the cause of many issues. By dropping the usage
of special swap map bits and related workarounds, we get a cleaner code
base and prepare for merging the swap count into the swap table in the
next step.

And swap_map is now only used for swap count, so in the next phase,
swap_map can be merged into the swap table, which will clean up more
things and start to reduce the static memory usage. Removal of
swap_cgroup_ctrl is also doable, but needs to be done after we also
simplify the allocation of swapin folios: always use the new
swap_cache_alloc_folio helper so the accounting will also be managed by
the swap layer by then.

Test results:

Redis / Valkey bench:
=====================

Testing on a ARM64 VM 1.5G memory:
Server: valkey-server --maxmemory 2560M
Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get

        no persistence              with BGSAVE
Before: 460475.84 RPS               311591.19 RPS
After:  451943.34 RPS (-1.9%)       371379.06 RPS (+19.2%)

Testing on a x86_64 VM with 4G memory (system components takes about 2G):
Server:
Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get

        no persistence              with BGSAVE
Before: 306044.38 RPS               102745.88 RPS
After:  309645.44 RPS (+1.2%)       125313.28 RPS (+22.0%)

The performance is a lot better when persistence is applied. This should
apply to many other workloads that involve sharing memory and COW. A
slight performance drop was observed for the ARM64 Redis test: We are
still using swap_map to track the swap count, which is causing redundant
cache and CPU overhead and is not very performance-friendly for some
arches. This will be improved once we merge the swap map into the swap
table (as already demonstrated previously [3]).

vm-scabiity
===========
usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
simulated PMEM as swap), average result of 6 test run:

                           Before:         After:
System time:               282.22s         283.47s
Sum Throughput:            5677.35 MB/s    5688.78 MB/s
Single process Throughput: 176.41 MB/s     176.23 MB/s
Free latency:              518477.96 us    521488.06 us

Which is almost identical.

Build kernel test:
==================
Test using ZRAM as SWAP, make -j48, defconfig, on a x86_64 VM
with 4G RAM, under global pressure, avg of 32 test run:

                Before            After:
System time:    1379.91s          1364.22s (-0.11%)

Test using ZSWAP with NVME SWAP, make -j48, defconfig, on a x86_64 VM
with 4G RAM, under global pressure, avg of 32 test run:

                Before            After:
System time:    1822.52s          1803.33s (-0.11%)

Which is almost identical.

MySQL:
======
sysbench /usr/share/sysbench/oltp_read_only.lua --tables=16
--table-size=1000000 --threads=96 --time=600 (using ZRAM as SWAP, in a
512M memory cgroup, buffer pool set to 3G, 3 test run and 180s warm up).

Before: 318162.18 qps
After:  318512.01 qps (+0.01%)

In conclusion, the result is looking better or identical for most cases,
and it's especially better for workloads with swap count > 1 on SYNC_IO
devices, about ~20% gain in above test. Next phases will start to merge
swap count into swap table and reduce memory usage.

One more gain here is that we now have better support for THP swapin.
Previously, the THP swapin was bound with swap cache bypassing, which
only works for single-mapped folios. Removing the bypassing path also
enabled THP swapin for all folios. The THP swapin is still limited to
SYNC_IO devices, the limitation can be removed later.

This may cause more serious THP thrashing for certain workloads, but that's
not an issue caused by this series, it's a common THP issue we should resolve
separately.

Link: https://lore.kernel.org/linux-mm/CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/linux-mm/20240326185032.72159-1-ryncsn@gmail.com/ [2]
Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
Changes in v4:
Based on mm-unstalbe, basically same with V3, mostly comment update and more
sanity checks. Stress test and performance test is looking good and basically
same as before.
- Rebase on latest mm-unstable, should be also mergeable with mm-new.
- Update the shmem update commit message as suggested by, and reviewed
  by [ Baolin Wang ].
- Add a WARN_ON to catch more potential issue and update a few comments.
- Link to v3: https://lore.kernel.org/r/20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com

Changes in v3:
- Imporve and update comments [ Barry Song, YoungJun Park, Chris Li ]
- Simplify the changes of cluster_reclaim_range a bit, as YoungJun points
  out the change looked confusing.
- Fix a few typos I found during self review.
- Fix a few build error and warns.
- Link to v2: https://lore.kernel.org/r/20251117-swap-table-p2-v2-0-37730e6ea6d5@tencent.com

Changes in v2:
- Rebased on latest mm-new to resolve conflicts, also appliable to
  mm-unstable.
- Imporve comment, and commit messages in multiple commits, many thanks to
  [Barry Song, YoungJun Park, Yosry Ahmed ]
- Fix cluster usable check in allocator [ YoungJun Park]
- Improve cover letter [ Chris Li ]
- Collect Reviewed-by [ Yosry Ahmed ]
- Fix a few build warning and issues from build bot.
- Link to v1: https://lore.kernel.org/r/20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com

---
Kairui Song (18):
      mm, swap: rename __read_swap_cache_async to swap_cache_alloc_folio
      mm, swap: split swap cache preparation loop into a standalone helper
      mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
      mm, swap: always try to free swap cache for SWP_SYNCHRONOUS_IO devices
      mm, swap: simplify the code and reduce indention
      mm, swap: free the swap cache after folio is mapped
      mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO
      mm, swap: swap entry of a bad slot should not be considered as swapped out
      mm, swap: consolidate cluster reclaim and usability check
      mm, swap: split locked entry duplicating into a standalone helper
      mm, swap: use swap cache as the swap in synchronize layer
      mm, swap: remove workaround for unsynchronized swap map cache state
      mm, swap: cleanup swap entry management workflow
      mm, swap: add folio to swap cache directly on allocation
      mm, swap: check swap table directly for checking cache
      mm, swap: clean up and improve swap entries freeing
      mm, swap: drop the SWAP_HAS_CACHE flag
      mm, swap: remove no longer needed _swap_info_get

Nhat Pham (1):
      mm/shmem, swap: remove SWAP_MAP_SHMEM

 arch/s390/mm/gmap_helpers.c |   2 +-
 arch/s390/mm/pgtable.c      |   2 +-
 include/linux/swap.h        |  77 ++--
 kernel/power/swap.c         |  10 +-
 mm/madvise.c                |   2 +-
 mm/memory.c                 | 276 +++++++-------
 mm/rmap.c                   |   7 +-
 mm/shmem.c                  |  75 ++--
 mm/swap.h                   |  70 +++-
 mm/swap_state.c             | 338 +++++++++++------
 mm/swapfile.c               | 864 ++++++++++++++++++++------------------------
 mm/userfaultfd.c            |  10 +-
 mm/vmscan.c                 |   1 -
 mm/zswap.c                  |   4 +-
 14 files changed, 862 insertions(+), 876 deletions(-)
---
base-commit: 92440888882ad21791a07ff8809807ef1d2c2a42
change-id: 20251007-swap-table-p2-7d3086e5c38a

Best regards,
-- 
Kairui Song <kasong@tencent.com>



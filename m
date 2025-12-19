Return-Path: <linux-pm+bounces-39713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA810CD1AAE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 20:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7829C3017EF6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D3533B6F9;
	Fri, 19 Dec 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuvM261/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC82F069E
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173459; cv=none; b=OegxBJbB/tah0jbs1WnLHHCyvkIbw2UyXthp/IMl5zC9ggX08E99fl/lliBO0o5gcU4m/LOKwUs26r7+6WBNV2fMv4no9yNI7pL1tbDtozQYStOTJBDpvjKsrlikIDFuypkKP56SCAXtGFSDM27Nru/orZW3s8zPfr4UttsJ/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173459; c=relaxed/simple;
	bh=cY3UzxPPw7NiQLeyBv8mkIRNHqoSk87zp6LmiyiFzcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ivGz2Mw36osmrb/NCce+eXAkLfm0QhW6c76hrbmspAooHp+wHKKJ2uowuaR/DeVIbAv1wW9SSPwDx4gbk096NMLM0P1ySZC8VwjNr1PQQyW1Fi7HWfBqjVDyvLOELKSx8YkkZysaoQj8wxEdcRPmU6FDkA7qEHGbMEft3TrOOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuvM261/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d0788adaso19329465ad.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 11:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766173457; x=1766778257; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKITxhWaTrx7T/+fL+zdtXl3HxN4mbsgucwgGMOva20=;
        b=HuvM261/6l/f+ljnAhWRRKL2m7QkxID2cnVelaLrEVMiUkH9QL5NrQuMGaG+/if8N6
         PaRs8xyT8RzitkPwEDMGY2AQbarSxTHPQ5Vl5nRLfon7CHVyp+LL1glrdx+HoDzI2f0j
         JzMh+XLPa2BOoRnG6oavvT6Pv7hJDdZrFxsrMeMcXPX7L0p4YxngoGxD1bGXR+J2TdvX
         sXqZv2zOGsJBXLDQCMjg1GQc/9EKrQ9zC6XqEXAQLnLCqQceXGOvKhlwvR42etSlUInk
         qo0j7TmTZUdP+ihKts+ttcH/fkR8o+od7S+t1/TLBIcnApHcMRkTqYf4RWsH3yl5W4QG
         2FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766173457; x=1766778257;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKITxhWaTrx7T/+fL+zdtXl3HxN4mbsgucwgGMOva20=;
        b=ltzOjpMSpnfE50zkujb+HpNkBz7AQprkTLnSvk8bV/d4My+7mnHIif+xUa3V0Lm+tf
         xk30kD6fV5mAMbECqc4JrOi+LnCfO1kN4hKcdfR7hLhyT2cRbSQDXIe2GSDsCCfT2CcG
         jiI4f6SZn4CVGiORIZ2HWd1FDU3mnBTKAu7pdLtYK7yVHgITFSbto6AYPxjxKKEjdzf9
         f1vw4Rg7PyeAqFb/mzWRLFprdb+2YQmA/BH8buPr7yOrTYlP0arGULhuQBctpySBvR4A
         5K3T3hjaO7mO+BigbF2XuzJlqTrcY2Zen18+4dbhOOk/zDEiR4wnKuFP/BLktp1UThUd
         2Fag==
X-Forwarded-Encrypted: i=1; AJvYcCVS+VmMqRuxq2nSUQOZ+i2NXaTkWWjuPLpeqmRWyd+PMHfSgAW411GPlHknKYV+D3363mCsQ0JHwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkspoPY7s+L91kojNbPSkzF76fnh6hVtfULoG6aPQiJHoRhab
	4Jp1Eu86k0/xe/GlqaihL+S+tCMgefiiLkM4YKTxImWDp8l3aqLVZBWD
X-Gm-Gg: AY/fxX5mwJzTpT+QhT+PPR5e4LX/WcTsJd4Uy7pOKDnj5pO2At+8oBigujvKArV6Y+R
	3TJK6CAivO59O4DRv1zHgctuBTSrEBhohViTYLQwJxpO2tC/Vvx/P12HBsUX2KC+3akX6Y98GSo
	tqHyLbAQQWFYwjf4qpwUIfPIq6bKFl1rtTumTg74PZROiFjIJG8vTK0pSXT6RYlXaXkTj863INu
	MmwvS3XTLh3eGdfQcQUKLoeH6wWQgjwnNQaMPq/rdjTpUAoT9L4ohmEPLR0GcFeY6wHseAYtcSe
	6LUx68Og17GY1Kya5NyAR7ngunQQqGdhZ/FIyGG3udu/ubNDDDOQFYsVOqR5FX9AQVK7f5y0FwK
	5PHgC+hFHvUdvzi4ORh2Fkdo7TFtYHLzKXyCFBhr0RyfwEl7ebxK6n9ZLPQaQ1qHPEooVsg0KNd
	vPahqjlQfiI8POiAGemgZXbCSSVjL0KGpxzRjSKa1UEnz7YQlG5bJe
X-Google-Smtp-Source: AGHT+IHfRtNT6VJT777zC29z6v+bOEkHUvfWHIfyAb14Z2bqgbzG5Ai69rkUcZuip31K3YZEyvlWgA==
X-Received: by 2002:a17:903:32cd:b0:2a0:be7b:1c50 with SMTP id d9443c01a7336-2a2f222b551mr36501175ad.14.1766173456883;
        Fri, 19 Dec 2025 11:44:16 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ceesm30170985ad.91.2025.12.19.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 11:44:16 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH v5 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
Date: Sat, 20 Dec 2025 03:43:29 +0800
Message-Id: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOTWrDMBCG4asEraMymtGPk1XvUbqQ5XEiaG1jG
 SUl+O6RQyCNvfwGnpe5icRj5CSOu5sYOccU+64Ms9+JcPbdiWVsyhYIaBSAk+niBzn5+oflgNI
 1BJVlE6jyophh5DZeH72v77LPMU39+PfIZ7VcnyU8rEpZSZDUaGqpthwIPyfuAnfTR+h/xdLK+
 PJKrT/JuHjnCNiyt43Zevrn0aw9LZ5ao1sHzpuw9frlETZeFx9qx1h5tF7Du5/n+Q4h4zaRbAE
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766173451; l=9183;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=cY3UzxPPw7NiQLeyBv8mkIRNHqoSk87zp6LmiyiFzcs=;
 b=MJBUgHScWWRicL5h6ZgvSsCmbA6ekauJ+P/+euDmnrkf9NSxRWwTw5/wuOekhTrzcWnIC2HXJ
 XU+1X7pmP7vCiChaJtHzAkR5Lij/Kgl7PZrftGdt5TIuwUzalOqXbFA
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
Changes in v5:
Rebased on top of current mm-unstalbe, also appliable on mm-new.
- Solve trivial conlicts with 6.19 rc1 for easier reviewing.
- Don't change the argument for swap_entry_swapped [ Baoquan He ].
- Update commit message and comment [ Baoquan He ].
- Add a WARN in swap_dup_entries to catch potential swap count
  overflow. No error was ever observed for this but the check existed
  before, so just keep it to be very careful.
- Link to v4: https://lore.kernel.org/r/20251205-swap-table-p2-v4-0-cb7e28a26a40@tencent.com

Changes in v4:
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
 include/linux/swap.h        |  71 ++--
 kernel/power/swap.c         |  10 +-
 mm/madvise.c                |   2 +-
 mm/memory.c                 | 276 +++++++-------
 mm/rmap.c                   |   7 +-
 mm/shmem.c                  |  75 ++--
 mm/swap.h                   |  70 +++-
 mm/swap_state.c             | 338 +++++++++++------
 mm/swapfile.c               | 861 ++++++++++++++++++++------------------------
 mm/userfaultfd.c            |  10 +-
 mm/vmscan.c                 |   1 -
 mm/zswap.c                  |   4 +-
 14 files changed, 858 insertions(+), 871 deletions(-)
---
base-commit: dc9f44261a74a4db5fe8ed570fc8b3edc53a28a2
change-id: 20251007-swap-table-p2-7d3086e5c38a

Best regards,
-- 
Kairui Song <kasong@tencent.com>



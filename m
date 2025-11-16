Return-Path: <linux-pm+bounces-38099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB661C61A26
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 19:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 725724E15F5
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E330F7E3;
	Sun, 16 Nov 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq7fYfXq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646E30C63A
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763316721; cv=none; b=op2t+2XVy8R2kzlqXfp8JCENiiyWwCsidFyM6RIXfdRbv9BtKAMAwoXTgaDQeqbYytyw7ve/8m0C8qozh9h3xgJqcnv/Zyb1q4FD+ulNUz2G8XG9wOhNbGQDc3yTG9JzHfFURdrZaNY7G5q/vUwS7cYwXKlWIJ/kGmyNOFmd8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763316721; c=relaxed/simple;
	bh=/P/YM4pb1/fXFf2POywLNCj1z51ehE/HU6r87l47Vdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s+1RkAAYSd2uqorJ6sUrPuPEUJy5Us2X+18t4V6SyxWxV1kJmozyNDZE5IHSdYvaRGIqu1vFCZHM/Wru7nLgSRcNBYmrmnGhxl+7IVm47sCUE421xqbfthwuvCYcVEw7o/WANvlua+N34qn4JTxZLi85QVqv10J7zcfIX7YnWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq7fYfXq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1b8264c86so371758085a.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763316719; x=1763921519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1CPaZeVUTN1AsZnR00JSBG/VHBNQ1hRxT7ANjmtaSo=;
        b=aq7fYfXqZbxNJaRzRekt8t/IK+hXpLw8SYqD2Qx0DHBvbK9VZc7jqcBDWUOz9X4KmL
         vr2poIaKnK6GtbEENJLffyAruU6dwn2HEmCuTdkcUluEEOIrmNEtGf89PT89uFe2Jbui
         6ZkdnfFCLvmLjpxwx9eOTgOHozBCXuFQQzZbEPR9mED5dlNQIvWP75oaUB8ZvssE62+2
         686AitksJRpO1oiYAKEMF/es9ECxfACgmibnULvSzlqG/qM1u5w8FBNDDM51XUDtC/Sj
         ckp5YI86+ZIAv5N0DAi6Q+dHFIVm/pB63teAfgf/KlYBu2SYtwLjDOweqCUTiGz74SDt
         c3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763316719; x=1763921519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1CPaZeVUTN1AsZnR00JSBG/VHBNQ1hRxT7ANjmtaSo=;
        b=azrL0sPA+FKiZShJKZ5JkvJp/SGT6nrBD97AEdh+3ABsZQb1PZjfAUsdFra7wVjR1h
         ai/EM8oPL4HLhw7z5xzrc6Crh+Sq8ns75qWEpwSjb28x270ogFISVBr5d5U31DZPFmNZ
         Fn+MmLivSuAUGNUBiKeg5jtUt8I5w7lnBxQUVcbmUEL2qcV8L8UcBNOpZeutYhXBn539
         2n2ceS2keZYAygGogUQfnfC606ENRWyc9cQ0A1hwz3XILGijRUS8Q/zOqCf3yWWI2DDr
         XOCktzUr961YkfA/JQiINRjy8ZMPvV6jnMKj0TKJUuyjxe9hQV+KzSQE9b/CtTUDdS5m
         3wjw==
X-Forwarded-Encrypted: i=1; AJvYcCVCP1tJR9ADF6iA7FBiuARMRflQdySFXf47Oc04s06pqoMFM0IZKv4M/fBO7D9x8PFij2tBiF2fRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEnJBnU8QXEB6hayp7mhKQHiRO8T9Qk15plpkwSEXY/AQw93Q
	AP6+nUGv38p+s8IJGv4viZypraXqNqvNPXGp/cSRGVUTFBV1qch10XU6
X-Gm-Gg: ASbGncvK3voUxDJ1EDl9RxdYa3xP6MxgZ+a6XYyCOVK2m2zb7+N34SJvf5SU5Av3cJg
	8lsUQUBrdCcDgtSjsD4HqdFmbCE7UHGHNELh0VWR5C6TplGJC24gTAISRoxl+J3Yy5k9R3AsD3j
	bqfypiHppM757WzMAcPWN5TCC17EIfOIFRLez94pfiClLT0OvcXybSb2xhd50Ou7DLeJeeMYPfs
	RfzqE0OE31sGdGxBdL8ubcoJQ5FstCqhXg3cqldjcc07Lp/eV2CuUJn3P+NvBvCTas0ebc2fRrq
	BDG+aAw4p3MQybH444pGTaxaK+57/EmWExmiXfujJU7aN5T8/IgZb+OGLkrTtqhefY6RjqmDbk5
	yhiScXpeQUCp6rzPsw1e7/ugtwJWM7dW67DFvTzFrEPD+PRiP4WAepus2WV30S37wzbLNIrV4KB
	MUz9KtmlufMlpcgDtkrwAwQ8o0SeixehseyUO+HhzM+lvCkeOr6G5V
X-Google-Smtp-Source: AGHT+IFE331CKiWxmYYylcJloJxeMZ2BiIyLX4dcrWxJho80PQ4NjjTu1iK8PcHMhdj8/5V0s+WO1Q==
X-Received: by 2002:a05:620a:400c:b0:89e:b3a0:bce9 with SMTP id af79cd13be357-8b2c315d2e4mr1337782085a.22.1763316718811;
        Sun, 16 Nov 2025 10:11:58 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2e089b436sm305447785a.45.2025.11.16.10.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 10:11:58 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH v2 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
Date: Mon, 17 Nov 2025 02:11:41 +0800
Message-Id: <20251117-swap-table-p2-v2-0-37730e6ea6d5@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0TGmkC/13Myw6CMBCF4Vchs3ZMaeUiK9/DsChlkEm0bdoGN
 YR3txJXLv+TnG+FSIEpQlesEGjhyM7mkIcCzKztjZDH3CCFrEohGoxP7THp4U7oJTajEm1NlVG
 thvzxgSZ+7d61zz1zTC68d34pv+tPkuc/aSlRoBpPalJDTUbJSyJryKajcQ/ot237AD4WwOysA
 AAA
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
 linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763316712; l=7592;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=/P/YM4pb1/fXFf2POywLNCj1z51ehE/HU6r87l47Vdw=;
 b=EUaXCzADQCSzNT8+jGIQ3f0BDmf422WLWvvUiMFAD/rDhinkZoSugxzI7X6PaRoxbhZssy2A0
 jhMadHnaNn5DO/TTGq1sMJhahSMsNPTkABUeo+AI0NZVwB4ZGEMw8KP
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
Series is almost identical to V1, mostly comment update and build fix, and
rebase to resolve conflicts and for easier review. Stress test and
performance test is looking good and basically same as before.

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
      mm, swap: consolidate cluster reclaim and check logic
      mm, swap: split locked entry duplicating into a standalone helper
      mm, swap: use swap cache as the swap in synchronize layer
      mm, swap: remove workaround for unsynchronized swap map cache state
      mm, swap: sanitize swap entry management workflow
      mm, swap: add folio to swap cache directly on allocation
      mm, swap: check swap table directly for checking cache
      mm, swap: clean up and improve swap entries freeing
      mm, swap: drop the SWAP_HAS_CACHE flag
      mm, swap: remove no longer needed _swap_info_get

Nhat Pham (1):
      mm/shmem, swap: remove SWAP_MAP_SHMEM

 arch/s390/mm/pgtable.c |   2 +-
 include/linux/swap.h   |  77 ++---
 kernel/power/swap.c    |  10 +-
 mm/madvise.c           |   2 +-
 mm/memory.c            | 275 ++++++++--------
 mm/rmap.c              |   7 +-
 mm/shmem.c             |  75 ++---
 mm/swap.h              |  70 +++-
 mm/swap_state.c        | 340 +++++++++++++-------
 mm/swapfile.c          | 848 +++++++++++++++++++++----------------------------
 mm/userfaultfd.c       |  10 +-
 mm/vmscan.c            |   1 -
 mm/zswap.c             |   4 +-
 13 files changed, 842 insertions(+), 879 deletions(-)
---
base-commit: 41218ede767f6b218185af65ce919d0cade75f6b
change-id: 20251007-swap-table-p2-7d3086e5c38a

Best regards,
-- 
Kairui Song <kasong@tencent.com>



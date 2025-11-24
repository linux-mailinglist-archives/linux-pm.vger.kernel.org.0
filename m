Return-Path: <linux-pm+bounces-38500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB2C82411
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCEA3ABF90
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E432D3A89;
	Mon, 24 Nov 2025 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5VJ6qDr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B12BDC28
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011739; cv=none; b=e0gp9oXjO7CG6joDFqMcZhNscJVE5WgJRmynHrlhR5T6DNIjrOCWi+vMSrcxy2bg+bGnCP8K/vOfQXTyxyKHaQHBeo0SuC7eTUbMYfvXw1fD7jNBssuZ/m7wVThZm3PYvQwG5+yGyjRkc9/jHIkDvyyqILK8Dc1ri8tyU0hGLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011739; c=relaxed/simple;
	bh=LWzQxbJRHW9VzB3LA2yzkorXpnWIvle6zmjZ3exFdgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WZ2jlVCZSA9E0QDiqmGoEEFIEgj7lMscNAujSB1yFiFMDDaa/kGWCAF4dJ07cf06Mk38jPVfHaf0EVjk8w25tMsupZFWyMp+KzEIpHS+uJErKmuE8gPIvkIAr8/W02y/rPHZEkxdu4tvBzeFy1nMPr8WmWh2YKYYPYx2RpdBjew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5VJ6qDr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso1305530b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764011737; x=1764616537; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uy/STkXZTXYrgITBtAfR5xJYldXIjH3PYEDKzxRY+ak=;
        b=N5VJ6qDr6FqQXhcJPLuerUu9mXQEbnnLkg2c1RcQt84RCuUmYHlRKhyqPtBL6QVJ41
         tWx+LrcxhL6OcaJ4jzoHQC7YcOCu/4l1RG0COxtqwN7hCy/IescrHsb+iPHiutNeJw4t
         Bt/NiucoEHASRN/Ejntpm13/0e+NsFsLAdbzaimO8mVLjTL3VQnpKc1n9rKivBpfK0K6
         rLJlHJ7QV47ZIb2SEEJIvLtYqaUg4EintV3pWXjIsf+EX4USETnHWxUOoNTRxzRIrOf+
         nfNe8TenZdmoigl/mSspHohHoeO0nrQ8n+p3eIExGEPwl9v23vb09XDsfwaNgyVT+5Q5
         Fq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764011737; x=1764616537;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy/STkXZTXYrgITBtAfR5xJYldXIjH3PYEDKzxRY+ak=;
        b=TimKEvp1zPbUO8WTYMFgHF6ksKusNh++jBJJ/zmK/iMkaFPLqY2bSR9FErv0kVttmP
         bdBNrBoT49HzyWK9bdCRUgmpPW+ouvG6M20CY29QGQFURmZybeh8uZuV4s0AvIrW5Kjm
         7UHtUbXrjNqDN4NFpp4MLdizQnbrfOE0vkwtQD1SBtoSr+95N+xPKtimParMDRhV0Ms1
         iVm+dFhlVJ4dx9EWEkJcv6Gq2a6Om/QauHfY6GoQFqX67sN7+UwrZf143olp9MlCMap+
         jQ37UprhGW8l1joGVvxLpUITNOfp2tYqOCUyCYd45m8CnFRJmeosvy53OS1ECw92ruL0
         nW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLM9Qvv4JZrRPCgj1IRjlGMpqlMUUtCLT7oy5Ly6E+7Z3rQy0Hz1GK5MW4W+8By7wu3K2pPSJJnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Qr42qfm0S/gCerOqFETUPPmLwk6VdZohBMbyGdW7nYbq/sOY
	RyaI+SXG/JXwVytdXm2BFZyEPu72JgMFdsdFNi+YpmYDDY6ZLcLYEy/B
X-Gm-Gg: ASbGncsq8yBErRtww7JVuEi10DhMrzJDuL7pmGVbpMVZk20X7wT9A46NIKet/2PujN9
	eWUDNGXcp7fkY1KgJmkjnCHlw7JD0a/J0LIu3iEo7PwIUPnHfC971Ov8vlMah9MeSGaYx+6BhhD
	233B515upn1wo9MtfHsPau3ajVwsnrK3DMSL9AFq0qBEeosc0kIz3lf9yBfHiqfG0FwDNKif9RR
	AYqrZ94X3e5l0jbkpsURDiOMHi66W0V6aNyhRPEl5+LOaNdFWn5wy0lIbAgy5tObaYIdTogJ4OE
	BXra/sKEsSoNL1ZykNFGqmxj/bzH8ywotzo5ah1VUDgkBQeb7q040djsLVIQsII0vbQGgGG5KV7
	iN0nRMd1FMPzjeIGx912U0skb7GqBiFE/C4uAVBFxj18ZGiLj7qmDtR82obbCa6y3O8E5TACMBO
	SAQLArsnV9m19VsmZV+KFg0xnJhnkgasvQ3sZ9tTA6kj1+sg3L
X-Google-Smtp-Source: AGHT+IHHR8gcm+u2rBmlqVse0ZQqmv1UWqForZAjRLZFPPF9ISEnQhFvT2RBfI2CGnz60va2DVmIKA==
X-Received: by 2002:a05:6a20:2449:b0:35e:521b:f4a1 with SMTP id adf61e73a8af0-3613e5b2d93mr19447853637.30.1764011736345;
        Mon, 24 Nov 2025 11:15:36 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def75ffsm14327479a12.3.2025.11.24.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 11:15:34 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH v3 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
Date: Tue, 25 Nov 2025 03:13:43 +0800
Message-Id: <20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGiuJGkC/12O0QrCIBhGX2V4naH+TVdXvUd04fRfE8oNFSvG3
 j03gmiX54Nz+CYSMTiM5FRNJGB20Q2+AOwqYnrtb0idLUwEEzVnTNH41CNNur0jHQVVFlgjsTb
 QaFKcMWDnXmvvci3cu5iG8F7zmS/rtySOm1LmlFGwB+iglWhAnBN6gz7tzfAgSyuLn8/59kkWi
 68UMJSopa3//XmeP5/uUqnsAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764011730; l=8506;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=LWzQxbJRHW9VzB3LA2yzkorXpnWIvle6zmjZ3exFdgE=;
 b=+vRqLhaIXKmp1dQ/q7JNPlANEo8bJ6W/OF4vvI0SDr2ApA4J2CtvLO3yovd2OeoppwsfYWpUU
 dfPjL69KIrgCX2AKaRO1q2080UsdYEjJHOy2fzz3GDVObqgmHUj1SNp
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
Still basically same with V2, mostly comment update and build fix, and
rebase to resolve conflicts and for easier review and testing. Stress test and
performance test is looking good and basically same as before.

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
 mm/swapfile.c               | 856 +++++++++++++++++++-------------------------
 mm/userfaultfd.c            |  10 +-
 mm/vmscan.c                 |   1 -
 mm/zswap.c                  |   4 +-
 14 files changed, 854 insertions(+), 876 deletions(-)
---
base-commit: 1fa8c5771a65fc5a56f6e39825561cdc8fa91e14
change-id: 20251007-swap-table-p2-7d3086e5c38a

Best regards,
-- 
Kairui Song <kasong@tencent.com>



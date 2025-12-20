Return-Path: <linux-pm+bounces-39723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F8CD2EBB
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 13:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDA630181A0
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F4F273D66;
	Sat, 20 Dec 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWC/IeX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8917B50A
	for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766234099; cv=none; b=V5qDGV6t8ypTeKrwc3NioSz9iasWl48Wew5+BJbu9nugnWtLUJXfEBrLN/O/+u9GZilIx8cFz0w5yN6pIxQ+gWAnH4ac7iFJRRTiO8QG881Y/g4GqtBG+pmcsfzzk1NB5ii/1jxMK7H8YOYv4wIl2ra/8SXr5DhMhlbPMIPrk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766234099; c=relaxed/simple;
	bh=HxcbYaDU2NCzMhsYOgAY99lFkJhGLXoRGHYhBoNgDLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHF/Df7KIlOT9K8LY+b3VY7Sed82oI13aHsNIQePMXaxqWXE3vInSSe9HB7zEfpBmLIhDYmknmu7TQiyajH/6WlwqgCsS+7V0DDqb3AK3iKXCuqgwYlOEp46lVgieo3Somx8IXJSCoG+Xck7FCl0eclV3N8ODCLHIsBGLUQMDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWC/IeX8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766234096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1HzDltyBKjzeygGtrpa51qJUu6D5dQuY0xY8PUvjRA=;
	b=QWC/IeX8LDnmkHebrH/SRxKr6x6GT3Y62IQ1o3CPRwakIUMYsn2zooEFUf2/n3BDMcR5mL
	aJIdpzVJ/x2KQ4vHM4Huj6D5eAJGqb3e7EjT+WMkQIY4gv9C/T0HoVDBoqRps2FEvxQ9ID
	LBpNfuD94OcrD+FMBtINnB3FRp9/6lE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-Irr-uDjTPjeJRvhM-fb6dg-1; Sat,
 20 Dec 2025 07:34:51 -0500
X-MC-Unique: Irr-uDjTPjeJRvhM-fb6dg-1
X-Mimecast-MFC-AGG-ID: Irr-uDjTPjeJRvhM-fb6dg_1766234088
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55583195DE48;
	Sat, 20 Dec 2025 12:34:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 191D030001A2;
	Sat, 20 Dec 2025 12:34:43 +0000 (UTC)
Date: Sat, 20 Dec 2025 20:34:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: Re: [PATCH v5 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
Message-ID: <aUaX3mypyTXXM07x@MiWiFi-R3L-srv>
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/20/25 at 03:43am, Kairui Song wrote:
> This series removes the SWP_SYNCHRONOUS_IO swap cache bypass swapin code and
> special swap flag bits including SWAP_HAS_CACHE, along with many historical
> issues. The performance is about ~20% better for some workloads, like
> Redis with persistence. This also cleans up the code to prepare for
> later phases, some patches are from a previously posted series.

Thanks for the great effort on the swap table phase II redesign, optimization
and improvement. I am done with the whole patchset reviewing, with my
limited knowledge, I didn't see some major issues, just rased several
minor concerns. All in all, the whole patchset looks good to me.

It's not easy to check patch by patch in this big patch series, especially
some patches are involving a lot of changes, and some change could be related
to later patch. I think it's worth being put in next or mergd for more testing.
Looking forward to seeing the phase III patchset.

FWIW, for the whole series,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Swap cache bypassing and swap synchronization in general had many
> issues. Some are solved as workarounds, and some are still there [1]. To
> resolve them in a clean way, one good solution is to always use swap
> cache as the synchronization layer [2]. So we have to remove the swap
> cache bypass swap-in path first. It wasn't very doable due to
> performance issues, but now combined with the swap table, removing
> the swap cache bypass path will instead improve the performance,
> there is no reason to keep it.
> 
> Now we can rework the swap entry and cache synchronization following
> the new design. Swap cache synchronization was heavily relying on
> SWAP_HAS_CACHE, which is the cause of many issues. By dropping the usage
> of special swap map bits and related workarounds, we get a cleaner code
> base and prepare for merging the swap count into the swap table in the
> next step.
> 
> And swap_map is now only used for swap count, so in the next phase,
> swap_map can be merged into the swap table, which will clean up more
> things and start to reduce the static memory usage. Removal of
> swap_cgroup_ctrl is also doable, but needs to be done after we also
> simplify the allocation of swapin folios: always use the new
> swap_cache_alloc_folio helper so the accounting will also be managed by
> the swap layer by then.
> 
> Test results:
> 
> Redis / Valkey bench:
> =====================
> 
> Testing on a ARM64 VM 1.5G memory:
> Server: valkey-server --maxmemory 2560M
> Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get
> 
>         no persistence              with BGSAVE
> Before: 460475.84 RPS               311591.19 RPS
> After:  451943.34 RPS (-1.9%)       371379.06 RPS (+19.2%)
> 
> Testing on a x86_64 VM with 4G memory (system components takes about 2G):
> Server:
> Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get
> 
>         no persistence              with BGSAVE
> Before: 306044.38 RPS               102745.88 RPS
> After:  309645.44 RPS (+1.2%)       125313.28 RPS (+22.0%)
> 
> The performance is a lot better when persistence is applied. This should
> apply to many other workloads that involve sharing memory and COW. A
> slight performance drop was observed for the ARM64 Redis test: We are
> still using swap_map to track the swap count, which is causing redundant
> cache and CPU overhead and is not very performance-friendly for some
> arches. This will be improved once we merge the swap map into the swap
> table (as already demonstrated previously [3]).
> 
> vm-scabiity
> ===========
> usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
> simulated PMEM as swap), average result of 6 test run:
> 
>                            Before:         After:
> System time:               282.22s         283.47s
> Sum Throughput:            5677.35 MB/s    5688.78 MB/s
> Single process Throughput: 176.41 MB/s     176.23 MB/s
> Free latency:              518477.96 us    521488.06 us
> 
> Which is almost identical.
> 
> Build kernel test:
> ==================
> Test using ZRAM as SWAP, make -j48, defconfig, on a x86_64 VM
> with 4G RAM, under global pressure, avg of 32 test run:
> 
>                 Before            After:
> System time:    1379.91s          1364.22s (-0.11%)
> 
> Test using ZSWAP with NVME SWAP, make -j48, defconfig, on a x86_64 VM
> with 4G RAM, under global pressure, avg of 32 test run:
> 
>                 Before            After:
> System time:    1822.52s          1803.33s (-0.11%)
> 
> Which is almost identical.
> 
> MySQL:
> ======
> sysbench /usr/share/sysbench/oltp_read_only.lua --tables=16
> --table-size=1000000 --threads=96 --time=600 (using ZRAM as SWAP, in a
> 512M memory cgroup, buffer pool set to 3G, 3 test run and 180s warm up).
> 
> Before: 318162.18 qps
> After:  318512.01 qps (+0.01%)
> 
> In conclusion, the result is looking better or identical for most cases,
> and it's especially better for workloads with swap count > 1 on SYNC_IO
> devices, about ~20% gain in above test. Next phases will start to merge
> swap count into swap table and reduce memory usage.
> 
> One more gain here is that we now have better support for THP swapin.
> Previously, the THP swapin was bound with swap cache bypassing, which
> only works for single-mapped folios. Removing the bypassing path also
> enabled THP swapin for all folios. The THP swapin is still limited to
> SYNC_IO devices, the limitation can be removed later.
> 
> This may cause more serious THP thrashing for certain workloads, but that's
> not an issue caused by this series, it's a common THP issue we should resolve
> separately.
> 
> Link: https://lore.kernel.org/linux-mm/CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/linux-mm/20240326185032.72159-1-ryncsn@gmail.com/ [2]
> Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]
> 
> Suggested-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Changes in v5:
> Rebased on top of current mm-unstalbe, also appliable on mm-new.
> - Solve trivial conlicts with 6.19 rc1 for easier reviewing.
> - Don't change the argument for swap_entry_swapped [ Baoquan He ].
> - Update commit message and comment [ Baoquan He ].
> - Add a WARN in swap_dup_entries to catch potential swap count
>   overflow. No error was ever observed for this but the check existed
>   before, so just keep it to be very careful.
> - Link to v4: https://lore.kernel.org/r/20251205-swap-table-p2-v4-0-cb7e28a26a40@tencent.com
> 
> Changes in v4:
> - Rebase on latest mm-unstable, should be also mergeable with mm-new.
> - Update the shmem update commit message as suggested by, and reviewed
>   by [ Baolin Wang ].
> - Add a WARN_ON to catch more potential issue and update a few comments.
> - Link to v3: https://lore.kernel.org/r/20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com
> 
> Changes in v3:
> - Imporve and update comments [ Barry Song, YoungJun Park, Chris Li ]
> - Simplify the changes of cluster_reclaim_range a bit, as YoungJun points
>   out the change looked confusing.
> - Fix a few typos I found during self review.
> - Fix a few build error and warns.
> - Link to v2: https://lore.kernel.org/r/20251117-swap-table-p2-v2-0-37730e6ea6d5@tencent.com
> 
> Changes in v2:
> - Rebased on latest mm-new to resolve conflicts, also appliable to
>   mm-unstable.
> - Imporve comment, and commit messages in multiple commits, many thanks to
>   [Barry Song, YoungJun Park, Yosry Ahmed ]
> - Fix cluster usable check in allocator [ YoungJun Park]
> - Improve cover letter [ Chris Li ]
> - Collect Reviewed-by [ Yosry Ahmed ]
> - Fix a few build warning and issues from build bot.
> - Link to v1: https://lore.kernel.org/r/20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com
> 
> ---
> Kairui Song (18):
>       mm, swap: rename __read_swap_cache_async to swap_cache_alloc_folio
>       mm, swap: split swap cache preparation loop into a standalone helper
>       mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
>       mm, swap: always try to free swap cache for SWP_SYNCHRONOUS_IO devices
>       mm, swap: simplify the code and reduce indention
>       mm, swap: free the swap cache after folio is mapped
>       mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO
>       mm, swap: swap entry of a bad slot should not be considered as swapped out
>       mm, swap: consolidate cluster reclaim and usability check
>       mm, swap: split locked entry duplicating into a standalone helper
>       mm, swap: use swap cache as the swap in synchronize layer
>       mm, swap: remove workaround for unsynchronized swap map cache state
>       mm, swap: cleanup swap entry management workflow
>       mm, swap: add folio to swap cache directly on allocation
>       mm, swap: check swap table directly for checking cache
>       mm, swap: clean up and improve swap entries freeing
>       mm, swap: drop the SWAP_HAS_CACHE flag
>       mm, swap: remove no longer needed _swap_info_get
> 
> Nhat Pham (1):
>       mm/shmem, swap: remove SWAP_MAP_SHMEM
> 
>  arch/s390/mm/gmap_helpers.c |   2 +-
>  arch/s390/mm/pgtable.c      |   2 +-
>  include/linux/swap.h        |  71 ++--
>  kernel/power/swap.c         |  10 +-
>  mm/madvise.c                |   2 +-
>  mm/memory.c                 | 276 +++++++-------
>  mm/rmap.c                   |   7 +-
>  mm/shmem.c                  |  75 ++--
>  mm/swap.h                   |  70 +++-
>  mm/swap_state.c             | 338 +++++++++++------
>  mm/swapfile.c               | 861 ++++++++++++++++++++------------------------
>  mm/userfaultfd.c            |  10 +-
>  mm/vmscan.c                 |   1 -
>  mm/zswap.c                  |   4 +-
>  14 files changed, 858 insertions(+), 871 deletions(-)
> ---
> base-commit: dc9f44261a74a4db5fe8ed570fc8b3edc53a28a2
> change-id: 20251007-swap-table-p2-7d3086e5c38a
> 
> Best regards,
> -- 
> Kairui Song <kasong@tencent.com>
> 



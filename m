Return-Path: <linux-pm+bounces-38919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2C3C94576
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A42164E0415
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9823D7FF;
	Sat, 29 Nov 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoUUFewG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAA23AB8D
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436072; cv=none; b=E64PgMIkkawVk9tV9lwsDlKv2+3GaT9kolMCiFgEdpEXbE8NU1YcagtntOnoMKUDZ7JgHw4Hj8lhyEuwwfR8bkN9YIUIhTDIGj61QnCx6eW/EzRUDdDnXxYvponGQloajSlT4CRIscp/w3K1tZYJs2XCme5jLvuwMTj98mZM1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436072; c=relaxed/simple;
	bh=aEi3fUeihkx7Xs7jMI1NkgKX1nDZ4HrkE6CG0v5DbFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMPvFqmUMUa1aG/u56kgoKyQAUOzFwcRSTaaxzO5KJYiAR3rf6nVFea+8qNTWZqGEREEqNPNabhXQN4VEFSwy662wbvkoIY0WWRmFiw9RYeKu3qXBKXw6GFCpWrPHv2LNPcj9o5zqQpVYN/P+9m34Fe+YA/9hBCryDYpnsnMTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoUUFewG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF38C2BC86
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764436072;
	bh=aEi3fUeihkx7Xs7jMI1NkgKX1nDZ4HrkE6CG0v5DbFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PoUUFewGdGpVbfMyV7x/XSqVZCIL7hqh56LUb41NOntsEbxLWIJjBFh1MN5SvMfJN
	 2b1OJMYeQstPtLtkEhrF7Ijb+9s8qFIxWZ/sMr93A+CEImgcSxQb4+iQmCQ65O30JW
	 zGsBwsN9X05x+qPGqSxDWKNXdDtb2WfXub3HS4hwv+s2tiiklNApSk/gOQB7moPFR3
	 PdVGo4YxRds2P89tWZh3PKVHh38DnzTUY7+4Xs8PXO5/V1IeHO44y0SfqIVN/fsVTz
	 3xa17bq2k6JqLz1wREAVDjZbvKFszNaV4cfkEN3HAR0+2GIniI2POS/Tqa9Hp3HB/w
	 n3SSktgQKJ52w==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-786943affbaso18714947b3.0
        for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 09:07:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgNU9Tcyyfl3DbJMj7P1CCqvXu/8Q8EdFmxBqoKShzfkSm88aIWWRH7JxE0zT/LYwkLjPz18aofA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwInQ1qgYO1GE59828FMddJXvDPXSleJnn0PZx30cWOxsuVOLYW
	6wErQtYZ+0WAfxx2T0q1fyNyYW/HbxWhDZOrad7AuEqHGjYjgV4fxCLorsrEpA7JoxpoL/Q9f8n
	Aa6MoQBH4cpy/MBEtf5YCswzW3ysmA8Pf9n2cEs9b7Q==
X-Google-Smtp-Source: AGHT+IGoLbSxanxq+rFI3LIH/mqm9+e3tjcYNJ/ehzOR5pFY7jyX7qnhO//KzRpv3gftUKmEKG6CYc+E+Sr/fomqbUo=
X-Received: by 2002:a05:690c:7249:b0:788:1eae:3d7f with SMTP id
 00721157ae682-78ab6fe526dmr171463927b3.70.1764436071502; Sat, 29 Nov 2025
 09:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com>
In-Reply-To: <20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 29 Nov 2025 21:07:40 +0400
X-Gmail-Original-Message-ID: <CACePvbUK6uSDtz0QkBq-eqzQ_Hi9+t1gthGGt+ok7xdZtO1V8Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkRNDXrXhesX6xwbiCQ91_SSNsi6Rzr-o_fwzw9asPFCsw3uZWkKu5-3HE
Message-ID: <CACePvbUK6uSDtz0QkBq-eqzQ_Hi9+t1gthGGt+ok7xdZtO1V8Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Can you add this swap table phase II series to mm-unstable for more
exposure? The patch series has gone through V3, overall looks OK, but
I have not finished reviewing them all yet. I will keep you posted
when the series is fully reviewed.

Thanks

Chris

On Mon, Nov 24, 2025 at 11:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> This series removes the SWP_SYNCHRONOUS_IO swap cache bypass swapin code =
and
> special swap flag bits including SWAP_HAS_CACHE, along with many historic=
al
> issues. The performance is about ~20% better for some workloads, like
> Redis with persistence. This also cleans up the code to prepare for
> later phases, some patches are from a previously posted series.
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> =3D=3D=3D=3D=3D=3D
> sysbench /usr/share/sysbench/oltp_read_only.lua --tables=3D16
> --table-size=3D1000000 --threads=3D96 --time=3D600 (using ZRAM as SWAP, i=
n a
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
> This may cause more serious THP thrashing for certain workloads, but that=
's
> not an issue caused by this series, it's a common THP issue we should res=
olve
> separately.
>
> Link: https://lore.kernel.org/linux-mm/CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+=
2i_mhuP5CQPSOPrmQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/linux-mm/20240326185032.72159-1-ryncsn@gmai=
l.com/ [2]
> Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmai=
l.com/ [3]
>
> Suggested-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Still basically same with V2, mostly comment update and build fix, and
> rebase to resolve conflicts and for easier review and testing. Stress tes=
t and
> performance test is looking good and basically same as before.
>
> Changes in v3:
> - Imporve and update comments [ Barry Song, YoungJun Park, Chris Li ]
> - Simplify the changes of cluster_reclaim_range a bit, as YoungJun points
>   out the change looked confusing.
> - Fix a few typos I found during self review.
> - Fix a few build error and warns.
> - Link to v2: https://lore.kernel.org/r/20251117-swap-table-p2-v2-0-37730=
e6ea6d5@tencent.com
>
> Changes in v2:
> - Rebased on latest mm-new to resolve conflicts, also appliable to
>   mm-unstable.
> - Imporve comment, and commit messages in multiple commits, many thanks t=
o
>   [Barry Song, YoungJun Park, Yosry Ahmed ]
> - Fix cluster usable check in allocator [ YoungJun Park]
> - Improve cover letter [ Chris Li ]
> - Collect Reviewed-by [ Yosry Ahmed ]
> - Fix a few build warning and issues from build bot.
> - Link to v1: https://lore.kernel.org/r/20251029-swap-table-p2-v1-0-3d43f=
3b6ec32@tencent.com
>
> ---
> Kairui Song (18):
>       mm, swap: rename __read_swap_cache_async to swap_cache_alloc_folio
>       mm, swap: split swap cache preparation loop into a standalone helpe=
r
>       mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
>       mm, swap: always try to free swap cache for SWP_SYNCHRONOUS_IO devi=
ces
>       mm, swap: simplify the code and reduce indention
>       mm, swap: free the swap cache after folio is mapped
>       mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO
>       mm, swap: swap entry of a bad slot should not be considered as swap=
ped out
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
>  include/linux/swap.h        |  77 ++--
>  kernel/power/swap.c         |  10 +-
>  mm/madvise.c                |   2 +-
>  mm/memory.c                 | 276 +++++++-------
>  mm/rmap.c                   |   7 +-
>  mm/shmem.c                  |  75 ++--
>  mm/swap.h                   |  70 +++-
>  mm/swap_state.c             | 338 +++++++++++------
>  mm/swapfile.c               | 856 +++++++++++++++++++-------------------=
------
>  mm/userfaultfd.c            |  10 +-
>  mm/vmscan.c                 |   1 -
>  mm/zswap.c                  |   4 +-
>  14 files changed, 854 insertions(+), 876 deletions(-)
> ---
> base-commit: 1fa8c5771a65fc5a56f6e39825561cdc8fa91e14
> change-id: 20251007-swap-table-p2-7d3086e5c38a
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>


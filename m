Return-Path: <linux-pm+bounces-39715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06897CD1B50
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02FB302FA2B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3BF2E8897;
	Fri, 19 Dec 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWyI9gPE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983772D877E
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766174761; cv=none; b=WyxOYH2sE6nH6UkLbmRoFfV8kRjq++52J7m+RqC9KiDLGJaQ2/emEYQb3sIixugEJE+mWCHDBeMGT5ZwpQZrc0TOyjgEjexV0cZuPYqst6uJjmeUmz6/8hxpOgeaUn1Q46wBuKdMWk1xotMHRf0bykN7yjOUH6pKVKAyGNz3izQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766174761; c=relaxed/simple;
	bh=mGiXM7dkwALqgZTC8yWe6dcbyH6/nFmHVVsJpWBZxM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+aJM7ftIcQZeGPpWH6yyGMR8t/L8V2T/d23qgLXiV+loE9ivKEc37Q8opJE4VYOkOo2w59ua6NEKQSOfUiwoMMZFs41pbV5+0M5M+hjq8f4xVVNpSYjQHAPEbuL0Anq1WTPFv7P/m+pRm0OFY9GgyWzvucW0p8MsbdBt4jjnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWyI9gPE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b7b737eddso2202824a12.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766174758; x=1766779558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w5CiTpqGrabbxUxAh6ePhewNTKmPofU9jkTiJ1MvgA=;
        b=NWyI9gPE4flaE6Ql22A4aSKHKYhCzIdVm9veP+5yq7d8/u3xkBDRl9+MQ1lrpx8Mk3
         6wcuVz5PKiw2ticz5u6Mbde9q+wGI5MejLm+G3IfGqH6Kv+vDsptJGiLBbNzmE7YEKgD
         AhOSFvj1eW+FOeXdnvSgSefLbBgDpLdUhR1gzaAPUWimLDC5IsFYF+srDpVm/nd2T7/T
         lsOgDf4hk8pGdfXvCPq+STYXG9/tGiuj9YXoAbdRD28ZJNlEKq3BtnpJruVHKYpYWP5X
         CwHWEU0oztB4JOFk0jztIg94pKf+Y9pcE/V3jaHsTO3wjQivav0LX6wIEY5eWnNEdpzw
         IbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766174758; x=1766779558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4w5CiTpqGrabbxUxAh6ePhewNTKmPofU9jkTiJ1MvgA=;
        b=TNMBvfYpi3G4M5MfynZhVXuyBT6785R88hzJ7Kc/fZjD2h8Nu1sW6lnhE/67fkt8Yz
         iLHwXRuNbFwMwn4g+ThsboFcpHW9Je/dXxbb8oXWz9Iyamg43Q7lRUSPPUQJQZab+Txa
         4J15rDjmhm6mO7wciBw+/GTJ6TpkC6B9QgMsBKJkGbYEyRjZ9A/ykSHTfPQqUYYxAOs6
         77wVk7belfeATWQ6Qg1zupYnV5rtvcALjyoECUjUsyN1ZmYKXV4a7VpAGgupvnrrtb2p
         E4PXH4oihYG1dW8Q4vuzZAcCv1y5wrz5I7Kf8eVrikkjDlkbz7jPKp/0OPSxtrML8ZCV
         bLbw==
X-Forwarded-Encrypted: i=1; AJvYcCUv1I1Hgj14OgBELxfVHRiVh2hQ3dii46YHSF2DPIeSanYeg2zh0gwLQBg/jI4RuT4c0zpD/YL8Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJ4DTEnpX3Dq/az44IXD/18gDyklRcHVxRNab2rDzB8BAaoH+
	l65HuFr7stBzAQZfMLraQ9ut7bKCaJYUJtyjMgxLlFTl6FC+Iw8pW1A6WAbIhCpaI4LC+PfFOIm
	dGyMdIHg3KUYdYPFAXIahrgsUv7V3iP0=
X-Gm-Gg: AY/fxX7Py56iV2RBCu2S8XyZxFfjEImAk9u9mA9TmGkoGTb//MRsYZYG41GGdnxNuUS
	gFEUzNBKMm+dJ4zeXuRe3v6aa55oU+xyri7ga2PjRBrPJeyHiyrpcC/p8Y7x1SjaOKliMDVH8WV
	pcNfVq9cvrdcOb+w6ztvls3QoxXHNNUx4yjN8BP9hxmJk6a6kvFt4Gb5PsksGSQyoAAPpcMkpS0
	UNOddtpUOPt/wr0iXWLPoMHJWC3tLCZEhWxSUvi1gOAvK860HZqzgoU559YR427zNZ9rtkOOaxM
	vShWtVd3r1X8daejV23Ful/yfkBovOLpUIWcQFeOqA==
X-Google-Smtp-Source: AGHT+IF1POnLCa4AjD0T4HL68OsMv+4HDDO0cpabJm86414ifutbIdde1m67LWKd/ckIi8nE4Q7eS3r7NXO8ejqKkZs=
X-Received: by 2002:aa7:c348:0:b0:64b:8f56:f804 with SMTP id
 4fb4d7f45d1cf-64b8f56ff7fmr2613779a12.28.1766174757596; Fri, 19 Dec 2025
 12:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
In-Reply-To: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 20 Dec 2025 04:05:21 +0800
X-Gm-Features: AQt7F2rEwxuypBr72KxPfJdvuV5mfvnYo1-1zcPWVt_eak3CiU3TT4aXkr2_eeI
Message-ID: <CAMgjq7D5bmQvkR_Lw3Fjx+oSwonvT0AqJUM3_wYahpqzk5xHbg@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 3:44=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
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
> Changes in v5:
> Rebased on top of current mm-unstalbe, also appliable on mm-new.
> - Solve trivial conlicts with 6.19 rc1 for easier reviewing.
> - Don't change the argument for swap_entry_swapped [ Baoquan He ].
> - Update commit message and comment [ Baoquan He ].
> - Add a WARN in swap_dup_entries to catch potential swap count
>   overflow. No error was ever observed for this but the check existed
>   before, so just keep it to be very careful.
> - Link to v4: https://lore.kernel.org/r/20251205-swap-table-p2-v4-0-cb7e2=
8a26a40@tencent.com
>
> Changes in v4:
> - Rebase on latest mm-unstable, should be also mergeable with mm-new.
> - Update the shmem update commit message as suggested by, and reviewed
>   by [ Baolin Wang ].
> - Add a WARN_ON to catch more potential issue and update a few comments.
> - Link to v3: https://lore.kernel.org/r/20251125-swap-table-p2-v3-0-33f54=
f707a5c@tencent.com
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

Gmail blocked my Patch 7 so I have to resend it manually, it still
appears on lore thread just fine but the order seems a bit odd. Hope
this won't cause trouble for everyone.


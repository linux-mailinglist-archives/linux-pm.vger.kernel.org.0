Return-Path: <linux-pm+bounces-24953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05363A810BC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B769B1BC03DE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3322DFB2;
	Tue,  8 Apr 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mdOBOdHW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F622D4C0
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127155; cv=none; b=EKN/M5t2b/+LlLhtsYBYVyh/CjWfHxcv70xoZsW+VE0kv7Qm82NfTyT+JraowkLydVnQ6JFodRWuyLt6Nc3qOhqZDWvfKAtHW7WMjP445QyS6ZWZ85TgUb96hDGdemJkScPJtojrqLR58pUWWSTZZzOvRhBvibQL6zBbxAhMT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127155; c=relaxed/simple;
	bh=0Vk4Q/tbcxmqoPdlz6UIUsDuIxw5cq/UVJKCtm5vkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FshRrz8B0nx+21hdj7yzbBAYB+s0Yu7g+Dl9ktCys/5ekLQTiseK1VkymFmRBC+y9wicmcZULRaT0T8oLs4HS9CZBBU+10Dd0tiKy3Iae8O4i+WNJHmpbWbUCjzYbYtN2ea7f1aNyoiMVN/xRgR59GIfdFknJ3Zr4Fx0/iLp4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mdOBOdHW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so15171226d6.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744127152; x=1744731952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4ws45xegNtEo3hyX9VLFGRAMSTn7tItQyk+TYKn5LE=;
        b=mdOBOdHWh/fvGknv0gXu1ly70YBcK/mlc6XLthNm42wAwihn0QSyGIrZdMyIhEwsLh
         eU17LAnpgdsRIv9EXQDRcveignOVir9nOnkym0VA36Ss96poFdxYd86RyMQj7Yy66kgn
         2wAGdrb2POQMbO3dAKlqGaf9vzCW0TkpRvtxgIBjkuubY4c5ANKbz4wL8TMuQ18sjEDT
         BiiLma7vLVSjuBK5JODSdopgmEHTap9QdOpNnlFyhURNmc4ZFZ3JZ0Q3qUV2C4OvkGL3
         rODWUQx1Mn3xlKBAFW+vYt4XL+x3KkWlqSnX8fJsduQJqTobQAy0NLKDj/feuyRHC5ZX
         JwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127152; x=1744731952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ws45xegNtEo3hyX9VLFGRAMSTn7tItQyk+TYKn5LE=;
        b=qg9tlKydrlyEfNFEPoWsF3iHgqRn7I2sKfcbF29JFKo8kzLs0+a0OnlTXcXNTV7u34
         74a+yxgm6L45kGbLz+PwPZH9V0pWaJsHByUMJ+o3K01K2fFJMYYIkXPR3Q60FEwz4jj7
         UxUEqnJK8V3NVGF07hTOmGq+1FH+mD8lJUEIpQq7F/MTmfG0O9moFXa47M3I4YPNu9Yq
         bMITJJfbzrfjcJZifCOVKi+JZjWLjZW7QCt8TwRBd9U4mpzUal1NW/bbUpeDKDRgy27S
         6Z7DQf9cT6c28hiF2fAKgCCS2D+ZH2N/dSTP5Vz5xBildvAr9AfWm59POgqau3A73r+H
         5e6w==
X-Forwarded-Encrypted: i=1; AJvYcCUoVFE8kj+lSs3tGa2dh4mYpORxihMuyY2Ogu5E6yy8qz8V8IoAy48oEIAzlNyx37WfACsjmyAPPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7F6A0PYOAGb6iPYmsCGGN0IJEa9JlQHloFNryDMJbhMSVfO4O
	drSh4qoNqAcY5naLN2xHfsXh8IsQnXA7Hui9nt8PLUYNWUb89g68kQud9k3Vx7M=
X-Gm-Gg: ASbGncsyUumvtGgVUznE/+sCRIEWCbH5qMV7L5W1XeWIjAIkNofP7i2iJdqutV2ednV
	xacmc502tLH60zokIOAjlr1/8nrk1vltP1hkRWo+Gi1Qkn0+KlOrnLlevqKUqRrg3elLDVglX7Z
	mNm9rSfTxLnjIkagay0+35bQmTMeeCpZHZP+jDe/RuS57kypnbmtamZMNsIeIa1PGyWq0U2OSGR
	RIEdDVZyrfpEN1tzpBCgHGIxyRAQmV8y0EENd3i830enGZO+t2Dv0Llyqsac4xF5e6KBRSooDkx
	HRREKk2foJuM+hegZTtt6NS1sXHziHPFjww8LvTXBVQ=
X-Google-Smtp-Source: AGHT+IFB93sjhMlD8Tc/Abwf4lsvbVA+UK3BQyylz33ogjZ0LPpUmiNISCzwhQcTDhyWWyzZaM2+Eg==
X-Received: by 2002:a05:6214:2588:b0:6e6:5d61:4f01 with SMTP id 6a1803df08f44-6f0584a4650mr233144056d6.8.1744127152257;
        Tue, 08 Apr 2025 08:45:52 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6ef0efc0a6csm75867956d6.14.2025.04.08.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:45:51 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:45:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hughd@google.com, yosry.ahmed@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
Message-ID: <20250408154547.GC816@cmpxchg.org>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>

On Tue, Apr 08, 2025 at 02:04:06PM +0100, Usama Arif wrote:
> 
> 
> On 08/04/2025 00:42, Nhat Pham wrote:
> > 
> > V. Benchmarking
> > 
> > As a proof of concept, I run the prototype through some simple
> > benchmarks:
> > 
> > 1. usemem: 16 threads, 2G each, memory.max = 16G
> > 
> > I benchmarked the following usemem commands:
> > 
> > time usemem --init-time -w -O -s 10 -n 16 2g
> > 
> > Baseline:
> > real: 33.96s
> > user: 25.31s
> > sys: 341.09s
> > average throughput: 111295.45 KB/s
> > average free time: 2079258.68 usecs
> > 
> > New Design:
> > real: 35.87s
> > user: 25.15s
> > sys: 373.01s
> > average throughput: 106965.46 KB/s
> > average free time: 3192465.62 usecs
> > 
> > To root cause this regression, I ran perf on the usemem program, as
> > well as on the following stress-ng program:
> > 
> > perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --pageswap $(nproc) --pageswap-ops 100000
> > 
> > and observed the (predicted) increase in lock contention on swap cache
> > accesses. This regression is alleviated if I put together the
> > following hack: limit the virtual swap space to a sufficient size for
> > the benchmark, range partition the swap-related data structures (swap
> > cache, zswap tree, etc.) based on the limit, and distribute the
> > allocation of virtual swap slotss among these partitions (on a per-CPU
> > basis):
> > 
> > real: 34.94s
> > user: 25.28s
> > sys: 360.25s
> > average throughput: 108181.15 KB/s
> > average free time: 2680890.24 usecs
> > 
> > As mentioned above, I will implement proper dynamic swap range
> > partitioning in a follow up work.
> > 
> > 2. Kernel building: zswap enabled, 52 workers (one per processor),
> > memory.max = 3G.
> > 
> > Baseline:
> > real: 183.55s
> > user: 5119.01s
> > sys: 655.16s
> > 
> > New Design:
> > real: mean: 184.5s
> > user: mean: 5117.4s
> > sys: mean: 695.23s
> > 
> > New Design (Static Partition)
> > real: 183.95s
> > user: 5119.29s
> > sys: 664.24s
> > 
> 
> Hi Nhat,
> 
> Thanks for the patches! I have glanced over a couple of them, but this was the main question that came to my mind.
> 
> Just wanted to check if you had a look at the memory regression during these benchmarks?
> 
> Also what is sizeof(swp_desc)? Maybe we can calculate the memory overhead as sizeof(swp_desc) * swap size/PAGE_SIZE?
> 
> For a 64G swap that is filled with private anon pages, the overhead in MB might be (sizeof(swp_desc) in bytes * 16M) - 16M (zerobitmap) - 16M*8 (swap map)?
> 
> This looks like a sizeable memory regression?

One thing to keep in mind is that the swap descriptor is currently
blatantly explicit, and many conversions and optimizations have not
been done yet. There are some tradeoffs made here regarding code
reviewability, but I agree it makes it hard to see what this would
look like fully realized.

I think what's really missing is an analysis of what the goal is and
what the overhead will be then.

The swapin path currently consults the swapcache, then the zeromap,
then zswap, and finally the backend. The external swap_cgroup array is
consulted to determine who to charge for the new page.

With vswap, the descriptor is looked up and resolves to a type,
location, cgroup ownership, a refcount. This means it replaces the
swapcache, the zeromap, the cgroup map, and largely the swap_map.

Nhat was not quite sure yet if the swap_map can be a single bit per
entry or two bits to represent bad slots. In any case, it's a large
reduction in static swap space overhead, and eliminates the tricky
swap count continuation code.


Return-Path: <linux-pm+bounces-15293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BA9936FA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05931C21166
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6411DE2A5;
	Mon,  7 Oct 2024 19:07:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8261DDA18
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328048; cv=none; b=MLRS83mUzt/c0Wja6qKZ2yj+/XVNX/TTUPVkRnOTgx8OQPtnx+Uf76mAGF5tYH4YqoKW8RkNbmVrdp7MEbfqoO9J3SAV0AcfO8hCJ4ljtHuz6v0th5NFhLG+oWzvLAytnfsXzR+76FrVyH/s0ko1nEMjJAEFfyWjcyskeSP49MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328048; c=relaxed/simple;
	bh=ub6K4TGqRBWLc7gcU91QVrXe4RDRhWYmxq7KbIJzFfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVEw5wmVWg/FAnhCVW3120Hz0TqStqoGyXL78DC6nowH2LYzB/a+gWD6ICE0YzrI0g+qdxcpwb6JmM2YJV9kQM6pAHUXUZrmNC0CM2bsmIl7UfzMur+FHgS4znMODpz+oP/Aaark3rn9aGVbcGiOP16Ry8McActfJwqjOyV1STg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E37DA7;
	Mon,  7 Oct 2024 12:07:46 -0700 (PDT)
Received: from [10.57.20.159] (unknown [10.57.20.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF8503F73F;
	Mon,  7 Oct 2024 12:07:14 -0700 (PDT)
Message-ID: <733de7f6-922c-460a-b4f6-57633122eac6@arm.com>
Date: Mon, 7 Oct 2024 20:07:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [cpuidle] 38f83090f5: fsmark.app_overhead
 51.9% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202410072214.11d18a3c-oliver.sang@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202410072214.11d18a3c-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/7/24 15:43, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 51.9% regression of fsmark.app_overhead on:
> 
> (
> but there is no performance difference for fsmark.files_per_sec
>      18.58            -0.2%      18.55        fsmark.files_per_sec
> )
> 
> 
> commit: 38f83090f515b4b5d59382dfada1e7457f19aa47 ("cpuidle: menu: Remove iowait influence")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> testcase: fsmark
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> parameters:
> 
> 	iterations: 1x
> 	nr_threads: 1t
> 	disk: 1HDD
> 	fs: btrfs
> 	fs2: nfsv4
> 	filesize: 4K
> 	test_size: 40M
> 	sync_method: fsyncBeforeClose
> 	nr_files_per_directory: 1fpd
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410072214.11d18a3c-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241007/202410072214.11d18a3c-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
> 
> commit: 
>   v6.12-rc1
>   38f83090f5 ("cpuidle: menu: Remove iowait influence")
> 
>        v6.12-rc1 38f83090f515b4b5d59382dfada 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    2032015 ±  3%     +51.9%    3087623        fsmark.app_overhead
>      18.58            -0.2%      18.55        fsmark.files_per_sec
>       2944            -2.9%       2858        vmstat.system.cs
>       0.02            +0.0        0.02        mpstat.cpu.all.irq%
>       0.01 ±  2%      +0.0        0.01        mpstat.cpu.all.soft%
>       0.04 ±  2%      +0.0        0.05 ±  3%  mpstat.cpu.all.sys%
>       4.07 ± 18%     -53.4%       1.90 ± 53%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>     267.72 ± 38%     -62.7%      99.92 ± 75%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>      30.08 ± 29%     -58.5%      12.50 ± 63%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>       4.07 ± 18%     -53.5%       1.89 ± 53%  sched_debug.cfs_rq:/.removed.util_avg.avg
>     267.67 ± 38%     -62.7%      99.92 ± 75%  sched_debug.cfs_rq:/.removed.util_avg.max
>      30.08 ± 29%     -58.5%      12.49 ± 63%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>      20.43 ± 17%     -25.5%      15.21 ± 16%  sched_debug.cfs_rq:/.util_est.stddev
>       7.85 ± 14%     +21.6%       9.55 ± 12%  sched_debug.cpu.clock.stddev
>       0.00 ± 25%     -47.7%       0.00 ± 44%  sched_debug.cpu.next_balance.stddev
>       0.02 ± 10%     -18.9%       0.02 ± 11%  sched_debug.cpu.nr_running.avg
>       0.14 ±  5%     -14.5%       0.12 ±  4%  sched_debug.cpu.nr_running.stddev
>       5.19            +0.6        5.79        perf-stat.i.branch-miss-rate%
>    4096977 ±  4%      +8.4%    4442600 ±  2%  perf-stat.i.branch-misses
>       1.79 ±  7%      -0.2        1.59 ±  3%  perf-stat.i.cache-miss-rate%
>   11620307           +22.2%   14202690        perf-stat.i.cache-references
>       2925            -3.2%       2830        perf-stat.i.context-switches
>       1.68           +38.6%       2.32        perf-stat.i.cpi
>  4.457e+08 ±  3%     +23.8%  5.518e+08 ±  2%  perf-stat.i.cpu-cycles
>       1630 ±  8%     +28.6%       2096 ±  4%  perf-stat.i.cycles-between-cache-misses
>       0.63           -25.5%       0.47        perf-stat.i.ipc
>       5.26            +0.2        5.48        perf-stat.overall.branch-miss-rate%
>       1.16           +18.4%       1.38        perf-stat.overall.cpi
>       0.86           -15.6%       0.73        perf-stat.overall.ipc
>    4103944 ±  4%      +7.9%    4429579        perf-stat.ps.branch-misses
>   11617199           +22.1%   14186503        perf-stat.ps.cache-references
>       2919            -3.2%       2825        perf-stat.ps.context-switches
>  4.492e+08 ±  3%     +23.2%  5.534e+08 ±  2%  perf-stat.ps.cpu-cycles

The other obvious guess would be increased cache misses due to deeper idle
states clearing the cache. The reduced IPC and increased cycles would indicate
that, but the cache-misses don't seem to make up for that IMO.


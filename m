Return-Path: <linux-pm+bounces-15275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDD9930EB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF4AB25100
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52D1D7E31;
	Mon,  7 Oct 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITMsj93x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C561D7E29
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314332; cv=none; b=m3faWbQV/ql1VGwSBybZjgSfXAfhbkDZ/KhWnUS49YjWpAD31Hrvd555GOqfZrS77WxOsRjWt6okOrqjMCrwaib+G9OAT/rtS6BNeYKS3Su5mN5SWNbhHYyBVl5Ud/818+c6hh5o0+cWRB5gAXQSARMDvrJwqU63POCYNP1EEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314332; c=relaxed/simple;
	bh=pZmffQkA69WnfFXbIxukgXI2HfLGAcf3r59BIQcG+jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdDP4cDU9XuuUR7lQGnzWUoGQ9azXOfx8zHY+VHYE4lRJ1QUgg047fKOPmpMGHODu/ays3cqKZlMLoN0GKR9SCA1BtraI97bHF8OxTb0fZlkJWrl8tPG8XgRciZ3WEyVvg++mqb7oK/nBpswenEq63CSgqIgq8D58fj5I/iiYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITMsj93x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EE8C4CECC
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314331;
	bh=pZmffQkA69WnfFXbIxukgXI2HfLGAcf3r59BIQcG+jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ITMsj93xi+SnfrTSbBWV4mhJtKWt5+q9UTQEKqFoV1CxqIAaF1aH+F9uBzvHHDP2q
	 ErIYp9HQPsRWWgvMSFdMgQYqQ1J+/La0YoiACMPN663i7pO4nrY1e/iF2e1Rr+RxzZ
	 IZtJZlcUyIJDwUYmEG0qthJnXp/DhJTCqEBv4V0MFnaCEF8901fhjrOplVzH5QwmQY
	 eo11XNIBTyIRp2IlnBw+f9mI0rjyTLpm9iYtXTFrZKG1gpmON/V+x8gdy6GUeO1Ook
	 vXN8g2c3M91rpUFNGbzLzdcf3fiBBsJLKAt0fRgcc0CvbqMxEIjeojPNZsZI8sK8Z0
	 o9hOiGRGfsC4g==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e03f8ecef8so2815189b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2024 08:18:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuRgOjzP4j5CXBB8Xx3EZuEzc5hyrVd86kwpNNohnfPptkpIFyUk92SQJLZUdd/dd/XapLukU2Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqDpgpnhXtpd5kHjpVXsyD2BvbA5/Ina6EuJSHp9ZInrDJEgc
	P5unaV6cVn8sECywTAvsvTm0Y6H6a0CAWGsagnyFt0cwW/YJ8VZyG5X7JyhMfgPAWewgGFvY8sL
	USh1P8ejYEmyaWzU0lJtD6Lm9L8k=
X-Google-Smtp-Source: AGHT+IEzY17ZFOuFo+e97wLqHAFoLi6XsCNxkcnQDuAegkoCJB+FQGksigXFTFJ6ZweH4dZBERL3Ly2MWedpvFwbVSY=
X-Received: by 2002:a05:6808:398c:b0:3da:ab86:bfd7 with SMTP id
 5614622812f47-3e3c1533d90mr11538552b6e.3.1728314330855; Mon, 07 Oct 2024
 08:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410072214.11d18a3c-oliver.sang@intel.com>
In-Reply-To: <202410072214.11d18a3c-oliver.sang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 17:18:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iyn0==dDNtdxEQpMqGaxa4O_Qr-uRxAq8DzJ+HmtWd5A@mail.gmail.com>
Message-ID: <CAJZ5v0iyn0==dDNtdxEQpMqGaxa4O_Qr-uRxAq8DzJ+HmtWd5A@mail.gmail.com>
Subject: Re: [linux-next:master] [cpuidle] 38f83090f5: fsmark.app_overhead
 51.9% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Christian Loehle <christian.loehle@arm.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:44=E2=80=AFPM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 51.9% regression of fsmark.app_overhead on:

What exactly is fsmark.app_overhead?  What does it measure?

>
> (
> but there is no performance difference for fsmark.files_per_sec
>      18.58            -0.2%      18.55        fsmark.files_per_sec
> )
>
>
> commit: 38f83090f515b4b5d59382dfada1e7457f19aa47 ("cpuidle: menu: Remove =
iowait influence")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> testcase: fsmark
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ =
2.60GHz (Ice Lake) with 128G memory
> parameters:
>
>         iterations: 1x
>         nr_threads: 1t
>         disk: 1HDD
>         fs: btrfs
>         fs2: nfsv4
>         filesize: 4K
>         test_size: 40M
>         sync_method: fsyncBeforeClose
>         nr_files_per_directory: 1fpd
>         cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410072214.11d18a3c-oliver.san=
g@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241007/202410072214.11d18a3c-ol=
iver.sang@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_file=
s_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase=
:
>   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debia=
n-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
>
> commit:
>   v6.12-rc1
>   38f83090f5 ("cpuidle: menu: Remove iowait influence")
>
>        v6.12-rc1 38f83090f515b4b5d59382dfada
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    2032015 =C4=85  3%     +51.9%    3087623        fsmark.app_overhead
>      18.58            -0.2%      18.55        fsmark.files_per_sec
>       2944            -2.9%       2858        vmstat.system.cs
>       0.02            +0.0        0.02        mpstat.cpu.all.irq%
>       0.01 =C4=85  2%      +0.0        0.01        mpstat.cpu.all.soft%
>       0.04 =C4=85  2%      +0.0        0.05 =C4=85  3%  mpstat.cpu.all.sy=
s%
>       4.07 =C4=85 18%     -53.4%       1.90 =C4=85 53%  sched_debug.cfs_r=
q:/.removed.runnable_avg.avg
>     267.72 =C4=85 38%     -62.7%      99.92 =C4=85 75%  sched_debug.cfs_r=
q:/.removed.runnable_avg.max
>      30.08 =C4=85 29%     -58.5%      12.50 =C4=85 63%  sched_debug.cfs_r=
q:/.removed.runnable_avg.stddev
>       4.07 =C4=85 18%     -53.5%       1.89 =C4=85 53%  sched_debug.cfs_r=
q:/.removed.util_avg.avg
>     267.67 =C4=85 38%     -62.7%      99.92 =C4=85 75%  sched_debug.cfs_r=
q:/.removed.util_avg.max
>      30.08 =C4=85 29%     -58.5%      12.49 =C4=85 63%  sched_debug.cfs_r=
q:/.removed.util_avg.stddev
>      20.43 =C4=85 17%     -25.5%      15.21 =C4=85 16%  sched_debug.cfs_r=
q:/.util_est.stddev
>       7.85 =C4=85 14%     +21.6%       9.55 =C4=85 12%  sched_debug.cpu.c=
lock.stddev
>       0.00 =C4=85 25%     -47.7%       0.00 =C4=85 44%  sched_debug.cpu.n=
ext_balance.stddev
>       0.02 =C4=85 10%     -18.9%       0.02 =C4=85 11%  sched_debug.cpu.n=
r_running.avg
>       0.14 =C4=85  5%     -14.5%       0.12 =C4=85  4%  sched_debug.cpu.n=
r_running.stddev
>       5.19            +0.6        5.79        perf-stat.i.branch-miss-rat=
e%
>    4096977 =C4=85  4%      +8.4%    4442600 =C4=85  2%  perf-stat.i.branc=
h-misses
>       1.79 =C4=85  7%      -0.2        1.59 =C4=85  3%  perf-stat.i.cache=
-miss-rate%
>   11620307           +22.2%   14202690        perf-stat.i.cache-reference=
s
>       2925            -3.2%       2830        perf-stat.i.context-switche=
s
>       1.68           +38.6%       2.32        perf-stat.i.cpi
>  4.457e+08 =C4=85  3%     +23.8%  5.518e+08 =C4=85  2%  perf-stat.i.cpu-c=
ycles
>       1630 =C4=85  8%     +28.6%       2096 =C4=85  4%  perf-stat.i.cycle=
s-between-cache-misses
>       0.63           -25.5%       0.47        perf-stat.i.ipc
>       5.26            +0.2        5.48        perf-stat.overall.branch-mi=
ss-rate%
>       1.16           +18.4%       1.38        perf-stat.overall.cpi
>       0.86           -15.6%       0.73        perf-stat.overall.ipc
>    4103944 =C4=85  4%      +7.9%    4429579        perf-stat.ps.branch-mi=
sses
>   11617199           +22.1%   14186503        perf-stat.ps.cache-referenc=
es
>       2919            -3.2%       2825        perf-stat.ps.context-switch=
es
>  4.492e+08 =C4=85  3%     +23.2%  5.534e+08 =C4=85  2%  perf-stat.ps.cpu-=
cycles
>       0.12 =C4=85  4%     -23.1%       0.09 =C4=85 12%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_con=
nector_destroy_workfn.process_one_work
>       0.00 =C4=85  8%     +52.0%       0.01 =C4=85 17%  perf-sched.sch_de=
lay.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_f=
ile.btrfs_do_write_iter
>       0.01 =C4=85 13%    +178.9%       0.03 =C4=85 11%  perf-sched.sch_de=
lay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>       0.01 =C4=85 13%     +47.2%       0.01 =C4=85 14%  perf-sched.sch_de=
lay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.00 =C4=85 14%    +257.1%       0.01 =C4=85 20%  perf-sched.sch_de=
lay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4=
_run_open_task
>       0.06 =C4=85  2%     +11.8%       0.06 =C4=85  3%  perf-sched.sch_de=
lay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.12 =C4=85  7%     -14.5%       0.10 =C4=85  4%  perf-sched.sch_de=
lay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_c=
onnector_destroy_workfn
>       0.09 =C4=85  8%     +13.9%       0.10 =C4=85  9%  perf-sched.sch_de=
lay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.03 =C4=85  2%     +27.5%       0.03 =C4=85 14%  perf-sched.sch_de=
lay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.14 =C4=85  6%     +20.5%       0.17 =C4=85 11%  perf-sched.sch_de=
lay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rp=
c_execute
>       0.01 =C4=85  2%    +867.1%       0.14 =C4=85 21%  perf-sched.sch_de=
lay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4=
_run_open_task
>       0.27 =C4=85 17%    +652.4%       2.03 =C4=85183%  perf-sched.wait_a=
nd_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.11 =C4=85  7%     +67.0%       0.19 =C4=85 12%  perf-sched.wait_a=
nd_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fi=
lemap_fdatawait_range
>      33.20 =C4=85  3%     +29.7%      43.08 =C4=85  4%  perf-sched.wait_a=
nd_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.84 =C4=85  4%     -16.6%       0.70 =C4=85 10%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnot=
ify_mark_destroy_workfn
>       2121 =C4=85  3%     -23.3%       1626 =C4=85  5%  perf-sched.wait_a=
nd_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
>       2.98 =C4=85143%   +5665.5%     171.90 =C4=85215%  perf-sched.wait_a=
nd_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.56 =C4=85 14%     +38.0%       0.77 =C4=85  7%  perf-sched.wait_a=
nd_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fi=
lemap_fdatawait_range
>       0.35 =C4=85  9%     +50.9%       0.53 =C4=85  8%  perf-sched.wait_a=
nd_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit=
.nfs4_run_open_task
>       3768 =C4=85 16%     +17.0%       4411 =C4=85  5%  perf-sched.wait_a=
nd_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.16 =C4=85  4%     +20.4%       0.20 =C4=85  4%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_con=
nector_destroy_workfn.process_one_work
>       0.89 =C4=85 14%     -35.2%       0.58 =C4=85 17%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_mar=
k_destroy_workfn.process_one_work
>       0.24 =C4=85 20%    +728.0%       1.99 =C4=85186%  perf-sched.wait_t=
ime.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.10 =C4=85  9%     +57.0%       0.16 =C4=85 12%  perf-sched.wait_t=
ime.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>      33.20 =C4=85  3%     +29.7%      43.07 =C4=85  4%  perf-sched.wait_t=
ime.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.79 =C4=85  5%     -19.7%       0.63 =C4=85 12%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_m=
ark_destroy_workfn
>       0.27 =C4=85  8%     +13.3%       0.30 =C4=85  5%  perf-sched.wait_t=
ime.max.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_con=
nector_destroy_workfn.process_one_work
>       0.50 =C4=85 17%     +33.3%       0.67 =C4=85  8%  perf-sched.wait_t=
ime.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>       0.34 =C4=85  9%     +23.1%       0.42 =C4=85  8%  perf-sched.wait_t=
ime.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4=
_run_open_task
>       5.60 =C4=85  7%      -1.3        4.32 =C4=85  6%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe
>       5.57 =C4=85  7%      -1.3        4.30 =C4=85  6%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.33 =C4=85  7%      -0.5        0.86 =C4=85 15%  perf-profile.call=
trace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_=
call
>       1.32 =C4=85  7%      -0.5        0.86 =C4=85 15%  perf-profile.call=
trace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
>       1.30 =C4=85  8%      -0.5        0.85 =C4=85 15%  perf-profile.call=
trace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
>       1.88 =C4=85 12%      -0.4        1.48 =C4=85  8%  perf-profile.call=
trace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.78 =C4=85 13%      +0.2        0.95 =C4=85 12%  perf-profile.call=
trace.cycles-pp.call_transmit.__rpc_execute.rpc_async_schedule.process_one_=
work.worker_thread
>       0.83 =C4=85 15%      +0.2        1.06 =C4=85 11%  perf-profile.call=
trace.cycles-pp.__vfork
>       1.11 =C4=85 15%      +0.2        1.34 =C4=85 10%  perf-profile.call=
trace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_sr=
c_group.sched_balance_rq.sched_balance_newidle
>       0.39 =C4=85 71%      +0.3        0.72 =C4=85  9%  perf-profile.call=
trace.cycles-pp.start_ordered_ops.btrfs_sync_file.btrfs_do_write_iter.do_it=
er_readv_writev.vfs_iter_write
>       0.54 =C4=85 46%      +0.4        0.91 =C4=85 16%  perf-profile.call=
trace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch=
_events.cmd_stat
>       0.92 =C4=85 20%      +0.4        1.32 =C4=85 11%  perf-profile.call=
trace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_t=
imer_interrupt.cpuidle_enter_state.cpuidle_enter
>       0.18 =C4=85141%      +0.4        0.61 =C4=85 10%  perf-profile.call=
trace.cycles-pp.readn.evsel__read_counter.read_counters.process_interval.di=
spatch_events
>       0.84 =C4=85 20%      +0.4        1.28 =C4=85 10%  perf-profile.call=
trace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.as=
m_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       0.09 =C4=85223%      +0.5        0.60 =C4=85 10%  perf-profile.call=
trace.cycles-pp.read.readn.evsel__read_counter.read_counters.process_interv=
al
>       0.00            +0.6        0.58 =C4=85  8%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.readn.evsel__r=
ead_counter
>       0.00            +0.6        0.58 =C4=85  8%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.read.readn.evsel__read_counter.re=
ad_counters
>       3.34 =C4=85  8%      +0.8        4.16 =C4=85  9%  perf-profile.call=
trace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues=
.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>      17.29 =C4=85  2%      +0.9       18.18 =C4=85  3%  perf-profile.call=
trace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>      17.29 =C4=85  2%      +0.9       18.18 =C4=85  3%  perf-profile.call=
trace.cycles-pp.ret_from_fork.ret_from_fork_asm
>      17.29 =C4=85  2%      +0.9       18.18 =C4=85  3%  perf-profile.call=
trace.cycles-pp.ret_from_fork_asm
>       4.19 =C4=85  5%      +1.3        5.51 =C4=85  4%  perf-profile.call=
trace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__=
sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       5.20 =C4=85  8%      +1.5        6.67 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_=
interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       6.40 =C4=85  9%      +1.6        7.96 =C4=85  4%  perf-profile.call=
trace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic=
_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       6.53 =C4=85 10%      +1.7        8.21 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.a=
sm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>      11.90 =C4=85  7%      +2.4       14.29 =C4=85  3%  perf-profile.call=
trace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt=
.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>      14.08 =C4=85  7%      +2.6       16.65 =C4=85  4%  perf-profile.call=
trace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle=
_enter.cpuidle_idle_call.do_idle
>       1.04 =C4=85 29%      -0.9        0.12 =C4=85 77%  perf-profile.chil=
dren.cycles-pp.poll_idle
>       1.87 =C4=85  9%      -0.5        1.35 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.mmput
>       1.84 =C4=85 11%      -0.5        1.34 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.exit_mmap
>       2.08 =C4=85 11%      -0.5        1.62 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.x64_sys_call
>       1.94 =C4=85 12%      -0.5        1.48 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.do_exit
>       1.76 =C4=85 12%      -0.5        1.30 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__x64_sys_exit_group
>       1.75 =C4=85 12%      -0.5        1.30 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.do_group_exit
>       1.42 =C4=85  7%      -0.4        1.00 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.exit_mm
>       0.94 =C4=85 12%      -0.4        0.59 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.unmap_vmas
>       1.03 =C4=85 14%      -0.3        0.72 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.btree_write_cache_pages
>       0.85 =C4=85  9%      -0.3        0.54 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.unmap_page_range
>       0.96 =C4=85 17%      -0.3        0.67 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.submit_eb_page
>       0.82 =C4=85  8%      -0.3        0.53 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.zap_pmd_range
>       0.78 =C4=85  9%      -0.3        0.50 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.zap_pte_range
>       0.65 =C4=85 15%      -0.3        0.39 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.zap_present_ptes
>       0.70 =C4=85 19%      -0.2        0.46 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.sched_clock_cpu
>       0.61 =C4=85 23%      -0.2        0.37 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.sched_clock
>       0.65 =C4=85  8%      -0.2        0.45 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.dl_server_stop
>       0.55 =C4=85  6%      -0.2        0.38 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.btrfs_commit_transaction
>       0.45 =C4=85  6%      -0.2        0.29 =C4=85 28%  perf-profile.chil=
dren.cycles-pp.alloc_empty_file
>       0.65 =C4=85 15%      -0.2        0.49 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.read_tsc
>       0.23 =C4=85 36%      -0.1        0.09 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.vma_alloc_folio_noprof
>       0.37 =C4=85  5%      -0.1        0.25        perf-profile.children.=
cycles-pp.__btrfs_run_delayed_refs
>       0.37 =C4=85  5%      -0.1        0.25        perf-profile.children.=
cycles-pp.btrfs_run_delayed_refs
>       0.19 =C4=85 53%      -0.1        0.07 =C4=85 89%  perf-profile.chil=
dren.cycles-pp.mas_next_slot
>       0.36 =C4=85  6%      -0.1        0.25 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.btrfs_run_delayed_refs_for_head
>       0.35 =C4=85  4%      -0.1        0.24 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.run_delayed_data_ref
>       0.34 =C4=85  9%      -0.1        0.25 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.try_address
>       0.14 =C4=85 27%      -0.1        0.06 =C4=85 81%  perf-profile.chil=
dren.cycles-pp.number
>       0.15 =C4=85 35%      -0.1        0.07 =C4=85 58%  perf-profile.chil=
dren.cycles-pp.obj_cgroup_charge
>       0.14 =C4=85 32%      -0.1        0.05 =C4=85109%  perf-profile.chil=
dren.cycles-pp.wake_up_q
>       0.29 =C4=85  5%      -0.1        0.22 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.i2c_outb
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.__i2c_transfer
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.ast_vga_connector_helper_detect_ctx
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.bit_xfer
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.drm_connector_helper_detect_from_ddc
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.drm_do_probe_ddc_edid
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.drm_helper_probe_detect_ctx
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.drm_probe_ddc
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.i2c_transfer
>       0.35 =C4=85  6%      -0.1        0.27 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.output_poll_execute
>       0.16 =C4=85 21%      -0.1        0.09 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.btrfs_write_and_wait_transaction
>       0.03 =C4=85 70%      +0.0        0.08 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.sd_setup_read_write_cmnd
>       0.06 =C4=85 57%      +0.1        0.11 =C4=85 30%  perf-profile.chil=
dren.cycles-pp._copy_from_user
>       0.06 =C4=85 89%      +0.1        0.13 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.blk_mq_requeue_work
>       0.03 =C4=85111%      +0.1        0.12 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.rcu_accelerate_cbs
>       0.25 =C4=85 29%      +0.1        0.37 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.extent_writepage_io
>       0.11 =C4=85 31%      +0.1        0.24 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.rw_verify_area
>       0.17 =C4=85 63%      +0.1        0.30 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.perf_event_read
>       0.07 =C4=85 62%      +0.1        0.21 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.svc_pool_wake_idle_thread
>       0.14 =C4=85 58%      +0.2        0.29 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.svc_tcp_read_marker
>       0.15 =C4=85 55%      +0.2        0.31 =C4=85 34%  perf-profile.chil=
dren.cycles-pp.__write_extent_buffer
>       0.15 =C4=85 64%      +0.2        0.31 =C4=85 28%  perf-profile.chil=
dren.cycles-pp.smp_call_function_single
>       0.35 =C4=85 18%      +0.2        0.52 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.arch_cpu_idle_enter
>       0.11 =C4=85 75%      +0.2        0.30 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.copy_extent_buffer_full
>       0.54 =C4=85 15%      +0.2        0.72 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.start_ordered_ops
>       0.15 =C4=85 22%      +0.2        0.34 =C4=85 41%  perf-profile.chil=
dren.cycles-pp.nfsd_set_fh_dentry
>       0.28 =C4=85 27%      +0.2        0.48 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.__fh_verify
>       0.28 =C4=85 27%      +0.2        0.48 =C4=85 29%  perf-profile.chil=
dren.cycles-pp.fh_verify
>       0.41 =C4=85 24%      +0.2        0.62 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.perf_read
>       0.45 =C4=85 20%      +0.2        0.66 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__memcpy
>       0.18 =C4=85 48%      +0.2        0.40 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.generic_exec_single
>       0.83 =C4=85 15%      +0.2        1.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__vfork
>       0.28 =C4=85 30%      +0.2        0.53 =C4=85 52%  perf-profile.chil=
dren.cycles-pp._nfs4_proc_access
>       0.33 =C4=85 22%      +0.3        0.58 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.tick_nohz_stop_idle
>       0.28 =C4=85 30%      +0.3        0.54 =C4=85 51%  perf-profile.chil=
dren.cycles-pp.nfs4_proc_access
>       0.63 =C4=85 14%      +0.3        0.92 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.evsel__read_counter
>       0.46 =C4=85 26%      +0.3        0.76 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.finish_task_switch
>       0.81 =C4=85 16%      +0.3        1.14 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.readn
>       1.10 =C4=85 15%      +0.4        1.48 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.xs_tcp_send_request
>       1.15 =C4=85 12%      +0.4        1.53 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.call_transmit
>       1.14 =C4=85 12%      +0.4        1.51 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.xprt_transmit
>       1.12 =C4=85 13%      +0.4        1.50 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.xprt_request_transmit
>       1.74 =C4=85  6%      +0.4        2.14 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.sched_tick
>       3.24 =C4=85  9%      +0.4        3.67 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.cmd_stat
>       3.24 =C4=85  9%      +0.4        3.67 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.dispatch_events
>       1.07 =C4=85 15%      +0.4        1.50 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.irq_enter_rcu
>       3.24 =C4=85  9%      +0.4        3.66 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.process_interval
>       1.01 =C4=85 16%      +0.4        1.45 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.tick_irq_enter
>       1.54 =C4=85 17%      +0.5        2.02 =C4=85 14%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock
>       3.08 =C4=85  9%      +0.5        3.58 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.read_counters
>       5.90 =C4=85  8%      +0.8        6.71 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.handle_softirqs
>      17.29 =C4=85  2%      +0.9       18.18 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.kthread
>       3.57 =C4=85  7%      +0.9        4.50 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.update_process_times
>      17.42 =C4=85  2%      +1.0       18.38 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.ret_from_fork
>      17.44 =C4=85  2%      +1.0       18.41 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.ret_from_fork_asm
>       4.47 =C4=85  4%      +1.4        5.85 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.tick_nohz_handler
>       5.49 =C4=85  6%      +1.6        7.05 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__hrtimer_run_queues
>       6.76 =C4=85  8%      +1.7        8.42 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.hrtimer_interrupt
>       6.90 =C4=85  9%      +1.8        8.68 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__sysvec_apic_timer_interrupt
>      12.60 =C4=85  7%      +2.6       15.18 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.sysvec_apic_timer_interrupt
>      13.99 =C4=85  7%      +2.7       16.65 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.98 =C4=85 27%      -0.9        0.11 =C4=85 74%  perf-profile.self=
.cycles-pp.poll_idle
>       0.53 =C4=85 24%      -0.2        0.28 =C4=85 28%  perf-profile.self=
.cycles-pp.__schedule
>       0.28 =C4=85 21%      -0.2        0.11 =C4=85 24%  perf-profile.self=
.cycles-pp._find_next_bit
>       0.32 =C4=85 29%      -0.1        0.20 =C4=85 23%  perf-profile.self=
.cycles-pp.zap_present_ptes
>       0.06 =C4=85 57%      +0.0        0.10 =C4=85 31%  perf-profile.self=
.cycles-pp._copy_from_user
>       0.06 =C4=85 58%      +0.1        0.11 =C4=85 28%  perf-profile.self=
.cycles-pp.__virt_addr_valid
>       0.06 =C4=85 68%      +0.1        0.20 =C4=85 37%  perf-profile.self=
.cycles-pp.tick_nohz_handler
>       0.44 =C4=85 19%      +0.2        0.66 =C4=85  7%  perf-profile.self=
.cycles-pp.__memcpy
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>


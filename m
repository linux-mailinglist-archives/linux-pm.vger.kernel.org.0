Return-Path: <linux-pm+bounces-26502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF448AA5C67
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7511BC4770
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05221A928;
	Thu,  1 May 2025 08:57:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF2B20E01A;
	Thu,  1 May 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746089856; cv=none; b=aUTxKrRUimmt22+WhxU14JaMGeLlsp+aMPb6Ef2nY4729+mPdAHLx9JTan++w9Ys7/MPIgikXbT60Yh4zw4g+SA6MwSPiDoI49CXra9/mTsdn4Tkn241RuNi2JdhQtvXeWrX3wjSYrTGh5TAaJ0YQmqnOs7L6UbHeQGpEtmPVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746089856; c=relaxed/simple;
	bh=ScajGTXlGH6KflV+V5P2kODwduXGixhrigoQvS0rQZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pg/5T5TDiOl+C2YHVdimt/cOnMtG08ysdwcCZbq+lmTm7CKC6k8/NgRcRa1i42VV8Q53Gr9dkT9XgeeBGOX41wcQgUd+g1mY3CrNvojadqgderiMcGYA2WERu9Yw9YjQ4kBgy+05QhOqskrovmgYu/J92Szu9/8IK+QQ5YdoA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FB1F2B;
	Thu,  1 May 2025 01:57:24 -0700 (PDT)
Received: from [10.1.36.61] (unknown [10.1.36.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC323F5A1;
	Thu,  1 May 2025 01:57:29 -0700 (PDT)
Message-ID: <507cc05d-0b66-4b05-afcd-21f088f51b53@arm.com>
Date: Thu, 1 May 2025 09:57:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [cpuidle] 38f83090f5: fsmark.files_per_sec 5.1%
 regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
References: <202504241314.fe89a536-lkp@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202504241314.fe89a536-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 4/24/25 06:49, kernel test robot wrote:
> 
> Hello,
> 
> back in last Oct, we reported
> "[linux-next:master] [cpuidle]  38f83090f5:  fsmark.app_overhead 51.9% regression"
> (https://lore.kernel.org/all/202410072214.11d18a3c-oliver.sang@intel.com/)
> but there is no obvious fsmark.files_per_sec difference at that time.
> 
> now on a different platform and with different fsmark parameters, we notice
> a small regression of fsmark.files_per_sec. but no obvious fsmark.app_overhead
> difference this time (so does not show in below detail table).

Any idea what's different on it in terms of cpuidle?
There's a good chance 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
is more useful than iowait metrics for such a workload, worth a try anyway.
Any chance you could try that?
With the governor infrastructure you could just checkout menu at parent/38f83090f5
and mainline, renaming the governor and then switching between the two at runtime.
Or I can send a patch for mainline checking out menu of parent/38f83090f5.


> 
> last Oct report seems cause some confusion. so for this one, we try to rebuild
> kernels and run more times to confirm the configs are same for parent/38f83090f5
> and data is stable.
> 
> just FYI what we observed in our tests.
> 
> 
> kernel test robot noticed a 5.1% regression of fsmark.files_per_sec on:
> 
> 
> commit: 38f83090f515b4b5d59382dfada1e7457f19aa47 ("cpuidle: menu: Remove iowait influence")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      6fea5fabd3323cd27b2ab5143263f37ff29550cb]
> [test failed on linux-next/master bc8aa6cdadcc00862f2b5720e5de2e17f696a081]
> 
> testcase: fsmark
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> parameters:
> 
> 	iterations: 8
> 	disk: 1SSD
> 	nr_threads: 4
> 	fs: btrfs
> 	filesize: 9B
> 	test_size: 16G
> 	sync_method: fsyncBeforeClose
> 	nr_directories: 16d
> 	nr_files_per_directory: 256fpd
> 	cpufreq_governor: performance
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202504241314.fe89a536-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250424/202504241314.fe89a536-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>   gcc-12/performance/1SSD/9B/btrfs/8/x86_64-rhel-9.4/16d/256fpd/4/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-spr-2sp4/16G/fsmark
> 
> commit: 
>   v6.12-rc1
>   38f83090f5 ("cpuidle: menu: Remove iowait influence")
> 
>        v6.12-rc1 38f83090f515b4b5d59382dfada 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       0.12 ±  4%      +0.0        0.14 ±  2%  mpstat.cpu.all.iowait%
>     940771            +2.8%     967141        proc-vmstat.pgfault
>     120077            -5.7%     113267        vmstat.system.cs
>      72197 ±  2%     -14.2%      61965 ±  2%  vmstat.system.in
>      20496            -5.1%      19456        fsmark.files_per_sec
>     219.58            +5.0%     230.50        fsmark.time.elapsed_time
>     219.58            +5.0%     230.50        fsmark.time.elapsed_time.max
>       0.02 ±  9%     +22.5%       0.03 ± 10%  perf-sched.wait_and_delay.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>      15676 ±  9%     -25.2%      11732 ± 14%  perf-sched.wait_and_delay.count.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>     130219 ±  7%     -14.8%     110942 ±  8%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
>       0.02 ± 10%     +27.8%       0.02 ± 12%  perf-sched.wait_time.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>  1.457e+09            -4.4%  1.393e+09        perf-stat.i.branch-instructions
>   14767792            -4.6%   14093766        perf-stat.i.branch-misses
>   71872875            -3.4%   69406875        perf-stat.i.cache-references
>     121769            -5.8%     114744        perf-stat.i.context-switches
>  8.574e+09            -7.2%   7.96e+09        perf-stat.i.cpu-cycles
>  7.979e+09            -3.6%  7.691e+09        perf-stat.i.instructions
>       3773            -2.0%       3697        perf-stat.i.minor-faults
>       3773            -2.0%       3697        perf-stat.i.page-faults
>   1.45e+09            -4.4%  1.386e+09        perf-stat.ps.branch-instructions
>   14670086            -4.5%   14003599        perf-stat.ps.branch-misses
>   71521482            -3.4%   69080547        perf-stat.ps.cache-references
>     121170            -5.7%     114204        perf-stat.ps.context-switches
>  8.537e+09            -7.2%  7.925e+09        perf-stat.ps.cpu-cycles
>  7.938e+09            -3.6%  7.654e+09        perf-stat.ps.instructions
>       3717            -1.9%       3645        perf-stat.ps.minor-faults
>       3717            -1.9%       3645        perf-stat.ps.page-faults
>       9.65 ± 14%      -9.4        0.22 ±123%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>      18.61 ±  6%      -4.7       13.95 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>      18.05 ±  7%      -4.5       13.51 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>      18.73 ±  7%      -4.5       14.22 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>      22.60 ±  4%      -4.5       18.11 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
>      21.55 ±  5%      -4.5       17.08 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>      21.57 ±  5%      -4.5       17.11 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
>      21.58 ±  5%      -4.5       17.12 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
>       2.39 ±  6%      -0.6        1.78 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_clone_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu.handle_irq_event
>       2.32 ±  7%      -0.6        1.72 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_orig_write_end_io.btrfs_clone_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu
>       2.21 ±  7%      -0.6        1.64 ±  7%  perf-profile.calltrace.cycles-pp.end_bbio_meta_write.btrfs_orig_write_end_io.btrfs_clone_write_end_io.blk_mq_end_request_batch.nvme_irq
>       0.52 ± 27%      +0.1        0.63 ±  6%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.blk_finish_plug.btrfs_sync_log.btrfs_sync_file.do_fsync
>       0.52 ± 27%      +0.1        0.63 ±  6%  perf-profile.calltrace.cycles-pp.blk_finish_plug.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       0.95 ±  6%      +0.2        1.10 ±  7%  perf-profile.calltrace.cycles-pp.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>       1.04 ±  6%      +0.2        1.21 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       0.51 ± 27%      +0.2        0.68 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.36 ± 70%      +0.3        0.62 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_free_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items
>       0.36 ± 70%      +0.3        0.65 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       2.20 ±  8%      +0.6        2.77 ± 11%  perf-profile.calltrace.cycles-pp.copy_extent_buffer_full.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items
>       0.00            +0.8        0.76 ± 10%  perf-profile.calltrace.cycles-pp.folio_end_writeback.end_bbio_meta_write.btrfs_orig_write_end_io.blk_mq_end_request_batch.nvme_irq
>       0.00            +0.8        0.85 ±  9%  perf-profile.calltrace.cycles-pp.end_bbio_meta_write.btrfs_orig_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu
>       0.00            +0.9        0.89 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_orig_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu.handle_irq_event
>       7.54 ±  5%      +1.1        8.69 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items
>       7.56 ±  5%      +1.1        8.71 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log
>       3.57 ±  5%      +1.3        4.87 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       1.99 ± 13%      +2.8        4.76 ± 10%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.cpuidle_enter_state
>       2.25 ± 14%      +2.9        5.16 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.cpuidle_enter_state.cpuidle_enter
>       2.35 ± 14%      +3.0        5.32 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       2.51 ± 15%      +3.1        5.60 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_posted_msi_notification.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>      50.39 ±  2%      +4.4       54.84 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      50.38 ±  2%      +4.4       54.82 ±  2%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      50.35 ±  2%      +4.4       54.80 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      50.84 ±  2%      +4.5       55.30        perf-profile.calltrace.cycles-pp.fsync
>      50.57 ±  2%      +4.5       55.03 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
>      50.57 ±  2%      +4.5       55.03 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>       9.92 ± 13%      -9.4        0.52 ± 12%  perf-profile.children.cycles-pp.poll_idle
>      18.84 ±  7%      -4.6       14.26 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
>      18.85 ±  7%      -4.6       14.27 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
>      19.59 ±  6%      -4.5       15.04 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
>      22.60 ±  4%      -4.5       18.11 ±  3%  perf-profile.children.cycles-pp.common_startup_64
>      22.60 ±  4%      -4.5       18.11 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
>      22.58 ±  4%      -4.5       18.09 ±  3%  perf-profile.children.cycles-pp.do_idle
>      21.58 ±  5%      -4.5       17.12 ±  4%  perf-profile.children.cycles-pp.start_secondary
>       2.46 ±  6%      -0.6        1.86 ±  7%  perf-profile.children.cycles-pp.btrfs_clone_write_end_io
>       0.12 ± 13%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.local_clock_noinstr
>       0.22 ±  8%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.__xa_set_mark
>       0.57 ±  5%      +0.1        0.64 ±  5%  perf-profile.children.cycles-pp.blk_finish_plug
>       0.59 ±  5%      +0.1        0.67 ±  5%  perf-profile.children.cycles-pp.__blk_flush_plug
>       0.77 ±  5%      +0.1        0.87 ±  4%  perf-profile.children.cycles-pp.__folio_start_writeback
>       0.60 ±  6%      +0.1        0.70 ±  6%  perf-profile.children.cycles-pp.pin_down_extent
>       0.75 ±  6%      +0.1        0.88 ±  7%  perf-profile.children.cycles-pp.btrfs_free_tree_block
>       0.96 ±  5%      +0.1        1.11 ±  7%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
>       1.11 ±  6%      +0.2        1.29 ±  6%  perf-profile.children.cycles-pp.set_extent_bit
>       1.21 ±  5%      +0.2        1.38 ±  6%  perf-profile.children.cycles-pp.__set_extent_bit
>       0.83 ±  5%      +0.2        1.01 ±  6%  perf-profile.children.cycles-pp.__folio_mark_dirty
>       1.25 ±  6%      +0.2        1.47 ±  6%  perf-profile.children.cycles-pp.__folio_end_writeback
>       2.28 ±  4%      +0.3        2.56 ±  4%  perf-profile.children.cycles-pp.__write_extent_buffer
>       3.81 ±  5%      +0.5        4.34 ±  6%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
>       3.73 ±  6%      +0.7        4.42 ±  8%  perf-profile.children.cycles-pp.copy_extent_buffer_full
>       5.21 ±  4%      +0.8        5.97 ±  6%  perf-profile.children.cycles-pp.__memcpy
>       3.62 ±  4%      +1.3        4.92 ±  7%  perf-profile.children.cycles-pp.intel_idle
>      10.48 ±  4%      +1.5       11.94 ±  4%  perf-profile.children.cycles-pp.btrfs_force_cow_block
>      10.51 ±  4%      +1.5       11.97 ±  4%  perf-profile.children.cycles-pp.btrfs_cow_block
>      50.40 ±  2%      +4.4       54.84 ±  2%  perf-profile.children.cycles-pp.__x64_sys_fsync
>      50.38 ±  2%      +4.4       54.83 ±  2%  perf-profile.children.cycles-pp.do_fsync
>      50.36 ±  2%      +4.4       54.81 ±  2%  perf-profile.children.cycles-pp.btrfs_sync_file
>      50.86 ±  2%      +4.5       55.32        perf-profile.children.cycles-pp.fsync
>      69.02 ±  2%      +4.6       73.66        perf-profile.children.cycles-pp.do_syscall_64
>      69.05 ±  2%      +4.6       73.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       6.48 ± 13%      -6.0        0.48 ± 12%  perf-profile.self.cycles-pp.poll_idle
>       0.32 ±  8%      +0.1        0.39 ± 11%  perf-profile.self.cycles-pp.folio_mark_accessed
>       5.10 ±  4%      +0.7        5.84 ±  6%  perf-profile.self.cycles-pp.__memcpy
>       3.62 ±  4%      +1.3        4.92 ±  7%  perf-profile.self.cycles-pp.intel_idle
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B941423AB87
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 19:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHCRTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 13:19:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53208 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgHCRTv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 13:19:51 -0400
Received: from 89-64-89-42.dynamic.chello.pl (89.64.89.42) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 1004877ac9269e33; Mon, 3 Aug 2020 19:19:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Subject: Re: [cpufreq] 48fc4efcdd: WARNING:possible_circular_locking_dependency_detected
Date:   Mon, 03 Aug 2020 19:19:47 +0200
Message-ID: <2379312.oHovjqWFI2@kreacher>
In-Reply-To: <87v9i3clnh.fsf@riseup.net>
References: <20200731115929.GQ23458@shao2-debian> <87v9i3clnh.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, August 1, 2020 1:25:22 AM CEST Francisco Jerez wrote:
> kernel test robot <rong.a.chen@intel.com> writes:
> 
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 48fc4efcdd584e8f04da8b195262ec38221bd6db ("[PATCH v2 2/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> > url: https://github.com/0day-ci/linux/commits/Rafael-J-Wysocki/cpufreq-intel_pstate-Implement-passive-mode-with-HWP-enabled/20200717-014718
> > base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> >
> > in testcase: kernel-selftests
> > with following parameters:
> >
> > 	group: kselftests-cpufreq
> > 	ucode: 0x5002f01
> >
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >
> >
> > on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> >
> > [   74.745395] WARNING: possible circular locking dependency detected
> > [   74.752071] 5.8.0-rc5-00064-g48fc4efcdd584 #1 Not tainted
> > [   74.757949] ------------------------------------------------------
> > [   74.764604] main.sh/3019 is trying to acquire lock:
> > [   74.769954] ffffffff82ec7f08 (intel_pstate_driver_lock){+.+.}-{3:3}, at: store_energy_performance_preference+0xec/0x250
> > [   74.781228] 
> > [   74.781228] but task is already holding lock:
> > [   74.788017] ffff88b07b5f8380 (&policy->rwsem){++++}-{3:3}, at: store+0x69/0xa0
> > [   74.795711] 
> > [   74.795711] which lock already depends on the new lock.
> > [   74.795711] 
> > [   74.805222] 
> > [   74.805222] the existing dependency chain (in reverse order) is:
> > [   74.813529] 
> > [   74.813529] -> #2 (&policy->rwsem){++++}-{3:3}:
> > [   74.820371]        __lock_acquire+0x538/0xa90
> > [   74.825144]        lock_acquire+0xab/0x390
> > [   74.829660]        down_write+0x38/0x70
> > [   74.833910]        store+0x69/0xa0
> > [   74.837724]        kernfs_fop_write+0xdc/0x1c0
> > [   74.842576]        vfs_write+0xee/0x220
> > [   74.846814]        ksys_write+0x68/0xe0
> > [   74.851039]        do_syscall_64+0x52/0xb0
> > [   74.855512]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   74.861463] 
> > [   74.861463] -> #1 (cpu_hotplug_lock){++++}-{0:0}:
> > [   74.868395]        __lock_acquire+0x538/0xa90
> > [   74.873127]        lock_acquire+0xab/0x390
> > [   74.877597]        cpus_read_lock+0x39/0xd0
> > [   74.882146]        cpufreq_register_driver+0xb6/0x2a0
> > [   74.887556]        intel_pstate_register_driver+0x32/0x70
> > [   74.893312]        intel_pstate_init+0x45d/0x4ca
> > [   74.898281]        do_one_initcall+0x5d/0x330
> > [   74.902984]        kernel_init_freeable+0x248/0x2c9
> > [   74.908185]        kernel_init+0xa/0x112
> > [   74.912430]        ret_from_fork+0x1f/0x30
> > [   74.916850] 
> > [   74.916850] -> #0 (intel_pstate_driver_lock){+.+.}-{3:3}:
> > [   74.924376]        check_prev_add+0x8e/0x9f0
> > [   74.928988]        validate_chain+0x79b/0x1080
> > [   74.933773]        __lock_acquire+0x538/0xa90
> > [   74.938469]        lock_acquire+0xab/0x390
> > [   74.942896]        __mutex_lock+0xac/0x9c0
> > [   74.947318]        store_energy_performance_preference+0xec/0x250
> > [   74.953735]        store+0x7c/0xa0
> > [   74.957458]        kernfs_fop_write+0xdc/0x1c0
> > [   74.962231]        vfs_write+0xee/0x220
> > [   74.966395]        ksys_write+0x68/0xe0
> > [   74.970549]        do_syscall_64+0x52/0xb0
> > [   74.974975]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   74.980859] 
> > [   74.980859] other info that might help us debug this:
> > [   74.980859] 
> > [   74.989744] Chain exists of:
> > [   74.989744]   intel_pstate_driver_lock --> cpu_hotplug_lock --> &policy->rwsem
> > [   74.989744] 
> > [   75.002149]  Possible unsafe locking scenario:
> > [   75.002149] 
> > [   75.008643]        CPU0                    CPU1
> > [   75.013461]        ----                    ----
> > [   75.018275]   lock(&policy->rwsem);
> > [   75.022037]                                lock(cpu_hotplug_lock);
> > [   75.028495]                                lock(&policy->rwsem);
> > [   75.034773]   lock(intel_pstate_driver_lock);
> > [   75.039427] 
> > [   75.039427]  *** DEADLOCK ***
> > [   75.039427] 
> > [   75.046168] 5 locks held by main.sh/3019:
> > [   75.050456]  #0: ffff888b9d973438 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x1ba/0x220
> > [   75.058750]  #1: ffff888beaaec488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write+0xa5/0x1c0
> > [   75.067413]  #2: ffff8898284de890 (kn->active#163){.+.+}-{0:0}, at: kernfs_fop_write+0xad/0x1c0
> > [   75.076422]  #3: ffffffff82c73a70 (cpu_hotplug_lock){++++}-{0:0}, at: store+0x26/0xa0
> > [   75.084566]  #4: ffff88b07b5f8380 (&policy->rwsem){++++}-{3:3}, at: store+0x69/0xa0
> > [   75.092528] 
> > [   75.092528] stack backtrace:
> > [   75.097500] CPU: 0 PID: 3019 Comm: main.sh Not tainted 5.8.0-rc5-00064-g48fc4efcdd584 #1
> > [   75.105902] Hardware name: Intel Corporation ............/S9200WKBRD2, BIOS SE5C620.86B.0D.01.0552.060220191912 06/02/2019
> > [   75.117274] Call Trace:
> > [   75.120081]  dump_stack+0x96/0xd0
> > [   75.123754]  check_noncircular+0x162/0x180
> > [   75.128220]  check_prev_add+0x8e/0x9f0
> > [   75.132325]  validate_chain+0x79b/0x1080
> > [   75.136589]  __lock_acquire+0x538/0xa90
> > [   75.140767]  lock_acquire+0xab/0x390
> > [   75.144684]  ? store_energy_performance_preference+0xec/0x250
> > [   75.150775]  __mutex_lock+0xac/0x9c0
> > [   75.154697]  ? store_energy_performance_preference+0xec/0x250
> > [   75.160786]  ? __lock_acquire+0x538/0xa90
> > [   75.165147]  ? store_energy_performance_preference+0xec/0x250
> > [   75.171282]  ? sscanf+0x4e/0x70
> > [   75.174781]  ? store_energy_performance_preference+0xec/0x250
> > [   75.180886]  store_energy_performance_preference+0xec/0x250
> > [   75.186816]  store+0x7c/0xa0
> > [   75.190056]  kernfs_fop_write+0xdc/0x1c0
> > [   75.194338]  vfs_write+0xee/0x220
> > [   75.198011]  ksys_write+0x68/0xe0
> > [   75.201685]  do_syscall_64+0x52/0xb0
> > [   75.205617]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   75.211051] RIP: 0033:0x7f2c1dfa9504
> > [   75.214999] Code: Bad RIP value.
> > [   75.218582] RSP: 002b:00007fffe26da068 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >
> 
> Was about to review v4 of this series, but from my reading of it it
> seems like this locking inversion situation could also occur with your
> last revision.  Is it a legitimate concern Rafael?
> 
> >[...]
> 

There a mistake in the patch.

Because energy_performance_preference is a policy attribute,
it is not valid to acquire intel_pstate_driver_lock in its "store"
routine, but that routine can check the driver pointer without additional
locking, because that pointer cannot change while it is running.

I've just sent a v5 to fix this problem.

Thanks!




Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91112581FF
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 21:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHaToD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 15:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgHaToD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Aug 2020 15:44:03 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53792206E3;
        Mon, 31 Aug 2020 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598903042;
        bh=9B6/M6/43/N+VrQX6UwnkiY8uNrfSqXz8/e67LODxn8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=w8hFO41BDU39LCL9ZCa1qgGOdeuxpAELFO0uNMmN+YWn0MQE0cqn/xsnvz7GmpE0i
         Idi3UfMleZwXdWRWcy8+s2LBiyXN9+KTwpuUelORm8OFRQs1kGO1+7KG4KRrPrIIqv
         04mCkuDoeGVSo+I13lAazkwxXcbztxOIKCmnxBG4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 36D2B35230F1; Mon, 31 Aug 2020 12:44:02 -0700 (PDT)
Date:   Mon, 31 Aug 2020 12:44:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        peterz@infrdead.org
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
Message-ID: <20200831194402.GD2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 31, 2020 at 12:02:31PM +0530, Naresh Kamboju wrote:
> While booting linux mainline kernel on arm64 db410c this kernel warning
> noticed.
> 
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   git commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
>   git describe: v5.9-rc3
>   make_kernelversion: 5.9.0-rc3
>   kernel-config:
> http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-mainline/2965/config
> 
> Boot log,
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> [    0.000000] Linux version 5.9.0-rc3 (oe-user@oe-host)
> (aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils)
> 2.30.0.20180208) #1 SMP PREEMPT Mon Aug 31 00:23:15 UTC 2020
> [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> <>
> [    5.299090] sdhci: Secure Digital Host Controller Interface driver
> [    5.299140] sdhci: Copyright(c) Pierre Ossman
> [    5.304313]
> [    5.307771] Synopsys Designware Multimedia Card Interface Driver
> [    5.308588] =============================
> [    5.308593] WARNING: suspicious RCU usage
> [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
> [    5.320052] 5.9.0-rc3 #1 Not tainted
> [    5.320057] -----------------------------
> [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37
> suspicious rcu_dereference_check() usage!
> [    5.320068]
> [    5.320068] other info that might help us debug this:
> [    5.320068]
> [    5.320074]
> [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
> [    5.320078] RCU used illegally from extended quiescent state!
> [    5.320084] no locks held by swapper/0/0.
> [    5.320089]
> [    5.320089] stack backtrace:
> [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
> [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    5.346452] Call trace:
> [    5.346463]  dump_backtrace+0x0/0x1f8
> [    5.346471]  show_stack+0x2c/0x38
> [    5.346480]  dump_stack+0xec/0x15c
> [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
> [    5.346499]  lock_acquire+0x3d0/0x440
> [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
> [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
> [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
> [    5.421795]  cpuidle_enter_state+0xc8/0x610
> [    5.426392]  cpuidle_enter+0x3c/0x50
> [    5.430561]  call_cpuidle+0x44/0x80
> [    5.434378]  do_idle+0x240/0x2a0

RCU ignores CPUs in the idle loop, which means that you cannot use
rcu_read_lock() from the idle loop without use of something like
RCU_NONIDLE().  If this is due to event tracing, you should use the
_rcuidle() variant of the event trace statement.

Note also that Peter Zijlstra (CCed) is working to shrink the portion
of the idle loop that RCU ignores.  Not sure that it covers your
case, but it is worth checking.

							Thanx, Paul

> [    5.437589]  cpu_startup_entry+0x2c/0x78
> [    5.441063]  rest_init+0x1ac/0x280
> [    5.444970]  arch_call_rest_init+0x14/0x1c
> [    5.448180]  start_kernel+0x50c/0x544
> [    5.452395]
> [    5.452399]
> [    5.452403] =============================
> [    5.452406] WARNING: suspicious RCU usage
> [    5.452409] 5.9.0-rc3 #1 Not tainted
> [    5.452412] -----------------------------
> [    5.452417] /usr/src/kernel/include/trace/events/ipi.h:36
> suspicious rcu_dereference_check() usage!
> [    5.452420]
> [    5.452424] other info that might help us debug this:
> [    5.452426]
> [    5.452429]
> [    5.452432] rcu_scheduler_active = 2, debug_locks = 1
> [    5.452436] RCU used illegally from extended quiescent state!
> [    5.452440] 1 lock held by swapper/0/0:
> [    5.452443]  #0: ffff8000127408f8 (logbuf_lock){-...}-{2:2}, at:
> vprintk_emit+0xb0/0x358
> [    5.452458]
> [    5.452461] stack backtrace:
> [    5.452465] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> [    5.452469] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    5.452472] Call trace:
> [    5.452476]  dump_backtrace+0x0/0x1f8
> [    5.452479]  show_stack+0x2c/0x38
> [    5.452481]  dump_stack+0xec/0x15c
> [    5.452485]  lockdep_rcu_suspicious+0xd4/0xf8
> [    5.452489]  arch_irq_work_raise+0x208/0x210
> [    5.452493]  __irq_work_queue_local+0x64/0x88
> [    5.452495]  irq_work_queue+0x3c/0x88
> [    5.452499]  printk_safe_log_store+0x148/0x178
> [    5.452502]  vprintk_func+0x1cc/0x2b8
> [    5.452506]  printk+0x74/0x94
> [    5.452509]  lockdep_rcu_suspicious+0x28/0xf8
> [    5.452512]  lock_release+0x338/0x360
> [    5.452516]  _raw_spin_unlock+0x3c/0xa0
> [    5.452519]  vprintk_emit+0xf8/0x358
> [    5.452522]  vprintk_default+0x48/0x58
> [    5.452526]  vprintk_func+0xec/0x2b8
> [    5.452528]  printk+0x74/0x94
> [    5.452532]  lockdep_rcu_suspicious+0x28/0xf8
> [    5.452535]  lock_acquire+0x3d0/0x440
> [    5.452538]  _raw_spin_lock_irqsave+0x80/0xb0
> [    5.452542]  __pm_runtime_suspend+0x34/0x1d0
> [    5.452545]  psci_enter_domain_idle_state+0x4c/0xb0
> [    5.452549]  cpuidle_enter_state+0xc8/0x610
> [    5.452552]  cpuidle_enter+0x3c/0x50
> [    5.452555]  call_cpuidle+0x44/0x80
> [    5.452559]  do_idle+0x240/0x2a0
> [    5.452562]  cpu_startup_entry+0x2c/0x78
> [    5.452564]  rest_init+0x1ac/0x280
> [    5.452568]  arch_call_rest_init+0x14/0x1c
> [    5.452571]  start_kernel+0x50c/0x544
> [    5.452575] =============================
> [    5.452578] WARNING: suspicious RCU usage
> [    5.452582] 5.9.0-rc3 #1 Not tainted
> [    5.452585] -----------------------------
> [    5.452590] /usr/src/kernel/include/trace/events/lock.h:63
> suspicious rcu_dereference_check() usage!
> [    5.452593]
> [    5.452596] other info that might help us debug this:
> [    5.452599]
> [    5.452601]
> [    5.452605] rcu_scheduler_active = 2, debug_locks = 1
> [    5.452609] RCU used illegally from extended quiescent state!
> [    5.452612] 1 lock held by swapper/0/0:
> [    5.452615]  #0: ffff8000127408f8 (logbuf_lock){-...}-{2:2}, at:
> vprintk_emit+0xb0/0x358
> [    5.452630]
> [    5.452633] stack backtrace:
> [    5.452636] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> [    5.452640] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    5.452643] Call trace:
> [    5.452646]  dump_backtrace+0x0/0x1f8
> [    5.452649]  show_stack+0x2c/0x38
> [    5.452652]  dump_stack+0xec/0x15c
> [    5.452656]  lockdep_rcu_suspicious+0xd4/0xf8
> [    5.452659]  lock_release+0x338/0x360
> [    5.452662]  _raw_spin_unlock+0x3c/0xa0
> [    5.452665]  vprintk_emit+0xf8/0x358
> [    5.452669]  vprintk_default+0x48/0x58
> [    5.452671]  vprintk_func+0xec/0x2b8
> [    5.452674]  printk+0x74/0x94
> [    5.452677]  lockdep_rcu_suspicious+0x28/0xf8
> [    5.452680]  lock_acquire+0x3d0/0x440
> [    5.452683]  _raw_spin_lock_irqsave+0x80/0xb0
> [    5.452686]  __pm_runtime_suspend+0x34/0x1d0
> [    5.452690]  psci_enter_domain_idle_state+0x4c/0xb0
> [    5.452693]  cpuidle_enter_state+0xc8/0x610
> [    5.452696]  cpuidle_enter+0x3c/0x50
> [    5.452698]  call_cpuidle+0x44/0x80
> [    5.452701]  do_idle+0x240/0x2a0
> [    5.452704]  cpu_startup_entry+0x2c/0x78
> [    5.452708]  rest_init+0x1ac/0x280
> [    5.452711]  arch_call_rest_init+0x14/0x1c
> [    5.452714]  start_kernel+0x50c/0x544
> 
> full test log link,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.9-rc3/testrun/3137660/suite/linux-log-parser/test/check-kernel-warning-1722813/log
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org

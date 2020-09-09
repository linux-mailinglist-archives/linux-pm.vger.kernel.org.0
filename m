Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D43262668
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 06:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIIEiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 00:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIIEiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 00:38:51 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664FC061756
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 21:38:48 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id u48so474324uau.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 21:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uR+rPpxqCzj1rn3UEtuWhrArIxD6Cs95gsyB99mLm8o=;
        b=KrX+hmUnc38Q0a4rHrlWdthm2e+t5DqpQxDmOfo82vGgxfjZTx3o2ee/ezbu1QIO07
         1yr48BAdF/P5N8fRUKEQ1wr4tlY3BH+0SnIw+FCTDDu3d1hxHLlOAOenu7BUF1UFd4mY
         3JvF4+Xyiiip9x94qnUC/pJtCq0pDvzNa2sJmKyvtUp31DFEhxS0RuFBjbg8Ja+d402d
         vhCPuksDXtJW++uK9dQKSNUNpV4vLGy9PaCRUdkUA2lQSPNtSVPRQJ4JFfVdXaHC+fNO
         fy6tXUz9o/W5XpJnhknU2q0DA96Y390d3KWkgFLnSzlgVDfUjfu6SYzB7WRMKHqx1Tev
         u1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uR+rPpxqCzj1rn3UEtuWhrArIxD6Cs95gsyB99mLm8o=;
        b=rvspPY0PMlWhm3v+ufhK8BCRVAOsBfjNux2IiScCIfO21zoanamwymYTp+zN8KZNtj
         65ewQBeDz+MrC10U9pueZL4b7F0I1Gm4m+PwiCgvT2FLbesYNGZjsNiQeU+IM+0AD6zw
         YoyBOUOwNlt0QY7FauKyADucFrA5wLbkLXy1Lfqso0S2obfjSSX0xc/FhXWwbL++QUB7
         dWCbvp8UPq9RTH3SaUqUjU2Jm2oME+Fu1wPCwbn2WJuy9jzVXQF2g0iVoc1K2/Cz49iC
         Bl2b271KiXNvCoGnN/ys4ey9L/Puj+34T15PxpQ+R8hi9NlWUy00qVTxWskkLgMC6wpN
         XeFA==
X-Gm-Message-State: AOAM531wyksBNkrAND2UtTT/ONdn/YkkjrFOyBJrZFarrpgALCvIg0/L
        EQcDA7UsL2bVPA7YmLs8DnwAwdwc4NgDEGivYM9w7w==
X-Google-Smtp-Source: ABdhPJzacr9m49kcqzYcvXdQMX/sPxFltce1zmkjR1sHXCd61kMUEjEaAdCc47Gr1QialYVA51Ub/MPnj2qBlG6VPRw=
X-Received: by 2002:a9f:35d0:: with SMTP id u16mr1418044uad.113.1599626325672;
 Tue, 08 Sep 2020 21:38:45 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Sep 2020 10:08:34 +0530
Message-ID: <CA+G9fYuRquEtm53yz9SYqa6O5gg4e6d9BCmDn163Fe2VwhWcJw@mail.gmail.com>
Subject: WARNING: suspicious RCU usage: race/events/tlb.h:57 suspicious
 rcu_dereference_check() usage!
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     ": Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While booting x86_64 with Linux next 20200908 tag kernel this warning
was noticed.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: dff9f829e5b0181d4ed9d35aa62d695292399b54
  git describe: next-20200908
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/853/config

warning logs:
---------------------
[   18.874329] Freeing unused kernel image (rodata/data gap) memory: 2012K
[   18.881107] Run /sbin/init as init process
[   18.905611]
[   18.907190] =============================
[   18.911194] WARNING: suspicious RCU usage
[   18.915199] 5.9.0-rc4-next-20200908 #1 Not tainted
[   18.919982] -----------------------------
[   18.923984] /usr/src/kernel/include/trace/events/tlb.h:57
suspicious rcu_dereference_check() usage!
[   18.933016]
[   18.933016] other info that might help us debug this:
[   18.933016]
[   18.941006]
[   18.941006] rcu_scheduler_active = 2, debug_locks = 1
[   18.947523] RCU used illegally from extended quiescent state!
[   18.953261] no locks held by swapper/2/0.
[   18.957264]
[   18.957264] stack backtrace:
[   18.961619] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.9.0-rc4-next-20200908 #1
[   18.969007] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   18.976392] Call Trace:
[   18.978844]  dump_stack+0x7d/0x9f
[   18.982158]  lockdep_rcu_suspicious+0xce/0xf0
[   18.986517]  switch_mm_irqs_off+0x441/0x450
[   18.990702]  switch_mm+0x1b/0x50
[   18.993936]  leave_mm+0x34/0x40
[   18.997082]  acpi_idle_enter_bm+0x23/0x120
[   19.001180]  acpi_idle_enter+0x189/0x2a0
[   19.005104]  ? rcu_eqs_enter.constprop.85+0xb2/0x180
[   19.010072]  cpuidle_enter_state+0xa5/0x4b0
[   19.015265]  cpuidle_enter+0x2e/0x40
[   19.015268]  do_idle+0x226/0x2b0
[   19.015273]  cpu_startup_entry+0x1d/0x20
[   19.015275]  start_secondary+0x114/0x150
[   19.029943]  secondary_startup_64+0xb6/0xc0
[   19.034141]
[   19.034142] =============================
[   19.034142] WARNING: suspicious RCU usage
[   19.034142] 5.9.0-rc4-next-20200908 #1 Not tainted
[   19.034143] -----------------------------
[   19.034143] /usr/src/kernel/include/trace/events/lock.h:37
suspicious rcu_dereference_check() usage!
[   19.034143]
[   19.034144] other info that might help us debug this:
[   19.034144]
[   19.034144]
[   19.034145] rcu_scheduler_active = 2, debug_locks = 1
[   19.034145] RCU used illegally from extended quiescent state!
[   19.034146] no locks held by swapper/2/0.
[   19.034146]
[   19.034146] stack backtrace:
[   19.034147] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.9.0-rc4-next-20200908 #1
[   19.034147] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   19.034147] Call Trace:
[   19.034148]  dump_stack+0x7d/0x9f
[   19.034148]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034148]  lock_acquire+0x327/0x390
[   19.034149]  _raw_spin_lock+0x2f/0x40
[   19.034149]  ? vprintk_emit+0x78/0x2f0
[   19.034149]  vprintk_emit+0x78/0x2f0
[   19.034149]  vprintk_default+0x1f/0x30
[   19.034150]  vprintk_func+0x51/0xf0
[   19.034150]  printk+0x52/0x6e
[   19.034150]  ? __lock_acquire+0x32a/0x19f0
[   19.034151]  lockdep_rcu_suspicious+0x20/0xf0
[   19.034151]  switch_mm_irqs_off+0x441/0x450
[   19.034151]  switch_mm+0x1b/0x50
[   19.034152]  leave_mm+0x34/0x40
[   19.034152]  acpi_idle_enter_bm+0x23/0x120
[   19.034152]  acpi_idle_enter+0x189/0x2a0
[   19.034153]  ? rcu_eqs_enter.constprop.85+0xb2/0x180
[   19.034153]  cpuidle_enter_state+0xa5/0x4b0
[   19.034153]  cpuidle_enter+0x2e/0x40
[   19.034154]  do_idle+0x226/0x2b0
[   19.034154]  cpu_startup_entry+0x1d/0x20
[   19.034154]  start_secondary+0x114/0x150
[   19.034155]  secondary_startup_64+0xb6/0xc0
[   19.034155]
[   19.034155] =============================
[   19.034156] WARNING: suspicious RCU usage
[   19.034156] 5.9.0-rc4-next-20200908 #1 Not tainted
[   19.034156] -----------------------------
[   19.034157] /usr/src/kernel/include/trace/events/lock.h:63
suspicious rcu_dereference_check() usage!
[   19.034157]
[   19.034157] other info that might help us debug this:
[   19.034158]
[   19.034158]
[   19.034158] rcu_scheduler_active = 2, debug_locks = 1
[   19.034159] RCU used illegally from extended quiescent state!
[   19.034159] 1 lock held by swapper/2/0:
[   19.034159]  #0: ffffffffbed25f58 (logbuf_lock){-...}-{2:2}, at:
vprintk_emit+0x78/0x2f0
[   19.034161]
[   19.034161] stack backtrace:
[   19.034162] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.9.0-rc4-next-20200908 #1
[   19.034162] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   19.034162] Call Trace:
[   19.034163]  dump_stack+0x7d/0x9f
[   19.034163]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034163]  ? vprintk_emit+0x9e/0x2f0
[   19.034164]  lock_release+0x246/0x270
[   19.034164]  _raw_spin_unlock+0x1a/0x30
[   19.034164]  vprintk_emit+0x9e/0x2f0
[   19.034165]  vprintk_default+0x1f/0x30
[   19.034165]  vprintk_func+0x51/0xf0
[   19.034165]  printk+0x52/0x6e
[   19.034166]  ? __lock_acquire+0x32a/0x19f0
[   19.034166]  lockdep_rcu_suspicious+0x20/0xf0
[   19.034166]  switch_mm_irqs_off+0x441/0x450
[   19.034167]  switch_mm+0x1b/0x50
[   19.034167]  leave_mm+0x34/0x40
[   19.034167]  acpi_idle_enter_bm+0x23/0x120
[   19.034167]  acpi_idle_enter+0x189/0x2a0
[   19.034168]  ? rcu_eqs_enter.constprop.85+0xb2/0x180
[   19.034168]  cpuidle_enter_state+0xa5/0x4b0
[   19.034168]  cpuidle_enter+0x2e/0x40
[   19.034169]  do_idle+0x226/0x2b0
[   19.034169]  cpu_startup_entry+0x1d/0x20
[   19.034169]  start_secondary+0x114/0x150
[   19.034170]  secondary_startup_64+0xb6/0xc0
[   19.034170]
[   19.034170] =============================
[   19.034171] WARNING: suspicious RCU usage
[   19.034171] 5.9.0-rc4-next-20200908 #1 Not tainted
[   19.034171] -----------------------------
[   19.034172] /usr/src/kernel/include/trace/events/sched.h:90
suspicious rcu_dereference_check() usage!
[   19.034172]
[   19.034172] other info that might help us debug this:
[   19.034173]
[   19.034173]
[   19.034173] rcu_scheduler_active = 2, debug_locks = 1
[   19.034174] RCU used illegally from extended quiescent state!
[   19.034174] 2 locks held by swapper/2/0:
[   19.034174]  #0: ffffffffbed25ff8 ((console_sem).lock){-...}-{2:2},
at: up+0x16/0x50
[   19.034176]  #1: ffff90dbeea90800 (&p->pi_lock){-.-.}-{2:2}, at:
try_to_wake_up+0x52/0x7a0
[   19.034178]
[   19.034178] stack backtrace:
[   19.034178] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.9.0-rc4-next-20200908 #1
[   19.034179] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   19.034179] Call Trace:
[   19.034179]  dump_stack+0x7d/0x9f
[   19.034180]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034180]  try_to_wake_up+0x6a4/0x7a0
[   19.034180]  ? find_held_lock+0x35/0xa0
[   19.034181]  wake_up_process+0x15/0x20
[   19.034181]  __up.isra.4+0x39/0x40
[   19.034181]  up+0x46/0x50
[   19.034182]  __up_console_sem+0x32/0x60
[   19.034182]  console_unlock+0x346/0x5c0
[   19.034182]  vprintk_emit+0x1d1/0x2f0
[   19.034183]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034183]  vprintk_default+0x1f/0x30
[   19.034183]  vprintk_func+0x51/0xf0
[   19.034184]  ? rcu_nmi_exit+0x12a/0x260
[   19.034184]  printk+0x52/0x6e
[   19.034184]  ? kernel_text_address+0x96/0xf0
[   19.034185]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034185]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034185]  show_trace_log_lvl+0x32f/0x3b0
[   19.034186]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034186]  show_stack+0x30/0x40
[   19.034186]  dump_stack+0x7d/0x9f
[   19.034186]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034187]  switch_mm_irqs_off+0x441/0x450
[   19.034187]  switch_mm+0x1b/0x50
[   19.034187]  leave_mm+0x34/0x40
[   19.034188]  acpi_idle_enter_bm+0x23/0x120
[   19.034188]  acpi_idle_enter+0x189/0x2a0
[   19.034188]  ? rcu_eqs_enter.constprop.85+0xb2/0x180
[   19.034189]  cpuidle_enter_state+0xa5/0x4b0
[   19.034189]  cpuidle_enter+0x2e/0x40
[   19.034189]  do_idle+0x226/0x2b0
[   19.034190]  cpu_startup_entry+0x1d/0x20
[   19.034190]  start_secondary+0x114/0x150
[   19.034190]  secondary_startup_64+0xb6/0xc0
[   19.034191]
[   19.034191] =============================
[   19.034191] WARNING: suspicious RCU usage
[   19.034192] 5.9.0-rc4-next-20200908 #1 Not tainted
[   19.034192] -----------------------------
[   19.034192] /usr/src/kernel/include/linux/rcupdate.h:643
rcu_read_lock() used illegally while idle!
[   19.034193]
[   19.034193] other info that might help us debug this:
[   19.034193]
[   19.034194]
[   19.034194] rcu_scheduler_active = 2, debug_locks = 1
[   19.034194] RCU used illegally from extended quiescent state!
[   19.034195] 3 locks held by swapper/2/0:
[   19.034195]  #0: ffffffffbed25ff8 ((console_sem).lock){-...}-{2:2},
at: up+0x16/0x50
[   19.034196]  #1: ffff90dbeea90800 (&p->pi_lock){-.-.}-{2:2}, at:
try_to_wake_up+0x52/0x7a0
[   19.034198]  #2: ffffffffbed28580 (rcu_read_lock){....}-{1:2}, at:
select_task_rq_fair+0xd0/0x10a0
[   19.034199]
[   19.034200] stack backtrace:
[   19.034200] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.9.0-rc4-next-20200908 #1
[   19.034201] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   19.034201] Call Trace:
[   19.034201]  dump_stack+0x7d/0x9f
[   19.034202]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034202]  select_task_rq_fair+0x4aa/0x10a0
[   19.034202]  ? show_stack+0x30/0x40
[   19.034203]  try_to_wake_up+0x181/0x7a0
[   19.034203]  ? find_held_lock+0x35/0xa0
[   19.034203]  wake_up_process+0x15/0x20
[   19.034203]  __up.isra.4+0x39/0x40
[   19.034204]  up+0x46/0x50
[   19.034204]  __up_console_sem+0x32/0x60
[   19.034204]  console_unlock+0x346/0x5c0
[   19.034205]  vprintk_emit+0x1d1/0x2f0
[   19.034205]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034205]  vprintk_default+0x1f/0x30
[   19.034206]  vprintk_func+0x51/0xf0
[   19.034206]  ? rcu_nmi_exit+0x12a/0x260
[   19.034206]  printk+0x52/0x6e
[   19.034207]  ? kernel_text_address+0x96/0xf0
[   19.034207]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034207]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034208]  show_trace_log_lvl+0x32f/0x3b0
[   19.034208]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034208]  show_stack+0x30/0x40
[   19.034209]  dump_stack+0x7d/0x9f
[   19.034209]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034209]  switch_mm_irqs_off+0x441/0x450
[   19.034210]  switch_mm+0x1b/0x50
[   19.034210]  leave_mm+0x34/0x40
[   19.034210]  acpi_idle_enter_bm+0x23/0x120
[   19.034211]  acpi_idle_enter+0x189/0x2a0
[   19.034211]  ? rcu_eqs_enter.constprop.85+0xb2/0x180
[   19.034211]  cpuidle_enter_state+0xa5/0x4b0
[   19.034212]  cpuidle_enter+0x2e/0x40
[   19.034212]  do_idle+0x226/0x2b0
[   19.034212]  cpu_startup_entry+0x1d/0x20
[   19.034213]  start_secondary+0x114/0x150
[   19.034213]  secondary_startup_64+0xb6/0xc0
[   19.034213]
[   19.034214] =============================
[   19.034214] WARNING: suspicious RCU usage
[   19.034214] 5.9.0-rc4-next-20200908 #1 Not tainted
[   19.034215] -----------------------------
[   19.034215] /usr/src/kernel/kernel/sched/fair.c:6694 suspicious
rcu_dereference_check() usage!
[   19.034215]
[   19.034216] other info that might help us debug this:
[   19.034216]
[   19.034216]
[   19.034217] rcu_scheduler_active = 2, debug_locks = 1
[   19.034217] RCU used illegally from extended quiescent state!
[   19.034217] 3 locks held by swapper/2/0:
[   19.034217]  #0: ffffffffbed25ff8 ((console_sem).lock){-...}-{2:2},
at: up+0x16/0x50
[   19.034219]  #1: ffff90dbeea90800 (&p->pi_lock){-.-.}-{2:2}, at:
try_to_wake_up+0x52/0x7a0
[   19.034220]  #2: ffffffffbed28580 (rcu_read_lock){....}-{1:2}, at:
select_task_rq_fair+0xd0/0x10a0
[   19.034222]
[   19.034222] stack backtrace:
[   19.034223] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.9.0-rc4-next-20200908 #1
[   19.034223] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   19.034223] Call Trace:
[   19.034224]  dump_stack+0x7d/0x9f
[   19.034224]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034224]  select_task_rq_fair+0x448/0x10a0
[   19.034225]  ? show_stack+0x30/0x40
[   19.034225]  try_to_wake_up+0x181/0x7a0
[   19.034225]  ? find_held_lock+0x35/0xa0
[   19.034226]  wake_up_process+0x15/0x20
[   19.034226]  __up.isra.4+0x39/0x40
[   19.034226]  up+0x46/0x50
[   19.034227]  __up_console_sem+0x32/0x60
[   19.034227]  console_unlock+0x346/0x5c0
[   19.034227]  vprintk_emit+0x1d1/0x2f0
[   19.034228]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034228]  vprintk_default+0x1f/0x30
[   19.034228]  vprintk_func+0x51/0xf0
[   19.034228]  ? rcu_nmi_exit+0x12a/0x260
[   19.034229]  printk+0x52/0x6e
[   19.034229]  ? kernel_text_address+0x96/0xf0
[   19.034229]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034230]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034230]  show_trace_log_lvl+0x32f/0x3b0
[   19.034230]  ? cpuidle_enter_state+0xa5/0x4b0
[   19.034231]  show_stack+0x30/0x40
[   19.034231]  dump_stack+0x7d/0x9f
[   19.034231]  lockdep_rcu_suspicious+0xce/0xf0
[   19.034232]  switch_mm_irqs_off+0x441/0x450
[   19.034232]  switch_mm+0x1b/0x50
[   19.034232]  leave_mm+0x34/0x40
[   19.034233]  acpi_idle_enter_bm+0x23/0x120
[   19.034233]  acpi_idle_enter+0x189/0x2a0
[   19.034233]  ? rcu_eqs_enter.constprop.85+0xb2/0x180
[   19.034234]  cpuidle_enter_state+0xa5/0x4b0
[   19.034234]  cpuidle_enter+0x2e/0x40
[   19.034234]  do_idle+0x226/0x2b0
[   19.034235]  cpu_startup_entry+0x1d/0x20
[   19.034235]  start_secondary+0x114/0x150
[   19.034235]  secondary_startup_64+0xb6/0xc0

Full test log,

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200908/testrun/3171064/suite/linux-log-parser/test/check-kernel-bug-1743477/log


-- 
Linaro LKFT
https://lkft.linaro.org

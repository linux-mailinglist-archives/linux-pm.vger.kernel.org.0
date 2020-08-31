Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9E2573B9
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgHaGcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 02:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaGco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 02:32:44 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC308C061575
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2020 23:32:43 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id v138so2640191vsv.7
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2020 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JL5FY/OPoxC6HDWJYlv4yemjpNN92vvIN4CMSxtN6co=;
        b=cMuyRTSxyhExkZY0IKNSWlVvO8PuH5Ok63c4pQ9nutHuvq2NWmeGFZJRG1IDHzqY8Q
         cIZwp2JhXWSUOq9UojMJbh+mQk+yzS31Vc23awkX6gzCudYOuf6XYs4UgNnH8S1DzvEY
         JWZ5xdwn/SRpSX9QhihOqPOXU5UBEItfwrSuL8nsYby9QjLXgzxdNBPiMnoMMqxinIt8
         f2aZ8fGRQqOG4lprhboGisuN+ZPhkiHTi2In5WeKxBRsfdDnwybgFMFWcNF8W476CJky
         qX2XGIpLab2UOus7H6JYxviic+Dp12HREV7rndufZMvTSyj1yGME0SzW19qdzw2jWbJ5
         hTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JL5FY/OPoxC6HDWJYlv4yemjpNN92vvIN4CMSxtN6co=;
        b=pwrTMnbFhVKSMG6uGn8qOn/DQCfULNK6sO/ezKSxDxphE637A0Kzn1rsNQt8GjN/yO
         gweH7/wFCMETEHkhX96xpF3MpPpHvWrMydXF085zKpFyjYkiMnPdsCINZxBS1ObUFqo3
         I2DRspNbdFyIdh33Nz8bDlGsOnu4T8rCZ02I2YBVIjLBI6GQCtb5iDv/s/uQ+pAxl4qU
         NTkk6un2eKDfKMM9IxgLEk+1hRSuVhSHIECIkzuY5rZYtpCGt59i1QX+9PXcXBfF5r9R
         C3V5t05J5WfMJ+yBLrztTX2BBjXpkBkGKiIPW9+yRxYdbaRr2XOpfU8LNYQH3uP+kZip
         lSHQ==
X-Gm-Message-State: AOAM531ww6+L1Eunz42RESFZsFQ/Pg/Nnizb4pECw0Uw4kV20xzigZCg
        eY63qEMqjpIY0HV4qi6F2haEmW9aevSPI15dwlr21g==
X-Google-Smtp-Source: ABdhPJzOO76mzWnFTJKnD/SXT05L8mq2/oW90RWTXbauVOOkxUkgcAw1KvyWdnOAxbqvkf4WnYp37Ns7eHcYcwoOJXg=
X-Received: by 2002:a67:7905:: with SMTP id u5mr41080vsc.179.1598855562545;
 Sun, 30 Aug 2020 23:32:42 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 31 Aug 2020 12:02:31 +0530
Message-ID: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
Subject: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and OF
 driver helper
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While booting linux mainline kernel on arm64 db410c this kernel warning
noticed.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
  git describe: v5.9-rc3
  make_kernelversion: 5.9.0-rc3
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-mainline/2965/config

Boot log,

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
[    0.000000] Linux version 5.9.0-rc3 (oe-user@oe-host)
(aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils)
2.30.0.20180208) #1 SMP PREEMPT Mon Aug 31 00:23:15 UTC 2020
[    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
<>
[    5.299090] sdhci: Secure Digital Host Controller Interface driver
[    5.299140] sdhci: Copyright(c) Pierre Ossman
[    5.304313]
[    5.307771] Synopsys Designware Multimedia Card Interface Driver
[    5.308588] =============================
[    5.308593] WARNING: suspicious RCU usage
[    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.320052] 5.9.0-rc3 #1 Not tainted
[    5.320057] -----------------------------
[    5.320063] /usr/src/kernel/include/trace/events/lock.h:37
suspicious rcu_dereference_check() usage!
[    5.320068]
[    5.320068] other info that might help us debug this:
[    5.320068]
[    5.320074]
[    5.320074] rcu_scheduler_active = 2, debug_locks = 1
[    5.320078] RCU used illegally from extended quiescent state!
[    5.320084] no locks held by swapper/0/0.
[    5.320089]
[    5.320089] stack backtrace:
[    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
[    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.346452] Call trace:
[    5.346463]  dump_backtrace+0x0/0x1f8
[    5.346471]  show_stack+0x2c/0x38
[    5.346480]  dump_stack+0xec/0x15c
[    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
[    5.346499]  lock_acquire+0x3d0/0x440
[    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
[    5.413118]  __pm_runtime_suspend+0x34/0x1d0
[    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
[    5.421795]  cpuidle_enter_state+0xc8/0x610
[    5.426392]  cpuidle_enter+0x3c/0x50
[    5.430561]  call_cpuidle+0x44/0x80
[    5.434378]  do_idle+0x240/0x2a0
[    5.437589]  cpu_startup_entry+0x2c/0x78
[    5.441063]  rest_init+0x1ac/0x280
[    5.444970]  arch_call_rest_init+0x14/0x1c
[    5.448180]  start_kernel+0x50c/0x544
[    5.452395]
[    5.452399]
[    5.452403] =============================
[    5.452406] WARNING: suspicious RCU usage
[    5.452409] 5.9.0-rc3 #1 Not tainted
[    5.452412] -----------------------------
[    5.452417] /usr/src/kernel/include/trace/events/ipi.h:36
suspicious rcu_dereference_check() usage!
[    5.452420]
[    5.452424] other info that might help us debug this:
[    5.452426]
[    5.452429]
[    5.452432] rcu_scheduler_active = 2, debug_locks = 1
[    5.452436] RCU used illegally from extended quiescent state!
[    5.452440] 1 lock held by swapper/0/0:
[    5.452443]  #0: ffff8000127408f8 (logbuf_lock){-...}-{2:2}, at:
vprintk_emit+0xb0/0x358
[    5.452458]
[    5.452461] stack backtrace:
[    5.452465] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[    5.452469] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.452472] Call trace:
[    5.452476]  dump_backtrace+0x0/0x1f8
[    5.452479]  show_stack+0x2c/0x38
[    5.452481]  dump_stack+0xec/0x15c
[    5.452485]  lockdep_rcu_suspicious+0xd4/0xf8
[    5.452489]  arch_irq_work_raise+0x208/0x210
[    5.452493]  __irq_work_queue_local+0x64/0x88
[    5.452495]  irq_work_queue+0x3c/0x88
[    5.452499]  printk_safe_log_store+0x148/0x178
[    5.452502]  vprintk_func+0x1cc/0x2b8
[    5.452506]  printk+0x74/0x94
[    5.452509]  lockdep_rcu_suspicious+0x28/0xf8
[    5.452512]  lock_release+0x338/0x360
[    5.452516]  _raw_spin_unlock+0x3c/0xa0
[    5.452519]  vprintk_emit+0xf8/0x358
[    5.452522]  vprintk_default+0x48/0x58
[    5.452526]  vprintk_func+0xec/0x2b8
[    5.452528]  printk+0x74/0x94
[    5.452532]  lockdep_rcu_suspicious+0x28/0xf8
[    5.452535]  lock_acquire+0x3d0/0x440
[    5.452538]  _raw_spin_lock_irqsave+0x80/0xb0
[    5.452542]  __pm_runtime_suspend+0x34/0x1d0
[    5.452545]  psci_enter_domain_idle_state+0x4c/0xb0
[    5.452549]  cpuidle_enter_state+0xc8/0x610
[    5.452552]  cpuidle_enter+0x3c/0x50
[    5.452555]  call_cpuidle+0x44/0x80
[    5.452559]  do_idle+0x240/0x2a0
[    5.452562]  cpu_startup_entry+0x2c/0x78
[    5.452564]  rest_init+0x1ac/0x280
[    5.452568]  arch_call_rest_init+0x14/0x1c
[    5.452571]  start_kernel+0x50c/0x544
[    5.452575] =============================
[    5.452578] WARNING: suspicious RCU usage
[    5.452582] 5.9.0-rc3 #1 Not tainted
[    5.452585] -----------------------------
[    5.452590] /usr/src/kernel/include/trace/events/lock.h:63
suspicious rcu_dereference_check() usage!
[    5.452593]
[    5.452596] other info that might help us debug this:
[    5.452599]
[    5.452601]
[    5.452605] rcu_scheduler_active = 2, debug_locks = 1
[    5.452609] RCU used illegally from extended quiescent state!
[    5.452612] 1 lock held by swapper/0/0:
[    5.452615]  #0: ffff8000127408f8 (logbuf_lock){-...}-{2:2}, at:
vprintk_emit+0xb0/0x358
[    5.452630]
[    5.452633] stack backtrace:
[    5.452636] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[    5.452640] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.452643] Call trace:
[    5.452646]  dump_backtrace+0x0/0x1f8
[    5.452649]  show_stack+0x2c/0x38
[    5.452652]  dump_stack+0xec/0x15c
[    5.452656]  lockdep_rcu_suspicious+0xd4/0xf8
[    5.452659]  lock_release+0x338/0x360
[    5.452662]  _raw_spin_unlock+0x3c/0xa0
[    5.452665]  vprintk_emit+0xf8/0x358
[    5.452669]  vprintk_default+0x48/0x58
[    5.452671]  vprintk_func+0xec/0x2b8
[    5.452674]  printk+0x74/0x94
[    5.452677]  lockdep_rcu_suspicious+0x28/0xf8
[    5.452680]  lock_acquire+0x3d0/0x440
[    5.452683]  _raw_spin_lock_irqsave+0x80/0xb0
[    5.452686]  __pm_runtime_suspend+0x34/0x1d0
[    5.452690]  psci_enter_domain_idle_state+0x4c/0xb0
[    5.452693]  cpuidle_enter_state+0xc8/0x610
[    5.452696]  cpuidle_enter+0x3c/0x50
[    5.452698]  call_cpuidle+0x44/0x80
[    5.452701]  do_idle+0x240/0x2a0
[    5.452704]  cpu_startup_entry+0x2c/0x78
[    5.452708]  rest_init+0x1ac/0x280
[    5.452711]  arch_call_rest_init+0x14/0x1c
[    5.452714]  start_kernel+0x50c/0x544

full test log link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.9-rc3/testrun/3137660/suite/linux-log-parser/test/check-kernel-warning-1722813/log

-- 
Linaro LKFT
https://lkft.linaro.org

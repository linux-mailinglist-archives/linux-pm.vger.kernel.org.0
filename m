Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D7225DB19
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgIDONL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 10:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbgIDONE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Sep 2020 10:13:04 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5070C206B8;
        Fri,  4 Sep 2020 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599228784;
        bh=WAsv6uOhSS1yjFzNPPN4FXPLfp8p89wDOAzZfbA6WBg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=v464VGCEopb+8UUAa0eMQCerBcbWJC6TFJ0zOTrhSwo+hSYIpxG62ltAjI5sHgJX8
         RteukzG8H/bs/B/qVxRkHStEwhiOpZkj9ecApej7X9OapCMMxjQzT4NEspyHostzQu
         WqfoV26SsKrroqeK/VLTWEqqVCzu87o6+FBjwR34=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 338A8352118D; Fri,  4 Sep 2020 07:13:04 -0700 (PDT)
Date:   Fri, 4 Sep 2020 07:13:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] cpuidle: psci: Fix suspicious RCU usage
Message-ID: <20200904141304.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200904064705.239614-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904064705.239614-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 04, 2020 at 08:47:05AM +0200, Ulf Hansson wrote:
> The commit eb1f00237aca ("lockdep,trace: Expose tracepoints"), started to
> expose us for tracepoints. This lead to the following RCU splat on an ARM64
> Qcom board.
> 
> [    5.529634] WARNING: suspicious RCU usage
> [    5.537307] sdhci-pltfm: SDHCI platform and OF driver helper
> [    5.541092] 5.9.0-rc3 #86 Not tainted
> [    5.541098] -----------------------------
> [    5.541105] ../include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
> [    5.541110]
> [    5.541110] other info that might help us debug this:
> [    5.541110]
> [    5.541116]
> [    5.541116] rcu_scheduler_active = 2, debug_locks = 1
> [    5.541122] RCU used illegally from extended quiescent state!
> [    5.541129] no locks held by swapper/0/0.
> [    5.541134]
> [    5.541134] stack backtrace:
> [    5.541143] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #86
> [    5.541149] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    5.541157] Call trace:
> [    5.568185] sdhci_msm 7864900.sdhci: Got CD GPIO
> [    5.574186]  dump_backtrace+0x0/0x1c8
> [    5.574206]  show_stack+0x14/0x20
> [    5.574229]  dump_stack+0xe8/0x154
> [    5.574250]  lockdep_rcu_suspicious+0xd4/0xf8
> [    5.574269]  lock_acquire+0x3f0/0x460
> [    5.574292]  _raw_spin_lock_irqsave+0x80/0xb0
> [    5.574314]  __pm_runtime_suspend+0x4c/0x188
> [    5.574341]  psci_enter_domain_idle_state+0x40/0xa0
> [    5.574362]  cpuidle_enter_state+0xc0/0x610
> [    5.646487]  cpuidle_enter+0x38/0x50
> [    5.650651]  call_cpuidle+0x18/0x40
> [    5.654467]  do_idle+0x228/0x278
> [    5.657678]  cpu_startup_entry+0x24/0x70
> [    5.661153]  rest_init+0x1a4/0x278
> [    5.665061]  arch_call_rest_init+0xc/0x14
> [    5.668272]  start_kernel+0x508/0x540
> 
> Following the path in pm_runtime_put_sync_suspend() from
> psci_enter_domain_idle_state(), it seems like we end up using the RCU.
> Therefore, let's simply silence the splat by informing the RCU about it
> with RCU_NONIDLE.
> 
> Note that, this is a temporary solution. Instead we should strive to avoid
> using RCU_NONIDLE (and similar), but rather push rcu_idle_enter|exit()
> further down, closer to the arch specific code. However, as the CPU PM
> notifiers are also using the RCU, additional rework is needed.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 74463841805f..d928b37718bd 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -66,7 +66,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  		return -1;
>  
>  	/* Do runtime PM to manage a hierarchical CPU toplogy. */
> -	pm_runtime_put_sync_suspend(pd_dev);
> +	RCU_NONIDLE(pm_runtime_put_sync_suspend(pd_dev));
>  
>  	state = psci_get_domain_state();
>  	if (!state)
> @@ -74,7 +74,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  
>  	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>  
> -	pm_runtime_get_sync(pd_dev);
> +	RCU_NONIDLE(pm_runtime_get_sync(pd_dev));
>  
>  	cpu_pm_exit();
>  
> -- 
> 2.25.1
> 

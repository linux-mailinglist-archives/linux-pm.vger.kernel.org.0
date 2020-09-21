Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3506827266D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgIUN74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 09:59:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37583 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgIUN7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 09:59:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id a3so17076350oib.4
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 06:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJbeS7CDTADmNzympMlsMFgP+fTyW3RDXL6Bvuab7Xk=;
        b=RPyc9WiOUIWlVDwgHqWKQ0rWxcGRSbRLAGueNlOrgpFVurkGYqhrfLIY71FuiDj93g
         4ZMuke+3WZ9wwnZiRYoO4PmHboN4BytzJ3vg9BjJi8mokw8idBcCZnO0wL2Gd8xdCtXe
         r5ZHXupTzebOSXpyW4jVqYHHFlM82uAQnQw/3JVtpcPlZPozrz9GfAreC1ZApa13QoTc
         WIB0mMM0YmlDUkOYBE6mwEogEmQmPy80cS/W3Y8V2BjtbRa+d6MnslTx/32kAM/sxxWP
         KViSmx+NxwzuTUU/4Mo2CkCHoiuBFrV4xeGWLCUxX8XImY34+UoWBHBwhC7hLJ0cjU7K
         OZXQ==
X-Gm-Message-State: AOAM531Yg/M9/ryeXW9Wywhav3d7mcUfmj6p84XeIdNW05osAyQeWcdx
        H1WurY4R7ViwoPgTtfmc9Xz0K96Ed0bak8K3id0=
X-Google-Smtp-Source: ABdhPJxbI7kmcRwuEuYjGHgyPhxqh62g9oPaW/dmUMon5mBxTQjKdqnG7EJCCAAvkzRrGrxoWwvumB/QGTUNa641W/w=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr5978oid.110.1600696794727;
 Mon, 21 Sep 2020 06:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200904064705.239614-1-ulf.hansson@linaro.org>
In-Reply-To: <20200904064705.239614-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 15:59:39 +0200
Message-ID: <CAJZ5v0heKJ-n_21hQ=eLrF9=+m6rz2rk1xGo9j84fEJerjKV=A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix suspicious RCU usage
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 4, 2020 at 8:47 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
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

I missed this one before, sorry about that.

Now applied as 5.9-rc6 material with the Paul's ACK, thanks!

> ---
>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 74463841805f..d928b37718bd 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -66,7 +66,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>                 return -1;
>
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
> -       pm_runtime_put_sync_suspend(pd_dev);
> +       RCU_NONIDLE(pm_runtime_put_sync_suspend(pd_dev));
>
>         state = psci_get_domain_state();
>         if (!state)
> @@ -74,7 +74,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>
>         ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>
> -       pm_runtime_get_sync(pd_dev);
> +       RCU_NONIDLE(pm_runtime_get_sync(pd_dev));
>
>         cpu_pm_exit();
>
> --
> 2.25.1
>

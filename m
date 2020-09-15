Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78626AF8A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIOV0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgIOVUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:20:35 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F162C061A27
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:17:58 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id c63so1195307vkb.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQ8NIm9Qkb4NV+7oBXD58GntPZaDX84Tgi/HUvr4KWE=;
        b=kaC1Zpx25qz1YGaeXqTlqflGPbCKSjZGL7oZAOsU0vnXIeygiU3ExOmAYMMWSCg6mk
         9TFYcnt8mfsWfleBPCV8Vp5pH7LxC+ZqC8f1muh+3Oq///bwakE2FQ/WyPI0qJZzcdIq
         hNhZY9y0x3Zl86M6zkoaS/l/c8tIca2kgHg5kaSOfbEYdfuCUlvUZ2AZtsK/RnYO1DqL
         lu4R1/Izr6ohSQho9hEkM5GwhY7tnJdsAiWblxWDWwj/mi5zARdKt/EoqpZZNYfRuss/
         hrf2TZblCgwT3a7rZDZ7cSmJM5QoUkVjtN10JiUVrkN52eadMv+fAs4N5cq7+kvUV2vz
         7m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQ8NIm9Qkb4NV+7oBXD58GntPZaDX84Tgi/HUvr4KWE=;
        b=cjVZjk5sTjQIiKM/6eKjk5m5fq1Ua+2GOUiFAzUh+WsNJ+Nwq0jRei07oyKTBUHV8m
         iPf1cCUn19VhAkp0dws2KDiJ7pEISJwD/OVOwG3Jw8GeImnYHk0zeSydyZDFsROZBrIi
         ESOvk2diH1E7OxnS1zRDCLSexWPQXjXjB84F/SR/sk3V73j96BmLQKQXlzdXU5if/z8y
         9RIADL8EOTHet8YEjFwGMpUAtyhbmV/XfZCOiNdeuAKBA0qet4IrtCGIlmcuPT4wYZSN
         hIvYFwGcDn/1n/54G+Xrz+nfbu6p+Z95/YbzaxVVjgWhdtGdcjoLQD854qzWleWjVD8J
         L7/w==
X-Gm-Message-State: AOAM532yOYg1mVFWXEckuzV9+317qEB1APAijrZFW+hwXYSHZD7BZR7z
        VY/tZzaeD0uZ0nJiJU8juiOTyeKI6Bl1QVlDTCNevw==
X-Google-Smtp-Source: ABdhPJzkqxjHAFBg3k5jzAdEV2hx1PnwR6GdaGFX3KsznlldhbbRXvFa9InxJnqBc6ToY0LSWqSIEQ0M54iWoHBVpsQ=
X-Received: by 2002:a1f:6ec4:: with SMTP id j187mr2910363vkc.15.1600204677519;
 Tue, 15 Sep 2020 14:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200904064705.239614-1-ulf.hansson@linaro.org> <20200904141304.GE29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200904141304.GE29330@paulmck-ThinkPad-P72>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Sep 2020 23:17:20 +0200
Message-ID: <CAPDyKFrgs+EGZQr_cqWiq_7v1qDi3WBWQpmZFPwu034Y5a8M1Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix suspicious RCU usage
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 4 Sep 2020 at 16:13, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Sep 04, 2020 at 08:47:05AM +0200, Ulf Hansson wrote:
> > The commit eb1f00237aca ("lockdep,trace: Expose tracepoints"), started to
> > expose us for tracepoints. This lead to the following RCU splat on an ARM64
> > Qcom board.
> >
> > [    5.529634] WARNING: suspicious RCU usage
> > [    5.537307] sdhci-pltfm: SDHCI platform and OF driver helper
> > [    5.541092] 5.9.0-rc3 #86 Not tainted
> > [    5.541098] -----------------------------
> > [    5.541105] ../include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
> > [    5.541110]
> > [    5.541110] other info that might help us debug this:
> > [    5.541110]
> > [    5.541116]
> > [    5.541116] rcu_scheduler_active = 2, debug_locks = 1
> > [    5.541122] RCU used illegally from extended quiescent state!
> > [    5.541129] no locks held by swapper/0/0.
> > [    5.541134]
> > [    5.541134] stack backtrace:
> > [    5.541143] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #86
> > [    5.541149] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    5.541157] Call trace:
> > [    5.568185] sdhci_msm 7864900.sdhci: Got CD GPIO
> > [    5.574186]  dump_backtrace+0x0/0x1c8
> > [    5.574206]  show_stack+0x14/0x20
> > [    5.574229]  dump_stack+0xe8/0x154
> > [    5.574250]  lockdep_rcu_suspicious+0xd4/0xf8
> > [    5.574269]  lock_acquire+0x3f0/0x460
> > [    5.574292]  _raw_spin_lock_irqsave+0x80/0xb0
> > [    5.574314]  __pm_runtime_suspend+0x4c/0x188
> > [    5.574341]  psci_enter_domain_idle_state+0x40/0xa0
> > [    5.574362]  cpuidle_enter_state+0xc0/0x610
> > [    5.646487]  cpuidle_enter+0x38/0x50
> > [    5.650651]  call_cpuidle+0x18/0x40
> > [    5.654467]  do_idle+0x228/0x278
> > [    5.657678]  cpu_startup_entry+0x24/0x70
> > [    5.661153]  rest_init+0x1a4/0x278
> > [    5.665061]  arch_call_rest_init+0xc/0x14
> > [    5.668272]  start_kernel+0x508/0x540
> >
> > Following the path in pm_runtime_put_sync_suspend() from
> > psci_enter_domain_idle_state(), it seems like we end up using the RCU.
> > Therefore, let's simply silence the splat by informing the RCU about it
> > with RCU_NONIDLE.
> >
> > Note that, this is a temporary solution. Instead we should strive to avoid
> > using RCU_NONIDLE (and similar), but rather push rcu_idle_enter|exit()
> > further down, closer to the arch specific code. However, as the CPU PM
> > notifiers are also using the RCU, additional rework is needed.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Peter, Rafael,

Is $subject patch okay as the short term solution? If so, I can
continue to look at the CPU PM notifiers, etc.

Kind regards
Uffe

>
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 74463841805f..d928b37718bd 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -66,7 +66,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >               return -1;
> >
> >       /* Do runtime PM to manage a hierarchical CPU toplogy. */
> > -     pm_runtime_put_sync_suspend(pd_dev);
> > +     RCU_NONIDLE(pm_runtime_put_sync_suspend(pd_dev));
> >
> >       state = psci_get_domain_state();
> >       if (!state)
> > @@ -74,7 +74,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >
> >       ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> >
> > -     pm_runtime_get_sync(pd_dev);
> > +     RCU_NONIDLE(pm_runtime_get_sync(pd_dev));
> >
> >       cpu_pm_exit();
> >
> > --
> > 2.25.1
> >

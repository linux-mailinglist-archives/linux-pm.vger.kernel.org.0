Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E59F258E48
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIAMhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgIAMga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 08:36:30 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC9C061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 05:36:29 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id c25so290659vkm.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIq7XVpK3n6IBrRKcWvFGTeHUzpcAgzGWVIVAICj3Vw=;
        b=yk/K5bvkVu6dpLU+EByoft625JzFjIlUFkj77MwfRCan3R8sS+dMvuUbzn6rywTJGs
         iffFySQOWlRfGKtOa4kVQHY1P74S00plVslJTmkbEN+8Kx2A0n/6+MbpmDdab3yp5QH4
         fSSgnVv8M1wOx0tigIzAf5yDDIm8Q8vXngOgq/IUbIOu0wR1zqUztmJxsAkI+gSq91rN
         1lTJLBnRdnRWCeYPGVKOSB4iAvjK8jDB30lI1nVq0EMJ5nf2h0aFj817QIkeeN7uBCo/
         IQjUZPPR6Wp9zCr/SUbsu+stAhgACz5wlQgb0EKpQu2iuo+rUiPBo6HcwxHaL5ptRzL8
         9ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIq7XVpK3n6IBrRKcWvFGTeHUzpcAgzGWVIVAICj3Vw=;
        b=HALWYrHFFThRzHdNEcvfFJ+pj3EzFibK1NjiEPWAVtz2n6OICndPkrpPaBtO4mrwSC
         o90ZLwU8U/5u/fP/niRd0lY3l9gm5E7QKAw+bnT+FIwUQyBOQFt+QXyRt01aWsdRPI5D
         4oMm4QYCNn9BSjhL7oGPlrIPkz8T3ldK7sUjVoceg4Gk1qQRv0222LuyD2Zah5llz3wA
         WtHvuSPJ7TN8/uTzUK39ip4LpBQsDfAsEqEwJBMa2gR0IC7j/+PU7QICLBPcj/tGfrM6
         3CYbJ0wUUstpnbXBto9NktDSWMVOGL2ZrtUgxXRjlayt2uZpgDxIhdBtUXkWG7pfN9xW
         JYAw==
X-Gm-Message-State: AOAM531amzaWMsDdjLGyWDA8DcoocI5GXfs5C9IEel8RKllgnJAYnZ/I
        Zm1VVuOIi32TK2g9kxzjNLZvp7ZAk9HrjckHqKlzNg==
X-Google-Smtp-Source: ABdhPJwgDqe0N+qK4Dxfh8JARoblxSy7BIomJtM3LlAM2rhyqVXOSEqkoHbXjfzB2zezVXHyj84O0k/kJJV4+UFhw5s=
X-Received: by 2002:a1f:4392:: with SMTP id q140mr1012387vka.0.1598963788944;
 Tue, 01 Sep 2020 05:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72> <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com> <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 14:35:52 +0200
Message-ID: <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     paulmck@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        open list <linux-kernel@vger.kernel.org>,
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
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Sep 2020 at 12:42, <peterz@infradead.org> wrote:
>
> On Tue, Sep 01, 2020 at 08:50:57AM +0200, Ulf Hansson wrote:
> > On Tue, 1 Sep 2020 at 08:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Mon, 31 Aug 2020 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > > > > [    5.308588] =============================
> > > > > [    5.308593] WARNING: suspicious RCU usage
> > > > > [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
> > > > > [    5.320052] 5.9.0-rc3 #1 Not tainted
> > > > > [    5.320057] -----------------------------
> > > > > [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
> > > > > [    5.320068]
> > > > > [    5.320068] other info that might help us debug this:
> > > > > [    5.320068]
> > > > > [    5.320074]
> > > > > [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
> > > > > [    5.320078] RCU used illegally from extended quiescent state!
> > > > > [    5.320084] no locks held by swapper/0/0.
> > > > > [    5.320089]
> > > > > [    5.320089] stack backtrace:
> > > > > [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> > > > > [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
> > > > > [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > > > [    5.346452] Call trace:
> > > > > [    5.346463]  dump_backtrace+0x0/0x1f8
> > > > > [    5.346471]  show_stack+0x2c/0x38
> > > > > [    5.346480]  dump_stack+0xec/0x15c
> > > > > [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
> > > > > [    5.346499]  lock_acquire+0x3d0/0x440
> > > > > [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
> > > > > [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
> > > > > [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
> > > > > [    5.421795]  cpuidle_enter_state+0xc8/0x610
> > > > > [    5.426392]  cpuidle_enter+0x3c/0x50
> > > > > [    5.430561]  call_cpuidle+0x44/0x80
> > > > > [    5.434378]  do_idle+0x240/0x2a0
>
> > > > Note also that Peter Zijlstra (CCed) is working to shrink the portion
> > > > of the idle loop that RCU ignores.  Not sure that it covers your
> > > > case, but it is worth checking.
>
> Right, so I think I 'caused' this by making the lock tracepoints
> visible. That is, the error always existed, now we actually warn about
> it.
>
> > > Thanks for letting me know. Let's see what Peter thinks about this then.
> > >
> > > Apologize for my ignorance, but from a cpuidle point of view, what
> > > does it mean using RCU_NONIDLE()? I guess we should avoid RCU_NONIDLE
> > > on bigger code paths?
> > >
> > > I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> > > and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> > > that's the easiest approach, at least to start with.
> > >
> > > Or do you have any other ideas?
>
> So IMO trace_*_rcuidle() and RCU_NONIDLE() are bugs, they just mean we
> got the ordering wrong and are papering over it. That said, that's been
> the modus operandi for a while now, just make it shut up and don't think
> about it :-/
>
> That said; I pushed the rcu_idle_enter() about as deep as it goes into
> generic code in commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
> deeper into the idle path")

Aha, that commit should fix this problem, I think. Looks like that
commit was sent as a fix and included in the recent v5.9-rc3.

Naresh, can you try with the above commit?

>
> I suppose the next step is pushing it into individual driver when
> needed, something like the below perhaps. I realize the coupled idle
> state stuff is more complicated that most, but it's also not an area
> I've looked at in detail, so perhaps I've just made a bigger mess, but
> it ought to give you enough to get going I think.

These aren't coupled states. Instead, in cpuidle-psci, we are using PM
domains through genpd and runtime PM to manage "shared idle states"
between CPUs.

Kind regards
Uffe

>
> Rafael?
>
> ---
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 74463841805f..617bbef316e6 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -49,6 +49,9 @@ static inline u32 psci_get_domain_state(void)
>
>  static inline int psci_enter_state(int idx, u32 state)
>  {
> +       /*
> +        * XXX push rcu_idle_enter into the coupled code
> +        */
>         return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
>  }
>
> @@ -72,7 +75,9 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>         if (!state)
>                 state = states[idx];
>
> +       rcu_idle_enter();
>         ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> +       rcu_idle_exit();
>
>         pm_runtime_get_sync(pd_dev);
>
> @@ -125,8 +130,13 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
>                                 struct cpuidle_driver *drv, int idx)
>  {
>         u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
> +       int ret;
>
> -       return psci_enter_state(idx, state[idx]);
> +       rcu_idle_enter();
> +       ret = psci_enter_state(idx, state[idx]);
> +       rcu_idle_exit();
> +
> +       return ret;
>  }
>
>  static const struct of_device_id psci_idle_state_match[] = {
> @@ -170,6 +180,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>          * deeper states.
>          */
>         drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
> +       drv->states[state_count - 1].flags = CPUIDLE_FLAG_RCU_IDLE;
>         psci_cpuidle_use_cpuhp = true;
>
>         return 0;
> @@ -285,6 +296,7 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>          * state index 0.
>          */
>         drv->states[0].enter = psci_enter_idle_state;
> +       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
>         drv->states[0].power_usage = UINT_MAX;
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 04becd70cc41..3dbac3bb761b 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -239,9 +239,11 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         time_start = ns_to_ktime(local_clock());
>
>         stop_critical_timings();
> -       rcu_idle_enter();
> +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> +               rcu_idle_enter();
>         entered_state = target_state->enter(dev, drv, index);
> -       rcu_idle_exit();
> +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> +               rcu_idle_exit();
>         start_critical_timings();
>
>         sched_clock_idle_wakeup_event();
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 75895e6363b8..47f686131a54 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -82,6 +82,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_UNUSABLE          BIT(3) /* avoid using this state */
>  #define CPUIDLE_FLAG_OFF               BIT(4) /* disable this state by default */
>  #define CPUIDLE_FLAG_TLB_FLUSHED       BIT(5) /* idle-state flushes TLBs */
> +#define CPUIDLE_FLAG_RCU_IDLE          BIT(6) /* driver will do RCU-idle */
>
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;

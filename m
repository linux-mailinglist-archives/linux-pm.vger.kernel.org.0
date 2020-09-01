Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4803A2595D0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbgIAPon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 11:44:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11691 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbgIAPol (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 11:44:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598975079; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=9RN/DXcpCgvBkcZ0mIGG04s1Hi8vxYfEBWSAyyjyMVw=; b=RR8cEV2OjnUMKh2ktePQ6Z31Gpp3prYL1ZWu4pImNd9RlR8asiVjbM0nb6hGkSlCB4T3d7P5
 QlksU7l0/y76WUZQQ4ALv1/OkR3rjBNES1fPiS3fk4GEhhW+lJg7ZpDgELhler+FGJ9GxyiS
 JEmdPYIJ2aFPaM8X7fHq5aE0gbE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f4e6c559bdf68cc03daec15 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 15:44:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1EACC433CB; Tue,  1 Sep 2020 15:44:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CC86C433CB;
        Tue,  1 Sep 2020 15:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CC86C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 1 Sep 2020 09:44:17 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>, paulmck@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
Message-ID: <20200901154417.GD20303@codeaurora.org>
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
 <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On Tue, Sep 01 2020 at 06:41 -0600, Ulf Hansson wrote:
>On Tue, 1 Sep 2020 at 14:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Tue, 1 Sep 2020 at 12:42, <peterz@infradead.org> wrote:
>> >
>> > On Tue, Sep 01, 2020 at 08:50:57AM +0200, Ulf Hansson wrote:
>> > > On Tue, 1 Sep 2020 at 08:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > > > On Mon, 31 Aug 2020 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
>> >
>> > > > > > [    5.308588] =============================
>> > > > > > [    5.308593] WARNING: suspicious RCU usage
>> > > > > > [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
>> > > > > > [    5.320052] 5.9.0-rc3 #1 Not tainted
>> > > > > > [    5.320057] -----------------------------
>> > > > > > [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
>> > > > > > [    5.320068]
>> > > > > > [    5.320068] other info that might help us debug this:
>> > > > > > [    5.320068]
>> > > > > > [    5.320074]
>> > > > > > [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
>> > > > > > [    5.320078] RCU used illegally from extended quiescent state!
>> > > > > > [    5.320084] no locks held by swapper/0/0.
>> > > > > > [    5.320089]
>> > > > > > [    5.320089] stack backtrace:
>> > > > > > [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
>> > > > > > [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
>> > > > > > [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>> > > > > > [    5.346452] Call trace:
>> > > > > > [    5.346463]  dump_backtrace+0x0/0x1f8
>> > > > > > [    5.346471]  show_stack+0x2c/0x38
>> > > > > > [    5.346480]  dump_stack+0xec/0x15c
>> > > > > > [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
>> > > > > > [    5.346499]  lock_acquire+0x3d0/0x440
>> > > > > > [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
>> > > > > > [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
>> > > > > > [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
>> > > > > > [    5.421795]  cpuidle_enter_state+0xc8/0x610
>> > > > > > [    5.426392]  cpuidle_enter+0x3c/0x50
>> > > > > > [    5.430561]  call_cpuidle+0x44/0x80
>> > > > > > [    5.434378]  do_idle+0x240/0x2a0
>> >
>> > > > > Note also that Peter Zijlstra (CCed) is working to shrink the portion
>> > > > > of the idle loop that RCU ignores.  Not sure that it covers your
>> > > > > case, but it is worth checking.
>> >
>> > Right, so I think I 'caused' this by making the lock tracepoints
>> > visible. That is, the error always existed, now we actually warn about
>> > it.
>> >
>> > > > Thanks for letting me know. Let's see what Peter thinks about this then.
>> > > >
>> > > > Apologize for my ignorance, but from a cpuidle point of view, what
>> > > > does it mean using RCU_NONIDLE()? I guess we should avoid RCU_NONIDLE
>> > > > on bigger code paths?
>> > > >
>> > > > I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
>> > > > and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
>> > > > that's the easiest approach, at least to start with.
>> > > >
I think this would be nice. This should also cover the case, where PM domain
power off notification callbacks call trace function internally. Right?

--Lina

>> > > > Or do you have any other ideas?
>> >
>> > So IMO trace_*_rcuidle() and RCU_NONIDLE() are bugs, they just mean we
>> > got the ordering wrong and are papering over it. That said, that's been
>> > the modus operandi for a while now, just make it shut up and don't think
>> > about it :-/
>> >
>> > That said; I pushed the rcu_idle_enter() about as deep as it goes into
>> > generic code in commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
>> > deeper into the idle path")
>>
>> Aha, that commit should fix this problem, I think. Looks like that
>> commit was sent as a fix and included in the recent v5.9-rc3.
>>
>> Naresh, can you try with the above commit?
>
>Ah, just realized that I misread the patch. It doesn't fix it.
>
>We would still need a RCU_NONIDLE() in psci_enter_domain_idle_state()
>- or something along the lines of what you suggest below.
>
>Apologies for the noise.
>
>Kind regards
>Uffe
>
[1]. https://lkml.org/lkml/2020/8/26/81
>>
>> >
>> > I suppose the next step is pushing it into individual driver when
>> > needed, something like the below perhaps. I realize the coupled idle
>> > state stuff is more complicated that most, but it's also not an area
>> > I've looked at in detail, so perhaps I've just made a bigger mess, but
>> > it ought to give you enough to get going I think.
>>
>> These aren't coupled states. Instead, in cpuidle-psci, we are using PM
>> domains through genpd and runtime PM to manage "shared idle states"
>> between CPUs.
>>
>> Kind regards
>> Uffe
>>
>> >
>> > Rafael?
>> >
>> > ---
>> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
>> > index 74463841805f..617bbef316e6 100644
>> > --- a/drivers/cpuidle/cpuidle-psci.c
>> > +++ b/drivers/cpuidle/cpuidle-psci.c
>> > @@ -49,6 +49,9 @@ static inline u32 psci_get_domain_state(void)
>> >
>> >  static inline int psci_enter_state(int idx, u32 state)
>> >  {
>> > +       /*
>> > +        * XXX push rcu_idle_enter into the coupled code
>> > +        */
>> >         return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
>> >  }
>> >
>> > @@ -72,7 +75,9 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>> >         if (!state)
>> >                 state = states[idx];
>> >
>> > +       rcu_idle_enter();
>> >         ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>> > +       rcu_idle_exit();
>> >
>> >         pm_runtime_get_sync(pd_dev);
>> >
>> > @@ -125,8 +130,13 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
>> >                                 struct cpuidle_driver *drv, int idx)
>> >  {
>> >         u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
>> > +       int ret;
>> >
>> > -       return psci_enter_state(idx, state[idx]);
>> > +       rcu_idle_enter();
>> > +       ret = psci_enter_state(idx, state[idx]);
>> > +       rcu_idle_exit();
>> > +
>> > +       return ret;
>> >  }
>> >
>> >  static const struct of_device_id psci_idle_state_match[] = {
>> > @@ -170,6 +180,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>> >          * deeper states.
>> >          */
>> >         drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
>> > +       drv->states[state_count - 1].flags = CPUIDLE_FLAG_RCU_IDLE;
>> >         psci_cpuidle_use_cpuhp = true;
>> >
>> >         return 0;
>> > @@ -285,6 +296,7 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>> >          * state index 0.
>> >          */
>> >         drv->states[0].enter = psci_enter_idle_state;
>> > +       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
>> >         drv->states[0].exit_latency = 1;
>> >         drv->states[0].target_residency = 1;
>> >         drv->states[0].power_usage = UINT_MAX;
>> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> > index 04becd70cc41..3dbac3bb761b 100644
>> > --- a/drivers/cpuidle/cpuidle.c
>> > +++ b/drivers/cpuidle/cpuidle.c
>> > @@ -239,9 +239,11 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>> >         time_start = ns_to_ktime(local_clock());
>> >
>> >         stop_critical_timings();
>> > -       rcu_idle_enter();
>> > +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>> > +               rcu_idle_enter();
>> >         entered_state = target_state->enter(dev, drv, index);
>> > -       rcu_idle_exit();
>> > +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>> > +               rcu_idle_exit();
>> >         start_critical_timings();
>> >
>> >         sched_clock_idle_wakeup_event();
>> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> > index 75895e6363b8..47f686131a54 100644
>> > --- a/include/linux/cpuidle.h
>> > +++ b/include/linux/cpuidle.h
>> > @@ -82,6 +82,7 @@ struct cpuidle_state {
>> >  #define CPUIDLE_FLAG_UNUSABLE          BIT(3) /* avoid using this state */
>> >  #define CPUIDLE_FLAG_OFF               BIT(4) /* disable this state by default */
>> >  #define CPUIDLE_FLAG_TLB_FLUSHED       BIT(5) /* idle-state flushes TLBs */
>> > +#define CPUIDLE_FLAG_RCU_IDLE          BIT(6) /* driver will do RCU-idle */
>> >
>> >  struct cpuidle_device_kobj;
>> >  struct cpuidle_state_kobj;

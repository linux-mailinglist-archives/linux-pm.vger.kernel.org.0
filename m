Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C1423E6F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhJFNN3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhJFNN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 09:13:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB1C061749
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 06:11:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j5so10253360lfg.8
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mI7xxwj+mBUooKpJkWS2Vk+yUURNXRcCn/QPZmJzSqg=;
        b=uCtda1JSEXExVjMHnUmKdQ3BIdH/nb6dx+16B2rJDTOTZ5L+dl9pwjI6McHaDVs76T
         r1HkEACDjrLpNOmu14fvl+hUkN9q6wOBhJ0BTAAtXuMJaz/TFQtFcFzd5E4+z8175ja+
         Nt2gYmOP5PvihienZx6bgrpNTgupaskzZLSWzuEVkCpLsCdQXg9vGZww5gS8J4xinCB5
         WO1IY02bURGqitQC6AYQn0pzgdJF5PA4fsyaKm8yQBtmbAWTiNWWUIvHkmYHmZWqUGuk
         cWPvvWxhbtG6QAvG70+OmH/hNgGUTGMFhs+zIRWrkkywsfGMqoL1520a7BNo0Jkq55Fe
         0Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI7xxwj+mBUooKpJkWS2Vk+yUURNXRcCn/QPZmJzSqg=;
        b=7QCRI3MjRIF80sBP0onsuOPrJvU7dXW+BQkVm2z4+W4sQOmbD7NmRyADZtdfaeA/2A
         RkOzzli5XVin4rOIgzwHf6+G5EyifbtSCcWYx0QSwfS9rkI1GtLNSIqig+DKfqpkSALW
         6CPqkrt6SEFaKfNdJ0jKuTXTm6ktxcqFN/BF4BHepzTnT/SyifvvNJ3E3zHMrREYABJ9
         UQ5GqCp+5pRc/3IwS98Z0qcBOz2GJ702wMJDMYdpebZDHy/jDKZkDWlwMsQbBBT0aU5M
         G+XJuGkQ9pTvRi2SBUygT94uR1lz/ISOagwpxV33xORvQK1zxNPyMjiiSbmMMRRhBbNQ
         41Yg==
X-Gm-Message-State: AOAM5319t6pIbM5trtSSOE888G+DPKK/Ov8ViQlmWG6zKBg4iyduxzPy
        vDnvkJJHpxhCumW2YkDPot4hQxln072cWtHw+QZFGw==
X-Google-Smtp-Source: ABdhPJzLsdUjkwax4R9lmdaqTnoEmLJtzqFAoWzDO17wLjWLkX2JgyidZHNPcZ9xW1+o+067OuauRSi68xT/6d2Ci0I=
X-Received: by 2002:a19:5f4b:: with SMTP id a11mr9618060lfj.373.1633525892201;
 Wed, 06 Oct 2021 06:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-2-ulf.hansson@linaro.org> <07e6821c-c221-e90d-c977-4d6b55c1ab8d@codeaurora.org>
In-Reply-To: <07e6821c-c221-e90d-c977-4d6b55c1ab8d@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Oct 2021 15:10:55 +0200
Message-ID: <CAPDyKFpJqnoG5HGwGoMvBBXBCBt=eTqMcdX_A29eY05LLgLi3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: Avoid calls to cpuidle_resume|pause() for s2idle
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 Oct 2021 at 12:22, Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 9/29/2021 8:14 PM, Ulf Hansson wrote:
> > In s2idle_enter(), cpuidle_resume|pause() are invoked to re-allow calls to
> > the cpuidle callbacks during s2idle operations. This is needed because
> > cpuidle is paused in-between in dpm_suspend_noirq() and dpm_resume_noirq().
> >
> > However, calling cpuidle_resume|pause() from s2idle_enter() looks a bit
> > superfluous, as it also causes all CPUs to be waken up when the first CPU
> > wakes up from s2idle.
>
> Thanks for the patch. This can be good optimization to avoid waking up
> all CPUs always.
>
> >
> > Therefore, let's drop the calls to cpuidle_resume|pause() from
> > s2idle_enter(). To make this work, let's also adopt the path in the
> > cpuidle_idle_call() to allow cpuidle callbacks to be invoked for s2idle,
> > even if cpuidle has been paused.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >   drivers/cpuidle/cpuidle.c |  7 ++++++-
> >   include/linux/cpuidle.h   |  2 ++
> >   kernel/power/suspend.c    |  2 --
> >   kernel/sched/idle.c       | 40 ++++++++++++++++++++++-----------------
> >   4 files changed, 31 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index ef2ea1b12cd8..c76747e497e7 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -49,7 +49,12 @@ void disable_cpuidle(void)
> >   bool cpuidle_not_available(struct cpuidle_driver *drv,
> >                          struct cpuidle_device *dev)
> >   {
> > -     return off || !initialized || !drv || !dev || !dev->enabled;
> > +     return off || !drv || !dev || !dev->enabled;
> > +}
> > +
> > +bool cpuidle_paused(void)
> > +{
> > +     return !initialized;
> >   }
> >
> >   /**
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index fce476275e16..51698b385ab5 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -165,6 +165,7 @@ extern void cpuidle_pause_and_lock(void);
> >   extern void cpuidle_resume_and_unlock(void);
> >   extern void cpuidle_pause(void);
> >   extern void cpuidle_resume(void);
> > +extern bool cpuidle_paused(void);
> >   extern int cpuidle_enable_device(struct cpuidle_device *dev);
> >   extern void cpuidle_disable_device(struct cpuidle_device *dev);
> >   extern int cpuidle_play_dead(void);
> > @@ -204,6 +205,7 @@ static inline void cpuidle_pause_and_lock(void) { }
> >   static inline void cpuidle_resume_and_unlock(void) { }
> >   static inline void cpuidle_pause(void) { }
> >   static inline void cpuidle_resume(void) { }
> > +static inline bool cpuidle_paused(void) {return true; }
> >   static inline int cpuidle_enable_device(struct cpuidle_device *dev)
> >   {return -ENODEV; }
> >   static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index eb75f394a059..388a5de4836e 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -97,7 +97,6 @@ static void s2idle_enter(void)
> >       raw_spin_unlock_irq(&s2idle_lock);
> >
> >       cpus_read_lock();
> > -     cpuidle_resume();
> >
> >       /* Push all the CPUs into the idle loop. */
> >       wake_up_all_idle_cpus();
>
> wake_up_all_idle_cpus() will still cause all CPUs to be woken up when
> first cpu wakes up.
>
> say for example,
> 1. device goes to s2idle suspend.
> 2. one CPU wakes up to handle irq (irq is not a wake irq but left
> enabled at GIC because of IRQF_NOSUSPEND flag) so such irq will not
> break suspend.
> 3. The cpu handles the irq.
> 4. same cpu don't break s2idle_loop() and goes to s2idle_enter() where
> it wakes up all existing idle cpus due to wake_up_all_idle_cpus()
> 5. all of CPUs again enter s2idle.
>
> to avoid waking up all CPUs in above case, something like below snip may
> help (i have not tested yet),
>
> when CPUs are in s2idle_loop(),
>
> 1. set the s2idle state to enter.
> 2. wake up all cpus from shallow state, so that they can re-enter
> deepest state.
> 3. Forever loop until a break with some wake irq.
> 4. clear the s2idle state.
> 5. wake up all cpus from deepest state so that they can now stay in
> shallow state/running state.
>
> void s2idle_loop(void)
> {
>
> +       s2idle_state = S2IDLE_STATE_ENTER;
> +       /* Push all the CPUs to enter deepest available state */
> +       wake_up_all_idle_cpus();
>          for (;;) {
>                  if (s2idle_ops && s2idle_ops->wake) {
>                          if (s2idle_ops->wake())
>                                 ..
>                  s2idle_enter();
>          }
> +       s2idle_state = S2IDLE_STATE_NONE;
> +       /* Push all the CPUs to enter default_idle() from this point */
> +       wake_up_all_idle_cpus();
> }

Overall, I follow your reasoning above and I think it makes sense to
me, but maybe Rafael has some concerns about it.

Even if the above code needs some polishing, the logic seems
reasonable to me. I suggest you post a patch, based on top of my small
series, so we can discuss your suggested improvements separately. Or
just tell me, if you would like me to do it.

>
> Thanks,
> Maulik

Thanks for reviewing!

[...]

Kind regards
Uffe

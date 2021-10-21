Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3F43676E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUQTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQTj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 12:19:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7105C0613B9
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 09:17:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r6so545118ljg.6
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoBKIJl0uVlCb4y2ghR0UXvsYP6ZZa4eIRxH6OeTSvA=;
        b=HYNNxlFb12+KrW4ACf3ZIco7O3zVNdL1ljmGjOUHDrymKhjdwmlg5PbIAgQKKxHl8R
         c7fqFn9Wg69ZPaZjYWa0k5kIgqnMFg6cUWQ9gYaPoF2fVkJH2RRyogdCffgNAel0fOsr
         wL/nYzFerPe4wsmY0udLwNvTnkIojiV6cGofqBixIutk4MBIql0GP5Jp2Xj+tXRB7Tp+
         6QF/UB4qiqSqErttes+QvFvPQsQU93GU5uw+qkRPb9Z8/JdxJp5P1cvWmGG6phaxBSuV
         gWIewpi+qHCU4PjUMbdNmHp5+ZGMtWoKFVIhRnl/zXtxLNeaDGDIPUemkr53r8XTS7JT
         QOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoBKIJl0uVlCb4y2ghR0UXvsYP6ZZa4eIRxH6OeTSvA=;
        b=uOL9yWzRFtCbOqHbIvb0qWVcis6feloGxw/KV0AHPvCxFTUt+mlNLEUcVmmLbrGDEk
         l4buDrLGJDWiXbXX36ske51I0skhFSKgLhf7P0GsA0VywB566MrZzo0XVwucYQsvpfaZ
         2RNO4HpGNjotgGP5QXI/nBnwQI+Ns8hPmTmsaO15qqYWNI8E0eZVjBd0+/ToSgMxt0N4
         o0MMjjjfddfGGInxnA29LOcb1YKb6h1TF/terZZNr/outKMa8e9Dcbfcz0idyz8TeR1+
         jzRGVZGo6bt1NMAx7JaM9o8Y/NNtTqxtY7EUkF1ppigi2wY8j49KZ7Vej78+AML/DRtW
         lqRQ==
X-Gm-Message-State: AOAM531rt49GWKfpZ4v4rbJCQPbC8DgMOTyaSosGJMpiZaz7K3UZoUfd
        fL3yXx/zqYJo1obYrGG1pIbG5EMKQwu7FmOAip2RCQ==
X-Google-Smtp-Source: ABdhPJwjsfh9moN6GY1R1FG3/BrFnDliW52+O2lbfMHOscLhrwPmUamaQO6aao7it4IQ2BnRwx5fhh4FPbfxCYPsEmQ=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr3647826ljq.300.1634833040558;
 Thu, 21 Oct 2021 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com> <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 18:16:43 +0200
Message-ID: <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 at 17:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 21, 2021 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 21 Oct 2021 at 15:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 1:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 20 Oct 2021 at 20:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Wed, Sep 29, 2021 at 4:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > In the cpuidle-psci case, runtime PM in combination with the generic PM
> > > > > > domain (genpd), may be used when entering/exiting an idlestate. More
> > > > > > precisely, genpd relies on runtime PM to be enabled for the attached device
> > > > > > (in this case it belongs to a CPU), to properly manage the reference
> > > > > > counting of its PM domain.
> > > > > >
> > > > > > This works fine most of the time, but during system suspend in the
> > > > > > dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> > > > > > Beyond this point and until runtime PM becomes re-enabled in the
> > > > > > dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
> > > > > >
> > > > > > To make sure the reference counting in genpd becomes correct, we need to
> > > > > > prevent cpuidle-psci from using runtime PM when it has been disabled for
> > > > > > the device. Therefore, let's move the call to cpuidle_pause() from
> > > > > > dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> > > > > > dpm_resume_noirq() into dpm_resume_early().
> > > > > >
> > > > > > Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> > > > > > Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > ---
> > > > > >  drivers/base/power/main.c | 6 ++----
> > > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > > > index cbea78e79f3d..1c753b651272 100644
> > > > > > --- a/drivers/base/power/main.c
> > > > > > +++ b/drivers/base/power/main.c
> > > > > > @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
> > > > > >
> > > > > >         resume_device_irqs();
> > > > > >         device_wakeup_disarm_wake_irqs();
> > > > > > -
> > > > > > -       cpuidle_resume();
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
> > > > > >         }
> > > > > >         mutex_unlock(&dpm_list_mtx);
> > > > > >         async_synchronize_full();
> > > > > > +       cpuidle_resume();
> > > > > >         dpm_show_time(starttime, state, 0, "early");
> > > > > >         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
> > > > > >  }
> > > > > > @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
> > > > > >  {
> > > > > >         int ret;
> > > > > >
> > > > > > -       cpuidle_pause();
> > > > > > -
> > > > > >         device_wakeup_arm_wake_irqs();
> > > > > >         suspend_device_irqs();
> > > > > >
> > > > > > @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
> > > > > >         int error = 0;
> > > > > >
> > > > > >         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> > > > > > +       cpuidle_pause();
> > > > > >         mutex_lock(&dpm_list_mtx);
> > > > > >         pm_transition = state;
> > > > > >         async_error = 0;
> > > > > > --
> > > > >
> > > > > Well, this is somewhat heavy-handed and it affects even the systems
> > > > > that don't really need to pause cpuidle at all in the suspend path.
> > > >
> > > > Yes, I agree.
> > > >
> > > > Although, I am not really changing the behaviour in regards to this.
> > > > cpuidle_pause() is already being called in dpm_suspend_noirq(), for
> > > > everybody today.
> > >
> > > Yes, it is, but pausing it earlier will cause more energy to be spent,
> > > potentially.
> > >
> > > That said, there are not too many users of suspend_late callbacks in
> > > the tree, so it may not matter too much.
> > >
> > > > >
> > > > > Also, IIUC you don't need to pause cpuidle completely, but make it
> > > > > temporarily avoid idle states potentially affected by this issue.  An
> > > > > additional CPUIDLE_STATE_DISABLED_ flag could be used for that I
> > > > > suppose and it could be set via cpuidle_suspend() called from the core
> > > > > next to cpufreq_suspend().
> > > >
> > > > cpuidle_suspend() would then need to go and fetch the cpuidle driver
> > > > instance, which in some cases is one driver per CPU. Doesn't that get
> > > > rather messy?
> > >
> > > Per-CPU variables are used for that, so it is quite straightforward.
> > >
> > > > Additionally, since find_deepest_state() is being called for
> > > > cpuidle_enter_s2idle() too, we would need to treat the new
> > > > CPUIDLE_STATE_DISABLED_ flag in a special way, right?
> > >
> > > No, it already checks "disabled".
> >
> > Yes, but that would be wrong.
>
> Hmmm.
>
> > The use case I want to support, for cpuidle-psci, is to allow all idle
> > states in suspend-to-idle,
>
> So does PM-runtime work in suspend-to-idle?  How?

No it doesn't. See below.

>
> > but prevent those that rely on runtime PM
> > (after it has been disabled) for the regular idle path.
>
> Do you have a special suspend-to-idle handling of those states that
> doesn't require PM-runtime?

Yes. Feel free to have a look in __psci_enter_domain_idle_state().

In principle, when running the s2idle path, we call
dev_pm_genpd_suspend|resume(), rather than pm_runtime_get|put*.

This let genpd manage the reference counting (hierarchically too) and
it also ignores the genpd governor in this stage, which also is needed
to enter the deepest state. Quite similar to how cpuidle works.

[...]

Kind regards
Uffe

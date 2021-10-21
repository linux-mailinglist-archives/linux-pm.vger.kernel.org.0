Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5394368B3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhJURH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 13:07:59 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35548 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhJURH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 13:07:56 -0400
Received: by mail-ot1-f43.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so1250274ott.2;
        Thu, 21 Oct 2021 10:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOZ8eo0fAHNOTtLyKjYuQbxB9Mnz8nPucoboPueo7ug=;
        b=VOfEqC2gB/2/FQaoC96lL7CkBJMnkAfB5HyRHD6sLA9wHaxY+D1XhYbXFxVm8ZONnm
         /ZkN5TwOZp+3VvjVBaIfwHlOHlMaSrsbyZvVcR7per5+RWYlg0CZ/IbS6or6IpsmT4ic
         CKqnw5cHvaD/MRqNc2/4UwaNiP8uJZTM2aFKVvvBnGbrlAQmcV5vTlji7/qXt27ITHhZ
         L5FAOqEAVUMa+l5Dcr6SuwJsWdlEwix+z3kJjILLPA+Em3jXHeM6ciJAmKKKlnLk9M/4
         S/B9u7/ADnAVECdIfnGWLtacxRuqLmwhYyNuuMhtiEIKaZpPulAMCRMSBq+9J18DtIvD
         EncA==
X-Gm-Message-State: AOAM530OVoki5Tp+eG+AuoqpshcDLkgM7yDZejyAqq6zlFMIV+e5dWW0
        N3psXuiT77jHXCxE5YSZTBxRjdxDaRi0CphHOGY=
X-Google-Smtp-Source: ABdhPJyN7RdXSDW0EPCRxZHf88z4F1Ctuemx5QWDHuKunvFrJpCBOYaETrcQcKRLCdOdPxQLZPzwDukik7dSyVFnAJ0=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr5843894ott.254.1634835939753;
 Thu, 21 Oct 2021 10:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAJZ5v0jQM3VDy_U8TiC3601ivSYVXyT5jJVjLt8qyMWE49zOeg@mail.gmail.com>
 <CAPDyKFouHn95Lwgx+PbK9itQP13U70ZiZbDr3jQd41KsvXMtqQ@mail.gmail.com> <CAJZ5v0hjdpyFGF5zPUX8RUaVW7Tk+qr9RwbGt-7C0Wxyx03TLg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hjdpyFGF5zPUX8RUaVW7Tk+qr9RwbGt-7C0Wxyx03TLg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 19:05:28 +0200
Message-ID: <CAJZ5v0iWxiH686bkZ3-mhKK0+F7f+wMWp8Adnjuk7BvdMywTww@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, Oct 21, 2021 at 6:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 21, 2021 at 6:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 21 Oct 2021 at 17:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 5:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 21, 2021 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Thu, 21 Oct 2021 at 15:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Oct 21, 2021 at 1:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > On Wed, 20 Oct 2021 at 20:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 29, 2021 at 4:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > In the cpuidle-psci case, runtime PM in combination with the generic PM
> > > > > > > > > domain (genpd), may be used when entering/exiting an idlestate. More
> > > > > > > > > precisely, genpd relies on runtime PM to be enabled for the attached device
> > > > > > > > > (in this case it belongs to a CPU), to properly manage the reference
> > > > > > > > > counting of its PM domain.
> > > > > > > > >
> > > > > > > > > This works fine most of the time, but during system suspend in the
> > > > > > > > > dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> > > > > > > > > Beyond this point and until runtime PM becomes re-enabled in the
> > > > > > > > > dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
> > > > > > > > >
> > > > > > > > > To make sure the reference counting in genpd becomes correct, we need to
> > > > > > > > > prevent cpuidle-psci from using runtime PM when it has been disabled for
> > > > > > > > > the device. Therefore, let's move the call to cpuidle_pause() from
> > > > > > > > > dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> > > > > > > > > dpm_resume_noirq() into dpm_resume_early().
> > > > > > > > >
> > > > > > > > > Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> > > > > > > > > Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> > > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/base/power/main.c | 6 ++----
> > > > > > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > > > > > > index cbea78e79f3d..1c753b651272 100644
> > > > > > > > > --- a/drivers/base/power/main.c
> > > > > > > > > +++ b/drivers/base/power/main.c
> > > > > > > > > @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
> > > > > > > > >
> > > > > > > > >         resume_device_irqs();
> > > > > > > > >         device_wakeup_disarm_wake_irqs();
> > > > > > > > > -
> > > > > > > > > -       cpuidle_resume();
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  /**
> > > > > > > > > @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
> > > > > > > > >         }
> > > > > > > > >         mutex_unlock(&dpm_list_mtx);
> > > > > > > > >         async_synchronize_full();
> > > > > > > > > +       cpuidle_resume();
> > > > > > > > >         dpm_show_time(starttime, state, 0, "early");
> > > > > > > > >         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
> > > > > > > > >  }
> > > > > > > > > @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
> > > > > > > > >  {
> > > > > > > > >         int ret;
> > > > > > > > >
> > > > > > > > > -       cpuidle_pause();
> > > > > > > > > -
> > > > > > > > >         device_wakeup_arm_wake_irqs();
> > > > > > > > >         suspend_device_irqs();
> > > > > > > > >
> > > > > > > > > @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
> > > > > > > > >         int error = 0;
> > > > > > > > >
> > > > > > > > >         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> > > > > > > > > +       cpuidle_pause();
> > > > > > > > >         mutex_lock(&dpm_list_mtx);
> > > > > > > > >         pm_transition = state;
> > > > > > > > >         async_error = 0;
> > > > > > > > > --
> > > > > > > >
> > > > > > > > Well, this is somewhat heavy-handed and it affects even the systems
> > > > > > > > that don't really need to pause cpuidle at all in the suspend path.
> > > > > > >
> > > > > > > Yes, I agree.
> > > > > > >
> > > > > > > Although, I am not really changing the behaviour in regards to this.
> > > > > > > cpuidle_pause() is already being called in dpm_suspend_noirq(), for
> > > > > > > everybody today.
> > > > > >
> > > > > > Yes, it is, but pausing it earlier will cause more energy to be spent,
> > > > > > potentially.
> > > > > >
> > > > > > That said, there are not too many users of suspend_late callbacks in
> > > > > > the tree, so it may not matter too much.
> > > > > >
> > > > > > > >
> > > > > > > > Also, IIUC you don't need to pause cpuidle completely, but make it
> > > > > > > > temporarily avoid idle states potentially affected by this issue.  An
> > > > > > > > additional CPUIDLE_STATE_DISABLED_ flag could be used for that I
> > > > > > > > suppose and it could be set via cpuidle_suspend() called from the core
> > > > > > > > next to cpufreq_suspend().
> > > > > > >
> > > > > > > cpuidle_suspend() would then need to go and fetch the cpuidle driver
> > > > > > > instance, which in some cases is one driver per CPU. Doesn't that get
> > > > > > > rather messy?
> > > > > >
> > > > > > Per-CPU variables are used for that, so it is quite straightforward.
> > > > > >
> > > > > > > Additionally, since find_deepest_state() is being called for
> > > > > > > cpuidle_enter_s2idle() too, we would need to treat the new
> > > > > > > CPUIDLE_STATE_DISABLED_ flag in a special way, right?
> > > > > >
> > > > > > No, it already checks "disabled".
> > > > >
> > > > > Yes, but that would be wrong.
> > > >
> > > > Hmmm.
> > > >
> > > > > The use case I want to support, for cpuidle-psci, is to allow all idle
> > > > > states in suspend-to-idle,
> > > >
> > > > So does PM-runtime work in suspend-to-idle?  How?
> > > >
> > > > > but prevent those that rely on runtime PM
> > > > > (after it has been disabled) for the regular idle path.
> > > >
> > > > Do you have a special suspend-to-idle handling of those states that
> > > > doesn't require PM-runtime?
> > >
> > > Regardless, pausing cpuidle in the suspend-to-idle path simply doesn't
> > > make sense at all, so this needs to be taken care of in the first
> > > place.
> >
> > Right, I do agree, don't get me wrong. But, do we really want to treat
> > s2-to-idle differently, compared to s2-to-ram in regards to this?
> >
> > Wouldn't it be a lot easier to let cpuidle drivers to opt-out for
> > cpuidle_pause|resume(), no matter whether it's for s2-to-idle or
> > s2-to-ram?
>
> I don't think so.
>
> Suspend-to-idle resume cpuidle after pausing it which is just plain
> confusing and waste of energy and the fact that the system-wide
> suspend flow interferes with using PM-runtime for implementing cpuidle
> callbacks at the low level really is an orthogonal problem.
>
> > >
> > > The problem with PM-runtime being unavailable after dpm_suspend()
> > > needs to be addressed in a different way IMO, because it only affects
> > > one specific use case.
> >
> > It's one specific case so far, but we have the riscv driver on its
> > way, which would suffer from the same problem.
>
> So perhaps they should be advised about this issue.
>
> > Anyway, an option is to figure out what platforms and cpuidle drivers,
> > that really needs cpuidle_pause|resume() at this point and make an
> > opt-in solution instead.
>
> None of them need to pause cpuidle for suspend-to-idle AFAICS.
>
> Some may want it in the non-s2idle suspend path, but I'm not sure
> about the exact point where cpuidle needs to be paused in this case.
> Possibly before offlining the nonboot CPUs.
>
> > This could then be used by runtime PM based
> > cpuidle drivers as well. Would that be a way forward?
>
> The PM-runtime case should be addressed directly IMO, we only need to
> figure out how to do that.
>
> I'm wondering how you are dealing with the case when user space
> prevents pd_dev from suspending via sysfs, for that matter.

Or what happens if rpm_suspend() returns -EAGAIN, because someone has
started to resume the device right after its reference counter went
down to 0.

It looks to me like the problem is there regardless of the whole
interference with system suspend.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF14367DD
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUQfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 12:35:47 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40826 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 12:35:46 -0400
Received: by mail-oi1-f180.google.com with SMTP id n63so1554758oif.7;
        Thu, 21 Oct 2021 09:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24SPUup6/debBy6bmeYVYTkV93XMdbp2pGn2kcZ1O4E=;
        b=4WwohxIEJl46jU6ylfQUYsdYZAf/aSzSVX2FtUguAyL+1uXGXhiOH1TCIL0ggMb3M+
         5bUhuTpQ4tv3Slz7kXZDTP3KoH2qWt10prPsGca7d+mjB4N5/+IPxulc3WQT4HgzweMA
         9DJ0UZQjgXd9d7cRXfU2Krk7azLN+xvTPd7ryIDVKoTcF0206yB0eGzCnfh1SyTwp3gs
         bFmniDiyG5e/cQEeQn7JmbMGQefwvOBdk5apJG6XnzH1VbbMj+988tStD3j7isCqaSOH
         L0HKZIPjfkVJi5/r3VOGR4KSeCfLsBxRct0j4CN6c9GvC+F2gr12C5AXnj9PFR8sxx+7
         PWjw==
X-Gm-Message-State: AOAM532hxdAQCDr57hb8Os98kPvwHWOZ4yh7aX7B4UD087z6CAD+0Mro
        GyAwWzwah2Br4SMBWljnLvVRVghO5UzZ8E+BlTs=
X-Google-Smtp-Source: ABdhPJwd9M0Gcatcj1kuS8RVW3SbXQpOfDakX+6RQkD6W9x4aZwoLdeHngugnh1WWBbKkNE+w60YGVQkf9WVXyegg/c=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr1552643oil.166.1634834010348;
 Thu, 21 Oct 2021 09:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com> <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
In-Reply-To: <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 18:33:19 +0200
Message-ID: <CAJZ5v0itweerfbq8NE9rEonZ2Nfu_nfKgERv2tweeLO4fgAgLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Thu, Oct 21, 2021 at 6:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 21 Oct 2021 at 17:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 21 Oct 2021 at 15:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 21, 2021 at 1:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Wed, 20 Oct 2021 at 20:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Sep 29, 2021 at 4:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > In the cpuidle-psci case, runtime PM in combination with the generic PM
> > > > > > > domain (genpd), may be used when entering/exiting an idlestate. More
> > > > > > > precisely, genpd relies on runtime PM to be enabled for the attached device
> > > > > > > (in this case it belongs to a CPU), to properly manage the reference
> > > > > > > counting of its PM domain.
> > > > > > >
> > > > > > > This works fine most of the time, but during system suspend in the
> > > > > > > dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> > > > > > > Beyond this point and until runtime PM becomes re-enabled in the
> > > > > > > dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
> > > > > > >
> > > > > > > To make sure the reference counting in genpd becomes correct, we need to
> > > > > > > prevent cpuidle-psci from using runtime PM when it has been disabled for
> > > > > > > the device. Therefore, let's move the call to cpuidle_pause() from
> > > > > > > dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> > > > > > > dpm_resume_noirq() into dpm_resume_early().
> > > > > > >
> > > > > > > Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> > > > > > > Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/base/power/main.c | 6 ++----
> > > > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > > > > index cbea78e79f3d..1c753b651272 100644
> > > > > > > --- a/drivers/base/power/main.c
> > > > > > > +++ b/drivers/base/power/main.c
> > > > > > > @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
> > > > > > >
> > > > > > >         resume_device_irqs();
> > > > > > >         device_wakeup_disarm_wake_irqs();
> > > > > > > -
> > > > > > > -       cpuidle_resume();
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
> > > > > > >         }
> > > > > > >         mutex_unlock(&dpm_list_mtx);
> > > > > > >         async_synchronize_full();
> > > > > > > +       cpuidle_resume();
> > > > > > >         dpm_show_time(starttime, state, 0, "early");
> > > > > > >         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
> > > > > > >  }
> > > > > > > @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
> > > > > > >  {
> > > > > > >         int ret;
> > > > > > >
> > > > > > > -       cpuidle_pause();
> > > > > > > -
> > > > > > >         device_wakeup_arm_wake_irqs();
> > > > > > >         suspend_device_irqs();
> > > > > > >
> > > > > > > @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
> > > > > > >         int error = 0;
> > > > > > >
> > > > > > >         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> > > > > > > +       cpuidle_pause();
> > > > > > >         mutex_lock(&dpm_list_mtx);
> > > > > > >         pm_transition = state;
> > > > > > >         async_error = 0;
> > > > > > > --
> > > > > >
> > > > > > Well, this is somewhat heavy-handed and it affects even the systems
> > > > > > that don't really need to pause cpuidle at all in the suspend path.
> > > > >
> > > > > Yes, I agree.
> > > > >
> > > > > Although, I am not really changing the behaviour in regards to this.
> > > > > cpuidle_pause() is already being called in dpm_suspend_noirq(), for
> > > > > everybody today.
> > > >
> > > > Yes, it is, but pausing it earlier will cause more energy to be spent,
> > > > potentially.
> > > >
> > > > That said, there are not too many users of suspend_late callbacks in
> > > > the tree, so it may not matter too much.
> > > >
> > > > > >
> > > > > > Also, IIUC you don't need to pause cpuidle completely, but make it
> > > > > > temporarily avoid idle states potentially affected by this issue.  An
> > > > > > additional CPUIDLE_STATE_DISABLED_ flag could be used for that I
> > > > > > suppose and it could be set via cpuidle_suspend() called from the core
> > > > > > next to cpufreq_suspend().
> > > > >
> > > > > cpuidle_suspend() would then need to go and fetch the cpuidle driver
> > > > > instance, which in some cases is one driver per CPU. Doesn't that get
> > > > > rather messy?
> > > >
> > > > Per-CPU variables are used for that, so it is quite straightforward.
> > > >
> > > > > Additionally, since find_deepest_state() is being called for
> > > > > cpuidle_enter_s2idle() too, we would need to treat the new
> > > > > CPUIDLE_STATE_DISABLED_ flag in a special way, right?
> > > >
> > > > No, it already checks "disabled".
> > >
> > > Yes, but that would be wrong.
> >
> > Hmmm.
> >
> > > The use case I want to support, for cpuidle-psci, is to allow all idle
> > > states in suspend-to-idle,
> >
> > So does PM-runtime work in suspend-to-idle?  How?
>
> No it doesn't. See below.
>
> >
> > > but prevent those that rely on runtime PM
> > > (after it has been disabled) for the regular idle path.
> >
> > Do you have a special suspend-to-idle handling of those states that
> > doesn't require PM-runtime?
>
> Yes. Feel free to have a look in __psci_enter_domain_idle_state().

So in theory you could check the pm_runtime_put_sync_suspend() return
value and fall back to something like WFI if that's an error code.

> In principle, when running the s2idle path, we call
> dev_pm_genpd_suspend|resume(), rather than pm_runtime_get|put*.
>
> This let genpd manage the reference counting (hierarchically too) and
> it also ignores the genpd governor in this stage, which also is needed
> to enter the deepest state. Quite similar to how cpuidle works.

OK

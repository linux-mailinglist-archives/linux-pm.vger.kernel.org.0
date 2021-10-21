Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6350436346
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJUNrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:47:39 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46914 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUNrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:47:37 -0400
Received: by mail-oi1-f175.google.com with SMTP id o204so859950oih.13;
        Thu, 21 Oct 2021 06:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNaX23h9O9c/G7pG000WHJ6bQPKz9HGo1gSBNA+fGwU=;
        b=EDMUrcw+9C+9De1m4kE+bw2lFCcVElirqN0o/iiCpvVI6P3rHx+Io9scnDEGOok2g3
         xfD+IQS8qsVypz4BRBxd638C6vwFQlHOb3cPvPs9Gz33kIt2DdlGHgN8C1JRtn2fETZa
         Bgk4aiaIPnEk61RuzptN0kiMG6/blPkuaSj46Vr7WkiNCjQ3Ne/jlbpohUH09pRLGTXl
         +WIkx2YRpFbfP7nf4dr15/IEdyB4l+IXxmt1G6+pamv7sQmKUt+955bCPH/9pc1BNuqh
         OcQuSR8FSK+FCz6UV0xtUIJWD5bqjv5NzeQZubuPOfpWnEtX/HSddmk3975dza4jw11e
         nDXA==
X-Gm-Message-State: AOAM531AQFss24xO2MOjP3hXNdNSr7HsDJx4KYPFYo7ZOfTG3BNMF2/S
        /cNNLD5WGCCjLUu8GYQb1MJybY1rQqOCRKEWqCg=
X-Google-Smtp-Source: ABdhPJyLF7e+JYzSioZz7r+D8rOUV+UL5jI7976DBV1QPmjULgnEQRgcXaFYRnZW9ADxBdhlG6Q+0Y7ElK1kivOTf+A=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr4421325oif.154.1634823920741;
 Thu, 21 Oct 2021 06:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
In-Reply-To: <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 15:45:09 +0200
Message-ID: <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
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

On Thu, Oct 21, 2021 at 1:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 20 Oct 2021 at 20:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Sep 29, 2021 at 4:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > In the cpuidle-psci case, runtime PM in combination with the generic PM
> > > domain (genpd), may be used when entering/exiting an idlestate. More
> > > precisely, genpd relies on runtime PM to be enabled for the attached device
> > > (in this case it belongs to a CPU), to properly manage the reference
> > > counting of its PM domain.
> > >
> > > This works fine most of the time, but during system suspend in the
> > > dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> > > Beyond this point and until runtime PM becomes re-enabled in the
> > > dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
> > >
> > > To make sure the reference counting in genpd becomes correct, we need to
> > > prevent cpuidle-psci from using runtime PM when it has been disabled for
> > > the device. Therefore, let's move the call to cpuidle_pause() from
> > > dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> > > dpm_resume_noirq() into dpm_resume_early().
> > >
> > > Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> > > Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/base/power/main.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index cbea78e79f3d..1c753b651272 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
> > >
> > >         resume_device_irqs();
> > >         device_wakeup_disarm_wake_irqs();
> > > -
> > > -       cpuidle_resume();
> > >  }
> > >
> > >  /**
> > > @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
> > >         }
> > >         mutex_unlock(&dpm_list_mtx);
> > >         async_synchronize_full();
> > > +       cpuidle_resume();
> > >         dpm_show_time(starttime, state, 0, "early");
> > >         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
> > >  }
> > > @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
> > >  {
> > >         int ret;
> > >
> > > -       cpuidle_pause();
> > > -
> > >         device_wakeup_arm_wake_irqs();
> > >         suspend_device_irqs();
> > >
> > > @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
> > >         int error = 0;
> > >
> > >         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> > > +       cpuidle_pause();
> > >         mutex_lock(&dpm_list_mtx);
> > >         pm_transition = state;
> > >         async_error = 0;
> > > --
> >
> > Well, this is somewhat heavy-handed and it affects even the systems
> > that don't really need to pause cpuidle at all in the suspend path.
>
> Yes, I agree.
>
> Although, I am not really changing the behaviour in regards to this.
> cpuidle_pause() is already being called in dpm_suspend_noirq(), for
> everybody today.

Yes, it is, but pausing it earlier will cause more energy to be spent,
potentially.

That said, there are not too many users of suspend_late callbacks in
the tree, so it may not matter too much.

> >
> > Also, IIUC you don't need to pause cpuidle completely, but make it
> > temporarily avoid idle states potentially affected by this issue.  An
> > additional CPUIDLE_STATE_DISABLED_ flag could be used for that I
> > suppose and it could be set via cpuidle_suspend() called from the core
> > next to cpufreq_suspend().
>
> cpuidle_suspend() would then need to go and fetch the cpuidle driver
> instance, which in some cases is one driver per CPU. Doesn't that get
> rather messy?

Per-CPU variables are used for that, so it is quite straightforward.

> Additionally, since find_deepest_state() is being called for
> cpuidle_enter_s2idle() too, we would need to treat the new
> CPUIDLE_STATE_DISABLED_ flag in a special way, right?

No, it already checks "disabled".

> Is this really what we want?
>
> >
> > The other guys who rely on the cpuidle pausing today could be switched
> > over to this new mechanism later and it would be possible to get rid
> > of the pausing from the system suspend path completely.
>
> Avoiding to pause cpuidle when it's not needed makes perfect sense.
> Although, it looks to me that we could also implement that on top of
> $subject patch.

Yes, it could.

> Unless you insist on the CPUIDLE_STATE_DISABLED_ way, I would probably
> explore an option to let a cpuidle driver to set a global cpuidle flag
> during ->probe(). Depending if this flag is set, we can simply skip
> calling cpuidle_pause() during system suspend.
>
> What do you think?

Well, which driver in particular is in question here?

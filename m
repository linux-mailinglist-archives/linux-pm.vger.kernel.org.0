Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF24360BA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJULvc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJULvc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 07:51:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB2C06161C
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 04:49:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u21so825959lff.8
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuH9sIJDNZs0UgxOGh411kkOSLBffoDt7vM8MC6DQHM=;
        b=khNjdgZSZgYDOh0Umaa9AzdCVK8l/F6gc5xBy/Fns2BjZ3fwNTPYybpbibSbX63fzt
         FvdZGy17wja6fJX82el0+bQf1Q6B3wCme5hw18xz3UJ4AiDysMGXmQps5sLPHd/L/1p8
         9bhGcRzF16wX17A14XQgA47Ei7ykkXavUwanOwLPexiZ9F6BoZGLhfci1SvQOri8MCtX
         8I3erdt58i1MJbzTNhdMj0m9dv4wlbwxnmZckFcziWTy98bOeMKZHZB2pqzmSDS2Hx54
         VBjKCAsIH4F2VBPR+4YuEevd/Z7r2GBrHNd0O2FQ+o8mAR95DLtL4hLV+DZFcU6dJ6PD
         Cc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuH9sIJDNZs0UgxOGh411kkOSLBffoDt7vM8MC6DQHM=;
        b=kkBf8MKT48+nmX0cgeDcyFgDiWYwbKgthP2L+3bvz3xIR1LZTOpQj/Lo8zirOIoBup
         rteBY9Wai30JQ4kuEbps4wIzv7cyBn5baQ1L+bj9onU+mh3ydGyLZliYl3K5TU9Askj3
         L3CAQrMREp48qXZSk7N/Ef4u0phuH1Worzt44UibDZ9GiEea0jin/LVT9yY+nIXH9svJ
         FUQRwpR55o0alcPgBf5uVnG/Z+jzWREIS+ZgNvjBpDcqcPfQUVSc2Ryz5MNgWMaOddKY
         tL7WTaGwu/qD3dweumsuStdeykq/tAJ0Pphed4v7VgwXRY/Ek22jbG34wGpjGehtuAqq
         MUXg==
X-Gm-Message-State: AOAM5303hNfku86xrC6pYU+Khp57ix4PxmnkolN9dRon7nKvriayh1O5
        TMia27hqTrrg2WZYfprNDMU5nFoVO+ZKSfOJqhL6VA==
X-Google-Smtp-Source: ABdhPJymcfJAaI+Z0t2BVdQva5KqvU1fkn/uFJxgQqJE3ELyxRMAavr1PRKxZxq2U1heygJVnoNH1U50TD1C1P0SGvs=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr2082259ljq.300.1634816954458;
 Thu, 21 Oct 2021 04:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 13:48:37 +0200
Message-ID: <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
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

On Wed, 20 Oct 2021 at 20:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 4:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > In the cpuidle-psci case, runtime PM in combination with the generic PM
> > domain (genpd), may be used when entering/exiting an idlestate. More
> > precisely, genpd relies on runtime PM to be enabled for the attached device
> > (in this case it belongs to a CPU), to properly manage the reference
> > counting of its PM domain.
> >
> > This works fine most of the time, but during system suspend in the
> > dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> > Beyond this point and until runtime PM becomes re-enabled in the
> > dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
> >
> > To make sure the reference counting in genpd becomes correct, we need to
> > prevent cpuidle-psci from using runtime PM when it has been disabled for
> > the device. Therefore, let's move the call to cpuidle_pause() from
> > dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> > dpm_resume_noirq() into dpm_resume_early().
> >
> > Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> > Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/main.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index cbea78e79f3d..1c753b651272 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
> >
> >         resume_device_irqs();
> >         device_wakeup_disarm_wake_irqs();
> > -
> > -       cpuidle_resume();
> >  }
> >
> >  /**
> > @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
> >         }
> >         mutex_unlock(&dpm_list_mtx);
> >         async_synchronize_full();
> > +       cpuidle_resume();
> >         dpm_show_time(starttime, state, 0, "early");
> >         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
> >  }
> > @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
> >  {
> >         int ret;
> >
> > -       cpuidle_pause();
> > -
> >         device_wakeup_arm_wake_irqs();
> >         suspend_device_irqs();
> >
> > @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
> >         int error = 0;
> >
> >         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> > +       cpuidle_pause();
> >         mutex_lock(&dpm_list_mtx);
> >         pm_transition = state;
> >         async_error = 0;
> > --
>
> Well, this is somewhat heavy-handed and it affects even the systems
> that don't really need to pause cpuidle at all in the suspend path.

Yes, I agree.

Although, I am not really changing the behaviour in regards to this.
cpuidle_pause() is already being called in dpm_suspend_noirq(), for
everybody today.

>
> Also, IIUC you don't need to pause cpuidle completely, but make it
> temporarily avoid idle states potentially affected by this issue.  An
> additional CPUIDLE_STATE_DISABLED_ flag could be used for that I
> suppose and it could be set via cpuidle_suspend() called from the core
> next to cpufreq_suspend().

cpuidle_suspend() would then need to go and fetch the cpuidle driver
instance, which in some cases is one driver per CPU. Doesn't that get
rather messy?

Additionally, since find_deepest_state() is being called for
cpuidle_enter_s2idle() too, we would need to treat the new
CPUIDLE_STATE_DISABLED_ flag in a special way, right?

Is this really what we want?

>
> The other guys who rely on the cpuidle pausing today could be switched
> over to this new mechanism later and it would be possible to get rid
> of the pausing from the system suspend path completely.

Avoiding to pause cpuidle when it's not needed makes perfect sense.
Although, it looks to me that we could also implement that on top of
$subject patch.

Unless you insist on the CPUIDLE_STATE_DISABLED_ way, I would probably
explore an option to let a cpuidle driver to set a global cpuidle flag
during ->probe(). Depending if this flag is set, we can simply skip
calling cpuidle_pause() during system suspend.

What do you think?

Kind regards
Uffe

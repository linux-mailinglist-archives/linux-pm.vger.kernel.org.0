Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7A435284
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTSUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 14:20:37 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35381 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTSUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 14:20:37 -0400
Received: by mail-ot1-f41.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so7483295ott.2;
        Wed, 20 Oct 2021 11:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zhU/MVqCC7sjIUtnc0rm+RoLnJs5XqU57OiDxfr75o=;
        b=oU7l580eqR5OexzEgBtjjI4OMwjpjMed+TkaXoH+d++ErXXSCIaImBlzfhIvm4IV9P
         sUTPTHq0oXoD79GYvay6hziAN0G5D4CfTTVacgoNPUmc25LVyjZowPeCxwHnKel0EbBT
         31UQOJEEvL4UUdhtIgGzL5/JToSVW008AdWifjHQ0gVVDMKmRtu9xEpZrv/X6JLfjPx3
         yBz63S0v/L3O4CTN/eJBrhO/sFWOatUw0KNiisUAdTNgr50Oms6EiAjD4rmeL3DajXGG
         OkVPGrE7Ar+Jhmc87jcXgzMXUcpi591bKl+OO4jsQMQ1V7f7tObwY8koShWUzCeVCgAv
         OcHw==
X-Gm-Message-State: AOAM530bQ2dTjy4pk5C53Osbs5WCRMW4ZvUCQIR2dYpwfIgwqB3ai67W
        K5glK7Oj56HsGifpnjXpaTvpa/gHTGoI4/oHHFk=
X-Google-Smtp-Source: ABdhPJzV8VLFk1Y0YSy+/q0IsBxl/pfuTalsdHErHCY3yeflTckxHWV8BtDVQYSa5tjcyJ17/wZC0umzUHxU7Ay9mog=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr711577ott.254.1634753902227;
 Wed, 20 Oct 2021 11:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org> <20210929144451.113334-3-ulf.hansson@linaro.org>
In-Reply-To: <20210929144451.113334-3-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Oct 2021 20:18:11 +0200
Message-ID: <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Wed, Sep 29, 2021 at 4:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the cpuidle-psci case, runtime PM in combination with the generic PM
> domain (genpd), may be used when entering/exiting an idlestate. More
> precisely, genpd relies on runtime PM to be enabled for the attached device
> (in this case it belongs to a CPU), to properly manage the reference
> counting of its PM domain.
>
> This works fine most of the time, but during system suspend in the
> dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> Beyond this point and until runtime PM becomes re-enabled in the
> dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
>
> To make sure the reference counting in genpd becomes correct, we need to
> prevent cpuidle-psci from using runtime PM when it has been disabled for
> the device. Therefore, let's move the call to cpuidle_pause() from
> dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> dpm_resume_noirq() into dpm_resume_early().
>
> Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index cbea78e79f3d..1c753b651272 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
>
>         resume_device_irqs();
>         device_wakeup_disarm_wake_irqs();
> -
> -       cpuidle_resume();
>  }
>
>  /**
> @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
>         }
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
> +       cpuidle_resume();
>         dpm_show_time(starttime, state, 0, "early");
>         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
>  }
> @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
>  {
>         int ret;
>
> -       cpuidle_pause();
> -
>         device_wakeup_arm_wake_irqs();
>         suspend_device_irqs();
>
> @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
>         int error = 0;
>
>         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> +       cpuidle_pause();
>         mutex_lock(&dpm_list_mtx);
>         pm_transition = state;
>         async_error = 0;
> --

Well, this is somewhat heavy-handed and it affects even the systems
that don't really need to pause cpuidle at all in the suspend path.

Also, IIUC you don't need to pause cpuidle completely, but make it
temporarily avoid idle states potentially affected by this issue.  An
additional CPUIDLE_STATE_DISABLED_ flag could be used for that I
suppose and it could be set via cpuidle_suspend() called from the core
next to cpufreq_suspend().

The other guys who rely on the cpuidle pausing today could be switched
over to this new mechanism later and it would be possible to get rid
of the pausing from the system suspend path completely.

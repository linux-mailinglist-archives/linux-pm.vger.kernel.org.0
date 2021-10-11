Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFD428A80
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhJKKHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbhJKKHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 06:07:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E60C061570
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 03:05:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y26so71961333lfa.11
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7cA9NqfV+l2ldiwKTZK6iXcHWSwpaV4+LaQNy+YSxw=;
        b=DHJRAlQ/cdsO002wqdk9U35i1vwGEsuhUrydew3ZbfwrGMuiHim3q+FY/zgXSjLtBJ
         bkOjFr1Wy76JZM8vj4HnCj3tY9Qrm7dKaTbPkD8i8DjItqI6mzVKOZn4knA/v6hBV3tZ
         Qkl3bH4Z7EChWg8dbSHD05ONtYISW2TnjlXsRVTyzGhb830HwXGEK45nYPRJOooqBYDG
         WQ4D6924TpZNHKEX+2/gx/dR/cDffPWK3Bs1KnPaoKqnx+++sx2OhHITerwerl9R3fwr
         Itaf1J67i0H6VXb8KyGDuSAB1vqynd2jLyj6Hlst+KUULBnuNi92Ugb3LLu4RujqNJAV
         AJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7cA9NqfV+l2ldiwKTZK6iXcHWSwpaV4+LaQNy+YSxw=;
        b=waDqZP1+ytyaOfbM9PG26QhYFxgrACjTiHA4urjCJ3xR+YoyUKv1uLeFWosFo34A+K
         viAQHgn+0X4xk8R85DyWygu0KOsoUymgFbtwV5I3xlf6ANgCgCjATpSPA/TTpEqfLH3b
         z8AFgFWK+PLyRHINgL9+4nlcBzi2MGDz7is8KiZdQm3ZyRjvFS0fCbpukfP0QrhvTexk
         voWQNlPtf/I2GNGr8nYnqmWhct8XfFjWsy0PZPgib2S8Kus2JzTg7pbckOj9Bbq8Y+iA
         FMNza1l+UeuYx1YzOjfjFzgiD6OL7PF/nIbp+S4qq1Dip/q68IprRplLBABDAEbkUhWh
         C5aw==
X-Gm-Message-State: AOAM531L/bGp1EVLbYYcSJ6Upktl8H6WAMZVjyl9Lz32NrMqyaAX8867
        U3l6mirVtxcsPCb1XnXqppMDhEemoNhnHXFV25TudA==
X-Google-Smtp-Source: ABdhPJxpc5P58y+Wm08HRpFIFUVVqV+WvrwkxexpxQHYYrEHJZq7Bm2y9XfrGnWChqbEa1jyTK4LdR7a2ZYDwDsUdyI=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr26262661lfb.71.1633946720249;
 Mon, 11 Oct 2021 03:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-2-ulf.hansson@linaro.org> <4692163.31r3eYUQgx@kreacher>
In-Reply-To: <4692163.31r3eYUQgx@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Oct 2021 12:04:44 +0200
Message-ID: <CAPDyKFoo+xXxgqQ71eSObrHyB-djKWkTtOO+nKdhBybOppNgBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: Avoid calls to cpuidle_resume|pause() for s2idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

On Sat, 9 Oct 2021 at 17:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, September 29, 2021 4:44:50 PM CEST Ulf Hansson wrote:
> > In s2idle_enter(), cpuidle_resume|pause() are invoked to re-allow calls to
> > the cpuidle callbacks during s2idle operations. This is needed because
> > cpuidle is paused in-between in dpm_suspend_noirq() and dpm_resume_noirq().
>
> Well, in fact, doing that last thing for s2idle is pointless, because cpuidle
> is going to be resumed eventually anyway in that case and the breakage expected
> to be prevented by the pausing will still occur.
>
> So I would rather do something like the patch below (untested).

Hi Rafael,

From a standalone change point of view, what you suggest seems reasonable to me.

However, the main issue I am really trying to fix in this series is
being done in patch2/2. And unfortunately, the below change doesn't
really fit with what I suggest in patch2/2. Can you please have a look
at patch2 as well?

If you think it may be better, I squash the two patches?

Kind regards
Uffe

>
> ---
>  drivers/base/power/main.c |   11 ++++++-----
>  kernel/power/suspend.c    |    8 ++++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state
>
>         resume_device_irqs();
>         device_wakeup_disarm_wake_irqs();
> -
> -       cpuidle_resume();
>  }
>
>  /**
> @@ -881,6 +879,7 @@ void dpm_resume_early(pm_message_t state
>  void dpm_resume_start(pm_message_t state)
>  {
>         dpm_resume_noirq(state);
> +       cpuidle_resume();
>         dpm_resume_early(state);
>  }
>  EXPORT_SYMBOL_GPL(dpm_resume_start);
> @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state
>  {
>         int ret;
>
> -       cpuidle_pause();
> -
>         device_wakeup_arm_wake_irqs();
>         suspend_device_irqs();
>
> @@ -1521,9 +1518,13 @@ int dpm_suspend_end(pm_message_t state)
>         if (error)
>                 goto out;
>
> +       cpuidle_pause();
> +
>         error = dpm_suspend_noirq(state);
> -       if (error)
> +       if (error) {
> +               cpuidle_resume();
>                 dpm_resume_early(resume_event(state));
> +       }
>
>  out:
>         dpm_show_time(starttime, state, error, "end");
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -97,7 +97,6 @@ static void s2idle_enter(void)
>         raw_spin_unlock_irq(&s2idle_lock);
>
>         cpus_read_lock();
> -       cpuidle_resume();
>
>         /* Push all the CPUs into the idle loop. */
>         wake_up_all_idle_cpus();
> @@ -105,7 +104,6 @@ static void s2idle_enter(void)
>         swait_event_exclusive(s2idle_wait_head,
>                     s2idle_state == S2IDLE_STATE_WAKE);
>
> -       cpuidle_pause();
>         cpus_read_unlock();
>
>         raw_spin_lock_irq(&s2idle_lock);
> @@ -405,6 +403,9 @@ static int suspend_enter(suspend_state_t
>         if (error)
>                 goto Devices_early_resume;
>
> +       if (state != PM_SUSPEND_TO_IDLE)
> +               cpuidle_pause();
> +
>         error = dpm_suspend_noirq(PMSG_SUSPEND);
>         if (error) {
>                 pr_err("noirq suspend of devices failed\n");
> @@ -459,6 +460,9 @@ static int suspend_enter(suspend_state_t
>         dpm_resume_noirq(PMSG_RESUME);
>
>   Platform_early_resume:
> +       if (state != PM_SUSPEND_TO_IDLE)
> +               cpuidle_resume();
> +
>         platform_resume_early(state);
>
>   Devices_early_resume:
>

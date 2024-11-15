Return-Path: <linux-pm+bounces-17637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51CA9CF12A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F00E1F2294C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC81D47C8;
	Fri, 15 Nov 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3YMA3Fu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151981BD507
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687181; cv=none; b=nKvabCJkd7Ql3KIGVvWGHwuIDTHPoYv1KHMpRfS9rCJ4OWMvX2BmeZB6v09gK9cBdYlc9qZhnx6DL3YPI0dChyQBUqB1920Jl1vN5BxKuqoFnagzkYMH6QwfkicqiR477XELVZePlK7qIB4T+GbnJINYjdAnIFeFZO22wDzYOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687181; c=relaxed/simple;
	bh=4bfYNrjswVuJidq47Ya/fdCVfHMQZK6/Z4gowMEudmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci70Srz7npL+Hmq6pK1Pk3Cj0yF84H/Y9cOHGvSj1WjKfJUcGvd9QcEJd+udhIKFTM0ty+MHzauBihD6e8N69uDoqc7KNJBGOQjWl0Ce0Z1HuwHnnJjnENcjRSR6c70BIHzl9mqM79V1mxXXslosMC2QBiJNkXKkvoBGRBxJVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3YMA3Fu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e91403950dso1543842a91.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 08:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731687179; x=1732291979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWH1xmrT8pY5ugzNVdOvWuT5YbA7gCdzuo4wKtoaZ6E=;
        b=U3YMA3FuFQdYSGvy14VhkRoZMr26VKY0xLUq4fRRSd+9Lv7ovb5uN7cubtozyaLqNQ
         IuSL6Qq9by/cJbYr6pjeHwhOfAHk28R3/Y8JnCaEJKlvIUATChT5jLNq1oFV9ySwihMA
         F+xQukppTIruaOS/CxkNhCL8pDnssC1Y3I+V22bdDY7UZFscM6OGo69pVFBzBjM0/Hq2
         dbQcYKF2dB4AjUlI5LFWIDfgQV+9lj9XmkWDE+nYLzplQlTVlgQgZZlVm21GnG0rC+xA
         hYPXJW74yPLYm0Xpe02lsKKKDlH5hjXmh8NqtVa53H87KQ1UtHw3BDamTy5T0UeoBiEh
         iUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687179; x=1732291979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWH1xmrT8pY5ugzNVdOvWuT5YbA7gCdzuo4wKtoaZ6E=;
        b=E7yvzmaaWFGnvCVvs0N5K8tsWcCXGx5TYQm7WKqfa7gHURtV3CAmLxv6e5Qrj+Ygx/
         NcsK8y7TPfR+qo0NsOWexiAvBmY66agzxWgbvhnEsEsOAkpJ11FgVNa3vu8WijCRHSb0
         OxG2+l28F9+Mt8he6RicBWG6TC/Jewa7DSnbOd8ZC9VJM3+moPc5CrK+HjoIS/lgR3jU
         Jsgy4cXfRU5TAghnUQp6NEplgVUL18fgT2JuuksGFRWHojhPyU2Pwjove7zjFy2FZt5d
         Kv2VOwevMpUKhodyCeHa+T+7KXFGRyIBXqSXWk/dhW6BkbdI1yoXDISe11VOESFROrLc
         gDiw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5d4ykfd55/85Rbc3rbBvZ7krcZGQXKQRFNaUY35aKNMdkkjsYJboBMGkLpf3e/EV82ekfyqzFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCFjY+hgRAgzmhclGwO8ovOUv8+Jh7vFXr9wHc0Bsh9/4gXgU
	uGPQG3jx9BI7qpocLfjOtt1dPjtYyHiOHHR9/I2lTiuAs9lon8iG31K6QU7rslxNLiedianCS9m
	2AimZRnHTLUqdsmORy8y2NXCF7/Z8w4mn1DL6Nw==
X-Google-Smtp-Source: AGHT+IGr5IzTg+ybJdJeUHuvXFAHYBBnY80QvW1Y6RpTPDz9n29JmL5yVprdM/jY49NEAnAWc2NhPrRYBnnsgIJct8c=
X-Received: by 2002:a17:90a:e7c6:b0:2ea:10de:1cee with SMTP id
 98e67ed59e1d1-2ea155a2349mr3784765a91.37.1731687179350; Fri, 15 Nov 2024
 08:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com> <20241114220921.2529905-6-saravanak@google.com>
In-Reply-To: <20241114220921.2529905-6-saravanak@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 15 Nov 2024 17:12:48 +0100
Message-ID: <CAKfTPtDYdFQoFjF8zXxXEEcx3frXoSSKxnPonQ6R8eEAJWkVWQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 23:09, Saravana Kannan <saravanak@google.com> wrote:
>
> As of today, the scheduler doesn't spread out all the kworker threads
> across all the available CPUs during suspend/resume. This causes
> significant resume latency during the dpm_resume*() phases.
>
> System resume latency is a very user-visible event. Reducing the
> latency is more important than trying to be energy aware during that
> period.
>
> Since there are no userspace processes running during this time and
> this is a very short time window, we can simply disable EAS during
> resume so that the parallel resume of the devices is spread across all
> the CPUs.
>
> On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
> plus disabling EAS for resume yields significant improvements:
> +---------------------------+-----------+------------+------------------+
> | Phase                     | Old full sync | New full async | % change |
> |                           |               | + EAS disabled |          |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_suspend*() time |        107 ms |          62 ms |     -42% |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_resume*() time  |         75 ms |          61 ms |     -19% |
> +---------------------------+-----------+------------+------------------+
> | Sum                       |        182 ms |         123 ms |     -32% |
> +---------------------------+-----------+------------+------------------+

in cover letter you have figures for
 - Old full sync
 - New full async
 - New full async  + EAS disabled

you should better use the figures for  New full async vs New full
async  + EAS disabled to show EAS disabled impact

I would be interested to get figures about the impact of disabling it
during full suspend sequence as I'm not convince that it's worth the
complexity especially with fix OPP during suspend

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  kernel/power/suspend.c  | 16 ++++++++++++++++
>  kernel/sched/topology.c | 13 +++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..7304dc39958f 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -393,6 +393,12 @@ void __weak arch_suspend_enable_irqs(void)
>         local_irq_enable();
>  }
>
> +/*
> + * Intentionally not part of a header file to avoid risk of abuse by other
> + * drivers.
> + */
> +void sched_set_energy_aware(unsigned int enable);
> +
>  /**
>   * suspend_enter - Make the system enter the given sleep state.
>   * @state: System sleep state to enter.
> @@ -468,6 +474,15 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>
>   Platform_wake:
>         platform_resume_noirq(state);
> +       /*
> +        * We do this only for resume instead of suspend and resume for these
> +        * reasons:
> +        * - Performance is more important than power for resume.
> +        * - Power spent entering suspend is more important for suspend. Also,
> +        *   stangely, disabling EAS was making suspent a few milliseconds
> +        *   slower in my testing.
> +        */
> +       sched_set_energy_aware(0);
>         dpm_resume_noirq(PMSG_RESUME);
>
>   Platform_early_resume:
> @@ -520,6 +535,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>   Resume_devices:
>         suspend_test_start();
>         dpm_resume_end(PMSG_RESUME);
> +       sched_set_energy_aware(1);

If we end up having a special scheduling mode during suspend, we
should make the function more generic and not only EAS/ smartphone
specific

Like a sched_suspend and sched_resume

>         suspend_test_finish("resume devices");
>         trace_suspend_resume(TPS("resume_console"), state, true);
>         resume_console();
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..c069c0b17cbf 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -284,6 +284,19 @@ void rebuild_sched_domains_energy(void)
>         mutex_unlock(&sched_energy_mutex);
>  }
>
> +void sched_set_energy_aware(unsigned int enable)

This is a copy/paste of sched_energy_aware_handler() below, we should
have 1 helper for both

> +{
> +       int state;
> +
> +       if (!sched_is_eas_possible(cpu_active_mask))
> +               return;
> +
> +       sysctl_sched_energy_aware = enable;
> +       state = static_branch_unlikely(&sched_energy_present);
> +       if (state != sysctl_sched_energy_aware)
> +               rebuild_sched_domains_energy();
> +}
> +
>  #ifdef CONFIG_PROC_SYSCTL
>  static int sched_energy_aware_handler(const struct ctl_table *table, int write,
>                 void *buffer, size_t *lenp, loff_t *ppos)
> --
> 2.47.0.338.g60cca15819-goog
>


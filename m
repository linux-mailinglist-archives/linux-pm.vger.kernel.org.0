Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B53275B37
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWPPB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 11:15:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45197 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPPB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:15:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id g96so8223otb.12;
        Wed, 23 Sep 2020 08:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLhyE7P88DmYg4/i6cdyiyPI9KCBG/i6ZZuiz/aXSLc=;
        b=Q4lxKB/nQ2UAVawqaeqehqOj4qKewY+w30Q3EQjP+XK9vEKi3RUeFlDuzFNQo61Pe4
         WS7dQ8/kBbF7TwIU3gsB2I0t8lCJiG46s34Ws9mCLtg9h0MqwEAhagW36TGgZ8iUdL6V
         Eyyhr76muktuxSimtfiicvfgZx0W7ELDhITlbRvJWk8srBR7O0s36CPeoU9eBS73ehn7
         z/QpkOUDslgKZOiwpP8AufndbFmBb3Dw1DPFeLp59GLqNjzmeZbVuJLOSiEGJm+8eFdD
         UEjVCv0cHX1yax4yS1X1/0cWNRYzPFdb7VyDpgYLXkkfowg+3Sp84awGAwJgJzw9zwTn
         jEPg==
X-Gm-Message-State: AOAM53133+ATG7rk9L+BYQqwWbtkN8KOEig6m9w/G5t8UjehwVwD1xmB
        c3eGcjhvKtxrH3w8ldftKn2LP6ljZZdwAUMxr0F2uNC2gfg=
X-Google-Smtp-Source: ABdhPJykR8lBZF2HGW4t494yDOxxknw2beOWkCZU2P5J0lda09bal7FRXuYyNAdAJoX9HWknleYb3Y466Xlu/6zqt2E=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr114896otj.262.1600874100200;
 Wed, 23 Sep 2020 08:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <c9dc39f9956ad9851511d6710e8f8a5cb142789e.1600238586.git.viresh.kumar@linaro.org>
In-Reply-To: <c9dc39f9956ad9851511d6710e8f8a5cb142789e.1600238586.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Sep 2020 17:14:49 +0200
Message-ID: <CAJZ5v0hpT9CAb1hxKcQVA-OJP3UYja=Kqvgh-Ed4N8Ln+=2b5A@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] cpufreq: stats: Enable stats for fast-switch as well
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 16, 2020 at 8:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Now that all the blockers are gone for enabling stats in fast-switching
> case, enable it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c       | 6 +++++-
>  drivers/cpufreq/cpufreq_stats.c | 6 ------
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 47aa90f9a7c2..d5fe64e96be9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2057,8 +2057,12 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                                         unsigned int target_freq)
>  {
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
> +       target_freq = cpufreq_driver->fast_switch(policy, target_freq);
>
> -       return cpufreq_driver->fast_switch(policy, target_freq);
> +       if (target_freq)
> +               cpufreq_stats_record_transition(policy, target_freq);

So this adds two extra branches in the scheduler path for the cases
when the stats are not used at all which seems avoidable to some
extent.

Can we check policy->stats upfront here and bail out right away if it
is not set, for example?

> +
> +       return target_freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 314fa1d506d0..daea17f0c36c 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -69,9 +69,6 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>         ssize_t len = 0;
>         int i;
>
> -       if (policy->fast_switch_enabled)
> -               return 0;
> -
>         for (i = 0; i < stats->state_num; i++) {
>                 if (pending) {
>                         if (i == stats->last_index)
> @@ -115,9 +112,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>         ssize_t len = 0;
>         int i, j, count;
>
> -       if (policy->fast_switch_enabled)
> -               return 0;
> -
>         len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
>         len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
>         for (i = 0; i < stats->state_num; i++) {
> --
> 2.25.0.rc1.19.g042ed3e048af
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7813A290711
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406693AbgJPOVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 10:21:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44892 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406666AbgJPOVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 10:21:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id x62so2581518oix.11;
        Fri, 16 Oct 2020 07:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+Msx894Km+mStI8UCb+zmDoBuIzSy5hxYPbjtCgtYo=;
        b=RvKeyIhW3I+bMdVxmpMTTBw1DHnLK7AQk6O0TX5htnWfFBT74y28Cu9Qa2V1LEqCOj
         cy7o/CQI/Hbe2W86DxPbqSOuEXV+wcx8hnKwqClHaOWS5xGBgf5wN0SlQ0TATGe2OIT+
         a5tf6M2xO22eZCP5oLO1cDiz0PFc14rklCYfA2ipV4YPKtfGwc4AvSdsgUYVi84lvAM0
         jofu2TIYQJKV0wdrzUk4ID9K7QLHo1yB8I5DvCURrNRZqm0Gjb1jKcnmRRbc1w16FSSr
         wXgENmeiIpPkN1CX5fD6ZMtwt9m3jJFOnn3TsgaW/EePcrBhDgCrBGObw/GbyTWxNHk+
         LMhg==
X-Gm-Message-State: AOAM533ZX4kXNbrV+FqDAsMEePy3wI1+hMoyDkZHOIhpffQPayLPmjSv
        Yh7QF9AJSvLGcEgZWPa7VmzbsSziKJJ/aKb2tcw=
X-Google-Smtp-Source: ABdhPJzUaqOCepfqqlp3XTiV86lgRQAGCRVZbjSYBQ6ueBWwAT7o0VYma1/tzOUrqQitO3OjUvbD5bL3BVao6/lPsJg=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2648814oii.69.1602858096113;
 Fri, 16 Oct 2020 07:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <37c3f1f76c055b305d1bba2c2001ac5b1d7a9b5f.1602565964.git.viresh.kumar@linaro.org>
In-Reply-To: <37c3f1f76c055b305d1bba2c2001ac5b1d7a9b5f.1602565964.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 16:21:25 +0200
Message-ID: <CAJZ5v0iYWf=SFnVeVcrWpD40vR+axdX9NrXxftdVH4PDeiNz7g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Improve code around unlisted freq check
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 7:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq core checks if the frequency programmed by the bootloaders
> is not listed in the freq table and programs one from the table in such
> a case. This is done only if the driver has set the
> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag.
>
> Currently we print two separate messages, with almost the same content,
> and do this with a pr_warn() which may be a bit too much as the driver
> only asked us to check this as it expected this to be the case. Lower
> down the severity of the print message by switching to pr_info() instead
> and print a single message only.
>
> Reported-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2ea245a6c0c0..99864afac272 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1461,14 +1461,13 @@ static int cpufreq_online(unsigned int cpu)
>          */
>         if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
>             && has_target()) {
> +               unsigned int old_freq = policy->cur;
> +
>                 /* Are we running at unknown frequency ? */
> -               ret = cpufreq_frequency_table_get_index(policy, policy->cur);
> +               ret = cpufreq_frequency_table_get_index(policy, old_freq);
>                 if (ret == -EINVAL) {
> -                       /* Warn user and fix it */
> -                       pr_warn("%s: CPU%d: Running at unlisted freq: %u KHz\n",
> -                               __func__, policy->cpu, policy->cur);
> -                       ret = __cpufreq_driver_target(policy, policy->cur - 1,
> -                               CPUFREQ_RELATION_L);
> +                       ret = __cpufreq_driver_target(policy, old_freq - 1,
> +                                                     CPUFREQ_RELATION_L);
>
>                         /*
>                          * Reaching here after boot in a few seconds may not
> @@ -1476,8 +1475,8 @@ static int cpufreq_online(unsigned int cpu)
>                          * frequency for longer duration. Hence, a BUG_ON().
>                          */
>                         BUG_ON(ret);
> -                       pr_warn("%s: CPU%d: Unlisted initial frequency changed to: %u KHz\n",
> -                               __func__, policy->cpu, policy->cur);
> +                       pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
> +                               __func__, policy->cpu, old_freq, policy->cur);
>                 }
>         }
>
> --

Applied as 5.10-rc material, thanks!

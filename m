Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86A150A62
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 16:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBCP6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 10:58:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45814 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgBCP6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 10:58:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so15176059oic.12;
        Mon, 03 Feb 2020 07:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNy1sNVUArXTL8VJUA8IVgEv6FUx+7xlRaj38yN9+Ik=;
        b=c4YUUZR2ALNr8ZOgLymmhULkleAD2QDlQ88ZvstQx3J00QZr034vr5gQ/1tIWtZhG5
         U2EJ0T0wyXRgBoHm8I94F/AomoKRj1hXsTptOj2KmCGU9toAt22570T8KxfE7ngnGOPh
         DoRMKBPStsdS1MD9+Y/2gQI32/VKhyoYVR8kOsyQ2Y4F4ny2TF1gOM46oSMNQNE5dBl6
         MWj6NQpMfWUwuSIp3WS/VDDwWZH9d2CZ5RwrpLg4joLycLTYqnPWrORin6IO3ygBcqra
         H4EzttECPXMAIXJimwRuC/eBpG7EU6JRfk2/yXaIWeAszCMajWanwTtSqlE89kSU80WT
         S89w==
X-Gm-Message-State: APjAAAWKnPtN/n8KVgoIZ0KtZ3z84jpOWkyA5dSwsuv/jZmFDEHm+hu/
        fQHMxvjFf+Sc+7o8GefMKk1TIDuq0zsC6PbLh+w=
X-Google-Smtp-Source: APXvYqyQP8HF/CGvf81WGV+tfzuoYmp1mCJV4HWnW40HlY1nO7ttJlcUOMUBmkSYp2uY0oUipXcv8RgVWcI7NCUZHT8=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr15585763oig.103.1580745483499;
 Mon, 03 Feb 2020 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20200203154517.2347-1-tiny.windzz@gmail.com>
In-Reply-To: <20200203154517.2347-1-tiny.windzz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Feb 2020 16:57:52 +0100
Message-ID: <CAJZ5v0hRnCXqDhee4UENYzqka3--2Vhnu3TWikrWJtGcq6aimA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: make cpufreq_global_kobject static
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 3, 2020 at 4:45 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> The cpufreq_global_kobject is only used internally by cpufreq.c
> after this:
>
> commit 2361be236662 ("cpufreq: Don't create empty
> /sys/devices/system/cpu/cpufreq directory")
>
> Make it static.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 +---
>  include/linux/cpufreq.h   | 3 ---
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4adac3a8c265..a0831d3d5ed1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -105,6 +105,7 @@ bool have_governor_per_policy(void)
>  }
>  EXPORT_SYMBOL_GPL(have_governor_per_policy);
>
> +static struct kobject *cpufreq_global_kobject;
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
>  {
>         if (have_governor_per_policy())
> @@ -2745,9 +2746,6 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
>
> -struct kobject *cpufreq_global_kobject;
> -EXPORT_SYMBOL(cpufreq_global_kobject);
> -
>  static int __init cpufreq_core_init(void)
>  {
>         if (cpufreq_disabled())
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 018dce868de6..0fb561d1b524 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -201,9 +201,6 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
>         return cpumask_weight(policy->cpus) > 1;
>  }
>
> -/* /sys/devices/system/cpu/cpufreq: entry point for global variables */
> -extern struct kobject *cpufreq_global_kobject;
> -
>  #ifdef CONFIG_CPU_FREQ
>  unsigned int cpufreq_get(unsigned int cpu);
>  unsigned int cpufreq_quick_get(unsigned int cpu);
> --

Applied as 5.6 material with minor modification, thanks!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D449B30FB76
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhBDS2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 13:28:34 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41761 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbhBDS2I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 13:28:08 -0500
Received: by mail-oi1-f177.google.com with SMTP id m13so4694120oig.8;
        Thu, 04 Feb 2021 10:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O++Ni8S6CV3MVdO8ZTSo7Rk4YCUFt3D0XWVU9XGT+a8=;
        b=OhvX5VCmd9zqE54QVuBZUOXNhvwbNZEc0t3MXEsz79gE1WFCOqzyxWwuAAJwVmx8Cn
         340nXLrIv4VE8xYm9A6kHjQYyw0Wqu/8rp6R7m2Mw1jP/UBsIyVkuff3IUqGoMu452Sa
         fDsnmP5UV6ieJCNzvSA1sod5kcRKM/swVKcep898pPIUFj+7Gyz8/53sBpYXk6M5pcGr
         8APu8YhSqcQkX8yMfXqhfP9hxTX5/1MD7FA/6LZdyA8UXKh+BVQ5BZJV2ZP/x0dWqNbr
         AI2LRqYDJZfEPw4UfuJJ+NG8hAB4cs7+RvJV2MCEB6rjEXygb2xggSWQ2/TLZGlFma9S
         fpGA==
X-Gm-Message-State: AOAM531ab3JkBe5vHq2Ww6Mv899Tkx619ms8TBhstf61v6IylFhsYzWW
        TpTyHQBFZX/KZCeI7AV3cSqFIx3OT0N4Odkp2us=
X-Google-Smtp-Source: ABdhPJxkhKYk4oXkJeTKUtjMr66fakUbvZ+6flWoKUE4tBqAvByzPRwDVWs4bapr1CEIe0d2dayBEHB5xmsWwJ+pEuE=
X-Received: by 2002:aca:308a:: with SMTP id w132mr529264oiw.69.1612463247909;
 Thu, 04 Feb 2021 10:27:27 -0800 (PST)
MIME-Version: 1.0
References: <bed6bc7e15c3ed398dd61b8f3968049f1f16b1b6.1612244449.git.viresh.kumar@linaro.org>
In-Reply-To: <bed6bc7e15c3ed398dd61b8f3968049f1f16b1b6.1612244449.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 19:27:16 +0100
Message-ID: <CAJZ5v0hFFXKnnTdkc3SHoSNPO06pDAWjudvxSjxQ6eOOnuXq_A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Remove unused flag CPUFREQ_PM_NO_WARN
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 2, 2021 at 6:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This flag is set by one of the drivers but it isn't used in the code
> otherwise. Remove the unused flag and update the driver.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.12 material, thanks!

> ---
> Rebased over:
>
> https://lore.kernel.org/lkml/a59bb322b22c247d570b70a8e94067804287623b.1612241683.git.viresh.kumar@linaro.org/
>
>  drivers/cpufreq/pmac32-cpufreq.c |  3 +--
>  include/linux/cpufreq.h          | 13 +++++--------
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 73621bc11976..4f20c6a9108d 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -439,8 +439,7 @@ static struct cpufreq_driver pmac_cpufreq_driver = {
>         .init           = pmac_cpufreq_cpu_init,
>         .suspend        = pmac_cpufreq_suspend,
>         .resume         = pmac_cpufreq_resume,
> -       .flags          = CPUFREQ_PM_NO_WARN |
> -                         CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
> +       .flags          = CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
>         .attr           = cpufreq_generic_attr,
>         .name           = "powermac",
>  };
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c8e40e91fe9b..353969c7acd3 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -398,8 +398,11 @@ struct cpufreq_driver {
>  /* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
>  #define CPUFREQ_CONST_LOOPS                    BIT(1)
>
> -/* don't warn on suspend/resume speed mismatches */
> -#define CPUFREQ_PM_NO_WARN                     BIT(2)
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device.
> + */
> +#define CPUFREQ_IS_COOLING_DEV                 BIT(2)
>
>  /*
>   * This should be set by platforms having multiple clock-domains, i.e.
> @@ -431,12 +434,6 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING      BIT(6)
>
> -/*
> - * Set by drivers that want the core to automatically register the cpufreq
> - * driver as a thermal cooling device.
> - */
> -#define CPUFREQ_IS_COOLING_DEV                 BIT(7)
> -
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>
> --
> 2.25.0.rc1.19.g042ed3e048af
>

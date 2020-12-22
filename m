Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEEB2E0A46
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgLVNH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 08:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgLVNHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 08:07:55 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1006C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 05:07:15 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id u7so6958141vsg.11
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJdu5vDMCx/ujY8a+bGU6qSDx1c5AEdKsGzNSm0hWYM=;
        b=ZOkedPHy4xDcFa7mDeWTvIVw1qhHj0i/j5RlW/oihYFku5fnb2+MKebLyfJpZG1Scs
         p+8CM5tzMgX3cLenZdaj6q0KFsGKBX8othYLqNA8fVlvnCL2dFiy2uNP6nYAkKL3w90M
         aynZZQjH9sGpf1h2EULcPKDcANWeKEBxNlbGetTNSUbe3e/6jc6NBSmwos8Uj6ZkZCyE
         LzRpD1SZgCD0Gnsk3B8TB3qfbZ2neN/PAwBEuqsrEPCsYBvvFPlRxA5knGREyIe8avKw
         hR/pG6BbKVC0zQDAUe9CYF8ttogPiE8piQjA9rLncF5Cw3GB9EuHFZzmnc+00BmWPXAE
         hvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJdu5vDMCx/ujY8a+bGU6qSDx1c5AEdKsGzNSm0hWYM=;
        b=PU2XP8npzt7IvkM2OWvDwkPKFbzdH074AT/5occUr5UPJOIF8K58B1JWDdRI5/RIJt
         bw9NBtlFiVpKeJjMxe0PAqKQ087oJjWtsA9tUTE7iFOc+T/ZE4yvmXP7mEOReT1rPXGG
         QfVe26vzkSxfYEpSKUteuj+etEGw7A9ZkhC4kV1ASBrMNKHLPD3c8k/bAsZbL5U4Yr91
         +QJCBz8KdUxQzXHs5/K6590y4xKhqSfH6GMs0gK3tBUfkMP4EfJjdG7GCpk4IGaDPyzX
         qaFFmabtzVx5l9p7ZC5DwC0RzMvKdDu2K6kkzQXFRAmBcfMFsx1bTrtx+dXPbarR2b6x
         2q1g==
X-Gm-Message-State: AOAM533Oih1F1R2j4mlpD2ZOOA3ig+SLueUur5sTS1wT4ZsvIjqygEEQ
        2ZzFPQqcEV20hd3rHN4ZieEOiwy8DUDS+LAKPvrG1/ov67WK/Q==
X-Google-Smtp-Source: ABdhPJwLLXzicnAhS9NdWV6aM8UTBiKQmmvSZ8pRvEydd7nXMyhANVh3BHf14B+GdIkx4jtUNgSs02f88RZkQvRYqow=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr14980585vsc.34.1608642434179;
 Tue, 22 Dec 2020 05:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130225039.15981-1-ilina@codeaurora.org> <20201130225039.15981-2-ilina@codeaurora.org>
In-Reply-To: <20201130225039.15981-2-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Dec 2020 14:06:38 +0100
Message-ID: <CAPDyKFr0+Hzod+cq1gBN66O-Tvt5RAB2aK=rzcqGaPF41TMRnQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] PM / Domains: add domain feature flag for next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Nov 2020 at 23:51, Lina Iyer <ilina@codeaurora.org> wrote:
>
> PM domains may support entering multiple power down states when the
> component devices and sub-domains are suspended. Also, they may specify
> the residency value for an idle state, only after which the idle state
> may provide power benefits. If the domain does not specify the residency
> for any of its idle states, the governor's choice is much simplified.
>
> Let's make this optional with the use of a PM domain feature flag.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v6:
>         - New patch based on discussions on v5 of the series
> ---
>  drivers/base/power/domain.c | 18 ++++++++++++++++++
>  include/linux/pm_domain.h   | 28 ++++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1b0c9ccbbe1f..1e6c0bf1c945 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1748,6 +1748,24 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_remove_notifier);
>
> +/**
> + * genpd_enable_next_wakeup - Enable genpd gov to use next_wakeup
> + *
> + * @genpd: The genpd to be updated
> + * @enable: Enable/disable genpd gov to use next wakeup
> + */
> +void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable)
> +{
> +       genpd_lock(genpd);
> +       if (enable)
> +               genpd->flags |= GENPD_FLAG_GOV_NEXT_WAKEUP;
> +       else
> +               genpd->flags &= ~GENPD_FLAG_GOV_NEXT_WAKEUP;
> +       genpd->next_wakeup = KTIME_MAX;
> +       genpd_unlock(genpd);
> +}
> +EXPORT_SYMBOL_GPL(genpd_enable_next_wakeup);
> +

Please drop this, as I don't think we need a dedicated function to
enable this feature.

Instead, it seems like a better idea to let the genpd provider set it,
before it calls pm_genpd_init(), along with its other genpd
configurations.

>  static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>                                struct generic_pm_domain *subdomain)
>  {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2ca919ae8d36..1f359bd19f77 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -55,13 +55,19 @@
>   *
>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM domain
>   *                             powered on except for system suspend.
> + *
> + * GENPD_FLAG_GOV_NEXT_WAKEUP: Enable the genpd governor to consider its
> + *                             components' next wakeup when  determining the
> + *                             optimal idle state. This is setup only if the
> + *                             domain's idle state specifies a residency.
>   */
> -#define GENPD_FLAG_PM_CLK       (1U << 0)
> -#define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> -#define GENPD_FLAG_ALWAYS_ON    (1U << 2)
> -#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
> -#define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> -#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> +#define GENPD_FLAG_PM_CLK         (1U << 0)
> +#define GENPD_FLAG_IRQ_SAFE       (1U << 1)
> +#define GENPD_FLAG_ALWAYS_ON      (1U << 2)
> +#define GENPD_FLAG_ACTIVE_WAKEUP   (1U << 3)
> +#define GENPD_FLAG_CPU_DOMAIN     (1U << 4)
> +#define GENPD_FLAG_RPM_ALWAYS_ON   (1U << 5)
> +#define GENPD_FLAG_GOV_NEXT_WAKEUP (1U << 6)

Nitpick.

To me, the configuration is something that corresponds to the genpd,
rather than the governor (even if it affects it in this case). That
said, how about just naming the flag something like
"GENPD_FLAG_MIN_RESIDENCY", as to indicate that the genpd's power off
states have minimum residencies values that may deserve to be
considered, while power off.

>
>  enum gpd_status {
>         GENPD_STATE_ON = 0,     /* PM domain is on */
> @@ -205,6 +211,11 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>         return to_gpd_data(dev->power.subsys_data->domain_data);
>  }
>
> +static inline bool genpd_may_use_next_wakeup(struct generic_pm_domain *genpd)
> +{
> +       return genpd->flags & GENPD_FLAG_GOV_NEXT_WAKEUP;
> +}

This can probably be moved into drivers/base/power/domain_governor.c.

> +
>  int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
>  int pm_genpd_remove_device(struct device *dev);
>  int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> @@ -217,6 +228,7 @@ int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
> +void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -275,6 +287,10 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>         return -EOPNOTSUPP;
>  }
>
> +static void genpd_enable_next_wakeup(struct generic_pm_domain *genpd,
> +                                    bool enable)
> +{ }
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Kind regards
Uffe

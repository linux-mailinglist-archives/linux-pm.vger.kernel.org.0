Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820562E0A5C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgLVNLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 08:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgLVNLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 08:11:10 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89DC0613D3
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 05:10:29 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id h6so6962979vsr.6
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 05:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wORpCwP/PH7s5v92DGchLRrRHanaLYyHWLFD2f49ktc=;
        b=ksk+439Sk7N6zd0mHMVvriWtabkZ/kswQIrKCA/dX+chsH7bcRYZO3Z5g3GJkeRgbV
         rOzviJt3v+emac3wOKUgE0XDCjgtKHVLhOW2pYSq+1Iz3yfBKT75YPgygMY4aZDVpMGH
         gFCbWJmnKodLoIAGgZhHMACf+XgGBju/u5ci1apGvOGaae+MVXFwO++iU8dwlqh5m2YG
         AfJsuevFByOI9YKVAjs+Bwga1CfNcqOF6go9PD/mGtFe5vr8959Yxu2Hyt3DeD83mSb1
         YJNWzuACBVWzhfKyk/leEbqyQgb2ZWJlYXOAUkalFajfWJz0XgVLPKxzkJnD5X2YQBy+
         54bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wORpCwP/PH7s5v92DGchLRrRHanaLYyHWLFD2f49ktc=;
        b=QQb9JPivK2BFHzgipAEmUd8LIX/gv/tNiiujuExPbipaLECPfFkapVLNzaSe+ej0NJ
         gxDEZIcKnJCi+zWqccDTa76KZLD3n6nLKf4guym7ySpjh1qSoHR7RhL3n44eHBE/EVlX
         77Pn8kzp5LIr+4tAVAJ8jO1YcgoZj1vDQP3yD2HMQ4Hw5W+UtOnPTw/4T23OGOJW96DM
         OXQ0P7vQJoznu3otXxQ1y22hUqvwtuA6ccGv+Wfyx5q4ssGqgd2JVfaPx5Y50Bj+cbu4
         vckYkZ0nA1gC6mkxvHHn0ZkpsEREDFSy8zx9WFu3pLGXvHLBXnjrZq8nGwihilWTPmKr
         uQfA==
X-Gm-Message-State: AOAM530I/5XoBXXCvHoDKNj6OQ8H5oyuokEj7ygALaSpA86FbKRVNNyP
        GjAEdCFRjLrPMeZpPOfb5Ga4/nEEHiznfKSZzGH9ug==
X-Google-Smtp-Source: ABdhPJwas99cyWHLX7z53I4QehDGkR8rAswPZcKi5vG56Nm0h2QZcGL/wmcAMnou7UbgWcIit05vLDx5y/pxtHQ4rZc=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr14600149vsr.19.1608642628595;
 Tue, 22 Dec 2020 05:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20201130225039.15981-1-ilina@codeaurora.org> <20201130225039.15981-3-ilina@codeaurora.org>
In-Reply-To: <20201130225039.15981-3-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Dec 2020 14:09:52 +0100
Message-ID: <CAPDyKFphczBOyDmSQBh3PE7YaUBYy4Y5uoozrv4QOf4pEbk-yg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PM / domains: inform PM domain of a device's next wakeup
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
> Some devices may have a predictable interrupt pattern while executing
> usecases. An example would be the VSYNC interrupt associated with
> display devices. A 60 Hz display could cause a interrupt every 16 ms. If
> the device were in a PM domain, the domain would need to be powered up
> for device to resume and handle the interrupt.
>
> Entering a domain idle state saves power, only if the residency of the
> idle state is met. Without knowing the idle duration of the domain, the
> governor would just choose the deepest idle state that matches the QoS
> requirements. The domain might be powered off just as the device is
> expecting to wake up. If devices could inform PM frameworks of their
> next event, the parent PM domain's idle duration can be determined.
>
> So let's add the dev_pm_genpd_set_next_wakeup() API for the device to
> inform PM domains of the impending wakeup. This information will be the
> domain governor to determine the best idle state given the wakeup.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v6:
>         - Update documentation
> Changes in v5:
>         - Fix commit text as pointed by Ulf
>         - Use -EOPNOTSUPP
> Changes in v4:
>         - Use PM domain data to store next_wakeup
>         - Drop runtime PM documentation
> Changes in v3:
>         - Fix unwanted change
> Changes in v2:
>         - Update documentation
>         - Remove runtime PM enabled check
>         - Update commit text
> ---
>  drivers/base/power/domain.c | 41 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 ++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1e6c0bf1c945..191539a8e06d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -408,6 +408,46 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>
> +/**
> + * dev_pm_genpd_set_next_wakeup - Notify PM framework of an impending wakeup.
> + *
> + * @dev: Device to handle
> + * @next: impending interrupt/wakeup for the device
> + *
> + * Allow devices to inform of the next wakeup. But, if the domain were already
> + * powered off, we will not wakeup the domain to recompute it's idle duration.

How about clarifying this as:

"It's assumed that the users guarantee that the genpd wouldn't be
detached while this routine is getting called. Additionally, it's also
assumed that @dev isn't runtime suspended (RPM_SUSPENDED).

> + * Although devices are expected to update the next_wakeup after the end of
> + * their usecase as well, it is possible the devices themselves may not know
> + * about that. Stale @next will be ignored when powering off the domain.
> + */
> +int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> +{
> +       struct generic_pm_domain *genpd;
> +       struct generic_pm_domain_data *gpd_data;
> +       int ret = -EINVAL;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return -ENODEV;
> +
> +       if (WARN_ON(!dev->power.subsys_data ||
> +                   !dev->power.subsys_data->domain_data))
> +               return ret;
> +
> +       genpd_lock(genpd);
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +       if (ktime_before(ktime_get(), next)) {
> +               gpd_data->next_wakeup = next;
> +               genpd->flags |= GENPD_FLAG_GOV_NEXT_WAKEUP;

I don't think we should set this here, but instead leave this to be
set by the genpd provider at initialization.

> +               ret = 0;
> +       }
> +       genpd_unlock(genpd);

I would suggest to simplify the above into:

gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
gpd_data->next_wakeup = next;

Then there is no need for locks because:
*) We assume the device remains attached to the genpd.
**) The device isn't runtime suspended, hence its corresponding genpd
is powered on and thus the genpd governor can't be looking at
"gpd_data->next_wakeup" simulantfsfulsy.

Moreover, as we agreed to ignore stale values for "next", there is no
reason to validate it against the current ktime, so let's just skip
it.

> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
> +
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -1450,6 +1490,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
>         gpd_data->td.constraint_changed = true;
>         gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
> +       gpd_data->next_wakeup = KTIME_MAX;

When looking at patch3, I wonder if it perhaps could be easier to use
"zero" as the default value? What do you think, just an idea?

>
>         spin_lock_irq(&dev->power.lock);
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1f359bd19f77..cc27d3d88849 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_PM_DOMAIN_H
>
>  #include <linux/device.h>
> +#include <linux/ktime.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/err.h>
> @@ -197,6 +198,7 @@ struct generic_pm_domain_data {
>         struct notifier_block *power_nb;
>         int cpu;
>         unsigned int performance_state;
> +       ktime_t next_wakeup;
>         void *data;
>  };
>
> @@ -229,6 +231,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
>  void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable);
> +int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -291,6 +294,11 @@ static void genpd_enable_next_wakeup(struct generic_pm_domain *genpd,
>                                      bool enable)
>  { }
>
> +static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> +{
> +       return -EOPNOTSUPP;
> +}
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

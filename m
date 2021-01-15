Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD82F791F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 13:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbhAOMbq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732777AbhAOMbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 07:31:43 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39308C0613C1
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 04:31:03 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t16so2110754vkl.10
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 04:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/BesD9/XsuCseYpXAMWyVXZDWL3uMJKI3ILP+bL1nM=;
        b=EVSVVLgC50T2uyGnNfHMt2uCsfvy6zHMK8mlEATSOs/yZVq/wF6KaPEBiicPuNzfVI
         Q0+wf/Vcrh/T2Bd2NK30Pq+PtgYiF0Jc5eYW54IhGWqmA7HVK0Xcc6DzRbYtNyUOeufc
         d1RRC9PhHKWiXCYnsmI78wluOs/rKMdOXC1/LwQQ3/cp14tkAhLwVD2zWNirmGb+gWwZ
         M0KVTDZwsSoJTm5dJOPG8GO7Mwdqzc2AlhNra4/tMZEm09u/9tCg/GGkkIcy3GRGE7Vr
         xQvK0qpgj3xa4SWJ+38K7QPVTE4KhAYknLYmKtpabCK9hpwFJzlLFc0czkNn1r9BT4+m
         HHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/BesD9/XsuCseYpXAMWyVXZDWL3uMJKI3ILP+bL1nM=;
        b=DnzPqxQs5ov1+WrSXOLK3mzBae3bRvg4OVwRyxEuzyFn3Hk3iL2vGjcIchyZXjr6M8
         lwhsv2CSXrDTVc5XUamju1jk+Yz4/mAZOKc7sh7oMqfEg4UkUQnjgviLj5T5bGPj2GMy
         uaqNc/BxSj0k5G19Zkjb99B/Tp53vXzMVyDvJTbAKqz+k2iL2/i6uZbj0KMto+sXCvgx
         OWZEYEaErG8GGe8B1WCoXvE2/3DpyjemFGwVWdgaWwBtl6To8TqM93CGusX4owp1e6SP
         njApic6Dxym9TD2qJoDAO0N9kRE6vOt/FCScg6QNd35E6DORqXMyVoWXl8+2+YSNO92W
         b28w==
X-Gm-Message-State: AOAM530/4fvKipEW3ZtW4qfWh7KVXYsTz5YXfYXWtJnDBktG/Eob4729
        di8GB5nBYP6V5Zj6iD29kCYQjgHOrnb05pOyrMLv05kBPSZErLQJ
X-Google-Smtp-Source: ABdhPJwnw0wYStzAzhvHcIVldC/k54ts3D4KwQQmeCHPWy3OtuRL/xnr+7+VwpA6vGJ5opV8FygsDNwcBKrUCtSZ2x8=
X-Received: by 2002:a1f:5fd5:: with SMTP id t204mr9681211vkb.6.1610713862303;
 Fri, 15 Jan 2021 04:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20210113201601.14874-1-ilina@codeaurora.org> <20210113201601.14874-2-ilina@codeaurora.org>
In-Reply-To: <20210113201601.14874-2-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jan 2021 13:30:26 +0100
Message-ID: <CAPDyKFqQxPMo_U7i7iAWZcXFQOSvP4UjdE6N9Mu_fHdpCdYGOA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] PM / domains: inform PM domain of a device's next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Jan 2021 at 21:16, Lina Iyer <ilina@codeaurora.org> wrote:
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

One comment below about the documentation of the new interface. WIth
that fixed, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Changes in v7:
>         - Simplify and set next-wakeup locklessly
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
>  drivers/base/power/domain.c | 22 ++++++++++++++++++++++
>  include/linux/pm_domain.h   |  6 ++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eedacb92..1a6174babe94 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -423,6 +423,27 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
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
> + * Although devices are expected to update the next_wakeup after the end of
> + * their usecase as well, it is possible the devices themselves may not know
> + * about that. Stale @next will be ignored when powering off the domain.

Sorry for nagging (same comment as for the previous version), but
could you please extend the above with the below text, as to make it
more clear:

"It's assumed that the users guarantee that the genpd wouldn't be
detached while this routine is getting called. Additionally, it's also
assumed that @dev isn't runtime suspended (RPM_SUSPENDED)."

With this, you don't need to mention the thing with the state of the
PM domain, as it can't be powered off when this function is called.

> + */
> +void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> +{
> +       struct generic_pm_domain_data *gpd_data;
> +
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +       gpd_data->next_wakeup = next;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -1465,6 +1486,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
>         gpd_data->td.constraint_changed = true;
>         gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
> +       gpd_data->next_wakeup = KTIME_MAX;
>
>         spin_lock_irq(&dev->power.lock);
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2ca919ae8d36..735583c0bc6d 100644
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
> @@ -191,6 +192,7 @@ struct generic_pm_domain_data {
>         struct notifier_block *power_nb;
>         int cpu;
>         unsigned int performance_state;
> +       ktime_t next_wakeup;
>         void *data;
>  };
>
> @@ -217,6 +219,7 @@ int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
> +void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -275,6 +278,9 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>         return -EOPNOTSUPP;
>  }
>
> +static inline void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> +{ }
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

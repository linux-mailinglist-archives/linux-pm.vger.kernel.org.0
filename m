Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A992A9491
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKFKjt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgKFKjs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:39:48 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE8C0613D2
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 02:39:48 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id f7so393915vsh.10
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 02:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LfqbFVQDf6EnKMtM2PNGP+fMgWiqJYrhuyrC9aGMG0=;
        b=Cn2FkJpPTwrScEBFP30KmR+ETYrdD8nqf3x0CR71mlDkB4y4y6gIHcwT3ZztSbJo+G
         rtY0jbK/4OeoFy7GNlca3ZyqajC86XuArno5O2bv4txDNs6kYwIdCpd89ncbLw4Jwx8b
         H7BfHfXVug9QIobm+rS6noOyXDdrzJVelFJJBwGl6pwh8vA8uJ/YLStxGDJoLW3Ih6ug
         jdVPeNH0DvkT+BWeLf8eCxH++yirPopFQ/pg9MhSqR6qo0HG1ttke1qvaGoqK3o+6erc
         7sFC83bhEERz3eH1wR1xnG/ZDGd9exD0su5iaY9KsSbH2nas5lPKxJk7Fi7J7V0Ev3vE
         wYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LfqbFVQDf6EnKMtM2PNGP+fMgWiqJYrhuyrC9aGMG0=;
        b=HkHWzGljRudem+kFKGguvCilf/06SwhBSafyI6vNzvPg/uBD8IccIFqFUljeol0tyU
         xQ4n1FfqKwFpCgJpnBBUDs+Z/6EIVkgk7e5vuTwoQ2guQFIIfoo21Mfs6RBRdUk/TrTn
         L8Ye9vwbkshGAeybKSg2QjNf0cW2EXxQymCCiHGC8r8Pa/3sI3Eru/WC3AcDU/Cpk5XD
         kZ1E4nq4R9+j/HKJ3qjSEDhVhGYreqt2h94PrQg/ZUXxCfPWA5dxm1N/SWEQ2jWlWdou
         /4TkXBo48YbAXeDVoKQKT1PCPgW2uPIipNBjv/DlfEGOnQSR80JsJPDIPuwwP2Zm3BQp
         IyXQ==
X-Gm-Message-State: AOAM531ZEHxe63OhtpSAXNBZHYt+xyWneLVPfgqRlWLZsjEYxRVHrYNz
        BISJRdIVYRf4T9tTLr9Op49MTfytYDxTom310kUE5g==
X-Google-Smtp-Source: ABdhPJwrrFjUmTEUgSw8KM5zff+kHxaTrTuy1pzw1Z5kVj4qG2MA9Af7aUi7pmz3zMyJk2E8QE6UlKcxpK/Mv0DkSZU=
X-Received: by 2002:a67:3256:: with SMTP id y83mr522273vsy.48.1604659187176;
 Fri, 06 Nov 2020 02:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20201020180413.32225-1-ilina@codeaurora.org> <20201020180413.32225-2-ilina@codeaurora.org>
In-Reply-To: <20201020180413.32225-2-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Nov 2020 11:39:10 +0100
Message-ID: <CAPDyKFoJkPYG4Qc4gbX6uW7vr1OJm7hXfznU+oSs2kvqSjufUw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM / domains: inform PM domain of a device's next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Oct 2020 at 20:04, Lina Iyer <ilina@codeaurora.org> wrote:
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
> So let's add the pm_genpd_set_next_wake() API for the device to notify

/s/pm_genpd_set_next_wake/dev_pm_genpd_set_next_wakeup

Also, please don't use the word "notifiy", but rather "inform" or
similar - to not confuse things with the kernel notifiers.

There are some more examples below in the patch where "notify" is
used, please have a look at those as well.

> PM domains of the impending wakeup. This information will be the domain
> governor to determine the best idle state given the wakeup.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Other than the nitpicks above, this looks good to me:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
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
>  drivers/base/power/domain.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 ++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 743268996336..34b90e77e0cd 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -408,6 +408,41 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
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
> +               ret = 0;
> +       }
> +       genpd_unlock(genpd);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -1431,6 +1466,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
>         gpd_data->td.constraint_changed = true;
>         gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
> +       gpd_data->next_wakeup = KTIME_MAX;
>
>         spin_lock_irq(&dev->power.lock);
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1ad0ec481416..e00c77b1efd8 100644
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
> +int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -275,6 +278,11 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>         return -ENOTSUPP;
>  }
>
> +static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> +{
> +       return -ENOTSUPP;
> +}
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

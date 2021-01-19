Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2E2FBA26
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 15:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbhASOor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 09:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389315AbhASKC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 05:02:28 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEFDC0613C1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 02:01:27 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id p20so3468224vsq.7
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 02:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFiICJwniMc0Mg91xgmY2/SkSt2U98JxqZWHMzErHqI=;
        b=EJRJbsr3k7ZHbk8Tfyu4r3RFd7m7/nXBSpmTxaHZ1j6GYoE3PHBScLqAWa0H1U+VXq
         24pDFQT09sOrdWpptqcrUJt89G0GBdQoHexg9QHOjqLyqD1c6lH3B9zfEJBjmaX6wgg3
         5eOOPxFTyAs17E+U4GWXMLgn5jC9xvbCY5LBV5gDTi0pQf4eGOGX6YwUXWN0opi55hFF
         ZpepDAm2dyDyds6SJp9u6VSkRYwFL8lq8FfayCw8xs3a7SEVaBFi/0XWHRNDt9Fufo3J
         r20PFRCQOBbitGw81vBlUkwyzw2j1SvkwiIubHo3QRPYAlBqubrwQJQm959qigD67a4f
         BYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFiICJwniMc0Mg91xgmY2/SkSt2U98JxqZWHMzErHqI=;
        b=UqNfkgg6yWwxdaJKQzZrSR134Raa6SjBrYwAtqA7vxzGSYnClEalunBe2cYpdwcoDg
         O79NpStPmh9T98MgD/o0Bbu9jNki9BsERa+x8XXw2+71MOYLABJ0g01cXLIWZQSkOdt4
         kms1esbHpZVeEmk+2R3IvjYocNr9IzT0hHAESdszFj+/UxgYi/sNIOBGBbBsZWYLLXtJ
         MzYVN9skKQVM2eQrH+/LXcemN2HIfH0rRG9iQlQP40eJ2/I+njvoQM3pRAlaz8ENaJ1w
         xXRmjb4tyEicrLOphSc1DuIOPM/vwsNjyCLuxlkezpVW+SLTaJBES7O1Kogrhk7gakMB
         v5MQ==
X-Gm-Message-State: AOAM531lpEDzRoYy/Xv7+/E5nweEVXRAXGZsDP9yYmcql8/LHrDTsFXg
        vaRdr6SAnK6OLyl1onTFJdPzR8phWrJigtur2cFqSA==
X-Google-Smtp-Source: ABdhPJy2RQAuq0B7Krbdn+Ul9WJ02t79YLdw2ym10tsq+ZsL8PYYwZCm7Zo1EGHSq8lvwMbikXefekKPz4bpkUaUzKY=
X-Received: by 2002:a67:c787:: with SMTP id t7mr2238076vsk.48.1611050486284;
 Tue, 19 Jan 2021 02:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20210115165004.22385-1-ilina@codeaurora.org> <20210115165004.22385-2-ilina@codeaurora.org>
In-Reply-To: <20210115165004.22385-2-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 11:00:50 +0100
Message-ID: <CAPDyKFqcPsr-aLP0zRgj2F4h_j0Vj7kSy5-aiH5qyH47dM6oYA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] PM / domains: inform PM domain of a device's next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Jan 2021 at 17:50, Lina Iyer <ilina@codeaurora.org> wrote:
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
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes in v8:
>         - Update documentation. Add Reviewed-by tag.
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
>  drivers/base/power/domain.c | 25 +++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  6 ++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eedacb92..10a960bd3204 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -423,6 +423,30 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>
> +/**
> + * dev_pm_genpd_set_next_wakeup - Notify PM framework of an impending wakeup.
> + *
> + * @dev: Device to handle
> + * @next: impending interrupt/wakeup for the device
> + *
> + *
> + * Allow devices to inform of the next wakeup. It's assumed that the users
> + * guarantee that the genpd wouldn't be detached while this routine is getting
> + * called. Additionally, it's also assumed that @dev isn't runtime suspended
> + * (RPM_SUSPENDED)."
> + * Although devices are expected to update the next_wakeup after the end of
> + * their usecase as well, it is possible the devices themselves may not know
> + * about that, so stale @next will be ignored when powering off the domain.
> + */
> +void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> +{
> +       struct generic_pm_domain_data *gpd_data;

Looks like you have dropped one of the needed sanity checks, to make
sure the device is attached to a genpd. My apologies if I missed that
in the previous version. So you need something like this:

genpd = dev_to_genpd_safe(dev);
if (!genpd)
    return;

> +
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +       gpd_data->next_wakeup = next;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -1465,6 +1489,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
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

Kind regards
Uffe

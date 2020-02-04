Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8796A151E91
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDQzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 11:55:31 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35931 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBDQzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 11:55:31 -0500
Received: by mail-vs1-f68.google.com with SMTP id a2so11820571vso.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 08:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUjD6ac/EaT+lGT7eSKAmx3Er9MO9GxqK/XPb/0Kz6g=;
        b=TpzPX4qKTAfk6jEFddBbQJJsXBm3xgfK1iNnrLoI53d8NuCbdkCyIXLQijPcVpunej
         qvN8AChgUXm1ZTiPxxaZWWgWMPNI3NAD/NljTVvLbudY744LGW2q0ARYqZ0M+PXPtbDA
         MzHRUDHSfrryFPjOMZgdotsAeDBiv/EGF/II163+qaqtibP6/uMzOdv9ZvMO7ypN6Kf2
         weRrqz8UvLg80XqAYxjcAX+Kk+qntiuiirUS+4MRx37r9eNx2LrhVlNeFXHbpxPCsI99
         6exF/7A/o2NeAOjjpTocrikF5j9Rp9WsbUFCxyl16h1QGnRF9g4R9CiiXEcVwAEAAeC1
         abOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUjD6ac/EaT+lGT7eSKAmx3Er9MO9GxqK/XPb/0Kz6g=;
        b=NvUOJEs3Q/jHUbTU1ZDyo3z3pOcDdmoHoNeVivFTv3Ch7rcS+3xuTkmF98+M4YnEMJ
         nIv9QLSV30qNdTTVYK4VLsDSi8I+rCXuXnj4CbHkE1LLaiXuPK9TGMP7Ck733mQU7YeX
         TaNHv80xSSpkWbQrnaMb+wDcGwG7Ofa8diiYluZgWLrhoaty2J4UYd4n4+dpac8BHGqZ
         CPTgG2y4WOSCDeIfow+ddHFmX1p7c9KHk+Cm1z4Nle8Gn1J2JZOP1ilgtji/67zdR8qX
         aiyNKNKp9/mfXeJzsaZDvs1feJncaqGj/BEnH91nC4hwcDt9xmimN+mkLWqMFm0Fkslm
         ipRg==
X-Gm-Message-State: APjAAAVlYEpN1Ez5qN7YqdNleq0Qu5VJ3zcaPDnCkDCwCnVvRmhAXKWr
        BXiio9FertyArpBnrc2rrsevUY7JncYE9+eHT5GnCw==
X-Google-Smtp-Source: APXvYqwSaVitwwf1ehbPdCyP+smP//5/6VZe3PHw+2z03X/gDmwArhYFkiF1LJElSJkmnouRWcMfscUnsjty5roYi5o=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr18889703vsb.200.1580835329380;
 Tue, 04 Feb 2020 08:55:29 -0800 (PST)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org> <1574254593-16078-5-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1574254593-16078-5-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 17:54:52 +0100
Message-ID: <CAPDyKFqBusMHWNHBCMXx6TxFO=8B6ytoyvvSfi14Z=-ahBDV5A@mail.gmail.com>
Subject: Re: [Patch v4 4/7] thermal: Add generic power domain warming device driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Nov 2019 at 13:56, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Resources modeled as power domains in linux kenrel can  be used to warm the
> SoC(eg. mx power domain on sdm845).  To support this feature, introduce a
> generic power domain warming device driver that can be plugged into the
> thermal framework (The thermal framework itself requires further
> modifiction to support a warming device in place of a cooling device.
> Those extensions are not introduced in this patch series).
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v3->v4:
>         - Removed late_init hook pd_warming_device_ops.
>         - Use of_genpd_add_device instead of pm_genpd_add_device to attach
>           device to the generic power domain.
>         - Use thermal_of_cooling_device_parent_register to register the
>           cooling device so that the device with genpd attached can be
>           made parent of the cooling device.
>         - With above changes, remove reference to generic_pm_domain in
>           pd_warming_device.
>
>  drivers/thermal/Kconfig              |  10 +++
>  drivers/thermal/Makefile             |   2 +
>  drivers/thermal/pwr_domain_warming.c | 138 +++++++++++++++++++++++++++++++++++
>  include/linux/pwr_domain_warming.h   |  29 ++++++++

Not sure about what the thermal maintainers think about the naming
here. In the end, it's their call.

However, normally we use "pm_domain_*", rather than "pwr_domain_*",
but maybe just "pd_*" is sufficient here.

>  4 files changed, 179 insertions(+)
>  create mode 100644 drivers/thermal/pwr_domain_warming.c
>  create mode 100644 include/linux/pwr_domain_warming.h
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 001a21a..0c5c93e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -187,6 +187,16 @@ config DEVFREQ_THERMAL
>
>           If you want this support, you should say Y here.
>
> +config PWR_DOMAIN_WARMING_THERMAL
> +       bool "Power Domain based warming device"
> +       depends on PM_GENERIC_DOMAINS_OF
> +       help
> +         This implements the generic power domain based warming
> +         mechanism through increasing the performance state of
> +         a power domain.
> +
> +         If you want this support, you should say Y here.
> +
>  config THERMAL_EMULATION
>         bool "Thermal emulation mode support"
>         help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 74a37c7..382c64a 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>
> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)       += pwr_domain_warming.o
> +
>  # platform thermal drivers
>  obj-y                          += broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)             += thermal_mmio.o
> diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
> new file mode 100644
> index 0000000..40162b9
> --- /dev/null
> +++ b/drivers/thermal/pwr_domain_warming.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Linaro Ltd
> + */
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/pwr_domain_warming.h>
> +
> +struct pd_warming_device {
> +       struct thermal_cooling_device *cdev;
> +       struct device dev;
> +       int max_state;
> +       int cur_state;
> +       bool runtime_resumed;
> +};
> +
> +static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +
> +       *state = pd_wdev->max_state;
> +       return 0;
> +}
> +
> +static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +
> +       *state = dev_pm_genpd_get_performance_state(&pd_wdev->dev);
> +
> +       return 0;
> +}
> +
> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +       struct device *dev = &pd_wdev->dev;
> +       int ret;
> +
> +       ret = dev_pm_genpd_set_performance_state(dev, state);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (state && !pd_wdev->runtime_resumed) {
> +               ret = pm_runtime_get_sync(dev);
> +               pd_wdev->runtime_resumed = true;
> +       } else if (!state && pd_wdev->runtime_resumed) {
> +               ret = pm_runtime_put(dev);
> +               pd_wdev->runtime_resumed = false;
> +       }
> +
> +       return ret;
> +}
> +
> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
> +       .get_max_state  = pd_wdev_get_max_state,
> +       .get_cur_state  = pd_wdev_get_cur_state,
> +       .set_cur_state  = pd_wdev_set_cur_state,
> +};
> +
> +struct thermal_cooling_device *
> +pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)

Maybe rename this to: thermal_of_pd_warming_register()

Moreover, I think you could replace the "struct device *parent", with
a "struct device_node *node" as in-parameter. That's all you need,
right?

> +{
> +       struct pd_warming_device *pd_wdev;
> +       struct of_phandle_args pd_args;
> +       int ret;
> +
> +       pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
> +       if (!pd_wdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       dev_set_name(&pd_wdev->dev, "%s_warming_dev", pd_name);

Perhaps skip the in-param *pd_name and make use of the suggested
"struct device_node *node", the index and something with "warming...",
when setting the name.

Just an idea, as to simplify for the caller.

> +       pd_wdev->dev.parent = parent;

This isn't needed, I think.

> +
> +       ret = device_register(&pd_wdev->dev);
> +       if (ret)
> +               goto error;
> +
> +       pd_args.np = parent->of_node;
> +       pd_args.args[0] = pd_id;
> +       pd_args.args_count = 1;
> +
> +       ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
> +

White space.

> +       if (ret)
> +               goto error;
> +
> +       ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
> +       if (ret < 0)
> +               goto error;
> +
> +       pd_wdev->max_state = ret - 1;
> +       pm_runtime_enable(&pd_wdev->dev);
> +       pd_wdev->runtime_resumed = false;
> +
> +       pd_wdev->cdev = thermal_of_cooling_device_parent_register
> +                                       (NULL, parent, pd_name, pd_wdev,
> +                                        &pd_warming_device_ops);

As stated in patch3, I don't get it why you need to use this new API
for "parents".

> +       if (IS_ERR(pd_wdev->cdev)) {
> +               pr_err("unable to register %s cooling device\n", pd_name);
> +               pm_runtime_disable(&pd_wdev->dev);
> +               ret = PTR_ERR(pd_wdev->cdev);
> +               goto error;
> +       }
> +
> +       return pd_wdev->cdev;
> +error:
> +       put_device(&pd_wdev->dev);

If device_register() succeeds you need to call device_unregister(),
rather than put_device() as a part of the error handling.

> +       kfree(pd_wdev);

You need a ->release() callback to manage kfree(), after you called
device_register().

> +       return ERR_PTR(ret);

Another thing is missing in the error path, which is to remove the
device for the genpd. I think calling pm_genpd_remove_device() should
work fine here.

> +}
> +EXPORT_SYMBOL_GPL(pwr_domain_warming_register);
> +
> +void pwr_domain_warming_unregister(struct thermal_cooling_device *cdev)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +       struct device *dev = &pd_wdev->dev;
> +
> +       if (pd_wdev->runtime_resumed) {
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +               pm_runtime_put(dev);
> +               pd_wdev->runtime_resumed = false;
> +       }
> +       pm_runtime_disable(dev);
> +       thermal_cooling_device_unregister(cdev);
> +       kfree(pd_wdev);
> +}
> +EXPORT_SYMBOL_GPL(pwr_domain_warming_unregister);
> diff --git a/include/linux/pwr_domain_warming.h b/include/linux/pwr_domain_warming.h
> new file mode 100644
> index 0000000..cb6550d
> --- /dev/null
> +++ b/include/linux/pwr_domain_warming.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Linaro Ltd.
> + */
> +#ifndef __PWR_DOMAIN_WARMING_H__
> +#define __PWR_DOMAIN_WARMING_H__
> +
> +#include <linux/pm_domain.h>
> +#include <linux/thermal.h>
> +
> +#ifdef CONFIG_PWR_DOMAIN_WARMING_THERMAL
> +struct thermal_cooling_device *
> +pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id);
> +
> +void pwr_domain_warming_unregister(struct thermal_cooling_device *cdev);
> +
> +#else
> +static inline struct thermal_cooling_device *
> +pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline void
> +pwr_domain_warming_unregister(struct thermal_cooling_device *cdev)
> +{
> +}
> +#endif /* CONFIG_PWR_DOMAIN_WARMING_THERMAL */
> +#endif /* __PWR_DOMAIN_WARMING_H__ */
> --
> 2.1.4
>

Kind regards
Uffe

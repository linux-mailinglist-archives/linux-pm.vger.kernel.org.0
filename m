Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3874B11C3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfILPEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 11:04:41 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37134 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732819AbfILPEk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 11:04:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id v78so5226989vke.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFNNCOgYKpq2tfIBsvM5Q2EFA3f47YwR/HKpQvuH55A=;
        b=AZEvGYnHobz+aCT+xnfAm+qo5L3S6S0AsimwkFQLGvUSD1g9sEjVwzSPupFnLuhUGb
         BkJp+eA6AN7OZp6PYY//MtWmqLqL6DjY5KT59ehRnTV2w9kilGBb7+zg/Lm/9PMIMAwU
         yaaC8yubvTQWQ6q22ByA5EqaO/cu2bJABaQNJwntZBiI1668H2QIAG4W1vWCf5PQ+bDq
         sINOBDMlzXWVnhASAglbBurBC1bHAK3wSNkv5g0+e/5v1+GpIoJZnk06vF4hCc0oDjQv
         D1HUQ8r+Gz0ca+OaEINpNDWtZQXKgcLdrHScU/jJAu6Cw7ZBMW6ODoMZtB8VK4iX2sol
         2Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFNNCOgYKpq2tfIBsvM5Q2EFA3f47YwR/HKpQvuH55A=;
        b=MqkNohiR/9d4xkYLa/2Yx8Vqjwy78LhrLK+WdqLJQwc9ccZxYVoWccl/nWXSinD6OY
         +3e90d8Am03t11B+XdGQeSKrM/ZoH43zXIrQioxUIgQFefQ8BJam1lzdgNea2PoxOtdO
         wYNvFRYpk72UVpgjyhLXWsHpYq4GHbqmZWjhrT44P4z8PIY478ZmicTwRRYZVDuooLvF
         t84c/YXS6r+m1SCgi8M00qvT42YwAXUELSvEi/mZHP20xk9fM2LJtcfFLEV/XFvtYcUU
         IDE2mik202bIfRyaH/FqqUmbdoyrrjL3WwDW4ibXGiRwzmyGbsjBOHDjVSSY0HrIsJ5o
         8n3g==
X-Gm-Message-State: APjAAAW+FErytpORvfCxzISQwzcLPbVQ9XjEzMdnUpbpO1NqdgrsChUM
        wCe1jLjW/TqPhAGnjvMlD9Pn0qDvBdj5V5qhbaWEWg==
X-Google-Smtp-Source: APXvYqzDZaA8bVUczMnOc9xu5hIchlU6tSMAYQmK9E71nFn77GkeKYvDio8gEXBBxH2xAQd8ycVUZdJh7BnvQANMu2s=
X-Received: by 2002:a1f:8c50:: with SMTP id o77mr7663416vkd.52.1568300678305;
 Thu, 12 Sep 2019 08:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org> <1568135676-9328-5-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1568135676-9328-5-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Sep 2019 17:04:01 +0200
Message-ID: <CAPDyKFpzeF6Adu9qBTFazTzbe=rv90x1UjKqC2LvCDpoXBJfVQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal: Add generic power domain warming device driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, agross@kernel.org,
        amit.kucheria@verdurent.com, Mark Rutland <mark.rutland@arm.com>,
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

On Tue, 10 Sep 2019 at 19:14, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Resources modeled as power domains in linux kenrel
> can  be used to warm the SoC(eg. mx power domain on sdm845).
> To support this feature, introduce a generic power domain
> warming device driver that can be plugged into the thermal framework
> (The thermal framework itself requires further modifiction to
> support a warming device in place of a cooling device.
> Those extensions are not introduced in this patch series).
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v1->v2:
>         - Make power domain based warming device driver a generic
>         driver in the thermal framework. v1 implemented this as a
>         Qualcomm specific driver.
>         - Rename certain variables as per review suggestions on the
>         mailing list.
>
>  drivers/thermal/Kconfig              |  11 +++
>  drivers/thermal/Makefile             |   2 +
>  drivers/thermal/pwr_domain_warming.c | 174 +++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/thermal/pwr_domain_warming.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9966364..eeb6018 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -187,6 +187,17 @@ config DEVFREQ_THERMAL
>
>           If you want this support, you should say Y here.
>
> +config PWR_DOMAIN_WARMING_THERMAL
> +       bool "Power Domain based warming device"
> +       depends on PM_GENERIC_DOMAINS
> +       depends on PM_GENERIC_DOMAINS_OF

PM_GENERIC_DOMAINS_OF can't be set unless PM_GENERIC_DOMAINS is set too.

So I assume it's sufficient to depend on PM_GENERIC_DOMAINS_OF?

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
> index 0000000..3dd792b
> --- /dev/null
> +++ b/drivers/thermal/pwr_domain_warming.c
> @@ -0,0 +1,174 @@
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
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/thermal.h>
> +
> +struct pd_warming_device {
> +       struct thermal_cooling_device *cdev;
> +       struct device *dev;
> +       int max_state;
> +       int cur_state;
> +       bool runtime_resumed;
> +};
> +
> +static const struct of_device_id pd_wdev_match_table[] = {
> +       { .compatible = "thermal-power-domain-wdev", .data = NULL },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pd_wdev_match_table);
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
> +       *state = dev_pm_genpd_get_performance_state(pd_wdev->dev);
> +
> +       return 0;
> +}
> +
> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +       struct device *dev = pd_wdev->dev;
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
> +       .get_max_state = pd_wdev_get_max_state,
> +       .get_cur_state = pd_wdev_get_cur_state,
> +       .set_cur_state = pd_wdev_set_cur_state,
> +};
> +
> +static int pd_wdev_create(struct device *dev, const char *name)
> +{
> +       struct pd_warming_device *pd_wdev;
> +       int state_count;
> +
> +       pd_wdev = devm_kzalloc(dev, sizeof(*pd_wdev), GFP_KERNEL);
> +       if (!pd_wdev)
> +               return -ENOMEM;
> +
> +       state_count = dev_pm_genpd_performance_state_count(dev);
> +       if (state_count < 0)
> +               return state_count;
> +
> +       pd_wdev->dev = dev;
> +       pd_wdev->max_state = state_count - 1;
> +       pd_wdev->runtime_resumed = false;
> +
> +       pm_runtime_enable(dev);
> +
> +       pd_wdev->cdev = thermal_of_cooling_device_register
> +                                       (dev->of_node, name,
> +                                        pd_wdev,
> +                                        &pd_warming_device_ops);
> +       if (IS_ERR(pd_wdev->cdev)) {
> +               dev_err(dev, "unable to register %s cooling device\n", name);
> +               pm_runtime_disable(dev);
> +
> +               return PTR_ERR(pd_wdev->cdev);
> +       }
> +
> +       return 0;
> +}
> +
> +static int pd_wdev_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev, *pd_dev;
> +       const char *pd_name;
> +       int id, count, ret = 0;
> +
> +       count = of_count_phandle_with_args(dev->of_node, "power-domains",
> +                                          "#power-domain-cells");

Perhaps this should be converted to genpd OF helper function instead,
that allows the caller to know how many power-domains there are
specified for a device node.

> +
> +       if (count > 1) {
> +               for (id = 0; id < count; id++) {
> +                       ret = of_property_read_string_index
> +                                       (dev->of_node, "power-domain-names",
> +                                        id, &pd_name);
> +                       if (ret) {
> +                               dev_err(dev, "Error reading the power domain name %d\n", ret);
> +                               continue;
> +                       }

It looks a bit awkward that you want to re-use the power-domain-names
as the name for the cooling (warming) device. This isn't really what
we use the "*-names" bindings for in general, I think.

Anyway, if you want a name corresponding to the actual attached PM
domain, perhaps re-using "->name" from the struct generic_pm_domain is
better. We can add a genpd helper for that, no problem. Of course it
also means that you must call dev_pm_domain_attach_by_id() first, to
attach the device and then get the name of the genpd, but that should
be fine.

> +
> +                       pd_dev = dev_pm_domain_attach_by_id(dev, id);
> +                       if (IS_ERR(pd_dev)) {
> +                               dev_err(dev, "Error attaching power domain %s %ld\n", pd_name, PTR_ERR(pd_dev));
> +                               continue;
> +                       }
> +
> +                       ret = pd_wdev_create(pd_dev, pd_name);
> +                       if (ret) {
> +                               dev_err(dev, "Error building cooling device %s %d\n", pd_name, ret);
> +                               dev_pm_domain_detach(pd_dev, false);
> +                               continue;
> +                       }

I am wondering about the use case of having multiple PM domains
attached to the cooling (warming) device. Is that really needed?
Perhaps you can elaborate on that a bit?

> +               }
> +       } else if (count == 1) {
> +               ret = of_property_read_string_index(dev->of_node,
> +                                                   "power-domain-names",
> +                                                   0, &pd_name);
> +               if (ret) {
> +                       dev_err(dev, "Error reading the power domain name %d\n", ret);
> +                       goto exit;
> +               }

According to my comment above, perhaps we simply don't have to use the
"power-domain-names" binding at all.

Also, I don't think this is really safe, as there is no guarantee that
there is PM domain attached to the device, just because you found the
DT property "power-domain-names".

Probably better to check pm_domain pointer for the device.

> +
> +               ret = pd_wdev_create(dev, pd_name);
> +               if (ret) {
> +                       dev_err(dev, "Error building cooling device %s %d\n", pd_name, ret);
> +                       goto exit;
> +               }
> +       } else  {
> +               ret = -EINVAL;
> +       }
> +
> +exit:
> +       return ret;
> +}
> +
> +static struct platform_driver pd_wdev_driver = {
> +       .driver = {
> +               .name = "qcom-rpmhpd-cdev",

Probably rename to a more generic name (leftover from earlier version I assume).

> +               .of_match_table = pd_wdev_match_table,
> +       },
> +       .probe = pd_wdev_probe,
> +};
> +module_platform_driver(pd_wdev_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm RPMHPD cooling device driver");

Ditto.

> +MODULE_LICENSE("GPL v2");
> --
> 2.1.4
>

Kind regards
Uffe

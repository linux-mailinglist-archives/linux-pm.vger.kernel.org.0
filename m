Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8F18F915
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCWP6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 11:58:11 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34504 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCWP6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 11:58:11 -0400
Received: by mail-vs1-f65.google.com with SMTP id t10so9104676vsp.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3nF2XEJF+3VJmtugEEG0k9Mal8VgUQrukDbfKGmZmw=;
        b=YSYjEAYdWU+Fcf3THNsHZiqYlveQL9H5/YFc9huB2qW0SVXTH1coofuUlbrn12kIXG
         oEk+JCxz5/G4NuMkHiNN7TAz7qKbGH/2/LivZdBvUWyHlsMIQKNiU0onzYv8obbaoTjt
         aeVMD/Sshl9NlDcl26nZwcS9+y/BY7b/zTqTcHFSp9ZQaR0PJSbVTm8cebq6uNXVaIt6
         59OCuJye0bTcysKaPKl2VgWUCHsPLLdSSdH9zqfrmljm1SRIc9ovUMHITte6oii5+Ggo
         I7/RrIzz0BW+kdgHwlADprLyL3QG6UqLfHEgIq9e+d1drrFHbg7oOZajk5V27vtRp6JJ
         fh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3nF2XEJF+3VJmtugEEG0k9Mal8VgUQrukDbfKGmZmw=;
        b=Vm6MxxcJli/z8e95s3nV14DC/nnk3p+k93sKxTdnjNfNBwCFgHMrcKUFDwYJVlL0hU
         Cfy+Yd37fDicwgdNzkc4pDg8XAdOZWVPPytYsk4k0UoiMhQB4YIXbUInwFhtcHgdCyts
         4gJKbNkpfwdRTwoCfn2JS1Rh5SwowGjJg/zZRkseA/1RtjbPQSjGyl8VqVIRUoTxEtqb
         p1XquiUcaefoAuzFJDEmwtWCV4BD/z0N5Ajhbs2FVUk2YtbfRJVni2f+ulzUaH1TnmG1
         G5CEQ1pzB0RAD5N+HJzOZPUB+6+P8iDR3KVhKD8Xu/HzYg5Be17BOgQH9H7p+6q6JaHq
         t6HQ==
X-Gm-Message-State: ANhLgQ3jMfPK1YKFOCKb51cQlh+C+cB+W1o6TZl4qIjsjq4Z6nJZDdaT
        6Mdug3UraVtF4Df8pY6Akd4S14rGWuXSjx5k8uRKiA==
X-Google-Smtp-Source: ADFU+vsS91ZoQIuI8ccP/DSMa9qRHXbW9REfOAml1Q+Ozi/C0xXdvRCLJ31dq8A8mFDqpGQA5tuX7hcVDRsQj4pKH30=
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr16732708vsr.165.1584979089841;
 Mon, 23 Mar 2020 08:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200320014107.26087-1-thara.gopinath@linaro.org> <20200320014107.26087-4-thara.gopinath@linaro.org>
In-Reply-To: <20200320014107.26087-4-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Mar 2020 16:57:33 +0100
Message-ID: <CAPDyKFqn0E=-sNZy=09tLZn=6VxEfiXL-vUNwb9HK8+WLDBiPw@mail.gmail.com>
Subject: Re: [Patch v5 3/6] thermal: Add generic power domain warming device driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
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

On Fri, 20 Mar 2020 at 02:41, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Resources modeled as power domains in linux kernel can  be used to warm the
> SoC(eg. mx power domain on sdm845).  To support this feature, introduce a
> generic power domain warming device driver that can be plugged into the
> thermal framework (The thermal framework itself requires further
> modifiction to support a warming device in place of a cooling device.
> Those extensions are not introduced in this patch series).
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
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
> v4->v5:
>         - All the below changes are as per Ulf's review comments.
>         - Renamed pwr_domain_warming.c and pwr_domain_warming.h to
>           pd_warming.c and pd_warming.h.
>         - Renamed pwr_domain_warming_register API to
>           of_pd_warming_register.
>         - Dropped in-param pd_name to of_pd_warming_register.
>         - Introduced ID allocator to uniquely identify each power domain
>           warming device.
>         - Introduced pd_warming_release to handle device kfree for
>           pd_warming_device.
>         - Introduced pm_genpd_remove_device in the error exit path
>           of of_pd_warming_register.
>
>  drivers/thermal/Kconfig      |  10 +++
>  drivers/thermal/Makefile     |   2 +
>  drivers/thermal/pd_warming.c | 168 +++++++++++++++++++++++++++++++++++
>  include/linux/pd_warming.h   |  29 ++++++
>  4 files changed, 209 insertions(+)
>  create mode 100644 drivers/thermal/pd_warming.c
>  create mode 100644 include/linux/pd_warming.h
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4d6753f2b18f..92522d541d0e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -206,6 +206,16 @@ config DEVFREQ_THERMAL
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
> index 8c8ed7b79915..7db87a779126 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -28,6 +28,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>
> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)       += pd_warming.o
> +
>  # platform thermal drivers
>  obj-y                          += broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)             += thermal_mmio.o
> diff --git a/drivers/thermal/pd_warming.c b/drivers/thermal/pd_warming.c
> new file mode 100644
> index 000000000000..c0854d2e4b92
> --- /dev/null
> +++ b/drivers/thermal/pd_warming.c
> @@ -0,0 +1,168 @@
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
> +#include <linux/pd_warming.h>
> +
> +struct pd_warming_device {
> +       struct thermal_cooling_device *cdev;
> +       struct device dev;
> +       int id;
> +       int max_state;
> +       int cur_state;
> +       bool runtime_resumed;
> +};
> +
> +static DEFINE_IDA(pd_ida);
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
> +static void pd_warming_release(struct device *dev)
> +{
> +       kfree(dev);

This is wrong, you should free a "struct pd_warming_device *". Use the
"container of" macro to get it from 'dev'.

> +}
> +
> +struct thermal_cooling_device *
> +of_pd_warming_register(struct device *parent, int pd_id)
> +{
> +       struct pd_warming_device *pd_wdev;
> +       struct of_phandle_args pd_args;
> +       char cdev_name[THERMAL_NAME_LENGTH];
> +       int ret;
> +
> +       pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
> +       if (!pd_wdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       dev_set_name(&pd_wdev->dev, "%s_%d_warming_dev",
> +                    dev_name(parent), pd_id);
> +       pd_wdev->dev.parent = parent;
> +       pd_wdev->dev.release = pd_warming_release;
> +
> +       ret = device_register(&pd_wdev->dev);
> +       if (ret) {
> +               put_device(&pd_wdev->dev);
> +               goto free_pd_wdev;
> +       }
> +
> +       ret = ida_simple_get(&pd_ida, 0, 0, GFP_KERNEL);
> +       if (ret < 0)
> +               goto unregister_device;

If you use and ida, you might as well use it as a part of the
dev_set_name() above.

That should give you a unique name, similar to how you use it for the
cdev_name below.

> +
> +       pd_wdev->id = ret;
> +
> +       pd_args.np = parent->of_node;
> +       pd_args.args[0] = pd_id;
> +       pd_args.args_count = 1;
> +
> +       ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
> +
> +       if (ret)
> +               goto remove_ida;
> +
> +       ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
> +       if (ret < 0)
> +               goto out_genpd;
> +
> +       pd_wdev->max_state = ret - 1;
> +       pm_runtime_enable(&pd_wdev->dev);
> +       pd_wdev->runtime_resumed = false;
> +
> +       snprintf(cdev_name, sizeof(cdev_name), "thermal-pd-%d", pd_wdev->id);
> +       pd_wdev->cdev = thermal_of_cooling_device_register
> +                                       (NULL, cdev_name, pd_wdev,
> +                                        &pd_warming_device_ops);
> +       if (IS_ERR(pd_wdev->cdev)) {
> +               pr_err("unable to register %s cooling device\n", cdev_name);
> +               ret = PTR_ERR(pd_wdev->cdev);
> +               goto out_runtime_disable;
> +       }
> +
> +       return pd_wdev->cdev;
> +
> +out_runtime_disable:
> +       pm_runtime_disable(&pd_wdev->dev);
> +out_genpd:
> +       pm_genpd_remove_device(&pd_wdev->dev);
> +remove_ida:
> +       ida_simple_remove(&pd_ida, pd_wdev->id);
> +unregister_device:
> +       device_unregister(&pd_wdev->dev);
> +       pd_warming_release(&pd_wdev->dev);

This is wrong, drop this.

> +free_pd_wdev:
> +       kfree(pd_wdev);

Since you should free this from the ->release() callback, there is no
need to do this here.

> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(of_pd_warming_register);
> +
> +void pd_warming_unregister(struct thermal_cooling_device *cdev)
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
> +       pm_genpd_remove_device(dev);
> +       ida_simple_remove(&pd_ida, pd_wdev->id);
> +       thermal_cooling_device_unregister(cdev);
> +       kfree(pd_wdev);

Don't use kfree here, but instead device_unregister(dev);

> +}
> +EXPORT_SYMBOL_GPL(pd_warming_unregister);
> diff --git a/include/linux/pd_warming.h b/include/linux/pd_warming.h
> new file mode 100644
> index 000000000000..550a5683b56d
> --- /dev/null
> +++ b/include/linux/pd_warming.h
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
> +of_pd_warming_register(struct device *parent, int pd_id);
> +
> +void pd_warming_unregister(struct thermal_cooling_device *cdev);
> +
> +#else
> +static inline struct thermal_cooling_device *
> +of_pd_warming_register(struct device *parent, int pd_id)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline void
> +pd_warming_unregister(struct thermal_cooling_device *cdev)
> +{
> +}
> +#endif /* CONFIG_PWR_DOMAIN_WARMING_THERMAL */
> +#endif /* __PWR_DOMAIN_WARMING_H__ */
> --
> 2.20.1
>

Besides the few things above, this looks good to me.

Kind regards
Uffe

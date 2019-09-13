Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7EB1938
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfIMHz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 03:55:27 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33374 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfIMHz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2019 03:55:27 -0400
Received: by mail-vk1-f194.google.com with SMTP id q186so5746561vkb.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2019 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2tWwia+mbaqyWF/gx1TiPXSb/yh2QIl2IHNsihm2XM=;
        b=jwLFFLFWEVVUcCaxIQCnDZAt/4F4QDNsElBEXujXptRdirXUOGNMIfEi0oslRVEBVH
         pnOibEX+wvh20E2CoNIoiDmXTeNxIL1f+JgGqISP8o/Kky1D3CY7UkpunpBtuD3C+koV
         iKTUMEDHLr0zmqHKVKr1HD4pGMobfVS7OPlfJvc96/N9QTENWEAX+I5eMPTa2JCUyGX4
         hj+LhvYUcZ2UtZRGGcEey4ebMkzZzwEKGFCrngIbELZmBapRhe5K0IEJQqhKGfkWv6cu
         eI5h2p3HKG9wdhqwDoBvDXVGAV+Wo6ociKHkfzC+jbywOOMeeNkqYD0h62xVczf+1qA/
         ej/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2tWwia+mbaqyWF/gx1TiPXSb/yh2QIl2IHNsihm2XM=;
        b=pHPH+OCydoXr5KI6XX7Z5qxGOPsZh9B8D8r/FXbh2polD2DDDFXrS5xVjezFy/rY5N
         RqfmXlhjg9aXU3cyOLZ67NOYCr94XLK/Bi4nClv7GKPrIb1ehGCKxD0KfX+7kXcUSGJW
         tf7X4RUKLVF5JBfKeJazkhKz1JzCjO71ssOePMvJIEBXJgO//op7GNkGLtl7m1FXMPNv
         H7KcUV9vBDMIiaEX7hiRA52OakIyg6KLHFowkYpmw3At5UAmN79FtaeFFiyThV7g+Kau
         O79vp1WbbkT2EpXSUnSV5aq0cOaalrYdjKq8FwBpmf40l8q/Zc9suATE0kqPvSGfT+Fd
         VBgg==
X-Gm-Message-State: APjAAAUioQ7y9nAg5Mdpccu3tHpnGBPKp+3iJTdGBJOaTsyguoyvuXtQ
        eHJOavrnCA6hMfzRBfWjnKPDaQwLa1dlnc2N9QP6EQ==
X-Google-Smtp-Source: APXvYqzVIc2tzPK1lwpEhty7Ze1GgnWvPsC7Bjl1HM/h+xRa+LmG+5iIajH3UMNkM4v1K1iSO7YMb4sPxhCGwAZ7s6A=
X-Received: by 2002:a1f:da45:: with SMTP id r66mr725890vkg.36.1568361326117;
 Fri, 13 Sep 2019 00:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
 <1568135676-9328-5-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFpzeF6Adu9qBTFazTzbe=rv90x1UjKqC2LvCDpoXBJfVQ@mail.gmail.com> <5D7AA7F9.1060603@linaro.org>
In-Reply-To: <5D7AA7F9.1060603@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Sep 2019 09:54:49 +0200
Message-ID: <CAPDyKFrB=g=6CvWVcoc6Dr8g1dXgr51zRoob8jc-9Ks_0Pst_g@mail.gmail.com>
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

On Thu, 12 Sep 2019 at 22:18, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> On 09/12/2019 11:04 AM, Ulf Hansson wrote:
>
> Hi Ulf,
>
> Thanks for the review.
> > On Tue, 10 Sep 2019 at 19:14, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> >>
> >> Resources modeled as power domains in linux kenrel
> >> can  be used to warm the SoC(eg. mx power domain on sdm845).
> >> To support this feature, introduce a generic power domain
> >> warming device driver that can be plugged into the thermal framework
> >> (The thermal framework itself requires further modifiction to
> >> support a warming device in place of a cooling device.
> >> Those extensions are not introduced in this patch series).
> >>
> >> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >> ---
> >> v1->v2:
> >>         - Make power domain based warming device driver a generic
> >>         driver in the thermal framework. v1 implemented this as a
> >>         Qualcomm specific driver.
> >>         - Rename certain variables as per review suggestions on the
> >>         mailing list.
> >>
> >>  drivers/thermal/Kconfig              |  11 +++
> >>  drivers/thermal/Makefile             |   2 +
> >>  drivers/thermal/pwr_domain_warming.c | 174 +++++++++++++++++++++++++++++++++++
> >>  3 files changed, 187 insertions(+)
> >>  create mode 100644 drivers/thermal/pwr_domain_warming.c
> >>
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index 9966364..eeb6018 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -187,6 +187,17 @@ config DEVFREQ_THERMAL
> >>
> >>           If you want this support, you should say Y here.
> >>
> >> +config PWR_DOMAIN_WARMING_THERMAL
> >> +       bool "Power Domain based warming device"
> >> +       depends on PM_GENERIC_DOMAINS
> >> +       depends on PM_GENERIC_DOMAINS_OF
> >
> > PM_GENERIC_DOMAINS_OF can't be set unless PM_GENERIC_DOMAINS is set too.
> >
> > So I assume it's sufficient to depend on PM_GENERIC_DOMAINS_OF?
>
> Yes, you are right. I will change it.
> >
> >> +       help
> >> +         This implements the generic power domain based warming
> >> +         mechanism through increasing the performance state of
> >> +         a power domain.
> >> +
> >> +         If you want this support, you should say Y here.
> >> +
> >>  config THERMAL_EMULATION
> >>         bool "Thermal emulation mode support"
> >>         help
> >> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> >> index 74a37c7..382c64a 100644
> >> --- a/drivers/thermal/Makefile
> >> +++ b/drivers/thermal/Makefile
> >> @@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
> >>  # devfreq cooling
> >>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
> >>
> >> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)       += pwr_domain_warming.o
> >> +
> >>  # platform thermal drivers
> >>  obj-y                          += broadcom/
> >>  obj-$(CONFIG_THERMAL_MMIO)             += thermal_mmio.o
> >> diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
> >> new file mode 100644
> >> index 0000000..3dd792b
> >> --- /dev/null
> >> +++ b/drivers/thermal/pwr_domain_warming.c
> >> @@ -0,0 +1,174 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2019, Linaro Ltd
> >> + */
> >> +#include <linux/err.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/init.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pm_domain.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/thermal.h>
> >> +
> >> +struct pd_warming_device {
> >> +       struct thermal_cooling_device *cdev;
> >> +       struct device *dev;
> >> +       int max_state;
> >> +       int cur_state;
> >> +       bool runtime_resumed;
> >> +};
> >> +
> >> +static const struct of_device_id pd_wdev_match_table[] = {
> >> +       { .compatible = "thermal-power-domain-wdev", .data = NULL },
> >> +       { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, pd_wdev_match_table);
> >> +
> >> +static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
> >> +                                unsigned long *state)
> >> +{
> >> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> >> +
> >> +       *state = pd_wdev->max_state;
> >> +       return 0;
> >> +}
> >> +
> >> +static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
> >> +                                unsigned long *state)
> >> +{
> >> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> >> +
> >> +       *state = dev_pm_genpd_get_performance_state(pd_wdev->dev);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
> >> +                                unsigned long state)
> >> +{
> >> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> >> +       struct device *dev = pd_wdev->dev;
> >> +       int ret;
> >> +
> >> +       ret = dev_pm_genpd_set_performance_state(dev, state);
> >> +
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (state && !pd_wdev->runtime_resumed) {
> >> +               ret = pm_runtime_get_sync(dev);
> >> +               pd_wdev->runtime_resumed = true;
> >> +       } else if (!state && pd_wdev->runtime_resumed) {
> >> +               ret = pm_runtime_put(dev);
> >> +               pd_wdev->runtime_resumed = false;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
> >> +       .get_max_state = pd_wdev_get_max_state,
> >> +       .get_cur_state = pd_wdev_get_cur_state,
> >> +       .set_cur_state = pd_wdev_set_cur_state,
> >> +};
> >> +
> >> +static int pd_wdev_create(struct device *dev, const char *name)
> >> +{
> >> +       struct pd_warming_device *pd_wdev;
> >> +       int state_count;
> >> +
> >> +       pd_wdev = devm_kzalloc(dev, sizeof(*pd_wdev), GFP_KERNEL);
> >> +       if (!pd_wdev)
> >> +               return -ENOMEM;
> >> +
> >> +       state_count = dev_pm_genpd_performance_state_count(dev);
> >> +       if (state_count < 0)
> >> +               return state_count;
> >> +
> >> +       pd_wdev->dev = dev;
> >> +       pd_wdev->max_state = state_count - 1;
> >> +       pd_wdev->runtime_resumed = false;
> >> +
> >> +       pm_runtime_enable(dev);
> >> +
> >> +       pd_wdev->cdev = thermal_of_cooling_device_register
> >> +                                       (dev->of_node, name,
> >> +                                        pd_wdev,
> >> +                                        &pd_warming_device_ops);
> >> +       if (IS_ERR(pd_wdev->cdev)) {
> >> +               dev_err(dev, "unable to register %s cooling device\n", name);
> >> +               pm_runtime_disable(dev);
> >> +
> >> +               return PTR_ERR(pd_wdev->cdev);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int pd_wdev_probe(struct platform_device *pdev)
> >> +{
> >> +       struct device *dev = &pdev->dev, *pd_dev;
> >> +       const char *pd_name;
> >> +       int id, count, ret = 0;
> >> +
> >> +       count = of_count_phandle_with_args(dev->of_node, "power-domains",
> >> +                                          "#power-domain-cells");
> >
> > Perhaps this should be converted to genpd OF helper function instead,
> > that allows the caller to know how many power-domains there are
> > specified for a device node.
>
> I am ok with this if you think that a OF helper to get the number of
> power domains is a useful helper in the genpd framework. I can add it as
> part of the next revision. Or do you want me to send it across separate?

Feel free to include in the next version of the series. In case it's needed.

> >
> >> +
> >> +       if (count > 1) {
> >> +               for (id = 0; id < count; id++) {
> >> +                       ret = of_property_read_string_index
> >> +                                       (dev->of_node, "power-domain-names",
> >> +                                        id, &pd_name);
> >> +                       if (ret) {
> >> +                               dev_err(dev, "Error reading the power domain name %d\n", ret);
> >> +                               continue;
> >> +                       }
> >
> > It looks a bit awkward that you want to re-use the power-domain-names
> > as the name for the cooling (warming) device. This isn't really what
> > we use the "*-names" bindings for in general, I think.
> >
> > Anyway, if you want a name corresponding to the actual attached PM
> > domain, perhaps re-using "->name" from the struct generic_pm_domain is
> > better. We can add a genpd helper for that, no problem. Of course it
> > also means that you must call dev_pm_domain_attach_by_id() first, to
> > attach the device and then get the name of the genpd, but that should
> > be fine.
>
> Ya. I need a name corresponding to the power domain name (or something
> very close) to identify the actual warming device in the sysfs entries.
> I can use genpd->name and a helper function to achieve it. I can include
> it in Patch 1/5 where I add other helper functions.

A separate patch please, but yeah, fold it in into @subject series.

> >
> >> +
> >> +                       pd_dev = dev_pm_domain_attach_by_id(dev, id);
> >> +                       if (IS_ERR(pd_dev)) {
> >> +                               dev_err(dev, "Error attaching power domain %s %ld\n", pd_name, PTR_ERR(pd_dev));
> >> +                               continue;
> >> +                       }
> >> +
> >> +                       ret = pd_wdev_create(pd_dev, pd_name);
> >> +                       if (ret) {
> >> +                               dev_err(dev, "Error building cooling device %s %d\n", pd_name, ret);
> >> +                               dev_pm_domain_detach(pd_dev, false);
> >> +                               continue;
> >> +                       }
> >
> > I am wondering about the use case of having multiple PM domains
> > attached to the cooling (warming) device. Is that really needed?
> > Perhaps you can elaborate on that a bit?
> Ya. I though about this as well. I don't have a use case. In my current
> case it is just one power domain on the SoC. But considering this is now
> a generic driver, in my opinion this has to be a generic solution. So if
> you think about this, the device should be able to specify any number of
> power domains that can behave as a warming device since a SoC can have
> any number of power domain based warming devices. May be one to warm up
> the cpus, one for gpus etc.

I get that, but you can always have more than one warming device. Each
warming device would then be attached to a single PM domain. Or is
there a problem with that?

In any case, if you don't have use case for multiple PM domains per
warming device at this point, I would rather keep it simple and start
to support only the single PM domain case.

>
> So another way of implementing this whole thing is to avoid having a
> special power domain warming device defined in the device tree. Instead,
> add a few new binding to the power-domain controller/provider entries
> to specify if a power domain controlled by the provider can act as a
> warming device or not. And have the initialization code for the power
> domain controller (of_genpd_add_provider_onecell or any other suitable
> API) register the specified power domain as a warming device.  The DT
> entries should probably look something like below in the case.
>
> rpmhpd: power-controller {
>                                 compatible = "qcom,sdm845-rpmhpd";
>                                 #power-domain-cells = <1>;
>                                 hosts-warming-dev;
>                                 warming-dev-names = "mx";
>                                 operating-points-v2 = <&rpmhpd_opp_table>;
>
>                                 rpmhpd_opp_table: opp-table {
>                                         compatible = "operating-points-v2";
> ....
>
> And have the following in of_genpd_add_provider_onecell
>
> if (hosts-warming-dev)
>         # loop through the warming-dev-names and register them as power domain
> warming devices.
>
> You think this is a better idea?

Not really, but you need to re-direct that question to DT maintainers
if want a better answer.

>
> >
> >> +               }
> >> +       } else if (count == 1) {
> >> +               ret = of_property_read_string_index(dev->of_node,
> >> +                                                   "power-domain-names",
> >> +                                                   0, &pd_name);
> >> +               if (ret) {
> >> +                       dev_err(dev, "Error reading the power domain name %d\n", ret);
> >> +                       goto exit;
> >> +               }
> >
> > According to my comment above, perhaps we simply don't have to use the
> > "power-domain-names" binding at all.
> I will use genpd->name
>

[...]

Kind regards
Uffe

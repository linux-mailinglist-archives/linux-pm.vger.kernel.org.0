Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601E0213857
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCKCP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 06:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGCKCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 06:02:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CDAC08C5C1
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 03:02:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so31969079wrj.13
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KSglCuKZom7N+uFfS3MmTsdhQ4Air/dzCpchXZq06HQ=;
        b=I0/kSCr8TJuxfeN61ggBpJlUvwnP7D3K9zIM5ce+d+JTCskkn5iytO+JUt2nqH2kL+
         666p1+rvfjW5XOa+0hWR4QuLm5BWGKR+mKdQvvcML8WM/ir3E13OHu/TFwcgTlrwvvnl
         G4DBZkWY+MR2VNnYky5umq60AxUvLtxu92mYwvK/+IoE7rRH69wgPy57N2WoeLPWndel
         IM3c9fDl5R0Nd+4PRJeZY3UKQNFb9nA+ruwiMQsFzOU0QcG06xNBHthf5B7auVCsoaL8
         9c4to1jBoZlBcGS2x3HlTjzpY/kRYLNviG8fktKCljj1QRmc8efBtYQI3Ptah/JoYj1P
         Dtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KSglCuKZom7N+uFfS3MmTsdhQ4Air/dzCpchXZq06HQ=;
        b=dLWHzgFd2rxQ9/kYlfC2mKwhtzwEyUz01eFVFtrrBDO3YP292PcK1zideOQeaXYgmb
         t82G99ojaZYL9RAxwUpXEo9u+/C5SWm4Au4xWytu7j+i3aKEBuhCI6ceD5PEq7x4qSdI
         +eO1jly64Gse9v0GEgsofgzleLW09YQ4Q7NxBYpzN9PCYGmLbACx9GXexn6eB2r/8ZJL
         m9A6asAjpKh+kFp4wnEI+TlqJr6unKaOsgObIfOXE3PeEPSmmhDCDqY6f5nVHkaKKQLQ
         +2JZ04x+RCDc2GveLbjFJHVFZX22c1Et4vpUFU4jI4IsDSQp5wPuEFxOl7amRQM9k1jy
         0uMw==
X-Gm-Message-State: AOAM531lyjdUw5yFr2jl0JixI7lhaggIgWZT45FYhOD2bEvQVYRkopsb
        7KWVLrkTNi/UXsuw+OTj79mmhw==
X-Google-Smtp-Source: ABdhPJzsgwRcT3xBH66gI81yE8LHzMiSna8htFBB3M4scc6NMnqnJ+bmBrnO6oI26eGWF2Sg7p3yAA==
X-Received: by 2002:adf:8524:: with SMTP id 33mr35644482wrh.366.1593770533180;
        Fri, 03 Jul 2020 03:02:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:7019:4e9b:2970:f860? ([2a01:e34:ed2f:f020:7019:4e9b:2970:f860])
        by smtp.googlemail.com with ESMTPSA id z10sm8372213wrm.21.2020.07.03.03.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 03:02:12 -0700 (PDT)
Subject: Re: [PATCH v6 3/6] thermal: Add generic power domain warming device
 driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>, rui.zhang@intel.com,
        ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Luba <Lukasz.Luba@arm.com>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
 <20200604015317.31389-4-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <733d118d-45a3-b981-4820-5d841e921a8d@linaro.org>
Date:   Fri, 3 Jul 2020 12:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604015317.31389-4-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Thara,

sorry for the delay.

Added Lukasz.

On 04/06/2020 03:53, Thara Gopinath wrote:
> Resources modeled as power domains in linux kernel can  be used to warm the
> SoC(eg. mx power domain on sdm845).  To support this feature, introduce a
> generic power domain warming device driver that can be plugged into the
> thermal framework (The thermal framework itself requires further
> modifiction to support a warming device in place of a cooling device.
> Those extensions are not introduced in this patch series).

The patch itself looks fine but I'm not very convinced about using a
specific driver as a warming device.

It is all about changing the performance state of a device and the power
domain is a way to access the associated callback.

It could be used as a cooling device as well.

The cpufreq cooling device could be used as a warming device and the way
we access the performance state is the freq qos.

We end up with different ways to do the same thing : change the
performance state.

On the other side, the energy model is being moved to the struct device,
so we will have gpu and cpu using it to retrieve a performance state
given a power value.

My opinion is instead of multiplying the ways to do the same think, we
should find a way to unify all the passive cooling devices into a single
generic performance state based mitigation device.

It does not imply to make all the passive cooling device changes but
provide a generic one first.

The ideal would be to register a struct device as a performance state
capable device and use the energy model stored in it.

In the meantime, the energy model should embed a couple of callbacks
get_power / set_power to set the performance state.

That implies a bit of more work, but IMHO it is worth to do.

Does it make sense ?


> ---
> 
> v3->v4:
> 	- Removed late_init hook pd_warming_device_ops.
> 	- Use of_genpd_add_device instead of pm_genpd_add_device to attach
> 	  device to the generic power domain.
> 	- Use thermal_of_cooling_device_parent_register to register the
> 	  cooling device so that the device with genpd attached can be
> 	  made parent of the cooling device.
> 	- With above changes, remove reference to generic_pm_domain in
> 	  pd_warming_device.
> 
> v4->v5:
> 	- All the below changes are as per Ulf's review comments.
> 	- Renamed pwr_domain_warming.c and pwr_domain_warming.h to
> 	  pd_warming.c and pd_warming.h.
> 	- Renamed pwr_domain_warming_register API to 
> 	  of_pd_warming_register.
> 	- Dropped in-param pd_name to of_pd_warming_register.
> 	- Introduced ID allocator to uniquely identify each power domain
> 	  warming device.
> 	- Introduced pd_warming_release to handle device kfree for
> 	  pd_warming_device.
> 	- Introduced pm_genpd_remove_device in the error exit path
> 	  of of_pd_warming_register.
> v5->v6:
> 	- Fixed issues with ->release() and kfree(dev) as pointed
> 	  out by Ulf.
> 
>  drivers/thermal/Kconfig      |  10 +++
>  drivers/thermal/Makefile     |   4 +
>  drivers/thermal/pd_warming.c | 169 +++++++++++++++++++++++++++++++++++
>  include/linux/pd_warming.h   |  29 ++++++
>  4 files changed, 212 insertions(+)
>  create mode 100644 drivers/thermal/pd_warming.c
>  create mode 100644 include/linux/pd_warming.h
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e53314ea9e25..3a0bcf3e8bd9 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -206,6 +206,16 @@ config DEVFREQ_THERMAL
>  
>  	  If you want this support, you should say Y here.
>  
> +config PWR_DOMAIN_WARMING_THERMAL
> +	bool "Power Domain based warming device"
> +	depends on PM_GENERIC_DOMAINS_OF
> +	help
> +	  This implements the generic power domain based warming
> +	  mechanism through increasing the performance state of
> +	  a power domain.
> +
> +	  If you want this support, you should say Y here.
> +
>  config THERMAL_EMULATION
>  	bool "Thermal emulation mode support"
>  	help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 86c506410cc0..14fa696a08bd 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -28,7 +28,11 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>  
> +#pwr domain warming
> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)	+= pd_warming.o
> +
>  obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o
> +
>  # platform thermal drivers
>  obj-y				+= broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
> diff --git a/drivers/thermal/pd_warming.c b/drivers/thermal/pd_warming.c
> new file mode 100644
> index 000000000000..1ea93481c79b
> --- /dev/null
> +++ b/drivers/thermal/pd_warming.c
> @@ -0,0 +1,169 @@
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
> +	struct thermal_cooling_device *cdev;
> +	struct device dev;
> +	int id;
> +	int max_state;
> +	int cur_state;
> +	bool runtime_resumed;
> +};
> +
> +static DEFINE_IDA(pd_ida);
> +
> +static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
> +				 unsigned long *state)
> +{
> +	struct pd_warming_device *pd_wdev = cdev->devdata;
> +
> +	*state = pd_wdev->max_state;
> +	return 0;
> +}
> +
> +static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
> +				 unsigned long *state)
> +{
> +	struct pd_warming_device *pd_wdev = cdev->devdata;
> +
> +	*state = dev_pm_genpd_get_performance_state(&pd_wdev->dev);
> +
> +	return 0;
> +}
> +
> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
> +				 unsigned long state)
> +{
> +	struct pd_warming_device *pd_wdev = cdev->devdata;
> +	struct device *dev = &pd_wdev->dev;
> +	int ret;
> +
> +	ret = dev_pm_genpd_set_performance_state(dev, state);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (state && !pd_wdev->runtime_resumed) {
> +		ret = pm_runtime_get_sync(dev);
> +		pd_wdev->runtime_resumed = true;
> +	} else if (!state && pd_wdev->runtime_resumed) {
> +		ret = pm_runtime_put(dev);
> +		pd_wdev->runtime_resumed = false;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
> +	.get_max_state	= pd_wdev_get_max_state,
> +	.get_cur_state	= pd_wdev_get_cur_state,
> +	.set_cur_state	= pd_wdev_set_cur_state,
> +};
> +
> +static void pd_warming_release(struct device *dev)
> +{
> +	struct pd_warming_device *pd_wdev;
> +
> +	pd_wdev = container_of(dev, struct pd_warming_device, dev);
> +	kfree(pd_wdev);
> +}
> +
> +struct thermal_cooling_device *
> +of_pd_warming_register(struct device *parent, int pd_id)
> +{
> +	struct pd_warming_device *pd_wdev;
> +	struct of_phandle_args pd_args;
> +	char cdev_name[THERMAL_NAME_LENGTH];
> +	int ret;
> +
> +	pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
> +	if (!pd_wdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev_set_name(&pd_wdev->dev, "%s_%d_warming_dev",
> +		     dev_name(parent), pd_id);
> +	pd_wdev->dev.parent = parent;
> +	pd_wdev->dev.release = pd_warming_release;
> +
> +	ret = device_register(&pd_wdev->dev);
> +	if (ret) {
> +		put_device(&pd_wdev->dev);
> +		goto out;
> +	}
> +
> +	ret = ida_simple_get(&pd_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto unregister_device;
> +
> +	pd_wdev->id = ret;
> +
> +	pd_args.np = parent->of_node;
> +	pd_args.args[0] = pd_id;
> +	pd_args.args_count = 1;
> +
> +	ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
> +
> +	if (ret)
> +		goto remove_ida;
> +
> +	ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
> +	if (ret < 0)
> +		goto out_genpd;
> +
> +	pd_wdev->max_state = ret - 1;
> +	pm_runtime_enable(&pd_wdev->dev);
> +	pd_wdev->runtime_resumed = false;
> +
> +	snprintf(cdev_name, sizeof(cdev_name), "thermal-pd-%d", pd_wdev->id);
> +	pd_wdev->cdev = thermal_of_cooling_device_register
> +					(NULL, cdev_name, pd_wdev,
> +					 &pd_warming_device_ops);
> +	if (IS_ERR(pd_wdev->cdev)) {
> +		pr_err("unable to register %s cooling device\n", cdev_name);
> +		ret = PTR_ERR(pd_wdev->cdev);
> +		goto out_runtime_disable;
> +	}
> +
> +	return pd_wdev->cdev;
> +
> +out_runtime_disable:
> +	pm_runtime_disable(&pd_wdev->dev);
> +out_genpd:
> +	pm_genpd_remove_device(&pd_wdev->dev);
> +remove_ida:
> +	ida_simple_remove(&pd_ida, pd_wdev->id);
> +unregister_device:
> +	device_unregister(&pd_wdev->dev);
> +out:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(of_pd_warming_register);
> +
> +void pd_warming_unregister(struct thermal_cooling_device *cdev)
> +{
> +	struct pd_warming_device *pd_wdev = cdev->devdata;
> +	struct device *dev = &pd_wdev->dev;
> +
> +	if (pd_wdev->runtime_resumed) {
> +		dev_pm_genpd_set_performance_state(dev, 0);
> +		pm_runtime_put(dev);
> +		pd_wdev->runtime_resumed = false;
> +	}
> +	pm_runtime_disable(dev);
> +	pm_genpd_remove_device(dev);
> +	ida_simple_remove(&pd_ida, pd_wdev->id);
> +	thermal_cooling_device_unregister(cdev);
> +	device_unregister(dev);
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
> +	return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline void
> +pd_warming_unregister(struct thermal_cooling_device *cdev)
> +{
> +}
> +#endif /* CONFIG_PWR_DOMAIN_WARMING_THERMAL */
> +#endif /* __PWR_DOMAIN_WARMING_H__ */
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

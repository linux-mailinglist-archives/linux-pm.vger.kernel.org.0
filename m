Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DC2CDA42
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLCPlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 10:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLCPlj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 10:41:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D3C061A4E
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 07:40:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a6so3151845wmc.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kCQS8T9IzaK7qsrPFGKkQow9sRMix1gp13CfkJxVIA0=;
        b=VXideQU4m746yyi4UAyDiWJeEJZT5L3Vw5k/xn06MXy3jlMwGBHa+GGn7QqEtNPCER
         FDdVWuKd+KJClvrz0z+GKBzLzpx8ZWuHikTch0FrWWRcqlwY7DqoY/6iVFSHbOJPMxqP
         6OXWx6S0Hb13t0jCiI+Tugt06DUWS8vDj5G6LhXFoMBi3LaIxKfNDpqhOwTIj6au4KWH
         OP/ndNlq6g46XazbTSibOJlf6GcDeLIkDHGClUaaKQGlHWXDg+0KbY20RPNdp/ZrfUak
         7qzNy098gY1pCT+PZXnk6/8Mu8jcP+oFn62Pt8LGdy2t3oZBmhPp2RyTaC4NP6EW2fF6
         2Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kCQS8T9IzaK7qsrPFGKkQow9sRMix1gp13CfkJxVIA0=;
        b=a5vAYjAdGXNcClh6+0gjXwZKV6ZfvBpnnAhIKgNuuu7cOyKgEnk2mk3kjf55Y2+R5b
         EsH+0US5mzWzDyh72jSJN4CObMgDiOF7dZzfpyJOnTVMoWP2mVdeE8FYqQ5MA8nkuGUl
         UQgt4KHxQZ2uspjL9FBFxfdiBwYXSFuNVYBpGOgFRIxpn47cjifdPt7efOQUWg6vJicS
         szGhz/NnTKOWWDLU7o1oDrtZy2Qz5SOFl2fAws3Y8JqFZ2I/cCfwvzAtK1ljANG/vIpf
         qPcwwASXCIuQqC/nQtw7grCSULgeHf161XPL/EMfsZJkdrvBMskLrMgFReL4aD6jChnI
         wxZQ==
X-Gm-Message-State: AOAM5321YSNquXd52I2ELTeulrP9A3OOqnXUdgefIpR4BJm0xH70cdQU
        0vooeGdRL3Ovw+/ZseXFV+HzqQ==
X-Google-Smtp-Source: ABdhPJzLB9zF1QadPDaL6kyXpahnC6RjyhmYQddcNPWEmYzU80qn43ICc2D9JRNcwrSz4Uv2vjnDsA==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr3976889wmb.99.1607010057394;
        Thu, 03 Dec 2020 07:40:57 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2? ([2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2])
        by smtp.googlemail.com with ESMTPSA id e27sm2710605wrc.9.2020.12.03.07.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 07:40:56 -0800 (PST)
Subject: Re: [PATCH v2 3/5] thermal: devfreq_cooling: add new registration
 functions with Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201118120358.17150-1-lukasz.luba@arm.com>
 <20201118120358.17150-4-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2eb16ccf-f635-af2d-616f-9cd0cec88ca0@linaro.org>
Date:   Thu, 3 Dec 2020 16:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118120358.17150-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/11/2020 13:03, Lukasz Luba wrote:
> The Energy Model (EM) framework supports devices such as Devfreq. Create
> new registration functions which automatically register EM for the thermal
> devfreq_cooling devices. This patch prepares the code for coming changes
> which are going to replace old power model with the new EM.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c | 99 ++++++++++++++++++++++++++++++-
>  include/linux/devfreq_cooling.h   | 22 +++++++
>  2 files changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 925523694462..b354271742c5 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -50,6 +50,8 @@ static DEFINE_IDA(devfreq_ida);
>   * @capped_state:	index to cooling state with in dynamic power budget
>   * @req_max_freq:	PM QoS request for limiting the maximum frequency
>   *			of the devfreq device.
> + * @em:		Energy Model for the associated Devfreq device
> + * @em_registered:	Devfreq cooling registered the EM and should free it.
>   */
>  struct devfreq_cooling_device {
>  	int id;
> @@ -63,6 +65,8 @@ struct devfreq_cooling_device {
>  	u32 res_util;
>  	int capped_state;
>  	struct dev_pm_qos_request req_max_freq;
> +	struct em_perf_domain *em;

This pointer is not needed, it is in the struct device.

> +	bool em_registered;

The boolean em_registered is not needed because of the test in the
function em_dev_unregister_perf_domain():

if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
                return;

Logically if the 'em' was not initialized, it must be NULL, the
corresponding struct device was zero-allocated.


>  };
>  
>  static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
> @@ -583,22 +587,115 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>  }
>  EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>  
> +/**
> + * devfreq_cooling_em_register_power() - Register devfreq cooling device with
> + *		power information and attempt to register Energy Model (EM)
> + * @df:		Pointer to devfreq device.
> + * @dfc_power:	Pointer to devfreq_cooling_power.
> + * @em_cb:	Callback functions providing the data of the EM
> + *
> + * Register a devfreq cooling device and attempt to register Energy Model. The
> + * available OPPs must be registered for the device.
> + *
> + * If @dfc_power is provided, the cooling device is registered with the
> + * power extensions. If @em_cb is provided it will be called for each OPP to
> + * calculate power value and cost. If @em_cb is not provided then simple Energy
> + * Model is going to be used, which requires "dynamic-power-coefficient" a
> + * devicetree property.
> + */
> +struct thermal_cooling_device *
> +devfreq_cooling_em_register_power(struct devfreq *df,
> +				  struct devfreq_cooling_power *dfc_power,
> +				  struct em_data_callback *em_cb)
> +{
> +	struct thermal_cooling_device *cdev;
> +	struct devfreq_cooling_device *dfc;
> +	struct device_node *np = NULL;
> +	struct device *dev;
> +	int nr_opp, ret;
> +
> +	if (IS_ERR_OR_NULL(df))
> +		return ERR_PTR(-EINVAL);
> +
> +	dev = df->dev.parent;

Why the parent ?

> +
> +	if (em_cb) {
> +		nr_opp = dev_pm_opp_get_opp_count(dev);
> +		if (nr_opp <= 0) {
> +			dev_err(dev, "No valid OPPs found\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		ret = em_dev_register_perf_domain(dev, nr_opp, em_cb, NULL, false);
> +	} else {
> +		ret = dev_pm_opp_of_register_em(dev, NULL);
> +	}
> +
> +	if (ret)
> +		dev_warn(dev, "Unable to register EM for devfreq cooling device (%d)\n",
> +			 ret);
> +
> +	if (dev->of_node)
> +		np = of_node_get(dev->of_node);
> +
> +	cdev = of_devfreq_cooling_register_power(np, df, dfc_power);
> +
> +	if (np)
> +		of_node_put(np);> +
> +	if (IS_ERR_OR_NULL(cdev)) {
> +		if (!ret)
> +			em_dev_unregister_perf_domain(dev);
> +	} else {
> +		dfc = cdev->devdata;
> +		dfc->em_registered = !ret;
> +	}
> +
> +	return cdev;
> +}
> +EXPORT_SYMBOL_GPL(devfreq_cooling_em_register_power);
> +
> +/**
> + * devfreq_cooling_em_register() - Register devfreq cooling device together
> + *				with Energy Model.
> + * @df:		Pointer to devfreq device.
> + * @em_cb:	Callback functions providing the data of the Energy Model
> + *
> + * This function attempts to register Energy Model for devfreq device and then
> + * register the devfreq cooling device.
> + */
> +struct thermal_cooling_device *
> +devfreq_cooling_em_register(struct devfreq *df, struct em_data_callback *em_cb)
> +{
> +	return devfreq_cooling_em_register_power(df, NULL, em_cb);
> +}
> +EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
> +
>  /**
>   * devfreq_cooling_unregister() - Unregister devfreq cooling device.
>   * @cdev: Pointer to devfreq cooling device to unregister.
> + *
> + * Unregisters devfreq cooling device and related Energy Model if it was
> + * present.
>   */
>  void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  {
>  	struct devfreq_cooling_device *dfc;
> +	struct device *dev;
>  
> -	if (!cdev)
> +	if (IS_ERR_OR_NULL(cdev))

Why this additional IS_ERR check ?

>  		return;
>  
>  	dfc = cdev->devdata;
> +	dev = dfc->devfreq->dev.parent;
>  
>  	thermal_cooling_device_unregister(dfc->cdev);
>  	ida_simple_remove(&devfreq_ida, dfc->id);
>  	dev_pm_qos_remove_request(&dfc->req_max_freq);
> +
> +	if (dfc->em_registered)
> +		em_dev_unregister_perf_domain(dev);
> +

As stated before it can be called unconditionally

>  	kfree(dfc->power_table);
>  	kfree(dfc->freq_table);
>  
> diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
> index 9df2dfca68dd..19868fb922f1 100644
> --- a/include/linux/devfreq_cooling.h
> +++ b/include/linux/devfreq_cooling.h
> @@ -11,6 +11,7 @@
>  #define __DEVFREQ_COOLING_H__
>  
>  #include <linux/devfreq.h>
> +#include <linux/energy_model.h>
>  #include <linux/thermal.h>
>  
>  
> @@ -65,6 +66,13 @@ struct thermal_cooling_device *
>  of_devfreq_cooling_register(struct device_node *np, struct devfreq *df);
>  struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df);
>  void devfreq_cooling_unregister(struct thermal_cooling_device *dfc);
> +struct thermal_cooling_device *
> +devfreq_cooling_em_register_power(struct devfreq *df,
> +				  struct devfreq_cooling_power *dfc_power,
> +				  struct em_data_callback *em_cb);
> +struct thermal_cooling_device *
> +devfreq_cooling_em_register(struct devfreq *df,
> +			    struct em_data_callback *em_cb);
>  
>  #else /* !CONFIG_DEVFREQ_THERMAL */
>  
> @@ -87,6 +95,20 @@ devfreq_cooling_register(struct devfreq *df)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +static inline struct thermal_cooling_device *
> +devfreq_cooling_em_register_power(struct devfreq *df,
> +				  struct devfreq_cooling_power *dfc_power,
> +				  struct em_data_callback *em_cb)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline struct thermal_cooling_device *
> +devfreq_cooling_em_register(struct devfreq *df,	struct em_data_callback *em_cb)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static inline void
>  devfreq_cooling_unregister(struct thermal_cooling_device *dfc)
>  {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

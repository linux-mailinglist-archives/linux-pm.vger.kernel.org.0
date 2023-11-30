Return-Path: <linux-pm+bounces-549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753D7FF002
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23EE281F50
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F84778C;
	Thu, 30 Nov 2023 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2SqlS35"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D9D6C
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 05:22:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332e40322f0so610872f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 05:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701350548; x=1701955348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4u7VCdFIs72013OKeFY0fqK/9EGR+LhEmp/Sst4Z+g=;
        b=V2SqlS354UgKlca1RfvftgU/37xTZv+vXwOIyrfGTT1mHeaEM5Ilk58DfNgL3zJ64d
         CjI7jJFkeTwYxWsJgFvuV4qtGlL7ZiRj0u82uehRxH2MxSvwnqBc8liuVkfj92nnZv/4
         1CASelJ2NdRCSqZYNo0gy6MDyvS4UmA5JGxagUQK2EuD1rpW5NsLD1KPxSU3oebJ94Q3
         vWpgbg8Q+lzWvG9vPAndma+6RewiSoFFhxXcQ5sVsHbzxE+Lqd6EjFY2Cnoag3HTsJiK
         u6YNCTYfHheVdqZW4d+Y//Wq15v5v//ni1Liyd1ZmFxDTwYv31mPltPYzgCkwTsBiH+C
         s9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350548; x=1701955348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4u7VCdFIs72013OKeFY0fqK/9EGR+LhEmp/Sst4Z+g=;
        b=vkVyaWSLoKLC92Iz/Yf5uW8gZBNd98XxxaMjzU7B6rWVRMQm4NaAZvaI8Ow+zQUMC9
         9IRch/BKvyvqCI1wq0zjFRINMJU7uWYfEgqvgjgeYqLch4k/PM8oPyT3Ng1QL7rTeXIU
         mJwATEcKqtN7pUEiHrcZ732u/PiFxsFrX9RLJOxUYYWPrwp8Bp5636QeNuorxvckUtbX
         F4yVTbEr+Wgr779N1yYhVSqgCXcgynpSjb3rndAMgR/CrSiubqyW3Od5jh6CLhg2F9cE
         ivKb8LVnEqW6co/Urr4etYcwVH9G7QCl+etRscMAWEwikxq+DIQSaNwYRwjmxuHfJCEn
         IDlA==
X-Gm-Message-State: AOJu0Yz/FC/Q3fHyTLnO/w+LhDbGl65BQMdndkwm2THIs7/hnnpzWkug
	/2zkSYWw+p71XdbABhYYmptdSQ==
X-Google-Smtp-Source: AGHT+IGrxqe8Q3EsAkZmX0rGbaVy053Wxcf2f11HNsi9FOXV1sgeRwkepP7AHhoWTwIJNTUrkTUm9w==
X-Received: by 2002:adf:e351:0:b0:332:fd68:6657 with SMTP id n17-20020adfe351000000b00332fd686657mr9524866wrj.56.1701350547734;
        Thu, 30 Nov 2023 05:22:27 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:3992:5718:8297:bc86? ([2a05:6e02:1041:c10:3992:5718:8297:bc86])
        by smtp.googlemail.com with ESMTPSA id j6-20020a5d6046000000b0033326e90496sm821800wrt.18.2023.11.30.05.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 05:22:27 -0800 (PST)
Message-ID: <09de3b1b-b725-46b8-97a6-55776fd5ca45@linaro.org>
Date: Thu, 30 Nov 2023 14:22:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Add support for device tree thermal zones
 consumers
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
References: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Angelo,

thanks for your proposal

On 15/11/2023 15:48, AngeloGioacchino Del Regno wrote:
> Add helpers to support retrieving thermal zones from device tree nodes:
> this will allow a device tree consumer to specify phandles to specific
> thermal zone(s), including support for specifying thermal-zone-names.
> This is useful, for example, for smart voltage scaling drivers that
> need to adjust CPU/GPU/other voltages based on temperature, and for
> battery charging drivers that need to scale current based on various
> aggregated temperature sensor readings which are board-dependant.

IMO these changes are trying to solve something from the DT perspective 
adding more confusion between phandle, names, types etc ... and it does 
not really help AFAICT.

Overall I'm a bit reluctant to add more API in the thermal.h. From my 
POV, we should try to remove as much as possible functions from there.

That said, the name of a thermal zone does not really exists and there 
is confusion in the code between a name and a type. (type being assumed 
to be a name).

There could be several thermal zones with the same types for non-DT 
description. However, the documentation says we should create an unique 
type in the DT and that is what is happening when registering a thermal 
zone from the DT [1] as we use the node name.

 From an external driver, it possible to get the np->name from the 
phandles and call thermal_zone_get_by_name(np->name).

The hardening change which may make sense is to check a thermal zone 
with the same name is not already registered in thermal_of.c by checking 
thermal_zone_get_by_name() fails before registering it.

   -- Daniel

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/thermal_of.c?h=thermal%2Fbleeding-edge#n514

> Example:
> smart-scaling-driver@10000000 {
> 	[...]
> 
> 	thermal-zones = <&cluster_big_tz>, <&gpu_tz>, <&vpu_tz>;
> 	thermal-zone-names = "cpu", "gpu", "vpu";
> 
> 	[...]
> }
> 
> battery-charger@20000000 {
> 	[...]
> 
> 	thermal-zones = <&battery_temp>, <&device_skin_temp>;
> 	thermal-zone-names = "batt-ext-sensor", "skin";
> 
> 	[...]
> }
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Changes in v2:
>   - Added missing static inline for !CONFIG_OF fallback functions
> 
> Background story: while I was cleaning up the MediaTek Smart Voltage Scaling
> (SVS) driver, I've found out that there's a lot of commonization to be done.
> After a rewrite of "this and that" in that driver, I came across a barrier
> that didn't allow me to remove another ~100 lines of code, and that was also
> anyway breaking the driver, because the thermal zone names are different
> from what was originally intended.
> 
> I've been looking for thermal zone handle retrieval around the kernel and
> found that there currently are at least four other drivers that could make
> use this as a cleanup: charger-manager, which is retrieving a thermal zone
> to look for with a "cm-thermal-zone" string property, gpu/drm/tiny/repaper.c
> that does the same by checking a "pervasive,thermal-zone" string property,
> and ab8500_temp and sdhci-omap which are simply hardcoding a "cpu_thermal"
> and "battery-thermal" thermal zone names respectively.
> 
> There are a number of other devices (mostly embedded, mostly smartphones)
> that don't have an upstream driver and that could make use of this as well.
> 
> Cheers!
> 
> 
>   drivers/thermal/thermal_of.c | 91 ++++++++++++++++++++++++++++++++++++
>   include/linux/thermal.h      | 15 ++++++
>   2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..d8ead456993e 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -538,6 +538,97 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   	return ERR_PTR(ret);
>   }
>   
> +/**
> + * __thermal_of_get_zone_by_index() - Get thermal zone handle from the DT
> + *				      thermal-zones index
> + * @dev:   Pointer to the consumer device
> + * @index: Index of thermal-zones
> + *
> + * This function will search for a thermal zone in the thermal-zones phandle
> + * array corresponding to the specified index, then will search for its name
> + * into the registered thermal zones through thermal_zone_get_zone_by_name()
> + *
> + * Please note that this function is for internal use only and expects that
> + * all of the sanity checks are performed by its caller.
> + *
> + * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
> + * when the API is disabled or the "thermal-zones" DT property is missing.
> + */
> +static struct thermal_zone_device
> +*__thermal_of_get_zone_by_index(struct device *dev, int index)
> +{
> +	struct thermal_zone_device *tzd;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(dev->of_node, "thermal-zones", index);
> +	if (!np)
> +		return NULL;
> +
> +	tzd = thermal_zone_get_zone_by_name(np->name);
> +	of_node_put(np);
> +
> +	return tzd;
> +}
> +
> +/**
> + * thermal_of_get_zone_by_index() - Get thermal zone handle from a DT node
> + *				    based on index
> + * @dev:   Pointer to the consumer device
> + * @index: Index of thermal-zones
> + *
> + * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
> + * when the API is disabled or the "thermal-zones" DT property is missing.
> + */
> +struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
> +{
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_property_present(dev->of_node, "thermal-zones"))
> +		return NULL;
> +
> +	return __thermal_of_get_zone_by_index(dev, index);
> +}
> +
> +/**
> + * thermal_of_get_zone() - Get thermal zone handle from a DT node based
> + *			   on name, or the first handle in list
> + * @dev:   Pointer to the consumer device
> + * @name:  Name as found in thermal-zone-names or NULL
> + *
> + * This function will search for a thermal zone in the thermal-zones phandle
> + * array corresponding to the index of that in the thermal-zone-names array.
> + * If the name is not specified (NULL), it will return the first thermal zone
> + * in the thermal-zones phandle array.
> + *
> + * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
> + * when the API is disabled or the "thermal-zones" DT property is missing.
> + */
> +struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
> +{
> +	int index;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_property_present(dev->of_node, "thermal-zones")) {
> +		pr_err("thermal zones property not present\n");
> +		return NULL;
> +	}
> +
> +	if (name) {
> +		index = of_property_match_string(dev->of_node, "thermal-zone-names", name);
> +		if (index < 0) {
> +			pr_err("thermal zone names property not present\n");
> +			return ERR_PTR(index);
> +		}
> +	} else {
> +		index = 0;
> +	}
> +
> +	return __thermal_of_get_zone_by_index(dev, index);
> +}
> +
>   static void devm_thermal_of_zone_release(struct device *dev, void *res)
>   {
>   	thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index cee814d5d1ac..0fceeb7ed08a 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -261,6 +261,9 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
>   
>   void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
>   
> +struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index);
> +struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name);
> +
>   #else
>   
>   static inline
> @@ -274,6 +277,18 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
>   						   struct thermal_zone_device *tz)
>   {
>   }
> +
> +static inline
> +struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline
> +struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
>   #endif
>   
>   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



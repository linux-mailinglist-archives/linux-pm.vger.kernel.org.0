Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943E6D1ABD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCaIt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCaIt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 04:49:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C11A953
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:49:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso4356026wmo.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680252552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0jEXvo6u2+BhLKwkJmfDK8810/6BhU9roz8utm2m9U=;
        b=KBaZdfLOBA1vtfK02ZpeI+MXdrmWikF8Bn4TProiRmOi6bxDBAGz0GdQQXfCdI+CDI
         q2EP7FNzsN5lPQELJDftgvMiFEhiGzlL6C9lMt9vMdIhHVrCgNwdAIaWCE1VhwJwz3tj
         Dqsdp6Lq2pN0FNCxyHjulP7VHBeer1VVuWF6TwFI2Xy7BsCPGkK8msYkf+kLB0v6c2Gm
         qDN0Y3znHI7eTsvX0iDWRQ+Lardy4AbPmtngUxsDmrUd1gWB9wsGMoqYC6NvKnOyhu+a
         FBm7z6HrPur9bH/YViB1GiDrPcpEr+OQp3RTEyqN1RBF0ZMoteQvZt/h8fBcig6sZTpz
         DClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680252552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0jEXvo6u2+BhLKwkJmfDK8810/6BhU9roz8utm2m9U=;
        b=RhLsEhgOIR1tObdK2aIxD/2/RPrXUh9WxXRbLR0+EyIpUdqxlLjEam8+XAPj2kYFpE
         voJCiaGr/cIn6OUb9+Y217uBPNe2HS9cJpIs7OH//qWiAJtX7eipPt5xu8ilN+DSVm8o
         8NIdbQ6PBI9wTW0l0SF97Wy7gzCQXRApN6EXsrhml097/uv6gCyNuJgF9EUwgbrTnSRb
         4G+TCFIwBW+2nVb3/smiF9ZHY6xaFhufrhEFKO28+4FIPTavauM4hHmCpl8c3LPWDF1e
         3EnYuBXU/FIHVDLSb5fKRGVu/pegvhMsvzLxRAh5+1G6+lIBnhg1Tx3K5bSjxC9HtY6a
         94aQ==
X-Gm-Message-State: AAQBX9d/w1tuMS0dCjPZ3YJHgnqykzarrJBiJWdFKgpmKgMvh8l5aank
        eRzTr8y2jvJbh0LKp0CE2soV4w==
X-Google-Smtp-Source: AKy350ZXWPrNMozEaJsrztMT4/xqb+Vr1IwxePJwY1g6uQzQ3G3+fb6DJSt7esgoD2GUoHAENK9MHw==
X-Received: by 2002:a1c:4c18:0:b0:3ef:7584:9896 with SMTP id z24-20020a1c4c18000000b003ef75849896mr9566071wmf.26.1680252552376;
        Fri, 31 Mar 2023 01:49:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:17ff:909e:1b73:8366? ([2a05:6e02:1041:c10:17ff:909e:1b73:8366])
        by smtp.googlemail.com with ESMTPSA id r16-20020a05600c459000b003f03d483966sm3649687wmo.44.2023.03.31.01.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 01:49:12 -0700 (PDT)
Message-ID: <751e20b9-34f6-ab1d-dd42-70239044f13d@linaro.org>
Date:   Fri, 31 Mar 2023 10:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal/core: Remove thermal_bind_params structure
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230330104526.3196-1-rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230330104526.3196-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rui,


On 30/03/2023 12:45, Zhang Rui wrote:
> Remove struct thermal_bind_params because no one is using it for thermal
> binding now.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Thanks for the cleanup, always good to remove unused code.

Rafael, is it fine if I pick it ?

> ---
>   .../driver-api/thermal/sysfs-api.rst          |  40 ------
>   drivers/thermal/thermal_core.c                | 129 ++----------------
>   include/linux/thermal.h                       |  38 ------
>   3 files changed, 11 insertions(+), 196 deletions(-)
> 
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index 2e0f79a9e2ee..6c1175c6afba 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -304,42 +304,6 @@ temperature) and throttle appropriate devices.
>   1.4 Thermal Zone Parameters
>   ---------------------------
>   
> -    ::
> -
> -	struct thermal_bind_params
> -
> -    This structure defines the following parameters that are used to bind
> -    a zone with a cooling device for a particular trip point.
> -
> -    .cdev:
> -	     The cooling device pointer
> -    .weight:
> -	     The 'influence' of a particular cooling device on this
> -	     zone. This is relative to the rest of the cooling
> -	     devices. For example, if all cooling devices have a
> -	     weight of 1, then they all contribute the same. You can
> -	     use percentages if you want, but it's not mandatory. A
> -	     weight of 0 means that this cooling device doesn't
> -	     contribute to the cooling of this zone unless all cooling
> -	     devices have a weight of 0. If all weights are 0, then
> -	     they all contribute the same.
> -    .trip_mask:
> -	       This is a bit mask that gives the binding relation between
> -	       this thermal zone and cdev, for a particular trip point.
> -	       If nth bit is set, then the cdev and thermal zone are bound
> -	       for trip point n.
> -    .binding_limits:
> -		     This is an array of cooling state limits. Must have
> -		     exactly 2 * thermal_zone.number_of_trip_points. It is an
> -		     array consisting of tuples <lower-state upper-state> of
> -		     state limits. Each trip will be associated with one state
> -		     limit tuple when binding. A NULL pointer means
> -		     <THERMAL_NO_LIMITS THERMAL_NO_LIMITS> on all trips.
> -		     These limits are used when binding a cdev to a trip point.
> -    .match:
> -	    This call back returns success(0) if the 'tz and cdev' need to
> -	    be bound, as per platform data.
> -
>       ::
>   
>   	struct thermal_zone_params
> @@ -357,10 +321,6 @@ temperature) and throttle appropriate devices.
>   	       will be created. when no_hwmon == true, nothing will be done.
>   	       In case the thermal_zone_params is NULL, the hwmon interface
>   	       will be created (for backward compatibility).
> -    .num_tbps:
> -	       Number of thermal_bind_params entries for this zone
> -    .tbp:
> -	       thermal_bind_params entries
>   
>   2. sysfs attributes structure
>   =============================
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d51cacd66756..2e6a49dd527d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -794,64 +794,18 @@ void print_bind_err_msg(struct thermal_zone_device *tz,
>   		tz->type, cdev->type, ret);
>   }
>   
> -static void __bind(struct thermal_zone_device *tz, int mask,
> -		   struct thermal_cooling_device *cdev,
> -		   unsigned long *limits,
> -		   unsigned int weight)
> -{
> -	int i, ret;
> -
> -	for (i = 0; i < tz->num_trips; i++) {
> -		if (mask & (1 << i)) {
> -			unsigned long upper, lower;
> -
> -			upper = THERMAL_NO_LIMIT;
> -			lower = THERMAL_NO_LIMIT;
> -			if (limits) {
> -				lower = limits[i * 2];
> -				upper = limits[i * 2 + 1];
> -			}
> -			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
> -							       upper, lower,
> -							       weight);
> -			if (ret)
> -				print_bind_err_msg(tz, cdev, ret);
> -		}
> -	}
> -}
> -
>   static void bind_cdev(struct thermal_cooling_device *cdev)
>   {
> -	int i, ret;
> -	const struct thermal_zone_params *tzp;
> +	int ret;
>   	struct thermal_zone_device *pos = NULL;
>   
>   	mutex_lock(&thermal_list_lock);
>   
>   	list_for_each_entry(pos, &thermal_tz_list, node) {
> -		if (!pos->tzp && !pos->ops->bind)
> -			continue;
> -
>   		if (pos->ops->bind) {
>   			ret = pos->ops->bind(pos, cdev);
>   			if (ret)
>   				print_bind_err_msg(pos, cdev, ret);
> -			continue;
> -		}
> -
> -		tzp = pos->tzp;
> -		if (!tzp || !tzp->tbp)
> -			continue;
> -
> -		for (i = 0; i < tzp->num_tbps; i++) {
> -			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> -				continue;
> -			if (tzp->tbp[i].match(pos, cdev))
> -				continue;
> -			tzp->tbp[i].cdev = cdev;
> -			__bind(pos, tzp->tbp[i].trip_mask, cdev,
> -			       tzp->tbp[i].binding_limits,
> -			       tzp->tbp[i].weight);
>   		}
>   	}
>   
> @@ -1138,16 +1092,6 @@ void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
>   
> -static void __unbind(struct thermal_zone_device *tz, int mask,
> -		     struct thermal_cooling_device *cdev)
> -{
> -	int i;
> -
> -	for (i = 0; i < tz->num_trips; i++)
> -		if (mask & (1 << i))
> -			thermal_zone_unbind_cooling_device(tz, i, cdev);
> -}
> -
>   /**
>    * thermal_cooling_device_unregister - removes a thermal cooling device
>    * @cdev:	the thermal cooling device to remove.
> @@ -1157,8 +1101,6 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
>    */
>   void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>   {
> -	int i;
> -	const struct thermal_zone_params *tzp;
>   	struct thermal_zone_device *tz;
>   
>   	if (!cdev)
> @@ -1175,21 +1117,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>   
>   	/* Unbind all thermal zones associated with 'this' cdev */
>   	list_for_each_entry(tz, &thermal_tz_list, node) {
> -		if (tz->ops->unbind) {
> +		if (tz->ops->unbind)
>   			tz->ops->unbind(tz, cdev);
> -			continue;
> -		}
> -
> -		if (!tz->tzp || !tz->tzp->tbp)
> -			continue;
> -
> -		tzp = tz->tzp;
> -		for (i = 0; i < tzp->num_tbps; i++) {
> -			if (tzp->tbp[i].cdev == cdev) {
> -				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
> -				tzp->tbp[i].cdev = NULL;
> -			}
> -		}
>   	}
>   
>   	mutex_unlock(&thermal_list_lock);
> @@ -1200,41 +1129,20 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>   
>   static void bind_tz(struct thermal_zone_device *tz)
>   {
> -	int i, ret;
> +	int ret;
>   	struct thermal_cooling_device *pos = NULL;
> -	const struct thermal_zone_params *tzp = tz->tzp;
>   
> -	if (!tzp && !tz->ops->bind)
> +	if (!tz->ops->bind)
>   		return;
>   
>   	mutex_lock(&thermal_list_lock);
>   
> -	/* If there is ops->bind, try to use ops->bind */
> -	if (tz->ops->bind) {
> -		list_for_each_entry(pos, &thermal_cdev_list, node) {
> -			ret = tz->ops->bind(tz, pos);
> -			if (ret)
> -				print_bind_err_msg(tz, pos, ret);
> -		}
> -		goto exit;
> -	}
> -
> -	if (!tzp || !tzp->tbp)
> -		goto exit;
> -
>   	list_for_each_entry(pos, &thermal_cdev_list, node) {
> -		for (i = 0; i < tzp->num_tbps; i++) {
> -			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> -				continue;
> -			if (tzp->tbp[i].match(tz, pos))
> -				continue;
> -			tzp->tbp[i].cdev = pos;
> -			__bind(tz, tzp->tbp[i].trip_mask, pos,
> -			       tzp->tbp[i].binding_limits,
> -			       tzp->tbp[i].weight);
> -		}
> +		ret = tz->ops->bind(tz, pos);
> +		if (ret)
> +			print_bind_err_msg(tz, pos, ret);
>   	}
> -exit:
> +
>   	mutex_unlock(&thermal_list_lock);
>   }
>   
> @@ -1491,15 +1399,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_id);
>    */
>   void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   {
> -	int i, tz_id;
> -	const struct thermal_zone_params *tzp;
> +	int tz_id;
>   	struct thermal_cooling_device *cdev;
>   	struct thermal_zone_device *pos = NULL;
>   
>   	if (!tz)
>   		return;
>   
> -	tzp = tz->tzp;
>   	tz_id = tz->id;
>   
>   	mutex_lock(&thermal_list_lock);
> @@ -1514,22 +1420,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   	list_del(&tz->node);
>   
>   	/* Unbind all cdevs associated with 'this' thermal zone */
> -	list_for_each_entry(cdev, &thermal_cdev_list, node) {
> -		if (tz->ops->unbind) {
> +	list_for_each_entry(cdev, &thermal_cdev_list, node)
> +		if (tz->ops->unbind)
>   			tz->ops->unbind(tz, cdev);
> -			continue;
> -		}
> -
> -		if (!tzp || !tzp->tbp)
> -			break;
> -
> -		for (i = 0; i < tzp->num_tbps; i++) {
> -			if (tzp->tbp[i].cdev == cdev) {
> -				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
> -				tzp->tbp[i].cdev = NULL;
> -			}
> -		}
> -	}
>   
>   	mutex_unlock(&thermal_list_lock);
>   
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index fef625f799ae..ab7460bfdcf6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -207,41 +207,6 @@ struct thermal_governor {
>   	struct list_head	governor_list;
>   };
>   
> -/* Structure that holds binding parameters for a zone */
> -struct thermal_bind_params {
> -	struct thermal_cooling_device *cdev;
> -
> -	/*
> -	 * This is a measure of 'how effectively these devices can
> -	 * cool 'this' thermal zone. It shall be determined by
> -	 * platform characterization. This value is relative to the
> -	 * rest of the weights so a cooling device whose weight is
> -	 * double that of another cooling device is twice as
> -	 * effective. See Documentation/driver-api/thermal/sysfs-api.rst for more
> -	 * information.
> -	 */
> -	int weight;
> -
> -	/*
> -	 * This is a bit mask that gives the binding relation between this
> -	 * thermal zone and cdev, for a particular trip point.
> -	 * See Documentation/driver-api/thermal/sysfs-api.rst for more information.
> -	 */
> -	int trip_mask;
> -
> -	/*
> -	 * This is an array of cooling state limits. Must have exactly
> -	 * 2 * thermal_zone.number_of_trip_points. It is an array consisting
> -	 * of tuples <lower-state upper-state> of state limits. Each trip
> -	 * will be associated with one state limit tuple when binding.
> -	 * A NULL pointer means <THERMAL_NO_LIMITS THERMAL_NO_LIMITS>
> -	 * on all trips.
> -	 */
> -	unsigned long *binding_limits;
> -	int (*match) (struct thermal_zone_device *tz,
> -			struct thermal_cooling_device *cdev);
> -};
> -
>   /* Structure to define Thermal Zone parameters */
>   struct thermal_zone_params {
>   	char governor_name[THERMAL_NAME_LENGTH];
> @@ -253,9 +218,6 @@ struct thermal_zone_params {
>   	 */
>   	bool no_hwmon;
>   
> -	int num_tbps;	/* Number of tbp entries */
> -	struct thermal_bind_params *tbp;
> -
>   	/*
>   	 * Sustainable power (heat) that this thermal zone can dissipate in
>   	 * mW

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-pm+bounces-16260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A762D9AB793
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569E41F21B9F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87301CB539;
	Tue, 22 Oct 2024 20:24:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4413E41A
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628688; cv=none; b=GU1XF7W6tCZRsWcOTKFm8fxLSnXCwq7N4aGKtVsFfwVyhhy7UWmC+fQlvFHQORGtKSSivx9e1NWaSWOovLIUDWRIIqFyS8US057so9d4pjFgaHqkyT3+iN41KBreD6jq08HECm9awx8ZggifeWDQC4ixIuI/VQl8xsUAXaHVXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628688; c=relaxed/simple;
	bh=Z8qsssNuF7Ilsg8kWPB71TiQztUMHO3IeOV17xKtxm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibblGcIaingRVBAp/5x4giztMfFlcveNmJGuzhpEUQVUL03zTjN6I8jiN3sO2zC/WVELmJouMjFrt+beXhSJLpO+fMhqlhEKpquCkPe0Ovpc6Z9UoTt2ayo/YF5f3lZIFKsGQcMs823hm+KZTKwawaHulLd7QmbAe++6h0IdGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA10497;
	Tue, 22 Oct 2024 13:25:15 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B0C3F73B;
	Tue, 22 Oct 2024 13:24:44 -0700 (PDT)
Message-ID: <cbadcbb6-72b0-4ac1-a3ed-15c935a3772e@arm.com>
Date: Tue, 22 Oct 2024 21:25:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] thermal: core: Connect the threshold with the core
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
 <20241022155147.463475-2-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241022155147.463475-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/24 16:51, Daniel Lezcano wrote:
> Initialize, de-initialize and handle the threshold in the same place
> than the trip points.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Link: https://patch.msgid.link/20240923100005.2532430-3-daniel.lezcano@linaro.org
> [ rjw: Subject edit ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 8f03985f971c..1e87256e86be 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -585,6 +585,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   			high = td->threshold;
>   	}
>   
> +	thermal_thresholds_handle(tz, &low, &high);
> +
>   	thermal_zone_set_trips(tz, low, high);
>   
>   	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
> @@ -1491,6 +1493,10 @@ thermal_zone_device_register_with_trips(const char *type,
>   			goto unregister;
>   	}
>   
> +	result = thermal_thresholds_init(tz);
> +	if (result)
> +		goto remove_hwmon;
> +

AFAICS the function thermal_thresholds_init() cannot fail.
It always returns 0. So compiler+linker will remove that check anyway. 
Therefore, I would remove the check in this code.
Or maybe you have some other plans in near future to that init
function...

>   	mutex_lock(&thermal_list_lock);
>   
>   	mutex_lock(&tz->lock);
> @@ -1514,6 +1520,8 @@ thermal_zone_device_register_with_trips(const char *type,
>   
>   	return tz;
>   
> +remove_hwmon:
> +	thermal_remove_hwmon_sysfs(tz);

So remove this line as well, since it cannot happen.
Although, it's a minor so up to you.

>   unregister:
>   	device_del(&tz->device);
>   release_device:
> @@ -1601,6 +1609,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   
>   	thermal_set_governor(tz, NULL);
>   
> +	thermal_thresholds_exit(tz);
>   	thermal_remove_hwmon_sysfs(tz);
>   	ida_free(&thermal_tz_ida, tz->id);
>   	ida_destroy(&tz->ida);

Other than that, since no functional issues

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


Return-Path: <linux-pm+bounces-13661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0096D2B0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203311F23BED
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673D197545;
	Thu,  5 Sep 2024 09:02:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9308F66;
	Thu,  5 Sep 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526926; cv=none; b=pNipCc25fKtTX25ovFsvfdoDIvohqSp5EFW1LKO3qjOVYip4THPXLuMsF678+oouluvRIwzHodJN5OQJSFhyXRuPGe4f3UPBe/4ww67f1WbwmPIM7QnLUwud7dZD6A4dCLODvzldmpUSPOCVkrLjMFaGM1kZ+z14iY3yzk28zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526926; c=relaxed/simple;
	bh=FHKEyAvuubLDSStqDRjDFhoQhwUSFGr1cpx1VpjtTSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BENZZTqBrcywxDz6CPsW7YiCieJX94S0PDWnQNwVhkCYE/D07Udnylme4K6xKnYH98PbWcv25X14HsRVSdUuxVHc6DTwtbjLVfIz1qh9Z7CeToZ5F10apf8/TphXryn1U2FWkaZvmHLPn2ibLdslKyMfTT+dEPjNe1weybJ3Hno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86DF6FEC;
	Thu,  5 Sep 2024 02:02:30 -0700 (PDT)
Received: from [10.57.86.69] (unknown [10.57.86.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 688123F73F;
	Thu,  5 Sep 2024 02:02:02 -0700 (PDT)
Message-ID: <2fe5274b-b6ea-4c70-9896-8ae6aa99e174@arm.com>
Date: Thu, 5 Sep 2024 10:02:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: sysfs: Add sanity checks for trip temperature
 and hysteresis
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12528772.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <12528772.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/26/24 17:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add sanity checks for new trip temperature and hysteresis values to
> trip_point_temp_store() and trip_point_hyst_store() to prevent trip
> point threshold from falling below THERMAL_TEMP_INVALID.
> 
> However, still allow user space to pass THERMAL_TEMP_INVALID as the
> new trip temperature value to invalidate the trip if necessary.
> 
> Also allow the hysteresis to be updated when the temperature is invalid
> to allow user space to avoid having to adjust hysteresis after a valid
> temperature has been set, but in that case just change the value and do
> nothing else.
> 
> Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Reorder the new check in trip_point_hyst_store() to be easier
>       to read (Daniel).
>     * Add a comment explaining the ordering of the new check in
>       trip_point_temp_store().
>     * Allow the hysteresis to be updated when the temperature is invalid.
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/7719509.EvYhyI6sBW@rjwysocki.net/
> 
> which is being sent separately because patch [1/2] from the original series
> has been applied.
> 
> ---
>   drivers/thermal/thermal_sysfs.c |   50 ++++++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -111,18 +111,26 @@ trip_point_temp_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	if (temp != trip->temperature) {
> -		if (tz->ops.set_trip_temp) {
> -			ret = tz->ops.set_trip_temp(tz, trip, temp);
> -			if (ret)
> -				goto unlock;
> -		}
> +	if (temp == trip->temperature)
> +		goto unlock;
>   
> -		thermal_zone_set_trip_temp(tz, trip, temp);
> +	/* Arrange the condition to avoid integer overflows. */
> +	if (temp != THERMAL_TEMP_INVALID &&
> +	    temp <= trip->hysteresis + THERMAL_TEMP_INVALID) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
>   
> -		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +	if (tz->ops.set_trip_temp) {
> +		ret = tz->ops.set_trip_temp(tz, trip, temp);
> +		if (ret)
> +			goto unlock;
>   	}
>   
> +	thermal_zone_set_trip_temp(tz, trip, temp);
> +
> +	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +
>   unlock:
>   	mutex_unlock(&tz->lock);
>   
> @@ -152,15 +160,33 @@ trip_point_hyst_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	if (hyst != trip->hysteresis) {
> -		thermal_zone_set_trip_hyst(tz, trip, hyst);
> +	if (hyst == trip->hysteresis)
> +		goto unlock;
> +
> +	/*
> +	 * Allow the hysteresis to be updated when the temperature is invalid
> +	 * to allow user space to avoid having to adjust hysteresis after a
> +	 * valid temperature has been set, but in that case just change the
> +	 * value and do nothing else.
> +	 */
> +	if (trip->temperature == THERMAL_TEMP_INVALID) {
> +		WRITE_ONCE(trip->hysteresis, hyst);
> +		goto unlock;
> +	}
>   
> -		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +	if (trip->temperature - hyst <= THERMAL_TEMP_INVALID) {
> +		ret = -EINVAL;
> +		goto unlock;
>   	}
>   
> +	thermal_zone_set_trip_hyst(tz, trip, hyst);
> +
> +	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +
> +unlock:
>   	mutex_unlock(&tz->lock);
>   
> -	return count;
> +	return ret ? ret : count;
>   }
>   
>   static ssize_t
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


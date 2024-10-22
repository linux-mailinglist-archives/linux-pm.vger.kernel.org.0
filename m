Return-Path: <linux-pm+bounces-16273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A169AB98C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 00:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5E01C21B18
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB431CC178;
	Tue, 22 Oct 2024 22:34:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50214A08E;
	Tue, 22 Oct 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636444; cv=none; b=claCqVVzRS2T3Y1KWodIYbNtQnBbRcEW6+d9ZC4UAr5N1ij0jI4RjVCFvN7Wn5YqsOKl6xtjR+VHVhOze+loKigjiwnJJVKtiDK7hGiMwpk4fR9UAdE2hiNqJPHZ4VjsEGqgOIoBb+wQqFZttRe6N9LZJoaGkoruP2AUzdWRUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636444; c=relaxed/simple;
	bh=3oE3lqFNk172Q6GEYBjnJ/UNf/ZeJZyAr/qQuZMwGXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS69r1Po2Ye6NzLlDBo8ToTA3Vz3t045tVWQVaJdB2KDec3qHz81ZETWqz+0avYB3dYCjHL1jLTcX6i4kXVIqvq0Aoyky0+gc1S30c9Va2l9rDE6q7oVJb+Th+VecSouWqOvUY+ZKLuM/kLcocHSNaI1nj08PYqgVedU/DDNXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2122497;
	Tue, 22 Oct 2024 15:34:31 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1413F528;
	Tue, 22 Oct 2024 15:34:00 -0700 (PDT)
Message-ID: <106f9c12-e598-4d09-993c-afcfad67b73f@arm.com>
Date: Tue, 22 Oct 2024 23:35:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] thermal: core: Manage thermal_governor_lock
 using a mutex guard
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <3679429.R56niFO833@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3679429.R56niFO833@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Switch over the thermal core to using a mutex guard for
> thermal_governor_lock management.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/863177860.0ifERbkFSE@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |   40 +++++++++++++---------------------------
>   1 file changed, 13 insertions(+), 27 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -124,7 +124,7 @@ int thermal_register_governor(struct the
>   	if (!governor)
>   		return -EINVAL;
>   
> -	mutex_lock(&thermal_governor_lock);
> +	guard(mutex)(&thermal_governor_lock);
>   
>   	err = -EBUSY;
>   	if (!__find_governor(governor->name)) {
> @@ -163,8 +163,6 @@ int thermal_register_governor(struct the
>   		}
>   	}
>   
> -	mutex_unlock(&thermal_governor_lock);
> -
>   	return err;
>   }
>   
> @@ -175,10 +173,10 @@ void thermal_unregister_governor(struct
>   	if (!governor)
>   		return;
>   
> -	mutex_lock(&thermal_governor_lock);
> +	guard(mutex)(&thermal_governor_lock);
>   
>   	if (!__find_governor(governor->name))
> -		goto exit;
> +		return;
>   
>   	list_del(&governor->governor_list);
>   
> @@ -189,9 +187,6 @@ void thermal_unregister_governor(struct
>   				 THERMAL_NAME_LENGTH))
>   			thermal_set_governor(pos, NULL);
>   	}
> -
> -exit:
> -	mutex_unlock(&thermal_governor_lock);
>   }
>   
>   int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
> @@ -200,16 +195,13 @@ int thermal_zone_device_set_policy(struc
>   	struct thermal_governor *gov;
>   	int ret = -EINVAL;
>   
> -	mutex_lock(&thermal_governor_lock);
> -
> +	guard(mutex)(&thermal_governor_lock);
>   	guard(thermal_zone)(tz);
>   
>   	gov = __find_governor(strim(policy));
>   	if (gov)
>   		ret = thermal_set_governor(tz, gov);
>   
> -	mutex_unlock(&thermal_governor_lock);
> -
>   	thermal_notify_tz_gov_change(tz, policy);
>   
>   	return ret;
> @@ -220,15 +212,13 @@ int thermal_build_list_of_policies(char
>   	struct thermal_governor *pos;
>   	ssize_t count = 0;
>   
> -	mutex_lock(&thermal_governor_lock);
> +	guard(mutex)(&thermal_governor_lock);
>   
>   	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
>   		count += sysfs_emit_at(buf, count, "%s ", pos->name);
>   	}
>   	count += sysfs_emit_at(buf, count, "\n");
>   
> -	mutex_unlock(&thermal_governor_lock);
> -
>   	return count;
>   }
>   
> @@ -668,17 +658,18 @@ int for_each_thermal_governor(int (*cb)(
>   			      void *data)
>   {
>   	struct thermal_governor *gov;
> -	int ret = 0;
>   
> -	mutex_lock(&thermal_governor_lock);
> +	guard(mutex)(&thermal_governor_lock);
> +
>   	list_for_each_entry(gov, &thermal_governor_list, governor_list) {
> +		int ret;
> +
>   		ret = cb(gov, data);
>   		if (ret)
> -			break;
> +			return ret;
>   	}
> -	mutex_unlock(&thermal_governor_lock);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
> @@ -1346,20 +1337,15 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
>   static int thermal_zone_init_governor(struct thermal_zone_device *tz)
>   {
>   	struct thermal_governor *governor;
> -	int ret;
>   
> -	mutex_lock(&thermal_governor_lock);
> +	guard(mutex)(&thermal_governor_lock);
>   
>   	if (tz->tzp)
>   		governor = __find_governor(tz->tzp->governor_name);
>   	else
>   		governor = def_governor;
>   
> -	ret = thermal_set_governor(tz, governor);
> -
> -	mutex_unlock(&thermal_governor_lock);
> -
> -	return ret;
> +	return thermal_set_governor(tz, governor);
>   }
>   
>   static void thermal_zone_init_complete(struct thermal_zone_device *tz)
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


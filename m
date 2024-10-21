Return-Path: <linux-pm+bounces-16151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F89A932B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D5F1F22C02
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8101E22F6;
	Mon, 21 Oct 2024 22:17:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68113C69E;
	Mon, 21 Oct 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549038; cv=none; b=XIxMVu4BekIkwX8zbqFtoRSgSoM3JZDROOQ+LypfFtF4WYSELujWPcC6KBS6wdgm9vm9BAQTZgcInHKO2mE5s+vufdX1afshWxNvUM7jq5GrPZVnt4LHk1unQeho2rRQALj2i6BBargpySQoB0uCm/Up+3CFBBH8CMyMtth94pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549038; c=relaxed/simple;
	bh=KWoL5iaMCRFuWKIL5C7HM1EAIHkYL4dDG72sXrOieZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omWlYRh8oFGJQzMPxGT4CjdoqeodALrbDIcWGEOtZbXVg63AcMfWsbFF1ZjMQu8eYkn+1WFGMoH/Ob4JRdFNZ2ui54D1/X2k4vC86uoKObNXkJDmPh7/ewwZ5+d+saRjY79EUDLW92xVJllGRoRSFAwhtjGcuMNdvwLDHv+HAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB02C497;
	Mon, 21 Oct 2024 15:17:45 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0E23F71E;
	Mon, 21 Oct 2024 15:17:14 -0700 (PDT)
Message-ID: <24c31077-8970-4fcd-bcaa-60d1a3da8f27@arm.com>
Date: Mon, 21 Oct 2024 23:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] thermal: core: Rearrange PM notification code
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <2299090.iZASKD2KPV@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2299090.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 20:09, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the code run for each thermal zone by the thermal PM notify
> handler to separate functions.
> 
> This will help to make some subsequent changes look somewhat more
> straightforward, among other things.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/4940614.GXAFRqVoOG@rjwysocki.net/
> 
> v1 -> v2: The thermal zone guard has not been defined yet, so use lock/unlock
>            directly on the thermal zone lock and update the changelog accordingly.
> 
> ---
>   drivers/thermal/thermal_core.c |   88 +++++++++++++++++++++--------------------
>   1 file changed, 46 insertions(+), 42 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1675,6 +1675,48 @@ static void thermal_zone_device_resume(s
>   	mutex_unlock(&tz->lock);
>   }
>   
> +static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
> +{
> +	mutex_lock(&tz->lock);
> +
> +	if (tz->resuming) {
> +		/*
> +		 * thermal_zone_device_resume() queued up for this zone has not
> +		 * acquired the lock yet, so release it to let the function run
> +		 * and wait util it has done the work.
> +		 */
> +		mutex_unlock(&tz->lock);
> +
> +		wait_for_completion(&tz->resume);
> +
> +		mutex_lock(&tz->lock);
> +	}
> +
> +	tz->suspended = true;
> +
> +	mutex_unlock(&tz->lock);
> +}
> +
> +static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
> +{
> +	mutex_lock(&tz->lock);
> +
> +	cancel_delayed_work(&tz->poll_queue);
> +
> +	reinit_completion(&tz->resume);
> +	tz->resuming = true;
> +
> +	/*
> +	 * Replace the work function with the resume one, which will restore the
> +	 * original work function and schedule the polling work if needed.
> +	 */
> +	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
> +	/* Queue up the work without a delay. */
> +	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
> +
> +	mutex_unlock(&tz->lock);
> +}
> +
>   static int thermal_pm_notify(struct notifier_block *nb,
>   			     unsigned long mode, void *_unused)
>   {
> @@ -1686,27 +1728,8 @@ static int thermal_pm_notify(struct noti
>   	case PM_SUSPEND_PREPARE:
>   		mutex_lock(&thermal_list_lock);
>   
> -		list_for_each_entry(tz, &thermal_tz_list, node) {
> -			mutex_lock(&tz->lock);
> -
> -			if (tz->resuming) {
> -				/*
> -				 * thermal_zone_device_resume() queued up for
> -				 * this zone has not acquired the lock yet, so
> -				 * release it to let the function run and wait
> -				 * util it has done the work.
> -				 */
> -				mutex_unlock(&tz->lock);
> -
> -				wait_for_completion(&tz->resume);
> -
> -				mutex_lock(&tz->lock);
> -			}
> -
> -			tz->suspended = true;
> -
> -			mutex_unlock(&tz->lock);
> -		}
> +		list_for_each_entry(tz, &thermal_tz_list, node)
> +			thermal_zone_pm_prepare(tz);
>   
>   		mutex_unlock(&thermal_list_lock);
>   		break;
> @@ -1715,27 +1738,8 @@ static int thermal_pm_notify(struct noti
>   	case PM_POST_SUSPEND:
>   		mutex_lock(&thermal_list_lock);
>   
> -		list_for_each_entry(tz, &thermal_tz_list, node) {
> -			mutex_lock(&tz->lock);
> -
> -			cancel_delayed_work(&tz->poll_queue);
> -
> -			reinit_completion(&tz->resume);
> -			tz->resuming = true;
> -
> -			/*
> -			 * Replace the work function with the resume one, which
> -			 * will restore the original work function and schedule
> -			 * the polling work if needed.
> -			 */
> -			INIT_DELAYED_WORK(&tz->poll_queue,
> -					  thermal_zone_device_resume);
> -			/* Queue up the work without a delay. */
> -			mod_delayed_work(system_freezable_power_efficient_wq,
> -					 &tz->poll_queue, 0);
> -
> -			mutex_unlock(&tz->lock);
> -		}
> +		list_for_each_entry(tz, &thermal_tz_list, node)
> +			thermal_zone_pm_complete(tz);
>   
>   		mutex_unlock(&thermal_list_lock);
>   		break;
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


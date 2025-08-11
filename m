Return-Path: <linux-pm+bounces-32169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F90B210E0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0306C7B4C60
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF52E3AFC;
	Mon, 11 Aug 2025 15:50:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45422E3398;
	Mon, 11 Aug 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927458; cv=none; b=ikJ74WOIchXXDHn1d/eXt1SUllRU+h6OEULz8lp+71YVdJtsHLo0OuFvaBbsE8BY58ROym+GkElbMoCQBhAjEDpOE/VnocW4kkda94K9Ah+G8kgErVPa2/DPD2RcTHzd7t4kKb8fHoHhysoWdYlPfE75qUbJvI0O1QXdey/ZQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927458; c=relaxed/simple;
	bh=zgknpN5cHZEkRFLN1q1uMwFVeipMxzqdFTEiz6TtKVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+fLrtqV3rzbfuIM2NVTUIXACHSKhBXdAaZzng1XZ7oFJ9u3tbGptzzyHYvwbvykCnFnC/vjv73tV62fqkvQksAoM28BbYIrh0G6WcSMLmW2Zo4QQ+4P/YDcrf7WKDg38KH0C0YCjFV2jm/zxk8ev3YMYg2P7y99Ir21Zu2Mtis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8572661;
	Mon, 11 Aug 2025 08:50:47 -0700 (PDT)
Received: from [10.1.26.70] (e127648.arm.com [10.1.26.70])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71BFB3F63F;
	Mon, 11 Aug 2025 08:50:54 -0700 (PDT)
Message-ID: <5a2c4b1c-e3ef-4d1d-ae93-ff744fdd7bf6@arm.com>
Date: Mon, 11 Aug 2025 16:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: menu: Avoid using invalid recent
 intervals data
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <2793874.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2793874.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 16:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Marc has reported that commit 85975daeaa4d ("cpuidle: menu: Avoid
> discarding useful information") caused the number of wakeup interrupts
> to increase on an idle system [1], which was not expected to happen
> after merely allowing shallower idle states to be selected by the
> governor in some cases.
> 
> However, on the system in question, all of the idle states deeper than
> WFI are rejected by the driver due to a firmware issue [2].  This causes
> the governor to only consider the recent interval duriation data
duration

> corresponding to attempts to enter WFI that are successful and the
> recent invervals table is filled with values lower than the scheduler
intervals

> tick period.  Consequently, the governor predicts an idle duration
> below the scheduler tick period length and avoids stopping the tick
> more often which leads to the observed symptom.
> 
> Address it by modifying the governor to update the recent intervals
> table also when entering the previously selected idle state fails, so
> it knows that the short idle intervals might have been the minority
> had the selected idle states been actually entered every time.
> 
> Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
> Link: https://lore.kernel.org/linux-pm/86o6sv6n94.wl-maz@kernel.org/ [1]
> Link: https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/ [2]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Tested-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/menu.c |   21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -97,6 +97,14 @@
>  
>  static DEFINE_PER_CPU(struct menu_device, menu_devices);
>  
> +static void menu_update_intervals(struct menu_device *data, unsigned int interval_us)
> +{
> +	/* Update the repeating-pattern data. */
> +	data->intervals[data->interval_ptr++] = interval_us;
> +	if (data->interval_ptr >= INTERVALS)
> +		data->interval_ptr = 0;
> +}
> +
>  static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
>  
>  /*
> @@ -222,6 +230,14 @@
>  	if (data->needs_update) {
>  		menu_update(drv, dev);
>  		data->needs_update = 0;
> +	} else if (!dev->last_residency_ns) {
> +		/*
> +		 * This happens when the driver rejects the previously selected
> +		 * idle state and returns an error, so update the recent
> +		 * intervals table to prevent invalid information from being
> +		 * used going forward.
> +		 */
> +		menu_update_intervals(data, UINT_MAX);
>  	}
>  
>  	/* Find the shortest expected idle interval. */
> @@ -482,10 +498,7 @@
>  
>  	data->correction_factor[data->bucket] = new_factor;
>  
> -	/* update the repeating-pattern data */
> -	data->intervals[data->interval_ptr++] = ktime_to_us(measured_ns);
> -	if (data->interval_ptr >= INTERVALS)
> -		data->interval_ptr = 0;
> +	menu_update_intervals(data, ktime_to_us(measured_ns));
>  }
>  
>  /**
> 
> 
> 



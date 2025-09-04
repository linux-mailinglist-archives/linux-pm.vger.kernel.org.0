Return-Path: <linux-pm+bounces-33801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103EBB43405
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CC33A6892
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165D29BDA6;
	Thu,  4 Sep 2025 07:32:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27A81ADC97;
	Thu,  4 Sep 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971166; cv=none; b=Wtmg/VGYyn7RrJb2MgImD8RkzeOc/heNfGVf3yPVkFRVDO/KgvGKKpTRQpFTHwv9KmoQUoY9bKo7H778bYlHY9Vn7O9qpci7j8OauR16DTQFBu3j8wU2H0vsxuQJJ8Y1WPM/mbhsuacAK9A7AlSPZyLfJcq2H7RXhyyLoU5UrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971166; c=relaxed/simple;
	bh=X3DG0/q+PGwPmbanpYPvuo1axhORVRIQzi82AV0N6z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVfS8tuWRoHYvqWnXngG3bvzPVxojjEjTmTueXAoHddcoMJpBEN3+/l2b464uFvzZTa4OpKVBE/oJUQYegu3hYAvhrIR0uDiQ0euLCIN/HdqoYw67wrf6IlasCr+5qgt/KgGoQEfF7P+6PaYSPi0Q5/vzB5q74CqGzpYbFFZD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979F41596;
	Thu,  4 Sep 2025 00:32:35 -0700 (PDT)
Received: from [10.57.60.120] (unknown [10.57.60.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B03F3F694;
	Thu,  4 Sep 2025 00:32:43 -0700 (PDT)
Message-ID: <57c54d50-9948-42be-985a-195b2027733a@arm.com>
Date: Thu, 4 Sep 2025 08:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] thermal: gov_step_wise: Allow cooling level to be
 reduced earlier
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <12745610.O9o76ZdvQC@rafael.j.wysocki>
 <1947735.tdWV9SEqCh@rafael.j.wysocki>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1947735.tdWV9SEqCh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/25 14:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current behavior of the Step-wise thermal governor is to increase
> the cooling level one step at a time after trip point threshold passing
> by thermal zone temperature until the temperature stops to rise and then
> do nothing until it falls down below the (possibly new) trip point
> threshold, at which point the cooling level is reduced straight to the
> applicable minimum.

Quite long single sentence to describe these stuff...

> 
> While this generally works, it is not in agreement with the throttling
> logic description comment in step_wise_manage() any more after some
> relatively recent changes, and in the case of passive cooling, it may
> lead to undesirable performance oscillations between high and low
> levels.
> 
> For this reason, modify the governor's cooling device state selection
> function, get_target_state(), to reduce cooling by one level even if
> the temperature is still above the thermal zone threshold, but the
> temperature has started to fall down.  However, ensure that the cooling
> level will remain above the applicable minimum in that case to pull
> the zone temperature further down, possibly until it falls below the
> trip threshold (which may now be equal to the low temperature of the
> trip).
> 
> Doing so should help higher performance to be restored earlier in some
> cases which is desirable especially for passive trip points with
> relatively high hysteresis values.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |   15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -20,7 +20,9 @@
>    * If the temperature is higher than a trip point,
>    *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
>    *       state for this trip point
> - *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
> + *    b. if the trend is THERMAL_TREND_DROPPING, use a lower cooling state
> + *       for this trip point, but keep the cooling state above the applicable
> + *       minimum
>    * If the temperature is lower than a trip point,
>    *    a. if the trend is THERMAL_TREND_RAISING, do nothing
>    *    b. if the trend is THERMAL_TREND_DROPPING, use the minimum applicable
> @@ -51,6 +53,17 @@
>   	if (throttle) {
>   		if (trend == THERMAL_TREND_RAISING)
>   			return clamp(cur_state + 1, instance->lower, instance->upper);
> +
> +		/*
> +		 * If the zone temperature is falling, the cooling level can
> +		 * be reduced, but it should still be above the lower state of
> +		 * the given thermal instance to pull the temperature further
> +		 * down.
> +		 */
> +		if (trend == THERMAL_TREND_DROPPING)
> +			return clamp(cur_state - 1,
> +				     min(instance->lower + 1, instance->upper),
> +				     instance->upper);
>   	} else if (trend == THERMAL_TREND_DROPPING) {
>   		if (cur_state <= instance->lower)
>   			return THERMAL_NO_TARGET;
> 
> 
> 

That make sense

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


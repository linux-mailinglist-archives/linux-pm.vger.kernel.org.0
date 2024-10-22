Return-Path: <linux-pm+bounces-16263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2569AB824
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 23:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46157B22D5C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC41C9EB3;
	Tue, 22 Oct 2024 21:02:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD113AD2A;
	Tue, 22 Oct 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630943; cv=none; b=aPOcumWebwAku1FvDmekW0u1QE5ODnbiXQXkOvPD/1ffFvhUiwMX6A+CaMsRcm1kHIDGG0VKVZizMb3q+j37/4dkr/MfO1XkuNuTKSApfUb2E+aCpvclaRGqG7Rk1yaynSM49ul2KGe1+0EAoIRkeCMX4mRtD7hMgeNJa831scA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630943; c=relaxed/simple;
	bh=PYbhW4klSjsJCjKaviplm9S2MfxW9Vf7YU0RXJuoGgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhtpHaMvt2jpAq4OD7cTrOddd7jgmh0GMdLFdOU0jeA4iCVC61rIizPTHWjVU/0uSuV9aHUISu8bHULtXMXqeUY3PKR5MntbxjY7mga0nXoMV+lMAWctLMT68m53eire2WVGXlWzOALwkfZSzMT5Q2uu/TjcIqoIXrWYgUetbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1310497;
	Tue, 22 Oct 2024 14:02:49 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53A53F71E;
	Tue, 22 Oct 2024 14:02:18 -0700 (PDT)
Message-ID: <2b841fb2-49b8-480f-896b-0b5a3cc6a1e2@arm.com>
Date: Tue, 22 Oct 2024 22:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] thermal: core: Add and use a reverse thermal
 zone guard
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <3344086.aeNJFYEL58@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3344086.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a guard for unlocking a locked thermal zone temporarily and use it
> in thermal_zone_pm_prepare().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new patch
> 
> ---
>   drivers/thermal/thermal_core.c |    8 +++-----
>   drivers/thermal/thermal_core.h |    3 +++
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1702,11 +1702,9 @@ static void thermal_zone_pm_prepare(stru
>   		 * acquired the lock yet, so release it to let the function run
>   		 * and wait util it has done the work.
>   		 */
> -		mutex_unlock(&tz->lock);
> -
> -		wait_for_completion(&tz->resume);
> -
> -		mutex_lock(&tz->lock);
> +		scoped_guard(thermal_zone_reverse, tz) {
> +			wait_for_completion(&tz->resume);
> +		}
>   	}
>   
>   	tz->state |= TZ_STATE_FLAG_SUSPENDED;
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -148,6 +148,9 @@ struct thermal_zone_device {
>   DEFINE_GUARD(thermal_zone, struct thermal_zone_device *, mutex_lock(&_T->lock),
>   	     mutex_unlock(&_T->lock))
>   
> +DEFINE_GUARD(thermal_zone_reverse, struct thermal_zone_device *,
> +	     mutex_unlock(&_T->lock), mutex_lock(&_T->lock))
> +
>   /* Initial thermal zone temperature. */
>   #define THERMAL_TEMP_INIT	INT_MIN
>   
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


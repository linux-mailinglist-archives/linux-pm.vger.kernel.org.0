Return-Path: <linux-pm+bounces-12183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBAB950E52
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 23:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA3A1C20DA7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0081A7056;
	Tue, 13 Aug 2024 21:06:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7E01A38C7
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583177; cv=none; b=kw6PCW8012QnHGQDcN10L8yiaD02vBQAKcX+c3hHo0S7uqZFNlZQOU2J45KN1iV+oGhkB1PdvmpKUuqWevLe+mw3fvbfrNoNw8WUfHHTo2EgwEhMS9ZP3BpROmXOla9Aax3GSvRaNqZyUtuaOS1x3QQCydbn8HIzKBVUe+LKa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583177; c=relaxed/simple;
	bh=Wd5YfiWEOiIIel6Doj4b708C6hA1X6p6W4IqzGEA+/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JowH3C8ci8Ht5Wemcj41P1YmflVS+/ta0jZJ6KbwVADeGX0Ts+x5B4HcLOwVYty+3UVhqFvznF6bnw77NcMH9InbbMbOO803K8Bp5coVY/64G+9rEo6ddth2zvDesXPNggXtSI+OmkWkRoN5f05Pjiisk8ikVa+9Kmma+Y7lL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id dygCsGYGyeSaBdygEs10ce; Tue, 13 Aug 2024 14:03:47 -0700
X-CMAE-Analysis: v=2.4 cv=GJnDEfNK c=1 sm=1 tr=0 ts=66bbca34
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=QyXUC8HyAAAA:8 a=t3YNmgBSAAAA:8
 a=d6xro1zaz7yaFmt7QvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <561441f1-3e96-4979-bc55-6296179760ed@piie.net>
Date: Tue, 13 Aug 2024 23:03:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] thermal: gov_bang_bang: Split bang_bang_control()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
 <3313587.aeNJFYEL58@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <3313587.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGHxP0RZahDoEfyd9EhqJZpQ+/1eKR0k6f+Ly/DPWjznZbkD1xF4/lV6eQUyHgqI+YBmeJH71N1EXcDkvqq+8BLeJEUfy4z5b6sye11M95NwrMxtaouP
 VnHay9kcDuiQ99Agtd36GLMI29XYHMjPkNktCmVZ7Uqk1j8KTnqitQT1RXrr81ptnyb01K64/nv8WkbJJnJCj3FOf+QBJ7hgZU4dNP9NAX/4tVqR/aOfjuu8
 EDMZ+qEup9ugEVeeUYXBKraJdpogTZasOdUgteniumH7VFOUVwlHp2uJNJnkgUXUop8uWRrv0K6i9YUiWSnxEFHZ3T1Rm/jaRqO5CqmLQTQklT+bSokKG4OQ
 wY5+2nzgXyUNu3TDUPHbc8jaNNVmQA==

On 13.08.24 16:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the setting of the thermal instance target state from
> bang_bang_control() into a separate function that will be also called
> in a different place going forward.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peter Kästle <peter@piie.net>

> ---
>   drivers/thermal/gov_bang_bang.c |   42 +++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -13,6 +13,27 @@
>   
>   #include "thermal_core.h"
>   
> +static void bang_bang_set_instance_target(struct thermal_instance *instance,
> +					  unsigned int target)
> +{
> +	if (instance->target != 0 && instance->target != 1 &&
> +	    instance->target != THERMAL_NO_TARGET)
> +		pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
> +			 instance->target, instance->name);
> +
> +	/*
> +	 * Enable the fan when the trip is crossed on the way up and disable it
> +	 * when the trip is crossed on the way down.
> +	 */
> +	instance->target = target;
> +
> +	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
> +
> +	mutex_lock(&instance->cdev->lock);
> +	__thermal_cdev_update(instance->cdev);
> +	mutex_unlock(&instance->cdev->lock);
> +}
> +
>   /**
>    * bang_bang_control - controls devices associated with the given zone
>    * @tz: thermal_zone_device
> @@ -54,25 +75,8 @@ static void bang_bang_control(struct the
>   		tz->temperature, trip->hysteresis);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (instance->trip != trip)
> -			continue;
> -
> -		if (instance->target != 0 && instance->target != 1 &&
> -		    instance->target != THERMAL_NO_TARGET)
> -			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
> -				 instance->target, instance->name);
> -
> -		/*
> -		 * Enable the fan when the trip is crossed on the way up and
> -		 * disable it when the trip is crossed on the way down.
> -		 */
> -		instance->target = crossed_up;
> -
> -		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
> -
> -		mutex_lock(&instance->cdev->lock);
> -		__thermal_cdev_update(instance->cdev);
> -		mutex_unlock(&instance->cdev->lock);
> +		if (instance->trip == trip)
> +			bang_bang_set_instance_target(instance, crossed_up);
>   	}
>   }
>   
> 
> 
> 


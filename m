Return-Path: <linux-pm+bounces-16268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E159AB900
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 23:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236F4284A96
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD71CDA31;
	Tue, 22 Oct 2024 21:47:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D91CC17D;
	Tue, 22 Oct 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633637; cv=none; b=QehjbO5/b4SMcNrH+dzltQxW1jsCupE4aOXC/5batgFVrD2fi0qQ1FBQhgvgtlLt6gZ18wbgXE1QVlMSrEeycrDE4l+ucThph+vLBG5GQNERJVCE3MzbPWtamlx7RtDrCRIufB+GzCgPTYpmLUQgpjmZCZat6CNtZOrewDSnbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633637; c=relaxed/simple;
	bh=cRvRYJc/6c0akFGJFIRKhOuJQrbFgybnciS6j3ZUjeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5i09tqiLLFDDhpZdMInzo53R7hdVtzI2Y1eJp0tKf4p5nr0c3+9VjkGwkwi6qwrONcsDQA9r1F5mtWY8tOzDt3h26Q78O+Ca1I+IU2MeC3IRAQ1BEV934UbKyjyJXHKokJbHG5D7vP8JC8RDk8V9scD8W2J5NrICcGzI7vwNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4280D497;
	Tue, 22 Oct 2024 14:47:44 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427DC3F528;
	Tue, 22 Oct 2024 14:47:13 -0700 (PDT)
Message-ID: <8594c611-4eac-45b1-9ab1-bd54c9642bf1@arm.com>
Date: Tue, 22 Oct 2024 22:48:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] thermal: core: Introduce
 thermal_instance_delete()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <3275745.5fSG56mABF@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3275745.5fSG56mABF@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 23:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not necessary to walk the thermal_instances list in a trip
> descriptor under a cooling device lock, so acquire that lock only
> for deleting the given thermal instance from the list of thermal
> instances in the given cdev.
> 
> Moreover, in analogy with the previous change that introduced
> thermal_instance_add(), put the code deleting the given thermal
> instance from the lists it is on into a separate new function
> called thermal_instance_delete().

make sense

> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/2224279.Mh6RI2rZIc@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |   17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -866,6 +866,17 @@ free_mem:
>   	return result;
>   }
>   
> +static void thermal_instance_delete(struct thermal_instance *instance)
> +{
> +	list_del(&instance->trip_node);
> +
> +	mutex_lock(&instance->cdev->lock);
> +
> +	list_del(&instance->cdev_node);
> +
> +	mutex_unlock(&instance->cdev->lock);
> +}
> +
>   /**
>    * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
>    * @tz:		pointer to a struct thermal_zone_device.
> @@ -882,16 +893,12 @@ static void thermal_unbind_cdev_from_tri
>   {
>   	struct thermal_instance *pos, *next;
>   
> -	mutex_lock(&cdev->lock);
>   	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
>   		if (pos->cdev == cdev) {
> -			list_del(&pos->trip_node);
> -			list_del(&pos->cdev_node);
> -			mutex_unlock(&cdev->lock);
> +			thermal_instance_delete(pos);
>   			goto unbind;
>   		}
>   	}
> -	mutex_unlock(&cdev->lock);
>   
>   	return;
>   
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


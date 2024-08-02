Return-Path: <linux-pm+bounces-11823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E6945B16
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3B91F21F50
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED51D1F54;
	Fri,  2 Aug 2024 09:35:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54671BF311;
	Fri,  2 Aug 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591310; cv=none; b=TgO0KJcl21Y4zfj/bKOlVqX6iE5WlvZ38oZPnL4LEAkztDeS24DgxcRkg/PVftH3t3iJAH1bD5Y43y3X9udBBKyVgFgMYETl/FMli05nb64mEa39Skjf2CGWggJeiObE1YkZi0R/6cqaXucJIXkYDfafuFscQDcIC5IJ3vcsGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591310; c=relaxed/simple;
	bh=lHqKn9/BieaOQLZIucVHv//ncilRWUHg2PVO0Tt3dYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9fxDQVMttGBZ/kQ3EE87OJ+jcmL6u52BFfNFOIatfTBZFn3eNCC49O/JwoGoWZOAAqBUSANCJhpL0tumuRFqPG0URvXv/fTyNIg0ZfhBTtynmiGw07ijXofIeepqBTI+gFfWpRFJWIIlwq3yMUqYCCKS2QgIVbiM+vq4CpI3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D818D1007;
	Fri,  2 Aug 2024 02:35:33 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749133F766;
	Fri,  2 Aug 2024 02:35:07 -0700 (PDT)
Message-ID: <1c276f68-3568-483c-8f75-88261b180b8d@arm.com>
Date: Fri, 2 Aug 2024 10:35:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 2/8] thermal: hisi: Use
 thermal_zone_for_each_trip() in hisi_thermal_register_sensor()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <2211925.irdbgypaU6@rjwysocki.net>
 <1994088.PYKUYFuaPT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1994088.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 16:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify hisi_thermal_register_sensor() to use thermal_zone_for_each_trip()
> for walking trip points instead of iterating over trip indices and using
> thermal_zone_get_trip() to get a struct thermal_trip pointer from a trip
> index.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch does not depend on the previous patch(es) in the series.
> 
> ---
>   drivers/thermal/hisi_thermal.c |   22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/drivers/thermal/hisi_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/hisi_thermal.c
> +++ linux-pm/drivers/thermal/hisi_thermal.c
> @@ -465,6 +465,18 @@ static irqreturn_t hisi_thermal_alarm_ir
>   	return IRQ_HANDLED;
>   }
>   
> +static int hisi_trip_walk_cb(struct thermal_trip *trip, void *arg)
> +{
> +	struct hisi_thermal_sensor *sensor = arg;
> +
> +	if (trip->type != THERMAL_TRIP_PASSIVE)
> +		return 0;
> +
> +	sensor->thres_temp = trip->temperature;
> +	/* Return nonzero to terminate the search. */
> +	return 1;
> +}
> +
>   static int hisi_thermal_register_sensor(struct platform_device *pdev,
>   					struct hisi_thermal_sensor *sensor)
>   {
> @@ -482,15 +494,7 @@ static int hisi_thermal_register_sensor(
>   		return ret;
>   	}
>   
> -	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
> -
> -		thermal_zone_get_trip(sensor->tzd, i, &trip);
> -
> -		if (trip.type == THERMAL_TRIP_PASSIVE) {
> -			sensor->thres_temp = trip.temperature;
> -			break;
> -		}
> -	}
> +	thermal_zone_for_each_trip(sensor->tzd, hisi_trip_walk_cb, sensor);
>   
>   	return 0;
>   }
> 
> 
> 



Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


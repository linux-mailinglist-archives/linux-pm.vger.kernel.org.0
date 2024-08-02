Return-Path: <linux-pm+bounces-11824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7911945B1D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94841C23685
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36771DAC71;
	Fri,  2 Aug 2024 09:35:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139031DAC4A;
	Fri,  2 Aug 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591353; cv=none; b=LIiFdT0EWUqIYi+4LWXynymIamUe+eNbmFAtHiEi9QGAoaYZHTtY1k/5s7ioKlOnKfCJ/CNWc2MyNugy5rcRXgYnDZPn4ooaj+ennaCdukeqhQdAa+Xho4Y8te7dO6BfKXHm9Qi/OhkfrF/l87kksiXLZFyw6Zw0264ykq8rQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591353; c=relaxed/simple;
	bh=dk3AkEexnpfCj7aRF0eLLUhA3VvcUM8ph8xsoYphiw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBV5MW0gqooSYpqYDWadGiaXtciceAT7/0+xjOwsrBfma6EcUo88hbkjuP9bzg7inJh+EnWCt4MHt6JE+rl6OYxK/htlitSMHo3FDpxs/uaVR6JyARuHP90ceOFKb/JRhOyP7vVwHN3b7JM7HeG1joUAUU3h7lAt49OlDoBjv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E741007;
	Fri,  2 Aug 2024 02:36:17 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52EF3F766;
	Fri,  2 Aug 2024 02:35:49 -0700 (PDT)
Message-ID: <078ce0ba-63d4-4d04-9ac0-2344ca176fe5@arm.com>
Date: Fri, 2 Aug 2024 10:36:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 1/8] thermal: broadcom: Use
 thermal_zone_get_crit_temp() in bcm2835_thermal_probe()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <2211925.irdbgypaU6@rjwysocki.net>
 <3322893.aeNJFYEL58@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3322893.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 16:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the bcm2835 thermal driver to use thermal_zone_get_crit_temp() in
> bcm2835_thermal_probe() instead of relying on the assumption that the
> critical trip index will always be 0.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/broadcom/bcm2835_thermal.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/broadcom/bcm2835_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ linux-pm/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -208,8 +208,7 @@ static int bcm2835_thermal_probe(struct
>   	 */
>   	val = readl(data->regs + BCM2835_TS_TSENSCTL);
>   	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
> -		struct thermal_trip trip;
> -		int offset, slope;
> +		int offset, slope, crit_temp;
>   
>   		slope = thermal_zone_get_slope(tz);
>   		offset = thermal_zone_get_offset(tz);
> @@ -217,7 +216,7 @@ static int bcm2835_thermal_probe(struct
>   		 * For now we deal only with critical, otherwise
>   		 * would need to iterate
>   		 */
> -		err = thermal_zone_get_trip(tz, 0, &trip);
> +		err = thermal_zone_get_crit_temp(tz, &crit_temp);
>   		if (err < 0) {
>   			dev_err(dev, "Not able to read trip_temp: %d\n", err);
>   			return err;
> @@ -232,7 +231,7 @@ static int bcm2835_thermal_probe(struct
>   		val |= (0xFE << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
>   
>   		/*  trip_adc value from info */
> -		val |= bcm2835_thermal_temp2adc(trip.temperature,
> +		val |= bcm2835_thermal_temp2adc(crit_temp,
>   						offset,
>   						slope)
>   			<< BCM2835_TS_TSENSCTL_THOLD_SHIFT;
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


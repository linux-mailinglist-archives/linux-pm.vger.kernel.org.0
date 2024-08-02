Return-Path: <linux-pm+bounces-11825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BDF945B21
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454762811F9
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005791C2312;
	Fri,  2 Aug 2024 09:36:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B591BF304;
	Fri,  2 Aug 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591394; cv=none; b=Jlac7MzpvAu9GqYcJFsbUuZKqBCzWPbSt+BX9e2Tpf/TEzxwNzanAxPaRRUOPTfvV0dnMBSa7U0qs1bZudMThzNfb3khvXoLOD4lXWma2D9Nz1JonuCahrFPbFViZyixv1ZS9R1o34qtbxmMxj6sG8WA2u8+gncCkUoFLQGCzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591394; c=relaxed/simple;
	bh=YoRXAyN8OiZWlodCaunm3r8RPE7btncyojDN5PbcFps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGEWjzQgC0tL7/z1lHfleC2ZAgmVPQcD2CCjYwvmvUTwHrmouRez6bsPGykQ/UwcJxdfRfzUi3hQEXasHdALWWtR92f50wUg34m7dz2mD9jzko0V7DK7ucPwORg1ALj8IIu4j7scA4Tk6Vrd2274BE8qZAsIPQsTnD67581l7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A3CA1007;
	Fri,  2 Aug 2024 02:36:58 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57D863F766;
	Fri,  2 Aug 2024 02:36:31 -0700 (PDT)
Message-ID: <ec9bc4c6-914c-4f84-8992-9604620a104b@arm.com>
Date: Fri, 2 Aug 2024 10:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 3/8] thermal: qcom: Use
 thermal_zone_get_crit_temp() in qpnp_tm_init()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org
References: <2211925.irdbgypaU6@rjwysocki.net>
 <7712228.EvYhyI6sBW@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7712228.EvYhyI6sBW@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 16:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify qpnp_tm_init() to use thermal_zone_get_crit_temp() to get the
> critical trip temperature instead of iterating over trip indices and
> using thermal_zone_get_trip() to get a struct thermal_trip pointer
> from a trip index until it finds the critical one.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch does not depend on the previous patch(es) in the series.
> 
> ---
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c |   22 +++-------------------
>   1 file changed, 3 insertions(+), 19 deletions(-)
> 
> Index: linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -291,24 +291,6 @@ static irqreturn_t qpnp_tm_isr(int irq,
>   	return IRQ_HANDLED;
>   }
>   
> -static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
> -{
> -	struct thermal_trip trip;
> -	int i, ret;
> -
> -	for (i = 0; i < thermal_zone_get_num_trips(chip->tz_dev); i++) {
> -
> -		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
> -		if (ret)
> -			continue;
> -
> -		if (trip.type == THERMAL_TRIP_CRITICAL)
> -			return trip.temperature;
> -	}
> -
> -	return THERMAL_TEMP_INVALID;
> -}
> -
>   /*
>    * This function initializes the internal temp value based on only the
>    * current thermal stage and threshold. Setup threshold control and
> @@ -343,7 +325,9 @@ static int qpnp_tm_init(struct qpnp_tm_c
>   
>   	mutex_unlock(&chip->lock);
>   
> -	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
> +	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> +	if (ret)
> +		crit_temp = THERMAL_TEMP_INVALID;
>   
>   	mutex_lock(&chip->lock);
>   
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


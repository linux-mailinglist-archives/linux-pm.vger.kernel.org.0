Return-Path: <linux-pm+bounces-11826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DB945B34
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE111F24E26
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E01DB438;
	Fri,  2 Aug 2024 09:40:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19B1BE87A;
	Fri,  2 Aug 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591621; cv=none; b=UJUG8qXH1sW7farpLJWUjLEO5m6M7Q+RE5wtGuMb5QeBoytwvza9dqCGiIkcy2cF6iupxf2wFuoflRzkGlBcTV3QWNdgQM/TO0wW7AV5tBzNE++lYf2iaOYpLUVJ/iN5xvO4LFmsgPibxRSwYh89Y3k7ca/5GA87hCNmkcOHL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591621; c=relaxed/simple;
	bh=pvF5sWZy7EqMyoymOgEIrh3uKuMiQWpQ4pZjx37a2Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPBLBxGNuRJtcWsoz1SLhW+v02eIjdH5xQhcsawCdMnmFnGS60foLWAO9OEj8d8ARtUibyWJgjWm+vwKEOx0hPzVdPJcHqMlm3AViVaqUJWoLhYYCkAkAcZUdeCQllsDaOUVhXDkQL8EgD4AgX9DWWbdCwflj9dukpNjHWVgWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA711007;
	Fri,  2 Aug 2024 02:40:44 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC23D3F766;
	Fri,  2 Aug 2024 02:40:17 -0700 (PDT)
Message-ID: <96748e6f-544e-4f13-9721-f1eea91dd639@arm.com>
Date: Fri, 2 Aug 2024 10:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 4/8] thermal: tegra: Introduce struct
 trip_temps for critical and hot trips
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
References: <2211925.irdbgypaU6@rjwysocki.net>
 <9333090.CDJkKcVGEf@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9333090.CDJkKcVGEf@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 17:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a helper structure, struct trip_temps, for storing the
> temperatures of the critical and hot trip points.
> 
> This helps to make the code in tegra_tsensor_get_hw_channel_trips()
> somewhat cleaner and will be useful subsequently in eliminating
> iteration over trip indices from the driver.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch does not depend on the previous patch(es) in the series.
> 
> ---
>   drivers/thermal/tegra/tegra30-tsensor.c |   34 ++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/tegra/tegra30-tsensor.c
> +++ linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -303,8 +303,13 @@ stop_channel:
>   	return 0;
>   }
>   
> +struct trip_temps {
> +	int hot_trip;
> +	int crit_trip;
> +};
> +
>   static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
> -					       int *hot_trip, int *crit_trip)
> +					       struct trip_temps *temps)
>   {
>   	unsigned int i;
>   
> @@ -312,8 +317,8 @@ static void tegra_tsensor_get_hw_channel
>   	 * 90C is the maximal critical temperature of all Tegra30 SoC variants,
>   	 * use it for the default trip if unspecified in a device-tree.
>   	 */
> -	*hot_trip  = 85000;
> -	*crit_trip = 90000;
> +	temps->hot_trip  = 85000;
> +	temps->crit_trip = 90000;
>   
>   	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
>   
> @@ -322,14 +327,14 @@ static void tegra_tsensor_get_hw_channel
>   		thermal_zone_get_trip(tzd, i, &trip);
>   
>   		if (trip.type == THERMAL_TRIP_HOT)
> -			*hot_trip = trip.temperature;
> +			temps->hot_trip = trip.temperature;
>   
>   		if (trip.type == THERMAL_TRIP_CRITICAL)
> -			*crit_trip = trip.temperature;
> +			temps->crit_trip = trip.temperature;
>   	}
>   
>   	/* clamp hardware trips to the calibration limits */
> -	*hot_trip = clamp(*hot_trip, 25000, 90000);
> +	temps->hot_trip = clamp(temps->hot_trip, 25000, 90000);
>   
>   	/*
>   	 * Kernel will perform a normal system shut down if it will
> @@ -338,7 +343,7 @@ static void tegra_tsensor_get_hw_channel
>   	 * shut down gracefully before sending signal to the Power
>   	 * Management controller.
>   	 */
> -	*crit_trip = clamp(*crit_trip + 5000, 25000, 90000);
> +	temps->crit_trip = clamp(temps->crit_trip + 5000, 25000, 90000);
>   }
>   
>   static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
> @@ -346,7 +351,8 @@ static int tegra_tsensor_enable_hw_chann
>   {
>   	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
>   	struct thermal_zone_device *tzd = tsc->tzd;
> -	int err, hot_trip = 0, crit_trip = 0;
> +	struct trip_temps temps = { 0 };
> +	int err;
>   	u32 val;
>   
>   	if (!tzd) {
> @@ -357,24 +363,24 @@ static int tegra_tsensor_enable_hw_chann
>   		return 0;
>   	}
>   
> -	tegra_tsensor_get_hw_channel_trips(tzd, &hot_trip, &crit_trip);
> +	tegra_tsensor_get_hw_channel_trips(tzd, &temps);
>   
>   	dev_info_once(ts->dev, "ch%u: PMC emergency shutdown trip set to %dC\n",
> -		      id, DIV_ROUND_CLOSEST(crit_trip, 1000));
> +		      id, DIV_ROUND_CLOSEST(temps.crit_trip, 1000));
>   
> -	hot_trip  = tegra_tsensor_temp_to_counter(ts, hot_trip);
> -	crit_trip = tegra_tsensor_temp_to_counter(ts, crit_trip);
> +	temps.hot_trip  = tegra_tsensor_temp_to_counter(ts, temps.hot_trip);
> +	temps.crit_trip = tegra_tsensor_temp_to_counter(ts, temps.crit_trip);
>   
>   	/* program LEVEL2 counter threshold */
>   	val = readl_relaxed(tsc->regs + TSENSOR_SENSOR0_CONFIG1);
>   	val &= ~TSENSOR_SENSOR0_CONFIG1_TH2;
> -	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG1_TH2, hot_trip);
> +	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG1_TH2, temps.hot_trip);
>   	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG1);
>   
>   	/* program LEVEL3 counter threshold */
>   	val = readl_relaxed(tsc->regs + TSENSOR_SENSOR0_CONFIG2);
>   	val &= ~TSENSOR_SENSOR0_CONFIG2_TH3;
> -	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG2_TH3, crit_trip);
> +	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG2_TH3, temps.crit_trip);
>   	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG2);
>   
>   	/*
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


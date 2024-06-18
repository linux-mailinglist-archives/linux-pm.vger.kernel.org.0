Return-Path: <linux-pm+bounces-9405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DE90C2A5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 06:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879ED284E47
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 04:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D654219FD;
	Tue, 18 Jun 2024 04:05:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE82595;
	Tue, 18 Jun 2024 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683506; cv=none; b=GR4R0p7nMWM3gC8lCfI1qFp+Hz1ORAZXqO3QF+lokFSR3E1r/6e3q1MmDmcy1AJ3rws3sonF6bC6l3P3tUe+nCeFBBbTf4Ic6gNm0S9MJ45J4oxb1M63JUSSFanmOJKna9L0SDyq8s5KeRIS1bGtsysP3lHpUJg3trqXT+vxWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683506; c=relaxed/simple;
	bh=jRwP4jQ+6fuBi4tIvvMc8ASHvc5MEraGwbn3lkHTKps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPalTWAcJmMPQtX09KI9CGnHd88LL7DY5ODbGVsd4fD4iNJGP7TB2tYsS7KPa45o+pMrtND3duC+WMaoIQfYukJpDDcpp/ISNdbGL6RaTpjK6sHscdRWafbqzyeN64XAct90E5Rp15xln0Qa4vMVM7SorNNjUoj/0r+DvNsMyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Jun 2024 13:03:52 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id DC37420584C6;
	Tue, 18 Jun 2024 13:03:52 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 18 Jun 2024 13:03:52 +0900
Received: from [192.168.1.137] (unknown [10.213.44.69])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 6B64BA6B4F;
	Tue, 18 Jun 2024 13:03:52 +0900 (JST)
Message-ID: <e54a7a9b-3fc7-457f-9f30-d6ab3a58c2b0@socionext.com>
Date: Tue, 18 Jun 2024 13:03:51 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/14] thermal: uniphier: Use
 thermal_zone_for_each_trip() for walking trip points
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <8409966.T7Z3S40VBb@kreacher> <2148114.bB369e8A3T@kreacher>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <2148114.bB369e8A3T@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 2024/06/18 3:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally inefficient to iterate over trip indices and call
> thermal_zone_get_trip() every time to get the struct thermal_trip
> corresponding to the given trip index, so modify the uniphier thermal
> driver to use thermal_zone_for_each_trip() for walking trips.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/uniphier_thermal.c |   37
> +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/drivers/thermal/uniphier_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/uniphier_thermal.c
> +++ linux-pm/drivers/thermal/uniphier_thermal.c
> @@ -239,13 +239,32 @@ static irqreturn_t uniphier_tm_alarm_irq
>   	return IRQ_HANDLED;
>   }
> 
> +struct trip_walk_data {
> +	struct uniphier_tm_dev *tdev;
> +	int crit_temp;
> +	int index;
> +};
> +
> +static int uniphier_tm_trip_walk_cb(struct thermal_trip *trip, void *arg)
> +{
> +	struct trip_walk_data *twd = arg;
> +
> +	if (trip->type == THERMAL_TRIP_CRITICAL &&
> +	    trip->temperature < twd->crit_temp)
> +		twd->crit_temp = trip->temperature;
> +
> +	uniphier_tm_set_alert(twd->tdev, twd->index, trip->temperature);
> +	twd->tdev->alert_en[twd->index++] = true;
> +}
> +
>   static int uniphier_tm_probe(struct platform_device *pdev)
>   {
> +	struct trip_walk_data twd = { .crit_temp = INT_MAX, .index = 0 };
>   	struct device *dev = &pdev->dev;
>   	struct regmap *regmap;
>   	struct device_node *parent;
>   	struct uniphier_tm_dev *tdev;
> -	int i, ret, irq, crit_temp = INT_MAX;
> +	int i, ret, irq;
> 
>   	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
>   	if (!tdev)
> @@ -293,20 +312,10 @@ static int uniphier_tm_probe(struct plat
>   	}
> 
>   	/* set alert temperatures */
> -	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
> -		struct thermal_trip trip;
> +	twd.tdev = tdev;
> +	thermal_zone_for_each_trip(tdev->tz_dev, uniphier_tm_trip_walk_cb, &twd);
> 
> -		ret = thermal_zone_get_trip(tdev->tz_dev, i, &trip);
> -		if (ret)
> -			return ret;
> -
> -		if (trip.type == THERMAL_TRIP_CRITICAL &&
> -		    trip.temperature < crit_temp)
> -			crit_temp = trip.temperature;
> -		uniphier_tm_set_alert(tdev, i, trip.temperature);
> -		tdev->alert_en[i] = true;
> -	}
> -	if (crit_temp > CRITICAL_TEMP_LIMIT) {
> +	if (twd.crit_temp > CRITICAL_TEMP_LIMIT) {
>   		dev_err(dev, "critical trip is over limit(>%d), or not set\n",
>   			CRITICAL_TEMP_LIMIT);
>   		return -EINVAL;

I confirmed the updated code using the helper function is equivalent
to the original.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi


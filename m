Return-Path: <linux-pm+bounces-15774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8259A0C33
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC53C1C25F85
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69E20C01C;
	Wed, 16 Oct 2024 13:58:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88820C009;
	Wed, 16 Oct 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087139; cv=none; b=c+UdFEoQEGP7nSpk/W1kB0dX5sc3Qo8pBk4bofE9lZ5tywDQYW6Q54DuvWrL96vE7Z1p1d2oXcy9cnTAvnIpkqLWi73zztwj8JqCwXROlBl1QpGkMz96w6Szscnvl9JnyaTjF/C2QnPaPesC2XuX54IFWY1Wbw+UWjlP/Y9LcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087139; c=relaxed/simple;
	bh=DCwW1BXaEzYmomHtjqvPhEnDGnecHTjUZgJNEcpFnTA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV+a8Ndu+BJiDoBSdy205lZFwASoKPuT/2qnXi7suJfPXiNV8QyBT0PXTd8/RSZv0z7t7ZLeTukmM6avmil9VQ3ODZ2duG7RaLkO+1dEcbTHhMmu7xNqSHmZ/TFGk6tTXgX7aHvIrOVklu6Nn0F1A1rzq5hjM9/f1xMjSYCH1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTCGw6RFvz6D8Y7;
	Wed, 16 Oct 2024 21:58:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 54E9E140B67;
	Wed, 16 Oct 2024 21:58:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 15:58:52 +0200
Date: Wed, 16 Oct 2024 14:58:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
	<thara.gopinath@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vasily Khoruzhick
	<anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v4 2/6] thermal: of: Use scoped memory and OF handling
 to simplify thermal_of_trips_init()
Message-ID: <20241016145851.00004e90@Huawei.com>
In-Reply-To: <20241010-b4-cleanup-h-of-node-put-thermal-v4-2-bfbe29ad81f4@linaro.org>
References: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
	<20241010-b4-cleanup-h-of-node-put-thermal-v4-2-bfbe29ad81f4@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Oct 2024 20:06:18 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Obtain the device node reference and allocate memory with
> scoped/cleanup.h to reduce error handling and make the code a bit
> simpler.
> 
> The code is not equivalent in one minor aspect: outgoing parameter
> "*ntrips" will not be zeroed on errors of memory allocation.  This
> difference is not important, because code was already not zeroing it in
> case of earlier errors and the only caller does not rely on ntrips being
> 0 in case of errors.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Trivial unrelated comment inline + maybe return_ptr() is the way to go as
Chen-Yu mentioned.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> 
> Changes in v4:
> 1. Significant change: kzalloc() also with scoped-handling so the entire
>    error handling could be removed.
> 2. Due to above, drop review-tags (Chen-Yu, Jonathan).
> 
> Changes in v2:
> 1. Drop left-over of_node_put in regular exit path (Chen-Yu)
> ---
>  drivers/thermal/thermal_of.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index f0ffc0e335ba9406f4fd858d6c561f9d23f4b842..37db435b54b124abf25b1d75d6cc4fb75f1c1e5c 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -95,11 +95,9 @@ static int thermal_of_populate_trip(struct device_node *np,
>  
>  static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
>  {
> -	struct thermal_trip *tt;
> -	struct device_node *trips;
>  	int ret, count;
>  
> -	trips = of_get_child_by_name(np, "trips");
> +	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
>  	if (!trips) {
>  		pr_err("Failed to find 'trips' node\n");
>  		return ERR_PTR(-EINVAL);
> @@ -108,36 +106,23 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  	count = of_get_child_count(trips);
>  	if (!count) {
>  		pr_err("No trip point defined\n");
> -		ret = -EINVAL;
> -		goto out_of_node_put;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
> -	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
> -	if (!tt) {
> -		ret = -ENOMEM;
> -		goto out_of_node_put;
> -	}
> -
> -	*ntrips = count;
> +	struct thermal_trip *tt __free(kfree) = kzalloc(sizeof(*tt) * count, GFP_KERNEL);

Trivial and unrelated, but maybe kcalloc(count, sizeof(tt), GFP_KERNEL);

> +	if (!tt)
> +		return ERR_PTR(-ENOMEM);
>  
>  	count = 0;
>  	for_each_child_of_node_scoped(trips, trip) {
>  		ret = thermal_of_populate_trip(trip, &tt[count++]);
>  		if (ret)
> -			goto out_kfree;
> +			return ERR_PTR(ret);
>  	}
>  
> -	of_node_put(trips);
> +	*ntrips = count;
>  
> -	return tt;
> -
> -out_kfree:
> -	kfree(tt);
> -	*ntrips = 0;
> -out_of_node_put:
> -	of_node_put(trips);
> -
> -	return ERR_PTR(ret);
> +	return no_free_ptr(tt);
>  }
>  
>  static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
> 



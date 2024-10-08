Return-Path: <linux-pm+bounces-15319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A54994702
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC8E1F27103
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E691D097F;
	Tue,  8 Oct 2024 11:32:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797718C900;
	Tue,  8 Oct 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387134; cv=none; b=JdwF0VprMHnczgl1kJThLwDRkBj9seUWLVh0v0a0LSVELumJtx69fKM0cePt8qcxe6U2gppiaf/EX5x9ev5K/aF2oUoD+Cfm/mql5qtcozfVW+ADN94JXq2FAS1K/pOzaI0GSAg2KnfSgbzSlSJwyRKO4EQf7WiRkyBK2UVQtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387134; c=relaxed/simple;
	bh=BIZhFLzZ1V3Ac+YnjXpug+akiGgDZeawNbKSfEcCcG8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkEKE8revsogk3ZkUgAjZLRXT651iN63LqcKSP85mINs5y6JHb6MvwaCtTYzA4OgHcf0jQFk2odbI6qlOxW4s4k4NXitKMsBJwIutB0Ie636h3JyrhfdAHRGXLaSojCTMYEBSyook4BijajkaYzPp2MnucJPBZUN0Koul3rMMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNDNc564Tz6GCD6;
	Tue,  8 Oct 2024 19:30:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 082A71408F9;
	Tue,  8 Oct 2024 19:32:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 13:32:10 +0200
Date: Tue, 8 Oct 2024 12:32:09 +0100
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
Subject: Re: [PATCH v3 2/6] thermal: of: Use scoped device node handling to
 simplify thermal_of_trips_init()
Message-ID: <20241008123209.00005cee@Huawei.com>
In-Reply-To: <20241008-b4-cleanup-h-of-node-put-thermal-v3-2-825122398f71@linaro.org>
References: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
	<20241008-b4-cleanup-h-of-node-put-thermal-v3-2-825122398f71@linaro.org>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 08 Oct 2024 11:00:02 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
A follow up suggestion below.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> 
> Changes in v2:
> 1. Drop left-over of_node_put in regular exit path (Chen-Yu)
> ---
>  drivers/thermal/thermal_of.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index f0ffc0e335ba9406f4fd858d6c561f9d23f4b842..d7d6f62caa13d545e5f7fae4c8ac1e737bf4c4b1 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -96,10 +96,9 @@ static int thermal_of_populate_trip(struct device_node *np,
>  static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
>  {
>  	struct thermal_trip *tt;
> -	struct device_node *trips;
>  	int ret, count;
>  
> -	trips = of_get_child_by_name(np, "trips");
> +	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
>  	if (!trips) {
>  		pr_err("Failed to find 'trips' node\n");
>  		return ERR_PTR(-EINVAL);
> @@ -108,15 +107,12 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  	count = of_get_child_count(trips);
>  	if (!count) {
>  		pr_err("No trip point defined\n");
> -		ret = -EINVAL;
> -		goto out_of_node_put;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
> -	if (!tt) {
> -		ret = -ENOMEM;
> -		goto out_of_node_put;
> -	}
> +	if (!tt)
> +		return ERR_PTR(-ENOMEM);
>  
>  	*ntrips = count;
>  
> @@ -127,15 +123,11 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  			goto out_kfree;
>  	}
>  
> -	of_node_put(trips);
> -
>  	return tt;
>  
>  out_kfree:
>  	kfree(tt);
May be worth a follow up to do __free(kfree) on this + a steal for the return.
Then push the ntrips set until after the populate so it doesn't need resetting to 0.


>  	*ntrips = 0;
> -out_of_node_put:
> -	of_node_put(trips);
>  
>  	return ERR_PTR(ret);
>  }
> 



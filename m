Return-Path: <linux-pm+bounces-12210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290D95203F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 18:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40D3281DA2
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4A1B9B34;
	Wed, 14 Aug 2024 16:42:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E91B9B31;
	Wed, 14 Aug 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653773; cv=none; b=oVNjsKYQlnj6JATrspir7sjNPxEctPm+VLyhU73We4Up/RNtxMLP4HxuFUArfIvLSdoiT/4b17qJJ4sUb0QTYOfed680Oj9vWo4m+ozPP0ARTtWzKs0o5dnsP0ihKOzES/V3VBaPXaPXJK0UjgOqXTAbKeEZc4P4Ekjgz2rPixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653773; c=relaxed/simple;
	bh=oi7WYRRaPvjerHLDMNbE+q+FkWLO5UuZ96gbD4eAvWo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uF6E0Nk66HcU4CuxpPEJp8dFaSwfKBPCg1ez17WgFxJMivr3LxGVylCMg7bovyCtwZ7jxe3mPXhdaXhn+l/R/jK95GJOa7vmXG3kmvm21eUXWMB1ReJDSMUdj4n/37zc2Ab+z1JvjEgKry9EG0bR42I3Ds5vJEzPa8saWqoyUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkYrp1H7Wz6K9Gf;
	Thu, 15 Aug 2024 00:40:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BE5E3140A90;
	Thu, 15 Aug 2024 00:42:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 17:42:48 +0100
Date: Wed, 14 Aug 2024 17:42:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Santosh Shilimkar
	<ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/9] memory: samsung: exynos5422-dmc: use scoped device
 node handling to simplify error paths
Message-ID: <20240814174246.00007e4e@Huawei.com>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-3-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
	<20240812-cleanup-h-of-node-put-memory-v1-3-5065a8f361d2@linaro.org>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Aug 2024 15:33:57 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Trivial comments inline
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index da7ecd921c72..d3ae4d95a3ba 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -4,6 +4,7 @@
>   * Author: Lukasz Luba <l.luba@partner.samsung.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/devfreq.h>
>  #include <linux/devfreq-event.h>
> @@ -1176,10 +1177,10 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
>  {
>  	int ret = 0;
>  	int idx;
> -	struct device_node *np_ddr;

This would definitely benefit from a
struct device *dev = dmc->dev;

>  	u32 freq_mhz, clk_period_ps;
>  
> -	np_ddr = of_parse_phandle(dmc->dev->of_node, "device-handle", 0);
> +	struct device_node *np_ddr __free(device_node) = of_parse_phandle(dmc->dev->of_node,
> +									  "device-handle", 0);
Trivial. Maybe consider the wrap suggested in patch 1.
> +	struct device_node *np_ddr __free(device_node) =
		of_parse_phandle(dmc->dev->of_node, "device-handle", 0);

>  	if (!np_ddr) {
>  		dev_warn(dmc->dev, "could not find 'device-handle' in DT\n");
>  		return -EINVAL;
> @@ -1187,39 +1188,31 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
>  
>  	dmc->timing_row = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
>  					     sizeof(u32), GFP_KERNEL);
> -	if (!dmc->timing_row) {
> -		ret = -ENOMEM;
> -		goto put_node;
> -	}
> +	if (!dmc->timing_row)
> +		return -ENOMEM;
>  
>  	dmc->timing_data = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
>  					      sizeof(u32), GFP_KERNEL);
> -	if (!dmc->timing_data) {
> -		ret = -ENOMEM;
> -		goto put_node;
> -	}
> +	if (!dmc->timing_data)
> +		return -ENOMEM;
>  
>  	dmc->timing_power = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
>  					       sizeof(u32), GFP_KERNEL);
> -	if (!dmc->timing_power) {
> -		ret = -ENOMEM;
> -		goto put_node;
> -	}
> +	if (!dmc->timing_power)
> +		return -ENOMEM;
>  
>  	dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dmc->dev,
>  						 DDR_TYPE_LPDDR3,
>  						 &dmc->timings_arr_size);
>  	if (!dmc->timings) {
>  		dev_warn(dmc->dev, "could not get timings from DT\n");
> -		ret = -EINVAL;
> -		goto put_node;
> +		return -EINVAL;
>  	}
>  
>  	dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dmc->dev);
>  	if (!dmc->min_tck) {
>  		dev_warn(dmc->dev, "could not get tck from DT\n");
> -		ret = -EINVAL;
> -		goto put_node;
> +		return -EINVAL;
>  	}
>  
>  	/* Sorted array of OPPs with frequency ascending */
> @@ -1239,8 +1232,6 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
>  	dmc->bypass_timing_data = dmc->timing_data[idx - 1];
>  	dmc->bypass_timing_power = dmc->timing_power[idx - 1];
>  
> -put_node:
> -	of_node_put(np_ddr);
>  	return ret;
>  }
>  
> 



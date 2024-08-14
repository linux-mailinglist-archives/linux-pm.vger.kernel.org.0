Return-Path: <linux-pm+bounces-12211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8D95204A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FCC284FD0
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6781B9B3F;
	Wed, 14 Aug 2024 16:45:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3D1B32C1;
	Wed, 14 Aug 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653909; cv=none; b=sjph0j2mN0Wc2K8hgOyNk5dQTMRwOhzRVQ1/fOO5NjQ7CTK6ef5c7ssxcukY+HP/rDObDr+asW9KujV7MpWJQT6mpsFAjYzwPrRojzX30+heaVhGuDZPeYImYBmphumuWqhjPAFceffhVgRw8gnrrLmo01KIxxZSkSia2K0PebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653909; c=relaxed/simple;
	bh=/n56xU5JNvQ+uWhPffHfc+6hSiphLiK4sF3OvYACHiM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTmVxDUJDZ6BGweIjuqnXC5FWVBWssATLKuCDSiIB/vhvC9U/6Z/50oBy1BOlKu9TK5wj4HCBOn6jViFQ24vLaZHRVy1K58/fsgTb0kEx8M6hnBtiS7+oSdLakjUH6x1Rx2tXI9lBPPeReUh+18Tw4idTNVzw0UCIPjr479t1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkYv46bP1z6K8x1;
	Thu, 15 Aug 2024 00:42:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E1FC1400CD;
	Thu, 15 Aug 2024 00:45:04 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 17:45:03 +0100
Date: Wed, 14 Aug 2024 17:45:02 +0100
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
Subject: Re: [PATCH 4/9] memory: stm32-fmc2-ebi: simplify with scoped for
 each OF child loop
Message-ID: <20240814174502.00003b2c@Huawei.com>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-4-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
	<20240812-cleanup-h-of-node-put-memory-v1-4-5065a8f361d2@linaro.org>
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

On Mon, 12 Aug 2024 15:33:58 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Might be worth using dev_err_probe() in here. Otherwise LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/memory/stm32-fmc2-ebi.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
> index 1c63eeacd071..7167e1da56d3 100644
> --- a/drivers/memory/stm32-fmc2-ebi.c
> +++ b/drivers/memory/stm32-fmc2-ebi.c
> @@ -1573,29 +1573,25 @@ static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
>  static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
>  {
>  	struct device *dev = ebi->dev;
> -	struct device_node *child;
>  	bool child_found = false;
>  	u32 bank;
>  	int ret;
>  
> -	for_each_available_child_of_node(dev->of_node, child) {
> +	for_each_available_child_of_node_scoped(dev->of_node, child) {
>  		ret = of_property_read_u32(child, "reg", &bank);
>  		if (ret) {
>  			dev_err(dev, "could not retrieve reg property: %d\n",
>  				ret);
> -			of_node_put(child);
>  			return ret;
			return dev_err_probe(dev, "could not retrieve reg property\n");
perhaps?
>  		}
>  
>  		if (bank >= FMC2_MAX_BANKS) {
>  			dev_err(dev, "invalid reg value: %d\n", bank);
> -			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
>  		if (ebi->bank_assigned & BIT(bank)) {
>  			dev_err(dev, "bank already assigned: %d\n", bank);
> -			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -1603,7 +1599,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
>  			ret = ebi->data->check_rif(ebi, bank + 1);
>  			if (ret) {
>  				dev_err(dev, "bank access failed: %d\n", bank);
> -				of_node_put(child);
>  				return ret;
>  			}
>  		}
> @@ -1613,7 +1608,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
>  			if (ret) {
>  				dev_err(dev, "setup chip select %d failed: %d\n",
>  					bank, ret);
> -				of_node_put(child);
>  				return ret;
>  			}
>  		}
> 



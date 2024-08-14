Return-Path: <linux-pm+bounces-12208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDB952030
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DF28AD7E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605AD1B8EB4;
	Wed, 14 Aug 2024 16:38:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0A1B8E94;
	Wed, 14 Aug 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653528; cv=none; b=JK79yAHbfEsZXWmsTbDNr0P/CgEbTNHZXjDjxJAwz541cRiZmo0eAKSnoRbZ9efp7Mr7U/RVoPM/pMQO6WDLfuLJ6MMulSNAe9+UPuJPv8U02FpES24g69k7kxoGYA0pLJ6XdALYsgUvVxKmMicsDxb+zlVI9CT1bErSjkGX0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653528; c=relaxed/simple;
	bh=CO8qOzi03Ld/YkeV8tQJ54g2seyyF0fq96e3Yln3LZ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csXVI6rocq17FQHTy+SncvtFKrXvqOcRKhDzA8SirK0y08t5EknXFptm8mTa+UCKeI5C/AWUCx/33qBI2eygZ8oqPyKtq667vgvLh83dpNJqGJP9j569luQPmfN7SAAELjpD3QKmzySsGIXIwlbCzmG9UDhj22GeEyCcKqLJxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkYlC4h9Mz6K6D2;
	Thu, 15 Aug 2024 00:35:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B165140C98;
	Thu, 15 Aug 2024 00:38:36 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 17:38:35 +0100
Date: Wed, 14 Aug 2024 17:38:34 +0100
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
Subject: Re: [PATCH 1/9] memory: atmel-ebi: use scoped device node handling
 to simplify error paths
Message-ID: <20240814173834.000002c8@Huawei.com>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-1-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
	<20240812-cleanup-h-of-node-put-memory-v1-1-5065a8f361d2@linaro.org>
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

On Mon, 12 Aug 2024 15:33:55 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi,

Comments inline.
> ---
>  drivers/memory/atmel-ebi.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index e8bb5f37f5cb..fcbfc2655d8d 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> @@ -517,7 +518,7 @@ static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
>  static int atmel_ebi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *child, *np = dev->of_node, *smc_np;
> +	struct device_node *child, *np = dev->of_node;
>  	struct atmel_ebi *ebi;
>  	int ret, reg_cells;
>  	struct clk *clk;
> @@ -541,30 +542,24 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>  
>  	ebi->clk = clk;
>  
> -	smc_np = of_parse_phandle(dev->of_node, "atmel,smc", 0);
> +	struct device_node *smc_np __free(device_node) = of_parse_phandle(dev->of_node,
> +									  "atmel,smc", 0);
Trivial:
I'd line break this as
> +	struct device_node *smc_np __free(device_node) =
		of_parse_phandle(dev->of_node, "atmel,smc", 0);

>  
>  	ebi->smc.regmap = syscon_node_to_regmap(smc_np);
> -	if (IS_ERR(ebi->smc.regmap)) {
> -		ret = PTR_ERR(ebi->smc.regmap);
> -		goto put_node;
> -	}
> +	if (IS_ERR(ebi->smc.regmap))
> +		return PTR_ERR(ebi->smc.regmap);
>  
>  	ebi->smc.layout = atmel_hsmc_get_reg_layout(smc_np);
> -	if (IS_ERR(ebi->smc.layout)) {
> -		ret = PTR_ERR(ebi->smc.layout);
> -		goto put_node;
> -	}
> +	if (IS_ERR(ebi->smc.layout))
> +		return PTR_ERR(ebi->smc.layout);
>  
>  	ebi->smc.clk = of_clk_get(smc_np, 0);
>  	if (IS_ERR(ebi->smc.clk)) {
> -		if (PTR_ERR(ebi->smc.clk) != -ENOENT) {
> -			ret = PTR_ERR(ebi->smc.clk);
> -			goto put_node;
> -		}
> +		if (PTR_ERR(ebi->smc.clk) != -ENOENT)
> +			return PTR_ERR(ebi->smc.clk);
>  
>  		ebi->smc.clk = NULL;
>  	}
> -	of_node_put(smc_np);

The large change in scope is a bit inelegant as it now hangs on to
the smc_np much longer than before.

Maybe it's worth pulling out the modified code as a 
atem_eb_probe_smc(struct device_node *smc_np, struct atmel_ebi_smc *smc )

or something like with a struct_group to define the atmel_ebi_smc

That would keep the tight scope for the data and generally simplify it
a bit.

>  	ret = clk_prepare_enable(ebi->smc.clk);
>  	if (ret)
>  		return ret;
> @@ -615,10 +610,6 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>  	}
>  
>  	return of_platform_populate(np, NULL, NULL, dev);
> -
> -put_node:
> -	of_node_put(smc_np);
> -	return ret;
>  }
>  
>  static __maybe_unused int atmel_ebi_resume(struct device *dev)
> 



Return-Path: <linux-pm+bounces-12215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F295208A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C33CB2290D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E871BA897;
	Wed, 14 Aug 2024 16:55:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA31B1409;
	Wed, 14 Aug 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654548; cv=none; b=WNX1hD1NWmzGLxOJ65KnIiYHPpMOdOMeUuLI4YygjbgC6GO3ixZ4iuHav1Tsh8Tj7KOj4Qd7wa4eDQEfEO1ADHJJowilQK+M7x8knntsYBHC5HuEEMMyDeFu9k8WXPeQ0ulfFZBphvGx6THKrekUyOy2l08dKJqdfKxNM7nRU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654548; c=relaxed/simple;
	bh=8ky1iVr+QEbGU+/PZctjOx0svo6AKnLXMM6XA2nqJDc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP/cC8ZBgPJDRL/S2fqFTkdjtFiwlwaQb2q5novPk/2xYHPdxPhEjksRAAh2/+oDPvbrftgT83j985if5asVWJY0AC4j/rD5tiUjP40DYst/X0n81HqcY3+ESt5Sq1dBO1UnyoWuX3spKkzcwWf25aXPRqwqEWNy2x/GQmDXfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkZ7h5yf1z6K9Jv;
	Thu, 15 Aug 2024 00:53:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7930B1400CD;
	Thu, 15 Aug 2024 00:55:43 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 17:55:42 +0100
Date: Wed, 14 Aug 2024 17:55:41 +0100
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
Subject: Re: [PATCH 9/9] memory: ti-aemif: simplify with scoped for each OF
 child loop
Message-ID: <20240814175541.00002023@Huawei.com>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-9-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
	<20240812-cleanup-h-of-node-put-memory-v1-9-5065a8f361d2@linaro.org>
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

On Mon, 12 Aug 2024 15:34:03 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Nothing wrong with this patch, but I think you can add a precusor
that will make this neater.

Jonathan

> ---
>  drivers/memory/ti-aemif.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> index e192db9e0e4b..cd2945d4ec18 100644
> --- a/drivers/memory/ti-aemif.c
> +++ b/drivers/memory/ti-aemif.c
> @@ -330,7 +330,6 @@ static int aemif_probe(struct platform_device *pdev)
>  	int ret = -ENODEV;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	struct device_node *child_np;
>  	struct aemif_device *aemif;
>  	struct aemif_platform_data *pdata;
>  	struct of_dev_auxdata *dev_lookup;
> @@ -374,12 +373,10 @@ static int aemif_probe(struct platform_device *pdev)
>  		 * functions iterate over these nodes and update the cs data
>  		 * array.
>  		 */
> -		for_each_available_child_of_node(np, child_np) {
> +		for_each_available_child_of_node_scoped(np, child_np) {
>  			ret = of_aemif_parse_abus_config(pdev, child_np);
> -			if (ret < 0) {
> -				of_node_put(child_np);
> +			if (ret < 0)
>  				goto error;
I'd precede this patch with use of
devm_clk_get_enabled()

That would avoid what looks like potential mixed devm and not issues
and let you return here.


> -			}
>  		}
>  	} else if (pdata && pdata->num_abus_data > 0) {
>  		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
> @@ -402,13 +399,11 @@ static int aemif_probe(struct platform_device *pdev)
>  	 * child will be probed after the AEMIF timing parameters are set.
>  	 */
>  	if (np) {
> -		for_each_available_child_of_node(np, child_np) {
> +		for_each_available_child_of_node_scoped(np, child_np) {
>  			ret = of_platform_populate(child_np, NULL,
>  						   dev_lookup, dev);
> -			if (ret < 0) {
> -				of_node_put(child_np);
> +			if (ret < 0)
>  				goto error;
> -			}
>  		}
>  	} else if (pdata) {
>  		for (i = 0; i < pdata->num_sub_devices; i++) {
> 



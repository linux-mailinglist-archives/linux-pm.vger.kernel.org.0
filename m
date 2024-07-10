Return-Path: <linux-pm+bounces-10918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06BB92CF46
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7D1F21F72
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70418EFF9;
	Wed, 10 Jul 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TBmZyMIw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFE12C530
	for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607470; cv=none; b=feSvHradGhDToBXh71fZ2tfAMVTcv0KfMzQx2n3JhtNVnqQToahcxeChzS9a+mLqKIbOk5bUBRTw6ci46d8A/j5UWVjMl005PJJvOdtq4slP7odfseQstmW0Wwh2vEcUiyTrmYVrafPkxvvTOML+ElOux4Bboe+btBxilS5AsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607470; c=relaxed/simple;
	bh=7Lhie7ob6XN2MfK3M+u9hh6fDPhqpPGPGWl4Rs6GGlY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ut2r8K7Fb+2G9Z2zZpYsOWjoU/y3KlG1N3eI+4oZVM033XXbLOg6xJ5BstA8MQpKrxFS3okpCSdX3Q+gsaXPIdAXIpD/U2xeLl5KtByyW7vMjccajgQKFIaTJWBcXO/8h4JLQ/SpFjzLs+J042P7kk6mEBezXJSTEra3YTDNjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TBmZyMIw; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240710103106epoutp02f357858a2dcfe23b4fe811e8e1318811~g01-dc0gN2098320983epoutp02g
	for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 10:31:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240710103106epoutp02f357858a2dcfe23b4fe811e8e1318811~g01-dc0gN2098320983epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720607466;
	bh=nbk9Pdg7OYXICEjwvvLvJ1kmU48SoJWAfgQWramsV64=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TBmZyMIwS1pd/aImfWEPhNtY9EgLmeDw6VIiO5qt34hHFPuPpxVf60svoUjQE5Pir
	 iw1gPCTHb9EilEUt9jA0eVr976byne3JiXS7I+5/320vA3TpJaDhJ4LsR6Z+O0Jqv9
	 9pELQ5IffCZyoT6mqsKCnimm2whyN0oUgeES4nfM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240710103105epcas5p2fe1d0154c7bca0415a1c3a44f12e6de1~g01_7maka1040310403epcas5p2Y;
	Wed, 10 Jul 2024 10:31:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WJvK42xdHz4x9Q1; Wed, 10 Jul
	2024 10:31:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.0E.06857.8E26E866; Wed, 10 Jul 2024 19:31:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240710103103epcas5p1e4d33af6169900a1395c0c62e20fc1c3~g018-gFuM2946029460epcas5p1U;
	Wed, 10 Jul 2024 10:31:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240710103103epsmtrp1c03e6e073d00f653bc70b3a918af22ee~g018_ReTl2327923279epsmtrp1S;
	Wed, 10 Jul 2024 10:31:03 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-48-668e62e8493a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.D1.18846.7E26E866; Wed, 10 Jul 2024 19:31:03 +0900 (KST)
Received: from INBRO002756 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240710103100epsmtip196e11e56159895c3b6822ba649ce5c85~g0152aB1u2202122021epsmtip1C;
	Wed, 10 Jul 2024 10:31:00 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Rafael J.
 Wysocki'" <rafael@kernel.org>, "'Daniel Lezcano'"
	<daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>, "'Lukasz
 Luba'" <lukasz.luba@arm.com>, "'Florian Fainelli'"
	<florian.fainelli@broadcom.com>, "'Ray Jui'" <rjui@broadcom.com>, "'Scott
 Branden'" <sbranden@broadcom.com>, "'Broadcom internal kernel review list'"
	<bcm-kernel-feedback-list@broadcom.com>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Shawn
 Guo'" <shawnguo@kernel.org>, "'Sascha Hauer'" <s.hauer@pengutronix.de>,
	"'Pengutronix Kernel Team'" <kernel@pengutronix.de>, "'Fabio Estevam'"
	<festevam@gmail.com>, "'Amit Kucheria'" <amitk@kernel.org>, "'Thara
 Gopinath'" <thara.gopinath@gmail.com>
Cc: <linux-pm@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-msm@vger.kernel.org>
In-Reply-To: <20240709-thermal-probe-v1-4-241644e2b6e0@linaro.org>
Subject: RE: [PATCH 04/12] thermal/drivers/exynos: simplify probe() with
 local dev variable
Date: Wed, 10 Jul 2024 16:00:58 +0530
Message-ID: <019601dad2b4$439c8b90$cad5a2b0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQILhc/2wHZoSi9ND1AGTvp0WerExgJCFhw7Asyq3nOxZeaNUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxT2bcttYYFcCo7XTjbWCAy3QitQXghMnMTdDI0YF1lYFijttRBK
	W3vLxlyIZAJOOkCGMmgQpiAflTFSsFJA3AA/N6xEPmSMrwoZjA9BlsDWkKz0ouPfc57znPec
	57w5HCb3LJvHSVVqSY1SouBjLixTT8A7gtnkwpPCRyM46qnKRD8W3GGhtdZhBqpc9UZTg0dR
	k2mcicrHczFkuGRmIYulmY1uzd9gI+OzISdUfLuPjZ60V2BotaAXoOJRe7bM0sVAV77OYaPL
	f19iopnyFgxNTxViaOOmkYWWrk8DNNvqhQYay7BoSDRWNgJCP9GHEWb9GJuo7pxjEEbDeYz4
	Y6gTI1pqzhCzLeWAKNoQEqvGN+NcEtIiU0iJjNT4kEqpSpaqlEfxY48nHkwMFQtFAlE4CuP7
	KCXpZBQ/5nCc4FCqwm6X7/O5RJFhp+IkFMUPej9So8rQkj4pKkobxSfVMoU6RB1ISdKpDKU8
	UElqI0RC4b5QuzApLWX52xm22iTKtH4/BbLBpH8+cOZAPAR2NvU4bWIu3gFgV5lbPnCx4xcA
	XjCVgVeB6UY162VF7WIdm06YAawvKWTSwSyAL6obwKYKwwWwrToP20x44k0YfNxhcARMfAXA
	P//9HdtUOeMfwIZ1k+NdD/wzeP/xVUc1C/eFNn2Vg3fFw2H9o3ZAY3f4oHzawTPxt+DNxQom
	PZMP/Gem1uHC0/5m7dAIoDVecO5Or2NWiF93htm2Jie6IAYO9xcwaOwB/7rXyqYxD84V5W3h
	NHivX4/ROBPqcle2+P3QbB2xD8GxNwiAP7UH0b3cYIFtmrFJQ9wVfpPHpdW+8OzS4Nbq3oDF
	Op0TLSFgqcnjAnhbv82Yfpsx/TYD+v97/QBYBrCLVFPpcpIKVQcryS9efbhUlW4EjmvYG9sG
	rJPLgd2AwQHdAHKYfE/Xqqe6k1xXmeTL06RGlajJUJBUNwi1b7uYydspVdnPSalNFIWEC0PE
	YnFIeLBYxPdync+9LOPicomWTCNJNal5WcfgOPOyGVz/eRf89LmLJwxtQzuy9P6cuvf6OzS8
	JKrS5l9Mhk7U1aDXguSkIX3PsjwwQarzOzYsW9hZOjzV5mVbr4ha2m3ODnv9VHD+vkLcIli7
	Gx3sjiqv9bLDs/0GOIPSSF7AfGvyM4/O2wt9qQ/u6yKTknd1EO4x39X/PHaurLn+4gFriYfp
	4CdhY36FK7V1X8Wbu5/AAYnxQKnYW7S7SSHNSjjiLYh3n/D9MHr507WZxY8DD9fpB9YiflsX
	qD4ajYlTPFx4nmOKPDQ6Xqtv3vFrybrwmHXoeNu7e4663Xoq35ATlgjriZRrWfE15jP7bTmW
	q113GxqrzxcJn5snH8YSv5zis6gUiWgvU0NJ/gOL2hillgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSnO7zpL40g9ezlCwOz6+wWNt7lMXi
	+5brTBbzPstaPLzqb7Fu2z1mi5n3WtksVk3dyWJx/vwGdou9r7eyW2x6fI3VYuL+s+wWl3fN
	YbP43HuE0WLibaDsjPP7mCwWNrWwW8z9MpXZ4unMzWwWTx72sVn83b6JxeLd6ieMFi+2iFtc
	WTODzUHCY828NYwes+6fZfPYOesuu8fiPS+ZPDat6mTzuHNtD5vH5iX1Hi82z2T06P9r4PF5
	k1wAVxSXTUpqTmZZapG+XQJXxoeep+wF2wwrHk1/yNjA+EC9i5GTQ0LARGLZ2+XsXYxcHEIC
	2xklnv/tZYVISEtc3ziBHcIWllj57zlU0TNGiZkbPjCBJNgEdCV2LG5jA7FFBHawScy64gRS
	xCzwnVHiY+9SVoiOk4wSC7dNYQGp4hRwklj5YxuYLSwQLTFx/mWwbhYBVYnfs+aDxXkFLCVW
	nNvFCGELSpyc+QQsziygLfH05lMoW15i+9s5zBDnKUj8fLqMFeIKJ4ll124yQtSIS7w8eoR9
	AqPwLCSjZiEZNQvJqFlIWhYwsqxiFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECE4NWkE7GJet
	/6t3iJGJg/EQowQHs5II7/wb3WlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1Kz
	U1MLUotgskwcnFINTHWe8fuzarfpsGoqOc9Yx8dsEvLZLy1s+U4Xxr/2769P2l/29ta+7WmL
	ax99UbBeHv78i8oUufdX/b568X2pXGyh4G1b90/HqFCyaBnPlTULX3FH7RIt70/buneSTkeo
	Ux/TuedC0Ywvb9j0u0SImv1aHOxz+5Rh8d9dNbIxdrLh54S/6K+OnfFzuZnrgfPXmOtny23Y
	fXKGYcKJgoOM4sFy9avnGOruOPer4PfF4uQlz+d9f3D5zK1LldxPqzuvZMhUVXbtrnNiD7mu
	wrNRqVtn8b7fc+oYqmIlN5dqsH5c++np4j2t1kvaN/5Yk76fd8cfU/+OHbMvl3r+L2cL9Lnw
	sbRg3cut79X2F8h9MFJiKc5INNRiLipOBACs0ki0fAMAAA==
X-CMS-MailID: 20240710103103epcas5p1e4d33af6169900a1395c0c62e20fc1c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240709130006epcas5p186c04ed3c733d13e59d58349a6043f92
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
	<CGME20240709130006epcas5p186c04ed3c733d13e59d58349a6043f92@epcas5p1.samsung.com>
	<20240709-thermal-probe-v1-4-241644e2b6e0@linaro.org>

Hello Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, July 9, 2024 6:30 PM
> To: Rafael J. Wysocki <rafael@kernel.org>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Zhang Rui <rui.zhang@intel.com>; Lukasz Luba
> <lukasz.luba@arm.com>; Florian Fainelli <florian.fainelli@broadcom.com>;
> Ray Jui <rjui@broadcom.com>; Scott Branden <sbranden@broadcom.com>;
> Broadcom internal kernel review list <bcm-kernel-feedback-
> list@broadcom.com>; Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>;
> Krzysztof Kozlowski <krzk@kernel.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Amit
> Kucheria <amitk@kernel.org>; Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org; linux-rpi-kernel@lists.infradead.org; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> samsung-soc@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> msm@vger.kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 04/12] thermal/drivers/exynos: simplify probe() with local
> dev variable
> 
> Simplify the probe() function by using local 'dev' instead of &pdev->dev.
> While touching devm_kzalloc(), use preferred sizeof(*) syntax.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/thermal/samsung/exynos_tmu.c | 42 +++++++++++++++++----------
> ---------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> b/drivers/thermal/samsung/exynos_tmu.c
> index 6482513bfe66..1152871cc982 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1004,11 +1004,11 @@ static const struct thermal_zone_device_ops
> exynos_sensor_ops = {
> 
>  static int exynos_tmu_probe(struct platform_device *pdev)  {
> +	struct device *dev = &pdev->dev;
>  	struct exynos_tmu_data *data;
>  	int ret;
> 
> -	data = devm_kzalloc(&pdev->dev, sizeof(struct exynos_tmu_data),
> -					GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> 
> @@ -1020,7 +1020,7 @@ static int exynos_tmu_probe(struct
> platform_device *pdev)
>  	 * TODO: Add regulator as an SOC feature, so that regulator enable
>  	 * is a compulsory call.
>  	 */
> -	ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
> +	ret = devm_regulator_get_enable_optional(dev, "vtmu");
>  	switch (ret) {
>  	case 0:
>  	case -ENODEV:
> @@ -1028,8 +1028,7 @@ static int exynos_tmu_probe(struct
> platform_device *pdev)
>  	case -EPROBE_DEFER:
>  		return -EPROBE_DEFER;
>  	default:
> -		dev_err(&pdev->dev, "Failed to get enabled regulator:
> %d\n",
> -			ret);
> +		dev_err(dev, "Failed to get enabled regulator: %d\n", ret);
>  		return ret;
>  	}
> 
> @@ -1037,44 +1036,44 @@ static int exynos_tmu_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
> 
> -	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
> +	data->clk = devm_clk_get(dev, "tmu_apbif");
>  	if (IS_ERR(data->clk)) {
> -		dev_err(&pdev->dev, "Failed to get clock\n");
> +		dev_err(dev, "Failed to get clock\n");
>  		return PTR_ERR(data->clk);
>  	}
> 
> -	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
> +	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
>  	if (IS_ERR(data->clk_sec)) {
>  		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> -			dev_err(&pdev->dev, "Failed to get triminfo
> clock\n");
> +			dev_err(dev, "Failed to get triminfo clock\n");
>  			return PTR_ERR(data->clk_sec);
>  		}
>  	} else {
>  		ret = clk_prepare(data->clk_sec);
>  		if (ret) {
> -			dev_err(&pdev->dev, "Failed to get clock\n");
> +			dev_err(dev, "Failed to get clock\n");
>  			return ret;
>  		}
>  	}
> 
>  	ret = clk_prepare(data->clk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to get clock\n");
> +		dev_err(dev, "Failed to get clock\n");
>  		goto err_clk_sec;
>  	}
> 
>  	switch (data->soc) {
>  	case SOC_ARCH_EXYNOS5433:
>  	case SOC_ARCH_EXYNOS7:
> -		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
> +		data->sclk = devm_clk_get(dev, "tmu_sclk");
>  		if (IS_ERR(data->sclk)) {
> -			dev_err(&pdev->dev, "Failed to get sclk\n");
> +			dev_err(dev, "Failed to get sclk\n");
>  			ret = PTR_ERR(data->sclk);
>  			goto err_clk;
>  		} else {
>  			ret = clk_prepare_enable(data->sclk);
>  			if (ret) {
> -				dev_err(&pdev->dev, "Failed to enable
> sclk\n");
> +				dev_err(dev, "Failed to enable sclk\n");
>  				goto err_clk;
>  			}
>  		}
> @@ -1085,33 +1084,32 @@ static int exynos_tmu_probe(struct
> platform_device *pdev)
> 
>  	ret = exynos_tmu_initialize(pdev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to initialize TMU\n");
> +		dev_err(dev, "Failed to initialize TMU\n");
>  		goto err_sclk;
>  	}
> 
> -	data->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, data,
> +	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
>  						  &exynos_sensor_ops);
>  	if (IS_ERR(data->tzd)) {
>  		ret = PTR_ERR(data->tzd);
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Failed to register sensor:
> %d\n",
> -				ret);
> +			dev_err(dev, "Failed to register sensor: %d\n", ret);
>  		goto err_sclk;
>  	}
> 
>  	ret = exynos_thermal_zone_configure(pdev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to configure the thermal
> zone\n");
> +		dev_err(dev, "Failed to configure the thermal zone\n");
>  		goto err_sclk;
>  	}
> 
> -	ret = devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
> +	ret = devm_request_threaded_irq(dev, data->irq, NULL,
>  					exynos_tmu_threaded_irq,
>  					IRQF_TRIGGER_RISING
>  						| IRQF_SHARED |
> IRQF_ONESHOT,
> -					dev_name(&pdev->dev), data);
> +					dev_name(dev), data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request irq: %d\n", data-
> >irq);
> +		dev_err(dev, "Failed to request irq: %d\n", data->irq);
>  		goto err_sclk;
>  	}
> 
> 
> --
> 2.43.0




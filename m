Return-Path: <linux-pm+bounces-12446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E863C956F86
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7FEB25F02
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99731607B6;
	Mon, 19 Aug 2024 16:00:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4452D045;
	Mon, 19 Aug 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083225; cv=none; b=b/e+Up6xvsy8qp2Gt6s6rcSFAFpoHTrzu24GW1bVb9KVvq5sljR54UJ61RXZR5tY0e3aH85x21VOjXQmRCzP04Ii9CAPSYuUqvejRShRKqlGXLrvB0g6mXiA2/H6L/FhrZS6rsrpCU+dMsiGoUc6m2mBcq9e49L4S3EmwMsfBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083225; c=relaxed/simple;
	bh=gWiJjwgPiS62/CDdy0pMjzITj5I0Ow5JyDbAxClF9wo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBL9VbALD2uNyHTGRfGo1HCBPZxq5Fabz3zHG2k2RyDXfpQyYCYtZ3EkknCsylyk9dH2Oz7xydhtJesbf6O1o26fjmLprlWkZvpme5gLJBjHYgNw/65NSoj62JccDCRPYQf/nxyAKRY/Q8BhlM5SE6OOYf4aEVhadc3KXmbqJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wncg16YwRz6K97L;
	Mon, 19 Aug 2024 23:57:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 182301400DB;
	Tue, 20 Aug 2024 00:00:21 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 17:00:20 +0100
Date: Mon, 19 Aug 2024 17:00:19 +0100
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
Subject: Re: [PATCH v2 11/13] memory: ti-aemif: simplify with
 dev_err_probe()
Message-ID: <20240819170019.00002dd0@Huawei.com>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-11-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
	<20240816-cleanup-h-of-node-put-memory-v2-11-9eed0ee16b78@linaro.org>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 12:54:35 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use dev_err_probe() to avoid dmesg flood on actual defer.  This makes
> the code also simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  drivers/memory/ti-aemif.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> index e192db9e0e4b..360f2705b1ff 100644
> --- a/drivers/memory/ti-aemif.c
> +++ b/drivers/memory/ti-aemif.c
> @@ -345,10 +345,8 @@ static int aemif_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, aemif);
>  
>  	aemif->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(aemif->clk)) {
> -		dev_err(dev, "cannot get clock 'aemif'\n");
> -		return PTR_ERR(aemif->clk);
> -	}
> +	if (IS_ERR(aemif->clk))
> +		return dev_err_probe(dev, PTR_ERR(aemif->clk), "cannot get clock 'aemif'\n");
Bit of a long line, so maybe wrap.  Up to maintainers

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
>  	ret = clk_prepare_enable(aemif->clk);
>  	if (ret)
> 



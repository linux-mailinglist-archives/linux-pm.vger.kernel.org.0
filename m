Return-Path: <linux-pm+bounces-12953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF9960779
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858641F22F62
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953219DFB3;
	Tue, 27 Aug 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eHwo8Ude"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564A17BEA1;
	Tue, 27 Aug 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754653; cv=none; b=TyqvN26jWWR2xWTCGfc2wNTEtx3+w5MZjkMtBnXdCpuAmFY6QBYUI+uKZLh0b4dBwHjsqv74ilVf033t0ZF8QXmsNLNHzmEliYt5Kxn5WVcDU2XJqrCLRZg+7wMIl35fVSd5KBjQGq7pQRT2uxpcq28DZbMnHrG7OEO5hHIhDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754653; c=relaxed/simple;
	bh=l9izztVExtAUrD6YpzmSThcoQLAFPh5B9SUAyjBtIXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t15Ag7Uk62KtgQSZbbJ8sTaFNo6CgfR0z0dUB6XoqyY6yY1OTckU6NcxVSX8j2qIQOEhTwXDjXmk7LV4M9NyaFMwl5klTqJLU2fYoHrMQgChIA7A+BlNPZngNAKfjs8zxa+vvdgdKB3Ct+4MaED7c347FvR4CMKXEeFjaB2joLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eHwo8Ude; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724754652; x=1756290652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l9izztVExtAUrD6YpzmSThcoQLAFPh5B9SUAyjBtIXw=;
  b=eHwo8Udez1hdAQtmOKJAEevW4dnfPBSlJlvtQ3Pf1KUnWy40yt+ho++8
   KnjVNXgBWda5QX3mzKyI3GWHyUvfrnY//UefY40XE7Qeb7pQQ4AIrqjZJ
   NJr6B3mP2EB4gHIm3OEyTGev4k4dJKlC4b1fMjcRDNByaB+9+UD78rO+d
   Q+7r1RhyhZz4ruXqIfzDeZQPXvN8MipaAcMidITYdCdcQNKXOwvyhx52Y
   eRSgd67tQBlzCTZUTVY6J/D0ycBEPzyvUkvC7VwW0U47WIxgupPt/eT8c
   r+93VdRlU/pRxEeK9BCS6HtO0dVhEJalJD2NcRdxG183eYmNxcCVbOwDy
   Q==;
X-CSE-ConnectionGUID: nmYP+ln5QmKnTOldkUy+bQ==
X-CSE-MsgGUID: t266nJc+TxiW+F+ZHE4JWg==
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="30945822"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 03:30:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Aug 2024 03:30:14 -0700
Received: from [10.159.224.217] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Aug 2024 03:30:11 -0700
Message-ID: <18f714f9-1369-4029-b036-3c176377374e@microchip.com>
Date: Tue, 27 Aug 2024 12:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] memory: atmel-ebi: simplify with scoped for each
 OF child loop
Content-Language: en-US, fr-FR
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof Kozlowski
	<krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, Lukasz Luba <lukasz.luba@arm.com>, Alim
 Akhtar <alim.akhtar@samsung.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <20240816-cleanup-h-of-node-put-memory-v2-2-9eed0ee16b78@linaro.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-2-9eed0ee16b78@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 at 12:54, Krzysztof Kozlowski wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks!
Regards,
   Nicolas

> ---
>   drivers/memory/atmel-ebi.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index 8f5b3302ee30..8db970da9af9 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -518,7 +518,7 @@ static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
>   static int atmel_ebi_probe(struct platform_device *pdev)
>   {
>          struct device *dev = &pdev->dev;
> -       struct device_node *child, *np = dev->of_node;
> +       struct device_node *np = dev->of_node;
>          struct atmel_ebi *ebi;
>          int ret, reg_cells;
>          struct clk *clk;
> @@ -592,7 +592,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
> 
>          reg_cells += val;
> 
> -       for_each_available_child_of_node(np, child) {
> +       for_each_available_child_of_node_scoped(np, child) {
>                  if (!of_property_present(child, "reg"))
>                          continue;
> 
> @@ -602,10 +602,8 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>                                  child);
> 
>                          ret = atmel_ebi_dev_disable(ebi, child);
> -                       if (ret) {
> -                               of_node_put(child);
> +                       if (ret)
>                                  return ret;
> -                       }
>                  }
>          }
> 
> 
> --
> 2.43.0
> 



Return-Path: <linux-pm+bounces-12954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B075896078F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62599283A43
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ABA19DFB3;
	Tue, 27 Aug 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QeIhBcnX"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D919D896;
	Tue, 27 Aug 2024 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754927; cv=none; b=MkP915Jui9iTuevYi+wGJYTywOkkDWh0E8RaxKdrcVbzaK+kSpa4PGqjGWSsapRWs+56mkXg4KEEBgwHxUBthF3FYLUej6kO2qXTio1bNgKQ1Zdv2zMNlcYCJWdlbWgts9XW5mFneweGiNmvBu+3Kv3Wao49UmQfuyyY0OC+9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754927; c=relaxed/simple;
	bh=pZPXWcOy01lpuwGBdeqJDgo45WVXSPUvzk8hasW6cAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H7oS8f9R1olBO8kmupZ+oL8si9jyI3jckxwxrrb+qIZWMzKjb2jtfLoc5bqDgODx0kUUQVmuPZxu4tP0U+e7NzV5ds+se/nPMjmwsEeWP2WRAxtIETSVssOIoyTf0aybPI3XnbvTzS7tS53mC3FfBUnFUX86JFWRU4B+sEgS6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QeIhBcnX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724754926; x=1756290926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pZPXWcOy01lpuwGBdeqJDgo45WVXSPUvzk8hasW6cAA=;
  b=QeIhBcnXiahd/CtrgJuNLfPHWHmbsSl/DrXp1sLlpg8mESd/thEzZmmh
   Wgo+kP2XgYlzTmyXbuwZbPdGKZTcCKgBDkwG2ExCMjNF8Pq5I53zYfWZT
   am5/5nOGKNuW80HUVOKGbrlceqJPTvOXgV3JPP1WD/32jfJ21xyaGvG1r
   bHcFclIfkQ1hBlEeB4Sxb/e+6Be7mBA3/SVRZ9qtok3wYRoBqqvDppXJv
   Eiu33SHWryGtS0DtsyIFx9yxXaGeMwE2PKMn6OeZIPyv+jt2KJh3Mi79M
   zTOoCUk2JB0UNO2npC2fE348QRsWrmmThAm7bbBU8D0Sv0XMZ5dGhZDYZ
   Q==;
X-CSE-ConnectionGUID: R2qFGaLOSkOwtUni+ImZrQ==
X-CSE-MsgGUID: nXp9GURrQrquSXTIux4rPw==
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="261882356"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 03:35:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Aug 2024 03:34:42 -0700
Received: from [10.159.224.217] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Aug 2024 03:34:45 -0700
Message-ID: <323aa755-8684-4de0-9582-df8449eeb124@microchip.com>
Date: Tue, 27 Aug 2024 12:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] memory: atmel-ebi: use scoped device node
 handling to simplify error paths
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
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <20240816-cleanup-h-of-node-put-memory-v2-1-9eed0ee16b78@linaro.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-1-9eed0ee16b78@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 at 12:54, Krzysztof Kozlowski wrote:
> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Best regards,
   Nicolas

> 
> ---
> 
> Changes in v2:
> 1. Wrap line before of_parse_phandle()
> ---
>   drivers/memory/atmel-ebi.c | 29 ++++++++++-------------------
>   1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index e8bb5f37f5cb..8f5b3302ee30 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -6,6 +6,7 @@
>    * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>    */
> 
> +#include <linux/cleanup.h>
>   #include <linux/clk.h>
>   #include <linux/io.h>
>   #include <linux/mfd/syscon.h>
> @@ -517,7 +518,7 @@ static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
>   static int atmel_ebi_probe(struct platform_device *pdev)
>   {
>          struct device *dev = &pdev->dev;
> -       struct device_node *child, *np = dev->of_node, *smc_np;
> +       struct device_node *child, *np = dev->of_node;
>          struct atmel_ebi *ebi;
>          int ret, reg_cells;
>          struct clk *clk;
> @@ -541,30 +542,24 @@ static int atmel_ebi_probe(struct platform_device *pdev)
> 
>          ebi->clk = clk;
> 
> -       smc_np = of_parse_phandle(dev->of_node, "atmel,smc", 0);
> +       struct device_node *smc_np __free(device_node) =
> +               of_parse_phandle(dev->of_node, "atmel,smc", 0);
> 
>          ebi->smc.regmap = syscon_node_to_regmap(smc_np);
> -       if (IS_ERR(ebi->smc.regmap)) {
> -               ret = PTR_ERR(ebi->smc.regmap);
> -               goto put_node;
> -       }
> +       if (IS_ERR(ebi->smc.regmap))
> +               return PTR_ERR(ebi->smc.regmap);
> 
>          ebi->smc.layout = atmel_hsmc_get_reg_layout(smc_np);
> -       if (IS_ERR(ebi->smc.layout)) {
> -               ret = PTR_ERR(ebi->smc.layout);
> -               goto put_node;
> -       }
> +       if (IS_ERR(ebi->smc.layout))
> +               return PTR_ERR(ebi->smc.layout);
> 
>          ebi->smc.clk = of_clk_get(smc_np, 0);
>          if (IS_ERR(ebi->smc.clk)) {
> -               if (PTR_ERR(ebi->smc.clk) != -ENOENT) {
> -                       ret = PTR_ERR(ebi->smc.clk);
> -                       goto put_node;
> -               }
> +               if (PTR_ERR(ebi->smc.clk) != -ENOENT)
> +                       return PTR_ERR(ebi->smc.clk);
> 
>                  ebi->smc.clk = NULL;
>          }
> -       of_node_put(smc_np);
>          ret = clk_prepare_enable(ebi->smc.clk);
>          if (ret)
>                  return ret;
> @@ -615,10 +610,6 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>          }
> 
>          return of_platform_populate(np, NULL, NULL, dev);
> -
> -put_node:
> -       of_node_put(smc_np);
> -       return ret;
>   }
> 
>   static __maybe_unused int atmel_ebi_resume(struct device *dev)
> 
> --
> 2.43.0
> 



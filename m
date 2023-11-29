Return-Path: <linux-pm+bounces-486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6E7FD87D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0111628278F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3D208C1;
	Wed, 29 Nov 2023 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1BHHaUu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF8F4;
	Wed, 29 Nov 2023 05:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701265450; x=1732801450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MPlGQDXLTd4g2qaz2Drg99hpErHK5vbwa9rvZksvgm8=;
  b=1BHHaUu4ym6c1Tm86FCZouFQlRCORCVjZFtA41Rcjz9349znlv9tbs69
   yyuXRHQVXM2OXHiEcGGM5A1RTKAlNdFWZiYdHuqMRGsO4HIhtdd9NuvDa
   9f0k3sH9+tLRT3xXI4fCgFgmFzCr1X0xNe5WF4w1xDaKTCs7dfW8FfQop
   fH9B3CIszvVe3mlv4Qba88ZrHUXOV966E7sltGrpxp43xDnUl1GC5vcxR
   kLV0LwZORITzlJ8hQWnMvoelKAzf4WqbUPuOWcwMuMiovav1KnYvH43/D
   VyFIi6tnP+x3KORbM9fyuymKcAhbBdMWFzJp2D4NG1F1RcxIRVrQZk5fS
   A==;
X-CSE-ConnectionGUID: 508zqXykQuqczyZSlLqfIA==
X-CSE-MsgGUID: MRF+HdceSYyZw6F0mq3Sjw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="13257623"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 06:44:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Nov 2023 06:43:50 -0700
Received: from [10.171.248.81] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Nov 2023 06:43:48 -0700
Message-ID: <b1b6e759-95ab-4150-a812-a0f0628b6f71@microchip.com>
Date: Wed, 29 Nov 2023 14:43:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [power/reset] at91-sama5d2: Add error handling in
 at91_shdwc_probe
Content-Language: en-US, fr-FR
To: Haoran Liu <liuhaoran14@163.com>, <claudiu.beznea@tuxon.dev>
CC: <sre@kernel.org>, <alexandre.belloni@bootlin.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20231129132939.34047-1-liuhaoran14@163.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231129132939.34047-1-liuhaoran14@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2023 at 14:29, Haoran Liu wrote:
> This patch adds error handling to the at91_shdwc_probe function
> in drivers/power/reset/at91-sama5d2_shdwc.c. The function

As the platforms are DT only and that this driver was instantiated 
precisely because a "match" existed, I don't think this error handling 
is needed because it cannot happen.

> previously did not handle the case where of_match_node could fail,
> potentially leading to unexpected behavior if the device tree match
> was unsuccessful.

You didn't say how you reached this "unexpected behavior": is it a real 
case (I'm interested in the boot log then) or found running a static 
analysis tool?

For now, it's a NACK, sorry. Best regards,
   Nicolas

> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>   drivers/power/reset/at91-sama5d2_shdwc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index e76b102b57b1..2ac566c83aec 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -353,6 +353,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
>                  return PTR_ERR(at91_shdwc->shdwc_base);
> 
>          match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
> +       if (!match) {
> +               dev_err(&pdev->dev, "No matching device found\n");
> +               return -ENODEV;
> +       }
> +
>          at91_shdwc->rcfg = match->data;
> 
>          at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
> --
> 2.17.1
> 



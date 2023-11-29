Return-Path: <linux-pm+bounces-519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB47FDE20
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0313DB20E60
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD603D0D6;
	Wed, 29 Nov 2023 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i4pse/XM"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3DFBC;
	Wed, 29 Nov 2023 09:15:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C662E0004;
	Wed, 29 Nov 2023 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701278156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fi6pfw/YrdlpRPQlqpuxTgYt0q8n78JWGSCcDcbp5EI=;
	b=i4pse/XMReNnftJ2DWqBLM7jpvYxZPwRWmWUEakFhPmk2HCamL/ds+2m58H3Ce/FcdkE+f
	S+20MoxlcdoyCAIf6H1l6po+cFGyUk/3AOpPXeLp4PPTay1ItCwJ9O0H1SA5KJ7WUl5isz
	21iBx0ds/o/eeE2p2AX9bKDkREHNqrbHXhmKfEgcs+3MdPFfxHCHYneAAX8kFuikjYjhxA
	Mo2YrbnP/BnbOxS9xf41dmjT3mDAwRmeI8CG7DT+Dt2sJcTpJV0Kw/r/We9vnPGLKlXdmt
	x6ZWVhtk0y8ydlfh9qUfIYLqU/enO6Nw/n3iD3xVle2Md8ZJIWq2oyiuH0anig==
Date: Wed, 29 Nov 2023 18:15:55 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Haoran Liu <liuhaoran14@163.com>
Cc: claudiu.beznea@tuxon.dev, sre@kernel.org, nicolas.ferre@microchip.com,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [power/reset] at91-sama5d2: Add error handling in
 at91_shdwc_probe
Message-ID: <20231129171555abae472b@mail.local>
References: <20231129132939.34047-1-liuhaoran14@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129132939.34047-1-liuhaoran14@163.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 29/11/2023 05:29:39-0800, Haoran Liu wrote:
> This patch adds error handling to the at91_shdwc_probe function
> in drivers/power/reset/at91-sama5d2_shdwc.c. The function
> previously did not handle the case where of_match_node could fail,
> potentially leading to unexpected behavior if the device tree match
> was unsuccessful.
> 
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index e76b102b57b1..2ac566c83aec 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -353,6 +353,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
>  		return PTR_ERR(at91_shdwc->shdwc_base);
>  
>  	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
> +	if (!match) {

Can you elaborate how this will ever happen?

> +		dev_err(&pdev->dev, "No matching device found\n");
> +		return -ENODEV;
> +	}
> +
>  	at91_shdwc->rcfg = match->data;
>  
>  	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-pm+bounces-24701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32BA77B5D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6523AEEB8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197F2036ED;
	Tue,  1 Apr 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UDI7LhQZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710462036E1
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511959; cv=none; b=JCApBUsEGU24+cWtLn5qq6Se8D/1HPH3ISp4eiGyB0hq5eEM5ybPkVy7tvXRDmNlGbYIkxXx7pHLxgM0LpxE7xRlPv12wNhOl4ZhOEY0liFnyByBQOFP7FOsTcSWWJgmkGg3+YMmaV8l9q+aovEvlLCnc1GmHbK1dbDuUP0jezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511959; c=relaxed/simple;
	bh=/To2QMK9osYpOZIEVtBmmtVVu15jo2nNA5nI60R+u+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3BDbVV0pN9w0vesNcYWEFAc0W5Jah6bMxwN3etyJFBhDdaKavaPGSkCR2kei9CWGBLOBptQbc2Zyhmw21N6b4O9hnA/MKEzOaiJaaQ+TcDh8bHOtIc1JRGghpFdtmx/RFRTgZfE//HEgVMpldVrpsmLyzgiVBmugIo5cJH4RVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UDI7LhQZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D8EA432F4;
	Tue,  1 Apr 2025 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743511955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13l0CQ3+3TzvDqW7m4TraU+Cgtn0HfSr7CCd6UAQKZ0=;
	b=UDI7LhQZ+tJ+0o6GeS961IKKKeGGFGJM2DEzGa9X2364roIpqkd+r3dHF3y3Q/jHYBBHCl
	Y9YqUdCnAT6ojpr0JnyniGw/iqelMjkYQ73y7Ai1hHhsmsWHlsejUAATyF3x9tA7feR26T
	PrVagGT40ZVWkc816gs5CLNOQWdoq2+Qhu/ZTwRcYpKWPY2+aBWDOaWuHFX4DFW2bF7uHZ
	1DFFn4abfJuh4fwjKZdUba+PT3D83ARtGyWMSCryM45DaG+0Rw3POWdtcltSYDdfTHyp1n
	G0gmmHRYXZQT8YdA/dlhhuJS1+KalrOkwukeBCgHyk6ieOPmvgsVkBJpNJtZqg==
Date: Tue, 1 Apr 2025 14:52:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] power: reset: at91-reset: Optimize at91_reset()
Message-ID: <20250401125235b4f44db6@mail.local>
References: <20250307053809.20245-1-eagle.alexander923@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307053809.20245-1-eagle.alexander923@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiudeuteehhfekgeejveefhfeiudejuefhgfeljefgjeegkeeujeeugfehgefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemvdgrtgejmehfvgegvgemheeirggumegtkegvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemvdgrtgejmehfvgegvgemheeirggumegtkegvgedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopegvrghglhgvrdgrlhgvgigrnhguvghrledvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehsrhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghv
X-GND-Sasl: alexandre.belloni@bootlin.com

On 07/03/2025 08:38:09+0300, Alexander Shiyan wrote:
> This patch adds a small optimization to the low-level at91_reset()
> function, which includes:
> - Removes the extra branch, since the following store operations
>   already have proper condition checks.
> - Removes the definition of the clobber register r4, since it is
>   no longer used in the code.
> 
> Fixes: fcd0532fac2a ("power: reset: at91-reset: make at91sam9g45_restart() generic")
> Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/power/reset/at91-reset.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 036b18a1f90f..511f5a8f8961 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -129,12 +129,11 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
>  		"	str	%4, [%0, %6]\n\t"
>  		/* Disable SDRAM1 accesses */
>  		"1:	tst	%1, #0\n\t"
> -		"	beq	2f\n\t"
>  		"	strne	%3, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
>  		/* Power down SDRAM1 */
>  		"	strne	%4, [%1, %6]\n\t"
>  		/* Reset CPU */
> -		"2:	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
> +		"	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
>  
>  		"	b	.\n\t"
>  		:
> @@ -145,7 +144,7 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
>  		  "r" (reset->data->reset_args),
>  		  "r" (reset->ramc_lpr)
> -		: "r4");
> +	);
>  
>  	return NOTIFY_DONE;
>  }
> -- 
> 2.39.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


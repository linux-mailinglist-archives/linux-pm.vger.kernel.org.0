Return-Path: <linux-pm+bounces-36910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C376AC0DA9B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8401F426F5C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9530F7E9;
	Mon, 27 Oct 2025 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kXq9dojZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6EF30E0FC;
	Mon, 27 Oct 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568715; cv=none; b=Zhlx44KTvPJJLGO+EWEDZH9p1fHkoXHT/1diD01YTwaQQGHFRGGk306v+rGj1igUgEqmw4P+4F194RIlDeDYuofnVjlNbNKuWcRa32xaTah9VJXd63OkGN9wA4B0+GbgZRjxokhVFGEJwupd0pgCqL1YcIY6qXYrXBEjkYnQihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568715; c=relaxed/simple;
	bh=t9hkT+4zAAhz5+o+QG2fo27oXgveTo7i7m6LBWKxhfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrna2hW5QJ4pUN0ePixO6rbux1+jCdbpVSq4EHvnyOBjeYHhwzggc4MomA7YfsLQgmByZxBpgI4gYPwPzJ9pAmCeGBEQhwS6uDu64Dwm4DGBd6cpgpQsA2sFgAoLpYOQ7SZhwrp9jnGJASZ1JNsiSDiG96FdNA+jvBqJ1Clq824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kXq9dojZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2CA211A16B1;
	Mon, 27 Oct 2025 12:38:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2B756062C;
	Mon, 27 Oct 2025 12:38:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49FD9102F24FC;
	Mon, 27 Oct 2025 13:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761568710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LIcovSWKnBA+L7voLcFHvTGbDw/RTZnlp4fA0bZ/QEc=;
	b=kXq9dojZmGm6Ef0a7GVd/BQliyMkvrAcJiCiXAw9LT8hdLsHlV5tISKRqILw5M8Rzfmm1b
	c1C536eyX14TLOfkOG+71IXH8VlV4qjgrpmoU8J1GbXUDjk+LN5PDq47kWgLfOZfj3shPw
	Uu/iiMcrr4GsRAIbG7C/VEiFAwxi5URrh/XciNr1PEYjufdGC+gBqrRVPPCPDYKW0UUE+Y
	sRf8GjhF7ceb/UsmPTgY1lKovKdb3qutucuN0MSxBcyBG5/JYXaGo/pglf2QW1+mliuzJq
	OtDAUk/qiv+3XpIKnXAQ0DVrZWEMG7VAwFCaw3hMY+0pbsarUiCIQGyS9xVxwA==
Date: Mon, 27 Oct 2025 13:38:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 12/15] rtc: bd70528: Support BD72720 rtc
Message-ID: <202510271238195ef3bdfb@mail.local>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <380ea1fdbb94a796418e8f463c6a9436001d572d.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380ea1fdbb94a796418e8f463c6a9436001d572d.1761564043.git.mazziesaccount@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 27/10/2025 13:47:51+0200, Matti Vaittinen wrote:
> The BD72720 has similar RTC block as a few other ROHM PMICs.
> 
> Add support for BD72720 RTC.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Note that we didn't get 07/15 that adds linux/mfd/rohm-bd72720.h which
this patch depends on.

> ---
> Revision history:
>  RFCv1 =>:
>  - No changes
> ---
>  drivers/rtc/Kconfig       |  3 ++-
>  drivers/rtc/rtc-bd70528.c | 21 ++++++++++++++-------
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 2933c41c77c8..418f6c28847a 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -561,7 +561,8 @@ config RTC_DRV_BD70528
>  	depends on MFD_ROHM_BD71828
>  	help
>  	  If you say Y here you will get support for the RTC
> -	  block on ROHM BD71815 and BD71828 Power Management IC.
> +	  block on ROHM BD71815, BD71828 and BD72720 Power
> +	  Management ICs.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-bd70528.
> diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
> index 954ac4ef53e8..4c8599761b2e 100644
> --- a/drivers/rtc/rtc-bd70528.c
> +++ b/drivers/rtc/rtc-bd70528.c
> @@ -7,6 +7,7 @@
>  #include <linux/bcd.h>
>  #include <linux/mfd/rohm-bd71815.h>
>  #include <linux/mfd/rohm-bd71828.h>
> +#include <linux/mfd/rohm-bd72720.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -262,13 +263,13 @@ static int bd70528_probe(struct platform_device *pdev)
>  
>  		/*
>  		 * See also BD718XX_ALM_EN_OFFSET:
> -		 * This works for BD71828 and BD71815 as they have same offset
> -		 * between ALM0 start and ALM0_MASK. If new ICs are to be
> -		 * added this requires proper check as ALM0_MASK is not located
> -		 * at the end of ALM0 block - but after all ALM blocks so if
> -		 * amount of ALMs differ the offset to enable/disable is likely
> -		 * to be incorrect and enable/disable must be given as own
> -		 * reg address here.
> +		 * This works for BD71828, BD71815, and BD72720 as they all
> +		 * have same offset between the ALM0 start and the ALM0_MASK.
> +		 * If new ICs are to be added this requires proper check as
> +		 * the  ALM0_MASK is not located at the end of ALM0 block -
> +		 * but after all ALM blocks. If amount of ALMs differ, the
> +		 * offset to enable/disable is likely to be incorrect and
> +		 * enable/disable must be given as own reg address here.
>  		 */
>  		bd_rtc->bd718xx_alm_block_start = BD71815_REG_RTC_ALM_START;
>  		hour_reg = BD71815_REG_HOUR;
> @@ -278,6 +279,11 @@ static int bd70528_probe(struct platform_device *pdev)
>  		bd_rtc->bd718xx_alm_block_start = BD71828_REG_RTC_ALM_START;
>  		hour_reg = BD71828_REG_RTC_HOUR;
>  		break;
> +	case ROHM_CHIP_TYPE_BD72720:
> +		bd_rtc->reg_time_start = BD72720_REG_RTC_START;
> +		bd_rtc->bd718xx_alm_block_start = BD72720_REG_RTC_ALM_START;
> +		hour_reg = BD72720_REG_RTC_HOUR;
> +		break;
>  	default:
>  		dev_err(&pdev->dev, "Unknown chip\n");
>  		return -ENOENT;
> @@ -337,6 +343,7 @@ static int bd70528_probe(struct platform_device *pdev)
>  static const struct platform_device_id bd718x7_rtc_id[] = {
>  	{ "bd71828-rtc", ROHM_CHIP_TYPE_BD71828 },
>  	{ "bd71815-rtc", ROHM_CHIP_TYPE_BD71815 },
> +	{ "bd72720-rtc", ROHM_CHIP_TYPE_BD72720 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, bd718x7_rtc_id);
> -- 
> 2.51.0
> 



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


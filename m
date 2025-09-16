Return-Path: <linux-pm+bounces-34709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8410B5910C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F8522C12
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90128000F;
	Tue, 16 Sep 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgQl69UE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D0199939;
	Tue, 16 Sep 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012208; cv=none; b=OXm2uB7Q0Hlvo4aQlTjg0s0OFIaryj5iVH96tT3QgdZ/Tdh3AUjV9Q4Bqjr5UjGwZ8bFw2zm1DvbOF8gncFRKPhhX/0Ryy3BXt8fBVCLWvWZy7D2Q5VZ0az1Bcv6Pmmeqald+rfdGbV2mmUU8qVvNxV3/cyki91An1mdzS6fE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012208; c=relaxed/simple;
	bh=UT9Y547qxU148/h+9nigpRNINW+rzTYKRz1weK+iQ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LafbG3mtv5JkiPVb5pZcYRPaAVHC4KNvUetjV1kmyP1992ib0NjtT7672SkOHf4wBg9prDD6zWdXk+BZD0xBBsuQG9p4kQLrHM+IBPQuM07HrYIhn+PSqfoa/yHJ5OkxstKE3Yx4Zs1dzI+wNiy1jhy7eh1yqRnif0HfMG8eY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgQl69UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBF0C4CEEB;
	Tue, 16 Sep 2025 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758012208;
	bh=UT9Y547qxU148/h+9nigpRNINW+rzTYKRz1weK+iQ4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgQl69UE/EnaEsBt3QJybqQJ7BUyqhyru9vtJ6qVAlyyUwFwhpAECVPzm7ByZoOOq
	 M8L/pmqmYV+/PJ2S9iZQDNBerdDbaQ+VZYu0g6q60y5GwqvBIKouDN7dOCWeEju5W6
	 x94WZ9iojLw6ioFhxx5dwHYkDSTG3AU5GwoS0/bMlINyykkA3JcLLdtpPZZu52Wx3i
	 XCbPZskbYHLKYEi3lV+dOGf8rOwrePctBjBjeAYrZR2Am9Lz315KAXahowvAUMCcnE
	 xdWQadTsZvCyc5mZr3qqK4wvepJE+dXvXAsfCbkgkjnMpn9XHbGQ8+930T/VDKkIvz
	 r0msymbebcYAg==
Date: Tue, 16 Sep 2025 09:43:23 +0100
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/9] power: supply: max77705_charger: move active
 discharge setting to mfd parent
Message-ID: <20250916084323.GH1637058@google.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
 <20250911-max77705_77976_charger_improvement-v3-1-35203686fa29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-1-35203686fa29@gmail.com>

On Thu, 11 Sep 2025, Dzmitry Sankouski wrote:

> Active discharge setting is a part of MFD top level i2c device, hence
> cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
> register from charger driver is a mistake.
> 
> Move active discharge setting to MFD parent driver.
> 
> Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  drivers/mfd/max77705.c                  | 3 +++
>  drivers/power/supply/max77705_charger.c | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> index 6b263bacb8c2..ff07d0e0d5f8 100644
> --- a/drivers/mfd/max77705.c
> +++ b/drivers/mfd/max77705.c
> @@ -108,6 +108,9 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
>  	if (pmic_rev != MAX77705_PASS3)
>  		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
>  
> +	/* Active Discharge Enable */
> +	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
> +
>  	ret = devm_regmap_add_irq_chip(dev, max77705->regmap,
>  					i2c->irq,
>  					IRQF_ONESHOT | IRQF_SHARED, 0,
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
> index 329b430d0e50..3b75c82b9b9e 100644
> --- a/drivers/power/supply/max77705_charger.c
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -487,9 +487,6 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
>  	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
>  				MAX77705_WDTEN_MASK, 0);
>  
> -	/* Active Discharge Enable */
> -	regmap_update_bits(regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
> -
>  	/* VBYPSET=5.0V */
>  	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_MASK, 0);
>  
> 
> -- 
> 2.39.5
> 

-- 
Lee Jones [李琼斯]


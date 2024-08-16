Return-Path: <linux-pm+bounces-12333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA5F95463F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499FE1F21ED0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FF16BE09;
	Fri, 16 Aug 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDeVTwPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00212D773;
	Fri, 16 Aug 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802104; cv=none; b=euO+RiUgNiXvPK/IoM9WviWz1U3Xvrarao6v03dthM/yLlFuN7Ldh6zbImL0F4mSjUr1NDbiS4rPpYQ5K4LCmNjihlRBr+dJHHXSmUaWuzMjjejCHqwhDN6bG1oG+xg9LGabzNxIKpGDZg5Rq0qvQ3gJoGdNoHbr4u5W9K0Wahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802104; c=relaxed/simple;
	bh=txY5dNdKYsNGue+2BgJYSuFeOKBcHe3KJqufST9Oka0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQnHi5GJQPkaEjfx6JyK7hMAr7/qf41Xyg4ABQBYS+2PLqK7Sgs44hcq+XoxxoS0me+dm5lN4Jh+PwLYAzrh/lo5V2Fn9e9hb29EFd4627agtUycIvC3ALgNCPmbXi5UrqkoMok+hQVEuNuRaWlMnEOArgPrh2wNpPoguHIMytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDeVTwPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7375FC32782;
	Fri, 16 Aug 2024 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723802104;
	bh=txY5dNdKYsNGue+2BgJYSuFeOKBcHe3KJqufST9Oka0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IDeVTwPbZtmiuiJ80+XJqk2v7JCUMtxD85nW3NG7xQHDj0MVzOZQwOGpLMnB3SoQp
	 rtNqiU0qM9iuzy5I9Dcd0cIOvpTL/pC7mO+o3KU3vfcnaWvfjcuD1c3r7JKE7Ds3Tq
	 wdiN+q74Usy0lBMPSk3IEEdUCAOZr4P3xQAvbkQf/BMcJaDPQwlXQobs9iqlLsCOic
	 qbH5DmVK++kk+3vEbpGHiRXbsGoNpzR8rkayLR1vClkorkLxc49t2kMeIWq2ccpPLJ
	 5jVqzhEXL9mJMGGVJ4ywgq+o6+ged8CwnYphI18Q8WzTJ6MpDweKNbYJagtgC7ihIw
	 Fk9xIgjaYwzUg==
Message-ID: <9dbaacdb-5f9c-48d4-a56a-a19ca8809344@kernel.org>
Date: Fri, 16 Aug 2024 11:54:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] power: supply: max77693: Set charge current
 limits during init
To: Artur Weber <aweber.kernel@gmail.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
 <20240816-max77693-charger-extcon-v4-4-050a0a9bfea0@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240816-max77693-charger-extcon-v4-4-050a0a9bfea0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 10:19, Artur Weber wrote:
> There are two charger current limit registers:
> 
> - Fast charge current limit (which controls current going from the
>   charger to the battery);
> - CHGIN input current limit (which controls current going into the
>   charger through the cable).
> 
> Add functions for setting both of the values, and set them to a
> safe default value of 500mA at initialization.
> 
> The value for the fast charge current limit can be modified by setting
> the constant-charge-current-max-ua DT property of the battery node
> specified in the monitored-battery charger DT property; the CHGIN input
> current limit will be set up later in the charger detection mechanism
> (in the future, the INPUT_CURRENT_LIMIT property could also be made
> writeable for userspace control of the current limit, while keeping
> the actual current limit from the charger to the battery intact
> so that users don't accidentally blow up their batteries with a bad
> value).
> 
> Acked-by: Lee Jones <lee@kernel.org>
> Tested-by: Henrik Grimler <henrik@grimler.se>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v3:
> - Dropped CHARGER reg in favor of managing the registers directly
> 
> Changes in v2:
> - Squashed mfd include register additions into this commit
> - Changed from custom fast charge current property to monitored-battery
>   (devm_power_supply_register call has been moved up as it is needed by
>   the DT init function now)
> - Changed to adapt to both current limit values being managed by the
>   CHARGER regulator
> ---
>  drivers/power/supply/max77693_charger.c | 82 ++++++++++++++++++++++++++++-----
>  include/linux/mfd/max77693-private.h    |  2 +
>  2 files changed, 73 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
> index 4caac142c428..17975ec69a6a 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -26,6 +26,7 @@ struct max77693_charger {
>  	u32 min_system_volt;
>  	u32 thermal_regulation_temp;
>  	u32 batttery_overcurrent;
> +	u32 fast_charge_current;
>  	u32 charge_input_threshold_volt;
>  };
>  
> @@ -596,6 +597,48 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
>  			CHG_CNFG_12_B2SOVRC_MASK, data);
>  }
>  
> +static int max77693_set_input_current_limit(struct max77693_charger *chg,
> +		unsigned int uamp)
> +{
> +	unsigned int data;
> +
> +	if (uamp < 60000 || uamp > 2540000) {
> +		dev_err(chg->dev, "Wrong value for input current limit");
> +		return -EINVAL;
> +	};
> +
> +	data = uamp / 20000; /* 20mA steps */
> +
> +	data <<= CHG_CNFG_09_CHGIN_ILIM_SHIFT;
> +
> +	dev_dbg(chg->dev, "Input current limit: %u (0x%x)\n", uamp, data);
> +
> +	return regmap_update_bits(chg->max77693->regmap,
> +			MAX77693_CHG_REG_CHG_CNFG_09,
> +			CHG_CNFG_09_CHGIN_ILIM_MASK, data);
> +}
> +
> +static int max77693_set_fast_charge_current(struct max77693_charger *chg,
> +		unsigned int uamp)
> +{
> +	unsigned int data;
> +
> +	if (uamp > 2100000) {
> +		dev_err(chg->dev, "Wrong value for fast charge current\n");
> +		return -EINVAL;
> +	}
> +
> +	data = uamp / 33300; /* 0.1A/3 steps */
> +
> +	data <<= CHG_CNFG_02_CC_SHIFT;
> +
> +	dev_dbg(chg->dev, "Fast charge current: %u (0x%x)\n", uamp, data);
> +
> +	return regmap_update_bits(chg->max77693->regmap,
> +			MAX77693_CHG_REG_CHG_CNFG_02,
> +			CHG_CNFG_02_CC_MASK, data);
> +}
> +
>  static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg,
>  		unsigned int uvolt)
>  {
> @@ -673,6 +716,15 @@ static int max77693_reg_init(struct max77693_charger *chg)
>  	if (ret)
>  		return ret;
>  
> +	ret = max77693_set_fast_charge_current(chg, chg->fast_charge_current);
> +	if (ret)
> +		return ret;
> +
> +	ret = max77693_set_input_current_limit(chg,
> +				DEFAULT_FAST_CHARGE_CURRENT);
> +	if (ret)
> +		return ret;
> +
>  	return max77693_set_charge_input_threshold_volt(chg,
>  			chg->charge_input_threshold_volt);
>  }
> @@ -681,6 +733,7 @@ static int max77693_reg_init(struct max77693_charger *chg)
>  static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  {
>  	struct device_node *np = dev->of_node;
> +	struct power_supply_battery_info *battery_info;
>  
>  	if (!np) {
>  		dev_err(dev, "no charger OF node\n");
> @@ -708,11 +761,20 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  		chg->charge_input_threshold_volt =
>  			DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT;
>  
> +	if (power_supply_get_battery_info(chg->charger, &battery_info) ||
> +			!battery_info->constant_charge_current_max_ua)
> +		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
> +	else
> +		chg->fast_charge_current =
> +			battery_info->constant_charge_current_max_ua;
> +
>  	return 0;
>  }
>  #else /* CONFIG_OF */
>  static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  {
> +	chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
> +
>  	return 0;
>  }
>  #endif /* CONFIG_OF */
> @@ -732,6 +794,15 @@ static int max77693_charger_probe(struct platform_device *pdev)
>  	chg->dev = &pdev->dev;
>  	chg->max77693 = max77693;
>  
> +	psy_cfg.drv_data = chg;
> +
> +	chg->charger = devm_power_supply_register(&pdev->dev,
> +						  &max77693_charger_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->charger))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> +				     "failed: power supply register\n");

This code move is not explained in the commit msg. At least I could not
find it. Please explain why you need it in the commit msg.

BTW, if you are interested in devices using this driver, have time, in
general care about the code and want to respond to patches, feel free to
add yourself to driver's maintainer entry.



Best regards,
Krzysztof



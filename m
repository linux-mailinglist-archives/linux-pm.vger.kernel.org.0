Return-Path: <linux-pm+bounces-11405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3093C692
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD44628383E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1019DF53;
	Thu, 25 Jul 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQbT8Ho/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912519D064;
	Thu, 25 Jul 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921857; cv=none; b=irIDsfns/28bXB44nGPF1N5B1vnz9j/1GPX0OWvt3TdeUFj8lnaHeTQj68TdxUIcqhMe09vViHECeLJjq00Sm06Xzzxv51xo64tcmFUI5tgX3zHD79ScN2SwihmXJEJkU/nbAYb3F2Fy2CcCRFMRnfR/JM0GPK0HUKXHltT9/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921857; c=relaxed/simple;
	bh=qRdsbQkoz6ky3wcoTwNugCdQYEJhYaP1T6fc6WgroS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCcOCPuE2ftIR/ht8w9ZTbzt0yhg6E/0/JqGpZphYeKCDkY3RWrc0I5/kJ1lN66aP9JdwT7ruJLPMM74NGh5Oh7X8+7NCpvK3hZ5RXPmmfimPYFRd+8fvq2nI5d9qYApZPdZ6jSVoXS3k6QOdrNcGBvQ0cWh7p/jSVsY8Jf77VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQbT8Ho/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F252AC116B1;
	Thu, 25 Jul 2024 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921857;
	bh=qRdsbQkoz6ky3wcoTwNugCdQYEJhYaP1T6fc6WgroS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQbT8Ho/8UVivRFD8K2lIdM5ZwbSrA4k/BkJ6NeSH7GU3Fj03qJN3MOY05UZTwn9V
	 EgjeeuyvDB+IKqBeYI9Z1/N7YYzUWVSrd4ml/CBw4zQX7afuuyCIt6IZLZnTavbwXN
	 /hvNorx/4gVEV4akUtIHhtpmlm02nBwrNbPhmu5maohJjq5bFuAtVS/6BZ83Q/jz+n
	 fg5IKBhTkMjzkz3mVZkqaBfsvUcHJhF7tgHo+Myv17C5ONGTzEfCKaGfU2uY/9YI3N
	 BGlUXL4fwIUEIIJUj9/zAcnfzgRnP5ieMBog6dMlMoVftgmiZjKrqT/30wXcaoOLT3
	 my8moQKodEPSA==
Date: Thu, 25 Jul 2024 16:37:30 +0100
From: Lee Jones <lee@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Henrik Grimler <henrik@grimler.se>,
	Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
	Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: Re: [PATCH v2 5/9] power: supply: max77693: Set charge current
 limits during init
Message-ID: <20240725153730.GG501857@google.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
 <20240715-max77693-charger-extcon-v2-5-0838ffbb18c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715-max77693-charger-extcon-v2-5-0838ffbb18c3@gmail.com>

On Mon, 15 Jul 2024, Artur Weber wrote:

> There are two charger current limit registers:
> 
> - Fast charge current limit (which controls current going from the
>   charger to the battery);
> - CHGIN input current limit (which controls current going into the
>   charger through the cable).
> 
> Add a function for setting both of the values, and set them to a
> safe default value of 500mA at initialization.
> 
> The default value for the fast charge current limit can be modified
> by setting the constant-charge-current-max-ua DT property of the
> battery node specified in the monitored-battery charger DT property.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v2:
> - Squashed mfd include register additions into this commit
> - Changed from custom fast charge current property to monitored-battery
>   (devm_power_supply_register call has been moved up as it is needed by
>   the DT init function now)
> - Changed to adapt to both current limit values being managed by the
>   CHARGER regulator
> ---
>  drivers/power/supply/max77693_charger.c | 43 ++++++++++++++++++++++++---------

>  include/linux/mfd/max77693-private.h    |  6 +++++

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
> index 0d53f61d58ba..0ddaa03669a2 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -28,6 +28,7 @@ struct max77693_charger {
>  	u32 min_system_volt;
>  	u32 thermal_regulation_temp;
>  	u32 batttery_overcurrent;
> +	u32 fast_charge_current;
>  	u32 charge_input_threshold_volt;
>  };
>  
> @@ -570,6 +571,14 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
>  			CHG_CNFG_12_B2SOVRC_MASK, data);
>  }
>  
> +static int max77693_set_current_limit(struct max77693_charger *chg,
> +		unsigned int uamp)
> +{
> +	dev_dbg(chg->dev, "Current limit: %u\n", uamp);
> +
> +	return regulator_set_current_limit(chg->regu, (int)uamp, (int)uamp);
> +}
> +
>  static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg,
>  		unsigned int uvolt)
>  {
> @@ -647,6 +656,10 @@ static int max77693_reg_init(struct max77693_charger *chg)
>  	if (ret)
>  		return ret;
>  
> +	ret = max77693_set_current_limit(chg, DEFAULT_FAST_CHARGE_CURRENT);
> +	if (ret)
> +		return ret;
> +
>  	return max77693_set_charge_input_threshold_volt(chg,
>  			chg->charge_input_threshold_volt);
>  }
> @@ -654,6 +667,7 @@ static int max77693_reg_init(struct max77693_charger *chg)
>  #ifdef CONFIG_OF
>  static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  {
> +	struct power_supply_battery_info *battery_info;
>  	struct device_node *np = dev->of_node;
>  
>  	if (!np) {
> @@ -682,11 +696,20 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  		chg->charge_input_threshold_volt =
>  			DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT;
>  
> +	if (power_supply_get_battery_info(chg->charger, &battery_info) ||
> +				!battery_info->constant_charge_current_max_ua)
> +		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
> +	else
> +		chg->fast_charge_current = \
> +				battery_info->constant_charge_current_max_ua;
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
> @@ -712,6 +735,15 @@ static int max77693_charger_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(chg->regu),
>  				     "failed to get charger regulator\n");
>  
> +	psy_cfg.drv_data = chg;
> +
> +	chg->charger = devm_power_supply_register(&pdev->dev,
> +						  &max77693_charger_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->charger))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> +				     "failed: power supply register\n");
> +
>  	ret = max77693_dt_init(&pdev->dev, chg);
>  	if (ret)
>  		return ret;
> @@ -720,8 +752,6 @@ static int max77693_charger_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	psy_cfg.drv_data = chg;
> -
>  	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed: create fast charge timer sysfs entry\n");
> @@ -741,15 +771,6 @@ static int max77693_charger_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	chg->charger = devm_power_supply_register(&pdev->dev,
> -						  &max77693_charger_desc,
> -						  &psy_cfg);
> -	if (IS_ERR(chg->charger)) {
> -		dev_err(&pdev->dev, "failed: power supply register\n");
> -		ret = PTR_ERR(chg->charger);
> -		goto err;
> -	}
> -
>  	return 0;
>  
>  err:
> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
> index 54444ff2a5de..4570646e2f33 100644
> --- a/include/linux/mfd/max77693-private.h
> +++ b/include/linux/mfd/max77693-private.h
> @@ -145,6 +145,8 @@ enum max77693_pmic_reg {
>  #define DEFAULT_THERMAL_REGULATION_TEMP		100
>  /* microamps */
>  #define DEFAULT_BATTERY_OVERCURRENT		3500000
> +/* microamps */
> +#define DEFAULT_FAST_CHARGE_CURRENT		500000
>  /* microvolts */
>  #define DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT	4300000
>  
> @@ -217,6 +219,10 @@ enum max77693_charger_battery_state {
>  #define CHG_CNFG_01_CHGRSTRT_MASK	(0x3 << CHG_CNFG_01_CHGRSTRT_SHIFT)
>  #define CHG_CNFG_01_PQEN_MAKS		BIT(CHG_CNFG_01_PQEN_SHIFT)
>  
> +/* MAX77693_CHG_REG_CHG_CNFG_02 register */
> +#define CHG_CNFG_02_CC_SHIFT		0
> +#define CHG_CNFG_02_CC_MASK		0x3F
> +
>  /* MAX77693_CHG_REG_CHG_CNFG_03 register */
>  #define CHG_CNFG_03_TOITH_SHIFT		0
>  #define CHG_CNFG_03_TOTIME_SHIFT	3
> 
> -- 
> 2.45.2
> 

-- 
Lee Jones [李琼斯]


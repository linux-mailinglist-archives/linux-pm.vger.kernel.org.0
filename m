Return-Path: <linux-pm+bounces-11406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9AA93C69E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E651C21EC9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8B19D890;
	Thu, 25 Jul 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlOI1Y+X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFE19CCEB;
	Thu, 25 Jul 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921943; cv=none; b=kWbzlX+rxnVKQ9ZVMfgaG3Rl2V5uO4O8bvxIH6DCglYklo34gyUS3NXaWj1ANV/nxiyVrRuVMFkQSGNxSsbwMNqXZqR2QI9fiCjW4Ljluo4x6l2mgIEgmD6jMCX0po9dh9qMVHey18WZUBDeUV+m/Y1AWqhwZFxw2CrEXBvlrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921943; c=relaxed/simple;
	bh=ukqdJDYHs+lhevV2NPb6J9PdNC83BV+yVXkKRp1WVmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+baP5kNTRgYR51Mtrf5Rqjuyd6Kiy/qtSH6QMQe2l9eB4eAKM9uJEQGZFT6lHbr1+3VxuOOmRj2/KPxJs9RzQI+UKVRAlmDNED3Wdlr/OA6mxjOxWTUV5Ji4xQjzA3msjgr/EHPdTnAtEtWEYQKMN23YVfAWugCVcH/3qaMucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlOI1Y+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD32C116B1;
	Thu, 25 Jul 2024 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921942;
	bh=ukqdJDYHs+lhevV2NPb6J9PdNC83BV+yVXkKRp1WVmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlOI1Y+XWS/tHgYIuzARRnvk2G6NqDAIBb7u7K1xl4Wy6PhQ3ABoAe9qsQfG8FIN0
	 yaSGVJwMxfCKlJJ7J+Llx8hhzNtGteeN5QWQksirYozKj6Vl8EAuUzxrYxoDgyNMTw
	 nhsDvnbtxE+4gt+fR/gZ1TbvkSz6TZ/0PG0GAAEuuy45cB21wc/q/Hm2MzGx2kFeXj
	 9uOiUAUqAtcEEuXeUcLiAvTM8U7Ag/LkxWzb2+xhKXd2BJm1Dppv8NwnFJRDDGqcEL
	 WEVSQy6R8uKySfD5Y389XDg5Xl7yvv5PdhOx7g3nYQSjRhfNS5LQJbISG2EbKNGwvv
	 /IW1M0UW85PVQ==
Date: Thu, 25 Jul 2024 16:38:56 +0100
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
Subject: Re: [PATCH v2 7/9] power: supply: max77693: Add support for
 detecting and enabling OTG
Message-ID: <20240725153856.GH501857@google.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
 <20240715-max77693-charger-extcon-v2-7-0838ffbb18c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715-max77693-charger-extcon-v2-7-0838ffbb18c3@gmail.com>

On Mon, 15 Jul 2024, Artur Weber wrote:

> Building upon the newly added extcon detection support, add detection
> for USB OTG cables (EXTCON_USB_HOST type), and enable/disable the OTG
> bits as needed.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v2:
> - Added CHGIN OTG current limit value
> - Squashed MFD header register changes into this commit
> ---
>  drivers/power/supply/max77693_charger.c | 103 +++++++++++++++++++++++++++-----

>  include/linux/mfd/max77693-private.h    |   5 ++

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
> index 2dc273dd96ee..34d68b1050d4 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -669,6 +669,16 @@ static int max77693_reg_init(struct max77693_charger *chg)
>  	if (ret)
>  		return ret;
>  
> +	/* Set OTG current limit to 900 mA */
> +	data = (0x1 << CHG_CNFG_02_OTG_ILIM_SHIFT);
> +	ret = regmap_update_bits(chg->max77693->regmap,
> +				MAX77693_CHG_REG_CHG_CNFG_02,
> +				CHG_CNFG_02_OTG_ILIM_MASK, data);
> +	if (ret) {
> +		dev_err(chg->dev, "Error setting OTG current limit: %d\n", ret);
> +		return ret;
> +	}
> +
>  	return max77693_set_charge_input_threshold_volt(chg,
>  			chg->charge_input_threshold_volt);
>  }
> @@ -690,11 +700,42 @@ static int max77693_set_charging(struct max77693_charger *chg, bool enable)
>  	return ret;
>  }
>  
> +static int max77693_set_otg(struct max77693_charger *chg, bool enable)
> +{
> +	struct regmap *regmap = chg->max77693->regmap;
> +	unsigned int data;
> +	bool is_enabled;
> +	int ret;
> +
> +	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_00, &data);
> +	if (ret)
> +		return ret;
> +
> +	is_enabled = !!(data & CHG_CNFG_00_OTG_MASK);
> +
> +	if (enable && !is_enabled) {
> +		/* OTG on, boost on, DIS_MUIC_CTRL on */
> +		data |= CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK \
> +				| CHG_CNFG_00_DIS_MUIC_CTRL_MASK;
> +
> +	} else if (!enable && is_enabled) {
> +		/* OTG off, boost off, DIS_MUIC_CTRL off */
> +		data &= ~(CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK \
> +				| CHG_CNFG_00_DIS_MUIC_CTRL_MASK);
> +	}
> +
> +	return regmap_write(chg->max77693->regmap,
> +			MAX77693_CHG_REG_CHG_CNFG_00,
> +			data);
> +}
> +
>  static void max77693_charger_extcon_work(struct work_struct *work)
>  {
>  	struct max77693_charger *chg = container_of(work, struct max77693_charger,
>  						  cable.work);
>  	struct extcon_dev *edev = chg->cable.edev;
> +	bool set_charging, set_otg;
> +	unsigned int current_limit;
>  	int connector, state;
>  	int ret;
>  
> @@ -707,31 +748,61 @@ static void max77693_charger_extcon_work(struct work_struct *work)
>  
>  	switch (connector) {
>  	case EXTCON_CHG_USB_SDP:
> -	case EXTCON_CHG_USB_DCP:
>  	case EXTCON_CHG_USB_CDP:
> +	case EXTCON_CHG_USB_SLOW:
> +		current_limit = 500000; /* 500 mA */
> +		set_charging = true;
> +		set_otg = false;
> +
> +		dev_info(chg->dev, "slow charging. connector type: %d\n",
> +			 connector);
> +		break;
> +	case EXTCON_CHG_USB_DCP:
>  	case EXTCON_CHG_USB_ACA:
>  	case EXTCON_CHG_USB_FAST:
> -	case EXTCON_CHG_USB_SLOW:
>  	case EXTCON_CHG_USB_PD:
> -		ret = max77693_set_charging(chg, true);
> -		if (ret) {
> -			dev_err(chg->dev, "failed to enable charging\n");
> -			break;
> -		}
> -		dev_info(chg->dev, "charging. connector type: %d\n",
> +		current_limit = chg->fast_charge_current;
> +		set_charging = true;
> +		set_otg = false;
> +
> +		dev_info(chg->dev, "fast charging. connector type: %d\n",
> +			 connector);
> +		break;
> +	case EXTCON_USB_HOST:
> +		current_limit = 500000; /* 500 mA */
> +		set_charging = false;
> +		set_otg = true;
> +
> +		dev_info(chg->dev, "USB host. connector type: %d\n",
>  			 connector);
>  		break;
>  	default:
> -		ret = max77693_set_charging(chg, false);
> -		if (ret) {
> -			dev_err(chg->dev, "failed to disable charging\n");
> -			break;
> -		}
> -		dev_info(chg->dev, "charging. connector type: %d\n",
> +		current_limit = 500000; /* 500 mA */
> +		set_charging = false;
> +		set_otg = false;
> +
> +		dev_info(chg->dev, "disconnected. connector type: %d\n",
>  			 connector);
>  		break;
>  	}
>  
> +	ret = max77693_set_current_limit(chg, current_limit);
> +	if (ret) {
> +		dev_err(chg->dev, "failed to set current limit (%d)\n", ret);
> +		goto out;
> +	}
> +
> +	ret = max77693_set_charging(chg, set_charging);
> +	if (ret) {
> +		dev_err(chg->dev, "failed to set charging (%d)\n", ret);
> +		goto out;
> +	}
> +
> +	ret = max77693_set_otg(chg, set_otg);
> +	if (ret)
> +		dev_err(chg->dev, "failed to set OTG (%d)\n", ret);
> +
> +out:
>  	power_supply_changed(chg->charger);
>  }
>  
> @@ -793,6 +864,10 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  			&chg->batttery_overcurrent))
>  		chg->batttery_overcurrent = DEFAULT_BATTERY_OVERCURRENT;
>  
> +	if (of_property_read_u32(np, "maxim,fast-charge-current-microamp",
> +			&chg->fast_charge_current))
> +		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
> +
>  	if (of_property_read_u32(np, "maxim,charge-input-threshold-microvolt",
>  			&chg->charge_input_threshold_volt))
>  		chg->charge_input_threshold_volt =
> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
> index 4570646e2f33..313fcc3173f9 100644
> --- a/include/linux/mfd/max77693-private.h
> +++ b/include/linux/mfd/max77693-private.h
> @@ -209,7 +209,10 @@ enum max77693_charger_battery_state {
>  
>  /* MAX77693 CHG_CNFG_00 register */
>  #define CHG_CNFG_00_CHG_MASK		0x1
> +#define CHG_CNFG_00_OTG_MASK		0x2
>  #define CHG_CNFG_00_BUCK_MASK		0x4
> +#define CHG_CNFG_00_BOOST_MASK		0x8
> +#define CHG_CNFG_00_DIS_MUIC_CTRL_MASK	0x20
>  
>  /* MAX77693_CHG_REG_CHG_CNFG_01 register */
>  #define CHG_CNFG_01_FCHGTIME_SHIFT	0
> @@ -222,6 +225,8 @@ enum max77693_charger_battery_state {
>  /* MAX77693_CHG_REG_CHG_CNFG_02 register */
>  #define CHG_CNFG_02_CC_SHIFT		0
>  #define CHG_CNFG_02_CC_MASK		0x3F
> +#define CHG_CNFG_02_OTG_ILIM_SHIFT	7
> +#define CHG_CNFG_02_OTG_ILIM_MASK	0x80
>  
>  /* MAX77693_CHG_REG_CHG_CNFG_03 register */
>  #define CHG_CNFG_03_TOITH_SHIFT		0
> 
> -- 
> 2.45.2
> 

-- 
Lee Jones [李琼斯]


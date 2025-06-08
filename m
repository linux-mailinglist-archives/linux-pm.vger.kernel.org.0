Return-Path: <linux-pm+bounces-28252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F24AD1437
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4B11888082
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57761C6FE8;
	Sun,  8 Jun 2025 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO6YsvO+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E62F3E;
	Sun,  8 Jun 2025 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749414356; cv=none; b=is7SWa3GetRedcRRHjxXyiJb6gy/toRdjrEnPi9wQVP6fLxouEfINSuexBdFu9zc1n9kmZ2jklj3Dm0RWHCTYSSjZ07PlHT4415iamYFG7QWKj2GURtp4VxWVHDcQpJZlnsP09Y5lncZy0NKCLL4U0y68/wEYqFgI4k35PTWVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749414356; c=relaxed/simple;
	bh=6o08xt4TDUOpfAyITCoVWKYI87XvO9fz6dJK8f0qC/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNG8EmUUDxto8BDwGsAIPlTaM8V3zWO8qhKITjhGebYbT6o/dTEVBopkq+N8mHIW9zpTabrvtti/q74i+72GHr50rpDbWG59LDjz6g4pUg3h46Lf7uz/hxhvSWHWf/mae+60LMWaCxsZXQETC++uDkXhWWOhzj8VSRaMiBw52WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO6YsvO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C2CC4CEEE;
	Sun,  8 Jun 2025 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749414356;
	bh=6o08xt4TDUOpfAyITCoVWKYI87XvO9fz6dJK8f0qC/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PO6YsvO+K+ofD8NUVNZyd6f6Vx5kI7ejo2oSqqTiOYYHXXTK7dTcZG8Uzlzpdrn3P
	 /5mfOZuZESHC1vJOnxhobH3SvT05u7fpsgWoFSAYUmucetRgiMHVmuevJUz+6YMeGd
	 /42CeitaHqexv/MIgpmWf8OLud68U+/No4RQmddVG97Y57UO0q8lMQdDWDpkZEGiCS
	 9yeFE3LUda+/2uFb39YlZAfLDhfqoxErb1OE/T6Ktr9wLX7cSt8I2L/d9imVGXSgyn
	 KXuTzNoCc4o0I/ox4OszRg9OZ5LQ8dDrEdyKSA64ShcCXXjIaYnNAHw99WL5knyOYq
	 Dhkr5YvwhYw4A==
Message-ID: <6a466a7d-5355-4712-8953-fa9569ec30a9@kernel.org>
Date: Sun, 8 Jun 2025 22:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] power: supply: core: rename
 power_supply_get_by_phandle to power_supply_get_by_reference
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@vger.kernel.org
References: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
 <20250430-psy-core-convert-to-fwnode-v2-5-f9643b958677@collabora.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250430-psy-core-convert-to-fwnode-v2-5-f9643b958677@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 30-Apr-25 12:54 AM, Sebastian Reichel wrote:
> (devm_)power_supply_get_by_phandle now internally uses fwnode and are no
> longer DT specific. Thus drop the ifdef check for CONFIG_OF and rename
> to (devm_)power_supply_get_by_reference to avoid the DT terminology.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c    |  2 +-
>  drivers/power/supply/bq2415x_charger.c   |  2 +-
>  drivers/power/supply/power_supply_core.c | 22 ++++++++++------------
>  include/linux/power_supply.h             | 15 +++------------
>  4 files changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 29b8fd4b935113f3e4790ee7f78141226048492d..8873aed3a52aa3f26564b6b2e576110c4069d28c 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -754,7 +754,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  	}
>  
>  	if (of_property_present(np, "usb0_vbus_power-supply")) {
> -		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
> +		data->vbus_power_supply = devm_power_supply_get_by_reference(dev,
>  						     "usb0_vbus_power-supply");
>  		if (IS_ERR(data->vbus_power_supply)) {
>  			dev_err(dev, "Couldn't get the VBUS power supply\n");
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
> index 1ecbca510bba99ee7abcda33a719035adfceeb5f..917c26ee56bc9f9da2f95f75a7d7f1afb0cea8d8 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -1674,7 +1674,7 @@ static int bq2415x_probe(struct i2c_client *client)
>  	/* Query for initial reported_mode and set it */
>  	if (bq->nb.notifier_call) {
>  		if (np) {
> -			notify_psy = power_supply_get_by_phandle(of_fwnode_handle(np),
> +			notify_psy = power_supply_get_by_reference(of_fwnode_handle(np),
>  						"ti,usb-charger-detection");
>  			if (IS_ERR(notify_psy))
>  				notify_psy = NULL;
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 1d53ceaa8fd161e7e72b90befabb9380393c99f2..37b9fa48faab27754d14d8379ed40d9bdda098ef 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -496,14 +496,13 @@ void power_supply_put(struct power_supply *psy)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_put);
>  
> -#ifdef CONFIG_OF
>  static int power_supply_match_device_fwnode(struct device *dev, const void *data)
>  {
>  	return dev->parent && dev_fwnode(dev->parent) == data;
>  }
>  
>  /**
> - * power_supply_get_by_phandle() - Search for a power supply and returns its ref
> + * power_supply_get_by_reference() - Search for a power supply and returns its ref
>   * @fwnode: Pointer to fwnode holding phandle property
>   * @property: Name of property holding a power supply name
>   *
> @@ -514,8 +513,8 @@ static int power_supply_match_device_fwnode(struct device *dev, const void *data
>   * Return: On success returns a reference to a power supply with
>   * matching name equals to value under @property, NULL or ERR_PTR otherwise.
>   */
> -struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
> -						 const char *property)
> +struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
> +						   const char *property)
>  {
>  	struct fwnode_handle *power_supply_fwnode;
>  	struct power_supply *psy = NULL;
> @@ -537,7 +536,7 @@ struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
>  
>  	return psy;
>  }
> -EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
> +EXPORT_SYMBOL_GPL(power_supply_get_by_reference);
>  
>  static void devm_power_supply_put(struct device *dev, void *res)
>  {
> @@ -547,16 +546,16 @@ static void devm_power_supply_put(struct device *dev, void *res)
>  }
>  
>  /**
> - * devm_power_supply_get_by_phandle() - Resource managed version of
> - *  power_supply_get_by_phandle()
> + * devm_power_supply_get_by_reference() - Resource managed version of
> + *  power_supply_get_by_reference()
>   * @dev: Pointer to device holding phandle property
>   * @property: Name of property holding a power supply phandle
>   *
>   * Return: On success returns a reference to a power supply with
>   * matching name equals to value under @property, NULL or ERR_PTR otherwise.
>   */
> -struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
> -						      const char *property)
> +struct power_supply *devm_power_supply_get_by_reference(struct device *dev,
> +							const char *property)
>  {
>  	struct power_supply **ptr, *psy;
>  
> @@ -567,7 +566,7 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	psy = power_supply_get_by_phandle(dev_fwnode(dev), property);
> +	psy = power_supply_get_by_reference(dev_fwnode(dev), property);
>  	if (IS_ERR_OR_NULL(psy)) {
>  		devres_free(ptr);
>  	} else {
> @@ -576,8 +575,7 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
>  	}
>  	return psy;
>  }
> -EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
> -#endif /* CONFIG_OF */
> +EXPORT_SYMBOL_GPL(devm_power_supply_get_by_reference);
>  
>  int power_supply_get_battery_info(struct power_supply *psy,
>  				  struct power_supply_battery_info **info_out)
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c95f098374cbdeafe8cddb52da3903f4f0e0f0fc..158227e86cfcb91b0fae7b1f9c944c5c395969ca 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -804,19 +804,10 @@ static inline void power_supply_put(struct power_supply *psy) {}
>  static inline struct power_supply *power_supply_get_by_name(const char *name)
>  { return NULL; }
>  #endif
> -#ifdef CONFIG_OF
> -extern struct power_supply *power_supply_get_by_phandle(struct fwnode_handle *fwnode,
> -							const char *property);
> -extern struct power_supply *devm_power_supply_get_by_phandle(
> +extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
> +							  const char *property);
> +extern struct power_supply *devm_power_supply_get_by_reference(
>  				    struct device *dev, const char *property);
> -#else /* !CONFIG_OF */
> -static inline struct power_supply *
> -power_supply_get_by_phandle(struct device_node *np, const char *property)
> -{ return NULL; }
> -static inline struct power_supply *
> -devm_power_supply_get_by_phandle(struct device *dev, const char *property)
> -{ return NULL; }
> -#endif /* CONFIG_OF */
>  
>  extern const enum power_supply_property power_supply_battery_info_properties[];
>  extern const size_t power_supply_battery_info_properties_size;
> 



Return-Path: <linux-pm+bounces-32471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A3B291B7
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 07:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D119C203B0A
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26286337;
	Sun, 17 Aug 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pukss/ny"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976253A7;
	Sun, 17 Aug 2025 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755410320; cv=none; b=qrVPQ7EdyqOKpGacNA3ahOVVdIbKfdJJPuJxGbEkdTDIJxDCPbQIcP+nds+JzdCxsFqEGgY8beNl/gvT+eRU4Zql4UwwkDqDHzIgk1SQKcdxpKP7DVqor0TVveqcfsR8FZMwzDo5An6SMgPIUwVN9z9VLyKkWavQo78OL8chEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755410320; c=relaxed/simple;
	bh=kVjCOVtPxPkKBG13ruCUgSjZutxtffiOYNecBVrhCsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHOQ/m088MEQdMOPXTByCEn1kXP0YCjyYjebiEVKJYQ6vbMFR2QEZapB5pqIeQQtImPnW4bwjOP10aymcbswgFO/o7K24lX35Ewxaib9XWlk5Gy3yZIz4IyIYDw3YvbSr+8ePChTlrwemu3tS1uOfJGM1lHLKi4a1PW04DoUOfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pukss/ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9753CC4CEEB;
	Sun, 17 Aug 2025 05:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755410319;
	bh=kVjCOVtPxPkKBG13ruCUgSjZutxtffiOYNecBVrhCsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pukss/nyQ2Q3HHl6r6++EUnmYnRM62KpZb1WCKb+3SNOCkxIGyI/xlqxAUTBx1mpT
	 /msCYg1I9YlQWHoNN3ifopa/4WewHc+fsWDtUHu5MkBLTp8n1NPpzzsMoIY4wNK17L
	 D3SuDA6PQlkOoUiWDHLhBFaX1QQhGdE7YdNTHB9MZOeudTd5KM6Z7aTzS5cVz/FVah
	 kV2Ge9xbha3HKM3ZS+HE9+xRPIHQLISh85e0dGjG4skhQb8IIloI/ganH3Ka42KDcp
	 2zyJr1ckheKtCXeTGzGyBHbnqH5LHj2DVdIUcHQRkcFziNef+XNzRNvdfWQKg/R8of
	 BvAHhEChRTADg==
Message-ID: <bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
Date: Sun, 17 Aug 2025 07:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2025 21:19, Andreas Kemnade wrote:
> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> It is a stripped down version of the driver here:
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/

Why are you duplicating the driver? Why original cannot be used?


...

> +
> +#define RSENS_DEFAULT_30MOHM 30000 /* 30 mOhm in uOhms*/
> +
> +static int bd7182x_get_rsens(struct bd71828_power *pwr)
> +{
> +	u64 tmp = RSENS_CURR;
> +	int rsens_ohm = RSENS_DEFAULT_30MOHM;
> +	struct fwnode_handle *node = NULL;
> +
> +	if (pwr->dev->parent)
> +		node = dev_fwnode(pwr->dev->parent);
> +
> +	if (node) {
> +		int ret;
> +		uint32_t rs;
> +
> +		ret = fwnode_property_read_u32(node,
> +					       "rohm,charger-sense-resistor-micro-ohms",

Hm? Are you writing ACPI or DT driver?

> +					       &rs);
> +		if (ret) {
> +			if (ret == -EINVAL) {
> +				rs = RSENS_DEFAULT_30MOHM;
> +			} else {
> +				dev_err(pwr->dev, "Bad RSENS dt property\n");
> +				return ret;
> +			}
> +		}
> +		if (!rs) {
> +			dev_err(pwr->dev, "Bad RSENS value\n");
> +			return -EINVAL;
> +		}
> +
> +		rsens_ohm = (int)rs;
> +	}
> +
> +	/* Reg val to uA */
> +	do_div(tmp, rsens_ohm);
> +
> +	pwr->curr_factor = tmp;
> +	pwr->rsens = rsens_ohm;
> +	dev_dbg(pwr->dev, "Setting rsens to %u micro ohm\n", pwr->rsens);
> +	dev_dbg(pwr->dev, "Setting curr-factor to %u\n", pwr->curr_factor);
> +	return 0;
> +}
> +
> +static int bd71828_power_probe(struct platform_device *pdev)
> +{
> +	struct bd71828_power *pwr;
> +	struct power_supply_config ac_cfg = {};
> +	struct power_supply_config bat_cfg = {};
> +	int ret;
> +	struct regmap *regmap;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap) {
> +		dev_err(&pdev->dev, "No parent regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	pwr = devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
> +	if (!pwr)
> +		return -ENOMEM;
> +
> +	pwr->regmap = regmap;
> +	pwr->dev = &pdev->dev;
> +	pwr->chip_type = platform_get_device_id(pdev)->driver_data;
> +
> +	switch (pwr->chip_type) {
> +	case ROHM_CHIP_TYPE_BD71828:
> +		pwr->bat_inserted = bd71828_bat_inserted;
> +		pwr->get_temp = bd71828_get_temp;
> +		pwr->regs = &pwr_regs_bd71828;
> +		dev_dbg(pwr->dev, "Found ROHM BD71828\n");

This is pretty useless debug. You do not use here autodetection, so
there is no "found" case. It's straightforward bind.

> +		break;
> +	case ROHM_CHIP_TYPE_BD71815:
> +		pwr->bat_inserted = bd71815_bat_inserted;
> +		pwr->get_temp = bd71815_get_temp;
> +		pwr->regs = &pwr_regs_bd71815;
> +		dev_dbg(pwr->dev, "Found ROHM BD71815\n");

Same here, drop.

> +	break;
> +	default:
> +		dev_err(pwr->dev, "Unknown PMIC\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = bd7182x_get_rsens(pwr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "sense resistor missing\n");
> +
> +	dev_set_drvdata(&pdev->dev, pwr);
> +	bd71828_init_hardware(pwr);
> +
> +	bat_cfg.drv_data	= pwr;
> +	bat_cfg.fwnode		= dev_fwnode(&pdev->dev);
> +
> +	ac_cfg.supplied_to	= bd71828_ac_supplied_to;
> +	ac_cfg.num_supplicants	= ARRAY_SIZE(bd71828_ac_supplied_to);
> +	ac_cfg.drv_data		= pwr;
> +
> +	pwr->ac = devm_power_supply_register(&pdev->dev, &bd71828_ac_desc,
> +					     &ac_cfg);
> +	if (IS_ERR(pwr->ac)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->ac),
> +				     "failed to register ac\n");
> +	}
> +
> +	pwr->bat = devm_power_supply_register(&pdev->dev, &bd71828_bat_desc,
> +					      &bat_cfg);
> +	if (IS_ERR(pwr->bat)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->bat),
> +				     "failed to register bat\n");
> +	}
> +
> +	ret = bd7182x_get_irqs(pdev, pwr);
> +	if (ret) {

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Drop {}

This applies to other places as well.

> +		return dev_err_probe(&pdev->dev, ret, "failed to request IRQs");
> +	};
> +
> +	/* Configure wakeup capable */
> +	device_set_wakeup_capable(pwr->dev, 1);
> +	device_set_wakeup_enable(pwr->dev, 1);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id bd71828_charger_id[] = {
> +	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
> +	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
> +
> +static struct platform_driver bd71828_power_driver = {
> +	.driver = {
> +		.name = "bd718xx-power",
> +	},
> +	.probe = bd71828_power_probe,
> +	.id_table = bd71828_charger_id,
> +};
> +
> +module_platform_driver(bd71828_power_driver);
> +MODULE_ALIAS("platform:bd718xx-power");

Drop module alias, incorrect name anyway and you already have proper
aliases from table.


Best regards,
Krzysztof


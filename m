Return-Path: <linux-pm+bounces-33650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19172B40650
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B6B3BEEC1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD422FE599;
	Tue,  2 Sep 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agyxXhK0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477B2F3C19;
	Tue,  2 Sep 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822425; cv=none; b=t4/bB4dil6aIlsGDO44kGE0GKNw/buCE96a4BzMpkBgOa71TnvfO4RL+HTzZ4ncBqYtlPqT9jgaIM2Au7jKevlHevK+Jisw6HKJyDp+cUzNdlmdzuhdAwYTG62McUo0/2RdVi7MAiHBQ0M1MqSSjbW/Y6AHO9iiZn41buNPhui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822425; c=relaxed/simple;
	bh=EBKiIC/TQi8pMFqdMi+Nl1qN1IVUCv8zQzOrO7F+syA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix+v+gJ6gQyO340SIw4bk6Ziq/iHmnIl31k7tf2E24z8UCZinYLKnXJ+tymk7UmGpmMREnV3JHWvRb70k5tyrRoTFt+EWXP8UsIYSGmJG3fNCOvTUpaPreBbA4DRiL2InhI1e10/s40DEkYokkVRSof/Vl+MTcHVIaV9r2U3hSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agyxXhK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD9DC4CEED;
	Tue,  2 Sep 2025 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756822425;
	bh=EBKiIC/TQi8pMFqdMi+Nl1qN1IVUCv8zQzOrO7F+syA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agyxXhK0HvbsjMPjmaJo+Ie03/Oa2dOZ7WhHK7aoEmnrPZve48dqtTpIkHmC+Kw/w
	 QLDLXlTPErSSKgnrcaiWvTjJs+qGb3Q2BJHayEJJUuH7VSGdhSU8L9eqf4bxhi93Q/
	 9kHsf9tW5+jNBYrJo1kqkG0q8EpvvsRtLzoaiPp3Io2lM3II8eugU9Nk0NHr8aa+Vk
	 oabLC5h/wUcLFRDUxjphGLqy4oOh/Uwxj8sDzGM9IjyrhRr7zhQaKfh4BsqouhyRfo
	 cZnn1gR2dzOL2qnTEZ5TDt0jN/DCM4WzzpGeB7bds67qyS0+yYRhI9ttjGJmdkVXw+
	 3L+w26wUiy6hw==
Date: Tue, 2 Sep 2025 15:13:39 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V7 2/5] mfd: bq257xx: Add support for BQ25703A core driver
Message-ID: <20250902141339.GR2163762@google.com>
References: <20250821162448.117621-1-macroalpha82@gmail.com>
 <20250821162448.117621-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821162448.117621-3-macroalpha82@gmail.com>

On Thu, 21 Aug 2025, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The Texas Instruments BQ25703A is an integrated charger manager and
> boost converter.
> 
> The MFD driver initalizes the device for the regulator driver
> and power supply driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/mfd/Kconfig         |  11 ++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/bq257xx.c       |  97 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/bq257xx.h | 104 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 213 insertions(+)
>  create mode 100644 drivers/mfd/bq257xx.c
>  create mode 100644 include/linux/mfd/bq257xx.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 425c5fba6cb1..768417c97339 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1641,6 +1641,17 @@ config MFD_TI_LMU
>  	  LM36274.  It consists of backlight, LED and regulator driver.
>  	  It provides consistent device controls for lighting functions.
>  
> +config MFD_BQ257XX
> +	tristate "TI BQ257XX Buck/Boost Charge Controller"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Support Texas Instruments BQ25703 Buck/Boost converter with
> +	  charge controller. It consists of regulators that provide
> +	  system voltage and OTG voltage, and a charger manager for
> +	  batteries containing one or more cells.
> +
>  config MFD_OMAP_USB_HOST
>  	bool "TI OMAP USBHS core and TLL driver"
>  	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f7bdedd5a66d..3d700374a42d 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
>  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
> +obj-$(CONFIG_MFD_BQ257XX)	+= bq257xx.o
>  obj-$(CONFIG_MFD_CGBC)		+= cgbc-core.o
>  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
>  obj-$(CONFIG_MFD_CS42L43)	+= cs42l43.o
> diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> new file mode 100644
> index 000000000000..ac4485a2cc60
> --- /dev/null
> +++ b/drivers/mfd/bq257xx.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BQ257XX Core Driver
> + * Copyright (C) 2025 Chris Morgan <macromorgan@hotmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/bq257xx.h>
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_range bq25703_readonly_reg_ranges[] = {
> +	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_MANUFACT_DEV_ID),
> +};
> +
> +static const struct regmap_access_table bq25703_writeable_regs = {
> +	.no_ranges = bq25703_readonly_reg_ranges,
> +	.n_no_ranges = ARRAY_SIZE(bq25703_readonly_reg_ranges),
> +};
> +
> +static const struct regmap_range bq25703_volatile_reg_ranges[] = {
> +	regmap_reg_range(BQ25703_CHARGE_OPTION_0, BQ25703_IIN_HOST),
> +	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_ADC_OPTION),
> +};
> +
> +static const struct regmap_access_table bq25703_volatile_regs = {
> +	.yes_ranges = bq25703_volatile_reg_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bq25703_volatile_reg_ranges),
> +};
> +
> +static const struct regmap_config bq25703_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = BQ25703_ADC_OPTION,
> +	.cache_type = REGCACHE_RBTREE,

Are you sure you want RB?  Most people have switched to MAPLE.

> +	.wr_table = &bq25703_writeable_regs,
> +	.volatile_table = &bq25703_volatile_regs,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int bq257xx_probe(struct i2c_client *client)
> +{
> +	struct bq257xx_device *ddata;
> +	static const struct mfd_cell cells[] = {
> +		MFD_CELL_NAME("bq257xx-regulator"),
> +		MFD_CELL_NAME("bq257xx-charger"),
> +	};

Sorry, that isn't what I meant.

Please place the 'struct mfd_cell' out of the function, like everyone
else does.

> +	int ret;
> +
> +	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->client = client;

'\n' here.

> +	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
> +	if (IS_ERR(ddata->regmap)) {
> +		return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap),
> +				     "Failed to allocate register map\n");
> +	}
> +
> +	i2c_set_clientdata(client, ddata);
> +
> +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> +				   cells, ARRAY_SIZE(cells), NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to register child devices\n");
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id bq257xx_i2c_ids[] = {
> +	{ "bq25703a" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
> +
> +static const struct of_device_id bq257xx_of_match[] = {
> +	{ .compatible = "ti,bq25703a" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bq257xx_of_match);
> +
> +static struct i2c_driver bq257xx_driver = {
> +	.driver = {
> +		.name = "bq257xx",
> +		.of_match_table = bq257xx_of_match,
> +	},
> +	.probe = bq257xx_probe,
> +	.id_table = bq257xx_i2c_ids,
> +};
> +module_i2c_driver(bq257xx_driver);
> +
> +MODULE_DESCRIPTION("bq257xx buck/boost/charger driver");
> +MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
> new file mode 100644
> index 000000000000..1d6ddc7fb09f
> --- /dev/null
> +++ b/include/linux/mfd/bq257xx.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Register definitions for TI BQ257XX
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#define BQ25703_CHARGE_OPTION_0			0x00
> +#define BQ25703_CHARGE_CURRENT			0x02
> +#define BQ25703_MAX_CHARGE_VOLT			0x04
> +#define BQ25703_OTG_VOLT			0x06
> +#define BQ25703_OTG_CURRENT			0x08
> +#define BQ25703_INPUT_VOLTAGE			0x0a
> +#define BQ25703_MIN_VSYS			0x0c
> +#define BQ25703_IIN_HOST			0x0e
> +#define BQ25703_CHARGER_STATUS			0x20
> +#define BQ25703_PROCHOT_STATUS			0x22
> +#define BQ25703_IIN_DPM				0x24
> +#define BQ25703_ADCIBAT_CHG			0x28
> +#define BQ25703_ADCIINCMPIN			0x2a
> +#define BQ25703_ADCVSYSVBAT			0x2c
> +#define BQ25703_MANUFACT_DEV_ID			0x2e
> +#define BQ25703_CHARGE_OPTION_1			0x30
> +#define BQ25703_CHARGE_OPTION_2			0x32
> +#define BQ25703_CHARGE_OPTION_3			0x34
> +#define BQ25703_ADC_OPTION			0x3a
> +
> +#define BQ25703_EN_LWPWR			BIT(15)
> +#define BQ25703_WDTMR_ADJ_MASK			GENMASK(14, 13)
> +#define BQ25703_WDTMR_DISABLE			0
> +#define BQ25703_WDTMR_5_SEC			1
> +#define BQ25703_WDTMR_88_SEC			2
> +#define BQ25703_WDTMR_175_SEC			3
> +
> +#define BQ25703_ICHG_MASK			GENMASK(12, 6)
> +#define BQ25703_ICHG_STEP_UA			64000
> +#define BQ25703_ICHG_MIN_UA			64000
> +#define BQ25703_ICHG_MAX_UA			8128000
> +
> +#define BQ25703_MAX_CHARGE_VOLT_MASK		GENMASK(15, 4)
> +#define BQ25703_VBATREG_STEP_UV			16000
> +#define BQ25703_VBATREG_MIN_UV			1024000
> +#define BQ25703_VBATREG_MAX_UV			19200000
> +
> +#define BQ25703_OTG_VOLT_MASK			GENMASK(13, 6)
> +#define BQ25703_OTG_VOLT_STEP_UV		64000
> +#define BQ25703_OTG_VOLT_MIN_UV			4480000
> +#define BQ25703_OTG_VOLT_MAX_UV			20800000
> +#define BQ25703_OTG_VOLT_NUM_VOLT		256
> +
> +#define BQ25703_OTG_CUR_MASK			GENMASK(14, 8)
> +#define BQ25703_OTG_CUR_STEP_UA			50000
> +#define BQ25703_OTG_CUR_MAX_UA			6350000
> +
> +#define BQ25703_MINVSYS_MASK			GENMASK(13, 8)
> +#define BQ25703_MINVSYS_STEP_UV			256000
> +#define BQ25703_MINVSYS_MIN_UV			1024000
> +#define BQ25703_MINVSYS_MAX_UV			16128000
> +
> +#define BQ25703_STS_AC_STAT			BIT(15)
> +#define BQ25703_STS_IN_FCHRG			BIT(10)
> +#define BQ25703_STS_IN_PCHRG			BIT(9)
> +#define BQ25703_STS_FAULT_ACOV			BIT(7)
> +#define BQ25703_STS_FAULT_BATOC			BIT(6)
> +#define BQ25703_STS_FAULT_ACOC			BIT(5)
> +
> +#define BQ25703_IINDPM_MASK			GENMASK(14, 8)
> +#define BQ25703_IINDPM_STEP_UA			50000
> +#define BQ25703_IINDPM_MIN_UA			50000
> +#define BQ25703_IINDPM_MAX_UA			6400000
> +#define BQ25703_IINDPM_DEFAULT_UA		3300000
> +#define BQ25703_IINDPM_OFFSET_UA		50000
> +
> +#define BQ25703_ADCIBAT_DISCHG_MASK		GENMASK(6, 0)
> +#define BQ25703_ADCIBAT_CHG_MASK		GENMASK(14, 8)
> +#define BQ25703_ADCIBAT_CHG_STEP_UA		64000
> +#define BQ25703_ADCIBAT_DIS_STEP_UA		256000
> +
> +#define BQ25703_ADCIIN				GENMASK(15, 8)
> +#define BQ25703_ADCIINCMPIN_STEP		50000
> +
> +#define BQ25703_ADCVSYS_MASK			GENMASK(15, 8)
> +#define BQ25703_ADCVBAT_MASK			GENMASK(7, 0)
> +#define BQ25703_ADCVSYSVBAT_OFFSET_UV		2880000
> +#define BQ25703_ADCVSYSVBAT_STEP		64000
> +
> +#define BQ25703_ADC_CH_MASK			GENMASK(7, 0)
> +#define BQ25703_ADC_CONV_EN			BIT(15)
> +#define BQ25703_ADC_START			BIT(14)
> +#define BQ25703_ADC_FULL_SCALE			BIT(13)
> +#define BQ25703_ADC_CMPIN_EN			BIT(7)
> +#define BQ25703_ADC_VBUS_EN			BIT(6)
> +#define BQ25703_ADC_PSYS_EN			BIT(5)
> +#define BQ25703_ADC_IIN_EN			BIT(4)
> +#define BQ25703_ADC_IDCHG_EN			BIT(3)
> +#define BQ25703_ADC_ICHG_EN			BIT(2)
> +#define BQ25703_ADC_VSYS_EN			BIT(1)
> +#define BQ25703_ADC_VBAT_EN			BIT(0)
> +
> +#define BQ25703_EN_OTG_MASK			BIT(12)
> +
> +struct bq257xx_device {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]


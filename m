Return-Path: <linux-pm+bounces-31680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E2B16F66
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B117B7178
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F622BDC3E;
	Thu, 31 Jul 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so20i7Tw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0B266B64;
	Thu, 31 Jul 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957371; cv=none; b=vGMc94PYAD154bvYZI5cr9Oy4CB8ZF2pERqrzXroDqglzZO1XNXcNQm9QWgHiaJ0ws2FsxJeJShy58PTfNveEajFkpaHkGCFF0nR+q/XqT32wccfBdMXtQyy7a31fsCWbCAKViCKBY3FtWybBn6v9wm4cElJ8paN36GvU9MjaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957371; c=relaxed/simple;
	bh=oscKnolhyIuuBA0SNeSeDKKCNreYha2LdQpZkrcRsX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6LVdYk8/36wUt9cgttfdEiXNiFzsG2teu8+r5Y4eVsydo7ZqLbT8UtrG2vVyxFu89ZLutBW5+dr5xlaW66GU23NJLeeXW3ZWG2XduTSaHH7siLI7gbVVRJPrDWAyVrFA4/ZRxMYYKniDYPNiN0G+8vZP6eG2fEquvGtqL2LDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so20i7Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD4C4CEEF;
	Thu, 31 Jul 2025 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753957371;
	bh=oscKnolhyIuuBA0SNeSeDKKCNreYha2LdQpZkrcRsX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=so20i7TwLKggeAdB1l02xtdgUg+4kwroiNTWl+zaCOPKwVhg8K+4EI6Ps/3Bsy6ts
	 tsi9yh5YXj43evXKsuHS+aiAZH5uWwFcrxAIjH1cnzhDCz2o/pGzdJX8wIHUyDcYDe
	 qoKs5bTReb6GkFZ4upQdU2iIugTVBN5B9tyl/LgsReeN54BowPiaprd9KG+PL/127r
	 WaEuY6hEFUUHPUg9vlSmUy8Tvie3y4g/5lXehcNaCgqGwvqLEyT/1gHfu9kCoUfiP3
	 seAfAb8Ln8sY4j9YF2fcvDecwYNZNjhK9276tc0gZCKCr8bQ3Se6/BOfswBadL72tj
	 y60mR8+CRBdEQ==
Date: Thu, 31 Jul 2025 11:22:45 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/5] mfd: bq257xx: Add support for BQ25703A core driver
Message-ID: <20250731102245.GC1049189@google.com>
References: <20250722164813.2110874-1-macroalpha82@gmail.com>
 <20250722164813.2110874-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722164813.2110874-3-macroalpha82@gmail.com>

On Tue, 22 Jul 2025, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The Texas Instruments BQ25703A is an integrated charger manager and
> boost converter.
> 
> The MFD driver initalizes the device for the regulator driver
> and power supply driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mfd/Kconfig         |  11 ++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/bq257xx.c       |  97 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/bq257xx.h | 108 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 217 insertions(+)
>  create mode 100644 drivers/mfd/bq257xx.c
>  create mode 100644 include/linux/mfd/bq257xx.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6fb3768e3d71..d8b39e8a8a17 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1585,6 +1585,17 @@ config MFD_TI_LMU
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
> index 79495f9f3457..06da932cce5d 100644
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
> index 000000000000..03325a04d44b
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
> +	.wr_table = &bq25703_writeable_regs,
> +	.volatile_table = &bq25703_volatile_regs,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int bq257xx_probe(struct i2c_client *client)
> +{
> +	struct bq257xx_device *ddata;
> +	struct mfd_cell cells[] = {
> +		MFD_CELL_NAME("bq257xx-regulator"),
> +		MFD_CELL_NAME("bq257xx-charger"),
> +	};

Please make these static const like all of the others above.

> +	int ret;
> +
> +	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->client = client;
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
> index 000000000000..153a96248f32
> --- /dev/null
> +++ b/include/linux/mfd/bq257xx.h
> @@ -0,0 +1,108 @@
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
/> +
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
> +enum bq257xx_id {
> +	BQ25703A,

Where is this used?

> +};
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


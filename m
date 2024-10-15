Return-Path: <linux-pm+bounces-15658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D5699EE98
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40114284B88
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC551AF0DA;
	Tue, 15 Oct 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjGr/JQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A813399F;
	Tue, 15 Oct 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000950; cv=none; b=Jxv2h7N4DWe90HUelLdQ9sd8gyxRV2vh2VLl74B31xlz36G3s4CPe7kwaGD0mwaSt+Zjsh2cW4qPo7LTWt96xCSPDx7sEimqDs8orkmIj6H4efA2LMI8VHNtj9pBmDEvIXNl9k0gFF2enAq8lUAEROdxU2m4Tu/omIad3xAMOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000950; c=relaxed/simple;
	bh=moZmyxAG8DSDEFm5HkvSZKTVAs+5VLNGY9Up2129WGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsc85z2MZ790nt/6BUgkhE0qvbakpU01kN9Qstck7Jqp2twR4BdN4UgflO1+ojMXkHZTpfN6wcs00xVjkSB43FcQwBjaKPolLaCZx4tHB8DoK4sxbZ9/md/li6MA22LMAQLSPCkBL/YQLbSdpAIMlw1WlxnImeQUhlqAkc244/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjGr/JQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED02EC4CEC6;
	Tue, 15 Oct 2024 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000949;
	bh=moZmyxAG8DSDEFm5HkvSZKTVAs+5VLNGY9Up2129WGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjGr/JQznWvxYlNzTUV+w/JEpxtJszv2z+vX2mh+7ShvPXexrX6G9V2rcwzNiUz/4
	 uGiZBCooVfmZUH0IZXVb5fOr8qjgc6GYsOl0PDUdD5xpCyvcI8k5Q18h8XpVTuN9Ee
	 gMvXhLu4DH+vomkFg51JrkDuGtPbhMg4J1BIy1EnVpUedwDjfG6ut1kZzNLdFSskz3
	 0kTkQeCRIx7OQRqRBnTkgXuxn6r1PTWBW4SzhZWg7lOuOJO4dmbf+AtBoQAklJ6dNc
	 Kgn5tKLOsH3Sd7MotzJynPiN+7baAUt//YYoRZrc2BN+TpRI0QVBGIxVulth6djnGn
	 +r2qqyDt+Dimg==
Date: Tue, 15 Oct 2024 15:02:24 +0100
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 3/7] mfd: Add new driver for MAX77705 PMIC
Message-ID: <20241015140224.GI8348@google.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-3-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-3-0d38b5090c57@gmail.com>

On Mon, 07 Oct 2024, Dzmitry Sankouski wrote:

> Add the core MFD driver for max77705 PMIC. We define five sub-devices
> for which the drivers will be added in subsequent patches.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes for v5:
> - license change to 2.0
> - use same hardware name in Kconfig and module descriptions
> Changes for v4:
> - rework driver from scratch
> - migrate to regmap_add_irq_chip, remove max77705-irq.c,
>   rename max77705-core.c to max77705.c
> - cleanup headers
> - remove debugfs code
> - migrate to use max77693_dev structure
> - remove max77705.h
> ---
>  MAINTAINERS                          |   2 ++
>  drivers/mfd/Kconfig                  |  12 +++++++
>  drivers/mfd/Makefile                 |   2 ++
>  drivers/mfd/max77705.c               | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77693-common.h  |   6 +++-
>  include/linux/mfd/max77705-private.h | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 449 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed8bdaaaca9..4bc9c0da6adb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14078,6 +14078,7 @@ F:	drivers/*/*max77843.c
>  F:	drivers/*/max14577*.c
>  F:	drivers/*/max77686*.c
>  F:	drivers/*/max77693*.c
> +F:	drivers/*/max77705*.c
>  F:	drivers/clk/clk-max77686.c
>  F:	drivers/extcon/extcon-max14577.c
>  F:	drivers/extcon/extcon-max77693.c
> @@ -14085,6 +14086,7 @@ F:	drivers/rtc/rtc-max77686.c
>  F:	include/linux/mfd/max14577*.h
>  F:	include/linux/mfd/max77686*.h
>  F:	include/linux/mfd/max77693*.h
> +F:	include/linux/mfd/max77705*.h
>  
>  MAXIRADIO FM RADIO RECEIVER DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f9325bcce1b9..090eb3fb3d67 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -904,6 +904,18 @@ config MFD_MAX77693
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MAX77705
> +	tristate "Maxim MAX77705 PMIC Support"
> +	depends on I2C
> +	select MFD_CORE
> +	help
> +	  Say yes here to add support for Maxim Integrated MAX77705.

"Integrated MAX77705 PMIC."

> +	  This is a Power Management IC with Charger, safe LDOs, Flash, Haptic
> +	  and MUIC controls on chip.
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_MAX77714
>  	tristate "Maxim Semiconductor MAX77714 PMIC Support"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2a9f91e81af8..3dc5742c6aeb 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -167,6 +167,7 @@ obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
> +obj-$(CONFIG_MFD_MAX77705)	+= max77705.o
>  obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
>  obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
>  obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
> @@ -232,6 +233,7 @@ obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
>  obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
> +obj-$(CONFIG_MFD_S2DOS05)	+= s2dos05.o
>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
>  obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
>  obj-$(CONFIG_MFD_VEXPRESS_SYSREG)	+= vexpress-sysreg.o
> diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> new file mode 100644
> index 000000000000..553f20a6cdd5
> --- /dev/null
> +++ b/drivers/mfd/max77705.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// max77705.c - mfd core driver for the MAX77705

No filenames in headers please - they have a habit of going out of date.

Drop references to "MFD":

  * Maxim MAX77705 PMIC core driver

> +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>

Only the SPDX in C++ comments please.

> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77705-private.h>
> +#include <linux/mfd/max77693-common.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>

Alphabetical please.

> +
> +#define I2C_ADDR_CHG    (0xD2 >> 1)
> +#define I2C_ADDR_FG     (0x6C >> 1)

Why are these being shifted?

> +
> +static struct mfd_cell max77705_devs[] = {
> +	{
> +		.name = "leds-max77705-rgb",

Why is 'leds' prefixed here?

> +		.of_compatible = "maxim,max77705-led",

Is it a straight LED or RGB?

> +	},
> +	{
> +		.name = "max77705-fuel-gauge",
> +		.of_compatible = "maxim,max77705-fuel-gauge",
> +	},
> +	{
> +		.name = "max77705-charger",
> +		.of_compatible = "maxim,max77705-charger",
> +	},
> +	{
> +		.name = "max77705-haptic",
> +		.of_compatible = "maxim,max77705-haptic",
> +	},
> +};
> +
> +static const struct regmap_range max77705_readable_ranges[] = {
> +	regmap_reg_range(MAX77705_PMIC_REG_PMICID1,		MAX77705_PMIC_REG_BSTOUT_MASK),
> +	regmap_reg_range(MAX77705_PMIC_REG_INTSRC,		MAX77705_PMIC_REG_RESERVED_29),
> +	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
> +	regmap_reg_range(MAX77705_PMIC_REG_MCONFIG,		MAX77705_PMIC_REG_MCONFIG2),
> +	regmap_reg_range(MAX77705_PMIC_REG_FORCE_EN_MASK,	MAX77705_PMIC_REG_FORCE_EN_MASK),
> +	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
> +	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL2,	MAX77705_PMIC_REG_BOOSTCONTROL2),
> +	regmap_reg_range(MAX77705_PMIC_REG_SW_RESET,		MAX77705_PMIC_REG_USBC_RESET),
> +};
> +
> +static const struct regmap_range max77705_writable_ranges[] = {
> +	regmap_reg_range(MAX77705_PMIC_REG_MAINCTRL1,		MAX77705_PMIC_REG_BSTOUT_MASK),
> +	regmap_reg_range(MAX77705_PMIC_REG_INTSRC,		MAX77705_PMIC_REG_RESERVED_29),
> +	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
> +	regmap_reg_range(MAX77705_PMIC_REG_MCONFIG,		MAX77705_PMIC_REG_MCONFIG2),
> +	regmap_reg_range(MAX77705_PMIC_REG_FORCE_EN_MASK,	MAX77705_PMIC_REG_FORCE_EN_MASK),
> +	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
> +	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL2,	MAX77705_PMIC_REG_BOOSTCONTROL2),
> +	regmap_reg_range(MAX77705_PMIC_REG_SW_RESET,		MAX77705_PMIC_REG_USBC_RESET),
> +
> +};
> +
> +static const struct regmap_access_table max77705_readable_table = {
> +	.yes_ranges = max77705_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(max77705_readable_ranges),
> +};
> +
> +static const struct regmap_access_table max77705_writable_table = {
> +	.yes_ranges = max77705_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(max77705_writable_ranges),
> +};
> +
> +static const struct regmap_config max77705_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &max77705_readable_table,
> +	.wr_table = &max77705_writable_table,
> +	.max_register = MAX77705_PMIC_REG_USBC_RESET,
> +};
> +
> +static const struct regmap_config max77705_leds_regmap_config = {
> +	.reg_base = MAX77705_RGBLED_REG_BASE,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX77705_LED_REG_END,
> +};
> +
> +static const struct regmap_config max77705_chg_regmap_config = {
> +	.reg_base = MAX77705_CHG_REG_BASE,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX77705_CHG_REG_SAFEOUT_CTRL,
> +};
> +
> +static const struct regmap_config max77705_fg_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX77705_FG_END,
> +};
> +
> +static const struct regmap_irq max77705_topsys_irqs[] = {
> +	{ .mask = MAX77705_SYSTEM_IRQ_BSTEN_INT,  },
> +	{ .mask = MAX77705_SYSTEM_IRQ_SYSUVLO_INT,  },
> +	{ .mask = MAX77705_SYSTEM_IRQ_SYSOVLO_INT,  },
> +	{ .mask = MAX77705_SYSTEM_IRQ_TSHDN_INT,  },
> +	{ .mask = MAX77705_SYSTEM_IRQ_TM_INT,  },
> +};
> +
> +static const struct regmap_irq_chip max77705_topsys_irq_chip = {
> +	.name			= "max77705-topsys",
> +	.status_base		= MAX77705_PMIC_REG_SYSTEM_INT,
> +	.mask_base		= MAX77705_PMIC_REG_SYSTEM_INT_MASK,
> +	.num_regs		= 1,
> +	.irqs			= max77705_topsys_irqs,
> +	.num_irqs		= ARRAY_SIZE(max77705_topsys_irqs),
> +};
> +
> +static int max77705_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct max77693_dev *max77705;
> +	struct i2c_client *i2c_chg;
> +	struct i2c_client *i2c_fg;
> +	struct regmap_irq_chip_data *irq_data;
> +	struct irq_domain *domain;
> +	int ret;
> +	unsigned int pmic_rev_value;
> +	u8 pmic_ver, pmic_rev;
> +
> +
> +	max77705 = devm_kzalloc(&i2c->dev, sizeof(struct max77693_dev),

sizeof(*max77705)

> +				GFP_KERNEL);

Why wrap here?  You're using 100-chars above.

> +	if (!max77705)
> +		return -ENOMEM;
> +
> +	max77705->dev = &i2c->dev;
> +	max77705->irq = i2c->irq;
> +	max77705->type = TYPE_MAX77705;
> +	i2c_set_clientdata(i2c, max77705);
> +
> +	max77705->regmap = devm_regmap_init_i2c(i2c, &max77705_regmap_config);
> +	if (IS_ERR(max77705->regmap))
> +		return PTR_ERR(max77705->regmap);
> +
> +	if (regmap_read(max77705->regmap, MAX77705_PMIC_REG_PMICREV, &pmic_rev_value) < 0)
> +		return -ENODEV;
> +
> +	pmic_rev = (pmic_rev_value & MAX77705_REVISION_MASK);
> +	pmic_ver = ((pmic_rev_value & MAX77705_VERSION_MASK) >> MAX77705_VERSION_SHIFT);

Over-bracketing.

> +	dev_dbg(max77705->dev, "device found: rev.0x%x, ver.0x%x\n",
> +		pmic_rev, pmic_ver);

Is this ever going to be useful after initial development?

> +	if (pmic_rev != MAX77705_PASS3) {
> +		dev_err(max77705->dev, "rev.0x%x is not tested",
> +			pmic_rev);

... especially since you're going to print unexpected values out anyway.

> +		return -ENODEV;
> +	}
> +
> +	max77705->regmap_leds = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
> +	if (IS_ERR(max77705->regmap_leds))
> +		return PTR_ERR(max77705->regmap_leds);
> +
> +	i2c_chg = devm_i2c_new_dummy_device(max77705->dev,
> +						i2c->adapter, I2C_ADDR_CHG);

'\n' here.

> +	max77705->regmap_chg = devm_regmap_init_i2c(i2c_chg,
> +						    &max77705_chg_regmap_config);

Why not create this in the CHG driver?

> +	if (IS_ERR(max77705->regmap_chg))
> +		return PTR_ERR(max77705->regmap_chg);
> +
> +	i2c_fg = devm_i2c_new_dummy_device(max77705->dev, i2c->adapter,
> +						I2C_ADDR_FG);
> +	max77705->regmap_fg = devm_regmap_init_i2c(i2c_fg,
> +						   &max77705_fg_regmap_config);

Why not create this in the FG driver?

> +	if (IS_ERR(max77705->regmap_fg))
> +		return PTR_ERR(max77705->regmap_fg);
> +
> +	ret = devm_regmap_add_irq_chip(max77705->dev, max77705->regmap,
> +					max77705->irq,
> +					IRQF_ONESHOT | IRQF_SHARED, 0,
> +					&max77705_topsys_irq_chip,
> +					&irq_data);
> +	if (ret)
> +		dev_err(max77705->dev, "failed to add irq chip: %d\n", ret);
> +
> +	/* Unmask interrupts from all blocks in interrupt source register */
> +	ret = regmap_update_bits(max77705->regmap,
> +				 MAX77705_PMIC_REG_INTSRC_MASK,
> +				 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);

Why the cast?

> +	if (ret < 0)
> +		dev_err(max77705->dev,
> +			"Could not unmask interrupts in INTSRC: %d\n", ret);

If it's an error, you should return.

> +	domain = regmap_irq_get_domain(irq_data);

'\n' here.

> +	ret = devm_mfd_add_devices(max77705->dev, PLATFORM_DEVID_NONE,
> +				   max77705_devs, ARRAY_SIZE(max77705_devs),
> +				   NULL, 0, domain);
> +	if (ret) {
> +		dev_err(max77705->dev, "failed to add MFD devices: %d\n", ret);

Failed to register child devices.

> +		return ret;
> +	}
> +
> +	device_init_wakeup(max77705->dev, true);
> +
> +	return 0;
> +}
> +
> +static int max77705_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
> +
> +	disable_irq(max77705->irq);

'\n' here.

> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(max77705->irq);
> +
> +	return 0;
> +}
> +
> +static int max77705_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(max77705->irq);

'\n' here.

> +	enable_irq(max77705->irq);
> +
> +	return 0;
> +}
> +

Remove this line.

> +DEFINE_SIMPLE_DEV_PM_OPS(max77705_pm_ops, max77705_suspend, max77705_resume);
> +
> +static const struct of_device_id max77705_i2c_dt_ids[] = {

max77705_i2c_of_match

> +	{ .compatible = "maxim,max77705" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, max77705_i2c_dt_ids);
> +
> +static struct i2c_driver max77705_i2c_driver = {
> +	.driver		= {
> +		.name		= "max77705",
> +		.of_match_table	= max77705_i2c_dt_ids,
> +		.pm		= pm_sleep_ptr(&max77705_pm_ops),
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe		= max77705_i2c_probe,

Please get rid of all of this ugly tabbing.

> +};
> +module_i2c_driver(max77705_i2c_driver);
> +
> +MODULE_DESCRIPTION("Maxim MAX77705 MFD core driver");

Not "MFD" - as above.

> +MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max77693-common.h b/include/linux/mfd/max77693-common.h
> index a5bce099f1ed..1b87b1ada21c 100644
> --- a/include/linux/mfd/max77693-common.h
> +++ b/include/linux/mfd/max77693-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Common data shared between Maxim 77693 and 77843 drivers
> + * Common data shared between Maxim 77693, 77705 and 77843 drivers
>   *
>   * Copyright (C) 2015 Samsung Electronics
>   */
> @@ -11,6 +11,7 @@
>  enum max77693_types {
>  	TYPE_MAX77693_UNKNOWN,
>  	TYPE_MAX77693,
> +	TYPE_MAX77705,
>  	TYPE_MAX77843,
>  
>  	TYPE_MAX77693_NUM,
> @@ -25,6 +26,7 @@ struct max77693_dev {
>  	struct i2c_client *i2c_muic;	/* 0x4A , MUIC */
>  	struct i2c_client *i2c_haptic;	/* MAX77693: 0x90 , Haptic */
>  	struct i2c_client *i2c_chg;	/* MAX77843: 0xD2, Charger */
> +	struct i2c_client *i2c_fg;	/* MAX77843: 0xD2, Charger */
>  
>  	enum max77693_types type;
>  
> @@ -32,6 +34,8 @@ struct max77693_dev {
>  	struct regmap *regmap_muic;
>  	struct regmap *regmap_haptic;	/* Only MAX77693 */
>  	struct regmap *regmap_chg;	/* Only MAX77843 */
> +	struct regmap *regmap_fg;	/* Only MAX77705 */
> +	struct regmap *regmap_leds;	/* Only MAX77705 */
>  
>  	struct regmap_irq_chip_data *irq_data_led;
>  	struct regmap_irq_chip_data *irq_data_topsys;
> diff --git a/include/linux/mfd/max77705-private.h b/include/linux/mfd/max77705-private.h
> new file mode 100644
> index 000000000000..8479d1b6cbe4
> --- /dev/null
> +++ b/include/linux/mfd/max77705-private.h
> @@ -0,0 +1,180 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +//
> +// Maxim MAX77705 definitions.
> +//
> +// Copyright (C) 2015 Samsung Electronics, Inc.
> +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>

No C++ please.

> +
> +#ifndef __LINUX_MFD_MAX77705_PRIV_H
> +#define __LINUX_MFD_MAX77705_PRIV_H
> +
> +#include <linux/pm.h>
> +
> +#define MAX77705_SRC_IRQ_CHG	BIT(0)
> +#define MAX77705_SRC_IRQ_TOP	BIT(1)
> +#define MAX77705_SRC_IRQ_FG	BIT(2)
> +#define MAX77705_SRC_IRQ_USBC	BIT(3)
> +#define MAX77705_SRC_IRQ_ALL	(MAX77705_SRC_IRQ_CHG | MAX77705_SRC_IRQ_TOP | \
> +				MAX77705_SRC_IRQ_FG | MAX77705_SRC_IRQ_USBC)
> +
> +// MAX77705_PMIC_REG_PMICREV register

No C++ please.

> +#define MAX77705_VERSION_SHIFT	3
> +#define MAX77705_REVISION_MASK	GENMASK(2, 0)
> +#define MAX77705_VERSION_MASK	GENMASK(7, MAX77705_VERSION_SHIFT)
> +// MAX77705_PMIC_REG_MAINCTRL1 register
> +#define MAX77705_MAINCTRL1_BIASEN_SHIFT	7
> +#define MAX77705_MAINCTRL1_BIASEN_MASK	BIT(MAX77705_MAINCTRL1_BIASEN_SHIFT)
> +// MAX77705_PMIC_REG_MCONFIG2 (haptics) register
> +#define MAX77705_CONFIG2_MEN_SHIFT	6
> +#define MAX77705_CONFIG2_MODE_SHIFT	7
> +#define MAX77705_CONFIG2_HTYP_SHIFT	5
> +// MAX77705_PMIC_REG_SYSTEM_INT_MASK register
> +#define MAX77705_SYSTEM_IRQ_BSTEN_INT	BIT(3)
> +#define MAX77705_SYSTEM_IRQ_SYSUVLO_INT	BIT(4)
> +#define MAX77705_SYSTEM_IRQ_SYSOVLO_INT	BIT(5)
> +#define MAX77705_SYSTEM_IRQ_TSHDN_INT	BIT(6)
> +#define MAX77705_SYSTEM_IRQ_TM_INT	BIT(7)
> +
> +enum max77705_hw_rev {
> +	MAX77705_PASS1 = 1,
> +	MAX77705_PASS2,
> +	MAX77705_PASS3,
> +};
> +
> +enum max77705_reg {
> +	MAX77705_PMIC_REG_PMICID1		= 0x00,
> +	MAX77705_PMIC_REG_PMICREV		= 0x01,
> +	MAX77705_PMIC_REG_MAINCTRL1		= 0x02,
> +	MAX77705_PMIC_REG_BSTOUT_MASK		= 0x03,
> +	MAX77705_PMIC_REG_FORCE_EN_MASK		= 0x08,
> +	MAX77705_PMIC_REG_MCONFIG		= 0x10,
> +	MAX77705_PMIC_REG_MCONFIG2		= 0x11,
> +	MAX77705_PMIC_REG_INTSRC		= 0x22,
> +	MAX77705_PMIC_REG_INTSRC_MASK		= 0x23,
> +	MAX77705_PMIC_REG_SYSTEM_INT		= 0x24,
> +	MAX77705_PMIC_REG_RESERVED_25		= 0x25,
> +	MAX77705_PMIC_REG_SYSTEM_INT_MASK	= 0x26,
> +	MAX77705_PMIC_REG_RESERVED_27		= 0x27,
> +	MAX77705_PMIC_REG_RESERVED_28		= 0x28,
> +	MAX77705_PMIC_REG_RESERVED_29		= 0x29,
> +	MAX77705_PMIC_REG_BOOSTCONTROL1		= 0x4C,
> +	MAX77705_PMIC_REG_BOOSTCONTROL2		= 0x4F,
> +	MAX77705_PMIC_REG_SW_RESET		= 0x50,
> +	MAX77705_PMIC_REG_USBC_RESET		= 0x51,
> +
> +	MAX77705_PMIC_REG_END,
> +};
> +
> +enum max77705_chg_reg {
> +	MAX77705_CHG_REG_BASE	= 0xB0,
> +	MAX77705_CHG_REG_INT	= 0,

Tab these out like above and below.

> +	MAX77705_CHG_REG_INT_MASK,
> +	MAX77705_CHG_REG_INT_OK,
> +	MAX77705_CHG_REG_DETAILS_00,
> +	MAX77705_CHG_REG_DETAILS_01,
> +	MAX77705_CHG_REG_DETAILS_02,
> +	MAX77705_CHG_REG_DTLS_03,
> +	MAX77705_CHG_REG_CNFG_00,
> +	MAX77705_CHG_REG_CNFG_01,
> +	MAX77705_CHG_REG_CNFG_02,
> +	MAX77705_CHG_REG_CNFG_03,
> +	MAX77705_CHG_REG_CNFG_04,
> +	MAX77705_CHG_REG_CNFG_05,
> +	MAX77705_CHG_REG_CNFG_06,
> +	MAX77705_CHG_REG_CNFG_07,
> +	MAX77705_CHG_REG_CNFG_08,
> +	MAX77705_CHG_REG_CNFG_09,
> +	MAX77705_CHG_REG_CNFG_10,
> +	MAX77705_CHG_REG_CNFG_11,
> +	MAX77705_CHG_REG_CNFG_12,
> +	MAX77705_CHG_REG_CNFG_13,
> +	MAX77705_CHG_REG_CNFG_14,
> +	MAX77705_CHG_REG_SAFEOUT_CTRL,
> +};
> +
> +enum max77705_fuelgauge_reg {
> +	STATUS_REG				= 0x00,
> +	VALRT_THRESHOLD_REG			= 0x01,
> +	TALRT_THRESHOLD_REG			= 0x02,
> +	SALRT_THRESHOLD_REG			= 0x03,
> +	REMCAP_REP_REG				= 0x05,
> +	SOCREP_REG				= 0x06,
> +	TEMPERATURE_REG				= 0x08,
> +	VCELL_REG				= 0x09,
> +	TIME_TO_EMPTY_REG			= 0x11,
> +	FULLSOCTHR_REG				= 0x13,
> +	CURRENT_REG				= 0x0A,
> +	AVG_CURRENT_REG				= 0x0B,
> +	SOCMIX_REG				= 0x0D,
> +	SOCAV_REG				= 0x0E,
> +	REMCAP_MIX_REG				= 0x0F,
> +	FULLCAP_REG				= 0x10,
> +	RFAST_REG				= 0x15,
> +	AVR_TEMPERATURE_REG			= 0x16,
> +	CYCLES_REG				= 0x17,
> +	DESIGNCAP_REG				= 0x18,
> +	AVR_VCELL_REG				= 0x19,
> +	TIME_TO_FULL_REG			= 0x20,
> +	CONFIG_REG				= 0x1D,
> +	ICHGTERM_REG				= 0x1E,
> +	REMCAP_AV_REG				= 0x1F,
> +	FULLCAP_NOM_REG				= 0x23,
> +	LEARN_CFG_REG				= 0x28,
> +	FILTER_CFG_REG				= 0x29,
> +	MISCCFG_REG				= 0x2B,
> +	QRTABLE20_REG				= 0x32,
> +	FULLCAP_REP_REG				= 0x35,
> +	RCOMP_REG				= 0x38,
> +	VEMPTY_REG				= 0x3A,
> +	FSTAT_REG				= 0x3D,
> +	DISCHARGE_THRESHOLD_REG			= 0x40,
> +	QRTABLE30_REG				= 0x42,
> +	ISYS_REG				= 0x43,
> +	DQACC_REG				= 0x45,
> +	DPACC_REG				= 0x46,
> +	AVGISYS_REG				= 0x4B,
> +	QH_REG					= 0x4D,
> +	VSYS_REG				= 0xB1,
> +	TALRTTH2_REG				= 0xB2,
> +	VBYP_REG				= 0xB3,
> +	CONFIG2_REG				= 0xBB,
> +	IIN_REG					= 0xD0,
> +	OCV_REG					= 0xEE,
> +	VFOCV_REG				= 0xFB,
> +	VFSOC_REG				= 0xFF,
> +
> +	MAX77705_FG_END,
> +};
> +
> +enum max77705_led_reg {
> +	MAX77705_RGBLED_REG_BASE = 0x30,
> +	MAX77705_RGBLED_REG_LEDEN = 0,

Here too.

> +	MAX77705_RGBLED_REG_LED0BRT,
> +	MAX77705_RGBLED_REG_LED1BRT,
> +	MAX77705_RGBLED_REG_LED2BRT,
> +	MAX77705_RGBLED_REG_LED3BRT,
> +	MAX77705_RGBLED_REG_LEDRMP,
> +	MAX77705_RGBLED_REG_LEDBLNK,
> +	MAX77705_LED_REG_END
> +};
> +
> +enum max77705_charger_battery_state {
> +	MAX77705_BATTERY_NOBAT,
> +	MAX77705_BATTERY_PREQUALIFICATION,
> +	MAX77705_BATTERY_DEAD,
> +	MAX77705_BATTERY_GOOD,
> +	MAX77705_BATTERY_LOWVOLTAGE,
> +	MAX77705_BATTERY_OVERVOLTAGE,
> +	MAX77705_BATTERY_RESERVED,
> +};
> +
> +enum max77705_charger_charge_type {
> +	MAX77705_CHARGER_CONSTANT_CURRENT	= 1,
> +	MAX77705_CHARGER_CONSTANT_VOLTAGE,
> +	MAX77705_CHARGER_END_OF_CHARGE,
> +	MAX77705_CHARGER_DONE,
> +};
> +
> +extern const struct dev_pm_ops max77705_pm_ops;
> +
> +#endif /* __LINUX_MFD_MAX77705_PRIV_H */
> 
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]


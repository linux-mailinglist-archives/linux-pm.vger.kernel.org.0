Return-Path: <linux-pm+bounces-15659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4099EFA7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451A92829CB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E71C07C3;
	Tue, 15 Oct 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKfjf2Dk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB561AF0AA;
	Tue, 15 Oct 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002815; cv=none; b=JWniz83041UA2RI4WVwcgmck84ubeplH4Qi4ncPhvlpMS2oAQTS1kpFq+BNMBZi8ntYrXRttk5eMUTDpkQrsNx96hh2Ddeqmf0WL+xYrogr4WaYJoNNjWlFImngEy35lll6T6IscVWK5wJnJ+XIy+pTqjplhpRz8hZ57CbC65Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002815; c=relaxed/simple;
	bh=PNMJc04pU83VuuyPs3myh2JVU41q5r+y1toi+Wk/W0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrDyMTFrFh1tgSc94sspDtG025CDhE3ogX76TWgZ4hRX6VqFqTGBuq9kyrELbNY84MhN+JLQACVkEymIoAsxgB4oq+CDomqu2TQ9NaMH+ORbGs96cNVD+CfsNta9UnhTAkdop0mTkez9EFOollD30Hoc33g6lcRZz8t9/8+A41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKfjf2Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C810C4CEC6;
	Tue, 15 Oct 2024 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002814;
	bh=PNMJc04pU83VuuyPs3myh2JVU41q5r+y1toi+Wk/W0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKfjf2DkuDwwCU82M6UHX06chmOI+WDD2mhjgqrAQDG2t7dk+ig/OEcVdNtFkkyVB
	 PDSJ7jl8ORsRRkDfgPglFEdHjlUxAeAjWXY4l/gJpzSci6CIdYKkLHoZB2MUcYucbG
	 sBxrbAEtcg7hGL4RAsl4dRshgIgIpf9iYy75SL1uib2R4SkrezMk3kb4c46pONJNe9
	 Xsm58y9DqWbDj3SBCojy9D7rouqKCOPMsz82eRE9f+NFHFmD2qthHgEYlHbW+3aAyA
	 02uRYfaKaFMHIrxWVwXmru/arqZVqFVu+Vb6hj7fIw1/vnX/JkvWdXCiIO+QYQzgc1
	 23yn48mym8e3g==
Date: Tue, 15 Oct 2024 15:33:29 +0100
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
Subject: Re: [PATCH v6 7/7] leds: max77705: Add LEDs support
Message-ID: <20241015143329.GJ8348@google.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-7-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-7-0d38b5090c57@gmail.com>

On Mon, 07 Oct 2024, Dzmitry Sankouski wrote:

> This adds basic support for LEDs for the max77705 PMIC.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes for v5:
> - use same hardware name in Kconfig and module descriptions
> - remove copyrighter owner from module authors
> 
> Changes in v4:
> - inline BLINK_(ON|OFF) macro
> - remove camel case
> - drop backwards compatibility(new driver)
> - drop module alias
> ---
>  MAINTAINERS                  |   1 +
>  drivers/leds/Kconfig         |   6 ++++++
>  drivers/leds/Makefile        |   1 +
>  drivers/leds/leds-max77705.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Lol!  How big is your terminal? :)

>  4 files changed, 165 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4bc9c0da6adb..66a1dd7577c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14079,6 +14079,7 @@ F:	drivers/*/max14577*.c
>  F:	drivers/*/max77686*.c
>  F:	drivers/*/max77693*.c
>  F:	drivers/*/max77705*.c
> +F:	drivers/leds/leds-max77705.c

Alphabetical?

>  F:	drivers/clk/clk-max77686.c
>  F:	drivers/extcon/extcon-max14577.c
>  F:	drivers/extcon/extcon-max77693.c
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b784bb74a837..a8492623caa4 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -753,6 +753,12 @@ config LEDS_MAX77650
>  	help
>  	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated.
>  
> +config LEDS_MAX77705
> +	tristate "LED support for Maxim MAX77705 PMIC"
> +	depends on MFD_MAX77705 && LEDS_CLASS && I2C

If MFD_MAX77705 depends on I2C, you shouldn't need that here.

> +	help
> +	  LED driver for MAX77705 MFD chip from Maxim Integrated.

No such thing as an "MFD chip".

> +
>  config LEDS_MAX8997
>  	tristate "LED support for MAX8997 PMIC"
>  	depends on LEDS_CLASS && MFD_MAX8997
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 18afbb5a23ee..096bf244527d 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
>  obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
>  obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
>  obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
> +obj-$(CONFIG_LEDS_MAX77705)		+= leds-max77705.o
>  obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>  obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
>  obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
> diff --git a/drivers/leds/leds-max77705.c b/drivers/leds/leds-max77705.c
> new file mode 100644
> index 000000000000..50af81fb7324
> --- /dev/null
> +++ b/drivers/leds/leds-max77705.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Based on leds-max77650 driver:
> +//		Copyright (C) 2018 BayLibre SAS
> +//		Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>

You don't need to do that.

> +//
> +// LED driver for MAXIM 77705 MFD.

Remove MFD from everywhere.

> +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>

Only the SPDX in C++ please.

> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/max77705-private.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77705_LED_NUM_LEDS		4
> +#define MAX77705_LED_EN_MASK		GENMASK(1, 0)
> +#define MAX77705_LED_MAX_BRIGHTNESS	0xff
> +
> +struct max77705_led {
> +	struct led_classdev cdev;
> +	struct regmap *regmap;
> +	unsigned int en_shift;
> +	unsigned int reg_brightness;
> +};
> +
> +static struct max77705_led *max77705_to_led(struct led_classdev *cdev)
> +{
> +	return container_of(cdev, struct max77705_led, cdev);
> +}
> +
> +static int max77705_rgb_blink(struct led_classdev *cdev,
> +				unsigned long *delay_on,
> +				unsigned long *delay_off)
> +{
> +	struct max77705_led *led = max77705_to_led(cdev);
> +	int value, on_value, off_value;
> +
> +	on_value = (((*delay_on < 100) ? 0 :
> +			(*delay_on < 500) ? *delay_on/100 - 1 :
> +			(*delay_on < 3250) ? (*delay_on - 500) / 250 + 4 : 15) << 4);
> +	off_value = ((*delay_off < 1) ? 0x00 :
> +			(*delay_off < 500) ? 0x01 :
> +			(*delay_off < 5000) ? *delay_off / 500 :
> +			(*delay_off < 8000) ? (*delay_off - 5000) / 1000 + 10 :
> +			(*delay_off < 12000) ? (*delay_off - 8000) / 2000 + 13 : 15);

These nested ternary are pretty miserable.  Please break them out.

Also all of these magic numbers probably need defining so the maths
becomes easier to follow for humans.

> +	value = on_value | off_value;
> +	return regmap_write(led->regmap, MAX77705_RGBLED_REG_LEDBLNK, value);
> +}
> +
> +static int max77705_led_brightness_set(struct led_classdev *cdev,
> +					enum led_brightness brightness)
> +{
> +	struct max77705_led *led = max77705_to_led(cdev);
> +	int ret;

Pop the ret on the bottom, if no other reason than for my OCD!

> +	unsigned long blink_default = 0;
> +
> +	if (brightness == LED_OFF) {
> +		// Flash OFF

No C++ comments please.

> +		ret = regmap_update_bits(led->regmap,
> +					MAX77705_RGBLED_REG_LEDEN,
> +					MAX77705_LED_EN_MASK << led->en_shift, 0);
> +		max77705_rgb_blink(cdev, &blink_default, &blink_default);
> +	} else {
> +		// Set current
> +		ret = regmap_write(led->regmap,
> +				   led->reg_brightness, brightness);

Line wrap at 100-chars.

> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_update_bits(led->regmap,
> +					MAX77705_RGBLED_REG_LEDEN, LED_ON << led->en_shift,
> +					MAX77705_LED_EN_MASK << led->en_shift);
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77705_led_probe(struct platform_device *pdev)
> +{
> +	struct fwnode_handle *child;
> +	struct max77705_led *leds, *led;
> +	struct device *dev;
> +	struct regmap *map;

s/map/regmap/

> +	int rv, num_leds;

What's rv?  If it's "return value", then please just use ret.

> +	u32 reg;
> +
> +	dev = &pdev->dev;

Do this during the declaration

> +	leds = devm_kcalloc(dev, sizeof(*leds),
> +				MAX77705_LED_NUM_LEDS, GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	map = dev_get_regmap(dev->parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	num_leds = device_get_child_node_count(dev);
> +	if (!num_leds || num_leds > MAX77705_LED_NUM_LEDS)

num_leds < 0

> +		return -ENODEV;
> +
> +	device_for_each_child_node(dev, child) {

If you use the _scoped version, you can drop the gotos.

> +		struct led_init_data init_data = {};
> +
> +		rv = fwnode_property_read_u32(child, "reg", &reg);
> +		if (rv || reg >= MAX77705_LED_NUM_LEDS) {
> +			rv = -EINVAL;
> +			goto err_node_put;
> +		}
> +
> +		led = &leds[reg];
> +		led->regmap = map;
> +		led->reg_brightness = MAX77705_RGBLED_REG_LED0BRT + reg;
> +		led->en_shift = 2 * reg;

Why 2?

> +		led->cdev.brightness_set_blocking = max77705_led_brightness_set;
> +		led->cdev.blink_set = max77705_rgb_blink;
> +		led->cdev.max_brightness = MAX77705_LED_MAX_BRIGHTNESS;
> +
> +		init_data.fwnode = child;
> +		init_data.devicename = "max77705";

You don't want to use the label as the devicename?

https://github.com/torvalds/linux/blob/master/drivers/leds/led-core.c#L526

> +
> +		rv = devm_led_classdev_register_ext(dev, &led->cdev,
> +							&init_data);
> +		if (rv)
> +			goto err_node_put;
> +
> +		rv = max77705_led_brightness_set(&led->cdev, LED_OFF);
> +		if (rv)
> +			goto err_node_put;
> +	}
> +
> +	return 0;

'\n' here.

> +err_node_put:
> +	fwnode_handle_put(child);
> +	return rv;
> +}
> +
> +static const struct of_device_id max77705_led_of_match[] = {
> +	{ .compatible = "maxim,max77705-led" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77705_led_of_match);
> +
> +static struct platform_driver max77705_led_driver = {
> +	.driver = {
> +		.name = "max77705-led",
> +		.of_match_table = max77705_led_of_match,
> +	},
> +	.probe = max77705_led_probe,
> +};
> +module_platform_driver(max77705_led_driver);
> +
> +MODULE_DESCRIPTION("Maxim MAX77705 LED driver");
> +MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]


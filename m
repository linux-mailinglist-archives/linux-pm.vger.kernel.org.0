Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30A32B1856
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 10:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKMJh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 04:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKMJhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 04:37:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B26C0617A6
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 01:37:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so7772234wmh.4
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 01:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZchWVqYUt/lS8DYtOsUcSqWAZLfZ47tBMaD11Li0pts=;
        b=MmHs05EYYQKgQcSGbFHZa07bNMdaq6fAMtA0GK2gjWc7e2+w++NE1QglcibGR0T6qr
         PiabNnnrx3pCZOjBF5qNlvfAm6SIs22ElbcX0cc7FBaeHb0BFNMoiPhTW7XWtQTgHTv8
         DS7DjAfGR/mweUQbddKu+lUQTj6ieQwP/nDtkOdXp4ZaxOVAyg29BERI+upUzfefpE2i
         PQHD+v15cb9ZDyzwsT7a3TWxsYWQAebBIG+Xrc5kNYcBMmPAg9q9nSuyLencW18+LRVl
         7vxMg8ZFJ9qT5t/NH03NiMT6hmL/rJJ5pn4OBUOV7wBHcDJNURy5H1LW/whpHUPgm38k
         Yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZchWVqYUt/lS8DYtOsUcSqWAZLfZ47tBMaD11Li0pts=;
        b=KqT55MpZvjVWwALlDo61v57Ft/nP33u/8CWhfaEp6xAFHac6d+mpLqWxfdz/uWsNfn
         Y7uOq1Bo+nOnDQRTYXs/WqY1aygutgWRXSEngoAGZ1VmZGmLPfinTI8cz2eK2IPvQ4xV
         FVPjpfNR7UfmU5t7+ctR0xVTNHl4Rxs5+bLncTY1aM1StTXUHFcma8uN834rFnMjaCBm
         IHKxmJBr/Ia5Jcy9uagfn+rrvWsOjj/CG2g96PNAAQsEl0Hpi7GgAeypmHIfJj3n4M09
         0PulHok5+pTxyxcGfhOBnueOIX/+TIymxOA69DRgs5A+U71YoCC6HU7q/Iiet4wEK4QJ
         WJIQ==
X-Gm-Message-State: AOAM533T5z89ijEUZiEnAMzhBtwQFfiy1sLujxo2ejqVyls5+8e8JWxT
        9xkpQ+J1XP1jQ8MBWPcYHXUgMw==
X-Google-Smtp-Source: ABdhPJzMRzlPRDLEIUvvH6HB5GYnbIQqmvUnhOHk/v3lwbeNtpgLbz6w0llziPFMUee4sPvPS/F+vA==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr1519974wma.7.1605260270278;
        Fri, 13 Nov 2020 01:37:50 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id b63sm10284814wme.9.2020.11.13.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 01:37:49 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:37:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
Message-ID: <20201113093747.GJ2787115@dell>
References: <20201104203403.24937-1-digetx@gmail.com>
 <20201104203403.24937-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104203403.24937-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 04 Nov 2020, Dmitry Osipenko wrote:

> Acer Iconia Tab A500 is an Android tablet device, it has ENE KB930
> Embedded Controller which provides battery-gauge, LED, GPIO and some
> other functions. The EC uses firmware that is specifically customized
> for Acer A500. This patch adds MFD driver for the Embedded Controller
> which allows to power-off / reboot the A500 device, it also provides
> a common register read/write API that will be used by the sub-devices.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/Kconfig        |  12 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/acer-ec-a500.c | 203 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/mfd/acer-ec-a500.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13669bf..527ba5054d80 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2097,6 +2097,18 @@ config MFD_KHADAS_MCU
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_ACER_A500_EC
> +	tristate "Embedded Controller driver for Acer Iconia Tab A500"

Drop "driver".  This is meant to be describing the device.

> +	depends on I2C

depends on OF ?

> +	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP
> +	help
> +	  Support for Acer Iconia Tab A500 Embedded Controller.
> +
> +	  The controller itself is ENE KB930, it is running firmware
> +	  customized for the specific needs of the Acer A500 hardware.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 1780019d2474..7bfc57c8b363 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -263,6 +263,7 @@ obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> +obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
> new file mode 100644
> index 000000000000..2785a6d9bcc4
> --- /dev/null
> +++ b/drivers/mfd/acer-ec-a500.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MFD driver for Acer Iconia Tab A500 Embedded Controller.

An "MFD" isn't a thing.  Please describe the device.

> + * Copyright 2020 GRATE-driver project.
> + *
> + * Based on downstream driver from Acer Inc.

Most drivers are.  Not sure this is required.

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reboot.h>

Alphabetical please. ;)

> +#define A500_EC_I2C_ERR_TIMEOUT		500
> +#define A500_EC_POWER_CMD_TIMEOUT	1000
> +
> +enum {
> +	REG_CURRENT_NOW = 0x03,
> +	REG_SHUTDOWN = 0x52,
> +	REG_WARM_REBOOT = 0x54,
> +	REG_COLD_REBOOT = 0x55,
> +};
> +
> +static struct i2c_client *a500_ec_client_pm_off;
> +
> +static int a500_ec_read(void *context, const void *reg_buf, size_t reg_size,
> +			void *val_buf, size_t val_sizel)
> +{
> +	struct i2c_client *client = context;
> +	unsigned int reg, retries = 5;
> +	u16 *ret_val = val_buf;
> +	s32 ret = 0;
> +
> +	if (reg_size != 1 || val_sizel != 2)

No magic numbers please.

What does this *mean*?

> +		return -EOPNOTSUPP;

Why EOPNOTSUPP?

> +	reg = *(u8 *)reg_buf;
> +
> +	while (retries-- > 0) {
> +		ret = i2c_smbus_read_word_data(client, reg);
> +		if (ret >= 0)
> +			break;
> +
> +		msleep(A500_EC_I2C_ERR_TIMEOUT);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "read 0x%x failed: %d\n", reg, ret);
> +		return ret;
> +	}
> +
> +	*ret_val = ret;
> +
> +	if (reg == REG_CURRENT_NOW)
> +		fsleep(10000);

Ooo, new toy!

> +	return 0;
> +}

I'm surprised there isn't a generic function which does this kind of
read.  Seems like pretty common/boilerplate stuff.

> +static int a500_ec_write(void *context, const void *data, size_t count)
> +{
> +	struct i2c_client *client = context;
> +	unsigned int reg, val, retries = 5;
> +	s32 ret = 0;
> +
> +	if (count != 3)

Define or comment needed.

> +		return -EOPNOTSUPP;
> +
> +	reg = *(u8  *)(data + 0);
> +	val = *(u16 *)(data + 1);
> +
> +	while (retries-- > 0) {
> +		ret = i2c_smbus_write_word_data(client, reg, val);
> +		if (ret >= 0)
> +			break;
> +
> +		msleep(A500_EC_I2C_ERR_TIMEOUT);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "write 0x%x failed: %d\n", reg, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

Again, seems pretty boilerplate.  Are you sure there isn't a helper?

> +static const struct regmap_config a500_ec_regmap_config = {
> +	.name = "KB930",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0xff,
> +};
> +
> +static const struct regmap_bus a500_ec_regmap_bus = {
> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +	.write = a500_ec_write,
> +	.read = a500_ec_read,
> +	.max_raw_read = 2,
> +};
> +
> +static void a500_ec_poweroff(void)
> +{
> +	i2c_smbus_write_word_data(a500_ec_client_pm_off, REG_SHUTDOWN, 0);
> +
> +	mdelay(A500_EC_POWER_CMD_TIMEOUT);
> +}
> +
> +static int a500_ec_restart_notify(struct notifier_block *this,
> +				  unsigned long reboot_mode, void *data)
> +{
> +	if (reboot_mode == REBOOT_WARM)
> +		i2c_smbus_write_word_data(a500_ec_client_pm_off,
> +					  REG_WARM_REBOOT, 0);
> +	else
> +		i2c_smbus_write_word_data(a500_ec_client_pm_off,
> +					  REG_COLD_REBOOT, 1);

What's with the magic '0' and '1's at the end?

> +	mdelay(A500_EC_POWER_CMD_TIMEOUT);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block a500_ec_restart_handler = {
> +	.notifier_call = a500_ec_restart_notify,
> +	.priority = 200,
> +};
> +
> +static const struct mfd_cell a500_ec_cells[] = {
> +	{ .name = "acer-a500-iconia-battery", },
> +	{ .name = "acer-a500-iconia-leds", },
> +};
> +
> +static int a500_ec_probe(struct i2c_client *client)
> +{
> +	struct regmap *rmap;

'rmap' barely makes the top 10:

$ git grep -ho "struct regmap \*[a-z]*" | sort | uniq -c | sort -rn | head
   1814 struct regmap *regmap
    581 struct regmap *map
     97 struct regmap *
     50 struct regmap *syscon
     50 struct regmap *r
     35 struct regmap *reg
     34 struct regmap *cfgchip
     32 struct regmap *grf
     30 struct regmap *rmap
     27 struct regmap *base

Please use regmap here.

> +	int err;
> +
> +	rmap = devm_regmap_init(&client->dev, &a500_ec_regmap_bus,
> +				client, &a500_ec_regmap_config);
> +	if (IS_ERR(rmap))
> +		return PTR_ERR(rmap);
> +
> +	/* register battery and LED sub-devices */

This comment is superfluous and is just the type of documentation that
becomes out-of-date quickly.

> +	err = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> +				   a500_ec_cells, ARRAY_SIZE(a500_ec_cells),
> +				   NULL, 0, NULL);
> +	if (err) {
> +		dev_err(&client->dev, "failed to add sub-devices: %d\n", err);
> +		return err;
> +	}
> +
> +	/* set up power management functions */

We know what "power" and "pm" mean.  You can safely remove this
comment.

> +	if (of_device_is_system_power_controller(client->dev.of_node)) {
> +		a500_ec_client_pm_off = client;
> +
> +		err = register_restart_handler(&a500_ec_restart_handler);
> +		if (err)
> +			return err;
> +
> +		if (!pm_power_off)
> +			pm_power_off = a500_ec_poweroff;
> +	}
> +
> +	return 0;
> +}
> +
> +static int a500_ec_remove(struct i2c_client *client)
> +{
> +	if (of_device_is_system_power_controller(client->dev.of_node)) {
> +		if (pm_power_off == a500_ec_poweroff)
> +			pm_power_off = NULL;
> +
> +		unregister_restart_handler(&a500_ec_restart_handler);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id a500_ec_match[] = {
> +	{ .compatible = "acer,a500-iconia-ec" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, a500_ec_match);
> +
> +static struct i2c_driver a500_ec_driver = {
> +	.driver = {
> +		.name = "acer-a500-embedded-controller",
> +		.of_match_table = a500_ec_match,
> +	},
> +	.probe_new = a500_ec_probe,
> +	.remove = a500_ec_remove,
> +};
> +module_i2c_driver(a500_ec_driver);
> +
> +MODULE_DESCRIPTION("Acer Iconia Tab A500 Embedded Controller driver");
> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

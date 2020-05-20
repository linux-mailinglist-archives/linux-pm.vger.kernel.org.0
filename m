Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0821DAE33
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETJBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETJBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 05:01:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE695C061A0E
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 02:01:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so2287780wrt.9
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QeYaaXZZw9ORQT3wBCin6SxHrsWXeI0gT1M2vCWZaEc=;
        b=F5kD6mQInuUcyU9yGshGXQzconuyPVBA6Ez/4AZPpnnaa2jmzqCmVJCtCqhGMqLTdC
         Jgya1C1i9bepk56ABcDUYRtj3IlN12x6ZDJcgJA3HsoCNJeOUzcz58SdXWFObBRcELgf
         OEN4fkkDIf6tWw9VCrBZam+HqnfYu2FfETz/lEfLMFYV6mgpKise3ONe5djPyl+Bi2H1
         C42RyJjiSWujQIGx6Jrve5yNtmJw8N6IBPmSIWLGu/zkEVPljTQ4VrqTArDwkVywW1Lh
         T0VtbOBg56V68eGihVYfjDcuX0khokqSaX4UCKbvSk9bUOIq04Q7ju7qX3tK5Rul92Cy
         JMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QeYaaXZZw9ORQT3wBCin6SxHrsWXeI0gT1M2vCWZaEc=;
        b=lUBDL3XIVB4IQU4RI+s2ERBtW87JOR3MEboovR4Nmrnibf/tuW1uZPo6dXWWygJlKs
         ac6+RIYqwZf924N5ja88z0jmORhNOpoL98tHG7a3wKqeuyeZyYM8WBjh/1CpkRlXcpBX
         wWpUQv7zsrhQyjXCrPvo4qZYRzddofU4oxqLbrsPwc3nSfnD4iwIpF8RrTNRr3Hz/KpC
         Icjk87d9MMI7xd4d1vYCA7cTcMi+zHStrS1fHxaOOrijEgpU4tZhc0GavzKk/F1FRphN
         sqONBQ+Epj3Pg5Tv/m9qzo1/CbuYCUujitQJYTYROaF2LBfvNvVNUs8INsa5GcnMUOA2
         NW9Q==
X-Gm-Message-State: AOAM533UJejv99fXPrYgq8Zukr5XfyM3yoEKxmv1BSZjk5rwGYb8qUAl
        oI1j/WO9Xpbf9P9nG++tzbs+5w==
X-Google-Smtp-Source: ABdhPJwWj3KF9iYchOy01+W/VOC49PrFEZ9IBPSmXWUC8JJTARZTapa3xqsQpc6Uf5AbSNPQJ4t49w==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr1221393wrp.338.1589965264473;
        Wed, 20 May 2020 02:01:04 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id d6sm2333510wra.63.2020.05.20.02.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:01:03 -0700 (PDT)
Date:   Wed, 20 May 2020 10:01:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mfd: add support for the Khadas System control
 Microcontroller
Message-ID: <20200520090101.GE271301@dell>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
 <20200512132613.31507-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512132613.31507-3-narmstrong@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 May 2020, Neil Armstrong wrote:

> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> boards.
> 
> It has multiple boot control features like password check, power-on
> options, power-off control and system FAN control on recent boards.
> 
> This implements a very basic MFD driver with the fan control and User
> NVMEM cells.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mfd/Kconfig            |  14 ++++
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/khadas-mcu.c       | 143 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/khadas-mcu.h |  91 +++++++++++++++++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 drivers/mfd/khadas-mcu.c
>  create mode 100644 include/linux/mfd/khadas-mcu.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0a59249198d3..b95091397052 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2003,6 +2003,20 @@ config MFD_WCD934X
>  	  This driver provides common support WCD934x audio codec and its
>  	  associated Pin Controller, Soundwire Controller and Audio codec.
>  
> +config MFD_KHADAS_MCU
> +	tristate "Support for Khadas System control Microcontroller"
> +	depends on I2C
> +	depends on OF || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Support for the Khadas System control Microcontroller interface present
> +	  on their VIM and Edge boards.
> +
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.

It would be good to describe the device here.

>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f935d10cbf0f..0f1633b096bb 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -257,5 +257,6 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
>  obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> +obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> new file mode 100644
> index 000000000000..6d08fa2e373a
> --- /dev/null
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Khadas System control Microcontroller
> + *
> + * Copyright (C) 2020 BayLibre SAS

Nit: '\n' here please.

> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/khadas-mcu.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>

Alphabetical.

> +static bool khadas_mcu_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	if (reg >= KHADAS_MCU_USER_DATA_0_REG &&
> +	    reg < KHADAS_MCU_PWR_OFF_CMD_REG)
> +		return true;
> +
> +	switch (reg) {
> +	case KHADAS_MCU_PWR_OFF_CMD_REG:
> +	case KHADAS_MCU_PASSWD_START_REG:
> +	case KHADAS_MCU_CHECK_VEN_PASSWD_REG:
> +	case KHADAS_MCU_CHECK_USER_PASSWD_REG:
> +	case KHADAS_MCU_WOL_INIT_START_REG:
> +	case KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool khadas_mcu_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case KHADAS_MCU_PASSWD_VEN_0_REG:
> +	case KHADAS_MCU_PASSWD_VEN_1_REG:
> +	case KHADAS_MCU_PASSWD_VEN_2_REG:
> +	case KHADAS_MCU_PASSWD_VEN_3_REG:
> +	case KHADAS_MCU_PASSWD_VEN_4_REG:
> +	case KHADAS_MCU_PASSWD_VEN_5_REG:
> +	case KHADAS_MCU_MAC_0_REG:
> +	case KHADAS_MCU_MAC_1_REG:
> +	case KHADAS_MCU_MAC_2_REG:
> +	case KHADAS_MCU_MAC_3_REG:
> +	case KHADAS_MCU_MAC_4_REG:
> +	case KHADAS_MCU_MAC_5_REG:
> +	case KHADAS_MCU_USID_0_REG:
> +	case KHADAS_MCU_USID_1_REG:
> +	case KHADAS_MCU_USID_2_REG:
> +	case KHADAS_MCU_USID_3_REG:
> +	case KHADAS_MCU_USID_4_REG:
> +	case KHADAS_MCU_USID_5_REG:
> +	case KHADAS_MCU_VERSION_0_REG:
> +	case KHADAS_MCU_VERSION_1_REG:
> +	case KHADAS_MCU_DEVICE_NO_0_REG:
> +	case KHADAS_MCU_DEVICE_NO_1_REG:
> +	case KHADAS_MCU_FACTORY_TEST_REG:
> +	case KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config khadas_mcu_regmap_config = {
> +	.reg_bits	= 8,
> +	.reg_stride	= 1,
> +	.val_bits	= 8,
> +	.max_register	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +	.volatile_reg	= khadas_mcu_reg_volatile,
> +	.writeable_reg	= khadas_mcu_reg_writeable,
> +	.cache_type	= REGCACHE_RBTREE,
> +};
> +
> +static struct mfd_cell khadas_mcu_fan_cells[] = {
> +	/* Feature supported only on VIM1/2 Rev13+ and VIM3 */

Doesn't read great.

Consider reversing or make the sentence more succinct.

"VIM1/2 Rev13+ and VIM3 only"

> +	{ .name = "khadas-mcu-fan-ctrl", },
> +};
> +
> +static struct mfd_cell khadas_mcu_cells[] = {
> +	/* Features supported on all board revisions */

I think we can omit this.

> +	{ .name = "khadas-mcu-user-mem", },
> +};
> +
> +static int khadas_mcu_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct khadas_mcu *khadas_mcu;

Prefer a rename to 'ddata'.

> +	int ret;
> +
> +	khadas_mcu = devm_kzalloc(dev, sizeof(*khadas_mcu), GFP_KERNEL);
> +	if (!khadas_mcu)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, khadas_mcu);
> +
> +	khadas_mcu->dev = dev;
> +
> +	khadas_mcu->map = devm_regmap_init_i2c(client,
> +					       &khadas_mcu_regmap_config);

Prefer a rename to 'regmap'.

> +	if (IS_ERR(khadas_mcu->map)) {
> +		ret = PTR_ERR(khadas_mcu->map);
> +		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   khadas_mcu_cells,
> +				   ARRAY_SIZE(khadas_mcu_cells),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (of_find_property(dev->of_node, "#cooling-cells", NULL))
> +		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +					    khadas_mcu_fan_cells,
> +					    ARRAY_SIZE(khadas_mcu_fan_cells),
> +					    NULL, 0, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id khadas_mcu_of_match[] = {
> +	{ .compatible = "khadas,mcu", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
> +
> +static struct i2c_driver khadas_mcu_driver = {
> +	.driver = {
> +		.name = "khadas-mcu-core",
> +		.of_match_table = of_match_ptr(khadas_mcu_of_match),
> +	},
> +	.probe = khadas_mcu_probe,
> +};
> +module_i2c_driver(khadas_mcu_driver);
> +
> +MODULE_DESCRIPTION("Khadas MCU core driver");
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
> new file mode 100644
> index 000000000000..2e68af21735c
> --- /dev/null
> +++ b/include/linux/mfd/khadas-mcu.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Khadas System control Microcontroller Register map
> + *
> + * Copyright (C) 2020 BayLibre SAS

Nit: '\n'

> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#ifndef MFD_KHADAS_MCU_H
> +#define MFD_KHADAS_MCU_H
> +
> +#define KHADAS_MCU_PASSWD_VEN_0_REG		0x0 /* RO */

Nit: Can you pad these please?

> +#define KHADAS_MCU_PASSWD_VEN_1_REG		0x1 /* RO */
> +#define KHADAS_MCU_PASSWD_VEN_2_REG		0x2 /* RO */
> +#define KHADAS_MCU_PASSWD_VEN_3_REG		0x3 /* RO */
> +#define KHADAS_MCU_PASSWD_VEN_4_REG		0x4 /* RO */
> +#define KHADAS_MCU_PASSWD_VEN_5_REG		0x5 /* RO */
> +#define KHADAS_MCU_MAC_0_REG			0x6 /* RO */
> +#define KHADAS_MCU_MAC_1_REG			0x7 /* RO */
> +#define KHADAS_MCU_MAC_2_REG			0x8 /* RO */
> +#define KHADAS_MCU_MAC_3_REG			0x9 /* RO */
> +#define KHADAS_MCU_MAC_4_REG			0xa /* RO */
> +#define KHADAS_MCU_MAC_5_REG			0xb /* RO */
> +#define KHADAS_MCU_USID_0_REG			0xc /* RO */
> +#define KHADAS_MCU_USID_1_REG			0xd /* RO */
> +#define KHADAS_MCU_USID_2_REG			0xe /* RO */
> +#define KHADAS_MCU_USID_3_REG			0xf /* RO */
> +#define KHADAS_MCU_USID_4_REG			0x10 /* RO */
> +#define KHADAS_MCU_USID_5_REG			0x11 /* RO */
> +#define KHADAS_MCU_VERSION_0_REG		0x12 /* RO */
> +#define KHADAS_MCU_VERSION_1_REG		0x13 /* RO */
> +#define KHADAS_MCU_DEVICE_NO_0_REG		0x14 /* RO */
> +#define KHADAS_MCU_DEVICE_NO_1_REG		0x15 /* RO */
> +#define KHADAS_MCU_FACTORY_TEST_REG		0x16 /* R */
> +#define KHADAS_MCU_BOOT_MODE_REG		0x20 /* RW */
> +#define KHADAS_MCU_BOOT_EN_WOL_REG		0x21 /* RW */
> +#define KHADAS_MCU_BOOT_EN_RTC_REG		0x22 /* RW */
> +#define KHADAS_MCU_BOOT_EN_EXP_REG		0x23 /* RW */
> +#define KHADAS_MCU_BOOT_EN_IR_REG		0x24 /* RW */
> +#define KHADAS_MCU_BOOT_EN_DCIN_REG		0x25 /* RW */
> +#define KHADAS_MCU_BOOT_EN_KEY_REG		0x26 /* RW */
> +#define KHADAS_MCU_KEY_MODE_REG			0x27 /* RW */
> +#define KHADAS_MCU_LED_MODE_ON_REG		0x28 /* RW */
> +#define KHADAS_MCU_LED_MODE_OFF_REG		0x29 /* RW */
> +#define KHADAS_MCU_SHUTDOWN_NORMAL_REG		0x2c /* RW */
> +#define KHADAS_MCU_MAC_SWITCH_REG		0x2d /* RW */
> +#define KHADAS_MCU_MCU_SLEEP_MODE_REG		0x2e /* RW */
> +#define KHADAS_MCU_IR_CODE1_0_REG		0x2f /* RW */
> +#define KHADAS_MCU_IR_CODE1_1_REG		0x30 /* RW */
> +#define KHADAS_MCU_IR_CODE1_2_REG		0x31 /* RW */
> +#define KHADAS_MCU_IR_CODE1_3_REG		0x32 /* RW */
> +#define KHADAS_MCU_USB_PCIE_SWITCH_REG		0x33 /* RW */
> +#define KHADAS_MCU_IR_CODE2_0_REG		0x34 /* RW */
> +#define KHADAS_MCU_IR_CODE2_1_REG		0x35 /* RW */
> +#define KHADAS_MCU_IR_CODE2_2_REG		0x36 /* RW */
> +#define KHADAS_MCU_IR_CODE2_3_REG		0x37 /* RW */
> +#define KHADAS_MCU_PASSWD_USER_0_REG		0x40 /* RW */
> +#define KHADAS_MCU_PASSWD_USER_1_REG		0x41 /* RW */
> +#define KHADAS_MCU_PASSWD_USER_2_REG		0x42 /* RW */
> +#define KHADAS_MCU_PASSWD_USER_3_REG		0x43 /* RW */
> +#define KHADAS_MCU_PASSWD_USER_4_REG		0x44 /* RW */
> +#define KHADAS_MCU_PASSWD_USER_5_REG		0x45 /* RW */
> +#define KHADAS_MCU_USER_DATA_0_REG		0x46 /* RW 56 bytes */
> +#define KHADAS_MCU_PWR_OFF_CMD_REG		0x80 /* WO */
> +#define KHADAS_MCU_PASSWD_START_REG		0x81 /* WO */
> +#define KHADAS_MCU_CHECK_VEN_PASSWD_REG		0x82 /* WO */
> +#define KHADAS_MCU_CHECK_USER_PASSWD_REG	0x83 /* WO */
> +#define KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG	0x86 /* RO */
> +#define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
> +#define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
> +
> +/* Boards */

I think the names make this superfluous.

> +enum {
> +	KHADAS_BOARD_VIM1 = 0x1,
> +	KHADAS_BOARD_VIM2,
> +	KHADAS_BOARD_VIM3,
> +	KHADAS_BOARD_EDGE = 0x11,
> +	KHADAS_BOARD_EDGE_V,
> +};
> +
> +/**
> + * struct khadas_mcu_data - Khadas MCU MFD structure

Doesn't match the struct name.

Prefer you drop the 'MFD' part.

> + * @device:		device reference used for logs
> + * @map:		register map
> + */
> +struct khadas_mcu {
> +	struct device *dev;
> +	struct regmap *map;
> +};
> +
> +#endif /* MFD_KHADAS_MCU_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

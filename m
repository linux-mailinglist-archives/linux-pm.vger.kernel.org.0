Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC941EB74E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgFBI0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBI0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 04:26:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23EC061A0E
        for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2020 01:26:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so2388833wru.12
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2020 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0K1GFxmKda8a4w4bqQh8yWgObnq0oAYFyzK4/4H4ces=;
        b=mQo0vKr1Szn2iACYkkjva3qBPhY/Mo7g5XoGYS/dC3cEsxjsezkXnUIb+1H4jPxbqf
         NkVlpKx6BRCffpmPgo0wH5PqstKdH3zEBuXp1SwwZbFgOtqdTDiIQ2eBzADU4t3Il2Th
         BDhVEIK0lcCzE3RigElG9Gvk82DJNBtddp1UrATt6sqeEGva/UZOS8tT+EzR9EGUgAXa
         7t3uzker8/2CzATPGmjcD7lO/E6uoFfNBPCSH6dCpW4SyS30D/KeeTqQBd/twS7F8vt5
         UOx5dwc7lsUF25+3EnA7xgBJoHu1WE6i1GZwhMDrrkJjV80ep711QABkHICl95AXiDsf
         aGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0K1GFxmKda8a4w4bqQh8yWgObnq0oAYFyzK4/4H4ces=;
        b=lsz15C1pmwbvwOGVjVKg328xBUs0UsZZ4lyUUTyO8taptdKRpvT5g5BCjhk5Pl9gHZ
         7lomM0kkJCQ7oj8U0IiTmdnHHBCb1sZEdU/VISisJyLa8djING4Af6dMhvU/UJo76Ij1
         iwp63elDKiB+uFODJLykjJjVo7HVqhoD7/r0+8EgwQkC/JcJPlA2lnmmRvsVxY9BkczI
         368mhIeNfqXmCm+weLbiwGUbiAetgMohpiq+faXKOX/0/zBCcsJlQMyxzNMZpXvqUrWB
         l+zLAy5u0Ym9IyWUi1x1WKMw4jtIQj8JK1cquZq9KLpaFFe/Zt9Ov6mS3VIWGj5PV2AN
         Sj8A==
X-Gm-Message-State: AOAM531EXD1QLXX7T4fTCM4GlxGUvZhO3FHrEGNF3VIqGeqclTKoayLq
        c07OGA4CupaywqtmFZf7ajZorg==
X-Google-Smtp-Source: ABdhPJxaED9b8OBAJ2ZJBNZ5mCQiMg3M1IGZxwVeYL718tqgka/sWcni+fQ7HYAAhFpkg8M/ijB35A==
X-Received: by 2002:a5d:4390:: with SMTP id i16mr24240134wrq.186.1591086400438;
        Tue, 02 Jun 2020 01:26:40 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:acf8:18a8:b3a5:a17b? ([2a01:e35:2ec0:82b0:acf8:18a8:b3a5:a17b])
        by smtp.gmail.com with ESMTPSA id s8sm2792975wrm.96.2020.06.02.01.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 01:26:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] mfd: add support for the Khadas System control
 Microcontroller
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200512132613.31507-1-narmstrong@baylibre.com>
 <20200512132613.31507-3-narmstrong@baylibre.com>
 <20200520090101.GE271301@dell>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <8837fa43-bf46-fdd1-472e-e5f0159dab2c@baylibre.com>
Date:   Tue, 2 Jun 2020 10:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520090101.GE271301@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/05/2020 11:01, Lee Jones wrote:
> On Tue, 12 May 2020, Neil Armstrong wrote:
> 
>> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
>> boards.
>>
>> It has multiple boot control features like password check, power-on
>> options, power-off control and system FAN control on recent boards.
>>
>> This implements a very basic MFD driver with the fan control and User
>> NVMEM cells.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mfd/Kconfig            |  14 ++++
>>  drivers/mfd/Makefile           |   1 +
>>  drivers/mfd/khadas-mcu.c       | 143 +++++++++++++++++++++++++++++++++
>>  include/linux/mfd/khadas-mcu.h |  91 +++++++++++++++++++++
>>  4 files changed, 249 insertions(+)
>>  create mode 100644 drivers/mfd/khadas-mcu.c
>>  create mode 100644 include/linux/mfd/khadas-mcu.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 0a59249198d3..b95091397052 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -2003,6 +2003,20 @@ config MFD_WCD934X
>>  	  This driver provides common support WCD934x audio codec and its
>>  	  associated Pin Controller, Soundwire Controller and Audio codec.
>>  
>> +config MFD_KHADAS_MCU
>> +	tristate "Support for Khadas System control Microcontroller"
>> +	depends on I2C
>> +	depends on OF || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	help
>> +	  Support for the Khadas System control Microcontroller interface present
>> +	  on their VIM and Edge boards.
>> +
>> +	  This driver provides common support for accessing the device,
>> +	  additional drivers must be enabled in order to use the functionality
>> +	  of the device.
> 
> It would be good to describe the device here.

Ok

> 
>>  menu "Multimedia Capabilities Port drivers"
>>  	depends on ARCH_SA1100
>>  
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index f935d10cbf0f..0f1633b096bb 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -257,5 +257,6 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
>>  obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>> +obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>>  
>>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
>> new file mode 100644
>> index 000000000000..6d08fa2e373a
>> --- /dev/null
>> +++ b/drivers/mfd/khadas-mcu.c
>> @@ -0,0 +1,143 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Khadas System control Microcontroller
>> + *
>> + * Copyright (C) 2020 BayLibre SAS
> 
> Nit: '\n' here please.

Ok

> 
>> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mfd/khadas-mcu.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/module.h>
> 
> Alphabetical.


Ok


> 
>> +static bool khadas_mcu_reg_volatile(struct device *dev, unsigned int reg)
>> +{
>> +	if (reg >= KHADAS_MCU_USER_DATA_0_REG &&
>> +	    reg < KHADAS_MCU_PWR_OFF_CMD_REG)
>> +		return true;
>> +
>> +	switch (reg) {
>> +	case KHADAS_MCU_PWR_OFF_CMD_REG:
>> +	case KHADAS_MCU_PASSWD_START_REG:
>> +	case KHADAS_MCU_CHECK_VEN_PASSWD_REG:
>> +	case KHADAS_MCU_CHECK_USER_PASSWD_REG:
>> +	case KHADAS_MCU_WOL_INIT_START_REG:
>> +	case KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static bool khadas_mcu_reg_writeable(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case KHADAS_MCU_PASSWD_VEN_0_REG:
>> +	case KHADAS_MCU_PASSWD_VEN_1_REG:
>> +	case KHADAS_MCU_PASSWD_VEN_2_REG:
>> +	case KHADAS_MCU_PASSWD_VEN_3_REG:
>> +	case KHADAS_MCU_PASSWD_VEN_4_REG:
>> +	case KHADAS_MCU_PASSWD_VEN_5_REG:
>> +	case KHADAS_MCU_MAC_0_REG:
>> +	case KHADAS_MCU_MAC_1_REG:
>> +	case KHADAS_MCU_MAC_2_REG:
>> +	case KHADAS_MCU_MAC_3_REG:
>> +	case KHADAS_MCU_MAC_4_REG:
>> +	case KHADAS_MCU_MAC_5_REG:
>> +	case KHADAS_MCU_USID_0_REG:
>> +	case KHADAS_MCU_USID_1_REG:
>> +	case KHADAS_MCU_USID_2_REG:
>> +	case KHADAS_MCU_USID_3_REG:
>> +	case KHADAS_MCU_USID_4_REG:
>> +	case KHADAS_MCU_USID_5_REG:
>> +	case KHADAS_MCU_VERSION_0_REG:
>> +	case KHADAS_MCU_VERSION_1_REG:
>> +	case KHADAS_MCU_DEVICE_NO_0_REG:
>> +	case KHADAS_MCU_DEVICE_NO_1_REG:
>> +	case KHADAS_MCU_FACTORY_TEST_REG:
>> +	case KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG:
>> +		return false;
>> +	default:
>> +		return true;
>> +	}
>> +}
>> +
>> +static const struct regmap_config khadas_mcu_regmap_config = {
>> +	.reg_bits	= 8,
>> +	.reg_stride	= 1,
>> +	.val_bits	= 8,
>> +	.max_register	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
>> +	.volatile_reg	= khadas_mcu_reg_volatile,
>> +	.writeable_reg	= khadas_mcu_reg_writeable,
>> +	.cache_type	= REGCACHE_RBTREE,
>> +};
>> +
>> +static struct mfd_cell khadas_mcu_fan_cells[] = {
>> +	/* Feature supported only on VIM1/2 Rev13+ and VIM3 */
> 
> Doesn't read great.
> 
> Consider reversing or make the sentence more succinct.
> 
> "VIM1/2 Rev13+ and VIM3 only"

Ok

> 
>> +	{ .name = "khadas-mcu-fan-ctrl", },
>> +};
>> +
>> +static struct mfd_cell khadas_mcu_cells[] = {
>> +	/* Features supported on all board revisions */
> 
> I think we can omit this.

Ok

> 
>> +	{ .name = "khadas-mcu-user-mem", },
>> +};
>> +
>> +static int khadas_mcu_probe(struct i2c_client *client,
>> +		       const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct khadas_mcu *khadas_mcu;
> 
> Prefer a rename to 'ddata'.

Ok

> 
>> +	int ret;
>> +
>> +	khadas_mcu = devm_kzalloc(dev, sizeof(*khadas_mcu), GFP_KERNEL);
>> +	if (!khadas_mcu)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, khadas_mcu);
>> +
>> +	khadas_mcu->dev = dev;
>> +
>> +	khadas_mcu->map = devm_regmap_init_i2c(client,
>> +					       &khadas_mcu_regmap_config);
>

Ok

> Prefer a rename to 'regmap'.
> 
>> +	if (IS_ERR(khadas_mcu->map)) {
>> +		ret = PTR_ERR(khadas_mcu->map);
>> +		dev_err(dev, "Failed to allocate register map: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>> +				   khadas_mcu_cells,
>> +				   ARRAY_SIZE(khadas_mcu_cells),
>> +				   NULL, 0, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (of_find_property(dev->of_node, "#cooling-cells", NULL))
>> +		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>> +					    khadas_mcu_fan_cells,
>> +					    ARRAY_SIZE(khadas_mcu_fan_cells),
>> +					    NULL, 0, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id khadas_mcu_of_match[] = {
>> +	{ .compatible = "khadas,mcu", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
>> +
>> +static struct i2c_driver khadas_mcu_driver = {
>> +	.driver = {
>> +		.name = "khadas-mcu-core",
>> +		.of_match_table = of_match_ptr(khadas_mcu_of_match),
>> +	},
>> +	.probe = khadas_mcu_probe,
>> +};
>> +module_i2c_driver(khadas_mcu_driver);
>> +
>> +MODULE_DESCRIPTION("Khadas MCU core driver");
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
>> new file mode 100644
>> index 000000000000..2e68af21735c
>> --- /dev/null
>> +++ b/include/linux/mfd/khadas-mcu.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Khadas System control Microcontroller Register map
>> + *
>> + * Copyright (C) 2020 BayLibre SAS
> 
> Nit: '\n'

Ok

> 
>> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#ifndef MFD_KHADAS_MCU_H
>> +#define MFD_KHADAS_MCU_H
>> +
>> +#define KHADAS_MCU_PASSWD_VEN_0_REG		0x0 /* RO */
> 
> Nit: Can you pad these please?

Ok

> 
>> +#define KHADAS_MCU_PASSWD_VEN_1_REG		0x1 /* RO */
>> +#define KHADAS_MCU_PASSWD_VEN_2_REG		0x2 /* RO */
>> +#define KHADAS_MCU_PASSWD_VEN_3_REG		0x3 /* RO */
>> +#define KHADAS_MCU_PASSWD_VEN_4_REG		0x4 /* RO */
>> +#define KHADAS_MCU_PASSWD_VEN_5_REG		0x5 /* RO */
>> +#define KHADAS_MCU_MAC_0_REG			0x6 /* RO */
>> +#define KHADAS_MCU_MAC_1_REG			0x7 /* RO */
>> +#define KHADAS_MCU_MAC_2_REG			0x8 /* RO */
>> +#define KHADAS_MCU_MAC_3_REG			0x9 /* RO */
>> +#define KHADAS_MCU_MAC_4_REG			0xa /* RO */
>> +#define KHADAS_MCU_MAC_5_REG			0xb /* RO */
>> +#define KHADAS_MCU_USID_0_REG			0xc /* RO */
>> +#define KHADAS_MCU_USID_1_REG			0xd /* RO */
>> +#define KHADAS_MCU_USID_2_REG			0xe /* RO */
>> +#define KHADAS_MCU_USID_3_REG			0xf /* RO */
>> +#define KHADAS_MCU_USID_4_REG			0x10 /* RO */
>> +#define KHADAS_MCU_USID_5_REG			0x11 /* RO */
>> +#define KHADAS_MCU_VERSION_0_REG		0x12 /* RO */
>> +#define KHADAS_MCU_VERSION_1_REG		0x13 /* RO */
>> +#define KHADAS_MCU_DEVICE_NO_0_REG		0x14 /* RO */
>> +#define KHADAS_MCU_DEVICE_NO_1_REG		0x15 /* RO */
>> +#define KHADAS_MCU_FACTORY_TEST_REG		0x16 /* R */
>> +#define KHADAS_MCU_BOOT_MODE_REG		0x20 /* RW */
>> +#define KHADAS_MCU_BOOT_EN_WOL_REG		0x21 /* RW */
>> +#define KHADAS_MCU_BOOT_EN_RTC_REG		0x22 /* RW */
>> +#define KHADAS_MCU_BOOT_EN_EXP_REG		0x23 /* RW */
>> +#define KHADAS_MCU_BOOT_EN_IR_REG		0x24 /* RW */
>> +#define KHADAS_MCU_BOOT_EN_DCIN_REG		0x25 /* RW */
>> +#define KHADAS_MCU_BOOT_EN_KEY_REG		0x26 /* RW */
>> +#define KHADAS_MCU_KEY_MODE_REG			0x27 /* RW */
>> +#define KHADAS_MCU_LED_MODE_ON_REG		0x28 /* RW */
>> +#define KHADAS_MCU_LED_MODE_OFF_REG		0x29 /* RW */
>> +#define KHADAS_MCU_SHUTDOWN_NORMAL_REG		0x2c /* RW */
>> +#define KHADAS_MCU_MAC_SWITCH_REG		0x2d /* RW */
>> +#define KHADAS_MCU_MCU_SLEEP_MODE_REG		0x2e /* RW */
>> +#define KHADAS_MCU_IR_CODE1_0_REG		0x2f /* RW */
>> +#define KHADAS_MCU_IR_CODE1_1_REG		0x30 /* RW */
>> +#define KHADAS_MCU_IR_CODE1_2_REG		0x31 /* RW */
>> +#define KHADAS_MCU_IR_CODE1_3_REG		0x32 /* RW */
>> +#define KHADAS_MCU_USB_PCIE_SWITCH_REG		0x33 /* RW */
>> +#define KHADAS_MCU_IR_CODE2_0_REG		0x34 /* RW */
>> +#define KHADAS_MCU_IR_CODE2_1_REG		0x35 /* RW */
>> +#define KHADAS_MCU_IR_CODE2_2_REG		0x36 /* RW */
>> +#define KHADAS_MCU_IR_CODE2_3_REG		0x37 /* RW */
>> +#define KHADAS_MCU_PASSWD_USER_0_REG		0x40 /* RW */
>> +#define KHADAS_MCU_PASSWD_USER_1_REG		0x41 /* RW */
>> +#define KHADAS_MCU_PASSWD_USER_2_REG		0x42 /* RW */
>> +#define KHADAS_MCU_PASSWD_USER_3_REG		0x43 /* RW */
>> +#define KHADAS_MCU_PASSWD_USER_4_REG		0x44 /* RW */
>> +#define KHADAS_MCU_PASSWD_USER_5_REG		0x45 /* RW */
>> +#define KHADAS_MCU_USER_DATA_0_REG		0x46 /* RW 56 bytes */
>> +#define KHADAS_MCU_PWR_OFF_CMD_REG		0x80 /* WO */
>> +#define KHADAS_MCU_PASSWD_START_REG		0x81 /* WO */
>> +#define KHADAS_MCU_CHECK_VEN_PASSWD_REG		0x82 /* WO */
>> +#define KHADAS_MCU_CHECK_USER_PASSWD_REG	0x83 /* WO */
>> +#define KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG	0x86 /* RO */
>> +#define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
>> +#define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
>> +
>> +/* Boards */
> 
> I think the names make this superfluous.

Ok

> 
>> +enum {
>> +	KHADAS_BOARD_VIM1 = 0x1,
>> +	KHADAS_BOARD_VIM2,
>> +	KHADAS_BOARD_VIM3,
>> +	KHADAS_BOARD_EDGE = 0x11,
>> +	KHADAS_BOARD_EDGE_V,
>> +};
>> +
>> +/**
>> + * struct khadas_mcu_data - Khadas MCU MFD structure
> 
> Doesn't match the struct name>
> Prefer you drop the 'MFD' part.

Ok

> 
>> + * @device:		device reference used for logs
>> + * @map:		register map
>> + */
>> +struct khadas_mcu {
>> +	struct device *dev;
>> +	struct regmap *map;
>> +};
>> +
>> +#endif /* MFD_KHADAS_MCU_H */
> 

Thanks for the review.

Neil

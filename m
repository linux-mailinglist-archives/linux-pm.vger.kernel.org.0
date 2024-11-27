Return-Path: <linux-pm+bounces-18174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F689DACFE
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22670B2089F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D4200BB8;
	Wed, 27 Nov 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgM7tqWH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766D13D503;
	Wed, 27 Nov 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731884; cv=none; b=W9HOUlZr6e0GqXMev98tRPyicnSMC77AbKXoSKF93J8pMLXoz1eFlxXEBO3Da/WBQOQKOOfwycjbqJWZTwxPoe6dEqAAxmzSaIJxByqCSjzRk4lvjUqg+3XyMXFF538mfIjkDsiYmt0+4ZSIWD7j3xu5vP69wQahf8n0eLLLEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731884; c=relaxed/simple;
	bh=L9Lf/+c5aWiG376ZtQwFOMY+aDoqqpnT+1+CkYemXu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAp7Qj7+06GX66BmPV3cPbZ+vJao8cKCX/nULR5BUGHV42n27jU4q1Q/59xCJCDSW9Hy2MHq6yU9hwcEKVLG8ZJsVIQ8KHIWxoWWIbwOQ+1ZcCS6QURFMV3KHsuDYy/zfDuZIkiFDaPxMyvnlH4msgOaUuYE08YlutgxtPh7Xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgM7tqWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDCFC4CECC;
	Wed, 27 Nov 2024 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732731883;
	bh=L9Lf/+c5aWiG376ZtQwFOMY+aDoqqpnT+1+CkYemXu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LgM7tqWHFUAU4EpE5+9+cX8X87K44OlJWhWc4JsaZ6/2OGniWT+ZJNxbbGpG/dtqT
	 Kv2PrSXxXp2kvB28EDwvgOQFucuwbWjXtyrR2Dwm29NdbsOdKx0PgZTtklz0nT9hA8
	 P7/3bkCExvjuT/yfLESpQ4hl8FN3XIobpiP4mR/xuNOB4kRcmpRYWnscsJ+TpyxUjp
	 jgXtwhHn49MMerwg+N+t6PYfTZbBgfM0/i++3wjv/teps8NpxuhhJ78Lgjv9Z2ZZ/t
	 ZdsIOhaBfj4XtpDehP6uxhba6022igAFV1Pc5UE77SY+uaYvAlJajFXcCpzN6Tm2Yk
	 ZsBA+cJEE/Hxw==
Message-ID: <be00dec6-d598-4dea-b608-51ea67b37084@kernel.org>
Date: Wed, 27 Nov 2024 19:24:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] power: supply: Add STC3117 fuel gauge unit driver
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, sre@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
 <20241127151953.29550-3-bhavin.sharma@siliconsignals.io>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241127151953.29550-3-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/11/2024 16:19, Bhavin Sharma wrote:
> Adds initial support for the STC3117 fuel gauge.
> 
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  MAINTAINERS                               |   8 +
>  drivers/power/supply/Kconfig              |   7 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/stc3117_fuel_gauge.c | 625 ++++++++++++++++++++++
>  4 files changed, 641 insertions(+)
>  create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82161bc70b51..42c1af29eddb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21855,6 +21855,14 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
>  F:	drivers/media/i2c/st-mipid02.c
>  
> +ST STC3117 FUEL GAUGE DRIVER
> +M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> +M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
> +F:	drivers/power/supply/stc3117_fuel_gauge.c
> +
>  ST STM32 FIREWALL
>  M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
>  S:	Maintained
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index bcfa63fb9f1e..6ad968fa1f69 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -908,6 +908,13 @@ config FUEL_GAUGE_SC27XX
>  	  Say Y here to enable support for fuel gauge with SC27XX
>  	  PMIC chips.
>  
> +config FUEL_GAUGE_STC3117
> +	tristate "STMicroelectronics STC3117 fuel gauge driver"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for fuel gauge with STC3117
> +	  PMIC chips.
> +
>  config CHARGER_UCS1002
>  	tristate "Microchip UCS1002 USB Port Power Controller"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 8dcb41545317..aea3d35f27f3 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
> +obj-$(CONFIG_FUEL_GAUGE_STC3117)	+= stc3117_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
>  obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
> diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
> new file mode 100644
> index 000000000000..99291bb9250f
> --- /dev/null
> +++ b/drivers/power/supply/stc3117_fuel_gauge.c
> @@ -0,0 +-2,622 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
> + *
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.
> + * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> + *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/workqueue.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/crc8.h>
> +
> +#define STC3117_ADDR_MODE                       0x00
> +#define STC3117_ADDR_CTRL                       0x01
> +#define STC3117_ADDR_SOC_L                      0x02
> +#define STC3117_ADDR_SOC_H                      0x03
> +#define STC3117_ADDR_COUNTER_L                  0x04
> +#define STC3117_ADDR_COUNTER_H                  0x05
> +#define STC3117_ADDR_CURRENT_L                  0x06
> +#define STC3117_ADDR_CURRENT_H                  0x07
> +#define STC3117_ADDR_VOLTAGE_L                  0x08
> +#define STC3117_ADDR_VOLTAGE_H                  0x09
> +#define STC3117_ADDR_TEMPERATURE                0x0A
> +#define STC3117_ADDR_AVG_CURRENT_L              0X0B
> +#define STC3117_ADDR_AVG_CURRENT_H              0X0C
> +#define STC3117_ADDR_OCV_L                      0X0D
> +#define STC3117_ADDR_OCV_H                      0X0E
> +#define STC3117_ADDR_CC_CNF_L                   0X0F
> +#define STC3117_ADDR_CC_CNF_H                   0X10
> +#define STC3117_ADDR_VM_CNF_L                   0X11
> +#define STC3117_ADDR_VM_CNF_H                   0X12
> +#define STC3117_ADDR_ALARM_SOC                  0X13
> +#define STC3117_ADDR_ALARM_VOLTAGE              0X14
> +#define STC3117_ADDR_ID                         0X18
> +#define STC3117_ADDR_CC_ADJ_L			0X1B
> +#define STC3117_ADDR_CC_ADJ_H			0X1C
> +#define STC3117_ADDR_VM_ADJ_L			0X1D
> +#define STC3117_ADDR_VM_ADJ_H			0X1E
> +#define STC3117_ADDR_RAM			0x20
> +#define STC3117_ADDR_OCV_TABLE			0x30
> +#define STC3117_ADDR_SOC_TABLE			0x30
> +
> +/************ Bit mask definition ************/
> +#define STC3117_ID			        0x16
> +#define STC3117_MIXED_MODE			0x00
> +#define STC3117_VMODE				BIT(0)
> +#define STC3117_GG_RUN				BIT(4)
> +#define STC3117_CC_MODE				BIT(5)
> +#define STC3117_BATFAIL			BIT(3)
> +#define STC3117_PORDET				BIT(4)
> +
> +#define STC3117_RAM_SIZE			16
> +#define STC3117_OCV_TABLE_SIZE			16
> +#define STC3117_RAM_TESTWORD			0x53A9
> +#define STC3117_SOFT_RESET                      0x11
> +#define STC3117_NOMINAL_CAPACITY		2600
> +
> +#define VOLTAGE_LSB_VALUE			9011
> +#define CURRENT_LSB_VALUE			24084
> +#define RSENSE					10
> +#define BATT_CAPACITY				1800
> +#define BATTERY_RINT				60
> +#define APP_CUTOFF_VOLTAGE			2500
> +#define BATT_CHG_VOLTAGE			4250
> +#define BATT_MIN_VOLTAGE			3300
> +#define MAX_HRSOC				51200
> +#define MAX_SOC				1000
> +#define CHG_MIN_CURRENT			200
> +#define CHG_END_CURRENT			20
> +#define APP_MIN_CURRENT			(-5)
> +#define BATTERY_FULL				95
> +#define CRC8_POLYNOMIAL			0x07
> +#define CRC8_INIT				0x00
> +#define CRC8_TABLE_SIZE			256
> +
> +DECLARE_CRC8_TABLE(stc3117_crc_table);
> +
> +enum stc3117_state {
> +	STC3117_INIT,
> +	STC3117_RUNNING,
> +	STC3117_POWERDN,
> +};
> +
> +enum stc3117_status {
> +	BATT_LOWBATT = -2,
> +	BATT_DISCHARG,
> +	BATT_IDLE,
> +	BATT_FULCHARG,
> +	BATT_ENDCHARG,
> +	BATT_CHARGING,
> +};
> +
> +/* Default OCV curve Li-ion battery */
> +static const int OCVValue[16] = {
> +    3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
> +    3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
> +};
> +
> +static union stc3117_internal_ram {
> +	u8 ram_bytes[STC3117_RAM_SIZE];
> +	struct {
> +	u16 TestWord;   /* 0-1    Bytes */
> +	u16 HRSOC;      /* 2-3    Bytes */
> +	u16 CC_cnf;     /* 4-5    Bytes */
> +	u16 VM_cnf;     /* 6-7    Bytes */
> +	u8 soc;         /* 8      Byte  */
> +	u8 state;       /* 9      Byte  */
> +	u8 unused[5];   /* 10-14  Bytes */
> +	u8 CRC;         /* 15     Byte  */
> +	} reg;
> +} ram_data;
> +
> +struct stc3117_data {
> +	struct i2c_client	*client;
> +	struct regmap		*regmap;
> +	struct delayed_work update_work;
> +	struct power_supply	*battery;
> +
> +	u8 SOCValue[16];
> +	int CC_cnf;
> +	int VM_cnf;
> +	int CC_adj;
> +	int VM_adj;
> +	int AvgCurrent;
> +	int AvgVoltage;
> +	int Current;
> +	int Voltage;
> +	int Temp;
> +	int SOC;
> +	int OCV;
> +	int HRSOC;
> +	int Presence;
> +	int Battery_state;


That's some Windows coding style... You need to clean up everything here
to match Linux Coding style.


> +};
> +




> +	i2c_set_clientdata(client, data);
> +	psy_cfg.drv_data = data;
> +
> +	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
> +
> +	ret = stc3117_init(data);
> +	if (ret)
> +		dev_err_probe(&client->dev, ret, "failed to initialization of stc3117\n");
> +
> +	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);
> +
> +	schedule_delayed_work(&data->update_work, 0);
> +
> +	data->battery = devm_power_supply_register(&client->dev,
> +						   &stc3117_battery_desc, &psy_cfg);
> +	if (IS_ERR(data->battery))
> +		dev_err_probe(&client->dev, PTR_ERR(data->battery), "failed to register battery\n");
> +
You ignored (again!) received comments. In multiple places. Go back to
previous email and carefully read commetns.

One more thing:

Please wrap code according to coding style (checkpatch is not a coding
style description, but only a tool).


Best regards,
Krzysztof


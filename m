Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF41BF882
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD3MwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 08:52:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40608 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3MwR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 08:52:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03UCqE7F088275;
        Thu, 30 Apr 2020 07:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588251134;
        bh=K4d+nmeB1EYZz6Viig2DwGBIetdlcYnDJCY+gI0Fdoo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RI0Z4mxFvkZJLGh5uca8ucD6OGvNZ4nRnG0TBSZa+K0mXnPPsXIHlHlE1j2eZPT/F
         6H/DBqDdPPEuzew6xAGnoiZPCUzu25Fzov3ggSEfowMZEKBMM5gWIEvVgdKhQ8jxDA
         gYX+umIic8kwli2Bt9KdwtfGl5RoNfCgAJv72PHQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UCqE58048191;
        Thu, 30 Apr 2020 07:52:14 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Apr 2020 07:52:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Apr 2020 07:52:14 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UCqEaa092612;
        Thu, 30 Apr 2020 07:52:14 -0500
Subject: Re: [PATCH 2/2] power: supply: Introduce the BQ27561 Fuel gauge
 driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     "Andrew F. Davis" <afd@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200417172227.28075-1-dmurphy@ti.com>
 <20200417172227.28075-2-dmurphy@ti.com>
 <20200429220522.w3likr4ywklxrkvr@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <26d120ab-5506-f0f8-1d45-fd7c5c4a1bde@ti.com>
Date:   Thu, 30 Apr 2020 07:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429220522.w3likr4ywklxrkvr@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 4/29/20 5:05 PM, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Apr 17, 2020 at 12:22:27PM -0500, Dan Murphy wrote:
>> Introduce the BQ27561 Fuel gauge driver from Texas Instruments. The
>> driver also supports the BQ27750 as it has the same register map and
>> bit mask.
> Why a separate driver instead of adding support to bq27xxx? The register
> map seems to be similar enough.

I will need to see if I can integrate this into the bq27xxx.  I have to 
look at these 2 devices as well as another device that we need to integrate

But preliminary analysis suggests that we can integrate these 2 devices 
plus the third one into the driver.

>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/power/supply/Kconfig      |   9 +
>>   drivers/power/supply/Makefile     |   1 +
>>   drivers/power/supply/bq27561_fg.c | 304 ++++++++++++++++++++++++++++++
>>   3 files changed, 314 insertions(+)
>>   create mode 100644 drivers/power/supply/bq27561_fg.c
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index f3424fdce341..febf6bf8c4ea 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -597,6 +597,15 @@ config CHARGER_BQ25890
>>   	help
>>   	  Say Y to enable support for the TI BQ25890 battery charger.
>>   
>> +config FUEL_GAUGE_BQ27561
>> +	tristate "Texas Instruments bq27561 fuel gauge driver"
>> +	depends on I2C
>> +	select REGMAP_I2C
> good :)
Ack
>
>> +	depends on GPIOLIB || COMPILE_TEST
>> +	help
>> +	 Say Y here to enable support for fuel gauge with TI bq27561
>> +	 fuel gauge chips.
>> +
>>   config CHARGER_SMB347
>>   	tristate "Summit Microelectronics SMB347 Battery Charger"
>>   	depends on I2C
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index 6c7da920ea83..4e402292b276 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -81,6 +81,7 @@ obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
>>   obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
>>   obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
>>   obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
>> +obj-$(CONFIG_FUEL_GAUGE_BQ27561)	+= bq27561_fg.o
>>   obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
>>   obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
>>   obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
>> diff --git a/drivers/power/supply/bq27561_fg.c b/drivers/power/supply/bq27561_fg.c
>> new file mode 100644
>> index 000000000000..b9f7cdc00d2e
>> --- /dev/null
>> +++ b/drivers/power/supply/bq27561_fg.c
>> @@ -0,0 +1,304 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// BQ27561 Fuel Gauge Driver
>> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>> +// Author: Dan Murphy <dmurphy@ti.com>
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/types.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +
>> +#define BQ27561_REG_CNTL	0x00
>> +#define BQ27561_REG_AR		0x02
>> +#define BQ27561_REG_TEMP	0x06
>> +#define BQ27561_REG_VOLT	0x08
>> +#define BQ27561_REG_REMAIN_CAP	0x10
>> +#define BQ27561_REG_BATTSTAT	0x0a
>> +#define BQ27561_REG_CURRENT	0x0c
>> +#define BQ27561_REG_FCC		0x12
>> +#define BQ27561_REG_AVG_CURRENT	0x14
>> +#define BQ27561_REG_TTE		0x16
>> +#define BQ27561_REG_TTF		0x18
>> +#define BQ27561_REG_CYCLECNT	0x2a
>> +#define BQ27561_REG_RSOC	0x2c
>> +
>> +#define BQ27561_VAL_MULTIPLIER	1000
>> +#define BQ27561_TEMP_K_TO_C	2732
>> +#define BQ27561_TIME_MIN_TO_S	60
>> +
>> +#define BQ27561_BATT_DEPLETED	BIT(4)
>> +#define BQ27561_BATT_CHARGED	BIT(5)
>> +#define BQ27561_BATT_DISCHARGING	BIT(6)
>> +
>> +enum {
>> +	BQ27561,
>> +	BQ27750,
>> +};
>> +
>> +struct bq27561_device {
>> +	struct device *dev;
>> +	struct i2c_client *client;
>> +	struct power_supply *battery;
>> +};
>> +
>> +static enum power_supply_property bq27561_properties[] = {
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_CAPACITY,
>> +	POWER_SUPPLY_PROP_TEMP,
>> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +	POWER_SUPPLY_PROP_CURRENT_NOW,
>> +	POWER_SUPPLY_PROP_CHARGE_NOW,
>> +	POWER_SUPPLY_PROP_CHARGE_FULL,
>> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
>> +};
>> +
>> +static int bq27561_get_temp(struct bq27561_device *bq)
>> +{
>> +	unsigned int temp;
>> +
>> +	temp = i2c_smbus_read_word_data(bq->client, BQ27561_REG_TEMP);
> please use regmap instead of direct i2c read/write commands!
>
OK I did not look at regmap close enough to see if it supports smbus.  
But apparently it does.

I just need to make sure.


>> +	if (temp < 0)
>> +		return temp;
> so e.g. -EIO will become -0.5°C?
Ack.  It is hard to get a negative temp to be recorded by the thermister 
in testing.
>
>> +	return temp - BQ27561_TEMP_K_TO_C;
>> +}
>> +
>> +static int bq27561_get_voltage(struct bq27561_device *bq)
>> +{
>> +	unsigned int batt_volt;
>> +
>> +	batt_volt = i2c_smbus_read_word_data(bq->client, BQ27561_REG_VOLT);
>> +	if (batt_volt < 0)
>> +		return batt_volt;
>> +
>> +	return batt_volt * BQ27561_VAL_MULTIPLIER;
>> +}
>> +
>> +static int bq27561_get_current(struct bq27561_device *bq)
>> +{
>> +	unsigned int batt_curr;
>> +
>> +	batt_curr = i2c_smbus_read_word_data(bq->client, BQ27561_REG_CURRENT);
>> +	if (batt_curr < 0)
>> +		return batt_curr;
>> +
>> +	return batt_curr * BQ27561_VAL_MULTIPLIER;
>> +}
>> +
>> +static int bq27561_get_charge_capacity(struct bq27561_device *bq)
>> +{
>> +	unsigned int charge_cap;
>> +
>> +	charge_cap = i2c_smbus_read_word_data(bq->client, BQ27561_REG_FCC);
>> +	if (charge_cap < 0)
>> +		return charge_cap;
>> +
>> +	return charge_cap * BQ27561_VAL_MULTIPLIER;
>> +}
>> +
>> +static int bq27561_get_batt_status(struct bq27561_device *bq)
>> +{
>> +	unsigned int batt_stat;
>> +	unsigned int curr;
>> +	int ret;
>> +
>> +	batt_stat = i2c_smbus_read_word_data(bq->client, BQ27561_REG_BATTSTAT);
>> +	if (batt_stat < 0)
>> +		return batt_stat;
>> +
>> +	curr = i2c_smbus_read_word_data(bq->client, BQ27561_REG_CURRENT);
>> +	if (curr < 0)
>> +		return curr;
>> +
>> +	if (batt_stat & BQ27561_BATT_CHARGED)
>> +		ret = POWER_SUPPLY_STATUS_FULL;
>> +	else if (batt_stat & BQ27561_BATT_DISCHARGING || curr == 0)
>> +		ret = POWER_SUPPLY_STATUS_DISCHARGING;
>> +	else if (curr > 0)
>> +		ret = POWER_SUPPLY_STATUS_CHARGING;
>> +	else
>> +		ret = POWER_SUPPLY_STATUS_UNKNOWN;
>> +
>> +	return ret;
>> +}
>> +
>> +static int bq27561_get_empty_time(struct bq27561_device *bq)
>> +{
>> +	unsigned int empty_time;
>> +
>> +	empty_time = i2c_smbus_read_word_data(bq->client, BQ27561_REG_TTE);
>> +	if (empty_time < 0)
>> +		return empty_time;
>> +
>> +	return empty_time * BQ27561_TIME_MIN_TO_S;
>> +}
>> +
>> +static int bq27561_get_property(struct power_supply *psy,
>> +				enum power_supply_property psp,
>> +				union power_supply_propval *val)
>> +{
>> +	struct bq27561_device *bq = power_supply_get_drvdata(psy);
>> +	int ret = 0;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +		ret = bq27561_get_voltage(bq);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = ret;
>> +		break;
>> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +		ret = bq27561_get_current(bq);
>> +		if (ret < 0)
>> +			return ret;
> current can be negative (charging vs discharging).
Ack
>
>> +
>> +		val->intval = ret;
>> +		break;
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		ret = bq27561_get_batt_status(bq);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = ret;
>> +		break;
>> +	case POWER_SUPPLY_PROP_TEMP:
>> +		val->intval = bq27561_get_temp(bq);
>> +		break;
> no error handling?
Ack
>
>> +	case POWER_SUPPLY_PROP_CAPACITY:
>> +		ret = i2c_smbus_read_word_data(bq->client, BQ27561_REG_RSOC);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = ret;
>> +		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
>> +		ret = bq27561_get_charge_capacity(bq);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = ret;
>> +		break;
>> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
>> +		ret = bq27561_get_empty_time(bq);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = ret;
>> +		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
>> +		ret = i2c_smbus_read_word_data(bq->client, BQ27561_REG_AR);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		val->intval = ret;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	};
>> +
>> +	return 0;
>> +}
>> +
>> +static int bq27561_set_property(struct power_supply *psy,
>> +				enum power_supply_property psp,
>> +				const union power_supply_propval *val)
>> +{
>> +	struct bq27561_device *bq = power_supply_get_drvdata(psy);
>> +	int ret = 0;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
>> +		ret = i2c_smbus_write_word_data(bq->client, BQ27561_REG_AR,
>> +						val->intval);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	};
>> +
>> +	return ret;
>> +}
>> +
>> +static int bq27561_prop_is_writeable(struct power_supply *psy,
>> +				     enum power_supply_property prop)
>> +{
>> +	switch (prop) {
>> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
>> +		return 1;
>> +	default:
>> +		return 0;
>> +	};
>> +}
>> +
>> +static struct power_supply_desc bq27561_power_supply_desc = {
>> +	.type = POWER_SUPPLY_TYPE_BATTERY,
>> +	.properties = bq27561_properties,
>> +	.num_properties = ARRAY_SIZE(bq27561_properties),
>> +	.get_property = bq27561_get_property,
>> +	.set_property = bq27561_set_property,
>> +	.property_is_writeable = bq27561_prop_is_writeable,
>> +};
>> +
>> +static int bq27561_probe(struct i2c_client *client,
>> +				 const struct i2c_device_id *id)
>> +{
>> +	struct bq27561_device *bq;
>> +	struct power_supply_config psy_cfg;
>> +
>> +	bq = devm_kzalloc(&client->dev, sizeof(*bq), GFP_KERNEL);
>> +	if (!bq)
>> +		return -ENOMEM;
>> +
>> +	bq->dev = &client->dev;
>> +	bq->client = client;
>> +	i2c_set_clientdata(client, bq);
>> +
>> +	psy_cfg.drv_data = bq;
> You should setup psy_cfg.of_node, so that it can be referenced
> in DT.
>
Ack
>> +	bq27561_power_supply_desc.name = id->name;
>> +	bq->battery = devm_power_supply_register(bq->dev,
>> +						 &bq27561_power_supply_desc,
>> +						 &psy_cfg);
>> +
>> +	if (IS_ERR(bq->battery))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id bq27561_match_table[] = {
>> +	{.compatible = "ti,bq27561",},
>> +	{.compatible = "ti,bq27750",},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, bq_fg_match_table);
>> +
>> +static const struct i2c_device_id bq27561_id[] = {
>> +	{"bq27561", BQ27561},
>> +	{"bq27750", BQ27750},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, bq27561_id);
>> +
>> +static struct i2c_driver bq27561_battery_driver = {
>> +	.driver = {
>> +		   .name = "bq27561-fuel-gauge",
>> +		   .of_match_table = bq27561_match_table,
>> +		   .owner = THIS_MODULE,
> i2c_register_driver() sets it owner automatically, so
> drop this.
>
>> +		   },
>> +	.probe = bq27561_probe,
>> +	.id_table = bq27561_id,
>> +};
>> +module_i2c_driver(bq27561_battery_driver);
>> +
>> +MODULE_AUTHOR("Texas Instruments");
>> +MODULE_DESCRIPTION("bq27561 battery monitor driver");
>> +MODULE_LICENSE("GPL v2");
> -- Sebastian

Return-Path: <linux-pm+bounces-18301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208D9DF260
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF298162DDF
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2141A2544;
	Sat, 30 Nov 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PzppHvLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9A1A00D6;
	Sat, 30 Nov 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988985; cv=none; b=l4iMLMfXbLYTqaLwkoBjUjC7vX6nCcI3lc7A/5syuWkn+7JAw7n6R/x7dVHDXe7Ceiu7PvPxf4zkURd75vv6lUat7Mzvj3T3ENo1H29m0jQMPlUUwv6JZ0z17OsprRSybZOWDNawNzVIyDueHRyHIrrGxpGjVJltYxmgmP8wxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988985; c=relaxed/simple;
	bh=L/mnVv/QdU9IQuhb7S6ybelrX6vlhMxb/DG4k5UrV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeITHWOUdPilC3NQw+IGodEx8uD2OzkpPFiQ2CfN2Z/kBlsP1jN+b/9f/EuoBynS1QYksvMyM4ktzxsD577LO6qOJg/HmpKB21kJSDPzvgzyTV93XQRKe1udyUY5AotsxNzxcN5nw5eJTQdFOcuKJrQvNRXFkqVD6+UrrD7nof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PzppHvLj; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id HRZztNh1xe67ZHRa0ttR0o; Sat, 30 Nov 2024 18:48:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732988908;
	bh=mnMhbLJd2P2Le/VIBazI/NgKkeWIHLuoIZ6P6sJndBY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PzppHvLjaX9NthVW8Ikmrq4T7u8YOtH9bYxJi5WHGTCmzMGH4Lzv8DsnDrrOTyiCx
	 CWyleEiCnZLr05yqPGjzDrUjZD+yDU74UsiMPOp398Osswsb4out6K5vr9+ItKNFv7
	 rtbK1rDNejRq2h+6l5TvDwbImZ9R5UyrUf2WAHfjxNy+tgw1VJEJohlWb4RHj27H80
	 dSmbCMw/HyTd8Zfiwtr9kTCJXbS/V0ujMAKmUuASRIHexYWLC9pf6mt3vcCdyBfdoE
	 AKjZGqqxpYivtD1fCray62/g6KwWvoYXgJb1Fi+J46cwv8lN7bMoLRMX/JHTbzcrBE
	 rCaZgvCLi7Xmw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 Nov 2024 18:48:28 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: 
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH v5 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Sat, 30 Nov 2024 18:47:57 +0100
Message-ID: <20241130174819.19551-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129114200.13351-3-bhavin.sharma@siliconsignals.io>
References: <20241129114200.13351-3-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

My mailer refuses adesses at @siliconsignals.io. So not every one is in this reply


Le 29/11/2024 à 12:40, Bhavin Sharma a écrit :
> Adds initial support for the STC3117 fuel gauge.
> 
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---

...

> +/* Bit mask definition */
> +#define STC3117_ID			        0x16
> +#define STC3117_MIXED_MODE			0x00
> +#define STC3117_VMODE				BIT(0)
> +#define STC3117_GG_RUN				BIT(4)
> +#define STC3117_CC_MODE				BIT(5)
One unneeded extra tab?

> +#define STC3117_BATFAIL			BIT(3)
> +#define STC3117_PORDET				BIT(4)
> +#define STC3117_RAM_SIZE			16
> +#define STC3117_OCV_TABLE_SIZE			16
> +#define STC3117_RAM_TESTWORD			0x53A9
> +#define STC3117_SOFT_RESET                      0x11
> +#define STC3117_NOMINAL_CAPACITY		2600

...

> +static int stc3117_set_para(struct stc3117_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
> +
> +	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
> +		regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
> +						ocvValue[i] * 100 / 55);
Should there be a ret |= ?

> +	if (data->soc_tab[1] != 0)
> +		regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
> +				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
Should there be a ret |= ?
If it is needed, some other places in the driver may alos need it.

> +
> +	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
> +					(ram_data.reg.cc_cnf >> 8) & 0xFF);
> +
> +	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
> +					ram_data.reg.cc_cnf & 0xFF);
> +
> +	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
> +					(ram_data.reg.vm_cnf >> 8) & 0xFF);
> +
> +	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
> +					ram_data.reg.vm_cnf & 0xFF);
> +
> +	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
> +
> +	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
> +					STC3117_MIXED_MODE | STC3117_GG_RUN);
> +
> +	return ret;
> +};

...

> +static int stc3117_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct stc3117_data *data = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (data->soc > BATTERY_FULL)
> +			val->intval = POWER_SUPPLY_STATUS_FULL;
This is dead-code. "val->intval" is over-written in ALL paths below.
The logic looks broken.

> +		if (data->batt_current < 0)
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else if (data->batt_current > 0)
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = data->voltage;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval = data->batt_current;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval = data->soc;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval = data->temp;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = data->presence;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

...

> +static int stc3117_probe(struct i2c_client *client)
> +{
> +	struct stc3117_data *data;
> +	struct power_supply_config psy_cfg = {};
> +	struct power_supply_battery_info *info;
> +	int ret;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	i2c_set_clientdata(client, data);
Is it needed?
(there is no i2c_get_clientdata() in the code)

> +	psy_cfg.drv_data = data;
> +
> +	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
> +
> +	data->battery = devm_power_supply_register(&client->dev,
> +						   &stc3117_battery_desc, &psy_cfg);> +	if (IS_ERR(data->battery))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
> +						"failed to register battery\n");
> +
> +	ret = device_property_read_u32(&client->dev, "sense-resistor",
> +				       &battery_info.sense_resistor);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +						"failed to get sense-register\n");
Should it be "failed to get sense-resistor\n"?

> +
> +	ret = power_supply_get_battery_info(data->battery, &info);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"failed to get battery information\n");
> +
> +	battery_info.battery_capacity = info->charge_full_design_uah * 1000;
> +	battery_info.voltage_min = info->voltage_min_design_uv * 1000;
> +	battery_info.voltage_max = info->voltage_min_design_uv * 1000;
Should it be voltage_max_design_uv?

> +
> +	ret = stc3117_init(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				"failed to initialization of stc3117\n");
"failed initialization" of "failed to initialize"?

> +
> +	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);
> +
> +	schedule_delayed_work(&data->update_work, 0);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id stc3117_id[] = {
> +	{"stc3117", 0},
Spaces sould be added to match stc3117_of_match below.

> +	{},
Unneeded ending comma after a terminator entry.

> +};
> +MODULE_DEVICE_TABLE(i2c, stc3117_id);
> +
> +static const struct of_device_id stc3117_of_match[] = {
> +	{ .compatible = "st,stc3117" },
> +	{},
Unneeded ending comma after a terminator entry.

> +};
> +MODULE_DEVICE_TABLE(of, stc3117_of_match);
...

CJ


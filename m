Return-Path: <linux-pm+bounces-40011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9CCCE6768
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 12:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BF3F3011DB4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D22F99A8;
	Mon, 29 Dec 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="nvAIuMTu";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="R8JiuHuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED512F9D9A;
	Mon, 29 Dec 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006632; cv=pass; b=r9o6Z5pEEaOOEmxXMaGTI+CeyUNdVhw/D8WotnU0s87Jq9SLXh1KvS/grfVpiplgB3q54K0l1NqDU+X+tEhtrz1uYB0EJJjlUJkhY6d3xEC7K06PS2MHcDeroYmznqvM+7cJErmVRQTTU71gblNJVf6LHIwkvgIquJNEgkZXyqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006632; c=relaxed/simple;
	bh=9k/WM7cAcqzS3uy/keLO6SKGkZFuYoKvyfmz4Izxlic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzoWr6D5/kUBpr4e2Q7R6j72S/ixhTQL1lb2EqQzqjNaElJP7O5gLJcjPccRIVjjVj875LPPtIWyiqJ9vkbi92hHnM9mqiBXVwGhREdPIe78NZN85OCJXfVuVLjxahO7I/lIbFJEC8l+12BAxxyil4QiOKhE506lKiGYH9I0Ojk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=nvAIuMTu; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=R8JiuHuQ; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1767006596; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CKLidprdxKoJpW5ljLGmYgu6QIaq6ejdqvf7NIF77hTJ0QzAcSShu1Tu01lTX2m/vC
    M31T2FPJXFegfbQQN1U2Z9Y4UeGehbdukUBdVX8bw8rxYYKMhSsP0XWVfmodxxGJmiSN
    9tUbw9At5ARXVY2SwyPuudQzfJhBPvrb4kfJiNw9B9GnM9v2MK4Yt10TkJZJDR8Kcn5+
    xFmrc7rGS011YSvLFS/P4gD5tN/lgMqhWz1/PZlHnrBXlf50XKoYIyR97l1He16S2mS9
    ebrApzHLXLmficUeJIArRMii2dTf8mJ8WpjtQPrUlsX0H8uhxkRGuNi+FCWUG+jp6v5X
    jQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767006596;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sKiWXwxe+9H0SWNjyxuk3itASAxKxOKJ193n08TPct4=;
    b=bU5DmuU1RQO7McY7iSl1lGXuGktVSeVdRMQeV6Yuwi+g2crRLijAiwDS63yXVA34Fz
    miAjpXMF6uTKy9QVKzZuq6qHjuKvyzsjXTdIQtGL9hQkRms2gaDRp9wOWyOHpT2oCYBJ
    XinEoUggLeFdExdo4CjTk8sljRErHhIrPSfPl7Fcyb9IIhIxucrKCoGfaP1lgNUXnAwy
    0lNtIHWUTBXV20JfVnhkyadn9CFtwxx0srlDw2u7xw+2Xdx070Z2vzrerv5eXEsfr06t
    dBtHCZoRVjJf8+Gr1TdSs0V0S6pNJVAQMT9j8fRvcGsDg8hZFq4hew9uEUd2A+7wtMac
    g61g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767006596;
    s=strato-dkim-0002; d=jm0.eu;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sKiWXwxe+9H0SWNjyxuk3itASAxKxOKJ193n08TPct4=;
    b=nvAIuMTua6DcEeFzu3p0Vw40wNf6omIRyHjkH+WcC9eCFIFrz9L0J2lw6J37zz0QMM
    /sly9r8zITHaWSoaZde6hWZqUWd+Dev0JT88gqoAnQCrYgJ8hJweGZoqmF2gVt2dIeyS
    pStvAacG/SIGfzqDaDRLBDNmxef5N5HAv/QBvpae9Q+57WCJ0Zjtk4cwYZThiA00fbmx
    5u5QxETk3Mqj2kn+C3nNalOZTLJM1adbkKFnm/uk2jn+TwTifTmNT7u/BcvBbEX+HeQ2
    GnEFDLY6Jocl+ZHVtrAy+X+5j3ohnkHnhcVpPsbVNHDRnnNAXi/Qn6J+tzPii8g2+qIz
    rwzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767006596;
    s=strato-dkim-0003; d=jm0.eu;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sKiWXwxe+9H0SWNjyxuk3itASAxKxOKJ193n08TPct4=;
    b=R8JiuHuQ52hfojjL+JPnhTmD3oBGoy/x7RKETDY/FMI2PdBqJs6Y3zP7VQLE8As82n
    ysSNEXyguvvKovO4ZrDw==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQvpoIkZXd2bnfIrOV7Mbk="
Received: from [192.168.1.232]
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec1BTB9tyqP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 29 Dec 2025 12:09:55 +0100 (CET)
Message-ID: <f413cdc1-1461-4896-b68e-6d78343b3fe1@jm0.eu>
Date: Mon, 29 Dec 2025 12:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: supply: add battery driver for netronix ec
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andreas Kemnade <andreas@kemnade.info>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
 <20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
 <aVFvVtXe58q84NOk@probook>
Content-Language: en-US
From: "Ing. Josua Mayer" <josua.mayer@jm0.eu>
Autocrypt: addr=josua.mayer@jm0.eu; keydata=
 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
In-Reply-To: <aVFvVtXe58q84NOk@probook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.12.25 um 18:56 schrieb J. Neuschäfer:
> Hello!
> 
> Nice to see someone work on the Netronix EC :-)
> 
> On Sat, Dec 27, 2025 at 05:28:13PM +0100, Josua Mayer wrote:
>> Implement a simple battery driver for monitoring voltage with the
>> netronix embedded controller found in certain ebook readers.
>>
>> Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
>> ---
>>   drivers/mfd/ntxec.c                  |   1 +
>>   drivers/power/supply/Kconfig         |   9 ++++
>>   drivers/power/supply/Makefile        |   1 +
>>   drivers/power/supply/ntxec-battery.c | 101 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 112 insertions(+)
>>
>> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
>> index 08c68de0f01bc..d5059b8862aa8 100644
>> --- a/drivers/mfd/ntxec.c
>> +++ b/drivers/mfd/ntxec.c
>> @@ -139,6 +139,7 @@ static const struct regmap_config regmap_config = {
>>   static const struct mfd_cell ntxec_subdev[] = {
>>   	{ .name = "ntxec-rtc" },
>>   	{ .name = "ntxec-pwm" },
>> +	{ .name = "ntxec-battery" },
>>   };
>>   
>>   static const struct mfd_cell ntxec_subdev_pwm[] = {
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 92f9f7aae92f2..5674a23ba7bd6 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -1132,4 +1132,13 @@ config FUEL_GAUGE_MM8013
>>   	  the state of charge, temperature, cycle count, actual and design
>>   	  capacity, etc.
>>   
>> +config BATTERY_NTXEC
>> +	tristate "Battery driver for Netronix embedded controller"
>> +	depends on MFD_NTXEC
>> +	help
>> +	  Say yes here to enable netronix ec battery monitoring driver.
>> +	  It enables the monitoring battery voltage on certain e-book readers
>> +	  using an embedded controller by ODM Netronix. Battery design
>> +	  characteristics are read from Firmware Tables if available.
> 
> What do you mean by Firmware Tables, and where does this happen?
Effectively I mean device-tree.

This happens in power-supply core automatically for type battery:

static struct power_supply *__must_check
__power_supply_register(struct device *parent,
				   const struct power_supply_desc *desc,
				   const struct power_supply_config *cfg)
{
	...
	/*
	 * Expose constant battery info, if it is available. While there are
	 * some chargers accessing constant battery data, we only want to
	 * expose battery data to userspace for battery devices.
	 */
	if (desc->type == POWER_SUPPLY_TYPE_BATTERY) {
		rc = power_supply_get_battery_info(psy, &psy->battery_info);
		if (rc && rc != -ENODEV && rc != -ENOENT)
			goto check_supplies_failed;
	}
	...
}

This code particular is the reason I marked it optional in DT binding.

> 
> (I guess it means devicetree/fwnode, but "git grep -i 'firmware tables'"
Yes, given that power_supply_get_battery_info uses fwnode_* functions.

> doesn't show many uses of that term)
I was struggling with the phrasing - can change to something better.

> 
>> +
>>   endif # POWER_SUPPLY
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index 4b79d5abc49a7..db6fc815f9da2 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
>>   obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
>>   obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
>>   obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
>> +obj-$(CONFIG_BATTERY_NTXEC)	+= ntxec-battery.o
>> diff --git a/drivers/power/supply/ntxec-battery.c b/drivers/power/supply/ntxec-battery.c
>> new file mode 100644
>> index 0000000000000..f49f0966d18dd
>> --- /dev/null
>> +++ b/drivers/power/supply/ntxec-battery.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * The Netronix embedded controller is a microcontroller found in some
>> + * e-book readers designed by the original design manufacturer Netronix, Inc.
>> + * It contains RTC, battery monitoring, system power management, and PWM
>> + * functionality.
>> + *
>> + * This driver implements battery monitoring.
>> + *
>> + * Copyright 2021 Josua Mayer <josua.mayer@jm0.eu>
>> + */
>> +
>> +#include <linux/mfd/ntxec.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +
>> +static const enum power_supply_property ntxec_battery_properties[] = {
>> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +};
>> +
>> +struct ntxec_battery {
>> +	struct ntxec *ec;
>> +};
>> +
>> +#define NTXEC_REG_READ_BATTERY	0x41
>> +
>> +static int ntxec_battery_get_property(struct power_supply *psy,
>> +				     enum power_supply_property psp,
>> +				     union power_supply_propval *val)
>> +{
>> +	struct ntxec_battery *priv = power_supply_get_drvdata(psy);
>> +	int ret;
>> +	unsigned int value;
>> +
>> +	switch (psp) {
>> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +			ret = regmap_read(priv->ec->regmap, NTXEC_REG_READ_BATTERY, &value);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			/* ec value to microvolt conversion:
>> +			 * vendor kernel source suggests linear behaviour from 3V to 4.2V
>> +			 * with readings 767 to 1023; each increment represents 4687,5uV.
>> +			 * adjust 3V boundary slightly to report exactly 4.2V when full.
>> +			 */
>> +			val->intval = 2999872 + (value - 767) * 4688;
>> +			break;
>> +		default:
>> +			dev_err(&psy->dev, "%s: invalid property %u\n", __func__, psp);
>> +			return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct power_supply_desc ntxec_battery_desc = {
>> +	.name = "ec-battery",
>> +	.type = POWER_SUPPLY_TYPE_BATTERY,
>> +	.properties = ntxec_battery_properties,
>> +	.get_property = ntxec_battery_get_property,
>> +	.num_properties = ARRAY_SIZE(ntxec_battery_properties),
>> +};
>> +
>> +static int ntxec_battery_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ntxec *ec = dev_get_drvdata(dev->parent);
>> +	struct power_supply_config psy_cfg = {};
>> +	struct ntxec_battery *priv;
>> +	struct power_supply *psy;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->ec = ec;
>> +	psy_cfg.drv_data = priv;
>> +	psy_cfg.fwnode = dev_fwnode(dev->parent);
>> +	psy_cfg.no_wakeup_source = true;
>> +	psy = devm_power_supply_register(dev, &ntxec_battery_desc, &psy_cfg);
>> +	if (IS_ERR(psy))
>> +		return PTR_ERR(psy);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver ntxec_battery_driver = {
>> +	.driver = {
>> +		.name = "ntxec-battery",
>> +	},
>> +	.probe = ntxec_battery_probe,
>> +};
>> +module_platform_driver(ntxec_battery_driver);
>> +
>> +MODULE_AUTHOR("Josua Mayer <josua.mayer@jm0.eu>");
>> +MODULE_DESCRIPTION("Battery driver for Netronix EC");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:ntxec-battery");
> 
> Thanks,
> J. Neuschäfer



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA510C141
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 02:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfK1BGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 20:06:54 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.91]:33515 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfK1BGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 20:06:54 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 4BA50400DC98D
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 19:06:52 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id a8Giif8gKqNtva8GiiQnV7; Wed, 27 Nov 2019 19:06:52 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hvOYKQUJE21stIgSn0WN4z50J2vix7puMNZz1Y1suDY=; b=O3JngmG83jQxHb4ZrcNpw7Mhpn
        AiYoiDIeR3kYXDxmlz4VfrTSAd3m90MhLtm/mpC4PFRU26ZLpm6RVcVac4N5/L4MnsjfzUhV6VZQL
        S5C6Xd7bPm1JAodGyvuSbG3vikDQmCGbZppNrVp2h4/Z+k1qcAYsLkJzO2oGqrKCpr55Ahv7WHmxa
        rvKEpbg5362IgyELfg40R2FpopiWAbqisX6mw/7QxsEQwOm1XRfwwkN4cY9KDYI9qM4CJVK5Hlq4H
        VAiC2nuRexYHEL1Vjmfu6wlYhYlRo/h9fOmb+zJLAM+i69/djeCNRUoIpPm0pnfNiws0WQIYQbW88
        fcdzTgOQ==;
Received: from [191.31.194.237] (port=59596 helo=[192.168.15.4])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1ia8Gh-0041CU-Br; Wed, 27 Nov 2019 22:06:51 -0300
Subject: Re: [PATCH v7 4/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191117141335.23404-1-matheus@castello.eng.br>
 <20191117141335.23404-5-matheus@castello.eng.br>
 <20191126145200.xqtvfrm6qc6yuutb@earth.universe>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <c5bb4962-10f7-0877-0c99-c2dad5bb53cf@castello.eng.br>
Date:   Wed, 27 Nov 2019 22:06:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126145200.xqtvfrm6qc6yuutb@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.194.237
X-Source-L: No
X-Exim-ID: 1ia8Gh-0041CU-Br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [191.31.194.237]:59596
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 8
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Em 11/26/19 11:52 AM, Sebastian Reichel escreveu:
> Hi,
> 
> On Sun, Nov 17, 2019 at 11:13:34AM -0300, Matheus Castello wrote:
>> For configuration of fuel gauge alert for a low level state of charge
>> interrupt we add a function to config level threshold and a device tree
>> binding property to set it in flatned device tree node.
>>
>> Now we can use "maxim,alert-low-soc-level" property with the values from
>> 1% up to 32% to configure alert interrupt threshold.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   drivers/power/supply/max17040_battery.c | 75 ++++++++++++++++++++++---
>>   1 file changed, 67 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>> index 9909f8cd7b5d..3fc9e1c7b257 100644
>> --- a/drivers/power/supply/max17040_battery.c
>> +++ b/drivers/power/supply/max17040_battery.c
>> @@ -29,6 +29,9 @@
>>   #define MAX17040_DELAY		1000
>>   #define MAX17040_BATTERY_FULL	95
>>
>> +#define MAX17040_ATHD_MASK		0xFFC0
>> +#define MAX17040_ATHD_DEFAULT_POWER_UP	4
>> +
>>   struct max17040_chip {
>>   	struct i2c_client		*client;
>>   	struct delayed_work		work;
>> @@ -43,6 +46,8 @@ struct max17040_chip {
>>   	int soc;
>>   	/* State Of Charge */
>>   	int status;
>> +	/* Low alert threshold from 32% to 1% of the State of Charge */
>> +	u32 low_soc_alert;
>>   };
>>
>>   static int max17040_get_property(struct power_supply *psy,
>> @@ -99,6 +104,21 @@ static void max17040_reset(struct i2c_client *client)
>>   	max17040_write_reg(client, MAX17040_CMD, 0x0054);
>>   }
>>
>> +static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
>> +{
>> +	int ret;
>> +	u16 data;
>> +
>> +	level = 32 - level;
>> +	data = max17040_read_reg(client, MAX17040_RCOMP);
>> +	/* clear the alrt bit and set LSb 5 bits */
>> +	data &= MAX17040_ATHD_MASK;
>> +	data |= level;
>> +	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
>> +
>> +	return ret;
>> +}
>> +
>>   static void max17040_get_vcell(struct i2c_client *client)
>>   {
>>   	struct max17040_chip *chip = i2c_get_clientdata(client);
>> @@ -115,7 +135,6 @@ static void max17040_get_soc(struct i2c_client *client)
>>   	u16 soc;
>>
>>   	soc = max17040_read_reg(client, MAX17040_SOC);
>> -
> 
> unrelated change.
> 
>>   	chip->soc = (soc >> 8);
>>   }
>>
>> @@ -161,6 +180,24 @@ static void max17040_get_status(struct i2c_client *client)
>>   		chip->status = POWER_SUPPLY_STATUS_FULL;
>>   }
>>
>> +static int max17040_get_of_data(struct max17040_chip *chip)
>> +{
>> +	struct device *dev = &chip->client->dev;
>> +	struct device_node *np = dev->of_node;
>> +	int ret = 0;
>> +
>> +	if (of_property_read_u32(np, "maxim,alert-low-soc-level",
>> +				 &chip->low_soc_alert)) {
>> +		chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
>> +	} else if (chip->low_soc_alert <= 0 ||
>> +			chip->low_soc_alert >= 33) {
>> +		/* low_soc_alert is not between 1% and 32% */
>> +		ret = -EINVAL;
>> +	}
> 
> use device_property_read_u32(), which is not DT specific. Also
> code can be simplified a bit:
> 
> chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
> device_property_read_u32(dev, "maxim,alert-low-soc-level", &chip->low_soc_alert);
> if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
>      return -EINVAL;
> return 0;
> 

Thanks for the review, I will use this.

>> +
>> +	return ret;
>> +}
>> +
>>   static void max17040_check_changes(struct i2c_client *client)
>>   {
>>   	max17040_get_vcell(client);
>> @@ -192,6 +229,9 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
>>   	/* send uevent */
>>   	power_supply_changed(chip->battery);
>>
>> +	/* reset alert bit */
>> +	max17040_set_low_soc_alert(client, chip->low_soc_alert);
>> +
>>   	return IRQ_HANDLED;
>>   }
>>
>> @@ -230,6 +270,7 @@ static int max17040_probe(struct i2c_client *client,
>>   	struct i2c_adapter *adapter = client->adapter;
>>   	struct power_supply_config psy_cfg = {};
>>   	struct max17040_chip *chip;
>> +	int ret;
>>
>>   	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>>   		return -EIO;
>> @@ -240,6 +281,12 @@ static int max17040_probe(struct i2c_client *client,
>>
>>   	chip->client = client;
>>   	chip->pdata = client->dev.platform_data;
>> +	ret = max17040_get_of_data(chip);
>> +	if (ret) {
>> +		dev_err(&client->dev,
>> +			"failed: low SOC alert OF data out of bounds\n");
>> +		return ret;
>> +	}
>>
>>   	i2c_set_clientdata(client, chip);
>>   	psy_cfg.drv_data = chip;
>> @@ -256,14 +303,26 @@ static int max17040_probe(struct i2c_client *client,
>>
>>   	/* check interrupt */
>>   	if (client->irq) {
>> -		int ret;
>> -
>> -		ret = max17040_enable_alert_irq(chip);
>> -
>> -		if (ret) {
>> -			client->irq = 0;
>> +		if (of_device_is_compatible(client->dev.of_node,
>> +					    "maxim,max77836-battery")) {
>> +			ret = max17040_set_low_soc_alert(client,
>> +							 chip->low_soc_alert);
>> +			if (ret) {
>> +				dev_err(&client->dev,
>> +					"Failed to set low SOC alert: err %d\n",
>> +					ret);
>> +				return ret;
>> +			}
>> +
>> +			ret = max17040_enable_alert_irq(chip);
>> +			if (ret) {
>> +				client->irq = 0;
>> +				dev_warn(&client->dev,
>> +					 "Failed to get IRQ err %d\n", ret);
>> +			}
>> +		} else {
>>   			dev_warn(&client->dev,
>> -				 "Failed to get IRQ err %d\n", ret);
>> +				 "Device not compatible for IRQ");
> 
> Something is odd here. Either this should be part of the first
> patch ("max17040: Add IRQ handler for low SOC alert"), or both
> device types support the IRQ and this check should be removed.
> > -- Sebastian
>

The first patch add the IRQ without the configuration of the low SoC 
alert, using the default state of charge level. This patch is working 
with registers to config the low state of charge level, so it was 
proposed to just try to write registers in the models compatible with 
that (maxim,max77836-battery).

Maybe join the first patch to this one, and let DT binding be the first 
patch on the series so we can already test compatible here, let me know 
what you think about it.

>>   		}
>>   	}
>>
>> --
>> 2.24.0.rc2
>>

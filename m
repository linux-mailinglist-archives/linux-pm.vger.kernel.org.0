Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0870D13A18E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 08:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgANHSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 02:18:34 -0500
Received: from mail.manjaro.org ([176.9.38.148]:47426 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgANHSe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jan 2020 02:18:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 4DF2836E5165;
        Tue, 14 Jan 2020 08:18:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jj5y9M-JQFUd; Tue, 14 Jan 2020 08:18:29 +0100 (CET)
Subject: Re: [RESEND 1/2] power: supply: add CW2015 Fuel Gauge driver
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200109113955.2882-1-t.schramm@manjaro.org>
 <20200109113955.2882-2-t.schramm@manjaro.org>
 <20200114020616.3pg4yssrtuwxjd32@earth.universe>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <9e24dab6-2e53-b3b4-c323-ab9bf10df3af@manjaro.org>
Date:   Tue, 14 Jan 2020 08:17:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200114020616.3pg4yssrtuwxjd32@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

thanks for the review!

>> +#ifdef CONFIG_OF
>> +static int cw2015_parse_dt(struct cw_battery *cw_bat)
>> +{
>> +	struct device *dev = &cw_bat->client->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct property *prop;
>> +	int length;
>> +	u32 value;
>> +	int ret;
>> +	struct cw_bat_platform_data *data = &cw_bat->plat_data;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	memset(data, 0, sizeof(*data));
>> +
>> +	/* determine the number of config info */
>> +	prop = of_find_property(node, PREFIX"bat-config-info", &length);
>> +	if (!prop)
>> +		return -EINVAL;
>> +
>> +	length /= sizeof(u32);
>> +
>> +	if (length > 0) {
>> +		size_t size = sizeof(*data->cw_bat_config_info) * length;
>> +
>> +		data->cw_bat_config_info = devm_kzalloc(dev, size, GFP_KERNEL);
>> +		if (!data->cw_bat_config_info)
>> +			return -ENOMEM;
>> +
>> +		ret = of_property_read_u32_array(node, PREFIX"bat-config-info",
>> +						 data->cw_bat_config_info,
>> +						 length);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
> 
> In its current state it does not look like data for DT. What
> information is stored in this "config info"?
>
Truth is: I don't know. The format of this blob is neither disclosed nor 
even mentioned by publicly available datasheets.
As far as I can tell it is information about the battery used, most 
likely data on chemistry and design capacity of the pack.
Since this depends on the cell built into a device I'd expect it to be 
located in the DT.

>> +	cw_bat->bat_mode = MODE_BATTERY;
>> +	cw_bat->monitor_sec = CW2015_DEFAULT_MONITOR_SEC *
>> +			      CW2015_TIMER_MS_COUNTS;
>> +
>> +	prop = of_find_property(node, PREFIX"voltage-divider", &length);
>> +	if (prop) {
>> +		length /= sizeof(u32);
>> +		if (length != 2) {
>> +			dev_err(dev, "Length of voltage divider array must be "
>> +				"2, not %u\n", length);
>> +			return -EINVAL;
>> +		}
>> +		ret = of_property_read_u32_index(node, PREFIX"voltage-divider",
>> +						 0, &data->divider_high);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to read value of high side "
>> +				"voltage divider resistor: %d\n", ret);
>> +			return ret;
>> +		}
>> +		ret = of_property_read_u32_index(node, PREFIX"voltage-divider",
>> +						 1, &data->divider_low);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to read value of low side "
>> +				"voltage divider resistor: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = of_property_read_u32(node, PREFIX"divider-res2", &value);
>> +	if (ret < 0)
>> +		value = 0;
>> +	data->divider_low = value;
>> +
>> +	ret = of_property_read_u32(node, PREFIX"virtual-power", &value);
>> +	if (ret < 0)
>> +		value = 0;
>> +	cw_bat->bat_mode = value;
> 
> of_property_read_bool
> 
>> +	ret = of_property_read_u32(node, PREFIX"monitor-interval", &value);
>> +	if (ret < 0)
>> +		dev_err(dev, "monitor-interval missing!\n");
>> +	else
>> +		cw_bat->monitor_sec = value * CW2015_TIMER_MS_COUNTS;
>> +
>> +	ret = of_property_read_u32(node, PREFIX"design-capacity", &value);
>> +	if (ret < 0) {
>> +		dev_err(dev, "design-capacity missing!\n");
>> +		data->design_capacity = 2000;
>> +	} else {
>> +		data->design_capacity = value;
>> +	}
>> +
>> +	of_property_read_u8(node, PREFIX"alert-level", &cw_bat->alert_level);
>> +	if (cw_bat->alert_level > 100) {
>> +		dev_err(dev, "invalid alert_level, clamping to 100 %%\n");
>> +		cw_bat->alert_level = 100;
>> +	}
> 
> This does not belong into DT.
>
Is there any interface that allows setting a hardware battery alert 
level? Or should I just drop it altogether?

Tobias

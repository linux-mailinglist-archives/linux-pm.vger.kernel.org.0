Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD517280436
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgJAQrP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 12:47:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39990 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbgJAQrP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 12:47:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091GlCas110323;
        Thu, 1 Oct 2020 11:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601570832;
        bh=cBELNFIPwspTIBCA2zHV6tM8uGfMKesPrz8uvHLYLcg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vUY7LTfaP0M+evcyJRiNJ/VRusCaAkvktf7q54rf/n5rLFVSwB8gAc/EQu5+K321o
         M/Mgl660n+GqktMfINmiAlMSkxspuKWiGrAq6yl9hvKUZ1DUZWNPgbfOFHm2IAPHSA
         /pBlsfI6TWAukvMrhj6nsu4RTNgRS4qtCGBg6MwE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091GlCRY038514;
        Thu, 1 Oct 2020 11:47:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 11:47:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 11:47:11 -0500
Received: from [10.250.79.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091GlBKo001683;
        Thu, 1 Oct 2020 11:47:11 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v4 2/2] power: supply: bq256xx: Introduce
 the BQ256XX charger driver
To:     Sebastian Reichel <sre@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>
References: <20200923152416.24822-1-r-rivera-matos@ti.com>
 <20200923152416.24822-3-r-rivera-matos@ti.com>
 <20200930234725.467aylfzokwzw72z@earth.universe>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <e78c0a78-8401-a6bf-8b49-b1444da79999@ti.com>
Date:   Thu, 1 Oct 2020 11:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930234725.467aylfzokwzw72z@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 9/30/20 6:47 PM, Sebastian Reichel wrote:
> Hi,
>
> You are leaking some resources, otherwise LGTM.
ACK
>
> On Wed, Sep 23, 2020 at 10:24:16AM -0500, Ricardo Rivera-Matos wrote:
>> [...]
>> +static int bq256xx_hw_init(struct bq256xx_device *bq)
>> +{
>> +	struct power_supply_battery_info bat_info = { };
>> +	int wd_reg_val = BQ256XX_WATCHDOG_DIS;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
>> +		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>> +		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>> +			wd_reg_val = i;
>> +	}
>> +	ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
>> +				 BQ256XX_WATCHDOG_MASK, wd_reg_val <<
>> +						BQ256XX_WDT_BIT_SHIFT);
>> +
>> +	ret = power_supply_get_battery_info(bq->charger, &bat_info);
>> +	if (ret) {
>> +		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
>> +
>> +		bat_info.constant_charge_current_max_ua =
>> +				bq->chip_info->bq256xx_def_ichg;
>> +
>> +		bat_info.constant_charge_voltage_max_uv =
>> +				bq->chip_info->bq256xx_def_vbatreg;
>> +
>> +		bat_info.precharge_current_ua =
>> +				bq->chip_info->bq256xx_def_iprechg;
>> +
>> +		bat_info.charge_term_current_ua =
>> +				bq->chip_info->bq256xx_def_iterm;
>> +
>> +		bq->init_data.ichg_max =
>> +				bq->chip_info->bq256xx_max_ichg;
>> +
>> +		bq->init_data.vbatreg_max =
>> +				bq->chip_info->bq256xx_max_vbatreg;
>> +	} else {
>> +		bq->init_data.ichg_max =
>> +			bat_info.constant_charge_current_max_ua;
>> +
>> +		bq->init_data.vbatreg_max =
>> +			bat_info.constant_charge_voltage_max_uv;
>> +	}
>> +
>> +	ret = bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_iindpm(bq, bq->init_data.iindpm);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_ichg(bq,
>> +				bat_info.constant_charge_current_max_ua);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_iprechg(bq,
>> +				bat_info.precharge_current_ua);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_vbatreg(bq,
>> +				bat_info.constant_charge_voltage_max_uv);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_iterm(bq,
>> +				bat_info.charge_term_current_ua);
>> +	if (ret)
>> +		goto err_out;
> You need to power_supply_put_battery_info().
ACK
>
>> +
>> +	return 0;
>> +
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static int bq256xx_parse_dt(struct bq256xx_device *bq)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
>> +				       &bq->watchdog_timer);
>> +	if (ret)
>> +		bq->watchdog_timer = BQ256XX_WATCHDOG_DIS;
>> +
>> +	if (bq->watchdog_timer > BQ256XX_WATCHDOG_MAX ||
>> +	    bq->watchdog_timer < BQ256XX_WATCHDOG_DIS)
>> +		return -EINVAL;
>> +
>> +	ret = device_property_read_u32(bq->dev,
>> +				       "input-voltage-limit-microvolt",
>> +				       &bq->init_data.vindpm);
>> +	if (ret)
>> +		bq->init_data.vindpm = bq->chip_info->bq256xx_def_vindpm;
>> +
>> +	ret = device_property_read_u32(bq->dev,
>> +				       "input-current-limit-microamp",
>> +				       &bq->init_data.iindpm);
>> +	if (ret)
>> +		bq->init_data.iindpm = bq->chip_info->bq256xx_def_iindpm;
>> +
>> +	return 0;
>> +}
>> +
>> +static int bq256xx_probe(struct i2c_client *client,
>> +			 const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct bq256xx_device *bq;
>> +	int ret;
>> +
>> +	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
>> +	if (!bq)
>> +		return -ENOMEM;
>> +
>> +	bq->client = client;
>> +	bq->dev = dev;
>> +	bq->chip_info = &bq256xx_chip_info_tbl[id->driver_data];
>> +
>> +	mutex_init(&bq->lock);
>> +
>> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
>> +
>> +	bq->regmap = devm_regmap_init_i2c(client,
>> +					bq->chip_info->bq256xx_regmap_config);
>> +
>> +	if (IS_ERR(bq->regmap)) {
>> +		dev_err(dev, "Failed to allocate register map\n");
>> +		return PTR_ERR(bq->regmap);
>> +	}
>> +
>> +	i2c_set_clientdata(client, bq);
>> +
>> +	ret = bq256xx_parse_dt(bq);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read device tree properties%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* OTG reporting */
>> +	bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>> +	if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
>> +		INIT_WORK(&bq->usb_work, bq256xx_usb_work);
>> +		bq->usb_nb.notifier_call = bq256xx_usb_notifier;
>> +		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
>> +	}
>> +
>> +	bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>> +	if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
>> +		INIT_WORK(&bq->usb_work, bq256xx_usb_work);
>> +		bq->usb_nb.notifier_call = bq256xx_usb_notifier;
>> +		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
>> +	}
>> +
>> +	if (client->irq) {
>> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>> +						bq256xx_irq_handler_thread,
>> +						IRQF_TRIGGER_FALLING |
>> +						IRQF_ONESHOT,
>> +						dev_name(&client->dev), bq);
>> +		if (ret)
>> +			goto error_out;
>> +	}
>> +
>> +	ret = bq256xx_power_supply_init(bq, dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register power supply\n");
>> +		goto error_out;
>> +	}
>> +
>> +	ret = bq256xx_hw_init(bq);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot initialize the chip.\n");
>> +		goto error_out;
>> +	}
>> +
>> +	return ret;
>> +
>> +error_out:
>> +	if (!IS_ERR_OR_NULL(bq->usb2_phy))
>> +		usb_unregister_notifier(bq->usb2_phy, &bq->usb_nb);
>> +
>> +	if (!IS_ERR_OR_NULL(bq->usb3_phy))
>> +		usb_unregister_notifier(bq->usb3_phy, &bq->usb_nb);
>> +	return ret;
> This also needs to be called during driver removal. Probably
> it's best to do this via devm_add_action_or_reset().
ACK, I will insert devm_add_action_or_reset() just before ret = 
bq256xx_power_supply_init()
>
>> [...]
> -- Sebastian
Ricardo


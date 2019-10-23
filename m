Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED22E230E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbfJWTDO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 15:03:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58986 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390221AbfJWTDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 15:03:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NJ3DYG047935;
        Wed, 23 Oct 2019 14:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571857393;
        bh=RBsrmB5dRbnER8qyESHGRPNFCeESgDOnj0P1hXdDZlQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Bm14vLj9hbnbB3TxnihbcS4H14B6zT+VB0WFfx07hMqz+eFmKoLYDUMr3GwK6aQl+
         IG+wnUg8HWljnBxWO0jeDtWbGWv0LVxGFc5HnE2ew6Df7o4bW3QQNOQQ8qAEVpqM+m
         evPNzo1DZp1w7C3W8DKU65dAttaL5zzQJA9vdmt8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NJ3C8O106139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 14:03:13 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 14:03:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 14:03:02 -0500
Received: from [10.250.35.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NJ3Bx1066089;
        Wed, 23 Oct 2019 14:03:12 -0500
Subject: Re: [PATCH 3/3] power: supply: bq2515x: Introduce the bq2515x family
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190930143137.21624-1-dmurphy@ti.com>
 <20190930143137.21624-3-dmurphy@ti.com>
 <20191020121514.yt3vgfpgldsxe2x4@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <66e6ebdf-628b-458a-8acb-65691ea83866@ti.com>
Date:   Wed, 23 Oct 2019 14:02:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020121514.yt3vgfpgldsxe2x4@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 10/20/19 7:15 AM, Sebastian Reichel wrote:
> Hi Dan,
>
> On Mon, Sep 30, 2019 at 09:31:37AM -0500, Dan Murphy wrote:
[...]
>> +
>> +static int bq2515x_power_supply_register(struct bq2515x_device *bq2515x)
>> +{
>> +	struct power_supply_config psy_cfg = { .drv_data = bq2515x, };
>> +	int ret = -EINVAL;
>> +
>> +	bq2515x->mains = devm_power_supply_register(bq2515x->dev,
>> +						    &bq2515x_mains_desc,
>> +						    &psy_cfg);
>> +	if (IS_ERR(bq2515x->mains))
>> +		return ret;
>> +
>> +	bq2515x->battery = devm_power_supply_register(bq2515x->dev,
>> +						      &bq2515x_battery_desc,
>> +						      &psy_cfg);
>> +	if (IS_ERR(bq2515x->battery)) {
>> +		power_supply_unregister(bq2515x->mains);
> you registered the mains power-supply with devm_ prefix, so it
> will be removed automatically.
Ack
>
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
>> +{
>> +	int ret = 0;
>> +
>> +	if (bq2515x->init_data.ichg)
>> +		ret = bq2515x_set_ilim_lvl(bq2515x, bq2515x->init_data.ichg);
>> +
>> +	if (bq2515x->init_data.vreg)
>> +		ret = bq2515x_set_batt_reg(bq2515x, bq2515x->init_data.vreg);
> This throws away potential error code from bq2515x_set_ilim_lvl().
Ack
>> +	return ret;
>> +}
>> +
>> +static int bq2515x_read_properties(struct bq2515x_device *bq2515x)
>> +{
>> +	int ret;
>> +
>> +	ret = device_property_read_u8(bq2515x->dev, "ti,charge-current",
>> +				      &bq2515x->init_data.ichg);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	ret = device_property_read_u8(bq2515x->dev,
>> +				      "ti,battery-regulation-voltage",
>> +				      &bq2515x->init_data.vreg);
>> +	if (ret)
>> +		goto fail;
> The above properties are marked as optional in the DT bindings
> document.
ACK.  Will just set them to the data sheet default values
>
>> +	bq2515x->pg_gpio = devm_gpiod_get_optional(bq2515x->dev,
>> +						   "pg", GPIOD_IN);
>> +	if (IS_ERR(bq2515x->pg_gpio))
>> +		dev_info(bq2515x->dev, "PG GPIO not defined");
>> +
>> +	bq2515x->reset_gpio = devm_gpiod_get_optional(bq2515x->dev,
>> +						   "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(bq2515x->reset_gpio))
>> +		dev_info(bq2515x->dev, "reset GPIO not defined");
>> +
>> +	bq2515x->lp_gpio = devm_gpiod_get_optional(bq2515x->dev, "low-power",
>> +						   GPIOD_OUT_LOW);
>> +	if (IS_ERR(bq2515x->lp_gpio))
>> +		dev_info(bq2515x->dev, "LP GPIO not defined");
>> +
>> +	bq2515x->ce_gpio = devm_gpiod_get_optional(bq2515x->dev,
>> +						   "charge-enable",
>> +						   GPIOD_OUT_HIGH);
>> +	if (IS_ERR(bq2515x->ce_gpio))
>> +		dev_info(bq2515x->dev, "Charge enable GPIO not defined");
> The GPIO errors should not be ignored, especially since you
> might get a -EPROBE_DEFER.

ACK


>> +fail:
>> +	return ret;
>> +}
>> +
>> +static const struct regmap_config bq2515x_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.max_register = BQ2515X_DEVICE_ID,
>> +	.reg_defaults     = bq2515x_reg_defs,
>> +	.num_reg_defaults = ARRAY_SIZE(bq2515x_reg_defs),
>> +	.cache_type	  = REGCACHE_RBTREE,
>> +};
>> +
>> +static int bq2515x_probe(struct i2c_client *client,
>> +			 const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct bq2515x_device *bq;
>> +	int ret;
>> +
>> +	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
>> +	if (!bq)
>> +		return -ENOMEM;
>> +
>> +	bq->client = client;
>> +	bq->dev = dev;
>> +
>> +	mutex_init(&bq->lock);
>> +
>> +	bq->regmap = devm_regmap_init_i2c(client, &bq2515x_regmap_config);
>> +	if (IS_ERR(bq->regmap)) {
>> +		dev_err(dev, "failed to allocate register map\n");
>> +		return PTR_ERR(bq->regmap);
>> +	}
>> +
>> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
>> +
>> +	i2c_set_clientdata(client, bq);
>> +
>> +	ret = bq2515x_read_properties(bq);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to register power supply\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = bq2515x_hw_init(bq);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot initialize the chip.\n");
>> +		return ret;
>> +	}
>> +
>> +	return bq2515x_power_supply_register(bq);
>> +}
>> +
>> +static const struct i2c_device_id bq2515x_i2c_ids[] = {
>> +	{ "bq25150", 0 },
>> +	{ "bq25155", 1 },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, bq2515x_i2c_ids);
>> +
>> +static const struct of_device_id bq2515x_of_match[] = {
>> +	{ .compatible = "ti,bq25150", },
>> +	{ .compatible = "ti,bq25155", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, bq2515x_of_match);
>> +
>> +static struct i2c_driver bq2515x_driver = {
>> +	.driver = {
>> +		.name = "bq2515x-charger",
>> +		.of_match_table = of_match_ptr(bq2515x_of_match),
> You need to do one of those:
>
>   * remove of_match_ptr and specify bq2515x_of_match directly
>   * put the OF table in #ifdef CONFIG_OF
>   * mark the OF table as __maybe_unused

Probably just do the first one.

Dan


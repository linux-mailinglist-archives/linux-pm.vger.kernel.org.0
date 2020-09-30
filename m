Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12227F62C
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 01:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgI3Xrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 19:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgI3Xr3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 19:47:29 -0400
Received: from earth.universe (dyndsl-091-096-063-136.ewe-ip-backbone.de [91.96.63.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EDE20C09;
        Wed, 30 Sep 2020 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601509648;
        bh=iR4aq6UI4mVmKcHUC5dsDNW9kyo86vbB1cOU/XmtlWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhN1TKskMUjnltP5VtGAUY/U/RwClmzKta5g+AA4e/iGXzaoj2WwdIgESVVjNPqYd
         v6WnqwGqI3ajKJL30XbLJhTLCYt/MiRwBXVxjh4Pw7Vl3KA0FZj4lkV1ry3jO6ep6t
         ftBBufGZ30EmVgjQ6w/0xOmaIAbTDezR/L1p+TZ8=
Received: by earth.universe (Postfix, from userid 1000)
        id CEE393C0C84; Thu,  1 Oct 2020 01:47:25 +0200 (CEST)
Date:   Thu, 1 Oct 2020 01:47:25 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v4 2/2] power: supply: bq256xx: Introduce the BQ256XX
 charger driver
Message-ID: <20200930234725.467aylfzokwzw72z@earth.universe>
References: <20200923152416.24822-1-r-rivera-matos@ti.com>
 <20200923152416.24822-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7pgq53fiwunzpu4p"
Content-Disposition: inline
In-Reply-To: <20200923152416.24822-3-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7pgq53fiwunzpu4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

You are leaking some resources, otherwise LGTM.

On Wed, Sep 23, 2020 at 10:24:16AM -0500, Ricardo Rivera-Matos wrote:
> [...]
> +static int bq256xx_hw_init(struct bq256xx_device *bq)
> +{
> +	struct power_supply_battery_info bat_info = { };
> +	int wd_reg_val = BQ256XX_WATCHDOG_DIS;
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
> +		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
> +		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
> +			wd_reg_val = i;
> +	}
> +	ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
> +				 BQ256XX_WATCHDOG_MASK, wd_reg_val <<
> +						BQ256XX_WDT_BIT_SHIFT);
> +
> +	ret = power_supply_get_battery_info(bq->charger, &bat_info);
> +	if (ret) {
> +		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
> +
> +		bat_info.constant_charge_current_max_ua =
> +				bq->chip_info->bq256xx_def_ichg;
> +
> +		bat_info.constant_charge_voltage_max_uv =
> +				bq->chip_info->bq256xx_def_vbatreg;
> +
> +		bat_info.precharge_current_ua =
> +				bq->chip_info->bq256xx_def_iprechg;
> +
> +		bat_info.charge_term_current_ua =
> +				bq->chip_info->bq256xx_def_iterm;
> +
> +		bq->init_data.ichg_max =
> +				bq->chip_info->bq256xx_max_ichg;
> +
> +		bq->init_data.vbatreg_max =
> +				bq->chip_info->bq256xx_max_vbatreg;
> +	} else {
> +		bq->init_data.ichg_max =
> +			bat_info.constant_charge_current_max_ua;
> +
> +		bq->init_data.vbatreg_max =
> +			bat_info.constant_charge_voltage_max_uv;
> +	}
> +
> +	ret = bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq->chip_info->bq256xx_set_iindpm(bq, bq->init_data.iindpm);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq->chip_info->bq256xx_set_ichg(bq,
> +				bat_info.constant_charge_current_max_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq->chip_info->bq256xx_set_iprechg(bq,
> +				bat_info.precharge_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq->chip_info->bq256xx_set_vbatreg(bq,
> +				bat_info.constant_charge_voltage_max_uv);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq->chip_info->bq256xx_set_iterm(bq,
> +				bat_info.charge_term_current_ua);
> +	if (ret)
> +		goto err_out;

You need to power_supply_put_battery_info().

> +
> +	return 0;
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int bq256xx_parse_dt(struct bq256xx_device *bq)
> +{
> +	int ret = 0;
> +
> +	ret = device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
> +				       &bq->watchdog_timer);
> +	if (ret)
> +		bq->watchdog_timer = BQ256XX_WATCHDOG_DIS;
> +
> +	if (bq->watchdog_timer > BQ256XX_WATCHDOG_MAX ||
> +	    bq->watchdog_timer < BQ256XX_WATCHDOG_DIS)
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32(bq->dev,
> +				       "input-voltage-limit-microvolt",
> +				       &bq->init_data.vindpm);
> +	if (ret)
> +		bq->init_data.vindpm = bq->chip_info->bq256xx_def_vindpm;
> +
> +	ret = device_property_read_u32(bq->dev,
> +				       "input-current-limit-microamp",
> +				       &bq->init_data.iindpm);
> +	if (ret)
> +		bq->init_data.iindpm = bq->chip_info->bq256xx_def_iindpm;
> +
> +	return 0;
> +}
> +
> +static int bq256xx_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct bq256xx_device *bq;
> +	int ret;
> +
> +	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> +	if (!bq)
> +		return -ENOMEM;
> +
> +	bq->client = client;
> +	bq->dev = dev;
> +	bq->chip_info = &bq256xx_chip_info_tbl[id->driver_data];
> +
> +	mutex_init(&bq->lock);
> +
> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
> +
> +	bq->regmap = devm_regmap_init_i2c(client,
> +					bq->chip_info->bq256xx_regmap_config);
> +
> +	if (IS_ERR(bq->regmap)) {
> +		dev_err(dev, "Failed to allocate register map\n");
> +		return PTR_ERR(bq->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, bq);
> +
> +	ret = bq256xx_parse_dt(bq);
> +	if (ret) {
> +		dev_err(dev, "Failed to read device tree properties%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* OTG reporting */
> +	bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +	if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
> +		INIT_WORK(&bq->usb_work, bq256xx_usb_work);
> +		bq->usb_nb.notifier_call = bq256xx_usb_notifier;
> +		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
> +	}
> +
> +	bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +	if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
> +		INIT_WORK(&bq->usb_work, bq256xx_usb_work);
> +		bq->usb_nb.notifier_call = bq256xx_usb_notifier;
> +		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
> +	}
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +						bq256xx_irq_handler_thread,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						dev_name(&client->dev), bq);
> +		if (ret)
> +			goto error_out;
> +	}
> +
> +	ret = bq256xx_power_supply_init(bq, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register power supply\n");
> +		goto error_out;
> +	}
> +
> +	ret = bq256xx_hw_init(bq);
> +	if (ret) {
> +		dev_err(dev, "Cannot initialize the chip.\n");
> +		goto error_out;
> +	}
> +
> +	return ret;
> +
> +error_out:
> +	if (!IS_ERR_OR_NULL(bq->usb2_phy))
> +		usb_unregister_notifier(bq->usb2_phy, &bq->usb_nb);
> +
> +	if (!IS_ERR_OR_NULL(bq->usb3_phy))
> +		usb_unregister_notifier(bq->usb3_phy, &bq->usb_nb);
> +	return ret;

This also needs to be called during driver removal. Probably
it's best to do this via devm_add_action_or_reset().

> [...]

-- Sebastian

--7pgq53fiwunzpu4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl91GP8ACgkQ2O7X88g7
+ppYlw//Q8IeAQxE/xXhvgs8NuIfoZbgio/EjZJNd2uixfhB8PL94/xV6RuFLJ70
ERhJiS83fC7o5ijkMIuwSzxw2fgbmdCTVi1d9M9Z0O5VGWcA2WgLKNNSZJ1OV5Ii
TEb4CljBdOjEWTyRybn+l5oPj34QH+C3x59u1fU3T1LJpUPPtLpaEFq3SK5T6NI2
gmmDBdj7lOcoSp06uuZT5W9XmkWBxIUAE35+AFzvnwbedh2AdIsjjZtx2x428uO1
zhvk9syqoTRCDHcBt7bvg9fLUg38FC1LAHlhoL6rRjRyjzSZSK58Yo7scK6HWgZe
uLYTVy2LHNwl7+s/8BFcqM1gBIvfRozqR/DPIwYC1pLNxk7CqG04ZNOm1RI6Ma1m
sEGKgG3sPaskd33v+TQT1N51W7K+iWa0wE368HB5o2DbtZtCN5nk7gIhAFynjPXV
U+maHdi32GCODvzlPfdxuoFZrKOjS6wEOGD/fjDz5s7Z5Fb2l2VhFkw7E95iHgdU
oSJLysZsG1w8NwhRVJDLlAw4+IEKWWhpOgELTMJJlrpUlrm4Vf7qst8Pqoxcnm8e
rW3WzYifpUomcWdWzZpGFoQKazTP/oB3U/KVGs9ojhG1VYgR4l/Y4+VZ/yDDah06
Fb6uoUUWCz8z+GFjsxvYJoBTW8GyW+b4VrTqPm/PGZ9XTvn5m90=
=+yQa
-----END PGP SIGNATURE-----

--7pgq53fiwunzpu4p--

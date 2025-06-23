Return-Path: <linux-pm+bounces-29401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB7AE4C21
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 19:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A2816855B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF62D3231;
	Mon, 23 Jun 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WLAD3Imn"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1461B393C;
	Mon, 23 Jun 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700868; cv=pass; b=tYNZWM4gqt/ku5X/8T8V+6/JmNsbzUzIEZg73fHmoDlqXQfqZFHdIPTHBAAaibwmg5a6m31ElRw5xxz8fY0bZ6c/mTjZk5zU73II1KE+2oZVMFfLnaagUD7C4cGKohj2kU7lZtIGBJebLDzvqfsfkzI6Ts24UcQyx9fnQrbna4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700868; c=relaxed/simple;
	bh=ayITbcPk18S2CL16f9xOjl+k4Klo3YiTjwCJ3DaO7K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA+1PH10MXIgiM5nz5r/6xKKLz2090xkxqX6pVqYdBMDxZOVCgDE6y0TBTP9ChSIKfO5gn1p9sO92LmbncUGoNiGqJLJSmxWS7hXij6AMEUtmYdu38pdxuZXx21yJQUq5apyjjK3S6c0WpZLiQHadRwsydwZV8AqmmfRVy/wuDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WLAD3Imn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750700850; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HoP6ru0tRsyiSsw2S7EaGG97yVGCL+XzUiWPc4tkHekFOE2rCRTQ4/hKsbm0gS4emLutlwKbQ5auObXN7KiYTXpvwvnYHD2RsAk6Xg5tjwukPCx6AMVrsYGTlE0wDv9X8xiJsOwkHZz/Fxn9LL1zUoDREaINIpeTJvB0UK6nx/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750700850; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SAP9ZoSDN099bYrKgdNfpIKbEdFruDtkUbcW65OTaKE=; 
	b=QtLXPeFBd2cGPi/fQV92g3X3tAa/Fk3ftC6CMNIL4sJVBODvEbCMLSaT05fTAq8koxWvBk720grA+ADOZ05mQhZ/i5dVbbkoKojWLX4rCPexFB1Er4Tloayi1yQ02y/RqeUHrhI4z1IoxossL6dOmqhIeX2rtLUKa/WMtox9xRM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750700850;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=SAP9ZoSDN099bYrKgdNfpIKbEdFruDtkUbcW65OTaKE=;
	b=WLAD3ImnHCk6WRjCeKNcvjhfdPQ31ezmTEWtyoSHf7lymdE7gMC5OKwEGnrVwclO
	PH6dXgayKhu/RRDJnLsEZ0mpK2/V4qOoYDd5VIU8q81QkIcwZMtKOAXw9z0vIdyOsmB
	j7bfqOOw839/2XreU7aGTja07D8JQnghHIFU53m0=
Received: by mx.zohomail.com with SMTPS id 1750700849253177.21966327827772;
	Mon, 23 Jun 2025 10:47:29 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1DA881807CE; Mon, 23 Jun 2025 19:47:25 +0200 (CEST)
Date: Mon, 23 Jun 2025 19:47:25 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, heiko@sntech.de, 
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 3/5] power: supply: bq257xx: Add support for BQ257XX
 charger
Message-ID: <tzn53fqo6vgdxayokwlfwluf33af2kly2c6rlxasvjuaetwtl3@rwzqx5gdrflo>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
 <20250623162223.184304-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rluckearszbi5kv"
Content-Disposition: inline
In-Reply-To: <20250623162223.184304-4-macroalpha82@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.696.82
X-ZohoMailClient: External


--3rluckearszbi5kv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V3 3/5] power: supply: bq257xx: Add support for BQ257XX
 charger
MIME-Version: 1.0

Hi,

On Mon, Jun 23, 2025 at 11:22:21AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add support for the charger function of the BQ257XX. The device is
> capable of charging batteries with a layout of 1 to 4 cells in
> series.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/power/supply/Kconfig           |   7 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/bq257xx_charger.c | 754 +++++++++++++++++++++++++
>  3 files changed, 762 insertions(+)
>  create mode 100644 drivers/power/supply/bq257xx_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2da..11893c50c5d2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -767,6 +767,13 @@ config CHARGER_BQ2515X
>  	  rail, ADC for battery and system monitoring, and push-button
>  	  controller.
> =20
> +config CHARGER_BQ257XX
> +	tristate "TI BQ257XX battery charger family"
> +	depends on MFD_BQ257XX
> +	help
> +	  Say Y to enable support for the TI BQ257XX family of battery
> +	  charging integrated circuits.
> +
>  config CHARGER_BQ25890
>  	tristate "TI BQ25890 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4f5f8e3507f8..425caeb31fc2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
>  obj-$(CONFIG_CHARGER_BQ2515X)	+=3D bq2515x_charger.o
> +obj-$(CONFIG_CHARGER_BQ257XX)	+=3D bq257xx_charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
>  obj-$(CONFIG_CHARGER_BQ25980)	+=3D bq25980_charger.o
>  obj-$(CONFIG_CHARGER_BQ256XX)	+=3D bq256xx_charger.o
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> new file mode 100644
> index 000000000000..749c471eccb1
> --- /dev/null
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -0,0 +1,754 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BQ257XX Battery Charger Driver
> + * Copyright (C) 2024 Chris Morgan <macromorgan@hotmail.com>
> + * Based off of BQ256XX Battery Charger Driver
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/bq257xx.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* Forward declaration of driver data. */
> +struct bq257xx_chg;
> +
> +/**
> + * struct bq257xx_chip_info - chip specific routines
> + * @bq257xx_hw_init: init function for hw
> + * @bq257xx_hw_shutdown: shutdown function for hw
> + * @bq257xx_get_state: get and update state of hardware
> + * @bq257xx_set_ichg: set maximum charge current (in uA)
> + * @bq257xx_set_vbatreg: set maximum charge voltage (in uV)
> + * @bq257xx_set_iindpm: set maximum input current (in uA)
> + */
> +struct bq257xx_chip_info {
> +	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
> +	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
> +	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
> +	int (*bq257xx_set_ichg)(struct bq257xx_chg *pdata, int ichg);
> +	int (*bq257xx_set_vbatreg)(struct bq257xx_chg *pdata, int vbatreg);
> +	int (*bq257xx_set_iindpm)(struct bq257xx_chg *pdata, int iindpm);
> +};
> +
> +/**
> + * struct bq257xx_chg - driver data for charger
> + * @chip: hw specific functions
> + * @bq: parent MFD device
> + * @charger: power supply device
> + * @online: charger input is present
> + * @fast_charge: charger is in fast charge mode
> + * @pre_charge: charger is in pre-charge mode
> + * @ov_fault: charger reports over voltage fault
> + * @batoc_fault: charger reports battery over current fault
> + * @oc_fault: charger reports over current fault
> + * @usb_type: USB type reported from parent power supply
> + * @supplied: Status of parent power supply
> + * @iindpm_max: maximum input current limit (uA)
> + * @vbat_max: maximum charge voltage (uV)
> + * @ichg_max: maximum charge current (uA)
> + * @vsys_min: minimum system voltage (uV)
> + */
> +struct bq257xx_chg {
> +	const struct bq257xx_chip_info *chip;
> +	struct bq257xx_device *bq;
> +	struct power_supply *charger;
> +	bool online;
> +	bool fast_charge;
> +	bool pre_charge;
> +	bool ov_fault;
> +	bool batoc_fault;
> +	bool oc_fault;
> +	int usb_type;
> +	int supplied;
> +	u32 iindpm_max;
> +	u32 vbat_max;
> +	u32 ichg_max;
> +	u32 vsys_min;
> +};
> +
> +/**
> + * bq25703_get_state() - Get the current state of the device
> + * @pdata: driver platform data
> + *
> + * Get the current state of the charger. Check if the charger is
> + * powered, what kind of charge state (if any) the device is in,
> + * and if there are any active faults.
> + *
> + * Return: Returns 0 on success, or error on failure to read device.
> + */
> +static int bq25703_get_state(struct bq257xx_chg *pdata)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_CHARGER_STATUS, &reg);
> +	if (ret)
> +		return ret;
> +
> +	pdata->online =3D reg & BQ25703_STS_AC_STAT;
> +	pdata->fast_charge =3D reg & BQ25703_STS_IN_FCHRG;
> +	pdata->pre_charge =3D reg & BQ25703_STS_IN_PCHRG;
> +	pdata->ov_fault =3D reg & BQ25703_STS_FAULT_ACOV;
> +	pdata->batoc_fault =3D reg & BQ25703_STS_FAULT_BATOC;
> +	pdata->oc_fault =3D reg & BQ25703_STS_FAULT_ACOC;
> +
> +	return 0;
> +}
> +
> +/**
> + * bq25703_get_min_vsys() - Get the minimum system voltage
> + * @pdata: driver platform data
> + * @intval: value for minimum voltage
> + *
> + * Return: Returns 0 on success or error on failure to read.
> + */
> +static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_MIN_VSYS,
> +			  &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D FIELD_GET(BQ25703_MINVSYS_MASK, reg);
> +	*intval =3D (reg * BQ25703_MINVSYS_STEP_UV) + BQ25703_MINVSYS_MIN_UV;
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_set_min_vsys() - Set the minimum system voltage
> + * @pdata: driver platform data
> + * @vsys: voltage value to set in uV.
> + *
> + * This function takes a requested minimum system voltage value, clamps
> + * it between the minimum supported value by the charger and a user
> + * defined minimum system value, and then writes the value to the
> + * appropriate register.
> + *
> + * Return: Returns 0 on success or error if an error occurs.
> + */
> +static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
> +{
> +	unsigned int reg;
> +	int vsys_min =3D pdata->vsys_min;
> +
> +	vsys =3D clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
> +	reg =3D ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
> +	reg =3D FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
> +
> +	return regmap_write(pdata->bq->regmap, BQ25703_MIN_VSYS,
> +			    reg);
> +}
> +
> +/**
> + * bq25703_get_cur() - Get the reported current from the battery
> + * @pdata: driver platform data
> + * @intval: value of reported battery current
> + *
> + * Read the reported current from the battery. Since value is always
> + * positive set sign to negative if discharging.
> + *
> + * Return: Returns 0 on success or error if unable to read value.
> + */
> +static int bq25703_get_cur(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_ADCIBAT_CHG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pdata->online)
> +		*intval =3D FIELD_GET(BQ25703_ADCIBAT_CHG_MASK, reg) *
> +			  BQ25703_ADCIBAT_CHG_STEP_UA;
> +	else
> +		*intval =3D -(FIELD_GET(BQ25703_ADCIBAT_DISCHG_MASK, reg) *
> +			    BQ25703_ADCIBAT_DIS_STEP_UA);
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_get_ichg_cur() - Get the maximum reported charge current
> + * @pdata: driver platform data
> + * @intval: value of maximum reported charge current
> + *
> + * Get the maximum reported charge current from the battery.
> + *
> + * Return: Returns 0 on success or error if unable to read value.
> + */
> +static int bq25703_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_CHARGE_CURRENT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*intval =3D FIELD_GET(BQ25703_ICHG_MASK, reg) * BQ25703_ICHG_STEP_UA;
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_set_ichg_cur() - Set the maximum charge current
> + * @pdata: driver platform data
> + * @ichg: current value to set in uA.
> + *
> + * This function takes a requested maximum charge current value, clamps
> + * it between the minimum supported value by the charger and a user
> + * defined maximum charging value, and then writes the value to the
> + * appropriate register.
> + *
> + * Return: Returns 0 on success or error if an error occurs.
> + */
> +static int bq25703_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
> +{
> +	unsigned int reg;
> +	int ichg_max =3D pdata->ichg_max;
> +
> +	ichg =3D clamp(ichg, BQ25703_ICHG_MIN_UA, ichg_max);
> +	reg =3D FIELD_PREP(BQ25703_ICHG_MASK, (ichg / BQ25703_ICHG_STEP_UA));
> +
> +	return regmap_write(pdata->bq->regmap, BQ25703_CHARGE_CURRENT,
> +			    reg);
> +}
> +
> +/**
> + * bq25703_get_chrg_volt() - Get the maximum set charge voltage
> + * @pdata: driver platform data
> + * @intval: maximum charge voltage value
> + *
> + * Return: Returns 0 on success or error if unable to read value.
> + */
> +static int bq25703_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_MAX_CHARGE_VOLT,
> +			  &reg);
> +	if (ret)
> +		return ret;
> +
> +	*intval =3D FIELD_GET(BQ25703_MAX_CHARGE_VOLT_MASK, reg) *
> +		  BQ25703_VBATREG_STEP_UV;
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_set_chrg_volt() - Set the maximum charge voltage
> + * @pdata: driver platform data
> + * @vbat: voltage value to set in uV.
> + *
> + * This function takes a requested maximum charge voltage value, clamps
> + * it between the minimum supported value by the charger and a user
> + * defined maximum charging value, and then writes the value to the
> + * appropriate register.
> + *
> + * Return: Returns 0 on success or error if an error occurs.
> + */
> +static int bq25703_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
> +{
> +	unsigned int reg;
> +	int vbat_max =3D pdata->vbat_max;
> +
> +	vbat =3D clamp(vbat, BQ25703_VBATREG_MIN_UV, vbat_max);
> +
> +	reg =3D FIELD_PREP(BQ25703_MAX_CHARGE_VOLT_MASK,
> +			 (vbat / BQ25703_VBATREG_STEP_UV));
> +
> +	return regmap_write(pdata->bq->regmap, BQ25703_MAX_CHARGE_VOLT,
> +			    reg);
> +}
> +
> +/**
> + * bq25703_get_iindpm() - Get the maximum set input current
> + * @pdata: driver platform data
> + * @intval: maximum input current value
> + *
> + * Read the actual input current limit from the device into intval.
> + * This can differ from the value programmed due to some autonomous
> + * functions that may be enabled (but are not currently). This is why
> + * there is a different register used.
> + *
> + * Return: Returns 0 on success or error if unable to read register
> + * value.
> + */
> +static int bq25703_get_iindpm(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_IIN_DPM, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D FIELD_GET(BQ25703_IINDPM_MASK, reg);
> +	*intval =3D (reg * BQ25703_IINDPM_STEP_UA) + BQ25703_IINDPM_OFFSET_UA;
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_set_iindpm() - Set the maximum input current
> + * @pdata: driver platform data
> + * @iindpm: current value in uA.
> + *
> + * This function takes a requested maximum input current value, clamps
> + * it between the minimum supported value by the charger and a user
> + * defined maximum input value, and then writes the value to the
> + * appropriate register.
> + *
> + * Return: Returns 0 on success or error if an error occurs.
> + */
> +static int bq25703_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
> +{
> +	unsigned int reg;
> +	int iindpm_max =3D pdata->iindpm_max;
> +
> +	iindpm =3D clamp(iindpm, BQ25703_IINDPM_MIN_UA, iindpm_max);
> +
> +	reg =3D ((iindpm - BQ25703_IINDPM_OFFSET_UA) / BQ25703_IINDPM_STEP_UA);
> +
> +	return regmap_write(pdata->bq->regmap, BQ25703_IIN_HOST,
> +			    FIELD_PREP(BQ25703_IINDPM_MASK, reg));
> +}
> +
> +/**
> + * bq25703_get_vbat() - Get the reported voltage from the battery
> + * @pdata: driver platform data
> + * @intval: value of reported battery voltage
> + *
> + * Read value of battery voltage into intval.
> + *
> + * Return: Returns 0 on success or error if unable to read value.
> + */
> +static int bq25703_get_vbat(struct bq257xx_chg *pdata, int *intval)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(pdata->bq->regmap, BQ25703_ADCVSYSVBAT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D FIELD_GET(BQ25703_ADCVBAT_MASK, reg);
> +	*intval =3D (reg * BQ25703_ADCVSYSVBAT_STEP) + BQ25703_ADCVSYSVBAT_OFFS=
ET_UV;
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_hw_init() - Set all the required registers to init the charger
> + * @pdata: driver platform data
> + *
> + * Initialize the BQ25703 by first disabling the watchdog timer (which
> + * shuts off the charger in the absence of periodic writes). Then, set
> + * the charge current, charge voltage, minimum system voltage, and
> + * input current limit. Disable low power mode to allow ADCs and
> + * interrupts. Enable the ADC, start the ADC, set the ADC scale to
> + * full, and enable each individual ADC channel.
> + *
> + * Return: Returns 0 on success or error code on error.
> + */
> +static int bq25703_hw_init(struct bq257xx_chg *pdata)
> +{
> +	struct regmap *regmap =3D pdata->bq->regmap;
> +	int ret =3D 0;
> +
> +	regmap_update_bits(regmap, BQ25703_CHARGE_OPTION_0,
> +			   BQ25703_WDTMR_ADJ_MASK,
> +			   FIELD_PREP(BQ25703_WDTMR_ADJ_MASK,
> +			   BQ25703_WDTMR_DISABLE));
> +
> +	ret =3D pdata->chip->bq257xx_set_ichg(pdata, pdata->ichg_max);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdata->chip->bq257xx_set_vbatreg(pdata, pdata->vbat_max);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D bq25703_set_min_vsys(pdata, pdata->vsys_min);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdata->chip->bq257xx_set_iindpm(pdata, pdata->iindpm_max);
> +	if (ret)
> +		return ret;
> +
> +	regmap_update_bits(regmap, BQ25703_CHARGE_OPTION_0,
> +			   BQ25703_EN_LWPWR, !BQ25703_EN_LWPWR);
> +
> +	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> +			   BQ25703_ADC_CONV_EN, BQ25703_ADC_CONV_EN);
> +
> +	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> +			   BQ25703_ADC_START, BQ25703_ADC_START);
> +
> +	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> +			   BQ25703_ADC_FULL_SCALE, BQ25703_ADC_FULL_SCALE);
> +
> +	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> +			   BQ25703_ADC_CH_MASK,
> +			   (BQ25703_ADC_CMPIN_EN | BQ25703_ADC_VBUS_EN |
> +			   BQ25703_ADC_PSYS_EN | BQ25703_ADC_IIN_EN |
> +			   BQ25703_ADC_IDCHG_EN | BQ25703_ADC_ICHG_EN |
> +			   BQ25703_ADC_VSYS_EN | BQ25703_ADC_VBAT_EN));
> +
> +	return ret;
> +}
> +
> +/**
> + * bq25703_hw_shutdown() - Set registers for shutdown
> + * @pdata: driver platform data
> + *
> + * Enable low power mode for the device while in shutdown.
> + */
> +static void bq25703_hw_shutdown(struct bq257xx_chg *pdata)
> +{
> +	regmap_update_bits(pdata->bq->regmap, BQ25703_CHARGE_OPTION_0,
> +			   BQ25703_EN_LWPWR, BQ25703_EN_LWPWR);
> +}
> +
> +static int bq257xx_set_charger_property(struct power_supply *psy,
> +		enum power_supply_property prop,
> +		const union power_supply_propval *val)
> +{
> +	struct bq257xx_chg *pdata =3D power_supply_get_drvdata(psy);
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return pdata->chip->bq257xx_set_iindpm(pdata, val->intval);
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return pdata->chip->bq257xx_set_vbatreg(pdata, val->intval);
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return pdata->chip->bq257xx_set_ichg(pdata, val->intval);
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bq257xx_get_charger_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct bq257xx_chg *pdata =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	ret =3D pdata->chip->bq257xx_get_state(pdata);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!pdata->online)
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (pdata->fast_charge || pdata->pre_charge)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (pdata->ov_fault || pdata->batoc_fault)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else if (pdata->oc_fault)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERCURRENT;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D "Texas Instruments";
> +		break;
> +
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D pdata->online;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return bq25703_get_iindpm(pdata, &val->intval);
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return bq25703_get_chrg_volt(pdata, &val->intval);
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return bq25703_get_cur(pdata, &val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		return bq25703_get_vbat(pdata, &val->intval);
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return bq25703_get_ichg_cur(pdata, &val->intval);
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		return bq25703_get_min_vsys(pdata, &val->intval);
> +
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval =3D pdata->usb_type;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static enum power_supply_property bq257xx_power_supply_props[] =3D {
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static int bq257xx_property_is_writeable(struct power_supply *psy,
> +					 enum power_supply_property prop)
> +{
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * bq257xx_external_power_changed() - Handler for external power change
> + * @psy: Power supply data
> + *
> + * When the external power into the charger is changed, check the USB
> + * type so that it can be reported. Additionally, update the max input
> + * current and max charging current to the value reported if it is a
> + * USB PD charger, otherwise use the default value. Note that each time
> + * a charger is removed the max charge current register is erased, so
> + * it must be set again each time the input changes or the device will
> + * not charge.
> + */
> +static void bq257xx_external_power_changed(struct power_supply *psy)
> +{
> +	struct bq257xx_chg *pdata =3D power_supply_get_drvdata(psy);
> +	union power_supply_propval val;
> +	int ret;
> +	int imax =3D pdata->iindpm_max;
> +
> +	pdata->chip->bq257xx_get_state(pdata);
> +
> +	pdata->supplied =3D power_supply_am_i_supplied(pdata->charger);
> +	if (pdata->supplied < 0)
> +		return;
> +
> +	if (pdata->supplied =3D=3D 0)
> +		goto out;
> +
> +	ret =3D power_supply_get_property_from_supplier(psy,
> +						      POWER_SUPPLY_PROP_USB_TYPE,
> +						      &val);
> +	if (ret)
> +		return;
> +
> +	pdata->usb_type =3D val.intval;
> +
> +	if ((pdata->usb_type =3D=3D POWER_SUPPLY_USB_TYPE_PD) ||
> +	    (pdata->usb_type =3D=3D POWER_SUPPLY_USB_TYPE_PD_DRP) ||
> +	    (pdata->usb_type =3D=3D POWER_SUPPLY_USB_TYPE_PD_PPS)) {
> +		ret =3D power_supply_get_property_from_supplier(psy,
> +							      POWER_SUPPLY_PROP_CURRENT_MAX,
> +							      &val);
> +		if (ret)
> +			return;
> +
> +		if (val.intval)
> +			imax =3D val.intval;
> +	}
> +
> +	if (pdata->supplied) {
> +		pdata->chip->bq257xx_set_ichg(pdata, pdata->ichg_max);
> +		pdata->chip->bq257xx_set_iindpm(pdata, imax);
> +		pdata->chip->bq257xx_set_vbatreg(pdata, pdata->vbat_max);
> +	}
> +
> +out:
> +	power_supply_changed(psy);
> +}
> +
> +static irqreturn_t bq257xx_irq_handler_thread(int irq, void *private)
> +{
> +	struct bq257xx_chg *pdata =3D private;
> +
> +	bq257xx_external_power_changed(pdata->charger);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct power_supply_desc bq257xx_power_supply_desc =3D {
> +	.name =3D "bq257xx-charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.usb_types =3D BIT(POWER_SUPPLY_USB_TYPE_C) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_PD) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_PD_DRP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_PD_PPS) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
> +	.properties =3D bq257xx_power_supply_props,
> +	.num_properties =3D ARRAY_SIZE(bq257xx_power_supply_props),
> +	.get_property =3D bq257xx_get_charger_property,
> +	.set_property =3D bq257xx_set_charger_property,
> +	.property_is_writeable =3D bq257xx_property_is_writeable,
> +	.external_power_changed =3D bq257xx_external_power_changed,
> +};
> +
> +static const struct bq257xx_chip_info bq25703_chip_info =3D {
> +		.bq257xx_hw_init =3D &bq25703_hw_init,
> +		.bq257xx_hw_shutdown =3D &bq25703_hw_shutdown,
> +		.bq257xx_get_state =3D &bq25703_get_state,
> +		.bq257xx_set_ichg =3D &bq25703_set_ichg_cur,
> +		.bq257xx_set_vbatreg =3D &bq25703_set_chrg_volt,
> +		.bq257xx_set_iindpm =3D &bq25703_set_iindpm,
> +};
> +
> +/**
> + * bq257xx_parse_dt() - Parse the device tree for required properties
> + * @pdata: driver platform data
> + * @psy_cfg: power supply config data
> + * @dev: device struct
> + *
> + * Read the device tree to identify the minimum system voltage, the
> + * maximum charge current, the maximum charge voltage, and the maximum
> + * input current.
> + *
> + * Return: Returns 0 on success or error code on error.
> + */
> +static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
> +		struct power_supply_config *psy_cfg, struct device *dev)
> +{
> +	struct power_supply_battery_info *bat_info;
> +	int ret;
> +
> +	ret =3D power_supply_get_battery_info(pdata->charger,
> +					    &bat_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to get battery info\n");
> +
> +	if ((bat_info->voltage_min_design_uv <=3D 0) ||
> +	    (bat_info->constant_charge_voltage_max_uv <=3D 0) ||
> +	    (bat_info->constant_charge_current_max_ua <=3D 0))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Required bat info missing or invalid\n");
> +
> +	pdata->vsys_min =3D bat_info->voltage_min_design_uv;
> +	pdata->vbat_max =3D bat_info->constant_charge_voltage_max_uv;
> +	pdata->ichg_max =3D bat_info->constant_charge_current_max_ua;
> +
> +	power_supply_put_battery_info(pdata->charger, bat_info);
> +
> +	ret =3D device_property_read_u32(dev,
> +				       "input-current-limit-microamp",
> +				       &pdata->iindpm_max);
> +	if (ret)
> +		pdata->iindpm_max =3D BQ25703_IINDPM_DEFAULT_UA;
> +
> +	return 0;
> +}
> +
> +static int bq257xx_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct bq257xx_device *bq =3D dev_get_drvdata(pdev->dev.parent);
> +	struct bq257xx_chg *pdata;
> +	struct power_supply_config psy_cfg =3D { };
> +	int ret;
> +
> +	device_set_of_node_from_dev(dev, pdev->dev.parent);
> +
> +	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	pdata->bq =3D bq;
> +	pdata->chip =3D &bq25703_chip_info;
> +
> +	platform_set_drvdata(pdev, pdata);
> +
> +	psy_cfg.drv_data =3D pdata;
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +
> +	pdata->charger =3D devm_power_supply_register(dev,
> +						    &bq257xx_power_supply_desc,
> +						    &psy_cfg);
> +	if (IS_ERR(pdata->charger))
> +		return dev_err_probe(dev, PTR_ERR(pdata->charger),
> +				     "Power supply register charger failed\n");
> +
> +	ret =3D bq257xx_parse_dt(pdata, &psy_cfg, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdata->chip->bq257xx_hw_init(pdata);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize the charger\n");
> +
> +	platform_set_drvdata(pdev, pdata);
> +
> +	if (bq->client->irq) {
> +		ret =3D devm_request_threaded_irq(dev, bq->client->irq, NULL,
> +						bq257xx_irq_handler_thread,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						dev_name(&bq->client->dev), pdata);
> +		if (ret < 0) {
> +			dev_err(dev, "get irq fail: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void bq257xx_charger_shutdown(struct platform_device *pdev)
> +{
> +	struct bq257xx_chg *pdata =3D platform_get_drvdata(pdev);
> +
> +	pdata->chip->bq257xx_hw_shutdown(pdata);
> +}
> +
> +static struct platform_driver bq257xx_chg_driver =3D {
> +	.driver =3D {
> +		.name =3D "bq257xx-charger",
> +	},
> +	.probe =3D bq257xx_charger_probe,
> +	.shutdown =3D bq257xx_charger_shutdown,
> +};
> +module_platform_driver(bq257xx_chg_driver);
> +
> +MODULE_DESCRIPTION("bq257xx charger driver");
> +MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.43.0
>=20

--3rluckearszbi5kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZkykACgkQ2O7X88g7
+poFMQ//RC4qhekqUPLyFwdlJa0roye4HYumeewZwe/nbiAsFClFYExQwoxnhRWE
PokIGAnBx5h7Gy/dukKQwVtq3DXm+FJSYfoe4oAPTakayr04Ux71lovZft4ZRTGZ
bxepQDQQmanpUX+C6SjNRoL5VvdtTmk0JPz12wXn+IrSjjccBUG0s+zO0DfNAk3j
86mdVrJs303XllEJAHwVIfaSKMazzFEa7kAnLbdvU+roV1y5ruY1xzbm9CZrtTrk
IRwuZqBo1v55Qqzq1mdtTBZDpq7odNVbpAATlUHIU/CBOT7QpnzRYLziHGCbQxvk
jFccpQxjKF2yToYU+SUsZttZuI3cszhczPO9Ccj/itKzRRMW+J5rioDqAD4C0R6w
URTVcNs9KN6Tepv6ygSVkT6Tzt4Sr507SF8DYnFCbekEdpL+pdUcFu83D5fe1NpI
a1rSb3iEf3E6gs4Zv+Et/Qwg1Moq8GqdqcsF910fTmt9Zf0tVq233LcnADTWNY6P
9D4DgIoXGM6RaNstoCsR2TMMUSh5OKzd6rWAL8TwEexWQOLdMwoeYBOpzcsi4w0D
X+dPb55y/ue/yDbXqr00qEXMqXBRTDWC7Xd13O8g/Db00S4xxdYfTO38caAlxiPC
hL1w8QPJQ7N7GrqN/MvrhPsxMdtF7BGn1DFiuIC9bjZUrXkjSpc=
=67jR
-----END PGP SIGNATURE-----

--3rluckearszbi5kv--


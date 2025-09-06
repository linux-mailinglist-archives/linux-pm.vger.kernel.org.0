Return-Path: <linux-pm+bounces-34087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C71B47761
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD19D7B31A7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DF28000D;
	Sat,  6 Sep 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="RTuWAsWC"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B2315D45;
	Sat,  6 Sep 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193761; cv=pass; b=Pqlm+wy8HKy13y51NKbliyw6RJ/xIS2N0PqGkWDihTJ9XC4LacQlaQAg+z6iMCnxYrQTP4fl8agLllAf4HhUi9vmdGeC2kfj06sU3wzzXtgWKu2I90MGlugupfmF4abcsCUt67K0N58OtIX4FWmewWdVh+SxEE7dFbOKRCYha6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193761; c=relaxed/simple;
	bh=08Jzm8EoybijeD4lHfZpVJlAa00ABkErvN3SujArK+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkfXRCOF21gWqZG7GbcMLR0J6+jVwjldVnbFQ3lTQw8q0rGRDJ8LeCHnc8p+XyKKclQfJHAGZ1NqkhcJytAm2WRsCElTizniivpPy7E8D01U/KhU+xOGH+Jg6NgCLBdTjg/g0B1NLao/GIxEYZxF1e+5pspMAWStCb5H1kFDky0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=RTuWAsWC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757193741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m9OjzFbf8Jrn2ZtMlfO7JNMaN6mAuvy8QG7xBa79owdC2Y53gLJv2uVKHn6KjmEEDzoB7IkcWeBNer3E4aBppgzrrW++QGUfU6rUq5aVVOHkBrVRhdN7NkaunHp51xGbT2EeH9rrvF5U7jbAdyj+oKDHCcX8hXi4d/UCYO+1z6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757193741; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bTC6jkBrpvftwDz9Il3dRK2x0hmvyj0vDVASqvIv8nQ=; 
	b=Lx11LrYq+1cUmOizEDcZ3kUT9c3dBiaTSPkkN01Vrotn5EtKASRaQTJ8XK7ZZ0/fpNfUvBHTxPJbNh8Ejhp1Ab/xMHa/I2BUY68rRPzn85wmbt1nHIONqtIZKxgV6DgphVjDHUE7NMlR/QsnaqnMSGSQDO/RjG00GhqioZ7wT+0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757193741;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=bTC6jkBrpvftwDz9Il3dRK2x0hmvyj0vDVASqvIv8nQ=;
	b=RTuWAsWCPEQ0KxdZqkK9jRRY9603JyuiGJMZ2o0MncSj2GLqJYRUyQqylKbNAqK2
	W7fjbClBlOuBvCJzPkGx9ihI7iQ3ot/VZPw1gR30Y2ildzZSxEb4r1/nuFpR+HTvl8n
	YAy2GeZ4h+3avnltZ9WehWgG3zRV92VpkfWroeBA=
Received: by mx.zohomail.com with SMTPS id 1757193739527103.16215484144959;
	Sat, 6 Sep 2025 14:22:19 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 7C789180B18; Sat, 06 Sep 2025 23:22:13 +0200 (CEST)
Date: Sat, 6 Sep 2025 23:22:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/4] power: supply: add support for MAX77759 fuel gauge
Message-ID: <3y5hqmxb6yknpsmzxnok3nb6ehqqincrpyph4yd7ceflkx4ynp@ukg3pdakutvp>
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
 <20250804-b4-gs101_max77759_fg-v5-1-03a40e6c0e3d@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjzimyl7cnh3tw6x"
Content-Disposition: inline
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-1-03a40e6c0e3d@uclouvain.be>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.176.7
X-ZohoMailClient: External


--qjzimyl7cnh3tw6x
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/4] power: supply: add support for MAX77759 fuel gauge
MIME-Version: 1.0

Hi,

On Mon, Aug 04, 2025 at 04:26:38PM +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> The Maxim MAX77759 is a PMIC used in gs101-oriole and gs101-raven
> (Google Pixel 6 and 6 Pro). It contains a fuel gauge on a separate
> I2C address. Add basic support for this fuel gauge. The driver is
> based on the driver for the MAX17201 and MAX17205 which also use
> the MAX M5 fuel gauge. There is a lot of common between the two
> devices with some key differences. The main one is the lack of nvmem
> in the fuel gauge of the MAX77759.
>=20
> The initialization of the chip is very basic and mostly hardcoded.
> Loading the model of the fuel gauge is not implemented here.
>=20
> On both gs101-oriole and gs101-raven, the same EEPROM as for the
> battery id is used to backup some of the state of the fuel gauge.
> Use a standard nvmem binding to access this data. The CRC8 is
> computed to allow to go from linux to a stock android without
> apparent data corruption. If other devices using the MAX77759 are
> found/created, a similar nvmem layout should be made or the driver
> should be extended to support those devices.
>=20
> The current, capacity, temperature and charge have all been tested.
> The charge full design and capacity equal the ones seen on android,
> the ratio between average charge and average current does predict
> pretty accurately the time to empty under a constant workload and
> temperature is coherent with the dynamic state of the device.
>=20
> Health is not enabled as it always reports overheating. The time to
> empty is wrong by about a factor 2. The voltage reporting is
> correct when using VCELL (which reports the lowest voltage of all
> cells) when considering that the device is connected to a single
> cell. It could be enabled by either confirming that the device is
> connected to a single cell or finding an alternative reporting mean.
>=20
> Modifications have been made to it since but the regmap was
> originally proposed by Andr=E9 Draszik in
>=20
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I would have picked it, but the DT binding has some review feedback
=66rom Krzysztof and needs to be taken together with this driver :)

Greetings,

-- Sebastian

>  drivers/power/supply/Kconfig            |  14 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77759_battery.c | 649 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 664 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..147d049b836c3fbb24b762dba=
f31eebb8ba041f7 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -458,6 +458,20 @@ config BATTERY_MAX1721X
>  	  Say Y here to enable support for the MAX17211/MAX17215 standalone
>  	  battery gas-gauge.
> =20
> +config BATTERY_MAX77759
> +	tristate "Maxim Integrated MAX77759 Fuel Gauge"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes to enable support for the Fuel gauge of the Maxim Integrated
> +	  MAX77759. It is a companion Power Management IC for USB Type-C
> +	  applications with Battery Charger, Fuel Gauge, temperature sensors,
> +	  USB Type-C Port Controller (TCPC), NVMEM, and additional GPIO
> +	  interfaces.
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called max77759_fg.
> +
>  config BATTERY_TWL4030_MADC
>  	tristate "TWL4030 MADC battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..114578fa4fd08356822f13ce1=
fbad29923defad8 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_MAX1720X)	+=3D max1720x_battery.o
>  obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
> +obj-$(CONFIG_BATTERY_MAX77759)	+=3D max77759_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
>  obj-$(CONFIG_CHARGER_RT5033)	+=3D rt5033_charger.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
> diff --git a/drivers/power/supply/max77759_battery.c b/drivers/power/supp=
ly/max77759_battery.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d8d702af607211e391733cd14=
323698b54be734c
> --- /dev/null
> +++ b/drivers/power/supply/max77759_battery.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Fuel gauge driver for Maxim 777759
> + *
> + * based on max1720x_battery.c
> + *
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/crc8.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/unaligned.h>
> +
> +#define MAX77759_FG_CRC8_POLYNOMIAL  0x07
> +DECLARE_CRC8_TABLE(max77759_fg_crc8_table);
> +
> +#define MAX77759_FG_STATUS		0x00	/* Status */
> +#define MAX77759_FG_STATUS_POR		BIT(1)	/* Power-On Reset */
> +#define MAX77759_FG_STATUS_BAT_ABSENT	BIT(3)	/* Battery absent */
> +#define MAX77759_FG_REPCAP		0x05	/* Average capacity */
> +#define MAX77759_FG_REPSOC		0x06	/* Percentage of charge */
> +#define MAX77759_FG_TEMP		0x08	/* Temperature */
> +#define MAX77759_FG_CURRENT		0x0A	/* Actual current */
> +#define MAX77759_FG_AVG_CURRENT		0x0B	/* Average current */
> +#define MAX77759_FG_FULL_CAP		0x10	/* Calculated full capacity */
> +#define MAX77759_FG_QR_TABLE00		0x12
> +#define MAX77759_FG_FULLSOCTHR		0x13
> +#define MAX77759_FG_CYCLES		0x17
> +#define MAX77759_FG_DESIGN_CAP		0x18	/* Design capacity */
> +#define MAX77759_FG_CONFIG		0x1D
> +#define MAX77759_FG_ICHGTERM		0x1E
> +#define MAX77759_FG_DEV_NAME		0x21	/* Device name */
> +#define MAX77759_FG_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
> +#define MAX77759_FG_DEV_NAME_TYPE	0x31
> +#define MAX77759_FG_QR_TABLE10		0x22
> +#define MAX77759_FG_FULLCAPNOM		0x23	/* Nominal full capacity */
> +#define MAX77759_FG_LEARNCFG		0x28
> +#define MAX77759_FG_FILTERCFG		0x29
> +#define MAX77759_FG_RELAXCFG		0x2A
> +#define MAX77759_FG_MISCCFG		0x2B
> +#define MAX77759_FG_TGAIN		0x2C
> +#define MAX77759_FG_TOFF		0x2D
> +#define MAX77759_FG_CGAIN		0x2E
> +#define MAX77759_FG_QR_TABLE20		0x32
> +#define MAX77759_FG_FULLCAPREP		0x35	/* Reported full capacity */
> +#define MAX77759_FG_RCOMP0		0x38
> +#define MAX77759_FG_TEMPCO		0x39	/* Temperature Compensation*/
> +#define MAX77759_FG_TASKPERIOD		0x3C
> +#define MAX77759_FG_TASKPERIOD_175MS	0x1680
> +#define MAX77759_FG_TASKPERIOD_351MS	0x2D00
> +#define MAX77759_FG_QR_TABLE30		0x42
> +#define MAX77759_FG_DQACC		0x45
> +#define MAX77759_FG_DPACC		0x46
> +#define MAX77759_FG_VFSOC0		0x48
> +#define MAX77759_FG_CONVGCFG		0x49
> +#define MAX77759_FG_COMMAND		0x60
> +#define MAX77759_FG_COMMAND_LOCK_CONF	0x0000	/* Lock extra config */
> +#define MAX77759_FG_COMMAND_UNLOCK_CONF	0x0080	/* Unlock extra config */
> +#define MAX77759_FG_CV_MIXCAP		0xB6
> +#define MAX77759_FG_CV_HALFTIME		0xB7
> +#define MAX77759_FG_CURVE		0xB9
> +#define MAX77759_FG_CONFIG2		0xBB
> +#define MAX77759_FG_CONFIG2_OCVQEN	BIT(4)
> +#define MAX77759_FG_CONFIG2_LDMDL	BIT(5)	/* Load model */
> +#define MAX77759_FG_CONFIG2_DSOCEN	BIT(7)
> +#define MAX77759_FG_VFSOC		0xFF
> +
> +static const char *const max77759_fg_manufacturer =3D "Maxim Integrated";
> +static const char *const max77759_fg_model =3D "MAX77759";
> +
> +struct max77759_fg_device_info {
> +	struct regmap *regmap;
> +	int rsense;
> +};
> +
> +/*
> + * Registers 0x80 up to 0xaf which contain the model for the fuel gauge
> + * algorithm are locked. They can be unlocked by writing 0x59 to 0x62
> + * and 0xc4 to 0x63. They should be enabled in the regmap if the driver
> + * is extended to manage the model.
> + */
> +static const struct regmap_range max77759_fg_registers[] =3D {
> +	regmap_reg_range(0x00, 0x4f),
> +	regmap_reg_range(0x60, 0x60),
> +	regmap_reg_range(0xb0, 0xbf),
> +	regmap_reg_range(0xd0, 0xd0),
> +	regmap_reg_range(0xdc, 0xdf),
> +	regmap_reg_range(0xfb, 0xfb),
> +	regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_range max77759_fg_ro_registers[] =3D {
> +	regmap_reg_range(0x3d, 0x3d),
> +	regmap_reg_range(0xfb, 0xfb),
> +	regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_access_table max77759_fg_write_table =3D {
> +	.no_ranges =3D max77759_fg_ro_registers,
> +	.n_no_ranges =3D ARRAY_SIZE(max77759_fg_ro_registers),
> +};
> +
> +static const struct regmap_access_table max77759_fg_rd_table =3D {
> +	.yes_ranges =3D max77759_fg_registers,
> +	.n_yes_ranges =3D ARRAY_SIZE(max77759_fg_registers),
> +};
> +
> +static const struct regmap_config max77759_fg_regmap_cfg =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.max_register =3D 0xff,
> +	.wr_table =3D &max77759_fg_write_table,
> +	.rd_table =3D &max77759_fg_rd_table,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static const enum power_supply_property max77759_fg_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_AVG,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +struct max77759_fg_state_save {
> +	u16 rcomp0;
> +	u16 tempco;
> +	u16 fullcaprep;
> +	u16 cycles;
> +	u16 fullcapnom;
> +	u16 qrtable00;
> +	u16 qrtable10;
> +	u16 qrtable20;
> +	u16 qrtable30;
> +	u16 mixcap;
> +	u16 halftime;
> +	u8 crc;
> +} __packed;
> +
> +/* Convert regs value to power_supply units */
> +
> +static int max77759_fg_percent_to_ps(unsigned int reg)
> +{
> +	return reg / 256;	/* in percent from 0 to 100 */
> +}
> +
> +static int max77759_fg_capacity_to_ps(unsigned int reg,
> +				      struct max77759_fg_device_info *info)
> +{
> +	return reg * (500000 / info->rsense);	/* in uAh */
> +}
> +
> +static int max77759_fg_capacity_lsb(struct max77759_fg_device_info *info,
> +				    unsigned int *lsb)
> +{
> +	unsigned int reg_task_period;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, MAX77759_FG_TASKPERIOD,
> +			  &reg_task_period);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (reg_task_period) {
> +	case MAX77759_FG_TASKPERIOD_175MS:
> +		*lsb =3D 1;
> +		break;
> +	case MAX77759_FG_TASKPERIOD_351MS:
> +		*lsb =3D 2;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Current and temperature is signed values, so unsigned regs
> + * value must be converted to signed type
> + */
> +
> +static int max77759_fg_temperature_to_ps(unsigned int reg)
> +{
> +	int val =3D (int16_t)reg;
> +
> +	return val * 10 / 256; /* in tenths of deg. C */
> +}
> +
> +/*
> + * Calculating current registers resolution:
> + *
> + * RSense stored in 10^-5 Ohm, so measurement voltage must be
> + * in 10^-11 Volts for get current in uA.
> + * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
> + * So: 102400 / 65535 * 10^5 =3D 156252
> + */
> +static int max77759_fg_current_to_voltage(unsigned int reg)
> +{
> +	int val =3D (int16_t)reg;
> +
> +	return val * 156252;
> +}
> +
> +static int max77759_fg_battery_get_property(struct power_supply *psy,
> +					    enum power_supply_property psp,
> +					    union power_supply_propval *val)
> +{
> +	struct max77759_fg_device_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int reg_val;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		/*
> +		 * POWER_SUPPLY_PROP_PRESENT will always readable via
> +		 * sysfs interface. Value return 0 if battery not
> +		 * present or unaccesable via I2c.
> +		 */
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_STATUS, &reg_val);
> +		if (ret < 0) {
> +			val->intval =3D 0;
> +			return 0;
> +		}
> +
> +		val->intval =3D !FIELD_GET(MAX77759_FG_STATUS_BAT_ABSENT, reg_val);
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_REPSOC, &reg_val);
> +		val->intval =3D max77759_fg_percent_to_ps(reg_val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_DESIGN_CAP, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D max77759_fg_capacity_to_ps(reg_val, info);
> +		ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +		val->intval *=3D reg_val;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_AVG:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_REPCAP, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D max77759_fg_capacity_to_ps(reg_val, info);
> +		ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +		val->intval *=3D reg_val;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_TEMP, &reg_val);
> +		val->intval =3D max77759_fg_temperature_to_ps(reg_val);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_CURRENT, &reg_val);
> +		val->intval =3D max77759_fg_current_to_voltage(reg_val) / info->rsense;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_AVG_CURRENT, &reg_val);
> +		val->intval =3D max77759_fg_current_to_voltage(reg_val) / info->rsense;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_FULL_CAP, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D max77759_fg_capacity_to_ps(reg_val, info);
> +		ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +		val->intval *=3D reg_val;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_DEV_NAME, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		reg_val =3D FIELD_GET(MAX77759_FG_DEV_NAME_TYPE_MASK, reg_val);
> +		if (reg_val =3D=3D MAX77759_FG_DEV_NAME_TYPE)
> +			val->strval =3D max77759_fg_model;
> +		else
> +			return -ENODEV;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D max77759_fg_manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77759_fg_init(struct device *dev,
> +			    struct max77759_fg_device_info *info,
> +			    struct power_supply *bat_psy)
> +{
> +	struct max77759_fg_state_save *state;
> +	struct power_supply_battery_info *bat_info;
> +	struct nvmem_cell *cell;
> +	unsigned int val;
> +	int ret;
> +	size_t len;
> +
> +	power_supply_get_battery_info(bat_psy, &bat_info);
> +
> +	cell =3D devm_nvmem_cell_get(dev, "fg_state");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +	state =3D (struct max77759_fg_state_save *)nvmem_cell_read(cell, &len);
> +	if (IS_ERR(state))
> +		return PTR_ERR(state);
> +	if (len !=3D sizeof(struct max77759_fg_state_save)) {
> +		ret =3D -EINVAL;
> +		goto err_init;
> +	}
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_REPCAP, 0x0000);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_RELAXCFG, 0x0839);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_COMMAND,
> +			   MAX77759_FG_COMMAND_UNLOCK_CONF);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_read(info->regmap, MAX77759_FG_VFSOC, &val);
> +	if (ret < 0)
> +		goto err_init;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_VFSOC0, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_LEARNCFG, 0x260E);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONFIG, 0x4217);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	val =3D MAX77759_FG_CONFIG2_DSOCEN | MAX77759_FG_CONFIG2_OCVQEN;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONFIG2, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FULLSOCTHR, 0x5F00);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FULLCAPREP,
> +			   state->fullcaprep);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	//Use an LSB of 2 because TASKPERIOD will be set to 351MS
> +	val =3D bat_info->charge_full_design_uah * (info->rsense / 100) / 10000;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_DESIGN_CAP, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_DPACC, 0x0C80);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_DQACC,
> +			   state->fullcapnom >> 4);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_STATUS,
> +			   MAX77759_FG_STATUS_POR);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FULLCAPNOM,
> +			   state->fullcapnom);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE00,
> +			   state->qrtable00);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE10,
> +			   state->qrtable10);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE20,
> +			   state->qrtable20);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE30,
> +			   state->qrtable30);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_RCOMP0, state->rcomp0);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TEMPCO, state->tempco);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TASKPERIOD,
> +			   MAX77759_FG_TASKPERIOD_351MS);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_ICHGTERM,
> +			   bat_info->charge_term_current_ua *
> +			   info->rsense / 15625);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TGAIN, 0xED51);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TOFF, 0x1EBA);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_MISCCFG, 0x3870);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CV_MIXCAP, state->mixcap=
);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CV_HALFTIME,
> +			   state->halftime);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONVGCFG, 0x2241);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_COMMAND,
> +			   MAX77759_FG_COMMAND_LOCK_CONF);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CURVE, 0x0014);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FILTERCFG, 0xc623);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CGAIN, 0x0400);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	val =3D MAX77759_FG_CONFIG2_DSOCEN | MAX77759_FG_CONFIG2_OCVQEN;
> +	val |=3D MAX77759_FG_CONFIG2_LDMDL;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONFIG2, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_STATUS, 0x0000);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CYCLES, state->cycles);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	kfree(state);
> +	return 0;
> +
> +err_init:
> +	kfree(state);
> +	return ret;
> +}
> +
> +static const struct power_supply_desc max77759_fg_bat_desc =3D {
> +	.name =3D "max77759-fg",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D max77759_fg_battery_props,
> +	.num_properties =3D ARRAY_SIZE(max77759_fg_battery_props),
> +	.get_property =3D max77759_fg_battery_get_property,
> +};
> +
> +static int max77759_fg_backup_fg_state(struct device *dev,
> +				       struct regmap *regmap)
> +{
> +	struct max77759_fg_state_save state;
> +	struct nvmem_cell *cell;
> +	int val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_RCOMP0, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.rcomp0 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_TEMPCO, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.tempco =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_FULLCAPREP, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.fullcaprep =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_CYCLES, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.cycles =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_FULLCAPNOM, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.fullcapnom =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE00, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable00 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE10, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable10 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE20, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable20 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE30, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable30 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_CV_MIXCAP, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.mixcap =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_CV_HALFTIME, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.halftime =3D (u16)val;
> +
> +	state.crc =3D crc8(max77759_fg_crc8_table, (u8 *)&state,
> +			 sizeof(state) - sizeof(state.crc), CRC8_INIT_VALUE);
> +
> +	cell =3D devm_nvmem_cell_get(dev, "fg_state");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +	ret =3D nvmem_cell_write(cell, &state, sizeof(state));
> +	if (ret < 0)
> +		dev_err(dev, "Failed to write fg_state to NVMEM: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void max77759_fg_remove(struct i2c_client *client)
> +{
> +	struct max77759_fg_device_info *info =3D i2c_get_clientdata(client);
> +
> +	max77759_fg_backup_fg_state(&client->dev, info->regmap);
> +}
> +
> +static int max77759_fg_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &client->dev;
> +	struct max77759_fg_device_info *info;
> +	struct power_supply *bat;
> +	int ret, val;
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	psy_cfg.drv_data =3D info;
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +
> +	crc8_populate_msb(max77759_fg_crc8_table, MAX77759_FG_CRC8_POLYNOMIAL);
> +
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap =3D devm_regmap_init_i2c(client, &max77759_fg_regmap_cfg);
> +	if (IS_ERR(info->regmap))
> +		return dev_err_probe(dev, PTR_ERR(info->regmap),
> +				     "regmap initialization failed\n");
> +
> +	ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms", &val=
);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read RSense from devicetree\n");
> +	info->rsense =3D val / 10;
> +
> +	bat =3D devm_power_supply_register(dev, &max77759_fg_bat_desc, &psy_cfg=
);
> +	if (IS_ERR(bat))
> +		return dev_err_probe(dev, PTR_ERR(bat),
> +				     "Failed to register power supply\n");
> +
> +	ret =3D max77759_fg_init(dev, info, bat);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77759_fg_of_match[] =3D {
> +	{ .compatible =3D "maxim,max77759-fg" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, max77759_fg_of_match);
> +
> +static struct i2c_driver max77759_fg_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77759_fg",
> +		.of_match_table =3D max77759_fg_of_match,
> +	},
> +	.probe =3D max77759_fg_probe,
> +	.remove =3D max77759_fg_remove,
> +};
> +module_i2c_driver(max77759_fg_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Thomas Antoine <t.antoine@uclouvain.be>");
> +MODULE_DESCRIPTION("Maxim MAX77759 Fuel Gauge IC driver");
>=20
> --=20
> 2.50.1
>=20
>=20

--qjzimyl7cnh3tw6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmi8pgEACgkQ2O7X88g7
+prtTw/9GWhwj3/1i8grM9uShQXEInu8I0fferdnDZTqj6/M/LONBq1YgE3CnN1J
KPaeHdrvieShAtGFMtZAMeiHctUnuKTlyE2ShC6IMZsI/KufZyEiD2lj2w1G0Jir
HeFt3WGdT/QOUF2uQmhtJhMFrTMSKNHoChYWs8agFXhjvVkcNs+3496ln/AdoW+1
kA1eABHcAsIV95Ge4bmBVJ5r88pNNt0CF/zYsA0TqaPKgicihwPUuA8AkHSlFdAg
2lb+LCEipmpyX+dnxvHv4YY1w4jZHkQDEu4IN0oLWyYIMf2UrXo6RLIf64jx76OZ
djWwpqPvbqPGUQIvU5I/qEbKItJDWT0qx0mf7m3PNve+XoC2XJX8TulKp293VSmu
49pG5HWTwGkHpXRHkW7hqvua9JmVt7JG6do7coBOHSGq2Qn9MbzvGWaO0Xqf1gBe
Noy8ypggFEJLy8azcnf6JBuDbdnVDjFPbYhFc1e8dPXlaI5k+Kz6ZgtQFFhYKerK
2+IG+WOiV8/yxFj8CIkejWqzMBbd11G53BQB3HTIBx2q2lIbAX9mcXtBk2mJEfeR
ESRKblsORplYO6xa0kDAehPq2QUxw/gwlkTIctOZBA1vgwEYyBk1xJTbjxmKLqws
ETQ7t3PzQ6wzhZZaw3uVRy64Fs4V6iZvSN5/8QB6wVpaWAuJIQE=
=Kub2
-----END PGP SIGNATURE-----

--qjzimyl7cnh3tw6x--


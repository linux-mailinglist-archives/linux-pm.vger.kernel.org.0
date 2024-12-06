Return-Path: <linux-pm+bounces-18689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444F49E6E14
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF61F168E6F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD572010EF;
	Fri,  6 Dec 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iCReIhZR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6B2010E0;
	Fri,  6 Dec 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487991; cv=pass; b=FbGcy+0Sf4uiHeXGYFw2P2ZcLygQoLE9oGlyAZRIQ2bCE6icdRRM0rf6cJFkfzUNOxiXvA8i8VswTTkb2oVS9psFHf1Av5DxuTRrkJGth+k6Z08KfJIPyk5nFvYXBdBgmHYbaxWnf+qa/gB+kuVJ3uHTLCQQWIedWIrQsRvf9hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487991; c=relaxed/simple;
	bh=v0ogPnwLFh1C2SwY6AHWiE2xIx0T1kz8lXkY1DTwQB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0B5ngUn0qKJj/3p3Q1jbBrW1mso0OIlAvSBdMXfDX99u0koKRUA90qdzadHZb3O4AZQqykDTh5BrBoR+3NiOKGRypEPOTAD3tDZitu+zsro0WlmfySKJz5vweOCJh1zHfimkG7WL9iaxXRt9nwsqqnA4/qX39l5tfwCNHm8tC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iCReIhZR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733487975; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZHoSfT/46hXnVrMNPUFYYp2vpHBs2GbEKrD6nT89/4fHrUesCf7LJMLzFsgAldYu0ig7JaoWKqhei6ErV6+zmR+GpLwcXhzCE5amYlcFCNDl32Rs4rMFkE1B8YSxpaFzkqLbHb+DXEIg7VUXjSPX77Fe6drs3GBgASQSYKyoT0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733487975; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6yMP8d8LdOfY3JpXzXxaOqXOY5mVfuULAir4PF0AuE8=; 
	b=OyarbyrXocCkmTFCUxpQW5Ke1hgFnkHqxoJx+2BitdxB/wGgf6Ey/N6qMOBRSCoYl8n4/AryXYEnVvlHgA50/4NhIK5as0/2maIIMijKbzI3KQF7Fq6JBkyhMz+rVHDgn0bfZcHisy1m03Fw2XKz2Zv1NP3E/7KOkTDLpaYzdZ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733487975;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=6yMP8d8LdOfY3JpXzXxaOqXOY5mVfuULAir4PF0AuE8=;
	b=iCReIhZRi8d2QEUl/8B8GRgRUzPzprZqz1gvhbLgc61lWLtMc5G9u0EREk3X6e5U
	H0c1ZjAHMqyajJjbcDJs4cj1vPwlbtTrpa2hXXo+E2DVir7nVuBaZnJebR4hboGtF0w
	fALowVdp7Q/1tFNQUfGhQ7zNlW27KaNKlPAJBmek=
Received: by mx.zohomail.com with SMTPS id 1733487973920636.5973699483671;
	Fri, 6 Dec 2024 04:26:13 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id B7BDA10604B0; Fri, 06 Dec 2024 13:26:09 +0100 (CET)
Date: Fri, 6 Dec 2024 13:26:09 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: christophe.jaillet@wanadoo.fr, 
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <6ccn5xnsfwxeepsft7tfozbhsvs3w3m2qpmcj74xua74qzkny3@s5rg3ytmcgzn>
References: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
 <20241202094328.14395-3-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="toto5a7kkdsoezu6"
Content-Disposition: inline
In-Reply-To: <20241202094328.14395-3-bhavin.sharma@siliconsignals.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.433.6
X-ZohoMailClient: External


--toto5a7kkdsoezu6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
MIME-Version: 1.0

Hi,

On Mon, Dec 02, 2024 at 03:11:53PM +0530, Bhavin Sharma wrote:
> Adds initial support for the STC3117 fuel gauge.
>=20
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status
>=20
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---

Please add the output from running the following script on a system
without your fuel gauge to the cover letter in the next submission.
It helps to check that the values are properly converted:

=2E/tools/testing/selftests/power_supply/test_power_supply_properties.sh

>  MAINTAINERS                               |   8 +
>  drivers/power/supply/Kconfig              |   7 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/stc3117_fuel_gauge.c | 665 ++++++++++++++++++++++
>  4 files changed, 681 insertions(+)
>  create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1fcc56bf2fb..10ead03660d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22125,6 +22125,14 @@ T:	git git://linuxtv.org/media.git
>  F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
>  F:	drivers/media/i2c/st-mipid02.c
> =20
> +ST STC3117 FUEL GAUGE DRIVER
> +M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> +M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
> +F:	drivers/power/supply/stc3117_fuel_gauge.c
> +
>  ST STM32 FIREWALL
>  M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
>  S:	Maintained
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 9f2eef6787f7..9f34a2a6bc00 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
>  	  Say Y here to enable support for fuel gauge with SC27XX
>  	  PMIC chips.
> =20
> +config FUEL_GAUGE_STC3117
> +       tristate "STMicroelectronics STC3117 fuel gauge driver"
> +       depends on I2C
> +       help
> +         Say Y here to enable support for fuel gauge with STC3117
> +         chip.
> +
>  config CHARGER_UCS1002
>  	tristate "Microchip UCS1002 USB Port Power Controller"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 59c4a9f40d28..b55cc48a4c86 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-char=
ger.o
>  obj-$(CONFIG_CHARGER_CROS_PCHG)	+=3D cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> +obj-$(CONFIG_FUEL_GAUGE_STC3117)       +=3D stc3117_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
>  obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
> diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/su=
pply/stc3117_fuel_gauge.c
> new file mode 100644
> index 000000000000..ffa7e0d35474
> --- /dev/null
> +++ b/drivers/power/supply/stc3117_fuel_gauge.c
> @@ -0,0 +1,665 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
> + *
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.
> + * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
com>
> + *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/workqueue.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/crc8.h>
> +
> +#define STC3117_ADDR_MODE                      0x00
> +#define STC3117_ADDR_CTRL                      0x01
> +#define STC3117_ADDR_SOC_L                     0x02
> +#define STC3117_ADDR_SOC_H                     0x03
> +#define STC3117_ADDR_COUNTER_L                 0x04
> +#define STC3117_ADDR_COUNTER_H                 0x05
> +#define STC3117_ADDR_CURRENT_L                 0x06
> +#define STC3117_ADDR_CURRENT_H                 0x07
> +#define STC3117_ADDR_VOLTAGE_L                 0x08
> +#define STC3117_ADDR_VOLTAGE_H                 0x09
> +#define STC3117_ADDR_TEMPERATURE               0x0A
> +#define STC3117_ADDR_AVG_CURRENT_L             0X0B
> +#define STC3117_ADDR_AVG_CURRENT_H             0X0C
> +#define STC3117_ADDR_OCV_L                     0X0D
> +#define STC3117_ADDR_OCV_H                     0X0E
> +#define STC3117_ADDR_CC_CNF_L                  0X0F
> +#define STC3117_ADDR_CC_CNF_H                  0X10
> +#define STC3117_ADDR_VM_CNF_L                  0X11
> +#define STC3117_ADDR_VM_CNF_H                  0X12
> +#define STC3117_ADDR_ALARM_soc                 0X13
> +#define STC3117_ADDR_ALARM_VOLTAGE             0X14
> +#define STC3117_ADDR_ID                        0X18
> +#define STC3117_ADDR_CC_ADJ_L			0X1B
> +#define STC3117_ADDR_CC_ADJ_H			0X1C
> +#define STC3117_ADDR_VM_ADJ_L			0X1D
> +#define STC3117_ADDR_VM_ADJ_H			0X1E

Please keep the x in 0X lower case. It suddenly changes after 0x0A

> +#define STC3117_ADDR_RAM			0x20
> +#define STC3117_ADDR_OCV_TABLE			0x30
> +#define STC3117_ADDR_SOC_TABLE			0x30
> +
> +/* Bit mask definition */
> +#define STC3117_ID			        0x16
> +#define STC3117_MIXED_MODE			0x00
> +#define STC3117_VMODE				BIT(0)
> +#define STC3117_GG_RUN				BIT(4)
> +#define STC3117_CC_MODE			BIT(5)
> +#define STC3117_BATFAIL			BIT(3)
> +#define STC3117_PORDET				BIT(4)
> +#define STC3117_RAM_SIZE			16
> +#define STC3117_OCV_TABLE_SIZE			16
> +#define STC3117_RAM_TESTWORD			0x53A9
> +#define STC3117_SOFT_RESET                      0x11
> +#define STC3117_NOMINAL_CAPACITY		2600
> +
> +#define VOLTAGE_LSB_VALUE			9011
> +#define CURRENT_LSB_VALUE			24084
> +#define APP_CUTOFF_VOLTAGE			2500
> +#define MAX_HRSOC				51200
> +#define MAX_SOC				1000
> +#define CHG_MIN_CURRENT			200
> +#define CHG_END_CURRENT			20
> +#define APP_MIN_CURRENT			(-5)
> +#define BATTERY_FULL				95
> +#define CRC8_POLYNOMIAL			0x07
> +#define CRC8_INIT				0x00
> +
> +DECLARE_CRC8_TABLE(stc3117_crc_table);
> +
> +enum stc3117_state {
> +	STC3117_INIT,
> +	STC3117_RUNNING,
> +	STC3117_POWERDN,
> +};
> +
> +enum stc3117_status {
> +	BATT_LOWBATT =3D -2,
> +	BATT_DISCHARG,
> +	BATT_IDLE,
> +	BATT_FULCHARG,
> +	BATT_ENDCHARG,
> +	BATT_CHARGING,
> +};
> +
> +/* Default ocv curve Li-ion battery */
> +static const int ocv_value[16] =3D {
> +	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
> +	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
> +};
> +
> +static union stc3117_internal_ram {
> +	u8 ram_bytes[STC3117_RAM_SIZE];
> +	struct {
> +	u16 testword;   /* 0-1    Bytes */
> +	u16 hrsoc;      /* 2-3    Bytes */
> +	u16 cc_cnf;     /* 4-5    Bytes */
> +	u16 vm_cnf;     /* 6-7    Bytes */
> +	u8 soc;         /* 8      Byte  */
> +	u8 state;       /* 9      Byte  */
> +	u8 unused[5];   /* 10-14  Bytes */
> +	u8 crc;         /* 15     Byte  */
> +	} reg;
> +} ram_data;
> +
> +struct stc3117_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct delayed_work update_work;
> +	struct power_supply *battery;
> +
> +	u8 soc_tab[16];
> +	int cc_cnf;
> +	int vm_cnf;
> +	int cc_adj;
> +	int vm_adj;
> +	int avg_current;
> +	int avg_voltage;
> +	int batt_current;
> +	int voltage;
> +	int temp;
> +	int soc;
> +	int ocv;
> +	int hrsoc;
> +	int presence;
> +	int battery_state;
> +};
> +
> +struct stc3117_battery_info {
> +	int voltage_min_mv;
> +	int voltage_max_mv;
> +	int battery_capacity_mah;
> +	int sense_resistor;
> +} battery_info;
> +
> +static int stc3117_convert(int value, int factor)
> +{
> +	value =3D (value * factor) / 4096;
> +	return value;
> +}
> +
> +static int stc3117_get_battery_data(struct stc3117_data *data)
> +{
> +	u8 reg_list[16];
> +	u8 data_adjust[4];
> +	int value, mode;
> +
> +	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
> +			 reg_list, sizeof(reg_list));
> +
> +	/* soc */
> +	value =3D (reg_list[3] << 8) + reg_list[2];
> +	data->hrsoc =3D value;
> +	data->soc =3D (value * 10 + 256) / 512;
> +
> +	/* cureent in mA*/

typo (cureent -> currrent)

> +	value =3D (reg_list[7] << 8) + reg_list[6];
> +	data->batt_current =3D stc3117_convert(value,
> +				CURRENT_LSB_VALUE / battery_info.sense_resistor);
> +
> +	/* voltage in mV */
> +	value =3D (reg_list[9] << 8) + reg_list[8];
> +	data->voltage =3D stc3117_convert(value, VOLTAGE_LSB_VALUE);
> +
> +	/* temp */

Looks like temp is in =B0C?

> +	data->temp =3D reg_list[10];
> +
> +	/* Avg batt_current in mA */
> +	value =3D (reg_list[12] << 8) + reg_list[11];
> +	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
> +	if (!(mode & STC3117_VMODE)) {
> +		value =3D stc3117_convert(value,
> +			 	CURRENT_LSB_VALUE / battery_info.sense_resistor);
> +	value =3D value / 4;
> +	} else {
> +		value =3D stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
> +	}
> +	data->avg_current =3D value;
> +
> +	/* ocv */

I guess ocv is also in mV?

> +	value =3D (reg_list[14] << 8) + reg_list[13];
> +	value =3D stc3117_convert(value, VOLTAGE_LSB_VALUE);
> +	value =3D (value + 2) / 4;
> +	data->ocv =3D value;
> +
> +	/* CC & VM adjustment counters */
> +	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
> +			 data_adjust, sizeof(data_adjust));
> +	value =3D (data_adjust[1] << 8) + data_adjust[0];
> +	data->cc_adj =3D value;
> +
> +	value =3D (data_adjust[3] << 8) + data_adjust[2];
> +	data->vm_adj =3D value;
> +
> +	return 0;
> +}
> +
> +static int stc3117_update_battery_status(struct stc3117_data *data)
> +{
> +	switch (data->battery_state) {
> +	case BATT_CHARGING:
> +		if (data->avg_current < CHG_MIN_CURRENT)
> +			data->battery_state =3D BATT_ENDCHARG;
> +		break;
> +
> +	case BATT_ENDCHARG:
> +		if (data->batt_current > CHG_MIN_CURRENT)
> +			data->battery_state =3D BATT_CHARGING;
> +		else if (data->avg_current < CHG_END_CURRENT)
> +			data->battery_state =3D BATT_IDLE;
> +		else if ((data->batt_current > CHG_END_CURRENT) &&
> +			 (data->voltage > battery_info.voltage_max_mv))
> +			data->battery_state =3D BATT_FULCHARG;
> +		break;
> +
> +	case BATT_FULCHARG:
> +		if (data->batt_current > CHG_MIN_CURRENT) {
> +			data->battery_state =3D BATT_CHARGING;
> +		} else if (data->avg_current < CHG_END_CURRENT) {
> +			if (data->avg_voltage > battery_info.voltage_max_mv) {
> +				regmap_write(data->regmap, STC3117_ADDR_SOC_H,
> +					     (MAX_HRSOC >> 8 & 0xFF));
> +				regmap_write(data->regmap, STC3117_ADDR_SOC_L,
> +					     (MAX_HRSOC & 0xFF));
> +				data->soc =3D MAX_SOC;
> +			}
> +			data->battery_state =3D BATT_IDLE;
> +		}
> +		break;
> +
> +	case BATT_IDLE:
> +		if (data->batt_current > CHG_END_CURRENT)
> +			data->battery_state =3D BATT_CHARGING;
> +		else if (data->batt_current < APP_MIN_CURRENT)
> +			data->battery_state =3D BATT_DISCHARG;
> +		break;
> +
> +	case BATT_DISCHARG:
> +		if (data->batt_current > APP_MIN_CURRENT)
> +			data->battery_state =3D BATT_IDLE;
> +		else if (data->avg_voltage < battery_info.voltage_min_mv)
> +			data->battery_state =3D BATT_LOWBATT;
> +		break;
> +
> +	case BATT_LOWBATT:
> +		if (data->avg_voltage > (battery_info.voltage_min_mv + 50))
> +			data->battery_state =3D BATT_IDLE;
> +		break;
> +
> +	default:
> +		data->battery_state =3D BATT_IDLE;
> +	}
> +
> +	return 0;
> +}

You are never using data->battery_state, so the whole function can
be removed and battery_state can be removed from the data struct.

> +
> +static int ram_write(struct stc3117_data *data)
> +{
> +	int ret;
> +
> +	ret =3D regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
> +				ram_data.ram_bytes, STC3117_RAM_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +};
> +
> +static int ram_read(struct stc3117_data *data)
> +{
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
> +			       ram_data.ram_bytes, STC3117_RAM_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +};
> +
> +static int stc3117_set_para(struct stc3117_data *data)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
> +
> +	for (int i =3D 0; i < STC3117_OCV_TABLE_SIZE; i++)
> +		ret |=3D regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
> +			     ocv_value[i] * 100 / 55);
> +	if (data->soc_tab[1] !=3D 0)
> +		ret |=3D regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
> +				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
> +
> +	ret |=3D regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
> +					(ram_data.reg.cc_cnf >> 8) & 0xFF);
> +
> +	ret |=3D regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
> +					ram_data.reg.cc_cnf & 0xFF);
> +
> +	ret |=3D regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
> +					(ram_data.reg.vm_cnf >> 8) & 0xFF);
> +
> +	ret |=3D regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
> +					ram_data.reg.vm_cnf & 0xFF);
> +
> +	ret |=3D regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
> +
> +	ret |=3D regmap_write(data->regmap, STC3117_ADDR_MODE,
> +					STC3117_MIXED_MODE | STC3117_GG_RUN);
> +
> +	return ret;
> +};
> +
> +static int stc3117_init(struct stc3117_data *data)
> +{
> +	int ID, ret;
> +	int ctrl;
> +	int ocv_m, ocv_l;
> +
> +	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
> +	if (ID !=3D STC3117_ID)
> +		return -EINVAL;
> +
> +	data->cc_cnf =3D (battery_info.battery_capacity_mah *
> +			battery_info.sense_resistor * 250 + 6194) / 12389;
> +	data->vm_cnf =3D (battery_info.battery_capacity_mah
> +						* 200 * 50 + 24444) / 48889;
> +
> +	/* Battery has not been removed */
> +	data->presence =3D 1;
> +
> +	/* Read RAM data */
> +	ret =3D ram_read(data);
> +	if (ret)
> +		return ret;
> +
> +	if (ram_data.reg.testword !=3D STC3117_RAM_TESTWORD ||
> +	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
> +					STC3117_RAM_SIZE, CRC8_INIT)) !=3D 0) {
> +		ram_data.reg.testword =3D STC3117_RAM_TESTWORD;
> +		ram_data.reg.cc_cnf =3D data->cc_cnf;
> +		ram_data.reg.vm_cnf =3D data->vm_cnf;
> +		ram_data.reg.crc =3D crc8(stc3117_crc_table, ram_data.ram_bytes,
> +					STC3117_RAM_SIZE - 1, CRC8_INIT);
> +
> +		ret =3D regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
> +
> +		ret |=3D regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
> +
> +		ret |=3D stc3117_set_para(data);
> +
> +		ret |=3D regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
> +
> +		ret |=3D regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
> +		if (ret)
> +			return ret;
> +
> +		if ((ctrl & STC3117_BATFAIL) !=3D 0  ||
> +		    (ctrl & STC3117_PORDET) !=3D 0) {
> +			ret =3D regmap_read(data->regmap,
> +					  STC3117_ADDR_OCV_H, &ocv_m);
> +
> +			ret |=3D regmap_read(data->regmap,
> +						STC3117_ADDR_OCV_L, &ocv_l);
> +
> +			ret |=3D stc3117_set_para(data);
> +
> +			ret |=3D regmap_write(data->regmap,
> +						STC3117_ADDR_OCV_H, ocv_m);
> +
> +			ret |=3D regmap_write(data->regmap,
> +						STC3117_ADDR_OCV_L, ocv_l);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret =3D stc3117_set_para(data);
> +			ret |=3D regmap_write(data->regmap, STC3117_ADDR_SOC_H,
> +				     (ram_data.reg.hrsoc >> 8 & 0xFF));
> +			ret |=3D regmap_write(data->regmap, STC3117_ADDR_SOC_L,
> +				     (ram_data.reg.hrsoc & 0xFF));
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	ram_data.reg.state =3D STC3117_INIT;
> +	ram_data.reg.crc =3D crc8(stc3117_crc_table, ram_data.ram_bytes,
> +				STC3117_RAM_SIZE - 1, CRC8_INIT);
> +	ret =3D ram_write(data);
> +	if (ret)
> +		return ret;
> +
> +	data->battery_state =3D BATT_IDLE;
> +
> +	return 0;
> +};
> +
> +static int stc3117_task(struct stc3117_data *data)
> +{
> +	int ID, mode, ret;

why is ID in upper case like a constant?

> +	int count_l, count_m;
> +	int ocv_l, ocv_m;
> +
> +	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
> +	if (ID !=3D STC3117_ID) {
> +		data->presence =3D 0;
> +		return -EINVAL;
> +	}
> +
> +	stc3117_get_battery_data(data);
> +
> +	/* Read RAM data */
> +	ret =3D ram_read(data);
> +	if (ret)
> +		return ret;
> +
> +	if (ram_data.reg.testword !=3D STC3117_RAM_TESTWORD ||
> +	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
> +					STC3117_RAM_SIZE, CRC8_INIT) !=3D 0)) {
> +		ram_data.reg.testword =3D STC3117_RAM_TESTWORD;
> +		ram_data.reg.cc_cnf =3D data->cc_cnf;
> +		ram_data.reg.vm_cnf =3D data->vm_cnf;
> +		ram_data.reg.crc =3D crc8(stc3117_crc_table, ram_data.ram_bytes,
> +					STC3117_RAM_SIZE - 1, CRC8_INIT);
> +		ram_data.reg.state =3D STC3117_INIT;
> +	}
> +
> +	/* check battery presence status */
> +	ret =3D regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
> +	if ((mode & STC3117_BATFAIL) !=3D 0) {
> +		data->presence =3D 0;
> +		ram_data.reg.testword =3D 0;
> +		ram_data.reg.state =3D STC3117_INIT;
> +		ret =3D ram_write(data);
> +		ret |=3D regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	data->presence =3D 1;
> +
> +	ret =3D regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
> +	if (ret)
> +		return ret;
> +	if ((mode & STC3117_GG_RUN) =3D=3D 0) {
> +		if (ram_data.reg.state > STC3117_INIT) {
> +			ret =3D stc3117_set_para(data);
> +
> +			ret |=3D regmap_write(data->regmap, STC3117_ADDR_SOC_H,
> +					(ram_data.reg.hrsoc >> 8 & 0xFF));
> +			ret |=3D regmap_write(data->regmap, STC3117_ADDR_SOC_L,
> +					(ram_data.reg.hrsoc & 0xFF));
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret =3D regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
> +
> +			ret |=3D regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
> +
> +			ret |=3D stc3117_set_para(data);
> +
> +			ret |=3D regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
> +
> +			ret |=3D regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
> +			if (ret)
> +				return ret;
> +		}
> +		ram_data.reg.state =3D STC3117_INIT;
> +	}
> +
> +	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
> +	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
> +
> +	count_m =3D (count_m << 8) + count_l;
> +
> +	/* INIT state, wait for batt_current & temperature value available: */
> +	if (ram_data.reg.state =3D=3D STC3117_INIT && count_m > 4) {
> +		data->avg_voltage =3D data->voltage;
> +		data->avg_current =3D data->batt_current;
> +		ram_data.reg.state =3D STC3117_RUNNING;
> +	}
> +
> +	if (ram_data.reg.state !=3D STC3117_RUNNING) {
> +		data->batt_current =3D 0;
> +		data->temp =3D 250;

why 250?

> +	} else {
> +		if (data->voltage < APP_CUTOFF_VOLTAGE)
> +			data->soc =3D 0;
> +
> +		if (mode & STC3117_VMODE) {
> +			data->avg_current =3D 0;
> +			data->batt_current =3D 0;
> +		} else {
> +			stc3117_update_battery_status(data);
> +		}
> +	}
> +
> +	ram_data.reg.hrsoc =3D data->hrsoc;
> +	ram_data.reg.soc =3D (data->soc + 5) / 10;
> +	ram_data.reg.crc =3D crc8(stc3117_crc_table, ram_data.ram_bytes,
> +				STC3117_RAM_SIZE - 1, CRC8_INIT);
> +
> +	ret =3D ram_write(data);
> +	if (ret)
> +		return ret;
> +	return 0;
> +};
> +
> +static void fuel_gauge_update_work(struct work_struct *work)
> +{
> +	struct stc3117_data *data =3D container_of(to_delayed_work(work),
> +					struct stc3117_data, update_work);
> +	stc3117_task(data);

Please run checkpatch before patch submission.

> +
> +	/* Schedule the work to run again in 2 seconds */
> +	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
> +}
> +
> +static int stc3117_get_property(struct power_supply *psy,
> +		enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct stc3117_data *data =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (data->soc > BATTERY_FULL)
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +		else if (data->batt_current < 0)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (data->batt_current > 0)
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D data->voltage;

This has to be in uV.

> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D data->batt_current;
> +		break;

This has to be in uA.

> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D data->soc;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval =3D data->temp;
> +		break;

This has to be in 1/10 of =B0C.

> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D data->presence;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static enum power_supply_property stc3117_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_PRESENT,
> +};

During the read process you are also getting OCV and average
current. Why are you not exporting them via the following
properties (in uV and uA) when you are getting them anyways?

POWER_SUPPLY_PROP_VOLTAGE_OCV
POWER_SUPPLY_PROP_CURRENT_AVG

> +static const struct power_supply_desc stc3117_battery_desc =3D {
> +	.name =3D "stc3117-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property =3D stc3117_get_property,
> +	.properties =3D stc3117_battery_props,
> +	.num_properties =3D ARRAY_SIZE(stc3117_battery_props),
> +};
> +
> +static const struct regmap_config stc3117_regmap_config =3D {
> +	.reg_bits       =3D 8,
> +	.val_bits       =3D 8,
> +};
> +
> +static int stc3117_probe(struct i2c_client *client)
> +{
> +	struct stc3117_data *data;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct power_supply_battery_info *info;
> +	int ret;
> +
> +	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client =3D client;
> +	data->regmap =3D devm_regmap_init_i2c(client, &stc3117_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	psy_cfg.drv_data =3D data;

psy_cfg.fwnode =3D dev_fwnode(dev);

> +
> +	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
> +
> +	data->battery =3D devm_power_supply_register(&client->dev,
> +						   &stc3117_battery_desc, &psy_cfg);
> +	if (IS_ERR(data->battery))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
> +					"failed to register battery\n");
> +
> +	ret =3D device_property_read_u32(&client->dev, "shunt-resistor-micro-oh=
ms",
> +				       &battery_info.sense_resistor);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"failed to get sense-registor\n");
> +	battery_info.sense_resistor =3D battery_info.sense_resistor / 1000;
> +
> +	ret =3D power_supply_get_battery_info(data->battery, &info);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"failed to get battery information\n");
> +
> +	battery_info.battery_capacity_mah =3D info->charge_full_design_uah / 10=
00;
> +	battery_info.voltage_min_mv =3D info->voltage_min_design_uv / 1000;
> +	battery_info.voltage_max_mv =3D info->voltage_max_design_uv / 1000;
> +
> +	ret =3D stc3117_init(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				"failed to initialize of stc3117\n");
> +
> +	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);

This is not being stopped on module removal. You need
devm_delayed_work_autocancel() instead of INIT_DELAYED_WORK.

Greetings,

-- Sebastian

> +	schedule_delayed_work(&data->update_work, 0);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id stc3117_id[] =3D {
> +	{ "stc3117", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, stc3117_id);
> +
> +static const struct of_device_id stc3117_of_match[] =3D {
> +	{ .compatible =3D "st,stc3117" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, stc3117_of_match);
> +
> +static struct i2c_driver stc3117_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "stc3117_i2c_driver",
> +		.of_match_table =3D stc3117_of_match,
> +	},
> +	.probe =3D stc3117_probe,
> +	.id_table =3D stc3117_id,
> +};
> +
> +module_i2c_driver(stc3117_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.i=
o>");
> +MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
> +MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
> --=20
> 2.43.0
>=20

--toto5a7kkdsoezu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdS7V4ACgkQ2O7X88g7
+prO8w/+JVOt/mtUlSbwUv/pNdx2Ae9/byhsoIySGpBt1494nxknxXTkcgbuDgwS
ZU3wcOc0KAOw0nFqcwqa2tPkf0y70VYs24ryMw/hP5Jcq/hiBdJbtqce5/WiRRGN
exHl3kjHPhbBBjIV6QqqSOqm4I+IWZATw15/DJtznrY08Kw235bvEp4XxeXQu0oe
2hYfDFuNWx9hV7NXHb0KBPXwgAQh4+IIYUFa36ZceOulUNl8aro1yHJ4hmgjiEYx
F1hVRWrjGfmBu/P3UPm6Nympy7p5bnF5h1tT9TOrtn8OYYJzbeo3Z3YQvDtIiSqN
/GZ5ezssZNOK7J22N8vHurJGwKz2EE1IF/QlEECqlcCBcRXr2PuMHsDMXSvO1IVw
7r+esjFsuxJ1+GXW/IKx11wnxQAUz93PSWaPCdu6QtybNSdYsFEG1r2ISFE8vwTR
d9qz4raVYExGh3DYEcRhJvQhp9vMjzXLkfWvm411sD7+lqnF+r314fjVEc5RowsB
JH//pgMkKIsy7647N21TStUnD6gXVE7ozSao8Y6qK0S+/z/McQkhmSp2FGI6RNIV
DnzqjTm2j2Y/i17fckbDMbrtmXAjPwB16FJexbjCgAHlhud+yFXhxKtUHuWAyOjd
zhqIUQBhF+t3no+XEwdirxytEzTuEinwV3q5N5nSCPaIHoxKtiM=
=KDir
-----END PGP SIGNATURE-----

--toto5a7kkdsoezu6--


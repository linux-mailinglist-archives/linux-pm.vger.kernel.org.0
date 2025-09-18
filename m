Return-Path: <linux-pm+bounces-35012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F303B87655
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 01:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9655627969
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB66239E8D;
	Thu, 18 Sep 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gdr9ngy7"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F92110;
	Thu, 18 Sep 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239006; cv=pass; b=RyURfwvxMWJjRlaS41hYu8sCMr1M2k8JIFgX/wPDSKg1BpCiA10AxvtfRbnseTGhhdmUKAciY7As8aoPkvAPg/WcU0XDOQkRCgCZF/+vlDcTWjqd2/bKoloexY+Cl73tHGF2PSrWP1LZVY5z/dHbvXYu05h+YeioSVHSn06j9HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239006; c=relaxed/simple;
	bh=4M/YuMjhn69U6fi3yHJAgDAM3+3ZbrTgShQnTQG0SN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po+hWkINSfcpBewaZVtz3hg+4dIk46z7RfwVHZUQxz8fFrbNwLw9wLH++X2dw1UZMepSyyP8ZBBYoQTWeePVvbKAvvzbHqJh4vkcU/h4qRbY3zReYH0M1lYuBLUTujIdz7G3DuRY40exHTZ5SFglpnYVWlta3rRRX1YJMS7Bdag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=gdr9ngy7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758238992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aIrKtwMCAFJnt8cl55ed9bsSCKGLL2T/45vje3X9mXCnNLQ/RQvqG6dsx1uQ5xODhSKmRE1xQnv02OB+Wm2bg5K0L6U0GzNY1RSKcVuzEq04ES9hR/3TGIE7JDouLIAhcweGQwKEO+QPXoX4I2bI/e8jxkqsV6+A8VlUiq66P+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758238992; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+lC8hSyrv8XQr7zVdCVUsyfJ3/ukf2JzeXsHytYrTx0=; 
	b=ggB8PK1yWcj3UkhItBUxdGF7SheXv2z7TDNVwHsmUyXLzNxLVnjAQKPfUhx4qSrajPB81zEVYPgx6QpeiVO9inbOMD16Zp/xub79huEIiTUasvTLUStKVcVd9U75x5nvsZAK4yTOywexbNpsZhoayoJ5IlfOeqNhaO5Be3/m0/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758238992;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+lC8hSyrv8XQr7zVdCVUsyfJ3/ukf2JzeXsHytYrTx0=;
	b=gdr9ngy7LpHHZFO0UmDKhnZcbfVJsfHpc4NuIRWL2M5rcxpVFCw6pUwlrmKEOBrI
	yOUUbyWFI1+tQ6pn6CcT/rRCRK0jbeXwjgdxWEaGFBa9/Tg5cKl5gRfUtMG9IH2lZCZ
	XZ6l2FmEQt2hQLlsf5YC7MKIVPWd3c44HciBUFNw=
Received: by mx.zohomail.com with SMTPS id 1758238990880496.58306325292335;
	Thu, 18 Sep 2025 16:43:10 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 33132180517; Fri, 19 Sep 2025 01:43:02 +0200 (CEST)
Date: Fri, 19 Sep 2025 01:43:02 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: cy_huang@richtek.com
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/3] power: supply: rt9756: Add Richtek RT9756
 smart cap divider charger
Message-ID: <uarjdpyemkqnwneoj6kdj7vfzzllbqmsurjnsjr5hkujao6thx@2ysih3s7mftj>
References: <cover.1755154950.git.cy_huang@richtek.com>
 <2bceb1be91e8841cd373c1d04f0a79d88c888dd8.1755154950.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvavl5kzzohynmvf"
Content-Disposition: inline
In-Reply-To: <2bceb1be91e8841cd373c1d04f0a79d88c888dd8.1755154950.git.cy_huang@richtek.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.211.62
X-ZohoMailClient: External


--bvavl5kzzohynmvf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v2 2/3] power: supply: rt9756: Add Richtek RT9756
 smart cap divider charger
MIME-Version: 1.0

Hi,

On Thu, Aug 14, 2025 at 03:31:07PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Add support for RT9756 smart cap divider charger.
>=20
> The RT9759 is a high efficiency and high charge current charger. The
> maximum charge current is up to 8A. It integrates a dual-phase charge
> pump core with ADC monitoring.
>=20
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---

Sorry for the delay. This looks mostly good, but I really don't like
the custom properties for the battery voltage and current. Instead
of handling via custom properties, register a second power_supply
device with POWER_SUPPLY_TYPE_BATTERY and use the normal=20
POWER_SUPPLY_PROP_VOLTAGE_NOW and POWER_SUPPLY_PROP_CURRENT_NOW
properties. Having custom properties for the watchdog and the
operating mode is fine with me, as these two things are quite
specific to the RT9756 chips.

While you are at it, you can also add this constant property for
the battery device:

POWER_SUPPLY_PROP_TECHNOLOGY =3D POWER_SUPPLY_TECHNOLOGY_LION

Also the charger's power_supply_config should set the
=2Esupplied_to, listing the battery device, so that the kernel
is aware of the link between those two devices.

Greetings,

-- Sebastian

>  drivers/power/supply/Kconfig  |  15 +
>  drivers/power/supply/Makefile |   1 +
>  drivers/power/supply/rt9756.c | 932 ++++++++++++++++++++++++++++++++++
>  3 files changed, 948 insertions(+)
>  create mode 100644 drivers/power/supply/rt9756.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2da..aff192474140 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -909,6 +909,21 @@ config CHARGER_RT9471
>  	  This driver can also be built as a module. If so, the module will be
>  	  called rt9471.
> =20
> +config CHARGER_RT9756
> +	tristate "Richtek RT9756 smart cap divider charger driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select LINEAR_RANGES
> +	help
> +	  This adds support for Richtek RT9756 smart cap divider charger driver.
> +	  It's a high efficiency and high charge current charger. the device
> +	  integrates smart cap divider topology with 9-channel high speed
> +	  ADCs that can provide input and output voltage, current and
> +	  temperature monitoring.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called rt9756.
> +
>  config CHARGER_CROS_USBPD
>  	tristate "ChromeOS EC based USBPD charger"
>  	depends on CROS_USBPD_NOTIFY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4f5f8e3507f8..a529f217f0ad 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_CHARGER_RT5033)	+=3D rt5033_charger.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
>  obj-$(CONFIG_CHARGER_RT9467)	+=3D rt9467-charger.o
>  obj-$(CONFIG_CHARGER_RT9471)	+=3D rt9471.o
> +obj-$(CONFIG_CHARGER_RT9756)	+=3D rt9756.o
>  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
>  obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
>  obj-$(CONFIG_BATTERY_RX51)	+=3D rx51_battery.o
> diff --git a/drivers/power/supply/rt9756.c b/drivers/power/supply/rt9756.c
> new file mode 100644
> index 000000000000..99bfbcc37272
> --- /dev/null
> +++ b/drivers/power/supply/rt9756.c
> @@ -0,0 +1,932 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (C) 2025 Richtek Technology Corp.
> +//
> +// Authors: ChiYuan Huang <cy_huang@richtek.com>
> +
> +#include <linux/atomic.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/linear_range.h>
> +#include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/util_macros.h>
> +
> +#define RT9756_REG_INTFLAG1	0x0B
> +#define RT9756_REG_INTFLAG2	0x0D
> +#define RT9756_REG_INTFLAG3	0x0F
> +#define RT9756_REG_ADCCTL	0x11
> +#define RT9756_REG_VBUSADC	0x12
> +#define RT9756_REG_BC12FLAG	0x45
> +#define RT9756_REG_INTFLAG4	0x49
> +
> +/* Flag1 */
> +#define RT9756_EVT_BUSOVP	BIT(3)
> +#define RT9756_EVT_BUSOCP	BIT(2)
> +#define RT9756_EVT_BUSUCP	BIT(0)
> +/* Flag2 */
> +#define RT9756_EVT_BATOVP	BIT(7)
> +#define RT9756_EVT_BATOCP	BIT(6)
> +#define RT9756_EVT_TDIEOTP	BIT(3)
> +#define RT9756_EVT_VBUSLOW_ERR	BIT(2)
> +#define RT9756_EVT_VAC_INSERT	BIT(0)
> +/* Flag3 */
> +#define RT9756_EVT_WDT		BIT(5)
> +#define RT9756_EVT_VAC_UVLO	BIT(4)
> +/* ADCCTL */
> +#define RT9756_ADCEN_MASK	BIT(7)
> +#define RT9756_ADCONCE_MASK	BIT(6)
> +/* Bc12_flag */
> +#define RT9756_EVT_BC12_DONE	BIT(3)
> +/* Flag4 */
> +#define RT9756_EVT_OUTOVP	BIT(0)
> +
> +#define RICHTEK_DEVID		7
> +#define RT9756_REVID		0
> +#define RT9756A_REVID		1
> +#define RT9757_REVID		2
> +#define RT9757A_REVID		3
> +#define RT9756_ADC_CONVTIME	1200
> +#define RT9756_ADC_MAXWAIT	16000
> +
> +enum rt9756_model {
> +	MODEL_RT9756 =3D 0,
> +	MODEL_RT9757,
> +	MODEL_RT9770,
> +	MODEL_MAX
> +};
> +
> +enum rt9756_adc_chan {
> +	ADC_VBUS =3D 0,
> +	ADC_IBUS,
> +	ADC_VBAT,
> +	ADC_IBAT,
> +	ADC_TDIE,
> +	ADC_MAX_CHANNEL
> +};
> +
> +enum rt9756_usb_type {
> +	USB_NO_VBUS =3D 0,
> +	USB_SDP =3D 2,
> +	USB_NSTD,
> +	USB_DCP,
> +	USB_CDP,
> +	MAX_USB_TYPE
> +};
> +
> +enum rt9756_fields {
> +	F_VBATOVP =3D 0,
> +	F_VBATOVP_EN,
> +	F_IBATOCP,
> +	F_IBATOCP_EN,
> +	F_VBUSOVP,
> +	F_VBUSOVP_EN,
> +	F_IBUSOCP,
> +	F_IBUSOCP_EN,
> +	F_SWITCHING,
> +	F_REG_RST,
> +	F_CHG_EN,
> +	F_OP_MODE,
> +	F_WDT_DIS,
> +	F_WDT_TMR,
> +	F_DEV_ID,
> +	F_BC12_EN,
> +	F_USB_STATE,
> +	F_VBUS_STATE,
> +	F_IBAT_RSEN,
> +	F_REVISION,
> +	F_MAX_FIELD
> +};
> +
> +enum rt9756_ranges {
> +	R_VBATOVP =3D 0,
> +	R_IBATOCP,
> +	R_VBUSOVP,
> +	R_IBUSOCP,
> +	R_MAX_RANGE
> +};
> +
> +static const struct reg_field rt9756_chg_fields[F_MAX_FIELD] =3D {
> +	[F_VBATOVP]	=3D REG_FIELD(0x08, 0, 4),
> +	[F_VBATOVP_EN]	=3D REG_FIELD(0x08, 7, 7),
> +	[F_IBATOCP]	=3D REG_FIELD(0x09, 0, 5),
> +	[F_IBATOCP_EN]	=3D REG_FIELD(0x09, 7, 7),
> +	[F_VBUSOVP]	=3D REG_FIELD(0x06, 0, 5),
> +	[F_VBUSOVP_EN]	=3D REG_FIELD(0x06, 7, 7),
> +	[F_IBUSOCP]	=3D REG_FIELD(0x07, 0, 4),
> +	[F_IBUSOCP_EN]	=3D REG_FIELD(0x07, 5, 5),
> +	[F_SWITCHING]	=3D REG_FIELD(0x5c, 7, 7),
> +	[F_REG_RST]	=3D REG_FIELD(0x00, 7, 7),
> +	[F_CHG_EN]	=3D REG_FIELD(0x00, 6, 6),
> +	[F_OP_MODE]	=3D REG_FIELD(0x00, 5, 5),
> +	[F_WDT_DIS]	=3D REG_FIELD(0x00, 3, 3),
> +	[F_WDT_TMR]	=3D REG_FIELD(0x00, 0, 2),
> +	[F_DEV_ID]	=3D REG_FIELD(0x03, 0, 3),
> +	[F_BC12_EN]	=3D REG_FIELD(0x44, 7, 7),
> +	[F_USB_STATE]	=3D REG_FIELD(0x46, 5, 7),
> +	[F_VBUS_STATE]	=3D REG_FIELD(0x4c, 0, 0),
> +	[F_IBAT_RSEN]	=3D REG_FIELD(0x5e, 0, 1),
> +	[F_REVISION]	=3D REG_FIELD(0x62, 0, 1),
> +};
> +
> +static const struct reg_field rt9770_chg_fields[F_MAX_FIELD] =3D {
> +	[F_VBATOVP]	=3D REG_FIELD(0x08, 0, 4),
> +	[F_VBATOVP_EN]	=3D REG_FIELD(0x08, 7, 7),
> +	[F_IBATOCP]	=3D REG_FIELD(0x09, 0, 5),
> +	[F_IBATOCP_EN]	=3D REG_FIELD(0x09, 7, 7),
> +	[F_VBUSOVP]	=3D REG_FIELD(0x06, 0, 5),
> +	[F_VBUSOVP_EN]	=3D REG_FIELD(0x06, 7, 7),
> +	[F_IBUSOCP]	=3D REG_FIELD(0x07, 0, 4),
> +	[F_IBUSOCP_EN]	=3D REG_FIELD(0x07, 5, 5),
> +	[F_SWITCHING]	=3D REG_FIELD(0x5c, 7, 7),
> +	[F_REG_RST]	=3D REG_FIELD(0x00, 7, 7),
> +	[F_CHG_EN]	=3D REG_FIELD(0x00, 6, 6),
> +	[F_OP_MODE]	=3D REG_FIELD(0x00, 5, 5),
> +	[F_WDT_DIS]	=3D REG_FIELD(0x00, 3, 3),
> +	[F_WDT_TMR]	=3D REG_FIELD(0x00, 0, 2),
> +	[F_DEV_ID]	=3D REG_FIELD(0x60, 0, 3),
> +	[F_BC12_EN]	=3D REG_FIELD(0x03, 7, 7),
> +	[F_USB_STATE]	=3D REG_FIELD(0x02, 5, 7),
> +	[F_VBUS_STATE]	=3D REG_FIELD(0x4c, 0, 0),
> +	[F_IBAT_RSEN]	=3D REG_FIELD(0x5e, 0, 1),
> +	[F_REVISION]	=3D REG_FIELD(0x62, 3, 7),
> +};
> +
> +/* All converted to microvolt or microamp */
> +static const struct linear_range rt9756_chg_ranges[R_MAX_RANGE] =3D {
> +	LINEAR_RANGE_IDX(R_VBATOVP, 4200000, 0, 31, 25000),
> +	LINEAR_RANGE_IDX(R_IBATOCP, 2000000, 0, 63, 100000),
> +	LINEAR_RANGE_IDX(R_VBUSOVP, 3000000, 0, 63, 50000),
> +	LINEAR_RANGE_IDX(R_IBUSOCP, 1000000, 0, 31, 250000),
> +};
> +
> +struct charger_event {
> +	unsigned int flag1;
> +	unsigned int flag2;
> +	unsigned int flag3;
> +	unsigned int flag4;
> +};
> +
> +struct rt9756_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regmap_field *rm_fields[F_MAX_FIELD];
> +	struct power_supply *psy;
> +	struct mutex adc_lock;
> +	struct power_supply_desc psy_desc;
> +	struct charger_event chg_evt;
> +	unsigned int rg_resistor;
> +	unsigned int real_resistor;
> +	enum rt9756_model model;
> +	atomic_t usb_type;
> +};
> +
> +struct rt975x_dev_data {
> +	const struct regmap_config *regmap_config;
> +	const struct reg_field *reg_fields;
> +	const struct reg_sequence *init_regs;
> +	size_t num_init_regs;
> +	int (*check_device_model)(struct rt9756_data *data);
> +};
> +
> +static int rt9756_get_value_field_range(struct rt9756_data *data, enum r=
t9756_fields en_field,
> +					enum rt9756_fields field, enum rt9756_ranges rsel, int *val)
> +{
> +	const struct linear_range *range =3D rt9756_chg_ranges + rsel;
> +	unsigned int enable, selector, value;
> +	int ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[en_field], &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (!enable) {
> +		*val =3D 0;
> +		return 0;
> +	}
> +
> +	ret =3D regmap_field_read(data->rm_fields[field], &selector);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D linear_range_get_value(range, selector, &value);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D (int)value;
> +
> +	return 0;
> +}
> +
> +static int rt9756_set_value_field_range(struct rt9756_data *data, enum r=
t9756_fields en_field,
> +					enum rt9756_fields field, enum rt9756_ranges rsel, int val)
> +{
> +	const struct linear_range *range =3D rt9756_chg_ranges + rsel;
> +	unsigned int selector, value;
> +	int ret;
> +
> +	if (!val)
> +		return regmap_field_write(data->rm_fields[en_field], 0);
> +
> +	value =3D (unsigned int)val;
> +	linear_range_get_selector_within(range, value, &selector);
> +	ret =3D regmap_field_write(data->rm_fields[field], selector);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_field_write(data->rm_fields[en_field], 1);
> +}
> +
> +static int rt9756_get_adc(struct rt9756_data *data, enum rt9756_adc_chan=
 chan,
> +			  int *val)
> +{
> +	struct regmap *regmap =3D data->regmap;
> +	unsigned int reg_addr =3D RT9756_REG_VBUSADC + chan * 2;
> +	unsigned int mask =3D RT9756_ADCEN_MASK | RT9756_ADCONCE_MASK;
> +	unsigned int shift =3D 0, adc_cntl;
> +	__be16 raws;
> +	int scale, offset =3D 0, ret;
> +
> +	guard(mutex)(&data->adc_lock);
> +
> +	ret =3D regmap_update_bits(regmap, RT9756_REG_ADCCTL, mask, mask);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read_poll_timeout(regmap, RT9756_REG_ADCCTL, adc_cntl,
> +				       !(adc_cntl & RT9756_ADCEN_MASK),
> +				       RT9756_ADC_CONVTIME, RT9756_ADC_MAXWAIT);
> +	if (ret && ret !=3D -ETIMEDOUT)
> +		return ret;
> +
> +	ret =3D regmap_raw_read(regmap, reg_addr, &raws, sizeof(raws));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * TDIE LSB 1'c, others LSB 1000uV or 1000uA.
> +	 * Rsense ratio is needed for IBAT channel
> +	 */
> +	if (chan =3D=3D ADC_TDIE) {
> +		scale =3D 10;
> +		shift =3D 8;
> +		offset =3D -40;
> +	} else if (chan =3D=3D ADC_IBAT)
> +		scale =3D 1000 * data->rg_resistor / data->real_resistor;
> +	else
> +		scale =3D 1000;
> +
> +	*val =3D ((be16_to_cpu(raws) >> shift) + offset) * scale;
> +
> +	return regmap_update_bits(regmap, RT9756_REG_ADCCTL, mask, 0);
> +}
> +
> +static int rt9756_get_switching_state(struct rt9756_data *data, int *sta=
tus)
> +{
> +	unsigned int switching_state;
> +	int ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[F_SWITCHING], &switching_stat=
e);
> +	if (ret)
> +		return ret;
> +
> +	if (switching_state)
> +		*status =3D POWER_SUPPLY_STATUS_CHARGING;
> +	else
> +		*status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	return 0;
> +}
> +
> +static int rt9756_get_charger_health(struct rt9756_data *data)
> +{
> +	struct charger_event *evt =3D &data->chg_evt;
> +
> +	if (evt->flag2 & RT9756_EVT_VBUSLOW_ERR)
> +		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
> +
> +	if (evt->flag1 & RT9756_EVT_BUSOVP || evt->flag2 & RT9756_EVT_BATOVP ||
> +	    evt->flag4 & RT9756_EVT_OUTOVP)
> +		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +
> +	if (evt->flag1 & RT9756_EVT_BUSOCP || evt->flag2 & RT9756_EVT_BATOCP)
> +		return POWER_SUPPLY_HEALTH_OVERCURRENT;
> +
> +	if (evt->flag1 & RT9756_EVT_BUSUCP)
> +		return POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +
> +	if (evt->flag2 & RT9756_EVT_TDIEOTP)
> +		return POWER_SUPPLY_HEALTH_OVERHEAT;
> +
> +	if (evt->flag3 & RT9756_EVT_WDT)
> +		return POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE;
> +
> +	return POWER_SUPPLY_HEALTH_GOOD;
> +}
> +
> +static int rt9756_get_charger_online(struct rt9756_data *data, int *val)
> +{
> +	unsigned int online;
> +	int ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[F_VBUS_STATE], &online);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D !!online;
> +	return 0;
> +}
> +
> +static int rt9756_get_vbus_ovp(struct rt9756_data *data, int *val)
> +{
> +	unsigned int opmode;
> +	int ovpval, ret;
> +
> +	/* operating mode -> 0 bypass, 1 div2 */
> +	ret =3D regmap_field_read(data->rm_fields[F_OP_MODE], &opmode);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rt9756_get_value_field_range(data, F_VBUSOVP_EN, F_VBUSOVP, R_V=
BUSOVP, &ovpval);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D opmode ? ovpval * 2 : ovpval;
> +	return 0;
> +}
> +
> +static int rt9756_set_vbus_ovp(struct rt9756_data *data, int val)
> +{
> +	unsigned int opmode;
> +	int ret;
> +
> +	/* operating mode -> 0 bypass, 1 div2 */
> +	ret =3D regmap_field_read(data->rm_fields[F_OP_MODE], &opmode);
> +	if (ret)
> +		return ret;
> +
> +	return rt9756_set_value_field_range(data, F_VBUSOVP_EN, F_VBUSOVP, R_VB=
USOVP,
> +					    opmode ? val / 2 : val);
> +}
> +
> +static const char * const rt9756_manufacturer =3D "Richtek Technology Co=
rp.";
> +static const char * const rt9756_model[MODEL_MAX] =3D  { "RT9756", "RT97=
57", "RT9770" };
> +
> +static int rt9756_psy_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	int *pval =3D &val->intval;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return rt9756_get_switching_state(data, pval);
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		*pval =3D rt9756_get_charger_health(data);
> +		return 0;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return rt9756_get_charger_online(data, pval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		return rt9756_get_vbus_ovp(data, pval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		return rt9756_get_adc(data, ADC_VBUS, pval);
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		return rt9756_get_value_field_range(data, F_IBUSOCP_EN, F_IBUSOCP, R_I=
BUSOCP, pval);
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return rt9756_get_adc(data, ADC_IBUS, pval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return rt9756_get_value_field_range(data, F_VBATOVP_EN, F_VBATOVP, R_V=
BATOVP, pval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return rt9756_get_value_field_range(data, F_IBATOCP_EN, F_IBATOCP, R_I=
BATOCP, pval);
> +	case POWER_SUPPLY_PROP_TEMP:
> +		return rt9756_get_adc(data, ADC_TDIE, pval);
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		*pval =3D atomic_read(&data->usb_type);
> +		return 0;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D rt9756_model[data->model];
> +		return 0;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D rt9756_manufacturer;
> +		return 0;
> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static int rt9756_psy_set_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   const union power_supply_propval *val)
> +{
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	int intval =3D val->intval;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		memset(&data->chg_evt, 0, sizeof(data->chg_evt));
> +		return regmap_field_write(data->rm_fields[F_CHG_EN], !!intval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		return rt9756_set_vbus_ovp(data, intval);
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		return rt9756_set_value_field_range(data, F_IBUSOCP_EN, F_IBUSOCP, R_I=
BUSOCP,
> +						    intval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return rt9756_set_value_field_range(data, F_VBATOVP_EN, F_VBATOVP, R_V=
BATOVP,
> +						    intval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return rt9756_set_value_field_range(data, F_IBATOCP_EN, F_IBATOCP, R_I=
BATOCP,
> +						    intval);
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return regmap_field_write(data->rm_fields[F_BC12_EN], !!intval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const enum power_supply_property rt9756_psy_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static int rt9756_psy_property_is_writeable(struct power_supply *psy,
> +					    enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +	case POWER_SUPPLY_PROP_ONLINE:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const unsigned int rt9756_wdt_millisecond[] =3D {
> +	500, 1000, 5000, 30000, 40000, 80000, 128000, 255000
> +};
> +
> +static ssize_t watchdog_timer_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	unsigned int wdt_tmr_now =3D 0, wdt_sel, wdt_dis;
> +	int ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[F_WDT_DIS], &wdt_dis);
> +	if (ret)
> +		return ret;
> +
> +	if (!wdt_dis) {
> +		ret =3D regmap_field_read(data->rm_fields[F_WDT_TMR], &wdt_sel);
> +		if (ret)
> +			return ret;
> +
> +		wdt_tmr_now =3D rt9756_wdt_millisecond[wdt_sel];
> +	}
> +
> +	return sysfs_emit(buf, "%d\n", wdt_tmr_now);
> +}
> +
> +static ssize_t watchdog_timer_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	unsigned int wdt_set, wdt_sel;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &wdt_set);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_write(data->rm_fields[F_WDT_DIS], 1);
> +	if (ret)
> +		return ret;
> +
> +	wdt_sel =3D find_closest(wdt_set, rt9756_wdt_millisecond,
> +			       ARRAY_SIZE(rt9756_wdt_millisecond));
> +
> +	ret =3D regmap_field_write(data->rm_fields[F_WDT_TMR], wdt_sel);
> +	if (ret)
> +		return ret;
> +
> +	if (wdt_set) {
> +		ret =3D regmap_field_write(data->rm_fields[F_WDT_DIS], 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t battery_voltage_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	int vbat_now, ret;
> +
> +	ret =3D rt9756_get_adc(data, ADC_VBAT, &vbat_now);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", vbat_now);
> +}
> +
> +static ssize_t battery_current_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	int ibat_now, ret;
> +
> +	ret =3D rt9756_get_adc(data, ADC_IBAT, &ibat_now);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", ibat_now);
> +}
> +
> +static const char * const rt9756_opmode_str[] =3D { "bypass", "div2" };
> +
> +static ssize_t operation_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	unsigned int opmode;
> +	int ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[F_OP_MODE], &opmode);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%s\n", rt9756_opmode_str[opmode]);
> +}
> +
> +static ssize_t operation_mode_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct rt9756_data *data =3D power_supply_get_drvdata(psy);
> +	int index, ret;
> +
> +	index =3D sysfs_match_string(rt9756_opmode_str, buf);
> +	if (index < 0)
> +		return index;
> +
> +	ret =3D regmap_field_write(data->rm_fields[F_OP_MODE], index);
> +
> +	return ret ?: count;
> +}
> +
> +static DEVICE_ATTR_RW(watchdog_timer);
> +static DEVICE_ATTR_RO(battery_voltage);
> +static DEVICE_ATTR_RO(battery_current);
> +static DEVICE_ATTR_RW(operation_mode);
> +
> +static struct attribute *rt9756_sysfs_attrs[] =3D {
> +	&dev_attr_watchdog_timer.attr,
> +	&dev_attr_battery_voltage.attr,
> +	&dev_attr_battery_current.attr,
> +	&dev_attr_operation_mode.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(rt9756_sysfs);
> +
> +static int rt9756_register_psy(struct rt9756_data *data)
> +{
> +	struct power_supply_desc *desc =3D &data->psy_desc;
> +	struct power_supply_config cfg =3D {};
> +	struct device *dev =3D data->dev;
> +	char *psy_name;
> +
> +	cfg.drv_data =3D data;
> +	cfg.fwnode =3D dev_fwnode(dev);
> +	cfg.attr_grp =3D rt9756_sysfs_groups;
> +
> +	psy_name =3D devm_kasprintf(dev, GFP_KERNEL, "rt9756-%s", dev_name(dev)=
);
> +	if (!psy_name)
> +		return -ENOMEM;
> +
> +	desc->name =3D psy_name;
> +	desc->type =3D POWER_SUPPLY_TYPE_USB;
> +	desc->usb_types =3D BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) | BIT(POWER_SUPP=
LY_USB_TYPE_SDP) |
> +			  BIT(POWER_SUPPLY_USB_TYPE_DCP) | BIT(POWER_SUPPLY_USB_TYPE_CDP);
> +	desc->properties =3D rt9756_psy_properties;
> +	desc->num_properties =3D ARRAY_SIZE(rt9756_psy_properties);
> +	desc->property_is_writeable =3D rt9756_psy_property_is_writeable;
> +	desc->get_property =3D rt9756_psy_get_property;
> +	desc->set_property =3D rt9756_psy_set_property;
> +
> +	data->psy =3D devm_power_supply_register(dev, desc, &cfg);
> +
> +	return PTR_ERR_OR_ZERO(data->psy);
> +}
> +
> +static int rt9756_get_usb_type(struct rt9756_data *data)
> +{
> +	unsigned int type;
> +	int report_type, ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[F_USB_STATE], &type);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case USB_SDP:
> +	case USB_NSTD:
> +		report_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case USB_DCP:
> +		report_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +		break;
> +	case USB_CDP:
> +		report_type =3D POWER_SUPPLY_USB_TYPE_CDP;
> +		break;
> +	case USB_NO_VBUS:
> +	default:
> +		report_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		break;
> +	}
> +
> +	atomic_set(&data->usb_type, report_type);
> +	return 0;
> +}
> +
> +static irqreturn_t rt9756_irq_handler(int irq, void *devid)
> +{
> +	struct rt9756_data *data =3D devid;
> +	struct regmap *regmap =3D data->regmap;
> +	struct charger_event *evt =3D &data->chg_evt;
> +	unsigned int bc12_flag =3D 0;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, RT9756_REG_INTFLAG1, &evt->flag1);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_read(regmap, RT9756_REG_INTFLAG2, &evt->flag2);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_read(regmap, RT9756_REG_INTFLAG3, &evt->flag3);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (data->model !=3D MODEL_RT9770) {
> +		ret =3D regmap_read(regmap, RT9756_REG_INTFLAG4, &evt->flag4);
> +		if (ret)
> +			return IRQ_NONE;
> +
> +		ret =3D regmap_read(regmap, RT9756_REG_BC12FLAG, &bc12_flag);
> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	dev_dbg(data->dev, "events: 0x%02x,%02x,%02x,%02x,%02x\n", evt->flag1, =
evt->flag2,
> +		evt->flag3, evt->flag4, bc12_flag);
> +
> +	if (evt->flag2 & RT9756_EVT_VAC_INSERT) {
> +		ret =3D regmap_field_write(data->rm_fields[F_BC12_EN], 1);
> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	if (evt->flag3 & RT9756_EVT_VAC_UVLO)
> +		atomic_set(&data->usb_type, POWER_SUPPLY_USB_TYPE_UNKNOWN);
> +
> +	if (bc12_flag & RT9756_EVT_BC12_DONE) {
> +		ret =3D rt9756_get_usb_type(data);
> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	power_supply_changed(data->psy);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rt9756_config_batsense_resistor(struct rt9756_data *data)
> +{
> +	unsigned int shunt_resistor_uohms =3D 2000, rsense_sel;
> +
> +	device_property_read_u32(data->dev, "shunt-resistor-micro-ohms", &shunt=
_resistor_uohms);
> +
> +	if (!shunt_resistor_uohms || shunt_resistor_uohms > 5000)
> +		return -EINVAL;
> +
> +	data->real_resistor =3D shunt_resistor_uohms;
> +
> +	/* Always choose the larger or equal one to prevent false ocp alarm */
> +	if (shunt_resistor_uohms <=3D 1000) {
> +		rsense_sel =3D 0;
> +		data->rg_resistor =3D 1000;
> +	} else if (shunt_resistor_uohms <=3D 2000) {
> +		rsense_sel =3D 1;
> +		data->rg_resistor =3D 2000;
> +	} else {
> +		rsense_sel =3D 2;
> +		data->rg_resistor =3D 5000;
> +	}
> +
> +	return regmap_field_write(data->rm_fields[F_IBAT_RSEN], rsense_sel);
> +}
> +
> +static const struct reg_sequence rt9756_init_regs[] =3D {
> +	REG_SEQ(0x00, 0x80, 1000), /* REG_RESET */
> +	REG_SEQ0(0x04, 0x13), /* VACOVP/OVPGATE 12V */
> +	REG_SEQ0(0x00, 0x28), /* WDT_DIS =3D 1 */
> +	REG_SEQ0(0x0c, 0x02), /* MASK FLAG1 */
> +	REG_SEQ0(0x0e, 0x06), /* MASK FLAG2 */
> +	REG_SEQ0(0x10, 0xca), /* MASK FLAG3 */
> +	REG_SEQ0(0x44, 0xa0), /* BC12_EN */
> +	REG_SEQ0(0x47, 0x07), /* MASK BC12FLAG */
> +	REG_SEQ0(0x4a, 0xfe), /* MASK FLAG4 */
> +	REG_SEQ0(0x5c, 0x40), /* MASK CON_SWITCHING */
> +	REG_SEQ0(0x63, 0x01), /* MASK VDDA_UVLO */
> +};
> +
> +static const struct reg_sequence rt9770_init_regs[] =3D {
> +	REG_SEQ(0x00, 0x80, 1000), /* REG_RESET */
> +	REG_SEQ0(0x04, 0x13), /* VACOVP/OVPGATE 12V */
> +	REG_SEQ0(0x00, 0x28), /* WDT_DIS =3D 1 */
> +	REG_SEQ0(0x0c, 0x02), /* MASK FLAG1 */
> +	REG_SEQ0(0x0e, 0x06), /* MASK FLAG2 */
> +	REG_SEQ0(0x10, 0xca), /* MASK FLAG3 */
> +	REG_SEQ0(0x5c, 0x40), /* MASK CON_SWITCHING */
> +	REG_SEQ0(0x63, 0x01), /* MASK VDDA_UVLO */
> +};
> +
> +static const struct regmap_config rt9756_regmap_config =3D {
> +	.name =3D "rt9756",
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x1ff,
> +};
> +
> +static const struct regmap_config rt9770_regmap_config =3D {
> +	.name =3D "rt9770",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0xff,
> +};
> +
> +static int rt9756_check_device_model(struct rt9756_data *data)
> +{
> +	struct device *dev =3D data->dev;
> +	unsigned int revid;
> +	int ret;
> +
> +	ret =3D regmap_field_read(data->rm_fields[F_REVISION], &revid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read revid\n");
> +
> +	if (revid =3D=3D RT9757_REVID || revid =3D=3D RT9757A_REVID)
> +		data->model =3D MODEL_RT9757;
> +	else if (revid =3D=3D RT9756_REVID || revid =3D=3D RT9756A_REVID)
> +		data->model =3D MODEL_RT9756;
> +	else
> +		return dev_err_probe(dev, -EINVAL, "Unknown revision %d\n", revid);
> +
> +	return 0;
> +}
> +
> +static int rt9770_check_device_model(struct rt9756_data *data)
> +{
> +	data->model =3D MODEL_RT9770;
> +	return 0;
> +}
> +
> +static int rt9756_probe(struct i2c_client *i2c)
> +{
> +	const struct rt975x_dev_data *dev_data;
> +	struct device *dev =3D &i2c->dev;
> +	struct rt9756_data *data;
> +	struct regmap *regmap;
> +	unsigned int devid;
> +	int ret;
> +
> +	dev_data =3D device_get_match_data(dev);
> +	if (!dev_data)
> +		return dev_err_probe(dev, -EINVAL, "No device data found\n");
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev =3D dev;
> +	mutex_init(&data->adc_lock);
> +	atomic_set(&data->usb_type, POWER_SUPPLY_USB_TYPE_UNKNOWN);
> +	i2c_set_clientdata(i2c, data);
> +
> +	regmap =3D devm_regmap_init_i2c(i2c, dev_data->regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
> +
> +	data->regmap =3D regmap;
> +
> +	ret =3D devm_regmap_field_bulk_alloc(dev, regmap, data->rm_fields, dev_=
data->reg_fields,
> +					   F_MAX_FIELD);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to alloc regmap fields\n");
> +
> +	/* Richtek Device ID check */
> +	ret =3D regmap_field_read(data->rm_fields[F_DEV_ID], &devid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read devid\n");
> +
> +	if (devid !=3D RICHTEK_DEVID)
> +		return dev_err_probe(dev, -ENODEV, "Incorrect VID 0x%02x\n", devid);
> +
> +	/* Get specific model */
> +	ret =3D dev_data->check_device_model(data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_register_patch(regmap, dev_data->init_regs, dev_data->nu=
m_init_regs);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init registers\n");
> +
> +	ret =3D rt9756_config_batsense_resistor(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to config batsense resistor\n");
> +
> +	ret =3D rt9756_register_psy(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init power supply\n");
> +
> +	return devm_request_threaded_irq(dev, i2c->irq, NULL, rt9756_irq_handle=
r, IRQF_ONESHOT,
> +					 dev_name(dev), data);
> +}
> +
> +static void rt9756_shutdown(struct i2c_client *i2c)
> +{
> +	struct rt9756_data *data =3D i2c_get_clientdata(i2c);
> +
> +	regmap_field_write(data->rm_fields[F_REG_RST], 1);
> +}
> +
> +static const struct rt975x_dev_data rt9756_dev_data =3D {
> +	.regmap_config		=3D &rt9756_regmap_config,
> +	.reg_fields		=3D rt9756_chg_fields,
> +	.init_regs		=3D rt9756_init_regs,
> +	.num_init_regs		=3D ARRAY_SIZE(rt9756_init_regs),
> +	.check_device_model	=3D rt9756_check_device_model,
> +};
> +
> +static const struct rt975x_dev_data rt9770_dev_data =3D {
> +	.regmap_config		=3D &rt9770_regmap_config,
> +	.reg_fields		=3D rt9770_chg_fields,
> +	.init_regs		=3D rt9770_init_regs,
> +	.num_init_regs		=3D ARRAY_SIZE(rt9770_init_regs),
> +	.check_device_model	=3D rt9770_check_device_model,
> +};
> +
> +static const struct of_device_id rt9756_device_match_table[] =3D {
> +	{ .compatible =3D "richtek,rt9756", .data =3D &rt9756_dev_data },
> +	{ .compatible =3D "richtek,rt9770", .data =3D &rt9770_dev_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt9756_device_match_table);
> +
> +static struct i2c_driver rt9756_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "rt9756",
> +		.of_match_table =3D rt9756_device_match_table,
> +	},
> +	.probe =3D rt9756_probe,
> +	.shutdown =3D rt9756_shutdown,
> +};
> +module_i2c_driver(rt9756_charger_driver);
> +
> +MODULE_DESCRIPTION("Richtek RT9756 charger driver");
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.34.1
>=20

--bvavl5kzzohynmvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjMmQIACgkQ2O7X88g7
+poCXRAAkc9Xy+i92gZazW1ZXz+hGZjeYxsfXDNhdVnl1wjMmo7yqBfurepOlGik
j84GAnqErFxn8xT/ZgGvaJT/E92T7qmir6KUfYCb6EQ+mRZVnhN/VMq3XrbfQ9S2
7FRXHSUs9HTS12+9uslNuwdHVIZe5UN6bl9EyXMznUzM4sqZ7p1EK9MMVoVA1iGw
kk7MEzm1lzpfuFLjzSufGHB1vOd3x8+p/a9r7lrfOfZShxH/lto4ZJl8V24OiRG3
u+Kjd7DtFla3+nneK5orf12IV+KCxSboREJavkguhKyLwn6HLS21mhItgOH2JbIK
W1kpTIp0DIxYgJVfdV4pJGNcVQWNtdRfvVxULaX2f+ThMpGSNp1ADeKERx35n6uq
pRwFSDqxBWqxZqf/vjlHcNfag4qEClWvfLdh6uLIjHktnq2xCZLn2JWplJRwvm/p
W/62nSRcT5sIGcjvSZnQlAPr6W+zAl1+w3ZcWeudf9zGCPYmS661y1hLYSlLkwTt
h4Fpr+6SdWQIEum0PQwhE0zalzrzXTblSpSIwmGejMUS56DMT2HoUjEfkqmTlfOe
XeT4K5GgftMyBwm77mJtG18+U023qxt+KWzRiBfjFPH3IZR9ZE6k7rNByw9E/GIG
1D1JcNH3cEU/Nhkr1ozp0FbBUUXYBU01mcZUMzEcmmwDpbzzOq0=
=zMRB
-----END PGP SIGNATURE-----

--bvavl5kzzohynmvf--


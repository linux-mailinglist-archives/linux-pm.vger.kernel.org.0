Return-Path: <linux-pm+bounces-39996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226BCE551A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A995B3008887
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16416225417;
	Sun, 28 Dec 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="Y3NMwYpe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA223204F8B;
	Sun, 28 Dec 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766944620; cv=none; b=kgqtNchXduz5wr16k71cpRdWh9i78Jf29PKTlHiiHXNx8BbLBelNeB7vrvAsn1w3o5KCYTzxCVQVMg7x0iSp2+D3NjMnUrGemT4yGT01sWJkfdOQseX6aMR9SrDenaw6MOGNABUxWWRs3RtEbcVmlEgPRF+9wg8gqGApwV1li1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766944620; c=relaxed/simple;
	bh=vzBM7iTJ1N2hIDsrUdTOy1DMExQ3ou2TSHgfKkaFTBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOLg1JRA+h7MLSNUrYacHwimVH+5vOOXA0qlpKd3scWeuEyjeL6Sdr1EglyG7STSZX5odivei5qtK1ho81OfD3oF3I/EWldEftKTv5wBJaaWBJUh7g3Q0rhAzca4mPibBYGSTo4g70ZH4HS3zr9qHgp8CLpPrhNlu5HGa36no0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=Y3NMwYpe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1766944600; x=1767549400; i=j.neuschaefer@gmx.net;
	bh=gxwTFnTRnyaWualmm3Im8GNQtsxiIxovVDAthcjCXss=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y3NMwYpeJ1qWrpvao5iaPx5tRiXpQ3FkWdpdOnK0J6sCb8I/5NAF1TYHMQDvNSL2
	 tX2TlX18tgO9x9jmYlEADLlo09rXpFD6j6Ya6QxFYvt4erh8L4NzEfKD5AIwwYn7t
	 YH4ynnZoLwnynLLrZ/a5521G/cJMbs4KfoIqB7b4zUWvBZtUW8wmCPgh+9AT28nKr
	 3y/U6UwO6QxGzZ5mQ2wJdNfb1HdOSYKHQLy6Zwijyy8a/UNWSce/UYEfsshnJdK4a
	 Jv4BiEJkg2tDml+WMUJK1Ucxex2hh66qkpGJmDzsgxR5AT/xWE0He01k+hfT78glv
	 Nz4Te6GWtJ/lDucseg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.100.107]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1vFmcL1s2D-00LVt7; Sun, 28
 Dec 2025 18:56:40 +0100
Date: Sun, 28 Dec 2025 18:56:38 +0100
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Josua Mayer <josua.mayer@jm0.eu>
Cc: j.neuschaefer@gmx.net, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] power: supply: add battery driver for netronix ec
Message-ID: <aVFvVtXe58q84NOk@probook>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
 <20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
X-Provags-ID: V03:K1:qd4VIPOMPFDt/GrZDXhLv8X/llDtYxQL5DV6KonIiUXYjWB2ne5
 sC/WoDRmPYyWYkDeL/qrm20tW7R4fYry71fHV16FXrYv1m13o9NltaW1PJZzJrMHr5tAaBU
 NAkvwkglCVlmc+bbLS3GORD5PBp49QYLdCydl8bMSH7fFSWY6EgobQsO16WRX9Io7BhvHqB
 MoJS1iHsZ0pdZSNHxvDHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GqEteljp9xA=;8ZlJd+E0maWbeHKN4wCXAgoDhAd
 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
 NsGV1YwheUSn70xZx/8/5sjtgQnrC

Hello!

Nice to see someone work on the Netronix EC :-)

On Sat, Dec 27, 2025 at 05:28:13PM +0100, Josua Mayer wrote:
> Implement a simple battery driver for monitoring voltage with the
> netronix embedded controller found in certain ebook readers.
>=20
> Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
> ---
>  drivers/mfd/ntxec.c                  |   1 +
>  drivers/power/supply/Kconfig         |   9 ++++
>  drivers/power/supply/Makefile        |   1 +
>  drivers/power/supply/ntxec-battery.c | 101 ++++++++++++++++++++++++++++=
+++++++
>  4 files changed, 112 insertions(+)
>=20
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index 08c68de0f01bc..d5059b8862aa8 100644
> --- a/drivers/mfd/ntxec.c
> +++ b/drivers/mfd/ntxec.c
> @@ -139,6 +139,7 @@ static const struct regmap_config regmap_config =3D =
{
>  static const struct mfd_cell ntxec_subdev[] =3D {
>  	{ .name =3D "ntxec-rtc" },
>  	{ .name =3D "ntxec-pwm" },
> +	{ .name =3D "ntxec-battery" },
>  };
> =20
>  static const struct mfd_cell ntxec_subdev_pwm[] =3D {
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 92f9f7aae92f2..5674a23ba7bd6 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -1132,4 +1132,13 @@ config FUEL_GAUGE_MM8013
>  	  the state of charge, temperature, cycle count, actual and design
>  	  capacity, etc.
> =20
> +config BATTERY_NTXEC
> +	tristate "Battery driver for Netronix embedded controller"
> +	depends on MFD_NTXEC
> +	help
> +	  Say yes here to enable netronix ec battery monitoring driver.
> +	  It enables the monitoring battery voltage on certain e-book readers
> +	  using an embedded controller by ODM Netronix. Battery design
> +	  characteristics are read from Firmware Tables if available.

What do you mean by Firmware Tables, and where does this happen?

(I guess it means devicetree/fwnode, but "git grep -i 'firmware tables'"
doesn't show many uses of that term)

> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefi=
le
> index 4b79d5abc49a7..db6fc815f9da2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
>  obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
>  obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o
>  obj-$(CONFIG_FUEL_GAUGE_MM8013)	+=3D mm8013.o
> +obj-$(CONFIG_BATTERY_NTXEC)	+=3D ntxec-battery.o
> diff --git a/drivers/power/supply/ntxec-battery.c b/drivers/power/supply=
/ntxec-battery.c
> new file mode 100644
> index 0000000000000..f49f0966d18dd
> --- /dev/null
> +++ b/drivers/power/supply/ntxec-battery.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the original design manufacturer Netronix=
, Inc.
> + * It contains RTC, battery monitoring, system power management, and PW=
M
> + * functionality.
> + *
> + * This driver implements battery monitoring.
> + *
> + * Copyright 2021 Josua Mayer <josua.mayer@jm0.eu>
> + */
> +
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +static const enum power_supply_property ntxec_battery_properties[] =3D =
{
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +struct ntxec_battery {
> +	struct ntxec *ec;
> +};
> +
> +#define NTXEC_REG_READ_BATTERY	0x41
> +
> +static int ntxec_battery_get_property(struct power_supply *psy,
> +				     enum power_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +	struct ntxec_battery *priv =3D power_supply_get_drvdata(psy);
> +	int ret;
> +	unsigned int value;
> +
> +	switch (psp) {
> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +			ret =3D regmap_read(priv->ec->regmap, NTXEC_REG_READ_BATTERY, &value=
);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* ec value to microvolt conversion:
> +			 * vendor kernel source suggests linear behaviour from 3V to 4.2V
> +			 * with readings 767 to 1023; each increment represents 4687,5uV.
> +			 * adjust 3V boundary slightly to report exactly 4.2V when full.
> +			 */
> +			val->intval =3D 2999872 + (value - 767) * 4688;
> +			break;
> +		default:
> +			dev_err(&psy->dev, "%s: invalid property %u\n", __func__, psp);
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct power_supply_desc ntxec_battery_desc =3D {
> +	.name =3D "ec-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D ntxec_battery_properties,
> +	.get_property =3D ntxec_battery_get_property,
> +	.num_properties =3D ARRAY_SIZE(ntxec_battery_properties),
> +};
> +
> +static int ntxec_battery_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ntxec *ec =3D dev_get_drvdata(dev->parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	struct ntxec_battery *priv;
> +	struct power_supply *psy;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->ec =3D ec;
> +	psy_cfg.drv_data =3D priv;
> +	psy_cfg.fwnode =3D dev_fwnode(dev->parent);
> +	psy_cfg.no_wakeup_source =3D true;
> +	psy =3D devm_power_supply_register(dev, &ntxec_battery_desc, &psy_cfg)=
;
> +	if (IS_ERR(psy))
> +		return PTR_ERR(psy);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ntxec_battery_driver =3D {
> +	.driver =3D {
> +		.name =3D "ntxec-battery",
> +	},
> +	.probe =3D ntxec_battery_probe,
> +};
> +module_platform_driver(ntxec_battery_driver);
> +
> +MODULE_AUTHOR("Josua Mayer <josua.mayer@jm0.eu>");
> +MODULE_DESCRIPTION("Battery driver for Netronix EC");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ntxec-battery");

Thanks,
J. Neusch=C3=A4fer


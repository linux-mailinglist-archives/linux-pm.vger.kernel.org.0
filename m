Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7F10DA07
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK2TKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 14:10:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK2TKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 14:10:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AE433291EAE
Received: by earth.universe (Postfix, from userid 1000)
        id BC5753C0C71; Fri, 29 Nov 2019 15:03:09 +0100 (CET)
Date:   Fri, 29 Nov 2019 15:03:09 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Subject: Re: [PATCH 2/2] power/supply: Add generic USB charger driver
Message-ID: <20191129140309.ae4urya6f2hussxn@earth.universe>
References: <20191103220801.10666-1-paul@crapouillou.net>
 <20191103220801.10666-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajdzh3ywfjytgnd"
Content-Disposition: inline
In-Reply-To: <20191103220801.10666-2-paul@crapouillou.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bajdzh3ywfjytgnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, Nov 03, 2019 at 11:08:01PM +0100, Paul Cercueil wrote:
> This simple charger driver uses the USB PHY framework to detect the
> presence of a charger.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/power/supply/Kconfig               |   7 ++
>  drivers/power/supply/Makefile              |   1 +
>  drivers/power/supply/generic-usb-charger.c | 140 +++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 drivers/power/supply/generic-usb-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index c84a7b1caeb6..069a91d89a42 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -51,6 +51,13 @@ config GENERIC_ADC_BATTERY
>  	  Say Y here to enable support for the generic battery driver
>  	  which uses IIO framework to read adc.
> =20
> +config GENERIC_USB_CHARGER
> +	tristate "Generic USB charger"
> +	depends on USB_PHY
> +	help
> +	  Say Y here to enable a generic USB charger driver which uses
> +	  the USB PHY framework to detect the presence of the charger.
> +
>  config MAX8925_POWER
>  	tristate "MAX8925 battery charger support"
>  	depends on MFD_MAX8925
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 6c7da920ea83..03f9b553bdfc 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -8,6 +8,7 @@ power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_le=
ds.o
>  obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
>  obj-$(CONFIG_POWER_SUPPLY_HWMON) +=3D power_supply_hwmon.o
>  obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
> +obj-$(CONFIG_GENERIC_USB_CHARGER)	+=3D generic-usb-charger.o
> =20
>  obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>  obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
> diff --git a/drivers/power/supply/generic-usb-charger.c b/drivers/power/s=
upply/generic-usb-charger.c
> new file mode 100644
> index 000000000000..d005acfc33c7
> --- /dev/null
> +++ b/drivers/power/supply/generic-usb-charger.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple USB charger driver
> + * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/usb/phy.h>

Missing <linux/of.h> for of_match_ptr()

> +
> +struct usb_charger {
> +	struct usb_phy *phy;
> +	struct notifier_block nb;
> +	struct power_supply_desc desc;
> +	struct power_supply *charger;
> +};
> +
> +static enum power_supply_property usb_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static int usb_charger_get_property(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct usb_charger *charger =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D charger->phy->chg_state =3D=3D USB_CHARGER_PRESENT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int usb_charger_event(struct notifier_block *nb,
> +			     unsigned long event, void *d)
> +{
> +	struct usb_charger *charger =3D container_of(nb, struct usb_charger, nb=
);
> +
> +	power_supply_changed(charger->charger);
> +
> +	return 0;
> +}
> +
> +static int usb_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct power_supply_desc *desc;
> +	struct usb_charger *charger;
> +	struct power_supply_config cfg =3D {
> +		.of_node =3D dev->of_node,
> +	};
> +	int err;
> +
> +	charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, charger);
> +	charger->nb.notifier_call =3D usb_charger_event;
> +	cfg.drv_data =3D charger;
> +
> +	if (dev->of_node)
> +		charger->phy =3D devm_usb_get_phy_by_phandle(dev, "phys", 0);
> +	else
> +		charger->phy =3D devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +	if (IS_ERR(charger->phy)) {
> +		err =3D PTR_ERR(charger->phy);
> +		if (err !=3D -EPROBE_DEFER)
> +			dev_err(dev, "No transceiver configured");
> +		return err;
> +	}
> +
> +	desc =3D &charger->desc;
> +	desc->name =3D "usb-charger";
> +	desc->properties =3D usb_charger_properties;
> +	desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
> +	desc->get_property =3D usb_charger_get_property;
> +
> +	switch (charger->phy->chg_type) {
> +	case SDP_TYPE:
> +		desc->type =3D POWER_SUPPLY_TYPE_USB;
> +		break;
> +	case DCP_TYPE:
> +		desc->type =3D POWER_SUPPLY_TYPE_USB_DCP;
> +		break;
> +	case CDP_TYPE:
> +		desc->type =3D POWER_SUPPLY_TYPE_USB_CDP;
> +		break;
> +	case ACA_TYPE:
> +		desc->type =3D POWER_SUPPLY_TYPE_USB_ACA;
> +		break;
> +	default:
> +		desc->type =3D POWER_SUPPLY_TYPE_UNKNOWN;
> +	}

This is deprecated in favour of the POWER_SUPPLY_PROP_USB_TYPE
property. Set desc->type to POWER_SUPPLY_TYPE_USB and have a
look at e.g. drivers/power/supply/cros_usbpd-charger.c to see
how POWER_SUPPLY_PROP_USB_TYPE is supposed to work.

> +	charger->charger =3D devm_power_supply_register(dev, desc, &cfg);
> +	if (IS_ERR(charger->charger)) {
> +		dev_err(dev, "Unable to register charger");
> +		return PTR_ERR(charger->charger);
> +	}
> +
> +	return usb_register_notifier(charger->phy, &charger->nb);

Please register with devm_add_action_or_reset() or (better)
create a devm_usb_register_notifier().

> +}
> +
> +static int usb_charger_remove(struct platform_device *pdev)
> +{
> +	struct usb_charger *charger =3D platform_get_drvdata(pdev);
> +
> +	usb_unregister_notifier(charger->phy, &charger->nb);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id usb_charger_of_match[] =3D {
> +	{ .compatible =3D "usb-charger" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, usb_charger_of_match);
> +#endif
> +
> +static struct platform_driver usb_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "usb-charger",
> +		.of_match_table =3D of_match_ptr(usb_charger_of_match),
> +	},
> +	.probe =3D usb_charger_probe,
> +	.remove =3D usb_charger_remove,
> +};
> +module_platform_driver(usb_charger_driver);
> +
> +MODULE_DESCRIPTION("Simple USB charger driver");
> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_LICENSE("GPL");

-- Sebastian

--bajdzh3ywfjytgnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3hJRoACgkQ2O7X88g7
+ppwUQ//S4fkfoZcxF+Bd69hJM9WCajnDkVjzSK6kRqpi7HFltSP4bRf9p/3uLdk
p9tB0afL5DHlQ8f4+dMBkaFA+47L1G4fuHojEYwsTpj3ClAvUNbbH4RwCko3GBwH
9LglJrav6t0l8rrQ6gCHgjzVyCvILN8YDdNUI2DSBIzgEi2iNjz2q6gryHD15YMe
k95eDRTuDBCyEWL50sQBM3iDhFMwoNhauPJ+c5KlmlOCt32kEk0Ng+dqPLkjBRWD
RwgeQawiHduZJpKAWX3q27dVORcSVwPKfQ85tkkjjsbJ1SUzVFQsNRdcvAZrgb/y
DTT8KfE0YlU7EfNKfD7ZYHgCVQgCAz3yqjIjU3xHuwu5P29S7sIqS27apKLYrKH3
5+XLpaN2fu1W5QzjXCJ8AfMKU/HTgDY1zBAGvmFtNNlQLXMKrBcZ1oBWUdKoqkQo
4sf7jqxvrKq/+x4BkJXTHKZT2bnXa68PdZCixSyOQ9fM7ha4lmo66q1zsHzCyJb9
8bEQnWBnEBBYdyLNFjAfNBPa+3Jzi3OZQske88pf4ntO2336rqL3/JoNfWYqVejj
3S6PM/By/lCnlXMOTTAQ9Keip37YigpNB5PHstJ1TU9XxRLkH9l/PuKdbuR9vOnm
bmTNcGlSd62X3+I4+R6+Czrs8Bc6AUJ2Gyb/bFsT1wz1HJO01R0=
=k+8E
-----END PGP SIGNATURE-----

--bajdzh3ywfjytgnd--

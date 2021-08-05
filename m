Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D03E1996
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhHEQcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhHEQb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 12:31:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E0C061798;
        Thu,  5 Aug 2021 09:31:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E94D71F442B1
Received: by earth.universe (Postfix, from userid 1000)
        id 5B0B43C0C9B; Thu,  5 Aug 2021 18:31:36 +0200 (CEST)
Date:   Thu, 5 Aug 2021 18:31:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ting Wang <zxc52fgh@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: Re: [PATCH v11 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20210805163136.mh3kx2fspvk6llwi@earth.universe>
References: <cover.1627992564.git.wangting11@xiaomi.com>
 <0d7753ae1e908f38a650eb6565de65f9f7c56e28.1627992564.git.wangting11@xiaomi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqnspqk2tyfcoueo"
Content-Disposition: inline
In-Reply-To: <0d7753ae1e908f38a650eb6565de65f9f7c56e28.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--aqnspqk2tyfcoueo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 04, 2021 at 07:01:58PM +0800, Ting Wang wrote:
> From: wangting11 <wangting11@xiaomi.com>
>=20
> Reports the kind of quick charge type based on
> different adapter power.
>=20
> Signed-off-by: wangting11 <wangting11@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 21 ++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/qcom_smbb.c            | 81 ++++++++++++++++++++-
>  include/linux/power_supply.h                | 14 ++++
>  4 files changed, 116 insertions(+), 1 deletion(-)

The patch description is wrong. This does not just add the quick
charge type to power-supply-core, but also enables the feature for
the qcom_smbb driver. This should be two patches!

> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index ca830c6cd809..a49e1049cd9b 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -736,3 +736,24 @@ Description:
> =20
>  		Access: Read
>  		Valid values: 1-31
> +
> +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +		Description:
> +		Reports the kind of quick charge type based on different adapter power.
> +		Different quick charge type represent different charging power.
> +		QUICK_CHARGE_NORMAL : Charging Power <=3D 10W
> +		QUICK_CHARGE_FAST : 10W < Charging Power <=3D 20W
> +		QUICK_CHARGE_FLASH : 20W < Charging Power <=3D 30W
> +		QUICK_CHARGE_TURBE : 30W < Charging Power <=3D 50W
> +		QUICK_CHARGE_SUPER : Charging Power > 50W

Where do these names come from? I never heard of them before (apart
=66rom this patch series) and cannot find them when doing a quick web
search. It looks like you only use it to map USB type to current, so
can this just be dropped from public API and handled within the
Qualcomm driver?

> +
> +		Access: Read-Only
> +		Valid values:
> +			0: QUICK_CHARGE_NORMAL,
> +			1: QUICK_CHARGE_FAST,
> +			2: QUICK_CHARGE_FLASH,
> +			3: QUICK_CHARGE_TURBE,
> +			4: QUICK_CHARGE_SUPER.
> +
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c3d7cbcd4fad..21f0ab748e5e 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -211,6 +211,7 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(MODEL_NAME),
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
>  	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
> +	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
>  };
> =20
>  static struct attribute *
> diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom=
_smbb.c
> index c890e1cec720..21ddfa39f655 100644
> --- a/drivers/power/supply/qcom_smbb.c
> +++ b/drivers/power/supply/qcom_smbb.c
> @@ -90,6 +90,12 @@
>  #define STATUS_CHG_FAST		BIT(7) /* Fast charging */
>  #define STATUS_CHG_GONE		BIT(8) /* No charger is connected */
> =20
> +#define IMAX_NORMAL		2000000
> +#define IMAX_FAST		4000000
> +#define IMAX_FLASH		6000000
> +#define IMAX_TURBE		10000000
> +#define IMAX_SUPER		12000000
> +
>  enum smbb_attr {
>  	ATTR_BAT_ISAFE,
>  	ATTR_BAT_IMAX,
> @@ -111,6 +117,7 @@ struct smbb_charger {
> =20
>  	bool dc_disabled;
>  	bool jeita_ext_temp;
> +	bool pd_verifed;
>  	unsigned long status;
>  	struct mutex statlock;
> =20
> @@ -485,6 +492,58 @@ static const struct smbb_irq {
>  	{ "dc-valid", smbb_dc_valid_handler },
>  };
> =20
> +struct quick_charge {
> +	enum power_supply_type adap_type;
> +	enum power_supply_quick_charge_type adap_cap;
> +};
> +
> +static struct quick_charge adapter_cap[10] =3D {
> +	{ POWER_SUPPLY_TYPE_USB,		QUICK_CHARGE_NORMAL },
> +	{ POWER_SUPPLY_TYPE_USB_DCP,		QUICK_CHARGE_NORMAL },
> +	{ POWER_SUPPLY_TYPE_USB_CDP,		QUICK_CHARGE_NORMAL },
> +	{ POWER_SUPPLY_TYPE_USB_ACA,		QUICK_CHARGE_NORMAL },
> +	{ POWER_SUPPLY_TYPE_USB_FLOAT,		QUICK_CHARGE_NORMAL },
> +	{ POWER_SUPPLY_TYPE_USB_PD,		QUICK_CHARGE_FAST },
> +	{ POWER_SUPPLY_TYPE_USB_HVDCP,		QUICK_CHARGE_FAST },
> +	{ POWER_SUPPLY_TYPE_USB_HVDCP_3,	QUICK_CHARGE_FAST },
> +	{ POWER_SUPPLY_TYPE_USB_HVDCP_3P5,	QUICK_CHARGE_FAST },
> +	{0, 0},
> +};
> +
> +static int get_quick_charge_type(struct smbb_charger *chg)
> +{
> +	union power_supply_propval prop =3D {0, };
> +	int charger_type, rc;
> +	int i =3D 0;
> +
> +	rc =3D power_supply_get_property(chg->bat_psy,
> +			POWER_SUPPLY_PROP_STATUS, &prop);
> +	if (rc < 0)
> +		return rc;
> +	if (prop.intval =3D=3D POWER_SUPPLY_STATUS_DISCHARGING)
> +		return 0;
> +
> +	rc =3D power_supply_get_property(chg->usb_psy,
> +			POWER_SUPPLY_PROP_USB_TYPE, &prop);
> +	if (rc < 0)
> +		return rc;
> +	charger_type =3D prop.intval;
> +
> +	/* when pd adapter is authenticated successfully */
> +	if ((charger_type =3D=3D POWER_SUPPLY_TYPE_USB_PD) && chg->pd_verifed) {
> +		return QUICK_CHARGE_TURBE;
> +	}
> +
> +	while (adapter_cap[i].adap_type !=3D 0) {
> +		if (charger_type =3D=3D adapter_cap[i].adap_type) {
> +			return adapter_cap[i].adap_cap;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
>  static int smbb_usbin_get_property(struct power_supply *psy,
>  		enum power_supply_property psp,
>  		union power_supply_propval *val)
> @@ -505,6 +564,9 @@ static int smbb_usbin_get_property(struct power_suppl=
y *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
>  		val->intval =3D 2500000;
>  		break;
> +	case POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE:
> +		val->intval =3D get_quick_charge_type(chg);
> +		break;
>  	default:
>  		rc =3D -EINVAL;
>  		break;
> @@ -662,11 +724,27 @@ static int smbb_battery_set_property(struct power_s=
upply *psy,
>  		const union power_supply_propval *val)
>  {
>  	struct smbb_charger *chg =3D power_supply_get_drvdata(psy);
> +	int charger_type, bat_imax;
>  	int rc;
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
> -		rc =3D smbb_charger_attr_write(chg, ATTR_BAT_IMAX, val->intval);
> +		charger_type =3D get_quick_charge_type(chg);
> +		if (charger_type =3D=3D QUICK_CHARGE_NORMAL)
> +			bat_imax =3D IMAX_NORMAL;
> +		else if (charger_type =3D=3D QUICK_CHARGE_FAST)
> +			bat_imax =3D IMAX_FAST;
> +		else if (charger_type =3D=3D QUICK_CHARGE_FLASH)
> +			bat_imax =3D IMAX_FLASH;
> +		else if (charger_type =3D=3D QUICK_CHARGE_TURBE)
> +			bat_imax =3D IMAX_TURBE;
> +		else if (charger_type =3D=3D QUICK_CHARGE_SUPER)
> +			bat_imax =3D IMAX_SUPER;
> +		else
> +			bat_imax =3D IMAX_NORMAL;
> +
> +		bat_imax =3D min(val->intval, bat_imax);
> +		rc =3D smbb_charger_attr_write(chg, ATTR_BAT_IMAX, bat_imax);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
>  		rc =3D smbb_charger_attr_write(chg, ATTR_BAT_VMAX, val->intval);
> @@ -695,6 +773,7 @@ static enum power_supply_property smbb_charger_proper=
ties[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
>  };
> =20
>  static enum power_supply_property smbb_battery_properties[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index be203985ecdd..3dc3e53c5df1 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -171,6 +171,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
>  };
> =20
>  enum power_supply_type {
> @@ -187,6 +188,10 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
> +	POWER_SUPPLY_TYPE_USB_HVDCP,		/* High Voltage DCP */
> +	POWER_SUPPLY_TYPE_USB_HVDCP_3,		/* Efficient High Voltage DCP */
> +	POWER_SUPPLY_TYPE_USB_HVDCP_3P5,	/* Efficient High Voltage DCP */
> +	POWER_SUPPLY_TYPE_USB_FLOAT,		/* Floating charger */
>  };

USB chargers should set the type to POWER_SUPPLY_TYPE_USB and report
the exact type via POWER_SUPPLY_PROP_USB_TYPE instead, so you need
to expand 'enum power_supply_usb_type'.

-- Sebastian

>  enum power_supply_usb_type {
> @@ -202,6 +207,15 @@ enum power_supply_usb_type {
>  	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
> +enum power_supply_quick_charge_type {
> +	QUICK_CHARGE_NORMAL =3D 0,		/* Charging Power <=3D 10W */
> +	QUICK_CHARGE_FAST,			/* 10W < Charging Power <=3D 20W */
> +	QUICK_CHARGE_FLASH,			/* 20W < Charging Power <=3D 30W */
> +	QUICK_CHARGE_TURBE,			/* 30W < Charging Power <=3D 50W */
> +	QUICK_CHARGE_SUPER,			/* Charging Power > 50W */
> +	QUICK_CHARGE_MAX,
> +};
> +
>  enum power_supply_notifier_events {
>  	PSY_EVENT_PROP_CHANGED,
>  };
> --=20
> 2.17.1
>=20

--aqnspqk2tyfcoueo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMEmMACgkQ2O7X88g7
+ppavw//WPo1Avmrb3ibRiou+jbKdrexG56wfsBTF41JINIxQ8+LIkrDE6p5i1H8
HH5UPjjxfs+MdTYSEnJTu8OTGecxOmvsKlaD4uZYLDGoRt8sgUrBrnikoqKA5swm
X1OzXAyIHypBhoDimlBz67YOjo+D5kasDoaBNQqDfq3Oy1fo0PLrAu89+RFkfglY
TzM/EizqmyqbsMuvQK6rWdCLFqnN53dmdsYplfzJ2YLoB4qsXUPGPcJk/tLkx40s
Mi3pM6c8PF83FMWxRfrV9r05X5GbFMHuT2B23RAKmUtlBtf2h/jneIAChAy24aGP
ZA9LZkKMFeqa8U/CjgGmtzdMcCwu3v/rezocyRz8YIZ9kutB2JXJESilIgSt3n5N
kOGEAl8kl0CTuYqViSNnJBMSVcByblLW+q9/n/k9DZ2qd/GRjGqj8pZ1FBshg+i9
/tEH2aLzNQsqGmNLKQhxxd7khAIyBWHSlWgQRm7mT5tH/h2RRMlOjETtO/uZYF2X
+5HhVaR2X4Nldxj6ehVnPMTRKcB+ps6LJ98J9KS8mC9yTWHotg/w/YLcfKkF8+7H
1UVP0k6ywROnffA2isUNLmwDSLlshrA40jyqoGJ8jMyFWtcira+LiD8gHZe3SYPT
/Ktaz8kwm1dRQmvCeOOtH0ZYK8CAH0PiiSJ47tOPufEQLSnM2ZE=
=/YOX
-----END PGP SIGNATURE-----

--aqnspqk2tyfcoueo--

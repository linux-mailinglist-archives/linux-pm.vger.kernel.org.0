Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4891C21FC
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 02:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgEBAeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 20:34:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38820 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgEBAeR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 20:34:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C9BC32A1FD0
Received: by earth.universe (Postfix, from userid 1000)
        id C8A803C08C7; Sat,  2 May 2020 02:34:12 +0200 (CEST)
Date:   Sat, 2 May 2020 02:34:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mathew King <mathewk@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] power_supply: Use designated initializer for
 property text arrays
Message-ID: <20200502003412.gfyeu4g6acfp6ml7@earth.universe>
References: <20200424173533.48572-1-mathewk@chromium.org>
 <20200424173533.48572-3-mathewk@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfgnklgnjintgnx4"
Content-Disposition: inline
In-Reply-To: <20200424173533.48572-3-mathewk@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rfgnklgnjintgnx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 24, 2020 at 11:35:31AM -0600, Mathew King wrote:
> Use designated initializers for the sysfs power supply text values. This
> will help ensure that the text values are kept in sync with the enum
> values from power_supply.h.
>=20
> Signed-off-by: Mathew King <mathewk@chromium.org>
> ---

Thanks, looks good to me, but does not apply without the first patch
(or due to other changes in power-supply's for-next branch).

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 76 ++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index b579081599d7..328107589770 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -35,41 +35,87 @@ struct power_supply_attr {
>  }
> =20
>  static const char * const power_supply_type_text[] =3D {
> -	"Unknown", "Battery", "UPS", "Mains", "USB",
> -	"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> -	"USB_PD", "USB_PD_DRP", "BrickID"
> +	[POWER_SUPPLY_TYPE_UNKNOWN]		=3D "Unknown",
> +	[POWER_SUPPLY_TYPE_BATTERY]		=3D "Battery",
> +	[POWER_SUPPLY_TYPE_UPS]			=3D "UPS",
> +	[POWER_SUPPLY_TYPE_MAINS]		=3D "Mains",
> +	[POWER_SUPPLY_TYPE_USB]			=3D "USB",
> +	[POWER_SUPPLY_TYPE_USB_DCP]		=3D "USB_DCP",
> +	[POWER_SUPPLY_TYPE_USB_CDP]		=3D "USB_CDP",
> +	[POWER_SUPPLY_TYPE_USB_ACA]		=3D "USB_ACA",
> +	[POWER_SUPPLY_TYPE_USB_TYPE_C]		=3D "USB_C",
> +	[POWER_SUPPLY_TYPE_USB_PD]		=3D "USB_PD",
> +	[POWER_SUPPLY_TYPE_USB_PD_DRP]		=3D "USB_PD_DRP",
> +	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
>  };
> =20
> -static const char * const power_supply_usb_type_text[] =3D {
> -	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
> -	"PD", "PD_DRP", "PD_PPS", "BrickID"
> +static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> +	[POWER_SUPPLY_USB_TYPE_UNKNOWN]		=3D "Unknown",
> +	[POWER_SUPPLY_USB_TYPE_SDP]		=3D "SDP",
> +	[POWER_SUPPLY_USB_TYPE_DCP]		=3D "DCP",
> +	[POWER_SUPPLY_USB_TYPE_CDP]		=3D "CDP",
> +	[POWER_SUPPLY_USB_TYPE_ACA]		=3D "ACA",
> +	[POWER_SUPPLY_USB_TYPE_C]		=3D "C",
> +	[POWER_SUPPLY_USB_TYPE_PD]		=3D "PD",
> +	[POWER_SUPPLY_USB_TYPE_PD_DRP]		=3D "PD_DRP",
> +	[POWER_SUPPLY_USB_TYPE_PD_PPS]		=3D "PD_PPS",
> +	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
>  };
> =20
>  static const char * const power_supply_status_text[] =3D {
> -	"Unknown", "Charging", "Discharging", "Not charging", "Full"
> +	[POWER_SUPPLY_STATUS_UNKNOWN]		=3D "Unknown",
> +	[POWER_SUPPLY_STATUS_CHARGING]		=3D "Charging",
> +	[POWER_SUPPLY_STATUS_DISCHARGING]	=3D "Discharging",
> +	[POWER_SUPPLY_STATUS_NOT_CHARGING]	=3D "Not charging",
> +	[POWER_SUPPLY_STATUS_FULL]		=3D "Full",
>  };
> =20
>  static const char * const power_supply_charge_type_text[] =3D {
> -	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
> +	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	=3D "Unknown",
> +	[POWER_SUPPLY_CHARGE_TYPE_NONE]		=3D "N/A",
> +	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	=3D "Trickle",
> +	[POWER_SUPPLY_CHARGE_TYPE_FAST]		=3D "Fast",
> +	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	=3D "Standard",
> +	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
> +	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
>  };
> =20
>  static const char * const power_supply_health_text[] =3D {
> -	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
> -	"Unspecified failure", "Cold", "Watchdog timer expire",
> -	"Safety timer expire", "Over current"
> +	[POWER_SUPPLY_HEALTH_UNKNOWN]		    =3D "Unknown",
> +	[POWER_SUPPLY_HEALTH_GOOD]		    =3D "Good",
> +	[POWER_SUPPLY_HEALTH_OVERHEAT]		    =3D "Overheat",
> +	[POWER_SUPPLY_HEALTH_DEAD]		    =3D "Dead",
> +	[POWER_SUPPLY_HEALTH_OVERVOLTAGE]	    =3D "Over voltage",
> +	[POWER_SUPPLY_HEALTH_UNSPEC_FAILURE]	    =3D "Unspecified failure",
> +	[POWER_SUPPLY_HEALTH_COLD]		    =3D "Cold",
> +	[POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE] =3D "Watchdog timer expire",
> +	[POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE]   =3D "Safety timer expire",
> +	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    =3D "Over current",
>  };
> =20
>  static const char * const power_supply_technology_text[] =3D {
> -	"Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe", "NiCd",
> -	"LiMn"
> +	[POWER_SUPPLY_TECHNOLOGY_UNKNOWN]	=3D "Unknown",
> +	[POWER_SUPPLY_TECHNOLOGY_NiMH]		=3D "NiMH",
> +	[POWER_SUPPLY_TECHNOLOGY_LION]		=3D "Li-ion",
> +	[POWER_SUPPLY_TECHNOLOGY_LIPO]		=3D "Li-poly",
> +	[POWER_SUPPLY_TECHNOLOGY_LiFe]		=3D "LiFe",
> +	[POWER_SUPPLY_TECHNOLOGY_NiCd]		=3D "NiCd",
> +	[POWER_SUPPLY_TECHNOLOGY_LiMn]		=3D "LiMn",
>  };
> =20
>  static const char * const power_supply_capacity_level_text[] =3D {
> -	"Unknown", "Critical", "Low", "Normal", "High", "Full"
> +	[POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN]	=3D "Unknown",
> +	[POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL]	=3D "Critical",
> +	[POWER_SUPPLY_CAPACITY_LEVEL_LOW]	=3D "Low",
> +	[POWER_SUPPLY_CAPACITY_LEVEL_NORMAL]	=3D "Normal",
> +	[POWER_SUPPLY_CAPACITY_LEVEL_HIGH]	=3D "High",
> +	[POWER_SUPPLY_CAPACITY_LEVEL_FULL]	=3D "Full",
>  };
> =20
>  static const char * const power_supply_scope_text[] =3D {
> -	"Unknown", "System", "Device"
> +	[POWER_SUPPLY_SCOPE_UNKNOWN]	=3D "Unknown",
> +	[POWER_SUPPLY_SCOPE_SYSTEM]	=3D "System",
> +	[POWER_SUPPLY_SCOPE_DEVICE]	=3D "Device",
>  };
> =20
>  static struct power_supply_attr power_supply_attrs[] =3D {
> --=20
> 2.26.2.303.gf8c07b1a785-goog
>=20

--rfgnklgnjintgnx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6swAQACgkQ2O7X88g7
+poA7BAAoAYgVtLJEK4TuQIcPgYikzbN/ODvqAVJc124KXcyFbHhf8jFNx0fj0aN
chw336oN7ZTpm8cCaJLZoaCwXi7002D/szoQLNqWgJIRkAc6Bf+kxUllPZqgmkMw
ArFpNyen/iKHkHTPOS1bIJSjytG1ZR/WDGdiT6ISwTE7sU2Z0LjiWelOoKVN7oFS
/U6LKyPxjXqh9kkDKP6HFRioqHfvye7t4Fa3iPZJVrktryGNQA4idLoDMGSnGx20
3QSZs/BDwUcETEUQS0xgmHlaSRm7Ov8TghsMkQ2ohu4OSoK/VttbrUl+iRxdA6E4
ivc947hwfr5vyXAyvXVagmK83CUVg3EG+egMhMdAnriXVYv3uUpB3Q4T5UtuJG0j
8yYwyDzYg4jvcPi2B5ymlNejPe4mjvIEyDg1toYNClMMxG92UWTzuGkMksgp4aTD
Grgl/+V3QUXW0t/VGkz0w6NDV49Ex4qCYBUtiN2tBKbC/HWiYm3L43xhIPlR7fxW
oRAsOsCRNkoN6BbSGDk7O7qo0Ft31J/qYnhwsyinqiN7auaGJlYM4bk/1WL9DwCX
Ype0Sp6EYfN/UX+DOltWNI3k2sx3bt7ztyf/JsCYI4CPgcxJ5Znx+oDAbcAu7VHw
xMCNlROHuxFUyk9Sj0/xTa4VbvQJq4weGEDToB4Adg0DT2g2gek=
=UdVL
-----END PGP SIGNATURE-----

--rfgnklgnjintgnx4--

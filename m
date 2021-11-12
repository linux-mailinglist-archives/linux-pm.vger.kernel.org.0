Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4148C44EC7A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 19:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhKLSNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 13:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKLSNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 13:13:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D94C061766;
        Fri, 12 Nov 2021 10:10:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 32A6E1F469D8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636740645; bh=85FVMl3g8AFx7K6/SNFfbacSsCp+0ar+O3UGJFm0kGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoUucfWsw02yRnc74nEfHMokcWTmdjto+Q+lIFlmDdcH5Olj2yrHar9AQ46H85lXv
         eNvx6weY65ST8xcN69QZnv1Zt2cluoNmuV6Y3stfYOsoQYr2IssugVOG5taWb2lVng
         kEHyhjYupXf0ZhLgMUX+rW6oI08oLY3BXzS5fHkXLwJngYg6HG1ZyvRmT81aR2PC6P
         greE5qWSEuhGYMEe3lSM96ck5rGOqoaTXMZloUgXkBKcYlb0ZAzDAsNZSGOaXvYhci
         sBZpGr1EAIixIBFPcyeDXLisItw3AozZ9mYjFHYOebRA0TO8VhsIqvivB5d+GDg+25
         qqz8OPUoKJQ2g==
Received: by earth.universe (Postfix, from userid 1000)
        id BB4703C0F95; Fri, 12 Nov 2021 19:10:42 +0100 (CET)
Date:   Fri, 12 Nov 2021 19:10:42 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, nicolopiazzalunga@gmail.com,
        linrunner@gmx.net, platform-driver-x86@vger.kernel.org,
        smclt30p@gmail.com
Subject: Re: [RFC v2] standardized attributes for powersupply charge behaviour
Message-ID: <20211112181042.jk63p5dm2ty3kxd5@earth.universe>
References: <20211108192852.357473-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gdkoi7vapq7cgty"
Content-Disposition: inline
In-Reply-To: <20211108192852.357473-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5gdkoi7vapq7cgty
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 08, 2021 at 08:28:52PM +0100, Thomas Wei=DFschuh wrote:
> This a revised version of
> "[RFC] add standardized attributes for force_discharge and inhibit_charge=
" [0],
> incorporating discussion results.
>=20
> The biggest change is the switch from two boolean attributes to a single
> enum attribute.
>=20
> [0] https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c=
2fec29983d1@gmail.com/
> ---
>  Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  7 +++++++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index ca830c6cd809..2f58cfc91420 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -455,6 +455,20 @@ Description:
>  			      "Unknown", "Charging", "Discharging",
>  			      "Not charging", "Full"
> =20
> +What:		/sys/class/power_supply/<supply_name>/charge_behaviour
> +Date:		November 2021
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents the charging behaviour.
> +
> +		Access: Read, Write
> +
> +		Valid values:
> +			=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +			auto:            Charge normally, respect thresholds
> +			inhibit-charge:  Do not charge while AC is attached
> +			force-discharge: Force discharge while AC is attached
> +
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c3d7cbcd4fad..26c60587dca1 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -172,6 +172,7 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> +	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),

this is missing (and should not compile without it):

static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] =3D { ... };

Otherwise LGTM. But you need to send API changes with an API user (i.e. the
patch updating acpi battery driver using this).

-- Sebastian

> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..70c333e86293 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -132,6 +132,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
> @@ -202,6 +203,12 @@ enum power_supply_usb_type {
>  	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
> +enum power_supply_charge_behaviour {
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO =3D 0,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
> +};
> +
>  enum power_supply_notifier_events {
>  	PSY_EVENT_PROP_CHANGED,
>  };
>=20
> base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
> --=20
> 2.33.1
>=20

--5gdkoi7vapq7cgty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGOrhkACgkQ2O7X88g7
+ppIzA//dU4xr70DB3Hf7a51yOvCJp/8wAq4sv3LDbdH9VCYpLJUJjPIhfRrvF35
LLoReo1khkCo953xglWSP2kopFmBIDs8fPQ6yFqHZfnuK8Wl/9MmEgK+X7i916L2
p2rLPqbvsSDoVEGqPY6Q5/cSBYgC+gKNBhirLOMe+9F9UfcJiQUzANXpOY5yRKiA
NIu81oLuVme7eMnFuVm+rPuPQjENZGqZxhkyolS+fsaInF6nkq2WfYxa2+dhqten
JSzXWIs98jWywf9zeZNYPaOQsmBbpSv8wVh6KKOYof53/7aunNMqjoNqZpGbVSd1
umi83KJHlsyts01pRHNCIc4/wwP2z+giQ2PhGS4z4SUc94C1cPwkvb9pSuInkbzb
RDW0VRsQG6q7SNaEVEXXkikjcGh0qlYat+hvu6jZ6bfwZMqGaz7o63EsXxPuFMbT
c8kr87ay4OJvkjfsSUiGYOZk28D9+qUc/BlRJYxR6E0F7jOfq9NXfOnRcV4WJWcL
F1ePyB3wtxUsikGx4vLqw6bYbeV/dn/cxZ+w3EzTDLPasX0VgpzBfakRqjnzd0HZ
GfONpAADOq6qql0bHeLYjDIGB2rupQZUuZlOKwUY4aC7+UycJjAGm4vVyGWLtLfg
nehQp+lPPCbORslqveIQnNh/5+Fc8Q/h+HwzkVvGFCf8vllgBpI=
=js4S
-----END PGP SIGNATURE-----

--5gdkoi7vapq7cgty--

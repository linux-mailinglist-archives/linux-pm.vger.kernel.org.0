Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF03E3168
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbhHFVvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbhHFVvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:51:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98068C0613CF;
        Fri,  6 Aug 2021 14:50:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 867F21F4088D
Received: by earth.universe (Postfix, from userid 1000)
        id 925243C0C99; Fri,  6 Aug 2021 23:50:50 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:50:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: sbs-battery: add support for
 time_to_empty_now attribute
Message-ID: <20210806215050.3pgcqwtcsg22de7c@earth.universe>
References: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
 <7238b56cca93c8101288b069fd044024da81db1f.1626678985.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2sjvvldoig5bjkfm"
Content-Disposition: inline
In-Reply-To: <7238b56cca93c8101288b069fd044024da81db1f.1626678985.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2sjvvldoig5bjkfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 19, 2021 at 09:20:19AM +0200, Matthias Schiffer wrote:
> As defined by the Smart Battery Data Specification.
>=20
> An _AVG suffix is added to the enum values REG_TIME_TO_EMPTY and
> REG_TIME_TO_FULL to make the distinction clear.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 3d6b8247d450..c4a95b01463a 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -31,8 +31,9 @@ enum {
>  	REG_CURRENT_AVG,
>  	REG_MAX_ERR,
>  	REG_CAPACITY,
> -	REG_TIME_TO_EMPTY,
> -	REG_TIME_TO_FULL,
> +	REG_TIME_TO_EMPTY_NOW,
> +	REG_TIME_TO_EMPTY_AVG,
> +	REG_TIME_TO_FULL_AVG,
>  	REG_STATUS,
>  	REG_CAPACITY_LEVEL,
>  	REG_CYCLE_COUNT,
> @@ -119,9 +120,11 @@ static const struct chip_data {
>  		SBS_DATA(POWER_SUPPLY_PROP_ENERGY_FULL, 0x10, 0, 65535),
>  	[REG_FULL_CHARGE_CAPACITY_CHARGE] =3D
>  		SBS_DATA(POWER_SUPPLY_PROP_CHARGE_FULL, 0x10, 0, 65535),
> -	[REG_TIME_TO_EMPTY] =3D
> +	[REG_TIME_TO_EMPTY_NOW] =3D
> +		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, 0x11, 0, 65535),
> +	[REG_TIME_TO_EMPTY_AVG] =3D
>  		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, 0x12, 0, 65535),
> -	[REG_TIME_TO_FULL] =3D
> +	[REG_TIME_TO_FULL_AVG] =3D
>  		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG, 0x13, 0, 65535),
>  	[REG_CHARGE_CURRENT] =3D
>  		SBS_DATA(POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX, 0x14, 0, 65535=
),
> @@ -165,6 +168,7 @@ static const enum power_supply_property sbs_propertie=
s[] =3D {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN,
>  	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> @@ -748,6 +752,7 @@ static void  sbs_unit_adjustment(struct i2c_client *c=
lient,
>  		val->intval -=3D TEMP_KELVIN_TO_CELSIUS;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>  		/* sbs provides time to empty and time to full in minutes.
> @@ -966,6 +971,7 @@ static int sbs_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>  	case POWER_SUPPLY_PROP_TEMP:
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> --=20
> 2.17.1
>=20

--2sjvvldoig5bjkfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENrroACgkQ2O7X88g7
+prZSA//XvPKJzAPD+EW+Q59E8R4i9DnilFbRVN8L6YWeCu2cKMwIE3vKm+CBl0f
BsJVfbOY+KG8ZTx4f3F4jA2P0fOX49gDeh7BrGu3yWbMFshP8lF5ZnkYT5ITcSxB
h7hZWftbZIP+46StFwqxhq4cPauEyRJhZEjphyj8xDNdRsrtLzgEcXCspDTXtymD
iZRBN+BfYfhEKpbO7IJxvzqbFox4aOp/DGv4XUZIwed57KXChDCga0Ri+u5d3PqM
MAJO2KmUzw3dO3d1V15nHKuo8O6WZDUH3mta1RcXHE9Je7GTZvuxJ0THX3WXy9Ga
msRh1HmoR2KSRPzBfTpKYyv+ZXhNCU5B4ahy4eWwzocb7uXkAnmfQ78IljIgvV4T
yhHlHS8DFGpPsilqWLvgEz8SXEfa+09JrYAnJ9hgyjOLsSxeU8Vsv/B6La7hnESb
KKYFrS+2s/G213BXMYH1j0k0eTzxsBdvpxfymEnbWpe3JJSMFnOMvNq/QGngmSSN
+c9o1PW+8rpe2fl4o0dEpOPRGJDdyjkhuaCz/aMKAcRAk6cxyqahHj8lraZSxmj0
gNLhNQ54tCJGrL3gCB27rw2SkRgpU2fUbPUJmqSOihr14HO1LpPg46B9P4FUceMW
MbipmxfoDtQWOdBFCpxzoC/ii5fhlS+DvRmbz+U9gN1KCvxrHns=
=S2d7
-----END PGP SIGNATURE-----

--2sjvvldoig5bjkfm--

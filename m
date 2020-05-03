Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD91C2939
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 02:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgECAav (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 20:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgECAav (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 20:30:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB95C061A0C;
        Sat,  2 May 2020 17:30:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 33E402A26C5
Received: by earth.universe (Postfix, from userid 1000)
        id C515B3C08C7; Sun,  3 May 2020 02:30:47 +0200 (CEST)
Date:   Sun, 3 May 2020 02:30:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Sandeep Patil <sspatil@android.com>
Subject: Re: [PATCH v5 1/3] power_supply: Add additional health properties to
 the header
Message-ID: <20200503003047.3d3migz2fagmvfs6@earth.universe>
References: <20200501175118.26226-1-dmurphy@ti.com>
 <20200501175118.26226-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lanqkvysnjhf2eti"
Content-Disposition: inline
In-Reply-To: <20200501175118.26226-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lanqkvysnjhf2eti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 12:51:16PM -0500, Dan Murphy wrote:
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>=20
> Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

What is going on? Ricardo wrote, that he added the JEITA spec
reference to the commit message. I don't see it anywhere. Also
Sandeep Patil asked to be Cc'd in new versions of the patchset.

You do not need to list bq2515x as user, but patch will only be
taken together with the driver (or any other driver using the
properties in mainline kernel).

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 2 +-
>  include/linux/power_supply.h                | 3 +++
>  3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index bf3b48f022dc..9f3fd01a9373 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -190,7 +190,7 @@ Description:
>  		Valid values: "Unknown", "Good", "Overheat", "Dead",
>  			      "Over voltage", "Unspecified failure", "Cold",
>  			      "Watchdog timer expire", "Safety timer expire",
> -			      "Over current"
> +			      "Over current", "Warm", "Cool", "Hot"
> =20
>  What:		/sys/class/power_supply/<supply_name>/precharge_current
>  Date:		June 2017
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index f37ad4eae60b..d0d549611794 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -61,7 +61,7 @@ static const char * const power_supply_charge_type_text=
[] =3D {
>  static const char * const power_supply_health_text[] =3D {
>  	"Unknown", "Good", "Overheat", "Dead", "Over voltage",
>  	"Unspecified failure", "Cold", "Watchdog timer expire",
> -	"Safety timer expire", "Over current"
> +	"Safety timer expire", "Over current", "Warm", "Cool", "Hot"
>  };
> =20
>  static const char * const power_supply_technology_text[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index dcd5a71e6c67..8670e90c1d51 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -61,6 +61,9 @@ enum {
>  	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_OVERCURRENT,
> +	POWER_SUPPLY_HEALTH_WARM,
> +	POWER_SUPPLY_HEALTH_COOL,
> +	POWER_SUPPLY_HEALTH_HOT,
>  };
> =20
>  enum {
> --=20
> 2.25.1
>=20

--lanqkvysnjhf2eti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uELcACgkQ2O7X88g7
+poBAg//cG25BWxTZ1Jhdk6pjuTlBMR/sSCntUwxGOXzdBmLcj4TQZlEnDziy4GW
U+mrskZ4fIxvecOu+ai668lBzTeILHDRUn3Xi+cFDeRUbHhG5G8FCIiT+SNYenyl
LkvgL/AYu2j3kls8YpQQbcDxG9CcVcMhNldWikYTz8ivZwVI8FO9JALyWd8wXvxG
SdjmeyjIwdED+HdMvtpF8oAB+g3U/EDlvdm6FG9lYFWknSuyZGJvceY3sSCKUZED
QE+B3BNJIIOnyxQZP1SX5pzyslq1EMTvWKu5awYatHc722D2ykiTLvODOsgiywiv
3z5pUBHgpGNwsnRJ3ro/mgFP1Pwf2HBMItuh9pjMFGS77YJXqh2bDRUd5kqESeLX
lIOO9ay+vC3q+lCJlRlM9uy/3nCpEsmY/jsjOPKrRT9ON/ubb5p3z/daRL6B4Ys/
HoFF0AeKnvlVx7qfuPon6DANfxRmWrvNeA92MH2VpzpYwBmF8JP1ghOYyxC2mNqB
i4dOEp+M6Tvo1oHD2XN23fNHcQ/2zqcHutoB0B80f+vunhfo3JhQJqrvHqC81eWg
fVzP5EdDHfFBocsAC5M1RYn+02iTvYyc33MvsmTAII5VEH4Tb4/GrBiOsvX/K2C5
vc+MlTEZvgcdLIyUxdrjxQIVnc/0NnKf48DUM4vSc03XBjKoEZI=
=YrBL
-----END PGP SIGNATURE-----

--lanqkvysnjhf2eti--

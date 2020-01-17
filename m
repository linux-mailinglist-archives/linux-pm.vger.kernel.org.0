Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF6140151
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 02:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgAQBHF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 20:07:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34378 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAQBHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 20:07:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 87B9B293B0F
Received: by earth.universe (Postfix, from userid 1000)
        id 1FB333C0C7E; Fri, 17 Jan 2020 02:06:58 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:06:58 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power_supply: Add additional health properties to
 the header
Message-ID: <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kdlvwj377i73eeg5"
Content-Disposition: inline
In-Reply-To: <20200116175039.1317-3-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kdlvwj377i73eeg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Looks good. But I will not merge it without a user and have comments
for the driver.

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
> index 28413f737e7d..bd0d3225f245 100644
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
> 2.25.0
>=20

--kdlvwj377i73eeg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4hCLEACgkQ2O7X88g7
+poPXg//dnaOWoDkaO1V3Kr2uRw9WVXRibgSacmAic5CsZKpfYkBR/jfRfbOlEK6
ky16j7nMYUig8ODe3c2yiqLgsBWxOeUOUecuk9si1yJdEtjrQNKq//SGvosWTJ4H
pILFngukgR+l4wLuOH+fAtJ6lYyuo3652DvvZMYXriPwD8RzYPooq9Vl3ddqLg0Y
L3CBI1aMIwsvDbB2vg4utHroxmmqiQdvxk8yfzI/IPhxd9TAxdDzD1JLL2S1f4Dz
Icc4yQB8rE1oIoQDB6K0QjXvOQukWhBRF8mrnLOXey88vWBjMk6KDpo5t0pnZ3yJ
y9SL03s8CJ6a5Z2a8FDV8RzpHpccROtNnmTMZsiWp2Q0FuvaufmzoRl74AaEvPJz
cg5LMDyWY1FrOoY/d41lKsWfZnbwNbm6ncbIQsfnOMsCvMQwOv5dE5EBWx6R67mN
gVzwWLi3B5tu9sBKUMES9KOKZGK3LN5Q+v2xPXXLACNnTAlmiP9gRwiiVjlt+6kv
HR1W8EA8p71SVDMFNzOQ5TshfCTTZ4z9+c+xn79/pOe5W/Ug/fxhWyn9TIVu1aaa
3hgU0B/0PRnjNGQtbIF0wBDv/nALPQodz0CC9Yvrsqvq8fRC3PZ94WiGc1htNbAI
c/XXa3sOFLeZgtZzehJwiGoj5NdBII03NG56Uk0WL9Lq57xlwEc=
=4oeG
-----END PGP SIGNATURE-----

--kdlvwj377i73eeg5--

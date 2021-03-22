Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD13446E4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCVOQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 10:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhCVOPk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 10:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 211176196C;
        Mon, 22 Mar 2021 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616422540;
        bh=93WXlItJ8lqDX08T3LRAf7u3umSeQGwbmE9sffV8Kvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9/bfmMZJbs94kuIc8V3LqfbMvyDeh+wfaGSqiB/iqZZ5w5mWykXkSSOU2mGsoSIo
         MWHcEiEHQr7Pu4rWekqjAQovd2c05LSlr0imuNLf1i/Kzf4+nQX4JGYByzVnxJaeZm
         +Yci9/n+HD/M98u2VpSHUSUKGLgv/Q2+c77rAtzUOKX9jNwt7Buuh5V9vOXnHyCCZG
         +sjx+fol6k5Jjfwye9ou7T149O2d4POH0xatMguoekUcOYROeAka3t2V795juy/39E
         7WiDKIfbn2waMx12VxQ+xJwjPT256El/92OSyNpgEf7ftGMDNJ2SrEoaBisV5MB71o
         EYtChkiH8p+VA==
Received: by earth.universe (Postfix, from userid 1000)
        id 248B23C0C96; Mon, 22 Mar 2021 15:15:38 +0100 (CET)
Date:   Mon, 22 Mar 2021 15:15:38 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] Rectify spelling
Message-ID: <20210322141538.imsggoeo3zhspwvz@earth.universe>
References: <20210311115735.1103-1-cxfcosmos@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psavtvaclubwuzp7"
Content-Disposition: inline
In-Reply-To: <20210311115735.1103-1-cxfcosmos@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--psavtvaclubwuzp7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 11, 2021 at 07:57:35PM +0800, Xiaofeng Cao wrote:
> Change  'stanalone'      to  'standalone'
> Change  'mesaurement'    to  'measurement'
> Change  'nonvilatile'    to  'nonvolatile'
> Change  'unical'         to  'unique'
> Change  'unaccesable'    to  'unaccessible'
> Change  'correcpondent'  to  'correspond'
>=20
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---

Thanks, queued. Please improve your patch subjects in the
future and use PATCHv2 instead of PATCH when sending a new
version.

-- Sebastian

>  drivers/power/supply/max1721x_battery.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supp=
ly/max1721x_battery.c
> index 1b1a36f8e929..473e53cd2801 100644
> --- a/drivers/power/supply/max1721x_battery.c
> +++ b/drivers/power/supply/max1721x_battery.c
> @@ -1,6 +1,6 @@
>  /*
>   * 1-Wire implementation for Maxim Semiconductor
> - * MAX7211/MAX17215 stanalone fuel gauge chip
> + * MAX7211/MAX17215 standalone fuel gauge chip
>   *
>   * Copyright (C) 2017 Radioavionica Corporation
>   * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
> @@ -28,7 +28,7 @@
>  /* Number of valid register addresses in W1 mode */
>  #define MAX1721X_MAX_REG_NR	0x1EF
> =20
> -/* Factory settings (nonvilatile registers) (W1 specific) */
> +/* Factory settings (nonvolatile registers) (W1 specific) */
>  #define MAX1721X_REG_NRSENSE	0x1CF	/* RSense in 10^-5 Ohm */
>  /* Strings */
>  #define MAX1721X_REG_MFG_STR	0x1CC
> @@ -105,7 +105,7 @@ static inline int max172xx_temperature_to_ps(unsigned=
 int reg)
>  /*
>   * Calculating current registers resolution:
>   *
> - * RSense stored in 10^-5 Ohm, so mesaurment voltage must be
> + * RSense stored in 10^-5 Ohm, so measurement voltage must be
>   * in 10^-11 Volts for get current in uA.
>   * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
>   * So: 102400 / 65535 * 10^5 =3D 156252
> @@ -137,7 +137,7 @@ static int max1721x_battery_get_property(struct power=
_supply *psy,
>  		/*
>  		 * POWER_SUPPLY_PROP_PRESENT will always readable via
>  		 * sysfs interface. Value return 0 if battery not
> -		 * present or unaccesable via W1.
> +		 * present or unaccessible via W1.
>  		 */
>  		val->intval =3D
>  			regmap_read(info->regmap, MAX172XX_REG_STATUS,
> @@ -334,9 +334,9 @@ static int devm_w1_max1721x_add_device(struct w1_slav=
e *sl)
> =20
>  	/*
>  	 * power_supply class battery name translated from W1 slave device
> -	 * unical ID (look like 26-0123456789AB) to "max1721x-0123456789AB\0"
> -	 * so, 26 (device family) correcpondent to max1721x devices.
> -	 * Device name still unical for any numbers connected devices.
> +	 * unique ID (look like 26-0123456789AB) to "max1721x-0123456789AB\0"
> +	 * so, 26 (device family) correspond to max1721x devices.
> +	 * Device name still unique for any number of connected devices.
>  	 */
>  	snprintf(info->name, sizeof(info->name),
>  		"max1721x-%012X", (unsigned int)sl->reg_num.id);
> --=20
> 2.25.1
>=20

--psavtvaclubwuzp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBYpokACgkQ2O7X88g7
+pokhQ/+Lq8EwwdzFEAQo+rqDxsreWv4Cpz7Nj17wMprOzYzPX7X4Jwc62MLZ78Y
zKk0Qc7tTa9FxPs75aLLPfOMPn1BYS87CCWzAoozp56ZJuqufemL32vd7MkabMHb
lmYw430hZh0hWbx+b+Quk4w348qd1xkb3ycZA1S7slE5mPyubf2gc1dpoz6FNUOK
Wws8S9xXwd0ijwSgP1eFBMseesvmzhicmR5x4eo3XIpkXsHq7B9FVwDNHM9x5Q3e
C1dAiqrvMWcBiq5OMgWlN44O/Yp166hdglQOE45U3JJ+ulRImOpXLRK8IdteG3BH
kiEWnCUQEGBgucJnELAwLWz4pgcW/6t0RvEiwOTIvm89ihizT0J6qrNHAmUAR8n/
JTOJ3TFoCuHVDhWfiM+qz+rXvA/PTi8e/lK2zBKmE7pYzZI7GC7bqS890VJRrBp1
TLkjHr1RkEkPjgI6R7JPmXRZJb5b6oE1SzhxpArPArJ3XogSPSy8aSY05DSOW/h8
WbtYz2BEZt5p0WnJaAXxssyuG9eayuoVqkW/1vhV5Ztta8Ir6WIBFBMOhx5z6Xng
KbFPJHNDxGy5WdVU3glb/82bYBh46N+NBEbL6H5PlyEqXOwg9mycUOiJpsGRpnGb
ZmNayBiqvusf7wzoGkrrdAjU/DHzDHWw1UyS+Zujv7pArEe27N4=
=oqgl
-----END PGP SIGNATURE-----

--psavtvaclubwuzp7--

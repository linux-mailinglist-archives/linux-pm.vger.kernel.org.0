Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26CDDE77
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 14:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfJTMnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 08:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJTMnm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 08:43:42 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98C921744;
        Sun, 20 Oct 2019 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571575421;
        bh=Mkt4V0ubKfu0vpl/nX8DPcWJKgzBgQDUxIY7+f3r7k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUj7Ga4ToHdEPVacR8j30ucKTOjDvGAuxGGoC/Yg5zfk3ID4ORDrMI2Wl9tKacB0z
         fcdP9S/x7lIzUM0lvKkbZEdslYexRTVy+AA/qLnM2WBKWqfxTWw9LcyKJ3R0mONym7
         6/ZGWNabsvZEOBKCqzgQnLRQ365sP00G3t3v39cE=
Received: by earth.universe (Postfix, from userid 1000)
        id 43D153C09B1; Sun, 20 Oct 2019 14:43:35 +0200 (CEST)
Date:   Sun, 20 Oct 2019 14:43:35 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: bq2515x: Introduce the bq2515x family
Message-ID: <20191020124335.gssoiyjmdtpygwqy@earth.universe>
References: <20190930143137.21624-1-dmurphy@ti.com>
 <20190930143137.21624-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pug62zvjsqlqwju4"
Content-Disposition: inline
In-Reply-To: <20190930143137.21624-3-dmurphy@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pug62zvjsqlqwju4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Here are some more notes.

On Mon, Sep 30, 2019 at 09:31:37AM -0500, Dan Murphy wrote:
> Introduce the bq25150 and bq25155 supply chargers.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

[...]

> +/* initial field values, converted to register values */
> +struct bq2515x_init_data {
> +	u8 ichg;	/* charge current		*/
> +	u8 vreg;	/* regulation voltage		*/

The following 4 entries seem to be unused.

> +	u8 iterm;	/* termination current		*/
> +	u8 iprechg;	/* precharge current		*/
> +	u8 sysvmin;	/* minimum system voltage limit */
> +	u8 ilim;	/* ILIM current contol		*/
> +};

[...]

> +static int get_const_charge_current(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int intval;
> +	int iin_msb;
> +	int iin_lsb;
> +	u16 ichg_measurement;
> +	int ilim_val, ichg_multiplier;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		return -ENODATA;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_IIN_M, &iin_msb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_IIN_L, &iin_lsb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ichg_measurement =3D (iin_msb << 8) | iin_lsb;
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ILIMCTRL, &ilim_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ilim_val >=3D BQ2515X_ILIM_150MA)
> +		ichg_multiplier =3D 350;
> +	else
> +		ichg_multiplier =3D 750;
> +
> +	intval =3D (ichg_measurement * 100 / BQ2515X_DIVISOR) * ichg_multiplier;
> +	return intval / 100;
> +}
> [...]

I just checked the calculation and you return mA. This is incorrect,
since the power-supply ABI uses =B5A. Please also re-check the other
calculations. You can find some information about the power-supply
subsystem here:

Documentation/power/power_supply_class.rst

-- Sebastian

--pug62zvjsqlqwju4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sVnQACgkQ2O7X88g7
+poKkQ//Ul4FyYqJe7GL08pax4RATZxfc9jZlRJqwfOfzHzwZlDSG9VAIP/IqySU
DMZ3uD1qbjNpJYzGzvDJ4Wtr6n0nwoaiGRMnzgEzWNXRjF+mZMTZX/PyZZ2Kvnww
G4xdqz5QgcdVnvdy52qYTlM0f7YKKFdvHKSmEtQCsGTEU0/A9K3bibpAttyCYQGU
Z/LbuuWJfIYCPBi3oYktvO0mtRmD8rK991EeihVuThJ8urtg60/UjQPfgVtBJ9Nz
LNf8dNe/cOS5pKyzrKCr7/5yalLlt5ekAX1INwS3roML6agn+EunkZ/gtE2gxotx
6xG132LE/0o5S/3P10ghlAdb0gVNxSMvA48FA96A4slKgO5W8potHCiR2n56Sedk
MiM6jTyXSjK1c3c7SxJM1B7lsFA+Sr2TDGBdoT6QIzisTo1LlpIbYa6dDavEPLbZ
HrST846Pw7LBPfQzbUI9g+OGJx1n6GHsQLN/MSs/MsVxufl5S5xAbLehwMdae+Ir
3Z2M3uSgtC8v5vpBccHCutfgnd/pYhPeX1hvOQIv2CHQfPBTk6jwb3BMR/bO4GU/
7+x1a/Bsak2jOis2hXQi0QoWP4jjBh1venLqt2QtWxKGCR1zejd3/9wU52rS9x7/
KO7JXiraWHwxCPGdSLL7tJkppc4c8zN4CoYNgR3eFpnrwXKQjsE=
=8M8k
-----END PGP SIGNATURE-----

--pug62zvjsqlqwju4--

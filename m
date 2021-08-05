Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8B3E190D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbhHEQEe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 12:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242895AbhHEQEa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Aug 2021 12:04:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69B666115B;
        Thu,  5 Aug 2021 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628179456;
        bh=sOxBUwwz0aOZWHN4XXLanK5+g/QHTjEiVnVP0DO7lB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5cNIV3pMyYChcQ2l5XxGXaQ4KbQZBNZCqkHSsVcAlFQXO1Jem9yrjMkvHJVcK2/E
         UJ45nNI1V5TDCh92qK1ZV13Lo/gjyqGUMJkybKbrutidjW0O4kF1gO66BDc6n8sEJh
         7sEVIRX028CTfRQ631ivtqNMYJv50QYvU2j4dbRmUUO+1YbUQtL2JCdr3UGkZqlFX8
         j2aacqdoskcP8I6eubv3JdB0dBooWc/s+CrLBP1M30KrWwIerPFzd5EoAYhDbUx0bo
         ID92hBx2I+fM7M0QHb2K+RngPkK/ANBGA/C2s7lySvTl4hehZTHec+Ut8e9O2mr/p4
         6/8rr1+ceGVYw==
Received: by earth.universe (Postfix, from userid 1000)
        id 7A9EF3C0C9B; Thu,  5 Aug 2021 18:04:14 +0200 (CEST)
Date:   Thu, 5 Aug 2021 18:04:14 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] power: supply: core: Parse battery type/technology
Message-ID: <20210805160414.xayo7pt4mzqtmlak@earth.universe>
References: <20210805085828.3451909-1-linus.walleij@linaro.org>
 <20210805085828.3451909-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhu3ndo3robcniam"
Content-Disposition: inline
In-Reply-To: <20210805085828.3451909-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rhu3ndo3robcniam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 05, 2021 at 10:58:28AM +0200, Linus Walleij wrote:
> This extends the struct power_supply_battery_info with a
> "technology" field makes the core DT parser optionally obtain
> this from the device tree.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ChangeLog v1->v2:
> - Drop the accidental double assignment of err as reported
>   by the kernel test robot et al.
> - Switch to "device-chemistry" instead of "battery-type"
>   to indicate the type.
> This is needed to migrate the STE AB8500 custom battery bindings
> and parser to the generic parser.
> ---
>  drivers/power/supply/power_supply_core.c | 20 ++++++++++++++++++++
>  include/linux/power_supply.h             |  1 +
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index d99e2f11c183..dd62c871b2b5 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -571,6 +571,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  	int err, len, index;
>  	const __be32 *list;
> =20
> +	info->technology                     =3D POWER_SUPPLY_TECHNOLOGY_UNKNOW=
N;
>  	info->energy_full_design_uwh         =3D -EINVAL;
>  	info->charge_full_design_uah         =3D -EINVAL;
>  	info->voltage_min_design_uv          =3D -EINVAL;
> @@ -618,6 +619,25 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  	 * Documentation/power/power_supply_class.rst.
>  	 */
> =20
> +	err =3D of_property_read_string(battery_np, "device-chemistry", &value);
> +	if (!err) {
> +		if (!strcmp("nickel-cadmium", value))
> +			info->technology =3D POWER_SUPPLY_TECHNOLOGY_NiCd;
> +		else if (!strcmp("nickel-metal-hydride", value))
> +			info->technology =3D POWER_SUPPLY_TECHNOLOGY_NiMH;
> +		else if (!strcmp("lithium-ion", value))
> +			/* Imprecise lithium-ion type */
> +			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		else if (!strcmp("lithium-ion-polymer", value))
> +			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LIPO;
> +		else if (!strcmp("lithium-ion-iron-phosphate", value))
> +			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiFe;
> +		else if (!strcmp("lithium-ion-manganese-oxide", value))
> +			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn;
> +		else
> +			dev_warn(&psy->dev, "%s unknown battery type\n", value);
> +	}
> +
>  	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
>  			     &info->energy_full_design_uwh);
>  	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index be203985ecdd..9ca1f120a211 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -352,6 +352,7 @@ struct power_supply_resistance_temp_table {
>   */
> =20
>  struct power_supply_battery_info {
> +	unsigned int technology;	    /* from the enum above */
>  	int energy_full_design_uwh;	    /* microWatt-hours */
>  	int charge_full_design_uah;	    /* microAmp-hours */
>  	int voltage_min_design_uv;	    /* microVolts */
> --=20
> 2.31.1
>=20

--rhu3ndo3robcniam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMC/4ACgkQ2O7X88g7
+poC8Q/+LyvlW3Q0Xvhst6kHBIyhs7fKY99yrumM29XOAFgK52tBxKBHW6st4I1d
TCOszc8nk0eTUhVFSQpPBouQpyIWgsgor0rFLCQ/BJkTZKPapKh6Tumrb+r6qhcZ
HknZfCtpbi0WIvbejbKmkqmT7ReQMDceBonFAra7sTL4MMVDp2vL2DPrbCuqtLzH
JWsKxnN6q+FHOYsaPhdIBJDpxNS44CdfNJIKECgAmN6yJajlidPpsjsB4FjQxV2r
BUhsuDFIk7BsMiIRGcGxz6A60qOyoJO2QZKR+ODAhikski85MArKYhXWa1fu2Z50
MPfLQ4tvSMySFTmMyTHi/rJZ0n82FDs201riFYq00Qa3OYljf4slw8SVcNuOX0qk
lqNCAZcyxucP3OdYIl8W4Y53LkgTqQGxQBMq8UAID+hvCmk1N21NnzdVh8GEjpU6
vioJ74EP/LvcjJ6AJ/pi1I4xll3bs4vsE3ZMtpZBIdjs6OZmpG8HMFOSTRX1xv/E
Hyui0unFcKRst+Gl0tE75qCf+is9d65ux0pbwZRwCLjbX7S4NNMRngG7OZ4Dma43
Q9XJBO6Bdj5OKMxIm4XPLtPEKc88CFn5iUdJCbV4zZugh1ezJ+1x1qfCNsLT0Bic
adw3XGugek8N5+F267VLuzc3XaeT3nxRbhLPUl2GrHrSaoVbnBs=
=nXtM
-----END PGP SIGNATURE-----

--rhu3ndo3robcniam--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA617D106
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 04:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCHDYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Mar 2020 22:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHDYS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Mar 2020 22:24:18 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30FA2070A;
        Sun,  8 Mar 2020 03:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583637858;
        bh=JjoSmNHwXhIashzBKZwTCNiO5mRTkp+jvzvmvOUHEhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kW5R1xOsSFeN3i7KPeUf1txrXEqiBJ5valuAjL+/0XX6QH1kEBr0fAzqXs5oveeDn
         ksmzVnz4TJBYY8ATJMY6prKBNPB4Mi3Qn+ofMmRcrn860BDOfPVJChBUn3o4JhGZaG
         sYiA1SbxS61DzrzdWNd4pLtVmWlL24TMBD+MewLI=
Received: by earth.universe (Postfix, from userid 1000)
        id 890B73C0C82; Sun,  8 Mar 2020 04:24:15 +0100 (CET)
Date:   Sun, 8 Mar 2020 04:24:15 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH] power: supply: sc27xx: Add POWER_SUPPLY_PROP_CHARGE_NOW
 attribute
Message-ID: <20200308032415.pirjewmu4wjut2xo@earth.universe>
References: <33dba0929575461e38c2e17ac0cc4a8a4e46fa2f.1581658633.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rk2x2c6jwavldn4i"
Content-Disposition: inline
In-Reply-To: <33dba0929575461e38c2e17ac0cc4a8a4e46fa2f.1581658633.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rk2x2c6jwavldn4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2020 at 01:38:58PM +0800, Baolin Wang wrote:
> Add the POWER_SUPPLY_PROP_CHARGE_NOW attribute to allow user to get
> current battery capacity (uAh) to do measurement.
>=20
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/sc27xx_fuel_gauge.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> index 469c83f..a7c8a84 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -614,6 +614,17 @@ static int sc27xx_fgu_get_property(struct power_supp=
ly *psy,
>  		val->intval =3D data->total_cap * 1000;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D sc27xx_fgu_get_clbcnt(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		value =3D DIV_ROUND_CLOSEST(value * 10,
> +					  36 * SC27XX_FGU_SAMPLE_HZ);
> +		val->intval =3D sc27xx_fgu_adc_to_current(data, value);
> +
> +		break;
> +
>  	default:
>  		ret =3D -EINVAL;
>  		break;
> @@ -682,6 +693,7 @@ static int sc27xx_fgu_property_is_writeable(struct po=
wer_supply *psy,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CALIBRATE,
> +	POWER_SUPPLY_PROP_CHARGE_NOW
>  };
> =20
>  static const struct power_supply_desc sc27xx_fgu_desc =3D {
> --=20
> 1.7.9.5
>=20

--rk2x2c6jwavldn4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5kZV8ACgkQ2O7X88g7
+pqhgRAAqmnqhBKya7Xa3yAztFO1pmXITppHrlVqecqljHx3sUH+8OvMyUSY64IJ
dxP1Kra/zcUyw44HCwJMeI/pmE4WdXddlcCWtmhcJks98WCJG20OUv9E4qMee96h
2bNsf79hMi05Zhs7N3d835sfLLCEIRfFP+rN/EJVLZXXsUtX2XCNbmr+D5ZQmxyZ
Dxg82PryGUbmPucF7Y+/t8BqjEOG6ct5FMqtqOckrtdKDHUXgqTFbICpH2JXjli5
UaaHv3gUPuiYvTe9U5/t6EvgmQ0J66fQ628G41CzTvsRAKvIO4o0ENd17gwAbHno
83b/bxN6E5hx+8+BfSSlUjtF5wpA/WatvFw63R13wO8cl3sBH6DGJ51f3maeDcGC
Ett0msiALhoS3AKO1IzcK2DJSwUfP8xutV0igOpouE/cmlSb2ZPN+hT7v6UAsTAA
38PSXj5edRcFlDF3ygjr1jao0QZyYZ9myL32bU52HEDmei1axXnN3vvEOWtT8cY6
BIoj+EerytLInoc03fbornNFc+dHXjPbGm236YUd7Yhw0z7ayJoHo4osjzlyqVuX
JxqbGGYOtTdAgvc0Au2fdNYuE/5TVfNlXuy+beXrRukChYijiBfNYe/zmCBoEQOx
s6ftb2jrCdfaXw/WmpMQNQQzO/ggfY4RgDiRg3sKUY9moMAVGS0=
=2A4B
-----END PGP SIGNATURE-----

--rk2x2c6jwavldn4i--

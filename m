Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD312F3E86
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391483AbhALWJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 17:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394222AbhALWJE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 17:09:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048DC061795
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 14:08:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 882571F4553E
Received: by earth.universe (Postfix, from userid 1000)
        id F3DA33C0C94; Tue, 12 Jan 2021 23:08:19 +0100 (CET)
Date:   Tue, 12 Jan 2021 23:08:19 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org, Rasmus Porsager <rasmus@beat.dk>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add Mele PCG03 to the
 deny-list
Message-ID: <20210112220819.7pwlhmeum4cttz4q@earth.universe>
References: <20210112103605.45012-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5w4dskkvljubv6xl"
Content-Disposition: inline
In-Reply-To: <20210112103605.45012-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5w4dskkvljubv6xl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 12, 2021 at 11:36:05AM +0100, Hans de Goede wrote:
> The Mele PCG03 is another mini PC using the AXP288 PMIC where the EFI
> code does not disable the charger part of the PMIC causing us to report
> a discharging battery with a random battery charge to userspace.
>=20
> Add it to the deny-list to avoid the bogus battery status reporting.
>=20
> Cc: Rasmus Porsager <rasmus@beat.dk>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 148eb8105803..39e16ecb7638 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -732,6 +732,12 @@ static const struct dmi_system_id axp288_fuel_gauge_=
blacklist[] =3D {
>  			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
>  		},
>  	},
> +	{	/* Mele PCG03 Mini PC */
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Mini PC"),
> +		},
> +	},
>  	{
>  		/* Minix Neo Z83-4 mini PC */
>  		.matches =3D {
> --=20
> 2.28.0
>=20

--5w4dskkvljubv6xl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/+HcsACgkQ2O7X88g7
+prUFRAAmqjG3FTVacI1spk5Iq7M+QzX1GwJIZheNh54NVLi9EJfHVgWsRcsHRbS
7aJoLJJElJc5iAA8EBRvAVQuOUI/b7WvPbK1+/wa2hsgkbtzl4R7FRWOs24psVHK
GRot6UfE5+sBCQfLadk0v4p3a00lhoIkc57u5PIUtI3SFqJcryqV8Ut7m5Py8upD
v1V+1ceiGKfEmmil22aZMW8DlWp4S4Hh3XjOln/Yb+j72sbRZlIqkOqgfgJ9EVgm
54fJDYGozbuJzqDfbYAvv22ZMePx/t+t0/EEFt6CEK40s/zKJb7t0KQPwgS9nXJq
gk6iaKTVYvd+ZHFIbRks75335syZiKwbK0tvcTQUlvqlpPXuGH5toKKKsbOKNIvo
HK50TFOJqC3AZwfPBmlduRBS4dckn5JxVI3CLktbey97Rie8grXQFMoClP5Hoh3i
e6G1JaIRK2MaD9jc5/OXM9ltnZ6H0rEzRCWM1PuSc6fZK578YclL3SkWx5ntVnWp
p5ajP5hk+eDR1Icz6hskiYQEWgI8CbEFWla7b3C8kvI3SN6YMWG/GEuNE/6pfo85
ro5Tu3Ue8TilZ9wESJXatOP2LMZVUWtECKjpmN0aR/DtldDPbTDf+N2toOrjKwhT
66ffsF/dEFV4mApqCWUSVVNwzR94FMaAc9Cmp00T18GzJ6AfXG0=
=EQXV
-----END PGP SIGNATURE-----

--5w4dskkvljubv6xl--

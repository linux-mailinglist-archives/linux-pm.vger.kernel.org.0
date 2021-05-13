Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF037FABE
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhEMPcu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 11:32:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41524 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhEMPct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 11:32:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A58DC1F42D98
Received: by earth.universe (Postfix, from userid 1000)
        id E30073C0C95; Thu, 13 May 2021 17:31:36 +0200 (CEST)
Date:   Thu, 13 May 2021 17:31:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola =?utf-8?Q?Milosavljevi=C4=87?= <mnidza@outlook.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] power: supply: sbs-battery: Fall back to Li-ion
 battery type for bq20z75
Message-ID: <20210513153136.76rr3ngjhuqy7b7q@earth.universe>
References: <20210510220827.11595-1-digetx@gmail.com>
 <20210510220827.11595-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrtn3tjxb6megzp2"
Content-Disposition: inline
In-Reply-To: <20210510220827.11595-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mrtn3tjxb6megzp2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 11, 2021 at 01:08:27AM +0300, Dmitry Osipenko wrote:
> The older bq20z75 controller doesn't support reporting the battery type
> and the type is Li-ion in this case.
>=20
> Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # TF101
> Tested-by: Nikola Milosavljevi=C4=87 <mnidza@outlook.com> # TF101
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

If it does not support reporting the battery type you should get an
error from sbs_get_battery_string_property. Obviously a string has
been returned, or you would not end up that far in the code. What
string do you see?

Considering BQ20Z65 and BQ20Z75 also support Li-Po I don't think
it's a good idea to fall back to Li-Ion. Kernel should never lie
about this, since I know some people use userspace based charging
setup and the charge limits are different for Li-Ion and Li-Po. When
reaching this place we do not know 100%, that it is a Li-ion, so
returning UNKNOWN is the safe option.

If you know, that your device (TF101) only supports Li-Ion
batteries, we can add a device specific override. But is this worth
the added maintenance burden? What is your plan for using this
information?

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index b71fbf543428..fec6c139d4ff 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -813,9 +813,17 @@ static int sbs_get_chemistry(struct i2c_client *clie=
nt,
>  	else
>  		val->intval =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> =20
> -	if (val->intval =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> +	if (val->intval =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
> +		struct sbs_info *chip =3D i2c_get_clientdata(client);
> +
>  		dev_warn_once(&client->dev, "Unknown chemistry: %s\n", chemistry);
> =20
> +		if (chip->flags & SBS_FLAGS_TI_BQ20ZX5) {
> +			dev_warn_once(&client->dev, "Falling back to Li-ion\n");
> +			val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.30.2
>=20

--mrtn3tjxb6megzp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCdRlMACgkQ2O7X88g7
+ppP8A//Sku/y7UYgfhN7Wrj6nJ977UurZIWBoU7LdYZCLE7cNbJ4oWQCkhd9bf4
54pFNgx7SdPHwF++9iK7HxKGf2eJhOrbKHx/QS1+tvcMme6lTK5icC3A0ikI1veW
N0j15IwArG9DTKq+NO9TcUxNxmGOxmHAGUevHsf2xnyO1beq/scdUF3GPIRy9ukc
gvw+pJgZmYpSLG1UN9EtT+cEGUMLFKh1BpIQh6rWjXV8XnogS6BAUA1al+jrkBdO
XenCWO+Yr/ofxOHy8vO/6s0TIU43PeKg0nKTf8OR9tYIn4mvAm0eWDOAxTiAys5s
LkH75QPvclM5K0MdcoyfvuqXKDWtAeKmHYTNOmy3iNOmoIRLBvptKMgRYQNY3lyN
gfa9IhQ9tNsFLbTX5g0InJlbvnGGq8mjZLpb/eGMRl50thAaos1B5eAkDe0G9bdd
RZZ3HfzQZeZhxVHxBgP3mMBZgoCMW6WN+C7Q+CR/B9ApY/P3+Z7eEYHoFQZLbtKI
54zLT1jTfRb1Lmdl31lqmw84cJTArlW8tNDGXlNRxt0ipvS+s9echMHeppeQum3X
yoxTjqzkKEiei2ciJ8L5BQMCoG9VY0RRVBXXYl+hOPwID4zifKhLEVuKjsY1PP5a
9s12XBP4J8MLKY2QxG05DRxsE2ySHSDs9DS1ecYT4p4Bj8dHMOc=
=ySGH
-----END PGP SIGNATURE-----

--mrtn3tjxb6megzp2--

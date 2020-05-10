Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0C1CCD8F
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgEJUJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 16:09:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgEJUJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 16:09:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1354C2A0428
Received: by earth.universe (Postfix, from userid 1000)
        id 024F13C08C7; Sun, 10 May 2020 22:09:37 +0200 (CEST)
Date:   Sun, 10 May 2020 22:09:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: max17040: Correct voltage reading
Message-ID: <20200510200936.hsygnezoxgbxsahv@earth.universe>
References: <20200504221300.3153-1-xc-racer2@live.ca>
 <BN6PR04MB0660DA4AED9364441DA33094A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hx7bg2ldd57usdl5"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660DA4AED9364441DA33094A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hx7bg2ldd57usdl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 04, 2020 at 03:12:58PM -0700, Jonathan Bakker wrote:
> According to the datasheet available at (1), the bottom four
> bits are always zero and the actual voltage is 1.25x this value
> in mV.  Since the kernel API specifies that voltages should be in
> uV, it should report 1250x the shifted value.
>=20
> 1) https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17040_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 8a1f0ee493aa..48aa44665e2f 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -126,7 +126,7 @@ static void max17040_get_vcell(struct i2c_client *cli=
ent)
> =20
>  	vcell =3D max17040_read_reg(client, MAX17040_VCELL);
> =20
> -	chip->vcell =3D vcell;
> +	chip->vcell =3D (vcell >> 4) * 1250;
>  }
> =20
>  static void max17040_get_soc(struct i2c_client *client)
> --=20
> 2.20.1
>=20

--hx7bg2ldd57usdl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64X4AACgkQ2O7X88g7
+ppo7RAAlh68rjdG0EAT4vqwdeC0NZ1Xjjdj1UoXNQ1aI1k6q4DGDgwbDsGhqjap
jQeG2gg9NqyGC9heqLYpb2vQJ5nDh6vyKKMwLz1Bt3EOXJ8ljRtcr0x67UBDOYNG
5MuYFPTwkV8KLVzhNTVzQRqqWFX+YZNXPrPND+/IKP71mnkaJSvdS1s6579t28LX
KlntSRf4kElQYoFqyD49Sj7Egn7G3ajQ43OygdmFokKOEywKAfoI7so+U3zRohZ2
beg9fiIOldk4YvOUnS7jXhR5K8COh/4SySkh6HQ9aoFI7mGm0lJ72IfFLoFb+Vcx
Rk/2+RLRHM/US/E4TIL6YjUM8qGdU+9sSFoKoDxcRILVmA5uR/UqwobTPqR5U/ql
EEjVTJwrR4l+2LwgC4l61FR3+qN8OZxuu1+zZU7oBW0JXBUpdN00goKACh2zDBLR
1dfftNk/AfSwHYYH36RVhxrurIWaNSFF8s+P9HjWWlp8oRXODeFX3VNpzHS8MkG+
XQlNS/XtgJSdxe7dE5NNLPOjg1HD5M4K6jzlPWgPrgRNowfxyZ2n1igKnrDh/hax
Up6foKwsZv2t/Y1DWknK+GCH5sZ/Bpeb8W29BR5SS38FCi4tfE2Xhn9ck7KuZqst
Nq8oVlNVH+Nq2ngAetMvHTwN4W3w0g2W/sxJHiUbN0pdJyiV02c=
=970P
-----END PGP SIGNATURE-----

--hx7bg2ldd57usdl5--

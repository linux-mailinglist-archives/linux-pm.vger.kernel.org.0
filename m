Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119AE3E3165
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbhHFVur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:50:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52532 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbhHFVur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:50:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 551B31F44DF3
Received: by earth.universe (Postfix, from userid 1000)
        id 613BB3C0C99; Fri,  6 Aug 2021 23:50:28 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:50:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: relax voltage limit
Message-ID: <20210806215028.pok7ec3dyrifaupk@earth.universe>
References: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvo6efs4un35zhrv"
Content-Disposition: inline
In-Reply-To: <cd466515301fcb19e9b858b2287d8bcc10cc3de1.1626678985.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cvo6efs4un35zhrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 19, 2021 at 09:20:18AM +0200, Matthias Schiffer wrote:
> The Smart Battery Data Specification allows for values 0..65535 mV,
> there is no reason to limit the value to 20000.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index f84dbaab283a..3d6b8247d450 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -102,7 +102,7 @@ static const struct chip_data {
>  	[REG_TEMPERATURE] =3D
>  		SBS_DATA(POWER_SUPPLY_PROP_TEMP, 0x08, 0, 65535),
>  	[REG_VOLTAGE] =3D
> -		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 20000),
> +		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 65535),
>  	[REG_CURRENT_NOW] =3D
>  		SBS_DATA(POWER_SUPPLY_PROP_CURRENT_NOW, 0x0A, -32768, 32767),
>  	[REG_CURRENT_AVG] =3D
> --=20
> 2.17.1
>=20

--cvo6efs4un35zhrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENrqQACgkQ2O7X88g7
+pqIBg//bA01H1vqmBod+OFPSoZyqaW+qNMBp3o6R2GsGrTMWrDOZY+XOqCCCmnL
CHujWi9OSwoofhx/0JwAau+2TVDxV0dMnRpxg7yHh7Aar/XU2S6Bt09ZnHvm5O5O
1CkeHX9osz3/qbS/xCjB+bju/jSJcFqLV4XsK2rCeXB0fnb8l83mD+4/YM/TcLq5
2L5ilE1RDQZKWCICWtxYd0xbEjCXVEz7SrQX9vWprgu4ifpiXSbpKhfXHV78YT2I
RN9lr5ISkaDFzvzGcMppEUzlw50/GllHoGAzpPU4NIOpku6EeUROX+jK/A6Fd2Hs
j28M95ax44d1JeAZ2anal5HD4BMH6z9jyVgYPTMOCj9JVNvXV9PZ7thgVW6EmS7w
DcgxtP/w5Mj3C2sMCuRsy4E4iOqx1jgKhBzeeGq9N4lb7yJHTKJ3ekkSHtogyGra
dyL0SpJu4ZI6W9xuhwN8UYamMbnd+azTQAs7ggKJ25C4xJPGUHvgjiju/pOrF6Fl
YCPLgrm1eC8e9z216iGKj5qSPi5j4DHpG12uA5AwYgQZJkLYUyfhKc7F26r/fRSA
fs4kpXoQnsBfrBvEDE50piCSLEFGwx/yKHUC7Goao5oKwduD9rzOMAyamcBTfUpY
CU0q4lSqIuR/MVREv9zmDi2j7UOS+xDCAMvw4sQnwP3d3z7dO7k=
=LSpE
-----END PGP SIGNATURE-----

--cvo6efs4un35zhrv--

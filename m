Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAD39B87E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFDL4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhFDL4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 07:56:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7ACC06174A;
        Fri,  4 Jun 2021 04:54:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 816AD1F4389A
Received: by earth.universe (Postfix, from userid 1000)
        id 3B4BA3C0C95; Fri,  4 Jun 2021 13:54:24 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:54:24 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] power: supply: oplc_battery: Use fallthrough
 pseudo-keyword
Message-ID: <20210604115424.3jjkrdd4ysbuamka@earth.universe>
References: <20210507124724.10825-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="niz3uw53k4kdb52r"
Content-Disposition: inline
In-Reply-To: <20210507124724.10825-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--niz3uw53k4kdb52r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc Kees and Gustavo]

Hi,

On Fri, May 07, 2021 at 08:47:24PM +0800, Wei Ming Chen wrote:
> Add pseudo-keyword macro fallthrough[1]
>=20
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highli=
ght=3Dfallthrough#implicit-switch-case-fall-through
>=20
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---

I suppose completely empty case branch is also ok and just not
documented? I mean it does not hurt much in this case, but quite
a few power-supply drivers have something like this and it would
IMHO reduce readability to add fallthrough; to all of them.

property_is_writable(dev, prop) {
    switch (prop) {
        case A:
        case C:
        case E:
            return true;
        default:
            return false;
    }
}

Thanks,

-- Sebastian

>  drivers/power/supply/olpc_battery.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index e0476ec06601..743b7f1cf9ea 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -238,6 +238,7 @@ static int olpc_bat_get_charge_full_design(union powe=
r_supply_propval *val)
>  	case POWER_SUPPLY_TECHNOLOGY_LiFe:
>  		switch (mfr) {
>  		case 1: /* Gold Peak, fall through */
> +			fallthrough;
>  		case 2: /* BYD */
>  			val->intval =3D 2800000;
>  			break;
> --=20
> 2.25.1
>=20

--niz3uw53k4kdb52r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6FGYACgkQ2O7X88g7
+pp4dg//dUNVD5Vv7HzNinfg7WFbPrNZ3SPiEqQQfxhfq4olXu8KRbaI0MkQVCSH
rZ3yZDB7yK4VXapzO7geYHBqLPaMHvoC3KL7WGAYmcBjVKTo4s+Ik1YsKkVUD7bz
l5Ln7dTBy5wTtTO09qwP75contdiUxNmAjFQ3U5ZHUOaGQmSQkty0Gfpu+CuENDV
ORo8PJMNGLHwGjlA10kcR0xrZPsQdfO3IefIf4rU/8Ppp1xfoHqLWGKfxAJP8SWa
Z29EO9u1lzvCgL7Qu0cXxdwvK7fiCjNzIq2l8EGU+H0wyaaXVnYTwcs7JnqLE462
KCbmUU1dLm3lMMd8DnWL1ozRXWArb60GiRLwaJqEfCnmHsOBEEN85Q4Ix9ZTCEk9
HmmzZBoYjtd0Ad8n+4u/Fja/45tLc4mtfIaQhvcsNbCgW1iRuRVCbyhXHzGib9zS
FhY9sYaL5m5IBKUFUJt+Y9bYZB8Nt0RGcyw6/dWFNHHqjb/YNrLJ6PesadsVjL3Y
SG8wo+5rEeGZs7kx+VcAr79inxesf40c/nn7vZJNlG9aqAbn4y/FQHbtVrVMGmRo
KCPMiipAxHsPuqw/As7hChcaKYt24MxZdlcCafpXcr3bVarAB/W7ol1KEX5N4HcX
uprkOyJmCHTOcd9JQHvOcudkKes1UwEcgpga6PQppT9d6F3QJ8I=
=cZG7
-----END PGP SIGNATURE-----

--niz3uw53k4kdb52r--

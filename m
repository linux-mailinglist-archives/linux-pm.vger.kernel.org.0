Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCA14015A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 02:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgAQBQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 20:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgAQBQX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 20:16:23 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7039720728;
        Fri, 17 Jan 2020 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579223782;
        bh=vaLH0jihnmRNQiDunhqpZC41zyWAEUMZNUUv6qH2MPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0bd2wErw3Lm4D8wiEeCvEBBF+NIWyZ7f5T/DCIaplBSMz1r6XdsqbpwtWDFx9kYL
         BiURyatuB56wdOcYelDFjtdlwITxBeI24K//ZQSr2OysKEJS95ohBcf2cNgjmTyQ+b
         G0phKgUCCm1z6MXVorwaXIesJCMG/7vhrxlDbySQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 06C933C0C7E; Fri, 17 Jan 2020 02:16:20 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:16:19 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: remove unneeded semicolon
Message-ID: <20200117011619.a2lq4tz3rah5nmgf@earth.universe>
References: <20200115134010.60385-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e2nosrm74sgks6j3"
Content-Disposition: inline
In-Reply-To: <20200115134010.60385-1-chenzhou10@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e2nosrm74sgks6j3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 15, 2020 at 09:40:10PM +0800, Chen Zhou wrote:
> Fixes coccicheck warning:
>=20
> ./drivers/power/supply/ipaq_micro_battery.c:188:2-3: Unneeded semicolon
> ./drivers/power/supply/ipaq_micro_battery.c:152:3-4: Unneeded semicolon
> ./drivers/power/supply/ipaq_micro_battery.c:171:2-3: Unneeded semicolon
>=20
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---

Thanks, I fixed the patch subject and applied it to power-supply's
for-next branch.

-- Sebastian

>  drivers/power/supply/ipaq_micro_battery.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/su=
pply/ipaq_micro_battery.c
> index 03592ce..192d9db 100644
> --- a/drivers/power/supply/ipaq_micro_battery.c
> +++ b/drivers/power/supply/ipaq_micro_battery.c
> @@ -149,7 +149,7 @@ static int micro_batt_get_property(struct power_suppl=
y *b,
>  		default:
>  			val->intval =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
>  			break;
> -		};
> +		}
>  		break;
>  	case POWER_SUPPLY_PROP_STATUS:
>  		val->intval =3D get_status(b);
> @@ -168,7 +168,7 @@ static int micro_batt_get_property(struct power_suppl=
y *b,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
> =20
>  	return 0;
>  }
> @@ -185,7 +185,7 @@ static int micro_ac_get_property(struct power_supply =
*b,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.7.4
>=20

--e2nosrm74sgks6j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4hCuMACgkQ2O7X88g7
+poMGg//aEtQY7r7xJ8j/Z4uRYYsqOD9laq3HECyCtATja8mXk5eWnNaMecDUdkV
LceSqFJ0+N29Celz3WnoXdidrIoHd4kCVUTtOsLV0vM5zvz0NEjqlDLvG0ZadtCd
3me+W9Tg0TSLzqY6jWuNMY8BP01dPpyMGzvDHkusfOqlqTiSTieyWPH+0SGbqgj2
s1DeRJ3xVeSM7826szumwjs87icnbL9KHXkKwacTT13whXHoO55qFEu78xSx8GHL
TrNmjnB298CFSbvMVd7sAgFOW/MlB3/DfeGd5nyYfC+3f0eLjvoIeIJVyItnm6tj
Ld/tiEygeOyQ5wVb3IMtfM2bz60dkST+P399yajbjQD/AHYfn1+KIgmQNeio4m5T
O1mfXoG4HoLnCdgEhlrLLrq/rOxv+HgsZX1H+2kTmiOwRqKvPYi9zUJs+l3/OGl+
0+Q+ibplgG9FjNUTT2pwDKUrHJgcYXCRAEIeMAmxOgpGVUmLHJRHWHmkyuYkEf4f
/NFELZXRSHUYfNZXS6DyQDfy4xur9qdEZgddyXZLX6mTfsjZgnkbfpuQipXDsQmb
/9aS+CQvUCNhmO3ZMONGx4j1Lpvy9Wj+rT/VHm8xvYNf+OaiGjSV7pP66ZpZO0pj
t3llD1I4EVyGEdtLMH6fh7B5KjqglJVVOKR3msaydwBMGH3k7Vk=
=dJks
-----END PGP SIGNATURE-----

--e2nosrm74sgks6j3--

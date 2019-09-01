Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36392A4BB5
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfIAUNT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 16:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfIAUNT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Sep 2019 16:13:19 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05EE2190F;
        Sun,  1 Sep 2019 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567368798;
        bh=xwERCMNbn31bRIYy50nY/WhqkdrEr3z8W+NIylZsaLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnjn4LnsGqJW4NQkww5fKLw+ziFk/a2TcN4ZJs984LglC7V2Urs4fEADBEw7hmyq/
         HriOMVxyLKoDyTvNK87teYsSKtZstb7WCvhqNc9ZL/azWoWthAb/cdTRL0MqfTXpBy
         SKBjFiilXiczx6DPPrlFWnhbk7VwEvKIvct/L+fY=
Received: by earth.universe (Postfix, from userid 1000)
        id A25343C0B7F; Sun,  1 Sep 2019 22:13:15 +0200 (CEST)
Date:   Sun, 1 Sep 2019 22:13:15 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: axp288_fuel_gauge: Sort the DMI
 blacklist alphabetically
Message-ID: <20190901201315.nsusbkggjusa3sjt@earth.universe>
References: <20190825154152.80087-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lump3ji3c3yc4od"
Content-Disposition: inline
In-Reply-To: <20190825154152.80087-1-hdegoede@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7lump3ji3c3yc4od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 25, 2019 at 05:41:51PM +0200, Hans de Goede wrote:
> The blacklist is getting big enough that it is good to have some sort
> of fixed order for it, sort it alphabetically.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 44169dabb705..6db2e86098e9 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -674,6 +674,7 @@ static void fuel_gauge_init_irq(struct axp288_fg_info=
 *info)
>  /*
>   * Some devices have no battery (HDMI sticks) and the axp288 battery's
>   * detection reports one despite it not being there.
> + * Please keep this listed sorted alphabetically.
>   */
>  static const struct dmi_system_id axp288_fuel_gauge_blacklist[] =3D {
>  	{
> @@ -696,6 +697,12 @@ static const struct dmi_system_id axp288_fuel_gauge_=
blacklist[] =3D {
>  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
>  		},
>  	},
> +	{
> +		/* ECS EF20EA */
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
> +		},
> +	},
>  	{
>  		/* Intel Cherry Trail Compute Stick, Windows version */
>  		.matches =3D {
> @@ -719,12 +726,6 @@ static const struct dmi_system_id axp288_fuel_gauge_=
blacklist[] =3D {
>  			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
>  		},
>  	},
> -	{
> -		/* ECS EF20EA */
> -		.matches =3D {
> -			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
> -		},
> -	},
>  	{}
>  };
> =20
> --=20
> 2.23.0
>=20

--7lump3ji3c3yc4od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1sJlsACgkQ2O7X88g7
+prfog//aHGqdHjjoL5mp88gV0NK2HsAhq95wihfX2eZ7xKSE4K6Fj9rjszRnO5E
96oj6iWHBiQPdM865SGlk0pG6FEeWEnBbDnrcD80NQPyNCzTW4+mPNTEKDxjLtOZ
91gwEJ///UEzsggZWGAqifIetiUyKVXrPD69EOfyA6gLQl1esKlkWK3CBc9Q8LiM
mAqzFrRomoLyPWRJiZJZ4k4+R/iauDhTAzsLj3qXyTmpda17Ze2BR1L8wep2xsuM
Uk9IpJl3tslBYaPCV5ZiPqIqO1Myn5dBEeao98RVkTRfu1xEne3gYVnqyfM0fU8/
7J7pxmo0lzfeuJIzpHFgAUKavXeBXbbPJ38WdgQmEpF0NKwQ23RQiMGOLm378cld
jsV8C6kVZtS9vHUuNSxk7NrAmXBc8VzDz0D5QXfBWoWIWAxDyWHznSYjPch4xcws
hNO7PJeoOyX7ShDhhm65S7x5DqJXu7D6+Aw0B1Z/pnOAtM/sr6beI7n7GR2Kv5gu
Js2dSnOMkn3q5iTuARqktBgxP7nk+kHGrWKFu939Fi/1OIgdN9r+9ntV8ZOdWcG/
mexVgUym33wsMKZZsCduPvTY26PT4YnKM/E9IzO5hqrXeEwhUDblo7dRGYX806VS
Jt0dpGCN7ImijTxv4B0UHu8O+XxfOBwrKNxGIbQ9GqB1vj0auPk=
=ZYr1
-----END PGP SIGNATURE-----

--7lump3ji3c3yc4od--

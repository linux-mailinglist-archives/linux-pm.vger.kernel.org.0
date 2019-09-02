Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3EA5C7B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfIBTDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfIBTDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:03:13 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FCAF21883;
        Mon,  2 Sep 2019 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567450992;
        bh=AWHxitr0Uqz89QQHhmQrpQCAfo/5quYPk/oro2ST544=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdztqFnanBJ+cfAc0ZvtQvOHoJv2wyldc2LIgPq0RJoaP+hKu8STi0QWt5wZskbEW
         qNDLzm8ld0+lleK8yX5hziJ/rS4EDp05uB66fJIJnnf6+LVQY8SEvCCwFBnZ9dNdTz
         9gdPhw2MoB5qAfMm6rG97SCnUlnBegKA0FiHCpBs=
Received: by earth.universe (Postfix, from userid 1000)
        id A84963C0B7F; Mon,  2 Sep 2019 21:03:09 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:03:09 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17042_battery: Fix a typo in function
 names
Message-ID: <20190902190309.yshdhrswhemdf7yb@earth.universe>
References: <20190721160328.24660-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="geki2nibjgyihtcm"
Content-Disposition: inline
In-Reply-To: <20190721160328.24660-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--geki2nibjgyihtcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 21, 2019 at 06:03:28PM +0200, Christophe JAILLET wrote:
> It is likely that 'max10742_[un]lock_model()' functions should be
> 'max17042_[un]lock_model()'
> (0 and 7 switched in 10742)
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 581c6bd23388..da3904822929 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -511,7 +511,7 @@ static inline void max17042_override_por(struct regma=
p *map,
>  		regmap_write(map, reg, value);
>  }
> =20
> -static inline void max10742_unlock_model(struct max17042_chip *chip)
> +static inline void max17042_unlock_model(struct max17042_chip *chip)
>  {
>  	struct regmap *map =3D chip->regmap;
> =20
> @@ -519,7 +519,7 @@ static inline void max10742_unlock_model(struct max17=
042_chip *chip)
>  	regmap_write(map, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
>  }
> =20
> -static inline void max10742_lock_model(struct max17042_chip *chip)
> +static inline void max17042_lock_model(struct max17042_chip *chip)
>  {
>  	struct regmap *map =3D chip->regmap;
> =20
> @@ -577,7 +577,7 @@ static int max17042_init_model(struct max17042_chip *=
chip)
>  	if (!temp_data)
>  		return -ENOMEM;
> =20
> -	max10742_unlock_model(chip);
> +	max17042_unlock_model(chip);
>  	max17042_write_model_data(chip, MAX17042_MODELChrTbl,
>  				table_size);
>  	max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
> @@ -589,7 +589,7 @@ static int max17042_init_model(struct max17042_chip *=
chip)
>  		temp_data,
>  		table_size);
> =20
> -	max10742_lock_model(chip);
> +	max17042_lock_model(chip);
>  	kfree(temp_data);
> =20
>  	return ret;
> --=20
> 2.20.1
>=20

--geki2nibjgyihtcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tZ20ACgkQ2O7X88g7
+priMg//R7FBlaET+kgtJlE1Iw8yaVuXLYkOfpjDXo4asEFbs5SPxrD4VyTWAXTs
McaDNnlAmVs5kinXneVN8LMYdU6MstWi0a3eV/5JYxGGMkvf9eBMOsqFvP6JOcsG
bypNfnKdLbuhaxC5ZjHLRK/D3b9oZ6nSBqBZjHvRQt4lIeqmTyNw/z0XaHqLhVHU
/eI6Y+FSx+v1agf+ycRfCOoIP95ZEEsxeBZLhe+aBlnUjD9WzmU4VZwmTM0PkmZt
Xq6xvkp6WezD4QihyOx911i08KHSMuxBQu6kd5eXQW+T0IdcIDQpbp8WD7pzOjrY
Gz9xE9f7T3kEjm4FRlBbGZe92X7GVpltqW/qOoeD1y87JbPAHNlLWkjv55KgysLK
yfnB+mbSetnlZ/lBnmLaeQnyzNJowykvqveQYJO4t+iO4dEFmplTAFS9syZcTicF
g0fAJWY4W9DZSLLQEG+f1PlxyaCwvabQpOTeQsHuPAc6FnA9ChxWePnoho9Y72Kk
GNx50V4/KS3A5agpyQ0JwfY9Jz48sZ0wHz6gEnccNeobzoxGYLgOJjDwLw1EtRv9
ACr3y/SbzjltKqjC5PgYHCfRESlCTXV7Ngt5Q1ZErvqH5ZeBnZwAhzV9hqY1shTc
07x8g4NyCMzsq07FOSbNqRZgvk6vEXk+gmNohoLLSlXlt916Bss=
=QS8p
-----END PGP SIGNATURE-----

--geki2nibjgyihtcm--

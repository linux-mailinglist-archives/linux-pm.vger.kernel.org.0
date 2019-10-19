Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B052DD815
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfJSKZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Oct 2019 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfJSKZR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Oct 2019 06:25:17 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B9F2082F;
        Sat, 19 Oct 2019 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571480716;
        bh=PB+8+CFcDHC/V7gHrHpJW0e3lzRlDYz1TNKgcBj6Q9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0isxqp9B78/lE8vC/fJDaHKBdUiWN6ku3lQbKdzAx/1lbA9jFBOrTbLiFMWBxGBd
         bng60wmXO3bL5eEdPsGA7IHfmWN9AIYKUMpH5JsynjnMODWYqeqgPKUUZceF9Sppmr
         GvBCNAhSFug6zfm6DogFxTm3nMMjbkPN30TKqCzo=
Received: by earth.universe (Postfix, from userid 1000)
        id 74E4A3C09B1; Sat, 19 Oct 2019 12:25:14 +0200 (CEST)
Date:   Sat, 19 Oct 2019 12:25:14 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     zhiyunq@cs.ucr.edu, csong@cs.ucr.edu, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: rt5033_battery: Fix the usage of
 potential uninitialized variable
Message-ID: <20191019102514.e7py77cl5uynjbqj@earth.universe>
References: <20191015165737.658-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5s3jpimr5xy5gox"
Content-Disposition: inline
In-Reply-To: <20191015165737.658-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--o5s3jpimr5xy5gox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2019 at 09:57:37AM -0700, Yizhuo wrote:
> In function rt5033_battery_get_present(), variable "val" could be
> uninitialized if regmap_read() returns -EINVAL. However, "val" is
> used to decide the return value, which is potentially unsafe.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---

The patch looks good, but your name in author and Signed-off-by line
look incomplete (only one name). Please resend with full name as
patch author and Signed-off-by.

Thanks,

-- Sebastian

>  drivers/power/supply/rt5033_battery.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply=
/rt5033_battery.c
> index d8667a9fc49b..6a617531698c 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -26,8 +26,14 @@ static int rt5033_battery_get_present(struct i2c_clien=
t *client)
>  {
>  	struct rt5033_battery *battery =3D i2c_get_clientdata(client);
>  	u32 val;
> +	int ret;
> =20
> -	regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
> +	ret =3D regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Failed to read RT5033_FUEL_REG_CONFIG_L.\n");
> +		return false;
> +	}
> =20
>  	return (val & RT5033_FUEL_BAT_PRESENT) ? true : false;
>  }
> --=20
> 2.17.1
>=20

--o5s3jpimr5xy5gox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2q5IYACgkQ2O7X88g7
+pqWkA/9EvJuyA5llGhAfOExXzXgaxzubn86saokf5/orrEYW2if8tGz46fvwESL
CaZlv1xJFzyg38MQEmQN++fgVm5R+IsvsmRRHFgi13eM5G5xf0ZDaowHLEOb1HV1
Q+hG9tXk2QGrp3piiZ1NQuW23ExE8+qQdajUrzPnD0+hdHtZnw6eoflnHxLpuXlI
ja7ggV2wTC8lkM1ak3Qc/mbtauAOGYMokgVc0eHf79obcRl58IQ8hgi8HGbYCUw8
smnxBpyfB7YKojOsn/50NxPU6kfGnHNo+uRmn0fzSq3wEiiMcf5rq4jju0mORArJ
YPLxClG6Yb95sKnN/a7cwPydv9qH38I5eZ2q/xhPex/9MLJW3jl3a/++Ebtx8iub
aT4CjLwhpfOCH4mWF3U1TVDjh4C9/Oma3lbkc3Yz+AyjbvrySp0i21iWKspB+1y4
ZR6rbFzb6IiPipQEf0IneNndxFQVbLMaDQGKXiFNOBtvzHm8fwAXybP/Rh6VWGjD
5tdw9Jc7QefH+q/FbqWIJHjf8c1JZlvvdYCNezoxulGkZWaFyFDMEQb1ER7iECcH
bVC8r7XDetMMUgJxl+f3Bed4eb+EH2ytmdzG08sl/tNscU7kws7arMIfJ3whMW/8
+/KCNGZbz4i6uAbESUg4h338By2CEKY52ntDat2ySS8os69GJkw=
=t/Cr
-----END PGP SIGNATURE-----

--o5s3jpimr5xy5gox--

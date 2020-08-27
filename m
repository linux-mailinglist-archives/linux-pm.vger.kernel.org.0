Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07DD2550CB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0V6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 17:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0V6T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Aug 2020 17:58:19 -0400
Received: from earth.universe (dyndsl-037-138-189-082.ewe-ip-backbone.de [37.138.189.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903B22080C;
        Thu, 27 Aug 2020 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598565498;
        bh=a9tq9mp0xanc4ZvC8pRUPpOwREYI1kj7OwLDkbhxcik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0Oqkq/3MR/DoiC32vVNU9iLy4V9FGTSNObCoJ+idUBg4/MlhTBjhoHdBq37R5ouL
         ACF5FPC5lbhKsr9cCh1a44RNoRp8qDyMPYNlObm9+80I5IhdHg4/RkimTi7lUq9YP8
         P11M8PHo0V1RvFPlcbFCVCFmE9POGKyrJ1lFcSsY=
Received: by earth.universe (Postfix, from userid 1000)
        id 016F83C0C82; Thu, 27 Aug 2020 23:58:16 +0200 (CEST)
Date:   Thu, 27 Aug 2020 23:58:16 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: sbs-battery: remove unused
 enable_detection flags
Message-ID: <20200827215816.mycozlzwiu6uc46n@earth.universe>
References: <20200811044141.1821281-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2ky3g6chlwyn6lm"
Content-Disposition: inline
In-Reply-To: <20200811044141.1821281-1-ikjn@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--a2ky3g6chlwyn6lm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 11, 2020 at 12:41:41PM +0800, Ikjoon Jang wrote:
> Remove unused enable_detection flag which is always true after
> the device is proved.
>=20
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> v2: initialize work queue before registering power supply
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 83b9924033bd..1b706adc8d43 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -185,7 +185,6 @@ struct sbs_info {
>  	struct power_supply		*power_supply;
>  	bool				is_present;
>  	struct gpio_desc		*gpio_detect;
> -	bool				enable_detection;
>  	bool				charger_broadcasts;
>  	int				last_state;
>  	int				poll_time;
> @@ -876,9 +875,6 @@ static int sbs_get_property(struct power_supply *psy,
>  		return -EINVAL;
>  	}
> =20
> -	if (!chip->enable_detection)
> -		goto done;
> -
>  	if (!chip->gpio_detect &&
>  		chip->is_present !=3D (ret >=3D 0)) {
>  		sbs_update_presence(chip, (ret >=3D 0));
> @@ -1007,7 +1003,6 @@ static int sbs_probe(struct i2c_client *client)
> =20
>  	chip->flags =3D (u32)(uintptr_t)device_get_match_data(&client->dev);
>  	chip->client =3D client;
> -	chip->enable_detection =3D false;
>  	psy_cfg.of_node =3D client->dev.of_node;
>  	psy_cfg.drv_data =3D chip;
>  	chip->last_state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> @@ -1077,6 +1072,8 @@ static int sbs_probe(struct i2c_client *client)
>  		}
>  	}
> =20
> +	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
> +
>  	chip->power_supply =3D devm_power_supply_register(&client->dev, sbs_des=
c,
>  						   &psy_cfg);
>  	if (IS_ERR(chip->power_supply)) {
> @@ -1089,10 +1086,6 @@ static int sbs_probe(struct i2c_client *client)
>  	dev_info(&client->dev,
>  		"%s: battery gas gauge device registered\n", client->name);
> =20
> -	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
> -
> -	chip->enable_detection =3D true;
> -
>  	return 0;
> =20
>  exit_psupply:
> --=20
> 2.28.0.236.gb10cc79966-goog
>=20

--a2ky3g6chlwyn6lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9ILGUACgkQ2O7X88g7
+pr4zg//S6qiAh58/6VcQSyrOAuPYjwtISnHyAvI/yfY9fE2zbgvy2GF7fj/DC67
jwmBErPjRGYOUsWt3uhrW3iVIGPM7B1NG7/vMTf7CwnVowjMV/9F8nwk/E5x1urS
jNGm3MPpj6wtLAtgOsE2J5sa5wTGi/DHAuyeJIZ13bDoSe1VYkQRU58+bj2k8sEG
7TZnF7zbxOEWUsrLtPvs3/r4XB67HVl935KPmywfVRLvKs12SpE9EgAUVJEk53I5
QYjG8JwWJKcHJVo8tVBY2KarIjDwhdFGecgG9fleYL64BITynM07FilE2WLvt5sb
r3zMvBlaOZNavzM+1S7VIdTmKp+WEAZy1WIiidJQfLR54JzdO2cNE3jhLlUI43rf
BvX1eEq4z0cK+VjlggTmU3MRPDYCNWGj6KGmO+ExQRvLU1NuNFkl3Xp/UXJUX2Pm
06C4LF1huMks+XFSRFWlsCcV7/Q2iNu76nasIlf8/yeWVZF5MDK5FVhmkO43RiHL
fiiIdBvhB3zEjLL4CM+Wrwu3xBiX2WQZo7B9rQAPh+oJivNCcT2+o/N7DZHqZBwC
ud2bNLUzxlmFtI20ob9CqhhPin+2LX5AFdYJGFxPk0/0tGWSI18el1/aWhASX2Le
CGPONSS8pbCvvpVSnePwz6MvHbnBzeqBHGykeyo8tmfQC/v4rJk=
=FT4t
-----END PGP SIGNATURE-----

--a2ky3g6chlwyn6lm--

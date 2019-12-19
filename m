Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B0125926
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLSBTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:19:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39472 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfLSBTc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:19:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 49B76292A17
Received: by earth.universe (Postfix, from userid 1000)
        id 2483B3C0C7B; Thu, 19 Dec 2019 02:19:29 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:19:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/7] power: supply: sbs-battery: add force_load as a dts
 property
Message-ID: <20191219011929.yyzpkhkskoy4nzmr@earth.universe>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
 <20191101190705.13393-3-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2gq722r6du4j2te"
Content-Disposition: inline
In-Reply-To: <20191101190705.13393-3-jeff.dagenais@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--v2gq722r6du4j2te
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 01, 2019 at 03:07:01PM -0400, Jean-Francois Dagenais wrote:
> This extends the behaviour of the existing module param so that system
> integrators can specify the flag in device-tree.
>=20
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---

sbs,force-load is not a hardware description and does not belong
into DT. OTOH "hot-plug-capable;" would be a hardware description
and carry the same information. Please respin the patch(es) and CC
Rob Herring <robh+dt@kernel.org> and devicetree@vger.kernel.org.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index f9e8c14ac830..f92b98d900d2 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -814,6 +814,7 @@ static int sbs_probe(struct i2c_client *client,
>  	struct power_supply_desc *sbs_desc;
>  	struct sbs_platform_data *pdata =3D client->dev.platform_data;
>  	struct power_supply_config psy_cfg =3D {};
> +	bool force_load;
>  	int rc;
>  	int irq;
> =20
> @@ -858,6 +859,9 @@ static int sbs_probe(struct i2c_client *client,
>  	}
>  	chip->i2c_retry_count =3D chip->i2c_retry_count + 1;
> =20
> +	force_load =3D of_property_read_bool(client->dev.of_node,
> +					   "sbs,force-load");
> +
>  	chip->gpio_detect =3D devm_gpiod_get_optional(&client->dev,
>  			"sbs,battery-detect", GPIOD_IN);
>  	if (IS_ERR(chip->gpio_detect)) {
> @@ -890,7 +894,7 @@ static int sbs_probe(struct i2c_client *client,
>  	 * Before we register, we might need to make sure we can actually talk
>  	 * to the battery.
>  	 */
> -	if (!(param_force_load || chip->gpio_detect)) {
> +	if (!(param_force_load || force_load || chip->gpio_detect)) {
>  		rc =3D sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> =20
>  		if (rc < 0) {
> --=20
> 2.23.0
>=20

--v2gq722r6du4j2te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl360CAACgkQ2O7X88g7
+po24RAAp0YGhYcnSNzRhM1fUWrahTEUNusqZ+vz2izgaeueK4c72bSy2xdwHUmi
g86bkAI2kRjAEXkLDQ5aXsXshvT4Sx8WmpVLWiWj6UKKSE8S+1Mj3oRdAIKMtwLV
BOckOgpdpRFOrKSnel2JLl7nU2hfRYLzF4qwo/QU+7eHPPP4KNOvxyqJUUNaoTPw
droz8vrEF2xJSlRScWIs6tkdR7kHiCQxHX1ZOttYtXERgI00fRW+IcnMG5PMayPG
hkHt2DM49vX9Oguus2h3pDwCcdmsCNABdaQgWikTq36Cbb4JuFk3tmSxfW8VbCSG
SffUAkg38Mgu8WnAnC6/sEpBH7FlPESuOg7lIBDu+e39nYgGlPD4rcdLuNF9rfre
OV67GpiAZz76daXec7Cr3B0A8nAA4Ue2WWhkhXnnkrlvYSG/B7fVonNRkLVCNqqi
MpydYVJFElpprlCfaKE1wvqTgmEIT9xK4IgzKcAcXmrvzWWT7yi5SB1X4RIcWOSX
55r+Hwpmki2zew6aVZWz0BKg6b6l0S8afJ7RqxC9rCTIiaI2RxeEZNW3Csl72xAd
bYe29OVhFzXff2v+xS4ZkEwQ98ULLszAlWkpIK6e8He/8IIj2epqCANX7l727/sj
rzu3UvRZ16Pw0RwrrMkmDgrunnssj2xlBjEoLz8FS7RuUJa0viI=
=TPxd
-----END PGP SIGNATURE-----

--v2gq722r6du4j2te--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD1287E0F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 23:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgJHVfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 17:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgJHVfs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 17:35:48 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCDA207DE;
        Thu,  8 Oct 2020 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602192947;
        bh=R+CjKK/22XYxtDtFw6KG9lgth7PXnH/9hixEGS2jtdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKzuIivkqXRLWPkN6NCzQarSDRnEe3Yh4oqRHT0kldkXk+nH0KRbottk7K4GBAJ0L
         QN/0ONH+JSHnnLy2JpTakF2vu6KgiHb3Ct07x6WBnEzlTH8GDxzm5OPpsInGlEQhOR
         GjQDUUcBI8jNbZFvxit8iPIA/iZbAg4BirrMIm7A=
Received: by earth.universe (Postfix, from userid 1000)
        id 06A383C0C87; Thu,  8 Oct 2020 23:35:45 +0200 (CEST)
Date:   Thu, 8 Oct 2020 23:35:44 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Colin King <colin.king@canonical.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: bq25980: remove redundant zero
 check on ret
Message-ID: <20201008213544.wakvf3ze2bshopem@earth.universe>
References: <20201006170600.545361-1-colin.king@canonical.com>
 <4239fc37-c1d4-23e5-c784-b171eb6173ab@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjlgoi4mnlire24r"
Content-Disposition: inline
In-Reply-To: <4239fc37-c1d4-23e5-c784-b171eb6173ab@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fjlgoi4mnlire24r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 06, 2020 at 12:23:06PM -0500, Dan Murphy wrote:
> Colin
>=20
> On 10/6/20 12:06 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > Currently ret is assigned to zero and the following statement checks
> > if it is non-zero. This check is redundant and can be removed
> >=20
> > Addresses-Coverity: ("Logically dead code")
> > Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259=
xx family")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/power/supply/bq25980_charger.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/sup=
ply/bq25980_charger.c
> > index 3995fb7cf060..f04f9acdb13b 100644
> > --- a/drivers/power/supply/bq25980_charger.c
> > +++ b/drivers/power/supply/bq25980_charger.c
> > @@ -613,9 +613,6 @@ static int bq25980_set_battery_property(struct powe=
r_supply *psy,
> >   	struct bq25980_device *bq =3D power_supply_get_drvdata(psy);
> >   	int ret =3D 0;
> > -	if (ret)
> > -		return ret;
> > -
> >   	switch (psp) {
> >   	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> >   		ret =3D bq25980_set_const_charge_curr(bq, val->intval);
>=20
> Thanks for the patch
>=20
> Acked-by: Dan Murphy <dmurphy@ti.com>

Thanks, queued.

-- Sebastian

--fjlgoi4mnlire24r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/hiwACgkQ2O7X88g7
+poEdQ/+M18AeoweOM86uVV6sfWR67UYgB1+C4wBV55tCIj4NMSQ8gGdZo3plK1h
K6ZPaUS/dbpreixvpi8F5bumnAqIYeCepykZs6FFrLbRcZViZhjFvayM7xqBTQr2
I6nc3RhAsno+h8niIiWRDFANT545Bohao6ImXer6+UtkyYyo2QdbGWXABTP7SqhW
CD0ZwoUvhWAoR1Vq/gJ5XXJiVQYvH5iCKB+HRzGI9UWCSFbcGJv4DgikxrIxEfEH
5Yv8LIWBjhW1OnKbmCwT9g0/RT2+XVioWua6EggF7dK11JjpQmF1wyDnZ4LkIyWP
ZaZoBDnO7iU/Sk6DgsXhYCdrmS940MWxUe0INpYEp3K27vIUAUgj5c635pOWvDrI
fCk74FHbs49N9ESHD+NTEy59lblVuYRUFoK21GgGzgO9ual7CENc4rOXWnJpXhlo
VyNl4C4Jvl3olYbVlTZPszZxYOGkzJbjriKnbH95EOzdbMn4gQmrw49uslu1tTk/
j4e52Enu797dKSUbvZc1uoh2ruPkksvAbsiB5CHuCkyaCB2bVEX6QCQ9fWvFGEc1
ony2kQcljVyg5kLOS9qEf3FCVrijCU1Ui2kGVAIcPscr1zBonZ+ReQknqKVkHfgF
tiqzxEe6uam8/INZsnHHcKRmplPDLp5/Y4vsFW0jLpjyAomtd/w=
=hZwC
-----END PGP SIGNATURE-----

--fjlgoi4mnlire24r--

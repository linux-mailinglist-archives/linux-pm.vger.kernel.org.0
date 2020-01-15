Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4A13CE45
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgAOUu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgAOUu6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jan 2020 15:50:58 -0500
Received: from earth.universe (dyndsl-095-033-170-011.ewe-ip-backbone.de [95.33.170.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3852F2051A;
        Wed, 15 Jan 2020 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579121457;
        bh=IGaSv9YovIQR3MVH6A8i1W4/xbBl3F5OhDJks5gzi1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1gc1bFTtZbRnHs0dFsDSkqdFh96xdHNLPC6Vm8IA70ltCpFlEh6A+WaeNajEOgGSo
         zvhAj1bzqJAxov982IuLn/7Eot3OdgL3Xvf+MaNFmwmInuOjPi+5PHD4YseqUdh40J
         yUzPqBsem7la16TnnSwPOaPwDdnXABXGjWr1jae8=
Received: by earth.universe (Postfix, from userid 1000)
        id 8F46F3C0C7C; Wed, 15 Jan 2020 21:50:55 +0100 (CET)
Date:   Wed, 15 Jan 2020 21:50:55 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: bq25890_charger: Add support of
 BQ25892 and BQ25896 chips
Message-ID: <20200115205055.f5dgjeenj3r2l2f4@earth.universe>
References: <20200101224627.12093-1-jekhor@gmail.com>
 <20200102135335.GA13218@jeknote.loshitsa1.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wc3ztikgyf3eauw5"
Content-Disposition: inline
In-Reply-To: <20200102135335.GA13218@jeknote.loshitsa1.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wc3ztikgyf3eauw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, queued to power-supply's for-next branch.

On Thu, Jan 02, 2020 at 04:53:35PM +0300, Yauhen Kharuzhy wrote:
> On Thu, Jan 02, 2020 at 01:46:25AM +0300, Yauhen Kharuzhy wrote:
> > Support BQ25892 and BQ25896 chips by this driver. They shared one chip
> > ID 0, so distinquish them by device revisions (2 for 25896 and 1 for
> > 25892).
> >=20
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  drivers/power/supply/bq25890_charger.c | 97 ++++++++++++++++++++------
> >  1 file changed, 76 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/sup=
ply/bq25890_charger.c
> > index 9d1ec8d677de..a3dcd4eb1287 100644
> > --- a/drivers/power/supply/bq25890_charger.c
> > +++ b/drivers/power/supply/bq25890_charger.c
> > @@ -25,12 +25,20 @@
> >  #define BQ25895_ID			7
> >  #define BQ25896_ID			0
> > =20
> > +enum bq25890_chip_version {
> > +	BQ25890,
> > +	BQ25892,
> > +	BQ25895,
> > +	BQ25896,
> > +};
> > +
> ...
> > +static int bq25890_get_chip_version(struct bq25890_device *bq)
> > +{
> > +	int id, rev;
> > +
> > +	id =3D bq25890_field_read(bq, F_PN);
> > +	if (id < 0) {
> > +		dev_err(bq->dev, "Cannot read chip ID.\n");
> > +		return id;
> > +	}
> > +
> > +	rev =3D bq25890_field_read(bq, F_DEV_REV);
> > +	if (rev < 0) {
> > +		dev_err(bq->dev, "Cannot read chip revision.\n");
> > +		return id;
> > +	}
> > +
> > +	switch (id) {
> > +	case BQ25890_ID:
> > +		bq->chip_version =3D BQ25890;
> > +		break;
> > +
> > +	/* BQ25892 and BQ25896 share same ID 0 */
> > +	case BQ25896_ID:
> > +		switch (rev) {
> > +		case 0:
> Sorry, typo here: should be 2 for 25896, I will fix this in v2.

I fixed this while applying.

-- Sebastian

> > +			bq->chip_version =3D BQ25896;
> > +			break;
> > +		case 1:
> > +			bq->chip_version =3D BQ25892;
> > +			break;
> > +		default:
> > +			dev_err(bq->dev,
> > +				"Unknown device revision %d, assume BQ25892\n",
> > +				rev);
> > +			bq->chip_version =3D BQ25892;
> > +		}
> > +		break;
> > +
> > +	case BQ25895_ID:
> > +		bq->chip_version =3D BQ25895;
> > +		break;
> > +
> > +	default:
> > +		dev_err(bq->dev, "Unknown chip ID %d\n", id);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> ...
>=20
> --=20
> Yauhen Kharuzhy

--wc3ztikgyf3eauw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4fey8ACgkQ2O7X88g7
+ppMihAAlbu7Cj5kznupKUuThBs3gO5ztHxbvrKZFRByg+VOKZrlZiSsRBW4xiBP
uRVBNauM9UIxTb3pCtIuC4goV2sL0v6vBW21+xChmvFXkk0y9DBTpuw5w7mNVPRt
tGo6kdZ4qrbqUt0yzumysR3XA5OFgKwH4QeDuw/VciSUS15TFLEViC8kEc5PMhtr
J8FGh1RPDVPKJ1plggE7aJBKWB2cXG1Z/BPISVc/eoDdUKUCF6dc4aF6x2l1E6BQ
eiZCI0m/62dF7f9hXUxtHO+w3UL0SlF94Q2GjutD4WDLQp0tymtI7bZmlIJ6C8KA
BirDA6DUzllAsjUuDvaLYzoqIG9VA2ew9OAreYadOxopZgTZgozLMt4Y181RxJ9R
TMvzsJgZa0+aWcETPCzX9v1UNvdYFig5Fsd5OBM1ntV4ddqNkqleG01BjRCFi4zs
KfpAZFCgl/n7VGR04NSjCq+7pXDawpkkme3K61Jf65zfoYmb3sedZWy7UuKArAep
R3iWBHPp/+Z8Lw7cdurykYodwd8+9AN3N2YT3Efzmf+0JHwUvsgpzMcjF+jcS11x
+RTYDvpuBxHoztwAhm03KBBbTmpTOe5O3BAaIC7zQRI0E/0d9QXX6KWVYVfNJvsD
8oI/F7xnYqEs7/tZziiUAU1Arzt5XRFqedX2SMAs9NGXtpjmZUQ=
=zGq6
-----END PGP SIGNATURE-----

--wc3ztikgyf3eauw5--

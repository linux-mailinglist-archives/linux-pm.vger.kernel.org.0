Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947DC1CBBB6
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 02:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgEIAPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 20:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbgEIAPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 20:15:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52FC061A0C;
        Fri,  8 May 2020 17:15:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 203592A33A3
Received: by earth.universe (Postfix, from userid 1000)
        id 9BE163C08C6; Sat,  9 May 2020 02:15:29 +0200 (CEST)
Date:   Sat, 9 May 2020 02:15:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: bq25890: unlock on error paths in bq25890_resume()
Message-ID: <20200509001529.vikzemeiifyfp4fs@earth.universe>
References: <20200506101116.GA77004@mwanda>
 <20200506122019.GB18376@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="os2uun2xexgi6yf2"
Content-Disposition: inline
In-Reply-To: <20200506122019.GB18376@qmqm.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--os2uun2xexgi6yf2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 06, 2020 at 02:20:20PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Wed, May 06, 2020 at 01:11:16PM +0300, Dan Carpenter wrote:
> > We introduced some new locking here, but need to update the error
> > paths so they unlock before returning.
>=20
> Reviewed-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Thanks, queued.

-- Sebastian

> > Fixes: 72d9cd9cdc18 ("power: bq25890: protect view of the chip's state")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/power/supply/bq25890_charger.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/sup=
ply/bq25890_charger.c
> > index 9339e216651ff..20b9824ef5acd 100644
> > --- a/drivers/power/supply/bq25890_charger.c
> > +++ b/drivers/power/supply/bq25890_charger.c
> > @@ -978,21 +978,22 @@ static int bq25890_resume(struct device *dev)
> > =20
> >  	ret =3D bq25890_get_chip_state(bq, &bq->state);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto unlock;
> > =20
> >  	/* Re-enable ADC only if charger is plugged in. */
> >  	if (bq->state.online) {
> >  		ret =3D bq25890_field_write(bq, F_CONV_START, 1);
> >  		if (ret < 0)
> > -			return ret;
> > +			goto unlock;
> >  	}
> > =20
> >  	/* signal userspace, maybe state changed while suspended */
> >  	power_supply_changed(bq->charger);
> > =20
> > +unlock:
> >  	mutex_unlock(&bq->lock);
> > =20
> > -	return 0;
> > +	return ret;
> >  }
> >  #endif
> > =20
> > --=20
> > 2.26.2
> >=20

--os2uun2xexgi6yf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl619iEACgkQ2O7X88g7
+poabw/+ImmnCtrv3oeQlxgy1kvUmLKF+VY8OcGAGt+GHgx4XNKwXKaKcX4vSff2
82m0CZAQsJWkItPv2ImEBf/X6ikWQAay6xtFLV5DuHG6YqcgCMvE4grl2T1pwoMh
Gj4uutn4N5a5zXBfm7dtMImwOpwnNIDCxbl2DFWhYrrH8h1pVnYVzU7ryfSu9EUm
/z7ouvMuAKHI9Sb/pCaEGOU2GyzSBwdbFzFSGtSCiLFUxxdA5r/7U9Wz794LpoTG
LRav7bQMeAJvJrHTmuHxZMtEiDil2qlXl8URvc7qAmPc6h+GbJrYOPZz9k94z8YS
h0JUxybdaSmwuEVtTXJiEHO3GcHsrJphqEvnhOIHZQwr680Sjsf9HME8YCMCjyHb
ce7y3GxGH5ip05/en28f0TObHHupwSPDRSBO2p/4jloWiwkBU0UWkowzWJV+qBLc
jOf0hJKBJ0b9bJbQnPdzzx4+QQNdGVUrwY+erXSFXmm8fnaQ84y7+rCD07+O5gLV
604U4PA/QxXyr7CZ6JGsPVryBjhopqp28k+2zwoZYGzEklTOZjXbLn8jn/CKuPIH
H5owsCiI/+oTKwFfRJgjCGwuIDXvBORJAfkirrMaxPK0XoEgKIqzemPPQ8CBW+od
Wsgq19OUxBxhPRTe9QBe2Sk6xtCzh57N0+vHYhrZg1kVB0gOll4=
=h8Do
-----END PGP SIGNATURE-----

--os2uun2xexgi6yf2--

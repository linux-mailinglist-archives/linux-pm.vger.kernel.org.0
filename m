Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569B41E6850
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405292AbgE1RHn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405353AbgE1RHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 13:07:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF29C08C5C6;
        Thu, 28 May 2020 10:07:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D51192A40C2
Received: by earth.universe (Postfix, from userid 1000)
        id 37F423C08C7; Thu, 28 May 2020 19:07:38 +0200 (CEST)
Date:   Thu, 28 May 2020 19:07:38 +0200
From:   "sre@kernel.org" <sebastian.reichel@collabora.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "zou_wei@huawei.com" <zou_wei@huawei.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] power: supply: Make bd9995x_chip_reset static
Message-ID: <20200528170738.32oxzc5qdumhpm2r@earth.universe>
References: <1589195577-8723-1-git-send-email-zou_wei@huawei.com>
 <ff7faf0add4155a10e3df12fceea8bda17050021.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dxex3npwl3gkrjhu"
Content-Disposition: inline
In-Reply-To: <ff7faf0add4155a10e3df12fceea8bda17050021.camel@fi.rohmeurope.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dxex3npwl3gkrjhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2020 at 11:22:26AM +0000, Vaittinen, Matti wrote:
> On Mon, 2020-05-11 at 19:12 +0800, Samuel Zou wrote:
> > Fix the following sparse warning:
> >=20
> > drivers/power/supply/bd99954-charger.c:1028:6: warning: symbol
> > 'bd9995x_chip_reset' was not declared.
> >=20
> > The bd9995x_chip_reset() has only one call site within bd99954-
> > charger.c
> > It should be static
> >=20
> > Fixes: 0902f8366491 ("power: supply: Support ROHM bd99954 charger")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Samuel Zou <zou_wei@huawei.com>
>=20
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Thanks, queued.

-- Sebastian

> > ---
> >  drivers/power/supply/bd99954-charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/bd99954-charger.c
> > b/drivers/power/supply/bd99954-charger.c
> > index 3da39c7..ffd8bfa 100644
> > --- a/drivers/power/supply/bd99954-charger.c
> > +++ b/drivers/power/supply/bd99954-charger.c
> > @@ -1025,7 +1025,7 @@ static int bd9995x_fw_probe(struct
> > bd9995x_device *bd)
> >  	return 0;
> >  }
> > =20
> > -void bd9995x_chip_reset(void *bd)
> > +static void bd9995x_chip_reset(void *bd)
> >  {
> >  	__bd9995x_chip_reset(bd);
> >  }
>=20

--dxex3npwl3gkrjhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7P79oACgkQ2O7X88g7
+pqj7A//QIQeWhIyRQRuOKZY2FpRD24XWskaevbRknmfHHWTFwJN8QeANMtLDoos
itYffuxiLJkGIjXQ9MVk4bfu21JjEMw7lrSIZ5lMN/qEQtTyJIyEke2ZBUSUaDR1
gkRz3cYfK85H17FsceedBLlUmAkvQxlZAUyJuz5CleB6HALADVJ9QDJG9NFDgAPf
hxRf66ePHdA6ryji2KU3nkAG+0hFYfc5z1K8oWm2I51HYzbCs0A2P0l8+zUgq852
MV7IwNIH8FaHdI993nxVjjfExuA28n6HNA3E7X9bLcCpQA+SZLOyNS7YaNjYryy3
8zpNVTxXj9RdPtKqIpPqpFWkZYAQ+23suMjBpFwxBqLc090b47LEbvnHJ1LGal4C
TAJHKkZWKvuaLqVLfQadGen6CuLGzNPiTnUjecDJ1GHfImbyHud36kt+J6bCUXIE
QyBu1R/Kpw2KSrbpjBduMdiCQUo9g6ocpvJDB47rP7x7lqR0WmG/H1tZTmreD2dB
zRIfeBonlz11Q4RfK2BnB6kcMkk3mR1xGInDFkulEO1FeQsBPUKQTWv1CKL4NNdk
0tnzw5h4VoxdjYkx+qpJfUjUdLFi2ljiMNorzdSFtrJFp6424vBWDKlTRWAEACI5
31nT44oZ7580kvnX3tBVJUxJi/M5kr/ZtPFu0CYq8LdeeGSINsE=
=1rwd
-----END PGP SIGNATURE-----

--dxex3npwl3gkrjhu--

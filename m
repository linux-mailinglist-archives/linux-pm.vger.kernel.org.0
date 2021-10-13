Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24A942C170
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhJMNfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 09:35:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37116 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMNfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 09:35:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 914831F445DD
Received: by earth.universe (Postfix, from userid 1000)
        id E68DE3C0CA8; Wed, 13 Oct 2021 15:33:13 +0200 (CEST)
Date:   Wed, 13 Oct 2021 15:33:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, Kate Hsuan <hpa@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] power: supply: axp288_charger: Fix missing
 mutex_init()
Message-ID: <20211013133313.hao3uvvi65tufgy7@earth.universe>
References: <20211013093115.2841167-1-weiyongjun1@huawei.com>
 <d3690325-9d55-607b-cf51-048f634ef7b5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da2hjslt5ssl5lky"
Content-Disposition: inline
In-Reply-To: <d3690325-9d55-607b-cf51-048f634ef7b5@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--da2hjslt5ssl5lky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 13, 2021 at 01:49:19PM +0200, Hans de Goede wrote:
> On 10/13/21 11:31 AM, Wei Yongjun wrote:
> > The driver allocates the mutex but not initialize it.
> > Use mutex_init() on it to initialize it correctly.
> >=20
> > Fixes: ed229454856e ("power: supply: axp288-charger: Optimize register =
reading method")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Thanks, patch looks good to me
> (I should have catched this myself during review...) :
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

> > ---
> >  drivers/power/supply/axp288_charger.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supp=
ly/axp288_charger.c
> > index fd4983c98fd9..9987b1731e38 100644
> > --- a/drivers/power/supply/axp288_charger.c
> > +++ b/drivers/power/supply/axp288_charger.c
> > @@ -865,6 +865,7 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
> >  	if (!info)
> >  		return -ENOMEM;
> > =20
> > +	mutex_init(&info->lock);
> >  	info->pdev =3D pdev;
> >  	info->regmap =3D axp20x->regmap;
> >  	info->regmap_irqc =3D axp20x->regmap_irqc;
> >=20
>=20

--da2hjslt5ssl5lky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFm4A4ACgkQ2O7X88g7
+pov7w//aHCvOeO3CsuC5GVCwcPl+gLAEZmUgpHaBojLoq5uFPXjScJSIeAaNmwg
werUUBa5TMwijjxRJ5vh+X5FNGCwnLxVgUxxujpQXRbX/Hb/Sx9IJRkdxY84XjGr
mCcrORwXnAhKjgfgOvjLHebu5Igh9Oc+2PlIwg27k9mw1+DrOdDFqtc3cfLmANJk
rW2dvpVrcgN7QMMPfjT8BCOFA0q/xawTTd6ESUMhQN0GcOldBCvVdfq++sodoLGx
QrdM2TSuu9zIMYl544XqVKck/9UJ0u28jsyikWdfFQldB0vJ1Ab03nrG36XWuKUw
s/Mx2R+I5Bt8a0Ot/wQIw8hf2IVIxPEY0wjbRmgSRF8u8/a5I2sm3LyIh1BQjBkp
y70sI9LzxHRvYBe0ZxJvajQcjVIR3DtJh32uDX809CilYifMwHZkxhB04BMwfuhJ
eQ0GlyKHKbgUzHqYUjaujJEzY+cKKNYFwIhnKaUoYn5VKwMHu3TQKvPWNfmB6D2c
E+2gTaVjvroKmQxz1+ysVxPzB7BDATY40hixE9dVONzeRCxugTodDPlcpWkFPiXO
Nb9VWIOep1f7cZLsHP7qFmSkZ6unjymsM4wJhDxk9qJnO2xhoVFWnB0ZfLqECKyH
3S+JfDJ5gZ2gca4TKl2kdBqaQrNKouCHhEE9nbSgxzvIY6OzPRE=
=d6j4
-----END PGP SIGNATURE-----

--da2hjslt5ssl5lky--

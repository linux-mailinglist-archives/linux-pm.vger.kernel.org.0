Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4911C2F66
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECVOJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 17:14:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50480 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgECVOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 17:14:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6C1A52A083E
Received: by earth.universe (Postfix, from userid 1000)
        id 28CC63C08C7; Sun,  3 May 2020 23:14:05 +0200 (CEST)
Date:   Sun, 3 May 2020 23:14:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 06/11] power: bq25890: update state on property read
Message-ID: <20200503211405.zegrp7e7hiy5whht@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <5c8e8f4c5a7fc2cecb62342f9a964f69f3fde7ae.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lf2y2viymq2wjzo"
Content-Disposition: inline
In-Reply-To: <5c8e8f4c5a7fc2cecb62342f9a964f69f3fde7ae.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3lf2y2viymq2wjzo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:12PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Edge interrupts from the charger may be lost or stuck in fault mode
> since probe(). Check if something changed everytime userspace wants
> some data.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 3b02fa80aedd..e4368d01396a 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -389,6 +389,8 @@ static bool bq25890_is_adc_property(enum power_supply=
_property psp)
>  	}
>  }
> =20
> +static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq);
> +
>  static int bq25890_power_supply_get_property(struct power_supply *psy,
>  					     enum power_supply_property psp,
>  					     union power_supply_propval *val)
> @@ -399,6 +401,8 @@ static int bq25890_power_supply_get_property(struct p=
ower_supply *psy,
>  	int ret;
> =20
>  	mutex_lock(&bq->lock);
> +	/* update state in case we lost an interrupt */
> +	__bq25890_handle_irq(bq);
>  	state =3D bq->state;
>  	do_adc_conv =3D !state.online && bq25890_is_adc_property(psp);
>  	if (do_adc_conv)
> --=20
> 2.20.1
>=20

--3lf2y2viymq2wjzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vNB0ACgkQ2O7X88g7
+pogFw/9GVb8Bdes1EnvpGaiNkrb5RcfYkYaTK1/wLA+c+XWm1b6w6INniLUXy6G
b+gyHI2L5IdRtDWrcTLPXJOXz2GYcow0Fe9Lhtrn9KHKT18wM/eummyU/6JpVaqj
oZxUR/dBIV+0reHLCdSCuXzS0ZPxBDiiBS4NVcYwnlcy94uqguHOyzvK/QYOljhv
lFvYz8qNO3Ye1VxsCmETSMA9VZ7drPKqUr9NKky1wAEQmPdoyhXK2maqkulGJmzo
7k0Df3sFGwECctpDy5nT7y/TnH0t6WqES3sCWI5VSpKCFJkG3OnEYCkZXk4wNU9l
/wBKpqMmqlYK6NwaZHTHcYdhpxhUxxOfjuv1gDNuFk/1OUfyZqt9u1YEKCrHzK1C
5RzkzwO7rI0aBhi0Cw0UB1ki98NVxacehyB7meJHWmtMqwNJNrNjkV3K00FpmX0c
JMJYfYduFnZ5VT2oK66cB+ZaSbHfuTcjcQA65TeNG5Nil/ypXenhXCnd+dDRctsw
TMhr1x62B+ENt7psOBhCt2NPoTIGs3e+5isRIF34Jy9gaS1YNdrJgFBrWWIalx9N
dG0FggrFIKljQNY47atO9lJTJvGfwtmmlku8iG/iNRGDRvl1yWJZ3HGYHbye1IX1
QjWgOBB+CHph2g02x13fiObuCXhnzD0jaR5v4NCRMum4OEirmyg=
=wt7W
-----END PGP SIGNATURE-----

--3lf2y2viymq2wjzo--

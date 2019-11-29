Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCC210D9A6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 19:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK2Sdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 13:33:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40054 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK2Sdp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 13:33:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0AED228C03C
Received: by earth.universe (Postfix, from userid 1000)
        id 40A483C0C78; Fri, 29 Nov 2019 19:33:40 +0100 (CET)
Date:   Fri, 29 Nov 2019 19:33:40 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Message-ID: <20191129183340.hsjddxot7ocnxran@earth.universe>
References: <20191117141335.23404-1-matheus@castello.eng.br>
 <20191117141335.23404-5-matheus@castello.eng.br>
 <20191126145200.xqtvfrm6qc6yuutb@earth.universe>
 <c5bb4962-10f7-0877-0c99-c2dad5bb53cf@castello.eng.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcuscrzzo6oezrpv"
Content-Disposition: inline
In-Reply-To: <c5bb4962-10f7-0877-0c99-c2dad5bb53cf@castello.eng.br>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xcuscrzzo6oezrpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 27, 2019 at 10:06:47PM -0300, Matheus Castello wrote:
> [...]
> > > @@ -256,14 +303,26 @@ static int max17040_probe(struct i2c_client *cl=
ient,
> > >=20
> > >   	/* check interrupt */
> > >   	if (client->irq) {
> > > -		int ret;
> > > -
> > > -		ret =3D max17040_enable_alert_irq(chip);
> > > -
> > > -		if (ret) {
> > > -			client->irq =3D 0;
> > > +		if (of_device_is_compatible(client->dev.of_node,
> > > +					    "maxim,max77836-battery")) {
> > > +			ret =3D max17040_set_low_soc_alert(client,
> > > +							 chip->low_soc_alert);
> > > +			if (ret) {
> > > +				dev_err(&client->dev,
> > > +					"Failed to set low SOC alert: err %d\n",
> > > +					ret);
> > > +				return ret;
> > > +			}
> > > +
> > > +			ret =3D max17040_enable_alert_irq(chip);
> > > +			if (ret) {
> > > +				client->irq =3D 0;
> > > +				dev_warn(&client->dev,
> > > +					 "Failed to get IRQ err %d\n", ret);
> > > +			}
> > > +		} else {
> > >   			dev_warn(&client->dev,
> > > -				 "Failed to get IRQ err %d\n", ret);
> > > +				 "Device not compatible for IRQ");
> >=20
> > Something is odd here. Either this should be part of the first
> > patch ("max17040: Add IRQ handler for low SOC alert"), or both
> > device types support the IRQ and this check should be removed.
>=20
> The first patch add the IRQ without the configuration of the low SoC aler=
t,
> using the default state of charge level. This patch is working with
> registers to config the low state of charge level, so it was proposed to
> just try to write registers in the models compatible with that
> (maxim,max77836-battery).
>=20
> Maybe join the first patch to this one, and let DT binding be the first
> patch on the series so we can already test compatible here, let me know w=
hat
> you think about it.

Assuming the !max77836 do not have any interrupt support, you can
just add the OF check in the first patch in "if (client->irq)", so
that it reads=20

if (client->irq && of_device_is_compatible(...)) {
    ...
}

-- Sebastian

--xcuscrzzo6oezrpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3hZIAACgkQ2O7X88g7
+pqwQQ/+JvYfTlob8QpLMuveqR4F7Jz+118C4j8H6w4xx8uCSp/xPQSxGSQ7zSIg
mrAm5+YQnm12m4e2nZwdLNAkePuW++O+U9was7s0TUsjVFRC4tQhtwo+LIAbirBz
RjqOm7tzZnTGu2w6Bhfoe3iyIRvNxELaEl4jk1iEV1qgn6G+z55p6Z6KpbMKWxKu
8PKEtmZdeN9s9fZQdkyukjvPAs23E2pUB8a++mc7Y5kML6xMMwqnR6Wn+MzaJgq9
7jL1dNZJ///rH/3JtOr/F237jAZdFdocwIhzS+uDYIU2FxC3WYu3/lD8TMXmWeBb
kYwOUHDvSx2sh1Bx52UyKvLT1rAtSIbp/u2NbOj9w3zB7k+cl9ePqw7HqiJlZ11d
V8T93H6bQvCXbftcSAvtRUA8HKh1HSO8o1U8+RMtBxz1y6B2LqNfD4dFT+wltWSj
Q+HyuzGfz6mrFQ3owFmohyeOSOC1FHJa6Fc1Z40obR3XKYBBMrO+8qXckTim9/dk
SsPF7E0O6UNJyqthzw9HL1R99F7AX9JX2fjOMAsWpVvoaDEqDkt3Ebt96Gl/YvRL
x+/+cWQSwGxikSHdDg6drOOYQri/jzySqwFJJhCtvnjqXGRUCRFxgluAIzy4qDBf
+67VS9ef6Xd2QDlxOPjxRAeqOYbCz6Z8v91q2s0FfS/uC5r7jCo=
=+2/E
-----END PGP SIGNATURE-----

--xcuscrzzo6oezrpv--

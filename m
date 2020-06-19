Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AB320163F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389963AbgFSQ21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394951AbgFSQ2Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 12:28:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E64C06174E;
        Fri, 19 Jun 2020 09:28:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 542132A54CA
Received: by earth.universe (Postfix, from userid 1000)
        id CAF173C08CD; Fri, 19 Jun 2020 18:28:20 +0200 (CEST)
Date:   Fri, 19 Jun 2020 18:28:20 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/6] power: supply: gpio-charger: add
 charge-current-limit feature
Message-ID: <20200619162820.hhv5rftp4xkhwtix@earth.universe>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
 <20200605224403.181015-4-sebastian.reichel@collabora.com>
 <20200615175844.GA2032047@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yyzsddwp6z7jengx"
Content-Disposition: inline
In-Reply-To: <20200615175844.GA2032047@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yyzsddwp6z7jengx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 15, 2020 at 11:58:44AM -0600, Rob Herring wrote:
> On Sat, Jun 06, 2020 at 12:44:00AM +0200, Sebastian Reichel wrote:
> > Add new charge-current-limit feature to gpio-charger.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/power/supply/gpio-charger.yaml   |  31 ++++
> >  drivers/power/supply/gpio-charger.c           | 140 ++++++++++++++++++
> >  2 files changed, 171 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charge=
r.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > index 30eabbb14ef3..e11cfdc68a51 100644
> > --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > @@ -39,6 +39,25 @@ properties:
> >      maxItems: 1
> >      description: GPIO indicating the charging status
> > =20
> > +  charge-current-limit-gpios:
> > +    minItems: 1
> > +    maxItems: 32
> > +    description: GPIOs used for current limiting
> > +
> > +  charge-current-limit-mapping:
> > +    description: List of touples with current in uA and a GPIO bitmap =
(in
>=20
> s/touples/tuples/
>=20
> > +      this order). The touples must be provided in descending order of=
 the
>=20
> and here.

Ack.

> > +      current limit.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    items:
> > +      items:
> > +        - description:
> > +            Current limit in uA
> > +        - description:
> > +            Encoded GPIO setting. Bit 0 represents last GPIO from the
> > +            charge-current-limit-gpios property. Bit 1 second to last
> > +            GPIO and so on.
>=20
> Seems a bit odd that bit N doesn't represent index N of the gpios.

I was looking at it from a graphical POV (i.e. "last" bit represents
last element):

list =3D <element3, element2, element1, element0>;
bits =3D 0b1011; // element3, 1 and 0

Basically when writing it the order is the same at the cost of list
index being reverse of bit index. But I do not really mind the order.
If people think its better the other way around I can swap it.

-- Sebastian

> > +
> >  required:
> >    - compatible
> > =20
> > @@ -47,6 +66,12 @@ anyOf:
> >      - gpios
> >    - required:
> >      - charge-status-gpios
> > +  - required:
> > +    - charge-current-limit-gpios
> > +
> > +dependencies:
> > +  charge-current-limit-gpios: [ charge-current-limit-mapping ]
> > +  charge-current-limit-mapping: [ charge-current-limit-gpios ]
> > =20
> >  additionalProperties: false
> > =20
> > @@ -60,4 +85,10 @@ examples:
> > =20
> >        gpios =3D <&gpd 28 GPIO_ACTIVE_LOW>;
> >        charge-status-gpios =3D <&gpc 27 GPIO_ACTIVE_LOW>;
> > +
> > +      charge-current-limit-gpios =3D <&gpioA 11 GPIO_ACTIVE_HIGH>,
> > +                                   <&gpioA 12 GPIO_ACTIVE_HIGH>;
> > +      charge-current-limit-mapping =3D <2500000 0x00>, // 2.5 A =3D> b=
oth GPIOs low
> > +                                     <700000 0x01>, // 700 mA =3D> GPI=
O A.12 high
> > +                                     <0 0x02>; // 0 mA =3D> GPIO A.11 =
high
> >      };

--yyzsddwp6z7jengx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s55sACgkQ2O7X88g7
+posXxAAimYGCMZqPCMGM572BWT84enhMCGLDZmbHF2T+nErP9bjg6Kl/7chCfr6
YtyFPcX5kAhq4yCwymzAEWjsnmo4Vn01XcXCvXZkUy9TZYyxTpqLN5IQupFoe1h6
QbP54+FosPdTsf2Yvm7QVyDxlbYMpuPPpU95jZRBtl4zsP5VGeZMwe0Ohf5x//aT
qBL/nY/l06OVq/pKV1OjfvAu6P4G1OkKnNw+AJ+itTZWZi+0I5xfsWZJ6Q9qHCXq
Gew48sWBTKQS4jLECNZuA7GcdYxNdjh8yl8t2jNCAw4WL7uSHL1wBBkzUmYjGB2h
qF5Q8w48iI3Dl2VwEvUp52Ca/AGu98e5gJp0QBqYUUxojZ15m4jbYk4elu05vb+v
kVdFvtpVWAhRChbiw7+PmOR+4WBC8d3CxpTgbGcFgort3mNPer8b1eS5YmA1eko9
d5Lb4xsw72+PrdSOdVFOqLW0jduAhlJuZfpnaStzfBO+YZWPJrkkmr78GZ/oIRrg
Tv78EKJ0ppyDv7wSev+4FbhsrneE16fJ6EoXrMwHzQt310wXam/bZu9ffzALPCsw
eNZFiCNV+0AXyziGJ9OLJQCVchgt5KgwkwDv0eVhDPZ6qUl7aG7lmCcVuFZrvFnB
v5BSRmZ3xE10iEmifEEhYlA4LYc/zFjdtWexbmc6Fj230KbY3zQ=
=3lsp
-----END PGP SIGNATURE-----

--yyzsddwp6z7jengx--

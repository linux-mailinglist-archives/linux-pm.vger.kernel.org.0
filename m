Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97E42A898
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhJLPmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhJLPmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 11:42:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037DC061749;
        Tue, 12 Oct 2021 08:40:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D17CC1F417F8
Received: by earth.universe (Postfix, from userid 1000)
        id 629A43C0CA8; Tue, 12 Oct 2021 17:40:36 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:40:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH 1/2] MAINTAINERS: power: supply: max17042: add entry with
 reviewers
Message-ID: <20211012154036.hyaabb6okzcgdlyw@earth.universe>
References: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
 <4803957.ieAp1BVO2D@pliszka>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xhbccxcdgg4mxxpl"
Content-Disposition: inline
In-Reply-To: <4803957.ieAp1BVO2D@pliszka>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xhbccxcdgg4mxxpl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 25, 2021 at 02:31:44PM +0200, Sebastian Krzyszkowiak wrote:
> On pi=C4=85tek, 24 wrze=C5=9Bnia 2021 13:56:18 CEST Krzysztof Kozlowski w=
rote:
> > The Maxim max17042 fuel gauge driver supports several devices used on
> > multiple different boards - both devicetree and ACPI based.  The driver
> > is incomplete and has few known issues.  Fixing these might break other
> > platforms so mention recent contributors who can provide feedback.  This
> > way most of interested parties might help reviewing the patches.
> >=20
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 329d3a0a9fdb..da9d5383af04 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11429,6 +11429,16 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/proximity/
> maxbotix,mb1232.yaml
> >  F:	drivers/iio/proximity/mb1232.c
> >=20
> > +MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
> > +R:	Hans de Goede <hdegoede@redhat.com>
> > +R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > +R:	Marek Szyprowski <m.szyprowski@samsung.com>
> > +R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>=20
> I think it may be worth adding:
>=20
> +R:	Purism Kernel Team <kernel@puri.sm>
>=20
> In any case:
>=20
> Reviewed-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Thanks, I queued both patches with the Purism Kernel Team added for
MAX17042.

-- Sebastian

--xhbccxcdgg4mxxpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFlrHQACgkQ2O7X88g7
+poRkw/+Mj5EPHQWa3zLPFmetZ9uwwHBoh9GjLW56m8qFf3n+PxtV5Mpso2w+rMx
gndUO7jro2+TdKjflLhV8/zKHeuxI3ft1A+BfpaUmGOuI2N12CYBWBMzrlq7EWaK
ckFXOjZ0pLC71qkU2Ewp1hhEbmOLiD/hzJNBSjcfESsH5Ikwq1djqD/o0LwigDkO
jmLCqCVAsh8HNR14Eo1ahQRbrh/RkBeRt/prk0z7Duwkyf3bq2jFxVRm8VvSEFEO
jnqpPz43QZb46kr2xZ9xqF6tRBBH3vl7KWNERPgat6MCtY/yRfdcLR94ORfUynjg
D+TyoaiHMCecPG//8j7t1bUsXwJM86h21Eo37p1y4FLZDBWB6k5yaPKpyayOe6A6
6nqM1MU/b4XAt16pT6WShQ4MtkScJhIfmfv9yksB6kvhbKaEiBhua0LCgy7tPuOb
L85OJSPLMAGbYW1wl9M5BBKPdOJ0Mx359eUlVvyaWxWrmOron+VVlgS5iR+pQmBE
rdxqcsTOEcmmZm10kr841mCfNShhTlMnXwZVFONTEANCYdHkCr+Qghr1l2xaP+/Y
GxdRDnfpsItbHdUhfL+MEpnozYoVnCu1rgdOva5mHr8nmlCe+ylJc6/7+mnhhTmf
+6b0pmV/EcqwVQSQWHHHHG2DiViWoVZ3m7ZuelF89q4w2szns94=
=nF7O
-----END PGP SIGNATURE-----

--xhbccxcdgg4mxxpl--

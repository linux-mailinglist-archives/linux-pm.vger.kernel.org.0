Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED75639B661
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhFDKDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFDKDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:03:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB3C06174A;
        Fri,  4 Jun 2021 03:01:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8A4461F43856
Received: by earth.universe (Postfix, from userid 1000)
        id F19F33C0C95; Fri,  4 Jun 2021 12:01:26 +0200 (CEST)
Date:   Fri, 4 Jun 2021 12:01:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] power: supply: max17040: Do not enforce
 (incorrect) interrupt trigger type
Message-ID: <20210604100126.uh6ky5633cci76jz@earth.universe>
References: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
 <20210526172036.183223-8-krzysztof.kozlowski@canonical.com>
 <20210602200609.GA3900200@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5z3bvd56oibiykjk"
Content-Disposition: inline
In-Reply-To: <20210602200609.GA3900200@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5z3bvd56oibiykjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 02, 2021 at 03:06:09PM -0500, Rob Herring wrote:
> On Wed, 26 May 2021 13:20:36 -0400, Krzysztof Kozlowski wrote:
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> >=20
> > Interrupt line can be configured on different hardware in different way,
> > even inverted.  Therefore driver should not enforce specific trigger
> > type - edge falling - but instead rely on Devicetree to configure it.
> >=20
> > The Maxim 14577/77836 datasheets describe the interrupt line as active
> > low with a requirement of acknowledge from the CPU therefore the edge
> > falling is not correct.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Iskren Chernev <iskren.chernev@gmail.com>
> >=20
> > ---
> >=20
> > Changes since v1:
> > 1. Remove the 'flags' variable.
> > 2. Added ack.
> > 3. Rebase - the bindings were converted to dtschema.
> > ---
> >  .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 2 +-
> >  drivers/power/supply/max17040_battery.c                       | 4 +---
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--5z3bvd56oibiykjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5+fYACgkQ2O7X88g7
+ppwug//XIycwF2DpnZ+rz60BboIbDdef0QCwTZTOaRDHI2dNpG4xQ/Eizaq8Wj6
pcP+D6ZyqZdK4vwep2YxpM0OfwNCdk/PNHVLxXCjbEeWQLAnpLERzPrQexBdUZF0
s04zSTqPu18GBwt5bZ/qmjYClXontLjzgBddFRYYLqFY+O9taGYVicb+qJ7o1Gd4
JAeXYPuYXjjLMjMN1GOR5lrpOVGt/RNKMWUyBoMqN0sMRZvoAqCLrvP/H2QKJ4xx
EsnHEtV8Z4r1Vk/ykQZ3bTWBtQUs+Z5PsU0jcEPDHejOJI6cExsTBRnx/j3WjUKH
NRpzrf7QsnD6eHWXS2XqzHc8Mn6o6yk+ih6y7S8GdQgZ28NpMktcD0ZD4vq4O1Rg
bjUBJZw6hKV+KjoxEOMZGYxRqBaekGeyElkMH1XFKccKuOdbnWQDoh992yPtWVrz
ZSgIXMg4N94dQ14VUNpG5OrDUnMpzLg5Is0KgWS4kkOvYCjk2aQiljn0GJ70wb9Y
fpa59e0Z3L8RfGdOIT6SlfRBMQOBk7F3l/L42HhRx2QtULhtDdhcKhIssuB2SIsA
Wq1I7hU0Tjraq8yE2GMgFBQ6OjQyjnDDAcvf3EfEWM4wsM/e1OUAyVFuN1q+DBFP
Tf8AgL3pSmU8QCXAvZmXKdxa10rAjpLHsOj/HVtKN6Ufe9rkusk=
=yKFF
-----END PGP SIGNATURE-----

--5z3bvd56oibiykjk--

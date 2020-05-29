Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429A41E7B48
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2LKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 07:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2LKf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 07:10:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA07B20663;
        Fri, 29 May 2020 11:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590750635;
        bh=BY3ChC/IaZNPa69hWhSGAWZe9xHacZ7qkDacn1aMT6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wy5wMivxtP/gY9Qx5SLx5Xh3rPJtZPeilcXR06MG/JumsXxlN93N3zrkaw5q/RcMo
         zuxSs+3pgZAnAyjaB+yhCZER1ehf902wDAJmifRTw0yMoij3gIGZYo2UTw6NNKeKB0
         b/ZsaiAyTrP8hcOMMbc7GJyVS68ovtyKeF4micho=
Date:   Fri, 29 May 2020 12:10:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] regulator: do not balance regulators without constraints
Message-ID: <20200529111031.GI4610@sirena.org.uk>
References: <CGME20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba@eucas1p1.samsung.com>
 <20200528131130.17984-1-m.szyprowski@samsung.com>
 <20200528134338.GD3606@sirena.org.uk>
 <56e496bc-172f-d62f-5376-c8d734af6a51@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <56e496bc-172f-d62f-5376-c8d734af6a51@samsung.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 07:45:06AM +0200, Marek Szyprowski wrote:
> On 28.05.2020 15:43, Mark Brown wrote:

> > This forces every supply to have something which explicitly manages
> > voltages which means that if one of the coupled supplies doesn't really
> > care about the voltage (perhaps doesn't even have any explicit
> > consumers) and just needs to be within a certain range of another supply
> > then it'll end up restricting things needlessly.

> Frankly, that's exactly what we need for Exynos5422 case. If devfreq=20
> driver is not enabled/compiled, we want to keep the "vdd_int" volatage=20
> unchanged. This confirms me that we really need to have a custom coupler=
=20
> for Exynos5422 case. It will solve such issues without adding hacks to=20
> regulator core.

It sounds like you need that or some form of cooperation between the
devfreq and cpufreq drivers.

> > Saravana was trying to do some stuff with sync_state() which might be
> > interesting here although I have concerns with that approach too:

> >     https://lore.kernel.org/lkml/20200527074057.246606-1-saravanak@goog=
le.com/

> This still doesn't solve the above mentioned case.

I didn't mean the particular patch, I meant something using the
sync_state() callback.

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q7aYACgkQJNaLcl1U
h9DSMQgAgbeb3psUrmh+k8IJNk9lxznRjlF9o9ykd+JUnv7FBkSsqc1h45q66Owv
acsuM90K2nI00+p4BOFppnFDdqwDFrVTDxXwXq37zXRy47TS+eOabwD1Ykvvwei1
rQmgVZm/M7hlCawKjyrLAADmWHU7u0tcKAeuCbP7ch1Ze3kyBoeoSOlXcdz3LwAn
ZWTISkGoGoIJLMEehxQAercXRD3JqSQjZcW6W6UugrzL1a1B125hW0MTxItnbRW0
YIIebA+wuOL2jffXjTqP54zNgnS/HC+F3am1lWJhEQX/kcyzZfb6/pK4SWTkvyoO
vwTCMVfZqb9pnKFzvNdcDlrBopclKw==
=dVIH
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8D68EC42
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBHKCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 05:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBHKC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 05:02:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322D3FF2D
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 02:02:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPhHU-0000Cx-Hc; Wed, 08 Feb 2023 11:02:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPhHS-003UDp-C9; Wed, 08 Feb 2023 11:02:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPhHS-001oZD-Sb; Wed, 08 Feb 2023 11:02:22 +0100
Date:   Wed, 8 Feb 2023 11:02:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@deeprootsystems.com>,
        linux-pm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] cpufreq: davinci: Fix clk use after free
Message-ID: <20230208100222.7fclfhv7oxbojrg6@pengutronix.de>
References: <20230208092654.551466-1-u.kleine-koenig@pengutronix.de>
 <20230208094451.wib7on57imsujbaj@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6hns4w24y72knflj"
Content-Disposition: inline
In-Reply-To: <20230208094451.wib7on57imsujbaj@vireshk-i7>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6hns4w24y72knflj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 08, 2023 at 03:14:51PM +0530, Viresh Kumar wrote:
> On 08-02-23, 10:26, Uwe Kleine-K=F6nig wrote:
> > The remove function first frees the clks and only then calls
> > cpufreq_unregister_driver(). If one of the cpufreq callbacks is called
> > just before cpufreq_unregister_driver() is run, the freed clks might be
> > used.
> >=20
> > Fixes: 6601b8030de3 ("davinci: add generic CPUFreq driver for DaVinci")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/cpufreq/davinci-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinc=
i-cpufreq.c
> > index 2d23015e2abd..ebb3a8102681 100644
> > --- a/drivers/cpufreq/davinci-cpufreq.c
> > +++ b/drivers/cpufreq/davinci-cpufreq.c
> > @@ -133,13 +133,13 @@ static int __init davinci_cpufreq_probe(struct pl=
atform_device *pdev)
> > =20
> >  static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
> >  {
> > +	cpufreq_unregister_driver(&davinci_driver);
> > +
> >  	clk_put(cpufreq.armclk);
> > =20
> >  	if (cpufreq.asyncclk)
> >  		clk_put(cpufreq.asyncclk);
> > =20
> > -	cpufreq_unregister_driver(&davinci_driver);
> > -
> >  	return 0;
> >  }
>=20
> Rafael, please take this directly as the dependency patch will go via you=
r tree
> too (the one that makes cpufreq_unregister_driver() return void).
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Ah, I intended to write a word about the dependency patch. Do we want to
backport this patch to stable? If so it might make sense to rework it to
not depend on the "cpufreq_unregister_driver() return void" patch to
simplify that.

I can help with reworking, just tell me your preferences.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6hns4w24y72knflj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPjcysACgkQwfwUeK3K
7AnZLAf/d2nUMO69dv9cX45Uxehh892YDimdDuMQ4T+FmJ/m9QBRGr0AiFcehNyD
Mo0hIsWOX/7iEz5mtUYe75XFayMYjGRxgimpNQ5y23Vabw1/rgHs6rWVFP5WYf6Y
wHG67h29SxK+CEw6R/J/1FVCm26iNpHrssJge2DqbpG1SGbIoBwqwWJX5lKVsfv8
oPJAIDAwfoBqXcYWdtDzolYLy/FCZotOwrunRguICf/o0onMViwj87wD6fB+alh3
QL5NR9xrlv3it+KuJU2oJTEE0qQ9aOcZjZ9uyxyaOJKFenOIqLC+Ud0OmqXdyJgw
vw4f4c0bQo5JC61emWwcdJSA7Rr4PA==
=OpNu
-----END PGP SIGNATURE-----

--6hns4w24y72knflj--

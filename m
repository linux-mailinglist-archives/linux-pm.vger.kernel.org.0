Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79F34CDF98
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 22:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiCDVJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 16:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCDVJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 16:09:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A70120198;
        Fri,  4 Mar 2022 13:09:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 136861F466D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646428144;
        bh=mf1kQ1QenWg2dMao8TGtKTeciuEgJ/FIVUidedTMpek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbhX5mhjStLrOtThvVRJ78U6KZ44/8Hr0cGefhEVJsbX/F91t+f7kHAY1l3zW7/BC
         1ChvewEIneqcWUxZQY8ftOrJl4N7otvb/WsXfQCOfqHieYMDTxP4kzMVDGrCoMT7Fj
         MPITX9AbNvrIxZqqX47yN12H3dyarFBOnBezMzCyysD36tHGc1VBPeO4a2JBePaVTA
         2KT6GSvNEsX8FLvsLgjfg7cYtTC7sGJ60K8lOZ++z9N3+YMY9SN+GLrGOoLWJJnro+
         vfSOI9qzvFUGEhAbru42bMeV34kWi+yjnRvZMS5T5S2cmg0UQVcau/cmA34w9TUUOB
         6Wp8XHnzhWtZw==
Received: by mercury (Postfix, from userid 1000)
        id EDBE31060602; Fri,  4 Mar 2022 22:09:00 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:09:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: ab8500_fg: Add line
 impedance
Message-ID: <20220304210900.3pvzbu3j5fbxwsca@mercury.elektranox.org>
References: <20220301124254.2338270-1-linus.walleij@linaro.org>
 <Yh+2lrxFkSZkOQCK@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkhsxr7xg2jacud7"
Content-Disposition: inline
In-Reply-To: <Yh+2lrxFkSZkOQCK@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kkhsxr7xg2jacud7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 02, 2022 at 12:25:26PM -0600, Rob Herring wrote:
> On Tue, Mar 01, 2022 at 01:42:53PM +0100, Linus Walleij wrote:
> > To improve the inner resistance measurement of the battery we need
> > to account for the line impedance of the connector to the battery.
> >=20
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../bindings/power/supply/stericsson,ab8500-fg.yaml          | 5 +++++
> >  1 file changed, 5 insertions(+)
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued (together with patch 2/2)

-- Sebastian

--kkhsxr7xg2jacud7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIif+wACgkQ2O7X88g7
+prlzxAAmlxP8pwyl+dgdxormupmTRC2UzwHqUvMKG4R1uxDAdzhQNJbrQ9ax8qF
5225I/WYTcLNnDoNqUkdvjfGnqb8JgS6CgYKsybW6/dLF9kzmPmQWnSknTvND+P/
QmrdW0yLQIR3nNMTmX2xtOICR2/lWbVols9CbHs6Eal4dvbW2gZCtHNH3VXIxRoH
V+lYrQPt3z4cpyTtmbreen68f0woK6vBfjiwN+zUmP4ArwlymGblvfk4rhQ47qnp
wU/fnD4POINo3fBXTrZzyySKOrth6wAkwq44m/oRT9cgOsgKAv+uaVpc9bXgQ0Aj
22b5W8joHRnHfmexA7HX/DvZtqJyyogs5SxaqNugyoLn0wBt5Doh9mpD8FRnqWmn
6eH/MgrcEMGfOMSKhn5iLOfqtnx21SloArQ0jptYtbhG4a1qzA0t5vmwmGJCzw6X
6t9jKHyhUxqvu/8aDKgIrddn3aI0pJ+GVZHiTA2jMK+DnckS3okOJFAk1AYddx+1
xIebAVmezE3HFt8mtACtMLghk6zeFE+ktaCSf/oNpFKIgh2VMr0UZwDv7x5mg4fw
nK7SjWzqGAOSuyGn/NT7ZAQ6b/4QwZnS4160vHBoSB8m6CpFilUQcKPgr2E7jK/x
8dyjRBKjpRY373se5UK6qoyoNicsKUNbCTrX7xWkk0j+DyFBJIM=
=VWp5
-----END PGP SIGNATURE-----

--kkhsxr7xg2jacud7--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF916A58E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 12:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBXLxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 06:53:51 -0500
Received: from foss.arm.com ([217.140.110.172]:35936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXLxv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 06:53:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8F1930E;
        Mon, 24 Feb 2020 03:53:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7524E3F534;
        Mon, 24 Feb 2020 03:53:50 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:53:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Milo Kim <milo.kim@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 4/8] regulator: rename regulator_linear_range to
 linear_range
Message-ID: <20200224115349.GD6215@sirena.org.uk>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
 <f66749295e07448012c80c2054b1f14506d17d76.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <f66749295e07448012c80c2054b1f14506d17d76.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 09:36:10AM +0200, Matti Vaittinen wrote:
> Rename the "regulator_linear_range" to more generic linear_range
> as a first step towards converting the "regulator_linear_range"
> to common helpers.

Doesn't this introduce a build break when applied by itself?  Patches
should be bisectable, if you want to split things up you should
introduce the new API then use it.

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5TuUwACgkQJNaLcl1U
h9Bobgf/bBfZFX2V9zrXf7uOqfAy58lDJsCapCQsq1yXEzID+pwtN5eG6vVcW+fc
sioaL8h3UtAeapwgAE0tJQgk1aRc88CsScuLJr0bmfSWQUvnq/UbL/NyyDnthYhd
vPKEno1MAOH0pBRBqG8IZG9eLEc7aaOvaI4a4pl0Dis3FNPwEDaumpVvJYK1V7U8
+0vvTWzZsX0yc0N+tdfOvP35v0NIqP3kZL6ztNEvuKx7RvTnyDyN4p/65O1dHZLd
bhat1RJll7ITXDizfyEzi0zuPWeJuYOuvWgSyl2Ow4AzRz7zXNYnehsbS2yofZy1
wDRxpH/9ARG4e9guroKxyuWFVFWgBg==
=XevB
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--

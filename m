Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6AD16EA2F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 16:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgBYPdM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 10:33:12 -0500
Received: from foss.arm.com ([217.140.110.172]:52226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbgBYPdM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 10:33:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9253F1FB;
        Tue, 25 Feb 2020 07:33:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1317C3F703;
        Tue, 25 Feb 2020 07:33:10 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:33:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 5/8] regulator: use linear_ranges helper
Message-ID: <20200225153309.GE4633@sirena.org.uk>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
 <ba2eb2d7363b386136a546a769a6e2d077558094.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
 <20200224115751.GE6215@sirena.org.uk>
 <d5e63ea6935991d855e2ae12915b3b4614e8f3aa.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <d5e63ea6935991d855e2ae12915b3b4614e8f3aa.camel@fi.rohmeurope.com>
X-Cookie: Booths for two or more.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 06:23:31AM +0000, Vaittinen, Matti wrote:

> Only change required on individual regulator drivers should be renaming
> the struct regulator_linear_range to linear_range. Rest of the changes
> should be internal to regulator framework, right?

Right, it's that type replacement that should be done atomically.

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5VPjQACgkQJNaLcl1U
h9DV+Af/YLPOCGPhEgq/4DLBacyUVBBMzshszyl+1OhweGApumy620sSGDV2XqMt
et1IK21GhwqVae3/qawujyX3lsyQX8lX/w17bHzr5MLEemCDvUp4luJaIlRKZS2p
5h0Qbt0ioaL7RDQ3+a/YtXgZqIR6EKGWUtIdW4wUk4K2VF1+9xUqvQNVeDFjxoUr
S9IBP/rMQJS3pgn0R1EtSZmFqqb7BBi+Cl1k/Qkbw5Ym/PukYHzFbnJXxTyxlrBX
OSbUPWd5YlhaGXcm+95hkzePuUbEiJBGUrAwwqSRCeTpzcIseDa0YtzMWUu+aP7/
vYpzdbT1DjswwI6XKO/JfgD0kKhmhw==
=fCzU
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--

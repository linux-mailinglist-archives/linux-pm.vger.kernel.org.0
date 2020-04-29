Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2131BE52C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2R1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 13:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgD2R1E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 13:27:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82C020787;
        Wed, 29 Apr 2020 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588181224;
        bh=5nFxIMtORu9k1muM2m7cCBsnXArZmp2XEa9iMeJXeQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSQZm4JPdxY5Tm9abQB8Kklc7rlsjMpSugMrooVLJWMYtkKu1i0OOXoDAiu2QFx7E
         Subvt4sI9yOswriE1+V5GXqvI6TB/Nrec+EGSyijgRHHQdrK3of98AMDniRQn9RgHn
         i52MFEviNHy3x1kvejQlvM6EX0lKEwcVED2oz144=
Date:   Wed, 29 Apr 2020 18:27:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] regulator: Revert "Use driver_deferred_probe_timeout for
 regulator_init_complete_work"
Message-ID: <20200429172701.GO4201@sirena.org.uk>
References: <20200429172349.55979-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline
In-Reply-To: <20200429172349.55979-1-john.stultz@linaro.org>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 05:23:49PM +0000, John Stultz wrote:
> This reverts commit dca0b44957e5 ("regulator: Use
> driver_deferred_probe_timeout for regulator_init_complete_work"),
> as we ended up reverting the default deferred_probe_timeout
> value back to zero, to preserve behavior with 5.6 we need to
> decouple the regulator timeout which was previously 30 seconds.
>=20
> This avoids breaking some systems that depend on the regulator
> timeout but don't require the deferred probe timeout.

Reviewed-by: Mark Brown <broonie@kernel.org>

I'm assuming this should go via the same path that the other revert
went.

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6puOQACgkQJNaLcl1U
h9Ch0QgAgdGatjelyk2utw5eSqdQ71gadgTZyi9Lkaq8b4AVkkOcHrTQELFrWeiD
P2fhekarO7j7hwZrYs1S/O8mFB4NZQ2TBErZ0nEpryTTyHehBLZWTAOHc0KKF7U3
qd4Ytq+v1uwENN6P4BjT7T4U0MLCGxjg6TTdYFXL7zxe+LsK79CjE128gCcVGnqd
yvaqaOTIwXOpHaOtbC54wSf1HKNJG+hY24HP652tZqwyljokazCtp9julOCT3Z7A
QrNSPVeSvoSyY2uF7dgIRYV40xTkSCOqEf1cspKC2zq+mT3RFnmX1iLZSHRANI27
6Tv7rRC/i9gfJAKjtoHqbKSFKA/mnw==
=Jw6k
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--

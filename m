Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411FF1643CD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBSL7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 06:59:45 -0500
Received: from foss.arm.com ([217.140.110.172]:47412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgBSL7p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 06:59:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5415131B;
        Wed, 19 Feb 2020 03:59:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F2E3F6CF;
        Wed, 19 Feb 2020 03:59:43 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:59:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] driver core: Make deferred_probe_timeout global
 so it can be shared
Message-ID: <20200219115942.GA4488@sirena.org.uk>
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200218220748.54823-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20200218220748.54823-2-john.stultz@linaro.org>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 10:07:48PM +0000, John Stultz wrote:
> This patch, suggested by Rob, allows deferred_probe_timeout to
> be global so other substems can use it.

> This also sets the default to 30 instead of -1 (no timeout) and
> modifies the regulator code to make use of it instead of its
> hard-coded 30 second interval.

This is at least two patches, one adding the new feature and the other
adding a user of that feature.

> @@ -5767,18 +5772,17 @@ static int __init regulator_init_complete(void)
>  		has_full_constraints =3D true;
> =20
>  	/*
> -	 * We punt completion for an arbitrary amount of time since
> +	 * We punt completion for deferred_probe_timeout seconds since
>  	 * systems like distros will load many drivers from userspace
>  	 * so consumers might not always be ready yet, this is
>  	 * particularly an issue with laptops where this might bounce

While I don't see it doing any harm I'm not 100% convinced by this
change - we're not really doing anything directly to do with deferred
probe here, we're shutting off regulators that remain unused late in
boot but even then they'll still be available for use.  It feels a bit
unclear and the way you've adapted the code to always have a timeout
even if the deferred probe timeout gets changed feels a bit off.  If
nothing else this comment needs more of an update than you've done.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NIysACgkQJNaLcl1U
h9Ashgf/dhUO3BoxzBzZCXprOsWsjQUjxy4uldVR1kQq26HrRxPptQQB4MbZ2l3O
mK9nTS027nDNZ5tCE5m/H4HcZnXvCR6ya05xixa5CcDc+mgaR8R2XDCJ63GFVYhL
dy0R4r4iQdx11vC1gJWNiscHBNgbWKRjSRsZLR51k2STkhaLhitvABbapP3BviU0
LtjwBbIDFwUdxPNGNaTUoss+vL5jdpm7l45io7bm6sLpE3UyAWQum7XZbsuXqmfv
9hHiObCOd3J7UUQe0bY7jEhWAf6ml9EOB5kyFyUTB3E5S4SM3o4PNyCl2yfEbict
RhH1UDGHnyXl/DCi6ox3CKwcZtWPtQ==
=fsjG
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F9D55C6
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfJML1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:27:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41063 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJML1T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:27:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2D39680249; Sun, 13 Oct 2019 13:27:02 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:27:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Limit voltage to 4.2V for
 battery
Message-ID: <20191013112714.GA5653@amd>
References: <20191009203355.5622-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20191009203355.5622-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There have been some cases of droid4 battery bulging that seem to be
> related to being left connected to the charger for several weeks.
>=20
> It is suspected that the 4.35V charge voltage configured for the battery
> is too much in the long run, so lets limit the charge voltage to 4.2V.
> It could also be that the batteries are just getting old.
>=20
> We don't really want to just change the charge voltage to 4.2V as Android
> may have charged the battery to 3.51.V as pointed out by Pavel
> Machek.

Now I'm confused. What is 3.51V? Is it typo for 4.35V?

> +	/*
> +	 * If battery voltage is higher than charge voltage, it may have been
> +	 * charged to 3.51V by Android. Try again in 10 minutes.
> +	 */

Ok, so maybe it is not a typo. I'm confused.

Note that I'd prefer not to see this in -stable.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jChIACgkQMOfwapXb+vICnwCgkUgzBNRBnmBrxU6C+qVloTtw
74UAoIhxPfH76o/dwAWvPI/rSAMRlPTe
=Dcv8
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

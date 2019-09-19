Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B66B7661
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfISJev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:34:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45530 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbfISJev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:34:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6ED1B81B8E; Thu, 19 Sep 2019 11:34:35 +0200 (CEST)
Date:   Thu, 19 Sep 2019 11:34:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 3/3] power: supply: cpcap-charger: Adjust current based
 on charger interrupts
Message-ID: <20190919093448.GE9644@amd>
References: <20190917215253.17880-1-tony@atomide.com>
 <20190917215253.17880-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <20190917215253.17880-4-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-09-17 14:52:53, Tony Lindgren wrote:
> When debugging why higher than 500 mA charge current does not work, I
> noticed that we start getting lots of chrgcurr1 interrupts if we attempt
> to charge at rates higher than the charger can provide.
>=20
> We can take advantage of the chrgcurr1 interrupts for charger detection,
> and retry charging at a lower rate if charging fails. When an acceptable
> charge rate is found, the chrgcurr1 interrupts stop.

Do you still see these problems with "good" charger? (Wall one,
capable of providing 2A)?

Note that 1A charging will decrease battery lifetime, and that phone
definitely should not be charging with more than 500mA when charging
=66rom computer. I actually prefer the way it charges slowly in mainline...

We'll eventually need a library or something; we don't want every
driver to reinvent charging code..

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2DS7gACgkQMOfwapXb+vKzbQCdFNYJjDTcK90EFvfbbS9YiwOv
VcIAn1zZnT/99Wyogm43fI9+kN/B5eRE
=FuSS
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

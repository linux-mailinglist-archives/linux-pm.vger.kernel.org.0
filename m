Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D214D55BB
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfJMLBd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:01:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40572 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMLBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:01:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BAE9E80249; Sun, 13 Oct 2019 13:01:15 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:01:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/5] power: supply: cpcap-battery: Simplify coulomb
 counter calculation with div_s64
Message-ID: <20191013110102.GB26237@amd>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-3-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 14:06:18, Tony Lindgren wrote:
> We can simplify cpcap_battery_cc_raw_div() with div_s64.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jA+4ACgkQMOfwapXb+vLrgQCePr6PQxCz1NuTK2eqT/wzWIdP
2eAAniGoiS7Hw6dziY0id77C+WgfJRa4
=A0Ch
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F108D55D4
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfJMLhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:37:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41282 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMLhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:37:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5C56F80249; Sun, 13 Oct 2019 13:37:00 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:36:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/5] power: supply: cpcap-battery: Simplify coulomb
 counter calculation with div_s64
Message-ID: <20191013113648.GF5653@amd>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-3-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w3uUfsyyY1Pqa/ej
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

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jDFAACgkQMOfwapXb+vJjagCeMv/4+3eu3srNfX7lUmcYO41m
jf4An1dtWJZlBTKiF45wVo5+0TM5o+Fn
=SlUW
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--

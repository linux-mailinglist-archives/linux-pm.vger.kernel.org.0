Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB0D55C4
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfJML0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:26:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41043 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJML0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:26:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 774F480249; Sun, 13 Oct 2019 13:26:24 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:26:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 5/5] power: supply: cpcap-battery: Add basic coulomb
 counter calibrate support
Message-ID: <20191013112636.GC26237@amd>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-6-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-6-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 14:06:21, Tony Lindgren wrote:
> This patch adds support for the coulomb counter calibration on init. We do
> this by polling for now, and only add partial calibration done interrupt
> support.
>=20
> Then later on when we know for sure we have the calibration done interrupt
> available in the device tree, we can switch to using the calibration done
> interrupt.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

4,5: Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jCewACgkQMOfwapXb+vJMVQCfZ5M57hH4vI2cJLO7Su1oDEjn
uvoAn22Y1y4LCqOK49rkkJUkBePchpwt
=ggvV
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--

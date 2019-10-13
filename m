Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1412D55D2
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2019 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfJMLgI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 07:36:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41255 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJMLgI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:36:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7ED2D8023F; Sun, 13 Oct 2019 13:35:51 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:35:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/5] power: supply: cpcap-battery: Move coulomb counter
 units per lsb to ddata
Message-ID: <20191013113548.GE5653@amd>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-2-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 14:06:17, Tony Lindgren wrote:
> We can simplify cpcap_battery_cc_raw_div() a bit by moving the units per
> lsb to ddata.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jDBQACgkQMOfwapXb+vJIxQCfQoZB6NRzEGnz7Siq1awC/ljw
IeIAoLW4KCMyw1AX2Dh69wiTXpcCtfsD
=HFNC
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--

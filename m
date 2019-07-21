Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7416F421
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2019 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGUQjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jul 2019 12:39:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45838 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfGUQjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jul 2019 12:39:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B87E880357; Sun, 21 Jul 2019 18:39:18 +0200 (CEST)
Date:   Sun, 21 Jul 2019 18:39:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/8] ACPI: EC: Return bool from acpi_ec_dispatch_gpe()
Message-ID: <20190721163929.GA12494@amd>
References: <71085220.z6FKkvYQPX@kreacher>
 <4778086.90p4OrCUAx@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <4778086.90p4OrCUAx@kreacher>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-07-16 18:12:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> On some systems, if suspend-to-idle is used, the EC may singal system

Typo "signal".

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl00lUEACgkQMOfwapXb+vJRuwCfY9dA6L4ivNmcYkG+aws8A0v9
9sEAniV7/AuJY0ezCk2g7s/2i2gUMpdZ
=iR1d
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB00B5FD65
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfGDTUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 15:20:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49084 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGDTUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 15:20:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8C6C88064B; Thu,  4 Jul 2019 21:20:09 +0200 (CEST)
Date:   Thu, 4 Jul 2019 21:20:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: suspend broken in next-20190704 on Thinkpad X60
Message-ID: <20190704192020.GA3771@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Suspend is broken in next-20190704 on Thinkpad X60. It very very
probably worked ok in 20190701.



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0eUXQACgkQMOfwapXb+vIyWwCfVNzttFQwQxMv+0DSegiLXCGs
o9wAmwZaCLTkVMu5GIsj9yZ5t9/kf8z+
=bP4N
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

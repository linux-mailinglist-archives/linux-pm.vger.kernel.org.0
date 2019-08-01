Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18D7E349
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfHAT1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 15:27:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52525 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbfHAT1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 15:27:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3710A8033D; Thu,  1 Aug 2019 21:27:02 +0200 (CEST)
Date:   Thu, 1 Aug 2019 21:27:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: OLPC in 5.3? was Re: [PATCH v7 01/10] dt-bindings: olpc,xo1.75-ec:
 Add OLPC XO-1.75 EC bindings
Message-ID: <20190801192713.GA22373@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
 <20190513075641.1277716-2-lkundrak@v3.sk>
 <20190513090743.GA19319@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20190513090743.GA19319@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

What is status of OLPC-1.75 in v5.3? IIRC most of the patches went in,
but I don't see suitable dts file in the tree. I tried porting one
=66rom working (4.19 or so) kernel, but it was not quite trivial.

Is there time for dts to be merged?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1DPREACgkQMOfwapXb+vK+UACfbtL9ZP0PJCU/Baj7rJWVyQ+e
P64An0T73nBmPyHevfV2Tm3Y1ZwpMgCk
=1aTI
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

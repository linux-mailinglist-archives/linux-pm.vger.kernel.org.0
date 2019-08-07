Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1C84BA8
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfHGMbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 08:31:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40732 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfHGMbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 08:31:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 77BFE80369; Wed,  7 Aug 2019 14:31:24 +0200 (CEST)
Date:   Wed, 7 Aug 2019 14:31:36 +0200
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
Subject: Re: OLPC in 5.3? was Re: [PATCH v7 01/10] dt-bindings:
 olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
Message-ID: <20190807123134.GA10407@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
 <20190513075641.1277716-2-lkundrak@v3.sk>
 <20190513090743.GA19319@amd>
 <20190801192713.GA22373@amd>
 <390f31d2f85e8075d9b1e250a2ec093ac8769703.camel@v3.sk>
 <20190803084755.GA8224@amd>
 <42288023.4384.1565000772220.JavaMail.zimbra@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <42288023.4384.1565000772220.JavaMail.zimbra@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm using [1].
>=20
> [1] https://raw.githubusercontent.com/hackerspace/olpc-xo175-linux/lr/olp=
c-xo175/arch/arm/configs/olpc_xo175_defconfig
>=20

Thanks a lot. I got it to work with 5.2 and 5.3-rc. One thing I
noticed...

"reboot: Restarting system", "Reboot failed --- System halted".

> I'm wondering if it would make sense to include this upstream?
> My guess was that nowadays multi_v7_defconfig that just works
> on any DT-based platform is preferred to machine specific ones.
>=20
> However, this one would enable OLPC-specific drivers the
> multi_v7_defconfig defconfig wouldn't.

Yes, I believe that would be useful. Getting all the extras without
that would be quite tricky.=20

> > Is there some kind of documentation somewhere? :-).
>=20
> This is always a tough question. Short answer would be no.
>=20
> I'm happy to answer questions though, if the above wouldn't be
> sufficient to make the thing boot for you.

Ok, it seems to work now ;-). I'll make some notes...

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1KxKYACgkQMOfwapXb+vI8gACgr/mo99h+73gGIruJmfMPyCRg
U7IAoKApKGX+y9Q0GxmeTM/KfmBHixdL
=sbDP
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

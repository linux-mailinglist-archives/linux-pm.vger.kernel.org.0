Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E828055A
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2019 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfHCIsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Aug 2019 04:48:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45073 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbfHCIr7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2019 04:47:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C481380318; Sat,  3 Aug 2019 10:47:44 +0200 (CEST)
Date:   Sat, 3 Aug 2019 10:47:56 +0200
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
Message-ID: <20190803084755.GA8224@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
 <20190513075641.1277716-2-lkundrak@v3.sk>
 <20190513090743.GA19319@amd>
 <20190801192713.GA22373@amd>
 <390f31d2f85e8075d9b1e250a2ec093ac8769703.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <390f31d2f85e8075d9b1e250a2ec093ac8769703.camel@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > What is status of OLPC-1.75 in v5.3? IIRC most of the patches went in,
> > but I don't see suitable dts file in the tree. I tried porting one
> > from working (4.19 or so) kernel, but it was not quite trivial.
> >=20
> > Is there time for dts to be merged?
>=20
> Short answer is that it's not absolutely necessary. With a new enough
> OpenFirmware, the firmware will just construct a correct FDT.

> To upgrade your machine to the new firmware, just copy=20
> http://dev.laptop.org/~quozl/q4e00ja.rom to a FAT partition on a USB
> flash stick and run "flash u:\q4e00ja.rom" from the "ok" prompt.
> Then you'll be able to run stock mainline kernels happily.

Aha, good, thanks. That went smoothly.

> That said, it might still be useful to have a DTS file in tree (for
> reference, testing, machines with older firmware, etc.). I've now re-
> sent the MMP2 devicetree update patch set with the DTS file included
> and copied you on that one.

Yes: sometimes it is neccessary to modify the dts. I was changing the
kernel command line, for example.

> As usual, I'm thankful for testing, reviews and acks.

I'll take a look. I tried 5.2 with defconfig from one of the branches
(olpc_xo175_defconfig), and that does not boot.

What config should I use? Is it enough to produce zImage and put it on
the flashdisk with olpc.fth file? Is there some kind of documentation
somewhere? :-).

Thanks and best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1FSjsACgkQMOfwapXb+vJejgCgwOhDGjCagQoLmYOk3RUIcISI
X6EAoJWL5JyswxbnkK51RiCTaV6D6nCw
=NXI7
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

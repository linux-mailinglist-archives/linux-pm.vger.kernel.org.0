Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A858E150
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfHNXiw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 19:38:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39391 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHNXiw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 19:38:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 843FC80A2A; Thu, 15 Aug 2019 01:38:37 +0200 (CEST)
Date:   Thu, 15 Aug 2019 01:38:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, tytso@mit.edu,
        nhorman@tuxdriver.com, security@kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID
 bit on AMD family 15h/16h
Message-ID: <20190814233849.GA462@amd>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190814232434.GA31769@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20190814232434.GA31769@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-08-15 01:24:35, Pavel Machek wrote:
> On Wed 2019-08-14 21:17:41, Lendacky, Thomas wrote:
> > From: Tom Lendacky <thomas.lendacky@amd.com>
> >=20
> > There have been reports of RDRAND issues after resuming from suspend on
> > some AMD family 15h and family 16h systems. This issue stems from BIOS
> > not performing the proper steps during resume to ensure RDRAND continues
> > to function properly.
>=20
> Burn it with fire!
>=20
> I mean... people were afraid RDRAND would be backdoored, and you now
> confirm ... it indeed _is_ backdoored? /., here's news for you!
>=20
> So what is the impact? Does it give random-looking but predictable
> numbers after resume? Does it give all zeros? Something else?

Plus... We trust the RDRAND in some configurations:

        random.trust_cpu=3D{on,off}
				[KNL] Enable or disable trusting the
				use of the CPU's random
				number generator (if available) to
	       		     fully seed the
				kernel's CRNG. Default is controlled by
				CONFIG_RANDOM_TRUST_CPU.

so.. does this mean /dev/random was giving non-random values for some
users?

Certainly it means userland users were getting non-random values. That
sounds like something worth CVE and informing affected users?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1Um4kACgkQMOfwapXb+vIG8QCfcMvaMkAtM9hsS5yK2VENUKxn
ka4AoLbv6GDCX/Ku6G0zERnadnXHCQNE
=6aFU
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

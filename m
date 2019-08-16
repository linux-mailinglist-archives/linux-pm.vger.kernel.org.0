Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A318FEA7
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfHPJHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 05:07:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39959 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfHPJHS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 05:07:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D68E380F3A; Fri, 16 Aug 2019 11:07:01 +0200 (CEST)
Date:   Fri, 16 Aug 2019 11:07:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        nhorman@tuxdriver.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID
 bit on AMD family 15h/16h
Message-ID: <20190816090713.GA17833@amd>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190814232434.GA31769@amd>
 <20190815151224.GB18727@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20190815151224.GB18727@mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-08-15 11:12:24, Theodore Y. Ts'o wrote:
> On Thu, Aug 15, 2019 at 01:24:35AM +0200, Pavel Machek wrote:
> > Burn it with fire!
> >=20
> > I mean... people were afraid RDRAND would be backdoored, and you now
> > confirm ... it indeed _is_ backdoored? /., here's news for you!
>=20
> To be fair to AMD, I wouldn't call it a backdoor.  Hanlon's razor is
> applicable here:
>=20
> 	"Never attribute to malice that which can be adequately
> 	explained by neglect."

> (Sometimes other words are used instead of neglect, but i'm trying to
> be nice.)

You are right, I thought it was returning values with low entropy, and
it returns ~0 (so -- really really low entropy :-) and can't be
clasified as a backdoor.

Anyway, AMD is _not_ doing good job right now.

I'd expect:

a) CVE reference

b) real fix; if BIOS can init the rng, so can kernel

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1WckEACgkQMOfwapXb+vJUmgCbBaZAQvUTMEhu0sVBHUxqvAVR
ZPEAn3mz1LDei9CmYiqspf9+V/tvyKCj
=tgYd
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

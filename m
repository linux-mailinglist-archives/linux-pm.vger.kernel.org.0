Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD28E136
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 01:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfHNXYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 19:24:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36276 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbfHNXYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 19:24:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E90BE80406; Thu, 15 Aug 2019 01:24:22 +0200 (CEST)
Date:   Thu, 15 Aug 2019 01:24:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, tytso@mit.edu,
        nhorman@tuxdriver.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on
 AMD family 15h/16h
Message-ID: <20190814232434.GA31769@amd>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-08-14 21:17:41, Lendacky, Thomas wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
>=20
> There have been reports of RDRAND issues after resuming from suspend on
> some AMD family 15h and family 16h systems. This issue stems from BIOS
> not performing the proper steps during resume to ensure RDRAND continues
> to function properly.

Burn it with fire!

I mean... people were afraid RDRAND would be backdoored, and you now
confirm ... it indeed _is_ backdoored? /., here's news for you!

So what is the impact? Does it give random-looking but predictable
numbers after resume? Does it give all zeros? Something else?

> =20
> +	rdrand_force	[X86]
> +			On certain AMD processors, the advertisement of the
> +			RDRAND instruction has been disabled by the kernel
> +			because of buggy BIOS support, specifically around the
> +			suspend/resume path. This option allows for overriding
> +			that decision if it is known that the BIOS support for
> +			RDRAND is not buggy on the system.

But this is not how we normally deal with buggy BIOSes. We don't want
user to have to decide this...

Should we introduce black-list or white-list of BIOS versions?

Hmm. Actually.

You are the CPU vendor. Surely you can tell us how to init RDRAND in
kernel if BIOS failed to do that... can you?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1UmDIACgkQMOfwapXb+vIddACfRHWnR0cLHZEfhG6DY3MIyTXq
QbAAoIiJ1aAu2CCmVd4tBCBEmPSkkrD3
=0qd7
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

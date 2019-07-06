Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF29C612C2
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfGFTB1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 15:01:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45389 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFTB1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 15:01:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2C9AD80449; Sat,  6 Jul 2019 21:01:13 +0200 (CEST)
Date:   Sat, 6 Jul 2019 21:01:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: suspend broken in next-20190704 on Thinkpad X60
Message-ID: <20190706190123.GA11603@amd>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Suspend is broken in next-20190704 on Thinkpad X60.
> > >
> > > Broken in what way?  Any details?
> > >
> > > > It very very probably worked ok in 20190701.
> > >
> > > Well, please try the linux-next branch from linux-pm.git
> > > (git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git)
> > > alone and see if that fails.
> >
> > So... let me try this one?
> >
> > commit  1e2a4c9019eb53f62790fadf86c14a54f4cf4888 (patch)
=2E..
> I'm not sure what you mean here.  I'm guessing that you don't get back
> to the console from which you ran the pm-suspend command, but is X
> restored, for example?  Is there any way to get into the system in
> that state?
>=20
> Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
> to happen for you.
>=20
> I would try
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=3Df012a132824fc870b90980540f727c76fc72e244
>=20
> to narrow down the scope somewhat.

pavel@amd:/data/l/linux-next-32$ git bisect log
# bad: [1e2a4c9019eb53f62790fadf86c14a54f4cf4888] Merge branch
'pm-cpufreq-new' into linux-next
# good: [f012a132824fc870b90980540f727c76fc72e244] Merge branches
'acpica', 'acpi-osl', 'acpi-tables', 'acpi-misc' and 'acpi-tools' into
linux-next
git bisect start '1e2a4c9019eb53f62790fadf86c14a54f4cf4888'
'f012a132824fc870b90980540f727c76fc72e244'
# good: [48a8a5f9a326d1c1a5505d51fb98086e5003f37e] Add linux-next
specific files for 20190701
git bisect good 48a8a5f9a326d1c1a5505d51fb98086e5003f37e

I think I can handle this... when I'm near the AC power.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0g8AMACgkQMOfwapXb+vJC1gCdEe4Nv6J4YyOXj+NxWhXqXs7/
ZugAniqE5snvGmD+xcWIOzM6b6Mxciq7
=8+gT
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

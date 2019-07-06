Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08E0611D2
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGFPQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 11:16:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39502 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfGFPQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 11:16:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 62389804C8; Sat,  6 Jul 2019 17:16:34 +0200 (CEST)
Date:   Sat, 6 Jul 2019 17:16:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: suspend broken in next-20190704 on Thinkpad X60
Message-ID: <20190706151645.GA9856@amd>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--G4iJoqBmSsgzjUCe
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
> > tree    cb5339fcaae2166832f91f4ce9f40575cc6cb6e5
> > parent  3836c60c063581294c3a82f8cbccf3f702951358 (diff)
> > parent  0a811974f3f79eea299af79c29595d8e1cb80a15 (diff)
> > download
> > linux-pm-1e2a4c9019eb53f62790fadf86c14a54f4cf4888.tar.gz
> > Merge branch 'pm-cpufreq-new' into
> > linux-nexttestinglinux-nextbleeding-edge
> > * pm-cpufreq-new:
> >
> > That one is broken, too.
> >
> > pavel@amd:~$ sudo pm-suspend
> >
> > Machine suspends, resumes, but I don't get my prompt back.
>=20
> I'm not sure what you mean here.  I'm guessing that you don't get back
> to the console from which you ran the pm-suspend command, but is X
> restored, for example?  Is there any way to get into the system in
> that state?

X is restored, and the rest of system works, but "pm-suspend" command
never completes, so I don't get shell prompt back in that window.

> Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
> to happen for you.
>=20
> I would try
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=3Df012a132824fc870b90980540f727c76fc72e244
>=20
> to narrow down the scope somewhat.

next-20190701 is ok, next-20190704 is broken. Can we use that to
narrow it down?

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0gu10ACgkQMOfwapXb+vKBNwCgsPIFW0w2JRAYRKvTsCknjYyF
9cQAnREuGPkxHWjdswVLotnC2sd8oXlp
=3in7
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

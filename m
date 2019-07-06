Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69B611E7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGFPcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 11:32:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39927 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfGFPcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 11:32:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F03C9804D3; Sat,  6 Jul 2019 17:32:09 +0200 (CEST)
Date:   Sat, 6 Jul 2019 17:32:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: suspend broken in next-20190704 on Thinkpad X60
Message-ID: <20190706153220.GA4778@amd>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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
>=20
> Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
> to happen for you.
>=20
> I would try
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=3Df012a132824fc870b90980540f727c76fc72e244

That one is good.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0gvwQACgkQMOfwapXb+vIMHACgmmIQwl98vKrdAPfnvy4PQbs9
yhkAn3vq7kRmK+FKfb+z/WSAXR599zbj
=PcYo
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

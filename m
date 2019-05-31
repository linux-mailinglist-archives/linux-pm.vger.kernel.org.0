Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CCB30DF8
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaMSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 08:18:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55288 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfEaMSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 08:18:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 74D2B802E6; Fri, 31 May 2019 14:18:10 +0200 (CEST)
Date:   Fri, 31 May 2019 14:18:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190531121820.GA3722@amd>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
 <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
 <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
 <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com>
 <20190530233804.syv4brpe3ndslyvo@treble>
 <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905310139380.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-05-31 01:42:02, Jiri Kosina wrote:
> On Thu, 30 May 2019, Josh Poimboeuf wrote:
>=20
> > > >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > >=20
> > > Yes, it is, thanks!
> >=20
> > I still think changing monitor/mwait to use a fixmap address would be a
> > much cleaner way to fix this.  I can try to work up a patch tomorrow.
>=20
> I disagree with that from the backwards compatibility point of view.
>=20
> I personally am quite frequently using differnet combinations of=20
> resumer/resumee kernels, and I've never been biten by it so far. I'd gues=
s=20
> I am not the only one.
> Fixmap sort of breaks that invariant.

If we get less tricky code, it may be worth it...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzxG4wACgkQMOfwapXb+vL4dwCgtSpSgpdvZHaImr55/SbbOMad
9MQAoK0rb5nzJTsI242mfK7pEZ/i4Xmy
=bqKz
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4E2E7AB
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE2Vxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 17:53:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58221 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2Vxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 17:53:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1F38E80302; Wed, 29 May 2019 23:53:18 +0200 (CEST)
Date:   Wed, 29 May 2019 23:53:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190529215327.GA20914@amd>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905292223500.1962@cbobk.fhfr.pm>
 <20190529212519.GA15104@amd>
 <nycvar.YFH.7.76.1905292327080.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905292327080.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-05-29 23:27:34, Jiri Kosina wrote:
> On Wed, 29 May 2019, Pavel Machek wrote:
>=20
> > > As explained in
> > >=20
> > > 	0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > >=20
> > > we always, no matter what, have to bring up x86 HT siblings during bo=
ot at
> > > least once in order to avoid first MCE bringing the system to its
> > > knees.
> >=20
> >=20
> > > Cc: stable@vger.kernel.org # v4.19+
> > > Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> > > Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> >=20
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > But I'm less sure if this is -stable material. Is reverting
> > 0cc3cd21657be04cb0559fe8063f2130493f92cf in -stable an option?
>=20
> Well, without that commit, first MCE to come kills nosmt system.

=2E..which is same situation 4.9-stable and 4.14-stable lives with for a
long long time, right?

But you are right, reverting 0cc3cd21657b does not look like good
option :-(.


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

iEYEARECAAYFAlzu/1cACgkQMOfwapXb+vJVUgCffNI3/12a9mauuop60+FR8/z+
MqgAn3S7yVE9nlSWs51frnsmzQ8paI+6
=G4vF
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

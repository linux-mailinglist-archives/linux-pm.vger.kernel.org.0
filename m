Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215BD2FA7F
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE3Krp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 06:47:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48105 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfE3Krp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 06:47:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7E3A7802E3; Thu, 30 May 2019 12:47:32 +0200 (CEST)
Date:   Thu, 30 May 2019 12:47:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190530104741.GA12800@amd>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-30 00:09:39, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
>=20
> As explained in
>=20
> 	0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
>=20
> we always, no matter what, have to bring up x86 HT siblings during boot at
> least once in order to avoid first MCE bringing the system to its knees.
>=20
> That means that whenever 'nosmt' is supplied on the kernel command-line,
> all the HT siblings are as a result sitting in mwait or cpudile after
> going through the online-offline cycle at least once.
>=20
> This causes a serious issue though when a kernel, which saw 'nosmt' on its
> commandline, is going to perform resume from hibernation: if the resume
> from the hibernated image is successful, cr3 is flipped in order to point
> to the address space of the kernel that is being resumed, which in turn
> means that all the HT siblings are all of a sudden mwaiting on address
> which is no longer valid.
>=20
> That results in triple fault shortly after cr3 is switched, and machine
> reboots.
>=20
> Fix this by always waking up all the SMT siblings before initiating the
> 'restore from hibernation' process; this guarantees that all the HT
> siblings will be properly carried over to the resumed kernel waiting in
> resume_play_dead(), and acted upon accordingly afterwards, based on the
> target kernel configuration.
> Symmetricaly, the resumed kernel has to push the SMT siblings to mwait
> again in case it has SMT disabled; this means it has to online all
> the siblings when resuming (so that they come out of hlt) and offline
> them again to let them reach mwait.
>=20
> Cc: stable@vger.kernel.org # v4.19+
> Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzvtM0ACgkQMOfwapXb+vK9VQCeMCaAPxQHm2kR8tQhJTkYBmOm
ZAcAoJtFwZcYrRfwjRiTD09ViNtMcVd2
=LKEq
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

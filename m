Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240F760B91
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfGESuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 14:50:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34941 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfGESuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 14:50:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ACFC0803D0; Fri,  5 Jul 2019 20:49:51 +0200 (CEST)
Date:   Fri, 5 Jul 2019 20:50:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: suspend broken in next-20190704 on Thinkpad X60
Message-ID: <20190705185001.GA4068@amd>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-07-05 00:59:35, Rafael J. Wysocki wrote:
> On Thu, Jul 4, 2019 at 9:20 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > Suspend is broken in next-20190704 on Thinkpad X60.
>=20
> Broken in what way?  Any details?
>=20
> > It very very probably worked ok in 20190701.
>=20
> Well, please try the linux-next branch from linux-pm.git
> (git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git)
> alone and see if that fails.

So... let me try this one?

commit	1e2a4c9019eb53f62790fadf86c14a54f4cf4888 (patch)
tree	cb5339fcaae2166832f91f4ce9f40575cc6cb6e5
parent	3836c60c063581294c3a82f8cbccf3f702951358 (diff)
parent	0a811974f3f79eea299af79c29595d8e1cb80a15 (diff)
download
linux-pm-1e2a4c9019eb53f62790fadf86c14a54f4cf4888.tar.gz
Merge branch 'pm-cpufreq-new' into
linux-nexttestinglinux-nextbleeding-edge
* pm-cpufreq-new:

That one is broken, too.

pavel@amd:~$ sudo pm-suspend

Machine suspends, resumes, but I don't get my prompt back.

Nothing suspect in dmesg:

[   63.925151] usb 5-1: reset full-speed USB device number 2 using
uhci_hcd
[   67.105121] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   67.106401] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
succeeded
[   67.106410] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[   67.106418] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
filtered out
[   67.108575] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
succeeded
[   67.108585] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[   67.108593] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
filtered out
[   67.109152] ata1.00: configured for UDMA/133
[   71.672932] PM: resume devices took 8.668 seconds
[   71.673955] OOM killer enabled.
[   71.673961] Restarting tasks ... done.
[   73.970718] wlan0: authenticate with 30:b5:c2:f5:9f:1e
[   73.972610] wlan0: send auth to 30:b5:c2:f5:9f:1e (try 1/3)
[   73.977518] wlan0: authenticated
[   73.985092] wlan0: associate with 30:b5:c2:f5:9f:1e (try 1/3)
[   73.989844] wlan0: RX AssocResp from 30:b5:c2:f5:9f:1e (capab=3D0x431
status=3D0 aid=3D2)
[   74.002908] wlan0: associated
pavel@amd:~$

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

iEYEARECAAYFAl0fm9kACgkQMOfwapXb+vIQqQCgiOVfWnJo6ZsG5owL92uTz0wS
m5AAoLQTX35gNTNvpVbkhMDrM1PV6czj
=W/c4
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

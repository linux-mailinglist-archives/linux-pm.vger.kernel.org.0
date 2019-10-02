Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6AFC919F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 21:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfJBTK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 15:10:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47194 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfJBTK2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 15:10:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 45C75802F8; Wed,  2 Oct 2019 21:10:10 +0200 (CEST)
Date:   Wed, 2 Oct 2019 21:10:23 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20191002191023.GD13492@amd>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home>
 <20191001163542.GB87296@google.com>
 <20191001130343.4480afe3@gandalf.local.home>
 <20191001174235.GC87296@google.com>
 <20191001140846.65d7866c@gandalf.local.home>
 <20191001193701.GD87296@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20191001193701.GD87296@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-10-01 12:37:01, Matthias Kaehlcke wrote:
> On Tue, Oct 01, 2019 at 02:08:46PM -0400, Steven Rostedt wrote:
> > On Tue, 1 Oct 2019 10:42:35 -0700
> > Matthias Kaehlcke <mka@chromium.org> wrote:
> >=20
> > > On Tue, Oct 01, 2019 at 01:03:43PM -0400, Steven Rostedt wrote:
> > > > On Tue, 1 Oct 2019 09:35:42 -0700
> > > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >  =20
> > > > > How about this instead:
> > > > >=20
> > > > >   Add tracepoints for genpd_power_on, genpd_power_off and
> > > > >   genpd_set_performance_state. The tracepoints can help with
> > > > >   understanding power domain behavior of a given device, which
> > > > >   may be particularly interesting for battery powered devices
> > > > >   and suspend/resume. =20
> > > >=20
> > > > Do you have a use case example to present? =20
> > >=20
> > > TBH I'm not looking into a specific use case right now. While
> > > peeking around in /sys/kernel/debug/tracing/events to learn more
> > > about existing tracepoints that might be relevant for my work
> > > I noticed the absence of genpd ones and it seemed a good idea to
> > > add them preemptively. Conceptually they seem similar to the
> > > existing regulator_enable/disable and cpu_idle tracepoints.
> > >=20
> > > As an abstract use case I could see power analysis on battery
> > > powered devices during suspend. genpd_power_on/off allow to see
> > > which power domains remain on during suspend, and might give
> > > insights for possible power saving options. Examples could be that
> > > a power domain stays unexpectedly on due to a misconfiguration, or
> > > two power domains remain on when it could be only one if you just
> > > moved that one pin/port over to the other domain in the next
> > > hardware revision.
> >=20
> > If the power management maintainers have no issues with adding these,
> > then neither do I ;-)  It would be them who would pull them in anyway.
>=20
> Ok, I'll send a new version with the changes you suggested and some more
> info in the commit message, unless PM maintainers raise concerns before
> that.

Dunno. Adding tracepoints because someone might need them for, umm,
something... I'd wait until they are actually needed.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAl2U9h8ACgkQMOfwapXb+vJlCgCXdBSL7hbDfn+LcSCp5VzPLAl6
fQCaA5CKSoT22nF69BPs91zdN1eNR6I=
=lSwj
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF54E123ED
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBVMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 17:12:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34335 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEBVMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 17:12:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 052968030A; Thu,  2 May 2019 23:12:42 +0200 (CEST)
Date:   Thu, 2 May 2019 23:12:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>,
        bleung@chromium.org, rjw@rjwysocki.net, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com
Subject: Re: [RESEND PATCH v3 1/2] power: supply: add input voltage limit
 property
Message-ID: <20190502211252.GA19144@amd>
References: <20190415220049.14924-1-enric.balletbo@collabora.com>
 <20190416071941.GB14538@amd>
 <8d1f70a7-46d6-f278-f58c-6a7e7a644d46@collabora.com>
 <20190502210138.ekrjvg4jex5x2tbo@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20190502210138.ekrjvg4jex5x2tbo@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Tue, Apr 16, 2019 at 10:42:30AM +0200, Enric Balletbo i Serra wrote:
> > On 16/4/19 9:19, Pavel Machek wrote:
> > >> This patch exposes a new property, similar to input current limit, to
> > >> re-configure the maximum voltage from the external supply at runtime
> > >> based on system-level knowledge or user input.
> > >=20
> > > Well, and I suspect it should expose input power limit, not input
> > > voltage limit.
> >=20
> > Oh, ok, I thought we were agree that input voltage had sense after had =
some
> > discussion in v3. Seems that no, let me try to give you another example=
=2E..
> >=20
> > > DC-DC convertor efficiency normally does not much depend on input
> > > voltage....
> >=20
> > As we said we have a heat "problem" due the internal voltage conversion=
s.
> >=20
> > Lets assume you have a linear regulator instead with a Vin range from 5=
V to 9V
> > and we want an output of 3.3V/1A
> >
> > For 9V:
> >  Input power : P(in) =3D 9V x 1A =3D 9W
> >  Output power: P(out) =3D 3.3V x 1A =3D 3.3W
> >  Regulator power dissipated: P(reg) =3D P(in) - P(out) =3D 9W - 3.3W =
=3D 5.7W
> >=20
> > For 5V:
> >  Input power : P(in) =3D 5V x 1A =3D 5W
> >  Output power: P(out) =3D 3.3V x 1A =3D 3.3W
> >  Regulator power dissipated: P(reg) =3D P(in) - P(out) =3D 5W - 3.3W =
=3D 1,7W
> >=20
> > In the first case the regulator needs to dissipate more power, hence the
> > temperature is greater than the second case.
>=20
> I would be surprised, if a linear regulator is being used in this
> place :) That would basically render functionality of higher voltage
> completley useless and a good reason to always limit to 5V. For the
> generic case I agree with Pavel, that control over the power (voltage
> * current) is the better choice. Still I believe it makes sense to
> have a control knob for the voltage available, since some hardware
> designs suck.
>=20
> For example the bad hardware design might be the remote side,
> that has issues providing some voltages and this would make it
> possible to debug that.

Ok, I agree it might be useful _somewhere_, mostly for hardware
debugging. But before if we add voltage_limit, lets add power_limit,
too; and for problems that can be solved using power_limit, lets use
power_limit...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzLXVQACgkQMOfwapXb+vIWiQCgjZymYEIk0L4SUks8ymFfv2QY
C6wAnAhtfiauZiZZ8GlW92+W6bU4HRxv
=HoG4
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

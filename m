Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DA144748
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 23:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAUWZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 17:25:50 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59562 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 17:25:50 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 298681C013F; Tue, 21 Jan 2020 23:25:48 +0100 (CET)
Date:   Tue, 21 Jan 2020 23:25:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, "Arthur D." <spinal.by@gmail.com>
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
Message-ID: <20200121222547.GA17712@duo.ucw.cz>
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd>
 <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Get a rough battery charge estimate until we've seen a high or low
> >> battery level. After that we can use the coulomb counter to calculate
> >> the battery capacity.
> >>
> >> Note that I should probably update this to support ocv-capacity-table
> >> before this makes sense to apply. With ocv-capacity-table we should be
> >> able to estimate battery state as described in the documentation for
> >> Documentation/devicetree/bindings/power/supply/battery.txt.
> >=20
> > Maybe we should let userspace do that?
> >=20
> > https://github.com/pavelmachek/libbattery
>=20
> Unless this gets integrated in UPower, My point of view is that
> userspace probably wants some uniform approach. Kernel interface
> definitely is one uniform interface that would also get picked up by UPow=
er.

I see that it is convenient to have it in kernel. I just assumed
Sebastian would not take that, because it does not _need_ to be in
kernel...

And maybe it is easier in userspace, since userspace has access to
persistent storage, so it can store detailed battery calibration
parameters? (And Gnome/Mate even does something like that, see
mate-power-statistics).

So... not my decision. Don't care too much either way. I have been
doing this in userspace, but...

What I'd like to see is some kind of indication that "this attribute
is not from hardware, kernel computed it for you" so clever userspace
can ignore it/compute it in more advanced way.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXid6awAKCRAw5/Bqldv6
8hiVAJoCECzK3dmkjV9JCaZ/ZaxxL6XJLgCfbj/EfZum9xpiGvFPw9zLtlbf2nU=
=e/PU
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

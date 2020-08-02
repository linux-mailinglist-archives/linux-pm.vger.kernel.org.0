Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B7235795
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHBO21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 10:28:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60200 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHBO21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2020 10:28:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DF1EC1C0BD4; Sun,  2 Aug 2020 16:28:25 +0200 (CEST)
Date:   Sun, 2 Aug 2020 16:28:25 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Qiwu Huang <yanziily@gmail.com>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200802142825.GA20261@amd>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug>
 <20200802123742.GA257810@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20200802123742.GA257810@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-08-02 14:37:42, Greg KH wrote:
> On Sun, Aug 02, 2020 at 02:00:15PM +0200, Pavel Machek wrote:
> > On Mon 2020-07-20 13:47:14, Qiwu Huang wrote:
> > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > >=20
> > > Reports the kind of quick charge type based on
> > > different adapter power.
> > >=20
> > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++++++++++++=
++
> > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > >  include/linux/power_supply.h                | 10 ++++++++++
> > >  3 files changed, 32 insertions(+)
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentat=
ion/ABI/testing/sysfs-class-power
> > > index 216d61a22f1e..dd3773dcf16a 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -708,3 +708,24 @@ Description:
> > > =20
> > >  		Access: Read
> > >  		Valid values: 1-31
> > > +
> > > +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> > > +Date:		Jul 2020
> > > +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> > > +		Description:
> > > +		Reports the kind of quick charge type based on different adapter p=
ower.
> > > +		Different quick charge type represent different charging power.
> > > +		QUICK_CHARGE_NORMAL : Charging Power <=3D 10W
> > > +		QUICK_CHARGE_FAST : 10W < Charging Power <=3D 20W
> > > +		QUICK_CHARGE_FLASH : 20W < Charging Power <=3D 30W
> > > +		QUICK_CHARGE_TURBE : 30W < Charging Power <=3D 50W
> > > +		QUICK_CHARGE_SUPER : Charging Power > 50W
> > > +
> > > +		Access: Read-Only
> > > +		Valid values:
> > > +			0: QUICK_CHARGE_NORMAL,
> > > +			1: QUICK_CHARGE_FAST,
> > > +			2: QUICK_CHARGE_FLASH,
> > > +			3: QUICK_CHARGE_TURBE,
> > > +			4: QUICK_CHARGE_SUPER.
> >=20
> > NAK.
> >=20
> > Just expose value in watts or something... People are talking about > 1=
00W charging, no
> > need to go with fast/turbe/super/hyper/nonsense.
> >=20
> > BTW fast charge is already "well defined", and what you call Normal is =
usually fast charge.
>=20
> I think these names come from the Qi charging spec, right?  So lets use
> what is given to us.

There are other standards, and this should better be generic.

Simply expose value in watts.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8mzYkACgkQMOfwapXb+vLHmwCfe58sH+wQnjUwSoQDY71diLxA
W1gAnjcLHsCbfBEBb8DBVMKF+jM8H2MM
=GuP/
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2116911029
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEAX1n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:27:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37578 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfEAX1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:27:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 10868263A05
Received: by earth.universe (Postfix, from userid 1000)
        id 658DA3C0D1B; Thu,  2 May 2019 01:27:38 +0200 (CEST)
Date:   Thu, 2 May 2019 01:27:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, jchwong@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v5 1/3] power_supply: Add Standard, Adaptive, and Custom
 charge types
Message-ID: <20190501232738.wvxvhcomj5xyesbk@earth.universe>
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
 <e5ec00fc-5075-85f7-4bd3-1745687f9a3e@collabora.com>
 <CAHX4x87APA8eSD0pCwkBFcR_JxRQsxsH-Ur7186BnHBF=PZf+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="al42vkdcvxlghjvs"
Content-Disposition: inline
In-Reply-To: <CAHX4x87APA8eSD0pCwkBFcR_JxRQsxsH-Ur7186BnHBF=PZf+A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--al42vkdcvxlghjvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

Yes. I merged the three patches adding the generic power supply
properties, thanks.

-- Sebastian

On Wed, May 01, 2019 at 10:34:38AM -0600, Nick Crews wrote:
> Hi Sebastian, does this look like an acceptable way of splitting up the
> content into multiple commits?
>=20
> Sorry to bug, and thanks,
> Nick
>=20
> On Tue, Apr 23, 2019 at 7:55 AM Enric Balletbo i Serra <
> enric.balletbo@collabora.com> wrote:
>=20
> >
> >
> > On 18/4/19 18:43, Nick Crews wrote:
> > > Add "Standard", "Adaptive", and "Custom" modes to the charge_type
> > > property, to expand the existing "Trickle" and "Fast" modes.
> > > I am adding them in order to support a new Chrome OS device,
> > > but these properties should be general enough that they can be
> > > used on other devices.
> > >
> > > The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
> > > more tricky: "Adaptive" means that the charge controller uses some
> > > custom algorithm to change the charge type automatically, with no
> > > configuration needed. "Custom" means that the charge controller uses =
the
> > > POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for so=
me
> > > other algorithm.
> > >
> > > v5 changes:
> > > - Split up adding the charge types and adding the
> > >   POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
> > >   POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties into
> > >   two different commits.
> > > v4 changes:
> > > - Add documentation for the new properties, and add documentation for
> > >   the the previously missing charge_control_limit and
> > >   charge_control_limit_max properties.
> > >
> > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> >
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 12 +++++++++---
> > >  drivers/power/supply/power_supply_sysfs.c   |  2 +-
> > >  include/linux/power_supply.h                |  8 ++++++--
> > >  3 files changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power
> > b/Documentation/ABI/testing/sysfs-class-power
> > > index 5e23e22dce1b..544c4e0ef8b6 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -119,10 +119,16 @@ Date:           July 2009
> > >  Contact:     linux-pm@vger.kernel.org
> > >  Description:
> > >               Represents the type of charging currently being applied=
 to
> > the
> > > -             battery.
> > > +             battery. "Trickle", "Fast", and "Standard" all mean
> > different
> > > +             charging speeds. "Adaptive" means that the charger uses
> > some
> > > +             algorithm to adjust the charge rate dynamically, without
> > > +             any user configuration required. "Custom" means that the
> > charger
> > > +             uses the charge_control_* properties as configuration f=
or
> > some
> > > +             different algorithm.
> > >
> > > -             Access: Read
> > > -             Valid values: "Unknown", "N/A", "Trickle", "Fast"
> > > +             Access: Read, Write
> > > +             Valid values: "Unknown", "N/A", "Trickle", "Fast",
> > "Standard",
> > > +                           "Adaptive", "Custom"
> > >
> > >  What:
> > /sys/class/power_supply/<supply_name>/charge_term_current
> > >  Date:                July 2014
> > > diff --git a/drivers/power/supply/power_supply_sysfs.c
> > b/drivers/power/supply/power_supply_sysfs.c
> > > index dce24f596160..64dff5cfecc3 100644
> > > --- a/drivers/power/supply/power_supply_sysfs.c
> > > +++ b/drivers/power/supply/power_supply_sysfs.c
> > > @@ -56,7 +56,7 @@ static const char * const power_supply_status_text[=
] =3D
> > {
> > >  };
> > >
> > >  static const char * const power_supply_charge_type_text[] =3D {
> > > -     "Unknown", "N/A", "Trickle", "Fast"
> > > +     "Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive",
> > "Custom"
> > >  };
> > >
> > >  static const char * const power_supply_health_text[] =3D {
> > > diff --git a/include/linux/power_supply.h b/include/linux/power_suppl=
y.h
> > > index 2f9c201a54d1..e86e05d8134d 100644
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -40,11 +40,15 @@ enum {
> > >       POWER_SUPPLY_STATUS_FULL,
> > >  };
> > >
> > > +/* What algorithm is the charger using? */
> > >  enum {
> > >       POWER_SUPPLY_CHARGE_TYPE_UNKNOWN =3D 0,
> > >       POWER_SUPPLY_CHARGE_TYPE_NONE,
> > > -     POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
> > > -     POWER_SUPPLY_CHARGE_TYPE_FAST,
> > > +     POWER_SUPPLY_CHARGE_TYPE_TRICKLE,       /* slow speed */
> > > +     POWER_SUPPLY_CHARGE_TYPE_FAST,          /* fast speed */
> > > +     POWER_SUPPLY_CHARGE_TYPE_STANDARD,      /* normal speed */
> > > +     POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,      /* dynamically adjusted
> > speed */
> > > +     POWER_SUPPLY_CHARGE_TYPE_CUSTOM,        /* use CHARGE_CONTROL_*
> > props */
> > >  };
> > >
> > >  enum {
> > >
> >

--al42vkdcvxlghjvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzKK18ACgkQ2O7X88g7
+ppqnw/1EwBjVwQBpcZbEi9Yrv1AvPaTcjsCcFuc6dVU8IlmR86JbO0yAYL9zEIW
B8QzrPazNUYVsjyAOCBcjMx1jqsC4e2yB9KIDqADVq/u1+KvwoBFMYDHwLdaCb96
KhWXkLuGCQx8T3UgShaF+hpjPaRFzHqok0KNVXtHD7gkapM+YBmK2FgXK5uI+MwX
vficrtDIhsuWk9xtJ8XndnXhre0H2OrHbxIqabjQPSPvm6i8OYvTFi1r7Erdxhpu
j0PnmFD31YRqPyPUke0SQOeifOwNBQ+JEUgMsC9QRMd5NX31oHArxReHSc1ZqxUl
dTK6r2CE8hOKStYxPqP8OqEalqcQfyiRtIMcEBF2cA3MTkv+xAqFXGPWZMOatJlL
kPLqnxNpE9PRFmOXCaVsB/rrlBe7nUWGWdekmgatdy9Eb5xUvM3N4Oc6692Q0Ckk
UDYIPO7GzFC72tZXhSNGQoXbyhchF13vnl+ohfB9pOeqIW1jKDLAD8gy7/ocTAcZ
u3BzYa6p4IgQ9WX+Pm2CxIf0o0foBOQOckJyHjsZZzSUVA14h/HRaOx0mB65vuCu
r98frFNiqbAX+yDFn1eiYeCUvmoj46t6MYyhSeT1RSjw5Abrd/4zr9Z0q78mwBTP
/dhYwN3n4hatvZ1Ah+rQW4kJe3h4Z/nC6N2Pjtjv7R7Z79iswQ==
=fv/A
-----END PGP SIGNATURE-----

--al42vkdcvxlghjvs--

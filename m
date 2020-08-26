Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED42539FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 23:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZV74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 17:59:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZV7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 17:59:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 42A8329946E
Received: by earth.universe (Postfix, from userid 1000)
        id E7C103C0C82; Wed, 26 Aug 2020 23:59:50 +0200 (CEST)
Date:   Wed, 26 Aug 2020 23:59:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/2] power: supply: Add support for RN5T618/RC5T619
 charger and fuel gauge
Message-ID: <20200826215950.bkzk76lwax7l6arz@earth.universe>
References: <20200815165610.10647-1-andreas@kemnade.info>
 <20200815165610.10647-2-andreas@kemnade.info>
 <20200826174817.vhus3j4i4t7u7jc4@earth.universe>
 <20200826202834.42b1673f@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pa4o3hd67cmcjsut"
Content-Disposition: inline
In-Reply-To: <20200826202834.42b1673f@aktux>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pa4o3hd67cmcjsut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 26, 2020 at 08:28:34PM +0200, Andreas Kemnade wrote:
> On Wed, 26 Aug 2020 19:48:17 +0200
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> > On Sat, Aug 15, 2020 at 06:56:09PM +0200, Andreas Kemnade wrote:
> > > [...]
> > > +static int rn5t618_battery_current_now(struct rn5t618_power_info *in=
fo,
> > > +				       union power_supply_propval *val)
> > > +{
> > > +	u16 res;
> > > +	int ret;
> > > +
> > > +	ret =3D rn5t618_battery_read_doublereg(info, RN5T618_CC_AVEREG1, &r=
es);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val->intval =3D res;
> > > +	/* 2's complement */
> > > +	if (val->intval & (1 << 13))
> > > +		val->intval =3D val->intval - (1 << 14);

Btw. I think sign_extend32() can be used here?

> > > +	/* negate current to be positive when discharging */
> > > +	val->intval *=3D -1000; =20
> >=20
> > mh, the sign is not documented (which should be fixed). At least
> > sbs-battery does it the other way around (negative current when
> > discharging, positive otherwise). Some drivers do not support
> > signed current and always report positive values (e.g. ACPI driver).
> >=20
> > What did you use as reference for swapping the sign?
> >=20
> Well, I have searched for documentation, found nothing and used the
> bq27xxx driver as reference  which I am used to from the GTA04/GTA02,
> so things behave equal. That are the devices where a was most
> intensively looking at those values.
> I thought that there would be some unwritten rule about that.

The mess is mostly due to lacking reviewing from my side
(and possibly my predecessors). I just went through a dozen of
drivers and it looks like most either do not support signed current
(and use negative values as error code :() or use negative current
for discharge. I could not find any other driver using negative
numbers for charging. I think it's best to negative =3D discharge as
official correct value and will send an update patch for the
documentation later.

-- Sebastian

--pa4o3hd67cmcjsut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9G204ACgkQ2O7X88g7
+poT0hAAo9qt3MJtmVC4Jo5cRFg8HtHcMV/QonFv94AU1H1EF/yXqztd2Q2GpQJo
Q91b0E0d6fBYsVhofss7D2Oq2dqEeSQlAUs1UohcXQlySBfsIPI4UYm+hxdkVegA
9Qaj5q6oFEZrHvN0O4hq86iH4dtelG0SgYbxWwpfnaehk+uTHdazVzwoBACw9q+s
j+5HRlqs0aelpVP2y8Sab0XQQHlt14Fl6r17vxuIxM4p0K7ks1+yElJtx1fyNrjO
Pvx72OyR40mEfGtMJErLpHEWDNAY7MZYUbb1VwWQ3uYOtmvI3RNcnP2ffXMR6j0t
J14Ll3Aui93Ka9GvM+hDivWw4/pehfDrajMs4xlpu2mtAwFmvZpUtxhGB5pRd54Q
MO2oaOaOmrWS5Klrpw57PN5PMHdODglZL8URpPD7x4bznVbEge9ekB6UowrJIsyp
7DQsb2VlVYkHGt3pY17XW0h80Lbc/IYLUlUgnkmrxBHkbI8vGWwJKsCT0Kx82ZwL
m+0NWKdVVfb/sQGTeWS4kAh82y4/llJlmZx4/QzzM57EKk0V4ZuUHNBAA+f8QgU1
0/S6jmXiv9/uU6aTqQXLHKDX3dInXMZS289aibvWYQAFcXeDF95qHDhbQoIzGWUk
WANu3gcDoWSzW2pdGlKtWjKvQtbGeyY4crVsIzomPQfqVe+tZng=
=ozPK
-----END PGP SIGNATURE-----

--pa4o3hd67cmcjsut--

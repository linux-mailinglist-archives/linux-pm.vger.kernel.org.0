Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF123A395
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgHCLuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 07:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHCLty (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 07:49:54 -0400
Received: from earth.universe (dyndsl-095-033-153-018.ewe-ip-backbone.de [95.33.153.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F62E20738;
        Mon,  3 Aug 2020 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596455392;
        bh=TS+oGh6Jm5K4oAPLNUEIM1NC7EmU71L2qngjo1TPL5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JseAVszHk4cgS5ayaSb7PJB6N8DHMrl278H7TfUHY4Pti3KQ2bgRvmhRAUm1T5hf5
         izrz3Z+HjMo3YPuvPwnYwO5SiGa2QZncewINUwZaW2xMPFcOu2Gj1y23iNsWM/H0z/
         dWCRMXhzOThfMH3osFUg0hPtSir5NJcn4Z9PF7IY=
Received: by earth.universe (Postfix, from userid 1000)
        id C9B543C0B95; Mon,  3 Aug 2020 13:49:50 +0200 (CEST)
Date:   Mon, 3 Aug 2020 13:49:50 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, Qiwu Huang <yanziily@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200803114950.oyb3gzyiccybah3u@earth.universe>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug>
 <20200802123742.GA257810@kroah.com>
 <20200802142825.GA20261@amd>
 <20200802165738.GA293244@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3tlbatxliq5aoxn6"
Content-Disposition: inline
In-Reply-To: <20200802165738.GA293244@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3tlbatxliq5aoxn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 02, 2020 at 06:57:38PM +0200, Greg KH wrote:
> On Sun, Aug 02, 2020 at 04:28:25PM +0200, Pavel Machek wrote:
> > On Sun 2020-08-02 14:37:42, Greg KH wrote:
> > > On Sun, Aug 02, 2020 at 02:00:15PM +0200, Pavel Machek wrote:
> > > > On Mon 2020-07-20 13:47:14, Qiwu Huang wrote:
> > > > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > >=20
> > > > > Reports the kind of quick charge type based on
> > > > > different adapter power.
> > > > >=20
> > > > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++++++++=
++++++
> > > > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > > > >  include/linux/power_supply.h                | 10 ++++++++++
> > > > >  3 files changed, 32 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Docume=
ntation/ABI/testing/sysfs-class-power
> > > > > index 216d61a22f1e..dd3773dcf16a 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > > > @@ -708,3 +708,24 @@ Description:
> > > > > =20
> > > > >  		Access: Read
> > > > >  		Valid values: 1-31
> > > > > +
> > > > > +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> > > > > +Date:		Jul 2020
> > > > > +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> > > > > +		Description:
> > > > > +		Reports the kind of quick charge type based on different adapt=
er power.
> > > > > +		Different quick charge type represent different charging power.
> > > > > +		QUICK_CHARGE_NORMAL : Charging Power <=3D 10W
> > > > > +		QUICK_CHARGE_FAST : 10W < Charging Power <=3D 20W
> > > > > +		QUICK_CHARGE_FLASH : 20W < Charging Power <=3D 30W
> > > > > +		QUICK_CHARGE_TURBE : 30W < Charging Power <=3D 50W
> > > > > +		QUICK_CHARGE_SUPER : Charging Power > 50W
> > > > > +
> > > > > +		Access: Read-Only
> > > > > +		Valid values:
> > > > > +			0: QUICK_CHARGE_NORMAL,
> > > > > +			1: QUICK_CHARGE_FAST,
> > > > > +			2: QUICK_CHARGE_FLASH,
> > > > > +			3: QUICK_CHARGE_TURBE,
> > > > > +			4: QUICK_CHARGE_SUPER.
> > > >=20
> > > > NAK.
> > > >=20
> > > > Just expose value in watts or something... People are talking about=
 > 100W charging, no
> > > > need to go with fast/turbe/super/hyper/nonsense.
> > > >=20
> > > > BTW fast charge is already "well defined", and what you call Normal=
 is usually fast charge.
> > >=20
> > > I think these names come from the Qi charging spec, right?  So lets u=
se
> > > what is given to us.
> >=20
> > There are other standards, and this should better be generic.
>=20
> What standard?  Why not go with this one, it's documented and out there
> and being used.

Well there is Power Delivery from USB Standard, Quick Charge from
Qualcomm, Super Charge from Huawei, Dash/Warp Charge from OnePlus,
Pump Express from Mediatek and the Qi stuff for wireless charging.
Possibly a few more, that I'm not aware of. Quickly charging devices
is a huge mess :(

The naming suggests that this is for Qualcomm's "Quick Charge"?

> > Simply expose value in watts.
>=20
> What if you do not know the watts, you just know these ranges.

In general those chargers often do not know the exact watts/amps
and that information can only be gained from the battery fuel
gauge (which usually has a coulomb counter). Exposing the charger
class means there is a way to debug problems, so it makes sense
IMHO. But the classification is quite different between the vendor's
proprietary quick charge algorithms, so we need to be careful with
the naming. It should be clear which property should be used
for given hardware.

More importantely I prefer not to merge new APIs without any users
(i.e. a driver making use of those values). Having a reference
driver means, that there is an example how to use the values
correctly and proves it is actually needed upstream. Right now
this looks like "let's modify the upstream kernel, so that we can
easily maintain our out of tree driver".

-- Sebastian

--3tlbatxliq5aoxn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8n+cwACgkQ2O7X88g7
+pp8bxAAoAuqFLNlN/96pOqBrHgZNuR9pbfYZPYn7nBJi8tYYmjKGb7lKEjKAgOj
hp93fE6SWVzaLpVqbIq1TReb66CPOoiXgmw+nUonj9v+2CsskCD9R3CYsf+XH+N6
vtYo/ptQGoYM1Mr/sVYTQvh8glkDzCa5N2bCqSUY4xXidHflGfa9pwVzUijJ9ZFr
tFESWJ/WfOdXRavmuDQk5/jXKxn161uqW6pURwkdwHSHD0Wp0pmZMbnUOlsZgim9
6y3qiL/duWwlZuHUjKXncO/Q8Z025jgAQcoADZjKDtky/tkGRjaPEZmN0hreNHNg
k5f9n8Gkar6pOQeWr4LFfOghaBT57TBCryA3lCUmfaUd1fdbd88KwFCU48K9Eq7y
wtdU/Squh08tUAKEx8IHejHwA8YoSaJfRqt2eXTxMIsM4FN4HXi48aZ6h7VmpsLl
u0AzJ1jPr0UOBP6u2K8MVMcLmP/nrfcwgNvAkft1AUAEzuT6WeKfXLcgLYQoZavT
cl3vrJ/fCRQS0mbZopaScwkYUt2q0mGBng+CPdHgcvcFbZWFQz3gasAdqLTckgcT
BZ4i42ewffch+1d/PwwEYJUuGGsR2anq35iDKJ+fHHBa+C5oOTzbRDv3N/M7zULI
9GD+al+aFuc1ij6GYDzhYShRbHtbwV5kZKrN5zeIF2RzttH78p4=
=yf/q
-----END PGP SIGNATURE-----

--3tlbatxliq5aoxn6--

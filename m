Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A780A3674A9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 23:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhDUVKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 17:10:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38328 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbhDUVKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 17:10:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 59E581F4262B
Received: by earth.universe (Postfix, from userid 1000)
        id C6FAF3C0C96; Wed, 21 Apr 2021 23:09:32 +0200 (CEST)
Date:   Wed, 21 Apr 2021 23:09:32 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     Tony Lindgren <tony@atomide.com>, zhuguangqing83@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cpcap-battery: fix invalid usage of
 list cursor
Message-ID: <20210421210932.mydyhrz5zdxj47mr@earth.universe>
References: <20210421143650.16045-1-zhuguangqing83@gmail.com>
 <YIBNDrHlwqn5hrl2@atomide.com>
 <20210421191933.6fa083e0b2496aedaef4957a@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6avv6kdiosg4bxgh"
Content-Disposition: inline
In-Reply-To: <20210421191933.6fa083e0b2496aedaef4957a@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6avv6kdiosg4bxgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 21, 2021 at 07:19:33PM +0200, Carl Philipp Klemm wrote:
> Tony Lindgren <tony@atomide.com> wrote:
> > * zhuguangqing83@gmail.com <zhuguangqing83@gmail.com> [210421 14:38]:
> > > From: Guangqing Zhu <zhuguangqing83@gmail.com>
> > >=20
> > > Fix invalid usage of a list_for_each_entry in cpcap_battery_irq_threa=
d().
> > > Empty list or fully traversed list points to list head, which is not
> > > NULL (and before the first element containing real data).
> > >=20
> > > Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> > > ---
> > > v2:
> > >   - Modify commit message and code as suggested by Sebastian.
> >=20
> > Thanks looks OK to me. Looks like there's no flag we need to set there =
when
> > the entry is found, so this should do for the check.
> >=20
> > Hmm I wonder if this just might fix the issue where booting with a USB
> > charger connected can hang..
> >=20
> > Reviewed-by: Tony Lindgren <tony@atomide.com>
>
> Looks good to me, but dosent appear to solve the bootup bug.
>=20
> (this time reply all)
>=20
> Reviewed-by: Carl Philipp Klemm <philipp@uvos.xyz>
> Tested-by: Carl Philipp Klemm <philipp@uvos.xyz>

Thanks, queued.

-- Sebastian

> > >  drivers/power/supply/cpcap-battery.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/sup=
ply/cpcap-battery.c
> > > index 6d5bcdb9f45d..a3fc0084cda0 100644
> > > --- a/drivers/power/supply/cpcap-battery.c
> > > +++ b/drivers/power/supply/cpcap-battery.c
> > > @@ -786,7 +786,7 @@ static irqreturn_t cpcap_battery_irq_thread(int i=
rq, void *data)
> > >  			break;
> > >  	}
> > > =20
> > > -	if (!d)
> > > +	if (list_entry_is_head(d, &ddata->irq_list, node))
> > >  		return IRQ_NONE;
> > > =20
> > >  	latest =3D cpcap_battery_latest(ddata);
> > > --=20
> > > 2.17.1
> > >=20

--6avv6kdiosg4bxgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCAlIAACgkQ2O7X88g7
+poDmA//el+ktIj4fLDAxtBSosuFD00WMU2CN34vj9MPKsAzb4OndyIqkkn9VRIp
LxDBOtSTUFok8FOsHcK2uUPwNiLicZnUCrWbzmbzZdpVzDWKtCgs7bZoUiSNAWO4
hMHk1ApGU/8Uw4p4F1C0orjIqblJHxMHIK7oxxQKF1503HaAKIXdDwTquR0RVej7
v7ixOTs0kAQl609NNx2auu5pZ7kFL++ZYqb5Ht40zItCRN4zNRFCfR6ery8/AzQ+
1kf9yLWPJHoCVHs/lAEkbzd4oXrbQOm01tOwKqfQkDgL0DViprfKB+UIHkk2WrWB
tbxYVzR2hTFx5KzFdULKzh/iLlRIHKu/CZnLexhOXLEV9E96VkToF/boVnqksi8a
3W4U5PEC+bPinNVdgbIT6y7R5jcgbTQvArQv0eKpnKrHsgUdoA11FybTQ1KU2xwb
Ga+VAv2k7mIUufML1NotZCG8NmuQ3sQZyj5/jpltL/usdVTnWKAaphomHz0E3A8k
tUqAJG0KsdxutD/EqXFJCj10jUT5vLR+RWvFHk+KeoS8Ocy1NfLY/gHsGXLiKOmP
Z1FXod0jt4I0e9kQix99nf8wKq+7pJtQzAp54QZ8RWAxboczT2J1eSsu5PvCmRN4
JPeg/hSpshqr6b/akRILDNAEgzWgK2BQXP9PcbRsM/lrLIEx46I=
=K2Gm
-----END PGP SIGNATURE-----

--6avv6kdiosg4bxgh--

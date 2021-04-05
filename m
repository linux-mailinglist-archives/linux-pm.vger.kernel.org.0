Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A5353C56
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhDEIWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 04:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDEIWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 04:22:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC0EC061756;
        Mon,  5 Apr 2021 01:22:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 608AA1F40EDB
Received: by earth.universe (Postfix, from userid 1000)
        id 17ED93C0C96; Mon,  5 Apr 2021 10:22:01 +0200 (CEST)
Date:   Mon, 5 Apr 2021 10:22:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Carl Philipp Klemm <philipp@uvos.xyz>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/5] power: supply: cpcap-charger: fix small mistake in
 current to register conversion
Message-ID: <20210405082201.v2nbm7bsej25uyva@earth.universe>
References: <20210117224745.40c38ae352761663db1752c9@uvos.xyz>
 <YGlpb+AHo/qtLxDI@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxvbqvlnpo7oos5f"
Content-Disposition: inline
In-Reply-To: <YGlpb+AHo/qtLxDI@atomide.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mxvbqvlnpo7oos5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 04, 2021 at 10:23:27AM +0300, Tony Lindgren wrote:
> * Carl Philipp Klemm <philipp@uvos.xyz> [210117 23:47]:
> > Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks, queued.

-- Sebastian

> > ---
> >  drivers/power/supply/cpcap-charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/suppl=
y/cpcap-charger.c
> > index 152090faf5b2..be7d1da7a5a5 100644
> > --- a/drivers/power/supply/cpcap-charger.c
> > +++ b/drivers/power/supply/cpcap-charger.c
> > @@ -300,7 +300,7 @@ static int cpcap_charger_current_to_regval(int micr=
oamp)
> >  		return CPCAP_REG_CRM_ICHRG(0x0);
> >  	if (miliamp < 177)
> >  		return CPCAP_REG_CRM_ICHRG(0x1);
> > -	if (miliamp > 1596)
> > +	if (miliamp >=3D 1596)
> >  		return CPCAP_REG_CRM_ICHRG(0xe);
> > =20
> >  	res =3D microamp / 88666;
> > --=20
> > 2.29.2
> >=20

--mxvbqvlnpo7oos5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBqyKgACgkQ2O7X88g7
+ppATQ//SDH1jDSHKp9+Q8mBAHsBDkO/iPHr/dwNpHHND45bdZz1DZVA13zkPkTZ
txJ/LRZLlieytbwMU/UKW/2J0hIhqWfO4+7YR+NX393OGPLNT9v7KfP3eRI5MCUg
+G5vm6iro09nVNznVjRF+xVJndY4P3fzTS11kw7BbQP4DM4G8osMnPQgqWn0Ygwg
Dm/7bnaPqvO8yKxE0omWrmGBuB31c/ABKeEi8Dgs/KIE6NFzBeXdwcbSFVBMNSvU
c9vLGD2QlBVHLqreHvLBuIzS8gIgN3/C+zmUhAEEY3OXt3vFGx2aI/UyRHu6Cu8M
CbNVpna502ogvUKyS/1bOi2/DZvL95HNaNE8VIJ+9WfMtvS0Q9n9No3lIt2E/aQy
Az9jfJFaXaGPOJlMlmzahNiocRWsw1XHWBpZRAMbAJb3wce6YGiuo+nfRiFkn0Ls
tEQVEtUJ0zUsf0i45kY03jfDhAtBZYZfEeuMMoXqciWCwU4deErVhzSCrS6dGm+r
uuVwbjWhLxs/5yiSJQRhtcwy5ZCQlMdMEAlY0Rkkmjcb8o6fm3YUN3CKG9+u1Tl6
B+gxj8ZWq8BTTX/GX3Xi8E1I6Ki87E4k49lfFE2jsa+NBGYteS4qN7ZZ0xmiKTGB
R1srVADJIsEOcs/INmhoOOVxEoSZ/69e8Nb7HPbtCqSk2tmR380=
=HnDd
-----END PGP SIGNATURE-----

--mxvbqvlnpo7oos5f--

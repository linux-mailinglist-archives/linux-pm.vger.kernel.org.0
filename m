Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE939B949
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFDNAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 09:00:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFDNAY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 09:00:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0585B1F439C8
Received: by earth.universe (Postfix, from userid 1000)
        id 408F63C0C95; Fri,  4 Jun 2021 14:58:36 +0200 (CEST)
Date:   Fri, 4 Jun 2021 14:58:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: surface-charger: Fix type of integer
 variable
Message-ID: <20210604125836.ew4y27ofa4bwi6uk@earth.universe>
References: <20210511092421.1928586-1-luzmaximilian@gmail.com>
 <55aafbea-96d4-29f2-8d8b-68f8ac970c6b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckokow4kmkwkjq7n"
Content-Disposition: inline
In-Reply-To: <55aafbea-96d4-29f2-8d8b-68f8ac970c6b@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ckokow4kmkwkjq7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 03, 2021 at 08:37:13PM +0200, Maximilian Luz wrote:
> On 5/11/21 11:24 AM, Maximilian Luz wrote:
> > The ac->state field is __le32, not u32. So change the variable we're
> > temporarily storing it in to __le32 as well.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: e61ffb344591 ("power: supply: Add AC driver for Surface Aggregat=
or Module")
> > Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>=20
> Friendly ping :)

Thanks, this has now been queued to my fixes branch.

-- Sebastian

> > ---
> >   drivers/power/supply/surface_charger.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/sup=
ply/surface_charger.c
> > index 81a5b79822c9..a060c36c7766 100644
> > --- a/drivers/power/supply/surface_charger.c
> > +++ b/drivers/power/supply/surface_charger.c
> > @@ -66,7 +66,7 @@ struct spwr_ac_device {
> >   static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
> >   {
> > -	u32 old =3D ac->state;
> > +	__le32 old =3D ac->state;
> >   	int status;
> >   	lockdep_assert_held(&ac->lock);
> >=20

--ckokow4kmkwkjq7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6I3wACgkQ2O7X88g7
+prCqg/+Jkw7uZPPHwkCon2Kk6TYJ9v/9HR1NZ20D9VFpB7WtKZ3oHyv8/Zav2RK
FWfqVNkagbabyKjOx3WZHwCgCYG45/dPY2OOLCgJ3ml3/x9omHH+6BEtT1nNPIrH
/4azgeufGGqXbu4zTTESOQ1iT8T5pzEC/nuKT0L7ZEUDrDXavGc+3U+xNGKC1SX+
LZ0Od8VOP8F4izdCLXar/NUIQFCb9tVW5auvjL2lffnXyu1kYqAawknXPB91uikZ
FOoLWC5j5rcDlcBZiRquH5ig+ftofnPNmA8EJsRI4YjMcSiiG09q344mBRLsi61H
ZyJe756aTjpi1cHeCAyY+IjqtapperZ0YEbw5yTzjJD2OpwJ4zSsQtdGR9+rEmpv
ga8zYnaeRCYiAeHsYYGP0GTBEngIDVNVlZ+RDSDrgspIJt+0xy92v2TlzJ5fiFdQ
gV5FeNPg+w12zv61h2EDwWzUb34vo7WuBG7bSg4osDcPdkDTBd+RmkYNs1i1x/Wm
S8fHFgPcWvDcWByyzAFLD5Ertj01L6CJicbHqJXwDmUC7cd5nZQWzaQ2iTGBXBoc
hCfBAYg1I9l4YNBT/d32g8cPQDCH+8n2pXP/JC+1N93nTlXNrIt+MreamVlAy+2U
ztc6HMTezOSiTwrRbsSHlALbJVZx/cssM8DJl+g8iyLTzBYmI3c=
=na9I
-----END PGP SIGNATURE-----

--ckokow4kmkwkjq7n--

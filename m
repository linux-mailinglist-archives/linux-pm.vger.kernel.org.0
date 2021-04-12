Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056235D197
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhDLUAh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 16:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbhDLUAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 16:00:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D622C061574;
        Mon, 12 Apr 2021 13:00:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3FBA51F44D1C
Received: by earth.universe (Postfix, from userid 1000)
        id 024C03C0C96; Mon, 12 Apr 2021 22:00:16 +0200 (CEST)
Date:   Mon, 12 Apr 2021 22:00:15 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Qiheng Lin <linqiheng@huawei.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] power: supply: Make symbol 'surface_ac_pm_ops'
 static
Message-ID: <20210412200015.klsjgbxozlcnzjuj@earth.universe>
References: <20210410041249.12846-1-linqiheng@huawei.com>
 <c5edfe56-eebe-55c0-e30f-4a552934d0b8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n6ae2inqxfgg5nqx"
Content-Disposition: inline
In-Reply-To: <c5edfe56-eebe-55c0-e30f-4a552934d0b8@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n6ae2inqxfgg5nqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 10, 2021 at 12:42:43PM +0200, Maximilian Luz wrote:
> On 4/10/21 6:12 AM, Qiheng Lin wrote:
> > The sparse tool complains as follows:
> >=20
> > drivers/power/supply/surface_charger.c:229:1: warning:
> >   symbol 'surface_ac_pm_ops' was not declared. Should it be static?
> >=20
> > This symbol is not used outside of surface_charger.c, so this
> > commit marks it static.
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
>=20
> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks, queued.

-- Sebastian

> > ---
> >   drivers/power/supply/surface_charger.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/sup=
ply/surface_charger.c
> > index c2dd7e604d14..81a5b79822c9 100644
> > --- a/drivers/power/supply/surface_charger.c
> > +++ b/drivers/power/supply/surface_charger.c
> > @@ -226,7 +226,7 @@ static int __maybe_unused surface_ac_resume(struct =
device *dev)
> >   {
> >   	return spwr_ac_recheck(dev_get_drvdata(dev));
> >   }
> > -SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
> > +static SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
> >   static int surface_ac_probe(struct ssam_device *sdev)
> >   {
> >=20

--n6ae2inqxfgg5nqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmB0ps8ACgkQ2O7X88g7
+pqFvQ/8Cop/jNAsC3l1eqybF101UmvzrrG6OVsg0c6gVF/OLg6VMwzvkPXudCL3
Hk+Pv1bZug9iqIGfpSDulUhLkpCucMcE7CVqWcmbvVNYSPGWcr2Gtd30gbK0Ixpc
u5AL2kBiv9oK3IEy70LLicY4pEjDFhMARBg84dcfID7PieRdm3x8Mw2mVfBRiyyy
dXqquHr3IK6NkYnd1DzI2bS3oC/GwuO40EdnKP5B52XABg87gXwR+Q/Mer7jGPTu
j/hS7v7PPZR3QknyL+crLQn68sXSWBumAfIhEnRIEEHSEKGz57YhV2cC3EFv4rWC
l7npOhAlFfCwAU775Hi9AerS6RvYFdi/SlitosDvXqRCi75aL/ufOq/6buDw0Bir
FEm6luo8UkDID45BZiO9NrFx8h72zt/H6JjTJn66K928jN1lh/EV4JCTUgF6NlJk
RUYZ6G8hbbekUWGOuuC8ijhCeQ/XkQF1AAYUh8Alzb+7i1az7vIqGUeyHY2qUcLk
/Ba13WDmmF/wypEp/gjzYAYAfo/qgusX9Hdg1YPBwRDDh/RXsE+okZ362ciN6F9C
vEEHazNgTPWHbugGEs7K+d4iwRgeAZdy3b65LR77Ewv5Pa5RWrdUP5GNLLWa8Z2Z
97ukXQabn7gvZ4NJFTxrkB6tKm0vcTxzCY6ds+lhj5/4GhpbDC4=
=YxJH
-----END PGP SIGNATURE-----

--n6ae2inqxfgg5nqx--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7BD35D193
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhDLUAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbhDLUAR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 16:00:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43358C061574;
        Mon, 12 Apr 2021 12:59:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id ABB371F44D1C
Received: by earth.universe (Postfix, from userid 1000)
        id 517023C0C96; Mon, 12 Apr 2021 21:59:55 +0200 (CEST)
Date:   Mon, 12 Apr 2021 21:59:55 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Qiheng Lin <linqiheng@huawei.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] power: supply: Make some symbols static
Message-ID: <20210412195955.cekbevvhwaksym3q@earth.universe>
References: <20210410041246.12791-1-linqiheng@huawei.com>
 <3026d506-4755-4885-4d22-9f589a660221@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4c4raao6ocdnmyi"
Content-Disposition: inline
In-Reply-To: <3026d506-4755-4885-4d22-9f589a660221@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--b4c4raao6ocdnmyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 10, 2021 at 12:41:10PM +0200, Maximilian Luz wrote:
> On 4/10/21 6:12 AM, Qiheng Lin wrote:
> > The sparse tool complains as follows:
> >=20
> > drivers/power/supply/surface_battery.c:700:1: warning:
> >   symbol 'dev_attr_alarm' was not declared. Should it be static?
> > drivers/power/supply/surface_battery.c:805:1: warning:
> >   symbol 'surface_battery_pm_ops' was not declared. Should it be static?
> >=20
> > This symbol is not used outside of surface_battery.c, so this
> > commit marks it static.
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
>=20
> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks, queued.

-- Sebastian

> > ---
> >   drivers/power/supply/surface_battery.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/sup=
ply/surface_battery.c
> > index 4116dd839ecd..7efa431a62b2 100644
> > --- a/drivers/power/supply/surface_battery.c
> > +++ b/drivers/power/supply/surface_battery.c
> > @@ -697,7 +697,7 @@ static ssize_t alarm_store(struct device *dev, stru=
ct device_attribute *attr, co
> >   	return count;
> >   }
> > -DEVICE_ATTR_RW(alarm);
> > +static DEVICE_ATTR_RW(alarm);
> >   static struct attribute *spwr_battery_attrs[] =3D {
> >   	&dev_attr_alarm.attr,
> > @@ -802,7 +802,7 @@ static int __maybe_unused surface_battery_resume(st=
ruct device *dev)
> >   {
> >   	return spwr_battery_recheck_full(dev_get_drvdata(dev));
> >   }
> > -SIMPLE_DEV_PM_OPS(surface_battery_pm_ops, NULL, surface_battery_resume=
);
> > +static SIMPLE_DEV_PM_OPS(surface_battery_pm_ops, NULL, surface_battery=
_resume);
> >   static int surface_battery_probe(struct ssam_device *sdev)
> >   {
> >=20

--b4c4raao6ocdnmyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmB0prsACgkQ2O7X88g7
+ppHCA//YhDPZITdMO3muJzoW5bu7WSLVq00uIINWgqTBQKDedfy47wTnHjn0+Lo
r2w/5HD2J7cd2+6Np0n0uo1tADtcFzusyT61JX/EYQKJ5mqWWKeF+LrDhNV+mch6
dRaAejLwXxSAPiM3RhCVkOt6NlBTQ0jqU2v9W4gsRjr+WANDrGsOTsZ/4IqSp+hi
Y75dIFlKg8hlC39U0ziRxh2ouLwZQojjRsbHqKi1qxTn3hgr7Tig2dSuajg6pAHW
Ap9xKgAGvxIwBWnvM8UqVR8NC0b7sg7S/ymr6PRaDoXZhZ7HcIDg9vzYS+uodMcu
GQ28k7kQPu58TpNs8aE2kgYNU05We7f7FwnFh2tJYAVIN860jrnmcJEwN6HHUgCK
SjNsK3UO0WUifmYBTtvChcHOXDb/OKwAdgJpf8eQodIwBPiVxbzMeCwB1+moAGk2
QTz/9GFfW5xaI4l/kaU/Noci7lCctbU0XoDKyM0ndz0jtSrgcuT530qVVmNA6gj5
yE1Sv9NIAkFeN16+J8rGlemiXcIazV5EoHHiwQs+p5l6KwOWDM/qkqFs4GkJwPCb
srfHEfn4V9lYInkYfC7eCK5fGIRB0EKXd2fY1fLWpDsi22AunkcK0h7BkBgp3pT9
wJfgXczKKb5srScB+Lcv6n9tKiHAziO/ZHiQtM3yaMUAxakg9oo=
=OFpp
-----END PGP SIGNATURE-----

--b4c4raao6ocdnmyi--

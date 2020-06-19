Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31818201907
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbgFSRD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 13:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbgFSRD0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 13:03:26 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31C320734;
        Fri, 19 Jun 2020 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592586205;
        bh=jm7iURKGIOvFqc9Z3q6moQdo07peRYBrkuujf/K565M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnJMZa4IoQ/Ve4GwA5VIoBqRjavl5heZUQEgDvqOxJgv8j8wugoopuQbI9i7RIPr0
         NgNMOZNiLUd1ykJjaVxmUMiB3E4QBmcAdx1wTPTtr8qUplZ701onbdmJbNWJKu8Kna
         wHJu201KmnSv2cj3rfeRM4wdLGYYYuoxgM0h/jo8=
Received: by earth.universe (Postfix, from userid 1000)
        id 0F7CC3C08CD; Fri, 19 Jun 2020 19:03:24 +0200 (CEST)
Date:   Fri, 19 Jun 2020 19:03:24 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] power: supply: bq24190_charger: Fix runtime PM
 imbalance on error
Message-ID: <20200619170324.2uh2uoqhzsrdwpmd@earth.universe>
References: <20200525110540.6949-1-dinghao.liu@zju.edu.cn>
 <CAJZ5v0j7cy1qZ5q3jWjJ77zJrVp+Kt2-4sWN3KF0jBgV9FOQew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfs6ocpfhxpyqlxm"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j7cy1qZ5q3jWjJ77zJrVp+Kt2-4sWN3KF0jBgV9FOQew@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hfs6ocpfhxpyqlxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 25, 2020 at 01:09:00PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 25, 2020 at 1:05 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrot=
e:
> >
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > it returns an error code. Thus a pairing decrement is needed on
> > the error handling path to keep the counter balanced.
> >
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>=20
> Better now:
>=20
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, queued.

-- Sebastian

> > ---
> >
> > Changelog:
> >
> > v2: - Use pm_runtime_put_noidle() rather than
> >       pm_runtime_put_autosuspend().
> > ---
> >  drivers/power/supply/bq24190_charger.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/sup=
ply/bq24190_charger.c
> > index 453d6332d43a..7b24c41a2137 100644
> > --- a/drivers/power/supply/bq24190_charger.c
> > +++ b/drivers/power/supply/bq24190_charger.c
> > @@ -481,8 +481,10 @@ static ssize_t bq24190_sysfs_store(struct device *=
dev,
> >                 return ret;
> >
> >         ret =3D pm_runtime_get_sync(bdi->dev);
> > -       if (ret < 0)
> > +       if (ret < 0) {
> > +               pm_runtime_put_noidle(bdi->dev);
> >                 return ret;
> > +       }
> >
> >         ret =3D bq24190_write_mask(bdi, info->reg, info->mask, info->sh=
ift, v);
> >         if (ret)
> > --
> > 2.17.1
> >

--hfs6ocpfhxpyqlxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s79sACgkQ2O7X88g7
+pq0+w/8C/4vBPrSRH0rWcIJdajqgkNmnPPK8jKZ/IqRvEi+xuN5o4udRKDddnV9
hcJqXPiyfWmUvgceyI9qDRd8GRk5ezUXH7izk3FCao9V9KJzem/YpkmAn2NbXQ+j
lhmw/sxVW12R7w0nlRCaQ7MxIdwfz6jt+L0ZPOCLZjSHZQk++46zF/zOlqUI0oKP
GNB04HMbgKjZpFKCw0UQrtPbbOJuciFCYcAUkFfL0SpNcGVxzcxWkH3SYC8kag5m
Dr5x+cex5tP5CxAPtvAqM2seMtba+tM3goOJH0ivmG6cP+3fu+4RuvPSQ6MIT0qy
o8QYMScUVO30V3Qxs2jBO8ytSAhZ425J/s8mQxOL14EhTP4DN3+UndgSaDj4ZcrX
TCfXtTQzwN6Z7Xln1GOp4Lpxdysp2MRVkDX0xffVc7kGR8EFl9EuFvf94IHuLE0y
Bc7PUwxD08G83VjIiItpaBd1UDvkZAx01dDnIXwN/ihd4a2GeAEvx/zhn8sksFwG
iEuEXLkgOmUiHa+hWgO80NCvaVDJ9rRs7amCgCfDNouonwe9DBC948WOxA+6ue8U
2N4bD2Y/u53ItO3ROXXulMjGOpNOQ1xmVLM6jGDGsCMlV6z8N8BN1qpo+73VlzCF
0KE0+HlED+ZfOYtoX3jEDb42OCVW7R4up9FDdGlsbeINiC7TOYc=
=veqx
-----END PGP SIGNATURE-----

--hfs6ocpfhxpyqlxm--

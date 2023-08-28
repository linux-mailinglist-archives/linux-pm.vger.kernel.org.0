Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716C78A729
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 10:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjH1IG2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjH1IGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 04:06:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1769114;
        Mon, 28 Aug 2023 01:06:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 451986607186;
        Mon, 28 Aug 2023 09:06:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693209979;
        bh=kV58buPVjDtdxXmHENO8P2ec4R8bJeK82hfUoWhb84I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S9IEtVk72yHqpdVthh0ij8JoCZIZgGyS+Le4vc7O09foWPuMPU5opQ8ZbJ0ZS8/Jc
         LP1VYJRUOqALa1j4QgJKP/7Ia50wHiafbh2j9QKKzv/yNPONt3aZRSYXCqctkoBz54
         mQbHnI7xMc1Ziyp1dpiKQrQVxsxjuLfy7I66vs5MnQPHwlPbO+VzJdV3vPiRTj+/Tz
         2mFCwWcuqA884NzOBbqpaEd09n5WjK1wvxlqyO2YgWeKHY/35AL599Ac8NT6WyzJQ1
         /dJuhAvxtv0ICZy/6hp9cPSUoJ64m401Vt7GxIBN6znZPl13/RwmzZ4GSTlvzEFrkj
         4rZxz6hpa0NRw==
Date:   Mon, 28 Aug 2023 10:06:16 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] thermal/of: Fix a leak in thermal_of_zone_register()
Message-ID: <20230828100616.7d64c98d@collabora.com>
In-Reply-To: <CAJZ5v0jZ8By3Mz_JM6O79p0af4GaRBXE4PgiCHVOuHWcf=UQsA@mail.gmail.com>
References: <20230809112348.2302384-1-boris.brezillon@collabora.com>
        <CAJZ5v0jZ8By3Mz_JM6O79p0af4GaRBXE4PgiCHVOuHWcf=UQsA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 11 Aug 2023 21:18:39 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Aug 9, 2023 at 1:23=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > thermal_zone_device_register_with_trips() copies the tzp info. After
> > calling this function, we should free the tzp object, otherwise it's
> > leaked.
> >
> > Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone pa=
rameters structure")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com> =20
>=20
> Hasn't this been fixed in -rc5?

It was indeed. I was based on -rc2 when I tested. Sorry for the noise.

>=20
> > ---
> >  drivers/thermal/thermal_of.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> > index 6fb14e521197..e74ef4fa576b 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -524,10 +524,17 @@ static struct thermal_zone_device *thermal_of_zon=
e_register(struct device_node *
> >         tz =3D thermal_zone_device_register_with_trips(np->name, trips,=
 ntrips,
> >                                                      mask, data, of_ops=
, tzp,
> >                                                      pdelay, delay);
> > +
> > +       /*
> > +        * thermal_zone_device_register_with_trips() copies the tzp inf=
o.
> > +        * We don't need it after that point.
> > +        */
> > +       kfree(tzp);
> > +
> >         if (IS_ERR(tz)) {
> >                 ret =3D PTR_ERR(tz);
> >                 pr_err("Failed to register thermal zone %pOFn: %d\n", n=
p, ret);
> > -               goto out_kfree_tzp;
> > +               goto out_kfree_trips;
> >         }
> >
> >         ret =3D thermal_zone_device_enable(tz);
> > @@ -540,8 +547,6 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
> >
> >         return tz;
> >
> > -out_kfree_tzp:
> > -       kfree(tzp);
> >  out_kfree_trips:
> >         kfree(trips);
> >  out_kfree_of_ops:
> > --
> > 2.41.0
> > =20


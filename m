Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E846352A70
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBL7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 07:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBL7q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 07:59:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2B1C0613E6;
        Fri,  2 Apr 2021 04:59:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id ADEFD1F4689B
Received: by earth.universe (Postfix, from userid 1000)
        id A05BE3C0C96; Fri,  2 Apr 2021 13:59:42 +0200 (CEST)
Date:   Fri, 2 Apr 2021 13:59:42 +0200
From:   "sre@kernel.org" <sebastian.reichel@collabora.com>
To:     "haojian.zhuang@linaro.org" <haojian.zhuang@linaro.org>
Cc:     Hao Fang <fanghao11@huawei.com>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] power: reset: hisi-reboot: use the correct HiSilicon
 copyright
Message-ID: <20210402115942.k5ozopz2z255dlgw@earth.universe>
References: <1617086285-36565-1-git-send-email-fanghao11@huawei.com>
 <PH0PR06MB7560EB9D65A4CF06F6F5C0A3977D9@PH0PR06MB7560.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nazkmwuyh7yakdtk"
Content-Disposition: inline
In-Reply-To: <PH0PR06MB7560EB9D65A4CF06F6F5C0A3977D9@PH0PR06MB7560.namprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nazkmwuyh7yakdtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 30, 2021 at 08:40:48AM +0000, Haojian Zhuang wrote:
> On 3/30/21 2:38 PM, Hao Fang wrote:
> > s/Hisilicon/HiSilicon/g.
> > It should use capital S, according to
> > https://www.hisilicon.com/en/terms-of-use.
> >=20
> > Signed-off-by: Hao Fang <fanghao11@huawei.com>
> > ---
> >   drivers/power/reset/hisi-reboot.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hi=
si-reboot.c
> > index 0ba5fdc..5abc5f6 100644
> > --- a/drivers/power/reset/hisi-reboot.c
> > +++ b/drivers/power/reset/hisi-reboot.c
> > @@ -1,8 +1,8 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> > - * Hisilicon SoC reset code
> > + * HiSilicon SoC reset code
> >    *
> > - * Copyright (c) 2014 Hisilicon Ltd.
> > + * Copyright (c) 2014 HiSilicon Ltd.
> >    * Copyright (c) 2014 Linaro Ltd.
> >    *
> >    * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> >=20
>=20
> Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Thanks, queued.

-- Sebastian

--nazkmwuyh7yakdtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBnBy4ACgkQ2O7X88g7
+pp7Mg//VR9uPXrmIK3u5qeih0Ryt45hbfRSzC3sAZp8dF/hHkunCdZDmZ5SAsIr
PIeDWBzHVoe4AUBgqtJVLjyeJ75dmvhuyYv4vekz1vfCpjgCIc5RdnnlEChKhc4B
mLs4CoHorCM23ueofWksf2IR3g4E1a0PKoJVUDZv1U+CPFjH9g6jQP+Wo2wlas6/
58yXpgApBGYxrBEosgPys7cluKfC7wd8Zw17bwX+96c+Xb129Qdu2qaukxu++rTI
CfGd3bpvosdQlszSxU33jz+hh5LiMOrLO/EKWR14zRKT4ZbpZQGueYIzVxfxiXhk
6MKUvfwKr6RChvQn4Qe8b1yqbeiVRjQDkv2UFpZUTcLWU0JxL18yXrggr2DuGIkd
mKsuWZd09JE1uhBGXFIQCoC3SOQQsWZiLxAE3vHfL96CuABd5m8Xyogst+7RQbx5
+exx/V1Zul/YlpVd7cizmmLH7Dd04ZbZasPyXbObUck5qJuWUUk64lgeoUZEuDAH
L5PgYaYU8NGZZSxvn5bOtBvJLOB0ea+MVbHf+OO1yZwi9d1EQK4760rLhNTY+REe
6BBn9xrSq8VAEAMYSiYUQmjIOITt2bDYP2FfUHbCRQHpOSz7ETylhBQ3u2PpGINh
7Dau+zICAUMDAxvF3rUs5BrLxFR00MJBLgeMOZ0Jcf9AgPwgwcc=
=o88j
-----END PGP SIGNATURE-----

--nazkmwuyh7yakdtk--

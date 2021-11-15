Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB345081F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhKOPWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 10:22:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhKOPW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 10:22:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 62E941F44DC2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636989566; bh=/f2D4HEYv9ATPphu5W7lru65izbE6fXRJV2MzcFSrGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7MwLAj5HzPRZ7/NPxCQQL0opmIL83Zz0JB7s02d7oIvoNg5mYod8RwkBtO+zIvSb
         8upZ7wXL2y2QedDQ/p7qcliCOKkZfl0IjVwy0oUBJKiBOD/jgrRZhVSsfuqIvWaLnO
         mHeztcRcs2kjJvVxhgaEFlgczXwYptJydD1kmNiTYXa9mM0pN/f3+mn1uBsO3C0gBy
         IUc81dLn4UvUupxjFKYNnBDsWkPTBpBWObYdHtGDkHdub7RZ3VbBFhLB95TpxqTRnD
         xZf3LRKxxmK/H9wV7d4BuzE1X6F+OtDen0q8cJAt6y4IuYfghjDiM9amKPzdxgvWGj
         mTDWKXj72cu1w==
Received: by earth.universe (Postfix, from userid 1000)
        id 8D6033C0F95; Mon, 15 Nov 2021 16:19:23 +0100 (CET)
Date:   Mon, 15 Nov 2021 16:19:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] power: supply: core: Break capacity loop
Message-ID: <20211115151923.tihkbpqhfd4fknuw@earth.universe>
References: <20211114231207.1877495-1-linus.walleij@linaro.org>
 <cd74a6c0-b9c9-c174-dc14-29ea30c64bcc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7d6qlckwfipe4lyq"
Content-Disposition: inline
In-Reply-To: <cd74a6c0-b9c9-c174-dc14-29ea30c64bcc@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7d6qlckwfipe4lyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 15, 2021 at 06:24:49PM +0800, Baolin Wang wrote:
>=20
>=20
> On 2021/11/15 7:12, Linus Walleij wrote:
> > We should not go on looking for more capacity tables after
> > we realize we have looked at the last one in
> > power_supply_find_ocv2cap_table().
> >=20
> > Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the =
battery OCV capacity table")
> > Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> LGTM.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks, queued to fixes branch.

-- Sebastian

> > ---
> >   drivers/power/supply/power_supply_core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index 038e35ea7fbe..885c92dc0379 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -852,6 +852,10 @@ power_supply_find_ocv2cap_table(struct power_suppl=
y_battery_info *info,
> >   		return NULL;
> >   	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
> > +		/* Out of capacity tables */
> > +		if (!info->ocv_table[i])
> > +			break;
> > +
> >   		temp_diff =3D abs(info->ocv_temp[i] - temp);
> >   		if (temp_diff < best_temp_diff) {
> >=20

--7d6qlckwfipe4lyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGSelwACgkQ2O7X88g7
+poZmhAAgDVTgpp88Spda7DuJxyVHgoQ1XeP4WzXIEdPVj290BjFBb+bfh57IZX5
RK9LxdDkhyKwhPWc5afrUgcYmqGkPkdzrDRbq4IjEylHCMHxoPLqtx/f20HMONvD
IGb9ksmoVuGEzRsnTWIrmHoxEWhACMDghsvj+FXr7Qr0pIKbM8alVPH8ZBH41GnT
C0+j52HU9XfpZNmawGbMtPJhc7QVXQnueqnKU5NtT7DMcwQ9vpg+JmKG5/bQLIoG
crEpPENfaPc7v9+n/T/M8+Ytlx2LXrFBcbiaUGAYYKayUsnm6e92KrF68Ec9aeo6
a51WffHUFYPuOeuQgeq5VCvcxTmm/wwvCj61Od+/N2InBqBoYdIBt2w8YlA/dsSj
7ZtqcBUCpt5peG22GLNMr5RwEd++F8F8baCUyrnj/kN7EHpH2iE4YyBz5hpnkQSP
7k8zTa5JmByE4wkJQwf0FLRiTlaxZNrbsB5qtdRWE3hf+2wQpjb7iajFrvxf1zLl
ovaXnkaCje2h+K6tEfaMiAql0MkfHy5vgwCcXZoCl6OpFyg3mqdq6ey4jfIrdxYC
f3Ij2LZyjyF/2n0vMejRSf8VzmTfZFyP4qT+EGoC+puBUMu86MjaC90NHqf6QpGM
T5cEaLprMyBG++Re3MdesmeFbjaIX3CucbFRqtJoxf7J9aGwVWQ=
=za7j
-----END PGP SIGNATURE-----

--7d6qlckwfipe4lyq--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE885188B2
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiECPjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiECPjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 11:39:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBCA2F003
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 08:36:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 848A71F41B99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651592176;
        bh=w3cS65ZizrFaW4k7vC+5vxb8mq4GjZKCd7iqLVvr9jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW3LAKlzvRlhVQH47DnJE2dBl0LJwHqYJp9D+O+9Sw590GNRUIGCQryFF45Qsh1JI
         bVfJ8udb7gMnRGHBc4rawD61GD6o9kpzomX1Njc+oQE0MwoLKFuIq6yNS8QLrreABc
         sFGNmCgaqXh5xhOdzsxteJ9UblU9KtSEirfx0nO/h2Q+mI99pfugbz+bk2z4RH5p1W
         RTKj08iuqhmS+32gXPFQ4CH94MogOAkcKBuffdiDDF9pql3nIF9qW2fvFty6wcsBaI
         7HeiF4dsx7+rWeLs2OWZf7+/Hff8Qz9OSMtE/hcCkHm30/By1JwpG40DTucF3KK1i1
         RxW/tg0uxafcw==
Received: by mercury (Postfix, from userid 1000)
        id 615621060430; Tue,  3 May 2022 17:36:14 +0200 (CEST)
Date:   Tue, 3 May 2022 17:36:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] power: supply: core: Initialize struct to zero
Message-ID: <20220503153614.nkdvkaotkgliqq5a@mercury.elektranox.org>
References: <20220424221301.1274428-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c43atqz36uacimn3"
Content-Disposition: inline
In-Reply-To: <20220424221301.1274428-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c43atqz36uacimn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 25, 2022 at 12:13:01AM +0200, Linus Walleij wrote:
> As we rely on pointers in the battery info to be zero-initialized
> such as in the helper function power_supply_supports_vbat2ri()
> we certainly need to allocate the struct power_supply_battery_info
> with kzalloc() as well. Else this happens:
>=20
> Unable to handle kernel paging request at virtual address 00280000
> (...)
> PC is at power_supply_vbat2ri+0x50/0x12c
> LR is at ab8500_fg_battery_resistance+0x34/0x108
>=20
> Fixes: e9e7d165b4b0 ("power: supply: Support VBAT-to-Ri lookup tables")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued to fixes branch.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index d925cb137e12..fad5890c899e 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -616,7 +616,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		goto out_put_node;
>  	}
> =20
> -	info =3D devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> +	info =3D devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		err =3D -ENOMEM;
>  		goto out_put_node;
> --=20
> 2.35.1
>=20

--c43atqz36uacimn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJxS+4ACgkQ2O7X88g7
+pqo+g//Z9LGgfDWMGWFX1KiX3MLlD3OG0bJI+ifSbJscNMue6wbvlbDnTHAoXzb
0HG/T6LwWioScyEEYnlikhvhOG55pDPEhihaugwjwh7HQ0HRTF+9dgKylXu7izjy
W03deTQ36fhSK02nt0bxbBvohHV8uR/nk7uxSJEnk3YQZ/ec/tmyZJmQrky4/+jR
jSp4cyg346BYKC8hMJHDy9hZbBEKXW25/3MEI+RZuQDGhNwS2D8BT09SAklKLgg5
j27kGxMTJODrSpH20/VvXbue5RskV3bFmGcnk7lZwKzjIRgXWHfyMvNEbcVn6g1L
ibqyciFc7zbEmWDMyPO0v3v4SPfQO0aHDnleuSyxcxXxlOFVZrv/UxOr34Edc09b
X6zttwMY17nVHRbc7Z7S1cfuMgQFsptU+/LrqU9O7v7Qo+pxP/MIxR4aQzS0q9Ab
5Qe7pyMrCO7IWZeov0+vFFXr2mel5odxydgKo5YrXRmxTxVGaR37kZQc3N6e1X1t
1iZjQPtl8mwJUZtZBdlnv6gcH/0WQ2hr/66KU7Dy8cg467qLyFvxAWNGO3eKCkDy
YaJq9RVEaw3nyJZK1MRJpvRGG1kc5MDlFrDbXAKY7CdDZViLbV1XFnZI3O2EIjzZ
HIK870mVbuNDlNbvlCBjcW8YdS6Hsoar4dj+FzbiwjAXyYnF8tQ=
=bLhh
-----END PGP SIGNATURE-----

--c43atqz36uacimn3--

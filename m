Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038415188CA
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiECPli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 11:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiECPlh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 11:41:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6CD3121B
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 08:38:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6C0961F44292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651592284;
        bh=WK4RXhbfgiXGDCrMoiApRr5NXlrOL2Vwx5XNtSs2H9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdqBChyU+qVZ1LzRhK8CfGMbP5NOwDwbyVKTHDfmZBpQToYlu1F0eEHAyu2wqnoM3
         c1sVBt6DdPSDGi2gx04G7FyYeSaHYHvp5WLF35hk1IrmcebGilimW4INPj0AdSwROI
         PKsWUDej2XVgrxMJUsGUBLRnu2sVGbU+1FCPPjSB+5GUX42uqfQLPTpgUQvYExfZN6
         JdQQxQMaX/thDiJvuSsMSE3Sm4Bri1iVwKIqH4xkJECxNJl2UiAboCAcmJWa/QCqQ+
         j6dpPM7ngcARBWKhuew0TJtOxjWjuvwVFN/2gDj9kDWZ6WH/xx2nxQQAfsN6ZAsLgt
         jQDoP13T+y5pg==
Received: by mercury (Postfix, from userid 1000)
        id 1F2C31060430; Tue,  3 May 2022 17:38:02 +0200 (CEST)
Date:   Tue, 3 May 2022 17:38:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500_fg: Allocate wq in probe
Message-ID: <20220503153802.npku5wbnw76snphd@mercury.elektranox.org>
References: <20220423172727.1197901-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzhcebuhuto7bc7l"
Content-Disposition: inline
In-Reply-To: <20220423172727.1197901-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wzhcebuhuto7bc7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 23, 2022 at 07:27:27PM +0200, Linus Walleij wrote:
> The workqueue is allocated in bind() but all interrupts are
> registered in probe().
>=20
> Some interrupts put work on the workqueue, which can have
> bad side effects.
>=20
> Allocate the workqueue in probe() instead, destroy it in
> .remove() and make unbind() simply flush the workqueue.
>=20
> Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized bindin=
g")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued to fixes branch.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 97ac588a9e9c..ec8a404d71b4 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -3037,13 +3037,6 @@ static int ab8500_fg_bind(struct device *dev, stru=
ct device *master,
>  {
>  	struct ab8500_fg *di =3D dev_get_drvdata(dev);
> =20
> -	/* Create a work queue for running the FG algorithm */
> -	di->fg_wq =3D alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
> -	if (di->fg_wq =3D=3D NULL) {
> -		dev_err(dev, "failed to create work queue\n");
> -		return -ENOMEM;
> -	}
> -
>  	di->bat_cap.max_mah_design =3D di->bm->bi->charge_full_design_uah;
>  	di->bat_cap.max_mah =3D di->bat_cap.max_mah_design;
>  	di->vbat_nom_uv =3D di->bm->bi->voltage_max_design_uv;
> @@ -3067,8 +3060,7 @@ static void ab8500_fg_unbind(struct device *dev, st=
ruct device *master,
>  	if (ret)
>  		dev_err(dev, "failed to disable coulomb counter\n");
> =20
> -	destroy_workqueue(di->fg_wq);
> -	flush_scheduled_work();
> +	flush_workqueue(di->fg_wq);
>  }
> =20
>  static const struct component_ops ab8500_fg_component_ops =3D {
> @@ -3117,6 +3109,13 @@ static int ab8500_fg_probe(struct platform_device =
*pdev)
>  	ab8500_fg_charge_state_to(di, AB8500_FG_CHARGE_INIT);
>  	ab8500_fg_discharge_state_to(di, AB8500_FG_DISCHARGE_INIT);
> =20
> +	/* Create a work queue for running the FG algorithm */
> +	di->fg_wq =3D alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
> +	if (di->fg_wq =3D=3D NULL) {
> +		dev_err(dev, "failed to create work queue\n");
> +		return -ENOMEM;
> +	}
> +
>  	/* Init work for running the fg algorithm instantly */
>  	INIT_WORK(&di->fg_work, ab8500_fg_instant_work);
> =20
> @@ -3227,6 +3226,8 @@ static int ab8500_fg_remove(struct platform_device =
*pdev)
>  {
>  	struct ab8500_fg *di =3D platform_get_drvdata(pdev);
> =20
> +	destroy_workqueue(di->fg_wq);
> +	flush_scheduled_work();
>  	component_del(&pdev->dev, &ab8500_fg_component_ops);
>  	list_del(&di->node);
>  	ab8500_fg_sysfs_exit(di);
> --=20
> 2.35.1
>=20

--wzhcebuhuto7bc7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJxTFkACgkQ2O7X88g7
+ppncxAAoBgVbKPRR1kKaAglxBBlDEStH+qhbVOxA4Kt9e/oFXjJwZ4WIDlSjlAl
vtz0VKiub34T7MsHfSSrckLJRsKogMEJpyXSzUpGBAFF4VSKKuq6mkN8AE4Iq0F6
H5qF3Pk2dVj2JhXx/redxgeonKW3AgqLIkVPH6qHeruxIou961RjewmfUXmMzHam
UhiTvJjAUFHAufPvT1OwXOTGGsprpNOqiA1T3U9ZEESDHylymI5JnO982qB2UEEq
OCP51czfTCIdWYB9aVqH4t6zA0O2FL8MIq7M0349qj2dzQgaFjMy7UAR8q7cfeeX
g6WDgqezuL0hg7A5V+XzdQxWrVp0Y+1WovXDQs/dAktlBQk99qePGq7AUe2Z5cXM
mGl49KUM8OwC12gvl7J6Dh8rp5wiOZEWjAgJLZDQyugCXb//TclM6hHUUde4DG6H
+I0UGbghgZKHFCm0lB8x50PsUE/xceQOFZbsKaD2IR5kJHFQuyp7yBeafyIkF7L4
XzmXgJuaTTz/eRbjBAFo6hDed726isBPKBniZZ26xBPsZ2LuNfaQgy1ucACerVcC
P4NxmXEwK12fi0CCb9eXVkw5OEr9Vi8/r+QRZK4YIzhCaBd6KQAkcJr00eR4MC+O
KRUh4E2Kc1S+M0jPXwQA1Zfg1PCypWocKH21nOxmnAeFHp9O+WE=
=/3ut
-----END PGP SIGNATURE-----

--wzhcebuhuto7bc7l--

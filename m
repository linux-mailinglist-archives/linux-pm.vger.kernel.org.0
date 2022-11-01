Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91C61420D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 01:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKAADq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 20:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKAADq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 20:03:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEC11A1A;
        Mon, 31 Oct 2022 17:03:45 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE7C866015AC;
        Tue,  1 Nov 2022 00:03:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667261023;
        bh=37ErT0h2h0SuIZaMCtim7Kcx0J0B//trhYk2GN2DI2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMvNzaa84KYjKMa5uOmFKGTESYSnrLav7kXzh+FBivYXcvAX3hNez+O1Ki4JHvIoM
         OeeDKok4GXt9YHnKoXQUZ50Y+qfbTYPFU9iFXYF+7yHdoSnNuN6VpO1JwX8GQfP4Gu
         9txzJLe5VTyO2p6xUfGaC3f13C2+9v9Z7ErGG6DNBGu6GZZbUOgNEfKWwCmh3xprPt
         1+axOrw4DM1yaAtZ1j0+A3LX1ATA1EMnRNOF0rj/tO/76vV0BuuSpDbgFvfzHUS8Bk
         jOL8gTuFLEaUZ370mTRgmOAYIpxCjl3NCucWpHgl0/yBXQqXLmROe3FZMxqbH4guwg
         y+PF3JNZjfA5A==
Received: by mercury (Postfix, from userid 1000)
        id 6F7421061C6F; Tue,  1 Nov 2022 01:03:40 +0100 (CET)
Date:   Tue, 1 Nov 2022 01:03:40 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Defer thermal zone probe
Message-ID: <20221101000340.4xqwl4z35malkk7j@mercury.elektranox.org>
References: <20221030205554.335633-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocxd3sz2to4chxhu"
Content-Disposition: inline
In-Reply-To: <20221030205554.335633-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ocxd3sz2to4chxhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 30, 2022 at 09:55:54PM +0100, Linus Walleij wrote:
> The call thermal_zone_get_zone_by_name() used to return the
> thermal zone right away, but recent refactorings in the
> thermal core has changed this so the thermal zone used by
> the battery is probed later, and the call returns -ENODEV.
>=20
> This was always quite fragile. If we get -ENODEV, then
> return a -EPROBE_DEFER and try again later.
>=20
> Cc: phone-devel@vger.kernel.org
> Fixes: 2b0e7ac0841b ("power: supply: ab8500: Integrate thermal zone")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued to fixes branch.

-- Sebastian

>  drivers/power/supply/ab8500_btemp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index 863fabe05bdc..307ee6f71042 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -725,7 +725,14 @@ static int ab8500_btemp_probe(struct platform_device=
 *pdev)
>  	/* Get thermal zone and ADC */
>  	di->tz =3D thermal_zone_get_zone_by_name("battery-thermal");
>  	if (IS_ERR(di->tz)) {
> -		return dev_err_probe(dev, PTR_ERR(di->tz),
> +		ret =3D PTR_ERR(di->tz);
> +		/*
> +		 * This usually just means we are probing before the thermal
> +		 * zone, so just defer.
> +		 */
> +		if (ret =3D=3D -ENODEV)
> +			ret =3D -EPROBE_DEFER;
> +		return dev_err_probe(dev, ret,
>  				     "failed to get battery thermal zone\n");
>  	}
>  	di->bat_ctrl =3D devm_iio_channel_get(dev, "bat_ctrl");
> --=20
> 2.37.3
>=20

--ocxd3sz2to4chxhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgYlkACgkQ2O7X88g7
+prDew//ZU5owY596un1UTozEbgldnMDgU4jKRKQ2HEbjY7ZduPpmuQe886k8iwf
Dn7ce7tnMSAxnSch9/tsPcOLsC40QIAbfedqlQSxpQNYXoVZyIH1DDVypNbtMv9P
7a5QXLYG+TEDM/91LTifoSl1AUKl9N79eosYaw7dV1mokeAPo9I+6EEOS9gnZrik
upEtJPOZphJ8XUMrZqkgxI/Rt95m0IC89Xwi/HPubaS395OPOxMMk8G/7M+SyLxN
h7loMrgurCVVH6vqXGKqv+VrpdzqEMri8i3/XgquDoUvz1j4ktaDGWfXd3Ct0R+r
slLZlm8rUTtWuW1XziW84vy5XoGd6ItH+JzJ1w+/5ETWqAaHRUUcoNNaUalWzRCI
dCet4iSvIi2EsndxZ2WIU8ePtPx0PDJuH3z1GG1B44l49yBm3kT551I/5yv05Ux9
5bxmN6gDm1zcHmSCFsoenXZCF5JnZVd5sKdIqj/jefMXOKDrpnHn6JTpnZgYD0gj
k6gjlMV/D8djL08cOsnGTomM2LRKKVGDbWx8RK0qYVpfztdom/yvMP02db5EHWYI
HhhcSub6+O6L6dQfTCvVXHDQWurfyUVpjAyWUZk+nlYGabWz2yZVaSgq3XsngMHp
zotdvHQp4wO1d0Q65Rb72aNFWzRuyH+CEV1ScvP/On/YSplJ8U4=
=eb7Z
-----END PGP SIGNATURE-----

--ocxd3sz2to4chxhu--

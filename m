Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E9605428
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 01:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJSXni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJSXnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 19:43:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B215383D;
        Wed, 19 Oct 2022 16:43:35 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 731726602377;
        Thu, 20 Oct 2022 00:43:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666223013;
        bh=HCQRIYIvaofyh8jKLFiJ7du6EQaW1+ZfM512iugncYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsXpEqKb3F6Pv7nJvstkXQZSVMUsQcTqIOe8HTdt0r48PA6T00tAngmhz6cPwWCYA
         64sAtfaXp0+AlD4GOwmSVV4sIHZQzZJKmnot3pYmq+0fanJgu/4yaXy22+KZW4za3u
         by7VFLwhRuB/6MXMPOmG74JuZwLQa3uuvkwqsRf0cPl41LL7zqcIJsAL94MpnEzI6H
         jUQkJ71MakP/gkW5o5rcZvBvWRzITq2aT8zrMmxpNAI+K7UlwnLTTUX1BB2bflC7+n
         g2fH7LzjffdEXWYblnWsfW3Z4xhuBaQk0P/7NaqvYtj+uo+HE8m39JKqIbVj/rOwo1
         JXbqFmS3dxZZA==
Received: by mercury (Postfix, from userid 1000)
        id F423B10607E3; Thu, 20 Oct 2022 01:43:30 +0200 (CEST)
Date:   Thu, 20 Oct 2022 01:43:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Morgan <macromorgan@hotmail.com>, Lee Jones <lee@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: rk817: check correct variable
Message-ID: <20221019234330.q537ytycvfredbzz@mercury.elektranox.org>
References: <Y0puvQLWS/rQ7hSb@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndm23mwvjfn32yfp"
Content-Disposition: inline
In-Reply-To: <Y0puvQLWS/rQ7hSb@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ndm23mwvjfn32yfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 15, 2022 at 11:26:37AM +0300, Dan Carpenter wrote:
> This code checks "->chg_ps" twice when it was supposed to check
> "->bat_ps".
>=20
> Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK81=
7")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks, queued to fixes branch.

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 635f051b0821..4e9c7b191266 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1116,14 +1116,12 @@ static int rk817_charger_probe(struct platform_de=
vice *pdev)
> =20
>  	charger->bat_ps =3D devm_power_supply_register(&pdev->dev,
>  						     &rk817_bat_desc, &pscfg);
> -
> -	charger->chg_ps =3D devm_power_supply_register(&pdev->dev,
> -						     &rk817_chg_desc, &pscfg);
> -
> -	if (IS_ERR(charger->chg_ps))
> +	if (IS_ERR(charger->bat_ps))
>  		return dev_err_probe(dev, -EINVAL,
>  				     "Battery failed to probe\n");
> =20
> +	charger->chg_ps =3D devm_power_supply_register(&pdev->dev,
> +						     &rk817_chg_desc, &pscfg);
>  	if (IS_ERR(charger->chg_ps))
>  		return dev_err_probe(dev, -EINVAL,
>  				     "Charger failed to probe\n");
> --=20
> 2.35.1
>=20

--ndm23mwvjfn32yfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNQi58ACgkQ2O7X88g7
+pqIDA/8Cufa9EL2N7PN83seMnZcc41WReqJXV2eZ3mEr8dhvRpbHms3jO9ME9xu
UzIY6oBhUpYaSIFAvH5uooGZn9cuXCQDdxdpiHtm2rRdO/w/yABigeS6/JeuubIj
u2tNyZzqByaTEQmL0LLZLrrICPJyW9baMCu0yTTwabtqE5pGvnRqoxMjuL/0HtZ9
LG7fLINu4rznnTR/4CvLMdHgLBNmJOUldbrT2TCNbG5NsH5RT3Oue076Tq7nmBkC
CJpb8oqJS9Nx2mJsi9qkoQScTQjt+UjIYHmp/JTQMjBQ5rnXuujeGJ9R4DItYUb9
c/fKi7TtmpppRtRYVjHSHpuuyc+TuUrnS2OUfYA+UWIVdXfgO0QDjEQa6Qmnbv/Z
lTpMQVAw0jhwLBtao0avqt2lT2SwsE/ZsD6I/FIMFcKFT+TL0JVChy2r//eY+rBC
AS60pINCLyR/948tnExf5R0oo49yBCynhYMJEG6LmxPYUlRx24cJ/IA3kUWGKzzV
6T7yooZIVpDdZAI8mnIJUyf0qeS89+HYaEGMWxomHIz9ZyPeYXXJhPQ2z6QVw4AN
qv4C9B1c6mQLrSK7xpOgTM9VzWXgmP+xNWUPVHf8wi9Syu1odxujAdr5oYU4OLPY
CaAChcTzS5JgAQilOuIpr3BHfi/Go9jd8+2V/IJeFbMTdylpZ2I=
=Te2v
-----END PGP SIGNATURE-----

--ndm23mwvjfn32yfp--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1F63988D
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 23:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiKZW5w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 17:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKZW5i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 17:57:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF78205
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 14:57:27 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 89C086602AC0;
        Sat, 26 Nov 2022 22:57:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669503445;
        bh=a9HiDFC1KypzeB3IeEHIUBAMBW/Xchd9PwProoeABBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoKKBunLvxTQJyuNaZdCZnnrz1IYq0v3TWVW3zUDsRsBYb8OyUK/6IyVx275D1qKx
         iMn+f1Ceb0fQ4ttAuJxVmaVWC8/cdeEu2DK1wf1K3M1dFoGBU91IFUimfKErQ3hox8
         hu6ivTbLo7NgzL3A6GSRtjchnXEagUhZ4k0FVMxVNFeGuPqm+A1Q4E7Xxn/GfkBD68
         zTrEsY9SYWYZw9WWOnYxcSVuk0pxsuZ3NMykjdA5/H5FMQBvBgC3Fl4qeb1B5OWpx4
         KT0d9ELBppJOiujXxKsRyzO6/objOm5nHtfTwbVi5ZxmJ2BV9I4sF9P4D+1PWO+H5T
         xAnrlfhULIoBw==
Received: by mercury (Postfix, from userid 1000)
        id 45A75106133F; Sat, 26 Nov 2022 23:57:23 +0100 (CET)
Date:   Sat, 26 Nov 2022 23:57:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     linus.walleij@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Fix error handling in
 ab8500_charger_init()
Message-ID: <20221126225723.3eghvrwr7gtpvcj2@mercury.elektranox.org>
References: <20221124031932.17032-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5j5mwqdwuoeqzcpw"
Content-Disposition: inline
In-Reply-To: <20221124031932.17032-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5j5mwqdwuoeqzcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 24, 2022 at 03:19:32AM +0000, Yuan Can wrote:
> The ab8500_charger_init() returns the platform_driver_register() directly
> without checking its return value, if platform_driver_register() failed,
> all ab8500_charger_component_drivers are not unregistered.
>=20
> Fix by unregister ab8500_charger_component_drivers when
> platform_driver_register() failed.
>=20
> Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized bindin=
g")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index c19c50442761..58757a5799f8 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3719,7 +3719,14 @@ static int __init ab8500_charger_init(void)
>  	if (ret)
>  		return ret;
> =20
> -	return platform_driver_register(&ab8500_charger_driver);
> +	ret =3D platform_driver_register(&ab8500_charger_driver);
> +	if (ret) {
> +		platform_unregister_drivers(ab8500_charger_component_drivers,
> +				ARRAY_SIZE(ab8500_charger_component_drivers));
> +		return ret;
> +	}
> +
> +	return 0;
>  }
> =20
>  static void __exit ab8500_charger_exit(void)
> --=20
> 2.17.1
>=20

--5j5mwqdwuoeqzcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOCmc8ACgkQ2O7X88g7
+prddQ//aWZOIDiZYhf2QD/haXJLlBzVpWZO3zuJzbKgOpEIxnlUWUSwt+1F6C2s
0XfA4GHJRxe03FhndREPCD2zOYicyRsv/5GSe4R2FjGi3zzyDIPF1g+TEt9tJ5Wq
KNA5ARYrY6TCrBPz0smpFZEweI+M7aktqzcizLkf4tgNrUFmU4/4kIzx1W8Eo0SR
nLi9k7ifHeboQaZwSFHUuR+AvVm2hy2hJWbBxU048oS3YPFcV7ahWtJT7VcVnyOR
anJGetniD4KYlzd6m0HwbzkzjMkwkxQKX/OIC9cuTuOD1LJ0bL9DYmSAvBqWSDEX
4+x6izhbFOoKh5orJMV15w7ck94LihFrvx6Vbx51At3xVd4gHR+C5Z1Hyw/0HxXS
7GJCED40mY94peP6E+Vj8a+QTJDMIA42dQrUIqWwrM3WLqMzQnBCpM308efMCQqy
nhoYVJnSvU4KhFEWC18aNWuNJpzH5VF+xTrI9wonIEoQrsU6mHhO7v226EJa74/D
WS+gl8GT08E0ku3BLoFqmsRupN5BU9BH39GOQs7ErzRF5cNpkZ2xOLglViyBeEeb
Ph9pPJkOmr9IRwsJSOGJ26/r3XRNwNhnmsz79atK1Td7gQByyTxq/KhPjA8DBUVx
0X/J8Eqx8+tqHjmZwvb/zjGBr1rFmSDrBojoG8mneYrKsvGKwZE=
=2jxR
-----END PGP SIGNATURE-----

--5j5mwqdwuoeqzcpw--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD856E6936
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 22:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfJ0VfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Oct 2019 17:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfJ0Ve7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Oct 2019 17:34:59 -0400
Received: from earth.universe (unknown [46.218.74.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91270205C9;
        Sun, 27 Oct 2019 21:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572212098;
        bh=RNWo0D53+Ntp+KRQWTyoCRiC9k2qRRWGq+MSH31Tp+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zDO/NDQeRNXDOSTjnzbTopEGwJHX6e2tM/JHpA2cK22ceN8lfqgCP9+J9K+nb7N3H
         DWf1h6Ze8xkvjiaYhrfc4nf68Z7qkz10voMFmyJQtpQNrvQJUbQzFNDjiSPqPzfWJ2
         WyJ9jatKVLxliYhBxA1zOiBSgd/O+sJOhHmYZtrw=
Received: by earth.universe (Postfix, from userid 1000)
        id 27A243C09B2; Sun, 27 Oct 2019 22:34:56 +0100 (CET)
Date:   Sun, 27 Oct 2019 22:34:56 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] power: supply: ab8500_charger: Fix wrong pointer
 passed to PTR_ERR()
Message-ID: <20191027213456.yexbg6kzgt7vl5fm@earth.universe>
References: <20191022111856.44118-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayrkqrrimiyumc6c"
Content-Disposition: inline
In-Reply-To: <20191022111856.44118-1-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ayrkqrrimiyumc6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2019 at 11:18:56AM +0000, Wei Yongjun wrote:
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
>=20
> Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Thanks for the patch. Gustavo A. R. Silva send an identical patch
one day earlier, so I applied his patch and added an Reviewed-by
=66rom you.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index ff2bb4411a22..8a0f9d769690 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3393,7 +3393,7 @@ static int ab8500_charger_probe(struct platform_dev=
ice *pdev)
>  		if (PTR_ERR(di->adc_main_charger_c) =3D=3D -ENODEV)
>  			return -EPROBE_DEFER;
>  		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
> -		return PTR_ERR(di->adc_main_charger_v);
> +		return PTR_ERR(di->adc_main_charger_c);
>  	}
>  	di->adc_vbus_v =3D devm_iio_channel_get(&pdev->dev, "vbus_v");
>  	if (IS_ERR(di->adc_vbus_v)) {
>=20
>=20
>=20

--ayrkqrrimiyumc6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl22DX8ACgkQ2O7X88g7
+pq3AA//XlhQ9Z3XbxQL2ENPtxj3Z9vncXBd8iNpcPAupduu4bIVpeAQosMIz7i9
1BmohV6r5Sp9tw5R0h4wN5GjZ3GCQlky9ok1XdV0P/Y3OvyKcnZVR6EIRbK+3zrn
meSAlWvZgr8VSoXyDSKPI5s0bJmRXV8q2sGQ2pRZwHNcazTF4d43wKgEEt162CD5
YSvS1KqRBPNA7RGE9/cupoaPzkUIG18wWvrRFQKAz3iAOyZW2j+t6KPRs7pJ4HY+
Th0+9WW2PPt97XzGJR4Ys51M41nVJK71lgf2V5Ip2PNVVSVKhbxWkp/IVK1HeeZI
hgjvVHqN/r132gLl3RdEeWqCIulM4349flTeR4hVLzIo2oAF+qOAb9+xMQqOwsDs
xqyDqt656efjpPy66FNM1LbJSf35I0snX5Ca4z6xIIXmRDe+sn7WgP7hULAulYty
SOCdmyAWJEpV8CcOQQizUldjn4vAVM7vfdaOrqRitP8dDRVJvFGGdF2AIDwWHTTQ
xRWd0I8t2JJn9Wyvphr15UiVzh1AdcoboSPsD27GXq8cmmnE9qegYVLsMa5T9rfl
YaroIPHc+vFYFnSwYLxaKAhWYVB4PDIeR6/aGixC9qexfMHKNuz+LLpeVbvoEvpS
IrfO/S+9H1cxY/szm+JSNudSx+bBa4wVFq9AKO3Vwp9AH7M0yYY=
=Rqe6
-----END PGP SIGNATURE-----

--ayrkqrrimiyumc6c--

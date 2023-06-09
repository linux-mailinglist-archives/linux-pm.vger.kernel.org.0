Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2972A308
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFITX6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFITX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 15:23:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C91F2D7C;
        Fri,  9 Jun 2023 12:23:56 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3FD816606F38;
        Fri,  9 Jun 2023 20:23:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686338635;
        bh=uNTdM2/xyHQurNyBydk0D8bRTklQBpCB7QRkvhxIhZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6uBwzc2Tw6hkIJ2ucux0Wfi6fySWCgVQMs0d9KqWIazDq+ejYD3IFNU0lYhFBM8x
         9blGkuwanOn/RYGeYgfC1sBORK8vBJR4d4jiHpLBErBuExnE7qTIU9TL3BmwK7iJRn
         v6X6hIIaQM1yqspOdlcRdtRqV1caHaSot3DrnSCszeeXSX8H1ILYl04k3sIw2mIATc
         +J39ouBEFuy5YCjr/UyTujJtf0yyyb1RwFlJeubLJtteBOnYnsMlRx3/pINAxtFpAW
         77hX3Qs0FZCK3iR7x6AzXC4NmRrNgMfNO1lMpRXKcrNyGdAfv46cqfHkORE/qlb5G2
         LQpjfOhUsWhiA==
Received: by mercury (Postfix, from userid 1000)
        id 7BF3B106118A; Fri,  9 Jun 2023 21:23:52 +0200 (CEST)
Date:   Fri, 9 Jun 2023 21:23:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power: reset: qcom-pon: add support for pm8941-pon
Message-ID: <20230609192352.h4e5zxwuhoaq77lc@mercury.elektranox.org>
References: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
 <20230609022553.1775844-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjht7i27hto4iruo"
Content-Disposition: inline
In-Reply-To: <20230609022553.1775844-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rjht7i27hto4iruo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 09, 2023 at 05:25:51AM +0300, Dmitry Baryshkov wrote:
> For PM8941 we don't have a defined field to store the reset reason.
> Support wrapping pwrkey and resin, but without writing the reset
> reason.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/qcom-pon.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index ebdcfb28c4a0..1344b361a475 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -17,6 +17,8 @@
>  #define GEN1_REASON_SHIFT		2
>  #define GEN2_REASON_SHIFT		1
> =20
> +#define NO_REASON_SHIFT			0
> +
>  struct pm8916_pon {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -45,6 +47,7 @@ static int pm8916_reboot_mode_write(struct reboot_mode_=
driver *reboot,
>  static int pm8916_pon_probe(struct platform_device *pdev)
>  {
>  	struct pm8916_pon *pon;
> +	long reason_shift;
>  	int error;
> =20
>  	pon =3D devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
> @@ -64,13 +67,17 @@ static int pm8916_pon_probe(struct platform_device *p=
dev)
>  	if (error)
>  		return error;
> =20
> -	pon->reboot_mode.dev =3D &pdev->dev;
> -	pon->reason_shift =3D (long)of_device_get_match_data(&pdev->dev);
> -	pon->reboot_mode.write =3D pm8916_reboot_mode_write;
> -	error =3D devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
> -	if (error) {
> -		dev_err(&pdev->dev, "can't register reboot mode\n");
> -		return error;
> +	reason_shift =3D (long)of_device_get_match_data(&pdev->dev);
> +
> +	if (reason_shift !=3D NO_REASON_SHIFT) {
> +		pon->reboot_mode.dev =3D &pdev->dev;
> +		pon->reason_shift =3D reason_shift;
> +		pon->reboot_mode.write =3D pm8916_reboot_mode_write;
> +		error =3D devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
> +		if (error) {
> +			dev_err(&pdev->dev, "can't register reboot mode\n");
> +			return error;
> +		}
>  	}
> =20
>  	platform_set_drvdata(pdev, pon);
> @@ -80,6 +87,7 @@ static int pm8916_pon_probe(struct platform_device *pde=
v)
> =20
>  static const struct of_device_id pm8916_pon_id_table[] =3D {
>  	{ .compatible =3D "qcom,pm8916-pon", .data =3D (void *)GEN1_REASON_SHIF=
T },
> +	{ .compatible =3D "qcom,pm8941-pon", .data =3D (void *)NO_REASON_SHIFT =
},
>  	{ .compatible =3D "qcom,pms405-pon", .data =3D (void *)GEN1_REASON_SHIF=
T },
>  	{ .compatible =3D "qcom,pm8998-pon", .data =3D (void *)GEN2_REASON_SHIF=
T },
>  	{ .compatible =3D "qcom,pmk8350-pon", .data =3D (void *)GEN2_REASON_SHI=
FT },
> --=20
> 2.39.2
>=20

--rjht7i27hto4iruo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSDfEcACgkQ2O7X88g7
+prtKQ/+LbeZ/SUCga7U/ISplAr/bCuxuef8r3j1a8LLHc7nDtjjFvmJKdcmTEak
BdTn/zBDJPRPUzXE9qwdgjMusZhXstKQNJrV3k86Ev+jBBdg8fKqIupfnnw8Dmh8
izc8k0H2qL0VTNo9449CkHzZRv/RijVPmPcl2OL3VwCMR84mGWpigPH5ytOK1Rvs
PWj6Emj7MWDqTAZolQSI1b+K+fG3W2eCcLyMQg4xORfft2gdupl5dLtG5lQUjFyT
4M+H12PkJoF10TmF0CO4pJiFnQq8Mns0LFwOcxQGroBX5KFF0VUmEBvZh4sg1taM
z/3iis7pZBu18g00gFr4tiIPNqFajOXY+ad8ZOQWyxcMWF8fsxmMC03mJfITsk6z
QxBVvLTVl9SajjZ50MhXLTGpkwLHlaEfnoc7OoN8HZPSuHW3UrusgDbwWCTPyqkL
xULZ+JcRjRuRPCx2fO7CmE03B+QyGbCXip+0AVMI4rUwxgkyYhd5ldzTmcIp+v9s
rxWJKEHJw+EV15sN1etZVCNpPLKFBvFwvIUpjGXIHSWAurW3Cn4NS7lMq/8lt/gM
0WGakRKjG+CtuiP3IkQZstfzC1yI+lzVTc/eqZqE/+P0hmsA8wI/YXMkWbTXmnbK
MXHnXTxqvEft2NzEVaNw6DIU7XAvcwiaTRlnZFW4TfqD8eh5Z+U=
=at7v
-----END PGP SIGNATURE-----

--rjht7i27hto4iruo--

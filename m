Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A226DF866
	for <lists+linux-pm@lfdr.de>; Wed, 12 Apr 2023 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjDLO0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Apr 2023 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDLOZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2023 10:25:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E77D9E
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2023 07:25:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmbPw-0000LT-K0; Wed, 12 Apr 2023 16:25:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmbPu-00AlBg-Lj; Wed, 12 Apr 2023 16:25:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmbPt-00Ccps-S8; Wed, 12 Apr 2023 16:25:45 +0200
Date:   Wed, 12 Apr 2023 16:25:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] soc: ti: smartreflex: Simplify getting the opam_sr
 pointer
Message-ID: <20230412142539.brqexyi5kpac5ltr@pengutronix.de>
References: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vfl2cxbaesvfsytx"
Content-Disposition: inline
In-Reply-To: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vfl2cxbaesvfsytx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Cc +=3D Tony Lindgren + Arnd Bergmann who did care about the last change
to this driver]

On Wed, Oct 12, 2022 at 04:00:32PM +0200, Uwe Kleine-K=F6nig wrote:
> The probe function stores the sr_info pointer using
> platform_set_drvdata(). Use the corresponding platform_get_drvdata() to
> retrieve that pointer in the remove and shutdown functions.
>=20
> This simplifies these functions and makes error handling unnecessary.
> This is a good thing as at least for .remove() returning an error code
> doesn't have the desired effect.
>=20
> This is a preparation for making platform remove callbacks return void.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch still applies to v6.3-rc1, but I didn't get any feedback
since 6 months now. I need this change to eventually make
platform_driver's remove callback return void.

Best regards
Uwe

[Keeping a full quote below for Tony and Arnd]

> ---
>  drivers/soc/ti/smartreflex.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index ad2bb72e640c..1d0b50feae44 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -940,21 +940,8 @@ static int omap_sr_probe(struct platform_device *pde=
v)
> =20
>  static int omap_sr_remove(struct platform_device *pdev)
>  {
> -	struct omap_sr_data *pdata =3D pdev->dev.platform_data;
>  	struct device *dev =3D &pdev->dev;
> -	struct omap_sr *sr_info;
> -
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> -		return -EINVAL;
> -	}
> -
> -	sr_info =3D _sr_lookup(pdata->voltdm);
> -	if (IS_ERR(sr_info)) {
> -		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
> -			__func__);
> -		return PTR_ERR(sr_info);
> -	}
> +	struct omap_sr *sr_info =3D platform_get_drvdata(pdev);
> =20
>  	if (sr_info->autocomp_active)
>  		sr_stop_vddautocomp(sr_info);
> @@ -968,20 +955,7 @@ static int omap_sr_remove(struct platform_device *pd=
ev)
> =20
>  static void omap_sr_shutdown(struct platform_device *pdev)
>  {
> -	struct omap_sr_data *pdata =3D pdev->dev.platform_data;
> -	struct omap_sr *sr_info;
> -
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> -		return;
> -	}
> -
> -	sr_info =3D _sr_lookup(pdata->voltdm);
> -	if (IS_ERR(sr_info)) {
> -		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
> -			__func__);
> -		return;
> -	}
> +	struct omap_sr *sr_info =3D platform_get_drvdata(pdev);
> =20
>  	if (sr_info->autocomp_active)
>  		sr_stop_vddautocomp(sr_info);
>=20
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vfl2cxbaesvfsytx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ2v1gACgkQj4D7WH0S
/k5TQAf/UNMH3+qMpKZzWdWPfwp6zZIelAaKkIrdjHniPE1Y0KuQnwizXnqxM5iP
tU06LS60Vh/6X071yMA+Q8REZH4Sn/3LlgR8iIQOrQ1UzYJk2cZN+NooKHVjZrrS
sMkOja5H3l1NIewJ+QOIsdlUDavzm/zpkOyzUmMQZqSuUmoriP9D+VyvXf3BSGMW
jhr0vJSYwzeWhlNbaGZjHZvh0Aok75/bVBbgi9ceW6WM4aRzROubTgZ7sXuKf8FI
ajZEgtsW0SI/FAVsRPXsFGJ2BoDYL4SY0m7GbX4puNfzAdvn58rh8iET+e+fiiKI
6neKsCjvXMQf5DQj1beSH6op67tWCw==
=Q5gE
-----END PGP SIGNATURE-----

--vfl2cxbaesvfsytx--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C3545523
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiFITnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbiFITnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 15:43:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B521B140879
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 12:43:33 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BFA16601649;
        Thu,  9 Jun 2022 20:43:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654803812;
        bh=wIw5xQazzdcaQPeGB+78em2JNtJ1yCrvfA2NAQSVAtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPUC/aVMNJBh8SAFB+sG8occbX3ipub7wZcVPujdSivQqC53E1iTz7TlRYOLQGKFa
         kbpYEBDJK5ZX/SeuWx4q+wTxNwarsmkbZZKX+J7SaznYbfENFc1BK4GF/qrw5tQzvG
         yQsF1ZIrV7/nqCA7wPJ6Y+VWEB+QKR+JVucLry/ItmT4DfJ8PZm/P3CBAzDfxea5OI
         sRjYZmLcbK6zUZSw94I8pb6e8HQC9qIwzt/0wgp6O3UrbUkiMEhp6JasSBf9gIHXmF
         yDxvdiRiVaLkH74vk1RSyONzKQkUvWTq8xWaJZYhAEDTPzbcyKfzeugdBWuAyR6086
         jjR2zdwRgKjLg==
Received: by mercury (Postfix, from userid 1000)
        id 9E1A910605B9; Thu,  9 Jun 2022 21:43:29 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:43:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: ab8500: Remove flush_scheduled_work() call.
Message-ID: <20220609194329.bkvnxmxovnbqxuxg@mercury.elektranox.org>
References: <50d84193-a933-1301-b9d9-bf6cc01ee126@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itjyily7edmuzn6j"
Content-Disposition: inline
In-Reply-To: <50d84193-a933-1301-b9d9-bf6cc01ee126@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--itjyily7edmuzn6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 09, 2022 at 01:58:04PM +0900, Tetsuo Handa wrote:
> It seems to me that ab8500 driver is using dedicated workqueues and
> is not calling schedule{,_delayed}_work{,_on}(). Then, there will be
> no work to flush using flush_scheduled_work().
>=20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
> using a macro") for background.

Looks sensible to me. Adding Linus to Cc and waiting a bit so that
he has time to review/test.

@Linus I think it makes sense to add something like this to
MAINTAINERS or add the files to the "ARM/NOMADIK/Ux500 ARCHITECTURES"
entry, so that you will be CC'd.

AB8500 BATTERY AND CHARGER DRIVERS
M:	Linus Walleij <linus.walleij@linaro.org>
S:	Maintained
F:	Documentation/devicetree/bindings/power/supply/*ab8500*
F:	Documentation/devicetree/bindings/power/supply/*ab8500*

-- Sebastian

>  drivers/power/supply/ab8500_btemp.c    | 1 -
>  drivers/power/supply/ab8500_chargalg.c | 1 -
>  drivers/power/supply/ab8500_charger.c  | 2 --
>  drivers/power/supply/ab8500_fg.c       | 1 -
>  4 files changed, 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index b7e842dff567..863fabe05bdc 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -697,7 +697,6 @@ static void ab8500_btemp_unbind(struct device *dev, s=
truct device *master,
> =20
>  	/* Delete the work queue */
>  	destroy_workqueue(di->btemp_wq);
> -	flush_scheduled_work();
>  }
> =20
>  static const struct component_ops ab8500_btemp_component_ops =3D {
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index 431bbc352d1b..454acb1964fc 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -1746,7 +1746,6 @@ static void ab8500_chargalg_unbind(struct device *d=
ev, struct device *master,
> =20
>  	/* Delete the work queue */
>  	destroy_workqueue(di->chargalg_wq);
> -	flush_scheduled_work();
>  }
> =20
>  static const struct component_ops ab8500_chargalg_component_ops =3D {
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index d04d087caa50..0510e0ee4c60 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3404,8 +3404,6 @@ static void ab8500_charger_unbind(struct device *de=
v)
>  	/* Delete the work queue */
>  	destroy_workqueue(di->charger_wq);
> =20
> -	flush_scheduled_work();
> -
>  	/* Unbind fg, btemp, algorithm */
>  	component_unbind_all(dev, di);
>  }
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index ec8a404d71b4..e49f9b679b6c 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -3227,7 +3227,6 @@ static int ab8500_fg_remove(struct platform_device =
*pdev)
>  	struct ab8500_fg *di =3D platform_get_drvdata(pdev);
> =20
>  	destroy_workqueue(di->fg_wq);
> -	flush_scheduled_work();
>  	component_del(&pdev->dev, &ab8500_fg_component_ops);
>  	list_del(&di->node);
>  	ab8500_fg_sysfs_exit(di);
> --=20
> 2.18.4
>=20

--itjyily7edmuzn6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiTVwACgkQ2O7X88g7
+prl2g//Zj2OelZQrv13rCytY1wFcFvK6XXyW3tKi0jThN12Yp99qS2znw4GQvXD
46X9MAEY7oLmCHL+pRTb4KGwZa2YD2wg0fXugykLFclD6YpS6iBo3LzM4MXron/x
qzp+KsdnJXxEMKtnZMYY5IRlWZq0NSyy/9Pn2rmLBrmFkL9S8qboocYVH0CQTjFt
lbVpY5HEfI//c13AqkXjsCve+IucS5YhyCnBjBqjDP5SGYeYax1be39z9riwkaHN
o9E7sza+di2RYAjI47UDbC9PgjWMqXWy/F+aC05HrUEcag0psBQpTTsRfK/EEowZ
X8KUgXOmc3kbgWx+VpWzJ5GYqW5HwDFKZTzEkxK/JMlpbTvv7krfhMBdhA9kBiDt
Y3xJiIlMHihtNB2zJmtIPa4s67ax6Xrxxum55appNCj5NAJym//uTnagxEv28ygB
CWaGnuMT2S7/LlSGS+IbrFgM8r5agpSI61EoWpF8Dwr6sEvksnemHYEVqEOo0bM2
4VWoXswFv2Y3NYUvdhDz4k/EaE4Apjo5gsEI+mVUQPmw3f4p/uXsJBWlmRQ4WopS
ACpNW8kDDkkBEMiADHogh64IadEGKumcxUTUfhJmrThgxDPkru185LliCVinxlEA
Krz4z9tzjMh1QIimC9IWykhC2DPYtzYcWgtbyBgEl+MXiF1x53w=
=r6OC
-----END PGP SIGNATURE-----

--itjyily7edmuzn6j--

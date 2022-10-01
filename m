Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAC5F1F4C
	for <lists+linux-pm@lfdr.de>; Sat,  1 Oct 2022 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJAUWF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Oct 2022 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJAUWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Oct 2022 16:22:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7A3C179
        for <linux-pm@vger.kernel.org>; Sat,  1 Oct 2022 13:22:04 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E66096601FAF;
        Sat,  1 Oct 2022 21:22:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664655723;
        bh=wqFWOW/OyWDfoee9KFjfBFsXAcHmgvzKirLr3Qysz8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmL4q3TM9ZtnL2r/8exv0bC7OZ8nfK+U8QCgs/1qtifBuFAjd2U2MgTw5Y1l/twLe
         yx1w9lYcqC2biP6B/9sgXh+jTvdTdBzJIAclONxKaVaamKULSCr3BKtdkcWBamSZmp
         70xnpfBvBdOmfW8DXvpWOnARB0fcn10gibrNHlP7ru274pSgvM2T9SPRUL+/q8E07f
         02JZod4Tu8LbBS80pgxi00rqsieehhSLowvCBBwqVqVT0Tz5kTW81200GAgd8pmRx3
         5x0JWpxavdl5j47rxzye1fIbvZNdL3N9A4FTLypd/gTUSjzyr8jpDp3Kcw8LhIsjf4
         7HbhnjsdzTkYA==
Received: by mercury (Postfix, from userid 1000)
        id 9EF95106090C; Sat,  1 Oct 2022 22:22:00 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:22:00 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        chiaen_wu@richtek.com
Subject: Re: [PATCH -next] power: supply: mt6370: Fix return value check in
 mt6370_chg_probe()
Message-ID: <20221001202200.2qhm2hy6lsv7iqxg@mercury.elektranox.org>
References: <20220921152915.1506767-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u47awkpqqf36v5rg"
Content-Disposition: inline
In-Reply-To: <20220921152915.1506767-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--u47awkpqqf36v5rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 21, 2022 at 11:29:15PM +0800, Yang Yingliang wrote:
> If create_singlethread_workqueue() fails, it returns a null pointer,
> replace IS_ERR() check with NULL pointer check.
>=20
> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger =
driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/mt6370-charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply=
/mt6370-charger.c
> index 716cba259a7a..f27dae5043f5 100644
> --- a/drivers/power/supply/mt6370-charger.c
> +++ b/drivers/power/supply/mt6370-charger.c
> @@ -911,8 +911,8 @@ static int mt6370_chg_probe(struct platform_device *p=
dev)
>  	priv->attach =3D MT6370_ATTACH_STAT_DETACH;
> =20
>  	priv->wq =3D create_singlethread_workqueue(dev_name(priv->dev));
> -	if (IS_ERR(priv->wq))
> -		return dev_err_probe(dev, PTR_ERR(priv->wq),
> +	if (!priv->wq)
> +		return dev_err_probe(dev, -ENOMEM,
>  				     "Failed to create workqueue\n");
> =20
>  	ret =3D devm_add_action_or_reset(dev, mt6370_chg_destroy_wq, priv->wq);

Thanks, queued.

-- Sebastian

--u47awkpqqf36v5rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4oWgACgkQ2O7X88g7
+prwkg/9H8t+w5BDB7ZR23wuGrZXIVllKKOvLNjCDjaRRfQ+lXyF7dJh7i5pc6Gu
5JdXoeUWbL3HxB/DRBQivZrZkkmiJ+4U7qLmRm9OXsyYZ+8MKlkDTbREpz2pKNzi
DB6KRMiYWssrSiOpKwx5Gs0HvCLFx3RD2R0ia6zMWOurNfnNYg/O855JNH4k01XT
5+nFMUFWxhKSO3rGr1SBaCcBohsN3itRp+7xMw5up3iOMA1Egkd6SciMZKAYBCRc
RuAW9cRrNEVtFLjXEyEg92RfWh+dxAtGuHQYMykdAyL+Zm8pUsR0X6OWoQROOdR+
mDMaW8G+oAQC0AuKNBHHgTtvkHx59iK6w42KWS64ehchMwR8FGVQncG6Rfd/oNiV
s1lqZVaXGkucPbglkEjbcVQm8kFJBFwsqUO1nPFU8gw/q+BjveIt+gnNHB+PnOaf
Xbi4ECLr1Q7Uq7DlRKBJqaTT7Yc4s/kyk7jWJFv9SgG2ZTgoErwX+7JDIpH/E3rF
FOQ92uGFDktQ3NArpmCpBIdwgBesln4PvUuVyarMRVgVDtu22kBDldjwgsl3/nE8
FXwpUEyiBPw8nwdzyGtKWlhqinXssW6M1vuGlktMrvWyFcavOGmmcvVr0TxuKLt0
sljzERUFWxQOPYI1zp4BP6i8Ln5wtyqOJxlHUsASs5szRvNzETw=
=ee/F
-----END PGP SIGNATURE-----

--u47awkpqqf36v5rg--

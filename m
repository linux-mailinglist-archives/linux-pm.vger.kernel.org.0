Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A246380C3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Nov 2022 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKXV6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Nov 2022 16:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXV6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2022 16:58:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2671E7DC9A
        for <linux-pm@vger.kernel.org>; Thu, 24 Nov 2022 13:58:40 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D69DF6602B47;
        Thu, 24 Nov 2022 21:58:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669327118;
        bh=v9cThGv9HCloRL/Y2LwP/br4wGF0ZUkkNKzhpyb7kT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8o+FvPw4EHtr73ISL1U0fUYS8k2Ue5iC/8JbCjy1yz+GIyQDT1O/uSMZBo6I1zTJ
         7rGs1OBrXQc9fLR2kiXGYf3Uq2MJBEI+awXPwKdvd+xI4wRFeyNt4Us850pBtO1DrG
         /OJ0PfRLIokMxN05C/+H5YLa+TSMh0B2Lv3SKR8VzoDt1yY1VL0412EJg8yWmHkLAk
         qgPXOUhYznKqGWvqO8yT45zbXTdRgU818HKN81w8HtHYOmnfJRZ0ZZxG6V2Vz+uvyX
         K0NHjPNRTN8jFS+JVgmNqJu0Fom+C3B9KKrv5pbCc433i+OKqF0GhPUCb9uTf3BRgd
         a3mwE/D5HCiVw==
Received: by mercury (Postfix, from userid 1000)
        id B1DFC106092D; Thu, 24 Nov 2022 22:58:35 +0100 (CET)
Date:   Thu, 24 Nov 2022 22:58:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhang Qilong <zhangqilong3@huawei.com>, daniel@zonque.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: z2_battery: Fix possible memleak in
 z2_batt_probe()
Message-ID: <20221124215835.kxzmni2bgcvkgnc6@mercury.elektranox.org>
References: <20221121011834.119060-1-zhangqilong3@huawei.com>
 <CACRpkdYwaoGOMNTdPnUbD-2y5PHY7Wp+fSuQvTsZLm2kaNuKeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pznkkmt6i56i2mtk"
Content-Disposition: inline
In-Reply-To: <CACRpkdYwaoGOMNTdPnUbD-2y5PHY7Wp+fSuQvTsZLm2kaNuKeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pznkkmt6i56i2mtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 22, 2022 at 09:33:34PM +0100, Linus Walleij wrote:
> On Mon, Nov 21, 2022 at 2:14 AM Zhang Qilong <zhangqilong3@huawei.com> wr=
ote:
>=20
> > If devm_gpiod_get_optional() returns error, the charger should be
> > freed before z2_batt_probe returns according to the context. We
> > fix it by just gotoing to 'err' branch.
> >
> > Fixes: a3b4388ea19b ("power: supply: z2_battery: Convert to GPIO descri=
ptors")
> > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>=20
> Oops good catch!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

-- Sebastian

--pznkkmt6i56i2mtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmN/6QcACgkQ2O7X88g7
+ppYUBAAobl6Ti9OMXtQOr1sW1SlUCixdvvDgS/R2EfWiHO2kHS80e5eWQ6UdbEl
PM1kx1jZZM7wC4ncVo51WJwc+7bKFf04WhenAfC/xvvWkKbYZBaBylfu8MaEMT37
XEbESrrA5j9HvPvpwxd6vnPqZYty2dF0IcOdylTKvyN/dJ+zPEirEM9r2yp7LTnf
VwUHJOb67CiAJnWHAj/WIj3suSsSfCRc8wUEBAJK7G18iInCBkCE53AS4o375m7a
O9cIjiCBoqS3NesMCWQOahMLP6Zn48Fimm1e3rU+eoJUV9qY2dZbHR8X00zAYXhw
x+1sf38bvJUL9NTbuStU92jNGHqLdPVOsnYphGsNJSApPKAc8JMZXKcJBjQSwJmC
Dy+ImAwO1KDz7hNPflLyrukiqa7wwuGYlqKuedZy9wRRThpgq7KwQ42L17Qlsdcv
BmVHLR37N/AcWGlXVR+d3SfgfdUapao5Eg5KTVVD4bp4qgtSDQnh7g4k5kyJ2qvt
vquGkVtUvDDeivbaLoVWZsIeRGTU++kwufUb3c9k6gs5wHGcK05+fPksQ5JH7AGG
QXeF2SPPlNMO9uFJMMAlIzUpxvQIVsNTGe2awj3fms258N4+lNJTRDT9C8ksgaED
xyJSMZlcNk4aaLseONk3ri8ZVOXvOZoDXDTtJWZifa0xc7oVAHo=
=09SD
-----END PGP SIGNATURE-----

--pznkkmt6i56i2mtk--

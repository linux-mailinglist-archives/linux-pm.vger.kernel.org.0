Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62451A6FBC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389920AbgDMXEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 19:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727968AbgDMXEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 19:04:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3BFC0A3BDC;
        Mon, 13 Apr 2020 16:04:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9D25B2A0D6D
Received: by earth.universe (Postfix, from userid 1000)
        id 6CD7E3C08C7; Tue, 14 Apr 2020 01:04:28 +0200 (CEST)
Date:   Tue, 14 Apr 2020 01:04:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] power:supply:88pm860x_battery:remove
 redundant dev_err message
Message-ID: <20200413230428.33zvqkw22sq25yk3@earth.universe>
References: <20200406050757.13796-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n754yjdft2ijrfzm"
Content-Disposition: inline
In-Reply-To: <20200406050757.13796-1-tangbin@cmss.chinamobile.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n754yjdft2ijrfzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 06, 2020 at 01:07:57PM +0800, Tang Bin wrote:
> In the pm860x_battery_probe(),when get irq failed, the function
> platform_get_irq() can log an dev_err message,so remove redundant
> message here.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

Thanks, queued.

-- Sebastian

> Changes from v1
>  - changed the theme=E3=80=81commit message and the code,but the purpose =
is the same.
>    The original piece is:https://lore.kernel.org/linux-pm/20200402111222.=
15204-1-tangbin@cmss.chinamobile.com/
> ---
>  drivers/power/supply/88pm860x_battery.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supp=
ly/88pm860x_battery.c
> index 5ca047b3f..1308f3a18 100644
> --- a/drivers/power/supply/88pm860x_battery.c
> +++ b/drivers/power/supply/88pm860x_battery.c
> @@ -919,16 +919,12 @@ static int pm860x_battery_probe(struct platform_dev=
ice *pdev)
>  		return -ENOMEM;
> =20
>  	info->irq_cc =3D platform_get_irq(pdev, 0);
> -	if (info->irq_cc <=3D 0) {
> -		dev_err(&pdev->dev, "No IRQ resource!\n");
> +	if (info->irq_cc <=3D 0)
>  		return -EINVAL;
> -	}
> =20
>  	info->irq_batt =3D platform_get_irq(pdev, 1);
> -	if (info->irq_batt <=3D 0) {
> -		dev_err(&pdev->dev, "No IRQ resource!\n");
> +	if (info->irq_batt <=3D 0)
>  		return -EINVAL;
> -	}
> =20
>  	info->chip =3D chip;
>  	info->i2c =3D
> --=20
> 2.20.1.windows.1
>=20
>=20
>=20

--n754yjdft2ijrfzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6U7/wACgkQ2O7X88g7
+pp5nBAAny2GsOfJrY108fh07lXnJQeY4FG//WzaAuCsYhRaVTKhYaZaj5XYCoAe
YZDQ23fwGosAja9aAdTaMSA63H6nMaWuLn2xlIsEe6ZGPiay6JJtp7+MIpfa/rts
C8iiJcN+jk0atj35W+f8QK2aeYuqKr/w8ZmATX6d7rvgWE72319dkGadpjiNZc16
Wi9SxfbQP+0LpKpQcx2Xoph8zWs7pKBVUzCdsYw3NJCJPfz06bi1+fk7eB2cTjJq
/loSJm9dZ17UXSjVMWmdiIznJ/dVDD/xUVrE+jp+tq9pUOxoP69pj90nE7Ytniy9
Y/5O1pbhj9byGCnbvZJq+fDp0jQSmw9ex4tGter9xUae3epfToM2JpvV5yCso9id
a85Va7AFktr+zPxGqj5q1wKQuP0eCWZaa7lxQV5UgKPM8zVuGXWl5b5tat5VyiGO
Ye8vSWJ5NeOsIghWYy0gTLciAu8opudLrDrN9tyBSlS3FDGRg4i7TTjeVLdAwoWN
bsKfsc86WQQM/hAIezyL3tjFdWrZuwPqMK1SODxbt7x1nqd0pF5WLVk0x6larXaZ
cYb6A57wBp7rdL3QbKERrWBP5Ee/Vg2Hzx7FFfO0V46iXWodsFQHbiSIvy0t5PQ8
XFX+QURl8SsZpOb/icLFKJGBd9j9KRM6ylCYs6OVPrtHYrD6YZo=
=Q76U
-----END PGP SIGNATURE-----

--n754yjdft2ijrfzm--

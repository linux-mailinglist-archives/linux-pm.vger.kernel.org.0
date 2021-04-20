Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9328E365AF7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 16:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhDTONl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhDTONk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 10:13:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4426C06174A;
        Tue, 20 Apr 2021 07:13:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2BA8E1F42875
Received: by earth.universe (Postfix, from userid 1000)
        id 6B3AC3C0C96; Tue, 20 Apr 2021 16:13:03 +0200 (CEST)
Date:   Tue, 20 Apr 2021 16:13:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     zhuguangqing83@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: fix invalid usage of list
 cursor
Message-ID: <20210420141303.c3qs2ue2cp24zbcj@earth.universe>
References: <20210414064724.27068-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dnew6poyedt2lq37"
Content-Disposition: inline
In-Reply-To: <20210414064724.27068-1-zhuguangqing83@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dnew6poyedt2lq37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+Cc Tony]

Hi,

On Wed, Apr 14, 2021 at 02:47:24PM +0800, zhuguangqing83@gmail.com wrote:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>
> Fix invalid usage of a list_for_each_entry in cpcap_battery_irq_thread().
> When list is empty or if the list is completely traversed (without breaki=
ng
> from the loop on one of the entries) then the list cursor does not point
> to a valid entry and therefore should not be used. "if (!d)" will never
> happen, maybe we should use "if (&d->node =3D=3D &ddata->irq_list)".

Commit message does not make sense. I think you meant to say:

Empty list or fully traversed list points to list head, which is not
NULL (and before the first element containing real data).

> Fixes: 874b2adbed125 ("power: supply: cpcap-battery: Add a battery driver=
")
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---
>  drivers/power/supply/cpcap-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 6d5bcdb9f45d..8169dc71a786 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -786,7 +786,7 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, =
void *data)
>  			break;
>  	}
> =20
> -	if (!d)
> +	if (&d->node =3D=3D &ddata->irq_list)
>  		return IRQ_NONE;

Please use list_entry_is_head() instead of open coding it.

>  	latest =3D cpcap_battery_latest(ddata);

Thanks,

-- Sebastian

--dnew6poyedt2lq37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmB+4WUACgkQ2O7X88g7
+poBqw/7BZUVQZBC2lPLVp2Hpfy39lbndvhzobXn+J7fZAwaiv0jDASNtlkTqW+E
Q32njsi46WxqUHycnWUNk05G74zlKST+r9dFzOh8v4wy+vsoC8RrZ5ETS1AYku7o
eGKLTkAladKltaWrERsykOyf3Jv1LkD6wWi/gY85yG9AWVu3QGR7Caz6bfNLlHkk
0Pi00agzI2n6/l2q3RoaDjJ9NO3AoJ4+9m3Od9XhlJHEOiIYVK8wi3a0rsACxGPc
x4daN72S+o23cWJfqGSaln11e/FzaAOMPxuCHq/vUH3pO5tq4YLXTAYBa/PGGUnC
y17LH0XST4WVQouHpfHODelGcTeBrvkgosY3mA5KOluEOA/FgTZoo0zUr7LoXJPV
qjT5zD35y85faiHn+wKdOhBNvGSQvQaBYTRbH4nZRtr9Fm+zrnrmRadQ9MEFgTi2
QVqXyDXZ22k4s5EcUVOO6jUcov+Cbopq+txeBMhWmZeKjByplV5pemeOiSKpRJR+
HHhx/dOPrnNYsbclNGmr2svUzt7ik4yvOXmVb0hA1jbrV+2GphiF/en5UzfLQ42L
si1IgS+rbVJW2c05Ef4YBVjqrGV2SxDTCDw04A2tuBMLKU32uCvlWFN6t4E/Zunc
/IbvzESx4+ToBbVPLbOGDjya6HYbxZQahMVkKpO+GF4patDtwi0=
=LiWG
-----END PGP SIGNATURE-----

--dnew6poyedt2lq37--

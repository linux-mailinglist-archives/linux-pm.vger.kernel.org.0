Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE6358366
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhDHMjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhDHMjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 08:39:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1AC061760;
        Thu,  8 Apr 2021 05:38:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4E3C11F45CCC
Received: by earth.universe (Postfix, from userid 1000)
        id 1FE943C0C96; Thu,  8 Apr 2021 14:38:49 +0200 (CEST)
Date:   Thu, 8 Apr 2021 14:38:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] power: supply: generic-adc-battery: fix possible
 use-after-free in gab_remove()
Message-ID: <20210408123849.c7oxkfrvxcvehftr@earth.universe>
References: <20210407091706.3266580-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d4e3pa23m4mtxfp2"
Content-Disposition: inline
In-Reply-To: <20210407091706.3266580-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--d4e3pa23m4mtxfp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 07, 2021 at 05:17:06PM +0800, Yang Yingliang wrote:
> This driver's remove path calls cancel_delayed_work(). However, that
> function does not wait until the work function finishes. This means
> that the callback function may still be running after the driver's
> remove function has finished, which would result in a use-after-free.
>=20
> Fix by calling cancel_delayed_work_sync(), which ensures that
> the work is properly cancelled, no longer running, and unable
> to re-schedule itself.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/generic-adc-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/s=
upply/generic-adc-battery.c
> index 0032069fbc2b..66039c665dd1 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -373,7 +373,7 @@ static int gab_remove(struct platform_device *pdev)
>  	}
> =20
>  	kfree(adc_bat->psy_desc.properties);
> -	cancel_delayed_work(&adc_bat->bat_work);
> +	cancel_delayed_work_sync(&adc_bat->bat_work);
>  	return 0;
>  }
> =20
> --=20
> 2.25.1
>=20

--d4e3pa23m4mtxfp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBu+VgACgkQ2O7X88g7
+pqfcBAAh9AiD2vv4fxLc/QZsABIke76eWHHLJ6/bke9Fe8lAQaiDkUaaTS4mT40
fkIY5PPnwHLoMPHJ+dhPBEOctARPm8RBVVj4GeV+2WLGB4ELjFgMZWKLneKJ5UKF
Yu0ovRuH5GxYbfeCg9l8kAW1ojTPI2javM7MsdvHG+t4KaVSN9FfKXLgkI+ylFHz
dkgPSuWGKRwJRO3LlY2cL4egwZTXoN5QUydT29kR9Lcm90qV/2u4bTIl/Q2wQzql
DMnc+8JsVMRRA8kHsJBGFHejW0hsHFUVaOxGqV1mJ6PO59+HOy35BpBUaIIfMSzD
gU66xOhvhyCUMW742l8piIPEetbiJJeUJox6zFuXQCOVVAMZovrHTme4D9ao1SPF
MqSFe1nMUPdNScyaVKZGO/2SpKJK21H/F+VQEUxmnCUOeTjB6Z/qrDnjPqhqLmAy
VtdPchqb00pBJTK7m3fSIXr1iUl6JD+sgneoP98kvGvsZ3HN7pWEWy5OLyAbjtKo
2wm2p2Ln13Sa5iXPAUY9u4EW1A4M+mtJ5OkxgfVfbRg0W8QgS8PT0jPW1QOLs0qV
WripDWxHVe5x3FXlZnUxk9UO6IPPxu1u/l6300kUc0nwozR4mPZxX8J9Mm6G5Lxp
GSRgSbMkat+QGgde/xQPhnxzFRVC4rwcvzcZYaYPucbgELv9vC8=
=oSXo
-----END PGP SIGNATURE-----

--d4e3pa23m4mtxfp2--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D03068AA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhA1AdM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1AdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:33:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE999C061573
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 16:32:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C83E91F44542
Received: by earth.universe (Postfix, from userid 1000)
        id A15983C0C97; Thu, 28 Jan 2021 01:32:25 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:32:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jian Dong <dj0227@163.com>
Cc:     linux-pm@vger.kernel.org, dongjian@yulong.com, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: Re: [PATCH] power-supply: use kobj_to_dev()
Message-ID: <20210128003225.glwgvrukp4hr3etf@earth.universe>
References: <20210120014713.17668-1-dj0227@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvbhpi4vvvriklea"
Content-Disposition: inline
In-Reply-To: <20210120014713.17668-1-dj0227@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kvbhpi4vvvriklea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 20, 2021 at 09:47:12AM +0800, Jian Dong wrote:
> From: dongjian <dongjian@yulong.com>
>=20
> Use kobj_to_dev() instead of open-coding it
>=20
> Signed-off-by: dongjian <dongjian@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ds2760_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply=
/ds2760_battery.c
> index 695bb67..5f50da5 100644
> --- a/drivers/power/supply/ds2760_battery.c
> +++ b/drivers/power/supply/ds2760_battery.c
> @@ -198,7 +198,7 @@ static ssize_t w1_slave_read(struct file *filp, struc=
t kobject *kobj,
>  			     struct bin_attribute *bin_attr, char *buf,
>  			     loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	return w1_ds2760_read(dev, buf, off, count);
>  }
> =20
> --=20
> 1.9.1
>=20
>=20

--kvbhpi4vvvriklea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASBhkACgkQ2O7X88g7
+prA7A/6AqkKq135TvR8GoUUglm4DwwBv2FAs7xqGy4Xtq+HjF0cf2zMlR/Ek9RF
o7mlQgi2JRfS7dFt5tPra7Oz7RWPBPdydG0rTt82DNb8y81Seyj76CqQa7+ygzb3
v9srfH9zxLhBfYxjpLZKOXV3if2JfoJOZJwyNUfKJ1GX0CNjmlFoyHqOYQ93taiu
/8LwVbs6AbfxcrdgNIlFDFf1D0l3iL+xAJE3KWG4qXmMJ6gYA4ftyaa0laY146qz
d5SfoOfphX0fh7kmzowl35M4+dcZFJwvoo1bP5UFOwfmHn/pwzYfzfYE+kDLjLV/
/dMfhd8EC5YdynPdq9jAsBjT5Cf7J6mOOS3FEjv2nGlRVC+SChyU3O9s9V0kve3A
yRqdcwSOB5q9sfv9FK/968Zqs6jQyaobRQCLvRUzEXahibh2WZQPsU1g7CwthfrZ
NP5sBy9rH74H9Aej412KCNkQbHEfHEcV58QGtE7ouJqwRNm+X+ZOn556kiGNYYNQ
AdWZuubB37PP0VHRs8+dZk8xPopWR8SLteu5dDCxDSe523HwTuODMLMvwFi0O53g
AHdP2qJLIJ4szETkcbL+Xc//KvwaVuXL3nK0lRmQl9K0nbr1lkrE10OJMLXb1quo
w40v/IOd6DWTg5k+bSjLFdk+5Qf2Rt91cVMqLUPr9mXtqm5wAe4=
=wIHZ
-----END PGP SIGNATURE-----

--kvbhpi4vvvriklea--

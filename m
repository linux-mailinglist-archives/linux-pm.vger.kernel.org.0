Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CED23264B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 22:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2Uio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 16:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2Uio (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 16:38:44 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4F220663;
        Wed, 29 Jul 2020 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596055124;
        bh=VYp51L0PqzAAfZr9+9UZ9JpjeqeU3KXhTWlu7/UjDn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwCqhvLfhpVRmgTpPf1Tj/ojFGI+dYhhsE0Xk1mWRpKl442XX1LouZu61Lm7lQTP/
         3lVj5QeYUOIVR48MdzjBT22fk/22Q/WRB8tGcoLPdINtD6DgQo1h5jqXfOYXqder97
         xCH3yljvNWSvjdgHlyrs+KlDRcntjVlXFa+X2z68=
Received: by earth.universe (Postfix, from userid 1000)
        id 511093C0B87; Wed, 29 Jul 2020 22:38:42 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:38:42 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     lh lin <lh.lin@mediatek.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        YJ Chiang <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH] test_power: Fix battery_current initial value
Message-ID: <20200729203842.guuxxjogtduqgrqs@earth.universe>
References: <20200729121400.20960-1-lh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o76ut34fyv2iprtm"
Content-Disposition: inline
In-Reply-To: <20200729121400.20960-1-lh.lin@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--o76ut34fyv2iprtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 08:14:00PM +0800, lh lin wrote:
> From: LH Lin <lh.lin@mediatek.com>
>=20
> Since default battery_status is POWER_SUPPLY_STATUS_DISCHARGING,
> we should change default battery_current to a negative value.
>=20
> Signed-off-by: LH Lin <lh.lin@mediatek.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/test_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 65c23ef6408d..4f29f0f096f5 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -34,7 +34,7 @@ static int battery_technology		=3D POWER_SUPPLY_TECHNOL=
OGY_LION;
>  static int battery_capacity		=3D 50;
>  static int battery_voltage		=3D 3300;
>  static int battery_charge_counter	=3D -1000;
> -static int battery_current		=3D 1600;
> +static int battery_current		=3D -1600;
> =20
>  static bool module_initialized;
> =20
> --=20
> 2.18.0

--o76ut34fyv2iprtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8h3lIACgkQ2O7X88g7
+pqvzQ//V7LTFWHWjCw602p2ejA5i0LeNqVnMhZn3ncZRbHdnQzUa4pYaVd/vOTV
PtjhD6XBGY6NEEG/UbiooH5wZ9AeUmSuQR+uj1XH3afTlGfRsAAUz6FmoemSA2Vw
VfDJa2HzQESrup7VkXMCx6EyPZIPJV/+0Ds/d987gZqFfT+lLgZblMqr7Eq0ubdC
L/kHlwkeAI9++brGU6NOAG5AjoIeE6YasX6mhfU5i2HLWDcvYuw3OosYYwBqKkCd
12FsSilZCwBODTYT6MAc/lYJ69kJlp2QWKQ8HYH5Ds5PzbMvD24Fhwx2ndX3G6wh
AzHwuY1mpXrwNNhDIDDe9wmFZIFwdYH8Ok9zvodjCDErsgqu3pqMIOZfUwQwZ7in
oVqkuZug5wtxtM+/zyHRlT8SO5+eGxliLzBhb0mf7ClEZKkIuSdjRZnoLkfjuihj
o0BVJ4UwzQaunoGLmWsZxu2F2YM08nfAXjrNJfA6ammD5JCuRYqZVCh+K0WGZxFa
7zeYe4NOWAkN72oR15F2qkU/LIP68IrezHc6UzXDzw8p61w9s1Wfc6NLNI2X/G6E
Nw2CzSJ/1ok/l6Dwf+UuEFGp0UcQTuesQkC8TU8CKbigGccYh5vQKsqQVqVKslof
bIxJrF7oaIPBM+FMf6/jzJ6rgwXj9MVY6PDA2VxyNdneFJ7WdRo=
=w2E8
-----END PGP SIGNATURE-----

--o76ut34fyv2iprtm--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435E027DC94
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgI2XS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 19:18:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39320 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgI2XS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 19:18:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5E3D629B618
Received: by earth.universe (Postfix, from userid 1000)
        id E6A0B3C0C84; Wed, 30 Sep 2020 01:18:52 +0200 (CEST)
Date:   Wed, 30 Sep 2020 01:18:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: fix spelling typo
Message-ID: <20200929231852.cej2fj2etrwaif2o@earth.universe>
References: <1601088070-12790-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqs32q2ghsl3w3ku"
Content-Disposition: inline
In-Reply-To: <1601088070-12790-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uqs32q2ghsl3w3ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 26, 2020 at 10:41:07AM +0800, Wang Qing wrote:
> Modify the comment typo: "compliment" -> "complement".
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ds2780_battery.c | 6 +++---
>  drivers/power/supply/ds2781_battery.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply=
/ds2780_battery.c
> index db3a254..dd57a47
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -160,7 +160,7 @@ static int ds2780_get_voltage(struct ds2780_device_in=
fo *dev_info,
> =20
>  	/*
>  	 * The voltage value is located in 10 bits across the voltage MSB
> -	 * and LSB registers in two's compliment form
> +	 * and LSB registers in two's complement form
>  	 * Sign bit of the voltage value is in bit 7 of the voltage MSB register
>  	 * Bits 9 - 3 of the voltage value are in bits 6 - 0 of the
>  	 * voltage MSB register
> @@ -188,7 +188,7 @@ static int ds2780_get_temperature(struct ds2780_devic=
e_info *dev_info,
> =20
>  	/*
>  	 * The temperature value is located in 10 bits across the temperature
> -	 * MSB and LSB registers in two's compliment form
> +	 * MSB and LSB registers in two's complement form
>  	 * Sign bit of the temperature value is in bit 7 of the temperature
>  	 * MSB register
>  	 * Bits 9 - 3 of the temperature value are in bits 6 - 0 of the
> @@ -241,7 +241,7 @@ static int ds2780_get_current(struct ds2780_device_in=
fo *dev_info,
> =20
>  	/*
>  	 * The current value is located in 16 bits across the current MSB
> -	 * and LSB registers in two's compliment form
> +	 * and LSB registers in two's complement form
>  	 * Sign bit of the current value is in bit 7 of the current MSB register
>  	 * Bits 14 - 8 of the current value are in bits 6 - 0 of the current
>  	 * MSB register
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply=
/ds2781_battery.c
> index 130cbdf..3df3c82
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -168,7 +168,7 @@ static int ds2781_get_voltage(struct ds2781_device_in=
fo *dev_info,
>  		return ret;
>  	/*
>  	 * The voltage value is located in 10 bits across the voltage MSB
> -	 * and LSB registers in two's compliment form
> +	 * and LSB registers in two's complement form
>  	 * Sign bit of the voltage value is in bit 7 of the voltage MSB register
>  	 * Bits 9 - 3 of the voltage value are in bits 6 - 0 of the
>  	 * voltage MSB register
> @@ -197,7 +197,7 @@ static int ds2781_get_temperature(struct ds2781_devic=
e_info *dev_info,
>  		return ret;
>  	/*
>  	 * The temperature value is located in 10 bits across the temperature
> -	 * MSB and LSB registers in two's compliment form
> +	 * MSB and LSB registers in two's complement form
>  	 * Sign bit of the temperature value is in bit 7 of the temperature
>  	 * MSB register
>  	 * Bits 9 - 3 of the temperature value are in bits 6 - 0 of the
> @@ -242,7 +242,7 @@ static int ds2781_get_current(struct ds2781_device_in=
fo *dev_info,
> =20
>  	/*
>  	 * The current value is located in 16 bits across the current MSB
> -	 * and LSB registers in two's compliment form
> +	 * and LSB registers in two's complement form
>  	 * Sign bit of the current value is in bit 7 of the current MSB register
>  	 * Bits 14 - 8 of the current value are in bits 6 - 0 of the current
>  	 * MSB register
> --=20
> 2.7.4
>=20

--uqs32q2ghsl3w3ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9zwNwACgkQ2O7X88g7
+poe4xAApDqvp17zcMV6bbQjCgtAfIVxdXyV22639kClfCylNrt2K7vd/5Xdf/Rm
RDHbUbVnRYIdDZEhZ1y8UZXUrI5zbRjD+aRTGMYrqAyI12ExEsty5dKC5aFHSj+M
ERVJ3zNWr9ORLFPnUNPHxquU91V1KDJ55S0zrtbd6KLTdErCw4D+lrnomiTU4kCn
PUBNuD0o10Qd6sDm6uYHpAEE9nYzUkQxoJEtOJqGr5iiKg378nEMsUlLZRhZibVV
I3AsoGmifOw2xcrQLc4yNCmTu75sK54MWyPCdKnVuf37+eDOmQ586A6l5B5ytqhD
WzKvXF6dK/T/VB2MWq2YazwKt+zjVTzqaNQiK7Iju3k3Z8ErrL6AbDXyDreIu2j1
kBKe4HWdcM0RuiQdy0/q86lt1TMoa23A3zyjkzT8bFdmYuBo64xZ0QBu3Ymvyb53
M41sGcrwJkmhW2ZJJOlhaX/G3gni4Fi3jlZrIaQVBngM2HH6GXhWYOQ7PsvOHvLN
ijsMN3/2OYJk04roj5nJepIbuvXMvNqCxvA9FvpjWd/yjdPNAqRIlc9+SWsxvJKf
88o3k0Q4O1Wb9PQ9snGs0rRkdhNnQ4QjVFH6X5bJvSJbGPAqpOsBLRj5G+TgTL0s
tfwMJ1RIHAdN5cWlBxaNuCeocZqxzy4TmTHs5UP2YbR2baX0I1k=
=rMNz
-----END PGP SIGNATURE-----

--uqs32q2ghsl3w3ku--

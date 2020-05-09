Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B466F1CC548
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 01:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgEIXmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 19:42:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgEIXmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 19:42:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AF6FE2A01A7
Received: by earth.universe (Postfix, from userid 1000)
        id A76D43C08C7; Sun, 10 May 2020 01:42:01 +0200 (CEST)
Date:   Sun, 10 May 2020 01:42:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     chenzhou10@huawei.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] power: reset: ltc2952: remove set but used variable
Message-ID: <20200509234201.md2veh4cxkdwoj2h@earth.universe>
References: <20200509103611.29551-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocomalmwbouxc3aq"
Content-Disposition: inline
In-Reply-To: <20200509103611.29551-1-yaohongbo@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ocomalmwbouxc3aq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 09, 2020 at 06:36:11PM +0800, Hongbo Yao wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/power/reset/ltc2952-poweroff.c:97:16: warning: variable
> =E2=80=98overruns=E2=80=99 set but not used [-Wunused-but-set-variable]
>   unsigned long overruns;
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/ltc2952-poweroff.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset=
/ltc2952-poweroff.c
> index e4a0cc45b3d1..318927938b05 100644
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -94,7 +94,6 @@ static enum hrtimer_restart ltc2952_poweroff_timer_wde(=
struct hrtimer *timer)
>  {
>  	ktime_t now;
>  	int state;
> -	unsigned long overruns;
>  	struct ltc2952_poweroff *data =3D to_ltc2952(timer, timer_wde);
> =20
>  	if (data->kernel_panic)
> @@ -104,7 +103,7 @@ static enum hrtimer_restart ltc2952_poweroff_timer_wd=
e(struct hrtimer *timer)
>  	gpiod_set_value(data->gpio_watchdog, !state);
> =20
>  	now =3D hrtimer_cb_get_time(timer);
> -	overruns =3D hrtimer_forward(timer, now, data->wde_interval);
> +	hrtimer_forward(timer, now, data->wde_interval);
> =20
>  	return HRTIMER_RESTART;
>  }
> --=20
> 2.20.1
>=20

--ocomalmwbouxc3aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl63P8AACgkQ2O7X88g7
+ppUHhAAlOhSJZFvAj8R7L0WLTSsWZmZ5QflRas0lCV7jYwESpyhyDxaHSxelnF8
l/DDBHSS90Vn9qSzFQw7uTrso6jAXUHYnLc0zLYWaXbmO07OoENeE5pfkh56j5FU
x7f+NSnC/u5bDJIXy/0v77DUmhy6S2OduZUrxH3C0EvT3cuHbphGMPKa/Rcdny+o
dfZH77x4WjQsFZZr8gdkaDWybgrFBrZZ1BH7WO8+SBVxJp8C/7RJqDyPT1ut8EnZ
9d0M4Ii3ZJ7xpcDsLIaEJmGtvB6u3ZXTiYZXkUyTSB57uyPcQf6Gsva1CZKb26nO
gYAJmZW1VkZrdT7tOeySzLGBND+HWtYEbhgPTfWuojT5Ye0yydDs4gjzClCl7jfX
BHz2G0sh3rG4fcB9CoiZymN8tbf+L+wiiwLUBTXw/7913ENCoROiy3lU5fY+vEwM
rCKsXrMXrCeuEkmRwXsr4WTRm13gBwzX6DQ6LzwCWx2RoV9RhAaASldtKw1tx2mR
5SUA23GJx/iluisRYSrM1kSLy9FFw0NIG25ZulfUWCIoQEqJF2CdyA02ITyNO7JO
4rbbAPhBiBBAWwRl8c7KBIKCvtNkLWPufzG1vTiOJ2y5V96AFgzgCKmkR/HBiwPK
P9zz7sSP7PNugxmgrgHrf3yOgRbKOZi2+S5MiJgmPTWJjvq8XQA=
=07TS
-----END PGP SIGNATURE-----

--ocomalmwbouxc3aq--

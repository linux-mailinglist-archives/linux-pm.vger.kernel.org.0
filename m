Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14DB139E2B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 01:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgANA2x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 19:28:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgANA2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 19:28:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 70C25291454
Received: by earth.universe (Postfix, from userid 1000)
        id A1F453C0C7C; Tue, 14 Jan 2020 01:28:47 +0100 (CET)
Date:   Tue, 14 Jan 2020 01:28:47 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: supply: max17040: Correct IRQ wake handling
Message-ID: <20200114002847.3wzj7j3y422fgrfz@earth.universe>
References: <CGME20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57@eucas1p1.samsung.com>
 <20200110100540.27371-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7x5qyghxj2shd5k"
Content-Disposition: inline
In-Reply-To: <20200110100540.27371-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--s7x5qyghxj2shd5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 10, 2020 at 11:05:40AM +0100, Marek Szyprowski wrote:
> Don't disable IRQ wake feature without prior enabling it.

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>=20
> This fixes following warning observed on Exynos3250-based Rinato board:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1288 at kernel/irq/manage.c:724 irq_set_irq_wake+0xf=
c/0x134
> Unbalanced IRQ 83 wake disable
> Modules linked in:
> CPU: 0 PID: 1288 Comm: rtcwake Not tainted 5.5.0-rc5-next-20200110-00031-=
g6289fffbb3f5 #7266
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112e48>] (unwind_backtrace) from [<c010e090>] (show_stack+0x10/0x14)
> [<c010e090>] (show_stack) from [<c0b25b28>] (dump_stack+0xa4/0xd0)
> [<c0b25b28>] (dump_stack) from [<c0128088>] (__warn+0xf4/0x10c)
> [<c0128088>] (__warn) from [<c0128114>] (warn_slowpath_fmt+0x74/0xb8)
> [<c0128114>] (warn_slowpath_fmt) from [<c019e9a0>] (irq_set_irq_wake+0xfc=
/0x134)
> [<c019e9a0>] (irq_set_irq_wake) from [<c0772708>] (max17040_suspend+0x50/=
0x58)
> [<c0772708>] (max17040_suspend) from [<c05f55ac>] (dpm_run_callback+0xb4/=
0x400)
> [<c05f55ac>] (dpm_run_callback) from [<c05f5e38>] (__device_suspend+0x140=
/0x814)
> [<c05f5e38>] (__device_suspend) from [<c05f9548>] (dpm_suspend+0x16c/0x56=
4)
> [<c05f9548>] (dpm_suspend) from [<c05fa2e4>] (dpm_suspend_start+0x90/0x98)
> [<c05fa2e4>] (dpm_suspend_start) from [<c01977f4>] (suspend_devices_and_e=
nter+0xec/0xc0c)
> [<c01977f4>] (suspend_devices_and_enter) from [<c019862c>] (pm_suspend+0x=
318/0x3e8)
> [<c019862c>] (pm_suspend) from [<c01963cc>] (state_store+0x68/0xc8)
> [<c01963cc>] (state_store) from [<c03531a4>] (kernfs_fop_write+0x10c/0x22=
0)
> [<c03531a4>] (kernfs_fop_write) from [<c02b44c4>] (__vfs_write+0x2c/0x1c4)
> [<c02b44c4>] (__vfs_write) from [<c02b7288>] (vfs_write+0xa4/0x180)
> [<c02b7288>] (vfs_write) from [<c02b74d0>] (ksys_write+0x58/0xcc)
> [<c02b74d0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xd6e83fa8 to 0xd6e83ff0)
> ...
> irq event stamp: 18028
> hardirqs last  enabled at (18027): [<c014b99c>] cancel_delayed_work+0x84/=
0xf8
> hardirqs last disabled at (18028): [<c0b49b1c>] _raw_spin_lock_irqsave+0x=
1c/0x58
> softirqs last  enabled at (17876): [<c01026d8>] __do_softirq+0x4f0/0x5e4
> softirqs last disabled at (17869): [<c0130d34>] irq_exit+0x16c/0x170
> ---[ end trace 0728005730004e60 ]---
>=20
> Fixes: 2e17ed94de68 ("power: supply: max17040: Add IRQ handler for low SO=
C alert")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/power/supply/max17040_battery.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index c1188e94cf54..8a1f0ee493aa 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -351,12 +351,8 @@ static int max17040_suspend(struct device *dev)
> =20
>  	cancel_delayed_work(&chip->work);
> =20
> -	if (client->irq) {
> -		if (device_may_wakeup(dev))
> -			enable_irq_wake(client->irq);
> -		else
> -			disable_irq_wake(client->irq);
> -	}
> +	if (client->irq && device_may_wakeup(dev))
> +		enable_irq_wake(client->irq);
> =20
>  	return 0;
>  }
> @@ -369,12 +365,8 @@ static int max17040_resume(struct device *dev)
>  	queue_delayed_work(system_power_efficient_wq, &chip->work,
>  			   MAX17040_DELAY);
> =20
> -	if (client->irq) {
> -		if (device_may_wakeup(dev))
> -			disable_irq_wake(client->irq);
> -		else
> -			enable_irq_wake(client->irq);
> -	}
> +	if (client->irq && device_may_wakeup(dev))
> +		disable_irq_wake(client->irq);
> =20
>  	return 0;
>  }
> --=20
> 2.17.1
>=20

--s7x5qyghxj2shd5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4dCzoACgkQ2O7X88g7
+poxbxAAhVoW4/5o/KXxFRNGik5QZkyYMCO6eWd5xYFy0ONasfKgvFJx3MUM3pb9
alVeDGgJMARZWQwfzxMhhf+JFh4YM5S9iNLCYayPHZNT04avnF1GDiIvolGsmq76
UqY5x7t00U57Q6rWppV+eZPaSWDf5yn7QXSy5+wY9Tyxui16JNH4nw+fZKoLBFZI
3jNaTmvSbK7cFJr3Nd9MQf0iRuOjI0u4yyPvL4jzSQVatyIu64jEd2/j+UwQoc3F
0jd351w/8KaKwRH4KfBFV7Bjwb9lUH2Q9zFpk5xMoYOVM0dWWjoCX6csgh/EWmme
Ul6LTRnyoXsOBdosV0eY8DMNR0a9DGEwDr+z7pLVivKr1Ij1kvGczz1F6LX6af50
Y7hl7txqHkZXovAhQXXAD/YMy3HA3B1zNg2FyfucA5fehyeQcX5Q8Plz+g0JNnRY
lifkJlz3GhGnNSQBPXrya5kiQC0XGgS+jG4WN3x23EcXKSt1BPBQ7hxXO3+hGpbv
D8i6tDC4TQkac8ck+tOy2DT4NCbQDGZMi3ttQTONRA/e69LhbRBUAgkLT+gxSjzJ
RbiTMzT4plXDZbasgS6dblTCAa/BVYKJWuDE/3Up7sf+be6NFgt47IxZ3m2Qj5lZ
WIYNVf40YaWIKOnH8Jna2FmHSrdK6CQ1pfRISgxPTwmrVTRffSw=
=3Lbd
-----END PGP SIGNATURE-----

--s7x5qyghxj2shd5k--

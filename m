Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97402125863
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSASi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:18:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSASi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:18:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7A04D291E6E
Received: by earth.universe (Postfix, from userid 1000)
        id CB20B3C0C7B; Thu, 19 Dec 2019 01:18:33 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:18:33 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix Kconfig indentation
Message-ID: <20191219001833.fvfj2xgibkxwiu57@earth.universe>
References: <20191120133959.14109-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dhhibu4vnoabxivd"
Content-Disposition: inline
In-Reply-To: <20191120133959.14109-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dhhibu4vnoabxivd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 20, 2019 at 09:39:59PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/Kconfig | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 27164a1d3c7c..9a5591ab90d0 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -73,10 +73,10 @@ config WM831X_POWER
>  	  provided by Wolfson Microelectronics WM831x PMICs.
> =20
>  config WM8350_POWER
> -        tristate "WM8350 PMU support"
> -        depends on MFD_WM8350
> -        help
> -          Say Y here to enable support for the power management unit
> +	tristate "WM8350 PMU support"
> +	depends on MFD_WM8350
> +	help
> +	  Say Y here to enable support for the power management unit
>  	  provided by the Wolfson Microelectronics WM8350 PMIC.
> =20
>  config TEST_POWER
> @@ -209,16 +209,16 @@ config BATTERY_WM97XX
>  	  Say Y to enable support for battery measured by WM97xx aux port.
> =20
>  config BATTERY_SBS
> -        tristate "SBS Compliant gas gauge"
> -        depends on I2C
> -        help
> +	tristate "SBS Compliant gas gauge"
> +	depends on I2C
> +	help
>  	  Say Y to include support for SBS battery driver for SBS-compliant
>  	  gas gauges.
> =20
>  config CHARGER_SBS
> -        tristate "SBS Compliant charger"
> -        depends on I2C
> -        help
> +	tristate "SBS Compliant charger"
> +	depends on I2C
> +	help
>  	  Say Y to include support for SBS compliant battery chargers.
> =20
>  config MANAGER_SBS
> @@ -484,11 +484,11 @@ config CHARGER_MANAGER
>  	depends on REGULATOR
>  	select EXTCON
>  	help
> -          Say Y to enable charger-manager support, which allows multiple
> -          chargers attached to a battery and multiple batteries attached=
 to a
> -          system. The charger-manager also can monitor charging status in
> -          runtime and in suspend-to-RAM by waking up the system periodic=
ally
> -          with help of suspend_again support.
> +	  Say Y to enable charger-manager support, which allows multiple
> +	  chargers attached to a battery and multiple batteries attached to a
> +	  system. The charger-manager also can monitor charging status in
> +	  runtime and in suspend-to-RAM by waking up the system periodically
> +	  with help of suspend_again support.
> =20
>  config CHARGER_LT3651
>  	tristate "Analog Devices LT3651 charger"
> --=20
> 2.17.1
>=20

--dhhibu4vnoabxivd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36wdkACgkQ2O7X88g7
+prglg/6AuQjzRWz0WzOc8yuV4MVLbFjxBnAMr6Kk3Z4e1xmbr0ThqVUplbBgnHi
XhYg75C4LCJ34K5Fmm9vQKf1vSwLOkSCpttpYaVrD/BEhgMu9tDUhmHAiDJPvEd1
89cmKjL/sH0+yfLzZH6Td2grBGM3NP68SdS6ER4MoP2bbS5EsWhaAvag3VIwxFH9
YqQ9xvVd+ooJU7AJLLS68yqLoHJq52+rpFXmuiKnpcIRAuPynm7/ECKwb4AEmqVG
uPd8b5OFKdyToONbiw/lNLtcr1mWTDySehDeG7me5/AAfGGV+z9930qRucA5+59z
I+zEQ37LslKXIFAhWGxKN3T+EjeyL4fUZwmFcsnSU6ohf/wnt1oKpiUxL6FjoKsD
YWQJnDQk4a+Vc0jNTpTpUXGxiZtBGkxi1aO55iGxxvh0Xx4R1IKE5k4Gu+pjh+yr
hbmwaweU1ZHWyAJ5r/L3fm+qHWeiLjDV5aHkhaFJLZDNfpnZQIFreRRfRaxQIu21
dXMuRIW22WC+kjJ7z2vxiELAYMZKJjZQM+xsHscyQkB2lbPQo4RB/4z/+jCe7NOn
+n/SkrwesGdHtuqIr4qzYK6ufLS25LYOIL7ZFXa7gampVBPJSGJl8BxQ9hE297rA
5YvecmUhv9FAD+N1meofGEr5d0FtdAcZ39yLricIG/MHiIDOTDw=
=BuYn
-----END PGP SIGNATURE-----

--dhhibu4vnoabxivd--

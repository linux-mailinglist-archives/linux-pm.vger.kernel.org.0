Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CF2E8A1A
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 04:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhACD1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 22:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbhACD1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2021 22:27:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9AC061573;
        Sat,  2 Jan 2021 19:26:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D20E11F4050B
Received: by earth.universe (Postfix, from userid 1000)
        id AE3113C0C94; Sun,  3 Jan 2021 04:26:31 +0100 (CET)
Date:   Sun, 3 Jan 2021 04:26:31 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/7] power: reset: Add poweroff driver for ATC260x
 PMICs
Message-ID: <20210103032631.k6ls5k2bnxmlhlhv@earth.universe>
References: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
 <eef6e5a4e0fc5f20da235a3a4124ba81eebfe2ca.1609258905.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="auttkguxzhd5q6k7"
Content-Disposition: inline
In-Reply-To: <eef6e5a4e0fc5f20da235a3a4124ba81eebfe2ca.1609258905.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--auttkguxzhd5q6k7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 29, 2020 at 07:31:20PM +0200, Cristian Ciocaltea wrote:
> This driver provides poweroff and reboot support for a system through
> the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
> family of PMICs.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v4:
>  - None
>=20
> Changes in v3:
>  - Removed the unnecessary driver compatibles
>=20
>  drivers/power/reset/Kconfig            |   8 +-
>  drivers/power/reset/Makefile           |   1 +
>  drivers/power/reset/atc260x-poweroff.c | 263 +++++++++++++++++++++++++
>  3 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/power/reset/atc260x-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index b22c4fdb2561..1737e227b16e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -39,6 +39,13 @@ config POWER_RESET_AT91_SAMA5D2_SHDWC
>  	  This driver supports the alternate shutdown controller for some Atmel
>  	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
> =20
> +config POWER_RESET_ATC260X
> +	tristate "Actions Semi ATC260x PMIC power-off driver"
> +	depends on MFD_ATC260X
> +	help
> +	  This driver provides power-off and restart support for a system
> +	  through Actions Semi ATC260x series PMICs.
> +
>  config POWER_RESET_AXXIA
>  	bool "LSI Axxia reset driver"
>  	depends on ARCH_AXXIA
> @@ -292,4 +299,3 @@ config NVMEM_REBOOT_MODE
>  	  action according to the mode.
> =20
>  endif
> -
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 9dc49d3a57ff..b4601c0a96ed 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_POWER_RESET_AS3722) +=3D as3722-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) +=3D at91-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AT91_RESET) +=3D at91-reset.o
>  obj-$(CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC) +=3D at91-sama5d2_shdwc.o
> +obj-$(CONFIG_POWER_RESET_ATC260X) +=3D atc260x-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AXXIA) +=3D axxia-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMKONA) +=3D brcm-kona-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMSTB) +=3D brcmstb-reboot.o
> diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset=
/atc260x-poweroff.c
> new file mode 100644
> index 000000000000..81b050f99302
> --- /dev/null
> +++ b/drivers/power/reset/atc260x-poweroff.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Poweroff & reset driver for Actions Semi ATC260x PMICs
> + *
> + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/atc260x/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

There is no DT code in this driver?

> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>

power_supply.h? That's for chargers and battery fuel gauges.

> +#include <linux/reboot.h>
> +#include <linux/regmap.h>

> [...]

Otherwise LGTM. I suppose I can cherry-pick this patch into
my tree, or did I miss some dependencies?

-- Sebastian

--auttkguxzhd5q6k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/xOWMACgkQ2O7X88g7
+poyiA/+IJ9TtjwGKUynnHBFNMG0SXvbxnAZeRSlALvJBTlOnr7ENbEhN4ouUcCI
WJw2ClTRUZvOcNLr5/ZR/U5lFVvxMmsVlYpFsBov/LDyZUVi7KyLWieLU0k6ZR3Z
ZZzAHVOue9pmwggb9B9idJ+Z1t1qfN/t8XR+zGkzSXIxKbXOJLQB3ixTQOJRkDt4
TlqAQ/ypHgQId54dysPIXCpeq/TkLninuctMa3WE1ytkO7fjHn0xp07xWSsvAKul
g2/1cZEu/itDACLoAGMjtmCpZrOaR3901Od3SmKMCDSYRFBvUKAQzuh9vW9P0Pz4
sYwusC/izNeanTuGUz9p2XKHb9B9fNPcyoDLzklJkPzTDuU4ClvuL2aT9qhFAALm
TKyLlLED2UxqAt3XtkzC3UAL8gHf0hv0cmaLlhOUpoqScQTa6lCKT4+D10y5yFv9
MoVK8POUMezAudfzhGneRcNJYRQHaIHAztSgPKitXONX2ve4ITue/AoRGx6X/OPJ
THg3QZO6VqUJGiSv4q7Tlo0dNK659CuGO6jmASqmpjv2BfbivbIi1jllurns7GV7
ldy8ZznbKCx65cni5r6OKybdbUwHkd1Jvb6gOHYrFuQ6l4iJo3edRLyP4RQGO0hA
O30CQlCuXIA0MO9/XI3y0gLNFRFvb3QBCwqFzJVTGEGyoiJcYlI=
=UCwu
-----END PGP SIGNATURE-----

--auttkguxzhd5q6k7--

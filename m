Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273652F8E97
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAPSKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 13:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAPSKG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Jan 2021 13:10:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6433922DBF;
        Sat, 16 Jan 2021 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610809455;
        bh=b07lwLAQD1OJQprPbI2xSjAn/WmejmRmegi5Xr2ZiFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcgSRdE7vJG48PYcjIqtVUT36kwmsCnvPVsvR9untI2vzkxZB84wtOyRCbk2Q/71/
         RfwWJ8GtxnOqw40Ufg23qVR5E4T8zPzV0oLh2hlfWl5aTVnnmKN2QGz+DfemiT8iTO
         kIVOkGeepdbOi9jGvFK27K7ef5SySLaehn7Mwjw4H87Znrp8+2xL9txK+r1u7uBiTn
         aJ0GpjBnbhXLD1wkdSePczJ7lQ4x778yKJoWHWOiC2tB9jSXTO4KtC3IPFdXuMODhl
         zKhINqfKHfJ+O27m05IBSTY1TemHlN35m1u+Z1e5G9MikgA9ZNBefbKQKyZgf+N/iA
         /USdY4b5q/4aw==
Received: by earth.universe (Postfix, from userid 1000)
        id 6D2E73C0C94; Sat, 16 Jan 2021 16:04:13 +0100 (CET)
Date:   Sat, 16 Jan 2021 16:04:13 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Marek Czerski <ma.czerski@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: ltc2952: make trigger delay configurable
Message-ID: <20210116150413.gqsodziwjv6g6bvd@earth.universe>
References: <20201207222829.13676-1-ma.czerski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e2hmrl2yurqucwco"
Content-Disposition: inline
In-Reply-To: <20201207222829.13676-1-ma.czerski@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e2hmrl2yurqucwco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 07, 2020 at 11:28:29PM +0100, Marek Czerski wrote:
> Make trigger delay configurable through device tree with
> trigger-delay-ms property.
>=20
> Trigger delay is the time to wait before starting shutdown
> sequence after trigger line assertion.
> Trigger delay must take into account the OFFT time configured
> with the capacitor connected to OFFT pin of the LTC2952 chip.
> Basically, the higher the capacitance connected to OFFT pin,
> the larger trigger delay must be.
>=20
> Signed-off-by: Marek Czerski <ma.czerski@gmail.com>
> ---
>  .../devicetree/bindings/power/reset/ltc2952-poweroff.txt  | 4 ++++
>  drivers/power/reset/ltc2952-poweroff.c                    | 8 ++++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-powero=
ff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
> index cd2d7f58a..881f15a78 100644
> --- a/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt

Please additionally Cc DT binding maintainer:

OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
M:	Rob Herring <robh+dt@kernel.org>
L:	devicetree@vger.kernel.org

> @@ -17,6 +17,9 @@ Optional properties:
>  			chip's trigger line. If this property is not set, the
>  			trigger function is ignored and the chip is kept alive
>  			until an explicit kill signal is received
> +- trigger-delay-ms	The number of milliseconds to wait after trigger line
> +			assertion before executing shut down procedure.
> +			The default is 2500ms.
> =20
>  Example:
> =20
> @@ -24,6 +27,7 @@ ltc2952 {
>  	compatible =3D "lltc,ltc2952";
> =20
>  	trigger-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
> +        trigger-delay-ms =3D <2000>;

please use tab instead of spaces

>  	watchdog-gpios =3D <&gpio1 2 GPIO_ACTIVE_HIGH>;
>  	kill-gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
>  };
> diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset=
/ltc2952-poweroff.c
> index 318927938..243811541 100644
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -55,6 +55,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/reboot.h>
> +#include <linux/of.h>
> =20
>  struct ltc2952_poweroff {
>  	struct hrtimer timer_trigger;
> @@ -172,10 +173,17 @@ static void ltc2952_poweroff_default(struct ltc2952=
_poweroff *data)
>  static int ltc2952_poweroff_init(struct platform_device *pdev)
>  {
>  	int ret;
> +	u32 trigger_delay_ms;
>  	struct ltc2952_poweroff *data =3D platform_get_drvdata(pdev);
> =20
>  	ltc2952_poweroff_default(data);
> =20
> +	if (!of_property_read_u32(pdev->dev.of_node, "trigger-delay-ms",
> +				  &trigger_delay_ms)) {

please use device_property_read_u32() from <linux/property.h>.

> +		data->trigger_delay =3D ktime_set(trigger_delay_ms / MSEC_PER_SEC,
> +			(trigger_delay_ms % MSEC_PER_SEC) * NSEC_PER_MSEC);
> +	}
> +
>  	data->gpio_watchdog =3D devm_gpiod_get(&pdev->dev, "watchdog",
>  					     GPIOD_OUT_LOW);
>  	if (IS_ERR(data->gpio_watchdog)) {

Thanks and sorry for delayed response,

-- Sebastian

--e2hmrl2yurqucwco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmADAG0ACgkQ2O7X88g7
+pouRg//XUlGkUbYoKKhWpKuAUENJk15apzYkpcnfHqTUvZV6Z6cEKxUfbJ0JSR/
fMLLidPz+pRZFv/VSnY7hk5aKwxwElRbjZ0PXRdr/72GqBbFX8eCifPkjHUY0cfL
OZ9G9SpN1Ldtvxp1H5q18Uf1S0CdOMFkbscdc4yMsWZKj6RfyIPJ+DIFN+MJhWVr
ucpiuSw9Gjf7zr7DQSHNUO8ujsF2wZxjA0m9UqtE2N5IJ7oULMKVvxtOtjLr2WR+
HuGvL472+3F/V19xctv5fceOhk7/hI6owc24M3iduoQfmIkXIiRediCx5pRjzSMq
l9ir4euSrrDSF8d7MaMyf8K6UXFSfjB07ev8mR7PpkIV4bnxv7hMwLlmSHFw+mNc
MAvP2iYFwLBLSyk0VSiILyCuGWjQFQgL1Kgz7iV/QF+uhMmK+MPMccJnNZriuaxb
sr3OU0dRNGSSmQchtH0HE3Ulmqg5BSdOBPNBjSi6vq/uEjwCzGaVkhtAO/0shZyv
L4qiuTzjooJYp0iuRrKQyG+K/641ItkQHMjN+DJfEYGgVq3440n9+4JyFKS/ZOFL
b4P1RyZskfRMCmlO4mBscEwkJ+h8FNu+tEG3T/MlRpTA3iNeS5xbALMWe4AojDl/
qY+B6Oe3pR1ky/Yep/Vhd3aIsFI6m1xhlwJNNVmZm/GyLEUZACg=
=8gbA
-----END PGP SIGNATURE-----

--e2hmrl2yurqucwco--

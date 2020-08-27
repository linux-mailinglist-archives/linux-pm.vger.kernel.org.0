Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F79254A10
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgH0P6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 11:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0P6V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Aug 2020 11:58:21 -0400
Received: from earth.universe (dyndsl-037-138-189-082.ewe-ip-backbone.de [37.138.189.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C8B2177B;
        Thu, 27 Aug 2020 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598543900;
        bh=YVJjPoepbQiHuw3Q5nO5r70MLvM9LFYq1jHiQ4ooBgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWl5dQauyst4N+isX4tuvH8fmb4v23nn19MmpKZNtOp1H5ZAifjxtKQ5hqWE0c4kA
         4gaVNIGN+PWWNVJTshI0BP6/Xe31Y3oFMNDFwyzcX/tw/eS+FT9bjxr8lfHbdJWVX1
         7lUwESJVaz/IRAdF6gUoDEBGjkLQp35N7UZSLkpE=
Received: by earth.universe (Postfix, from userid 1000)
        id A71F13C0C82; Thu, 27 Aug 2020 17:58:18 +0200 (CEST)
Date:   Thu, 27 Aug 2020 17:58:18 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2] power: supply: gpio-charger: Convert to GPIO
 descriptors
Message-ID: <20200827155818.5windxwjnhbaqism@earth.universe>
References: <20200827084828.190841-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6t6iikw3q7qs4u4b"
Content-Disposition: inline
In-Reply-To: <20200827084828.190841-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6t6iikw3q7qs4u4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 27, 2020 at 10:48:28AM +0200, Linus Walleij wrote:
> This converts the GPIO charger to use exclusively GPIO
> descriptors, moving the two remaining platforms passing
> global GPIO numbers over to using a GPIO descriptor table.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> ChangeLog v1->v2:
> - Rebased on v5.9-rc1
> ---

Thanks Linus, I queued the patch into power-supply's for-next branch
after neither my patchset from June (with the same change), nor your
patch from a few weeks ago triggered any feedback from the ARM
maintainers.

If a conflict in linux-next is detected ARM tree can merge the
following:

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/psy-arm-gpio-charger-immutable-for-5.10-signed

for you to fetch changes up to 17529bcf0ae20f1ac6d7846762bf0c6ad91dbb7f:

  power: supply: gpio-charger: Convert to GPIO descriptors (2020-08-27 16:4=
7:14 +0200)

----------------------------------------------------------------
Immutable branch between arm and power-supply for gpio-charger for 5.10

This immutable branch drops legacy gpio API from
gpio-charger and updates the remaining users to
the new gpiod API instead.

Signed-off-by: Sebastian Reichel <sre@kernel.org>

----------------------------------------------------------------
Linus Walleij (1):
      power: supply: gpio-charger: Convert to GPIO descriptors

 arch/arm/mach-pxa/tosa.c            | 12 ++++++++++--
 arch/arm/mach-sa1100/collie.c       | 14 ++++++++++++--
 drivers/power/supply/gpio-charger.c | 26 +-------------------------
 include/linux/power/gpio-charger.h  |  6 ------
 4 files changed, 23 insertions(+), 35 deletions(-)

-- Sebastian

>  arch/arm/mach-pxa/tosa.c            | 12 ++++++++++--
>  arch/arm/mach-sa1100/collie.c       | 14 ++++++++++++--
>  drivers/power/supply/gpio-charger.c | 26 +-------------------------
>  include/linux/power/gpio-charger.h  |  6 ------
>  4 files changed, 23 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
> index 3d2c108e911e..431709725d02 100644
> --- a/arch/arm/mach-pxa/tosa.c
> +++ b/arch/arm/mach-pxa/tosa.c
> @@ -369,6 +369,15 @@ static struct pxaficp_platform_data tosa_ficp_platfo=
rm_data =3D {
>  /*
>   * Tosa AC IN
>   */
> +static struct gpiod_lookup_table tosa_power_gpiod_table =3D {
> +	.dev_id =3D "gpio-charger",
> +	.table =3D {
> +		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_AC_IN,
> +			    NULL, GPIO_ACTIVE_LOW),
> +		{ },
> +	},
> +};
> +
>  static char *tosa_ac_supplied_to[] =3D {
>  	"main-battery",
>  	"backup-battery",
> @@ -378,8 +387,6 @@ static char *tosa_ac_supplied_to[] =3D {
>  static struct gpio_charger_platform_data tosa_power_data =3D {
>  	.name			=3D "charger",
>  	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> -	.gpio			=3D TOSA_GPIO_AC_IN,
> -	.gpio_active_low	=3D 1,
>  	.supplied_to		=3D tosa_ac_supplied_to,
>  	.num_supplicants	=3D ARRAY_SIZE(tosa_ac_supplied_to),
>  };
> @@ -951,6 +958,7 @@ static void __init tosa_init(void)
>  	clk_add_alias("CLK_CK3P6MI", tc6393xb_device.name, "GPIO11_CLK", NULL);
> =20
>  	gpiod_add_lookup_table(&tosa_udc_gpiod_table);
> +	gpiod_add_lookup_table(&tosa_power_gpiod_table);
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
> =20
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index 3cc2b71e16f0..bd3a52fd09ce 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -30,6 +30,7 @@
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/power/gpio-charger.h>
> =20
>  #include <video/sa1100fb.h>
> @@ -131,16 +132,23 @@ static struct irda_platform_data collie_ir_data =3D=
 {
>  /*
>   * Collie AC IN
>   */
> +static struct gpiod_lookup_table collie_power_gpiod_table =3D {
> +	.dev_id =3D "gpio-charger",
> +	.table =3D {
> +		GPIO_LOOKUP("gpio", COLLIE_GPIO_AC_IN,
> +			    NULL, GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  static char *collie_ac_supplied_to[] =3D {
>  	"main-battery",
>  	"backup-battery",
>  };
> =20
> -
>  static struct gpio_charger_platform_data collie_power_data =3D {
>  	.name			=3D "charger",
>  	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> -	.gpio			=3D COLLIE_GPIO_AC_IN,
>  	.supplied_to		=3D collie_ac_supplied_to,
>  	.num_supplicants	=3D ARRAY_SIZE(collie_ac_supplied_to),
>  };
> @@ -386,6 +394,8 @@ static void __init collie_init(void)
> =20
>  	platform_scoop_config =3D &collie_pcmcia_config;
> =20
> +	gpiod_add_lookup_table(&collie_power_gpiod_table);
> +
>  	ret =3D platform_add_devices(devices, ARRAY_SIZE(devices));
>  	if (ret) {
>  		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/g=
pio-charger.c
> index 875735d50716..ae778f110101 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -5,7 +5,6 @@
>   */
> =20
>  #include <linux/device.h>
> -#include <linux/gpio.h> /* For legacy platform data */
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -131,7 +130,6 @@ static int gpio_charger_probe(struct platform_device =
*pdev)
>  	struct power_supply_desc *charger_desc;
>  	struct gpio_desc *charge_status;
>  	int charge_status_irq;
> -	unsigned long flags;
>  	int ret;
>  	int num_props =3D 0;
> =20
> @@ -149,29 +147,7 @@ static int gpio_charger_probe(struct platform_device=
 *pdev)
>  	 * boardfile descriptor tables. It's good to try this first.
>  	 */
>  	gpio_charger->gpiod =3D devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> -
> -	/*
> -	 * Fallback to legacy platform data method, if no GPIO is specified
> -	 * using boardfile descriptor tables.
> -	 */
> -	if (!gpio_charger->gpiod && pdata) {
> -		/* Non-DT: use legacy GPIO numbers */
> -		if (!gpio_is_valid(pdata->gpio)) {
> -			dev_err(dev, "Invalid gpio pin in pdata\n");
> -			return -EINVAL;
> -		}
> -		flags =3D GPIOF_IN;
> -		if (pdata->gpio_active_low)
> -			flags |=3D GPIOF_ACTIVE_LOW;
> -		ret =3D devm_gpio_request_one(dev, pdata->gpio, flags,
> -					    dev_name(dev));
> -		if (ret) {
> -			dev_err(dev, "Failed to request gpio pin: %d\n", ret);
> -			return ret;
> -		}
> -		/* Then convert this to gpiod for now */
> -		gpio_charger->gpiod =3D gpio_to_desc(pdata->gpio);
> -	} else if (IS_ERR(gpio_charger->gpiod)) {
> +	if (IS_ERR(gpio_charger->gpiod)) {
>  		/* Just try again if this happens */
>  		if (PTR_ERR(gpio_charger->gpiod) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> diff --git a/include/linux/power/gpio-charger.h b/include/linux/power/gpi=
o-charger.h
> index 5a5a8de98181..c0b7657ac1df 100644
> --- a/include/linux/power/gpio-charger.h
> +++ b/include/linux/power/gpio-charger.h
> @@ -13,18 +13,12 @@
>   * struct gpio_charger_platform_data - platform_data for gpio_charger de=
vices
>   * @name:		Name for the chargers power_supply device
>   * @type:		Type of the charger
> - * @gpio:		GPIO which is used to indicate the chargers status
> - * @gpio_active_low:	Should be set to 1 if the GPIO is active low otherw=
ise 0
>   * @supplied_to:	Array of battery names to which this chargers supplies =
power
>   * @num_supplicants:	Number of entries in the supplied_to array
>   */
>  struct gpio_charger_platform_data {
>  	const char *name;
>  	enum power_supply_type type;
> -
> -	int gpio;
> -	int gpio_active_low;
> -
>  	char **supplied_to;
>  	size_t num_supplicants;
>  };
> --=20
> 2.26.2
>=20

--6t6iikw3q7qs4u4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9H1/cACgkQ2O7X88g7
+prKXA//SHVYm7JOOv0d8WB4BBZc2xvWpwJUgzJUDfhCbLN3Jf3iYeAYQHZRf9aX
blYnQIYirPKPXiAbcvDuZgs6Z1GtRzJ3BKUz8YXOpnVbLyobkHPI4MEwYiM52Ecs
w75l6RejigTTuVuBlelksfSRCH88YQ9PGb3HfsQQ3Maepiiu67er+6V5YShPiYZE
tlHO4Sg2Om2YhbDv94KUPSZhf27AA1OsOErRJxYH2DXMp+7adSSnX8d+jaNX1rSj
hi1k6nyYK3fsK+aFPvh3MGyEeNz81MnFU/b8x2A+Y1Z7cgnsFDxVa/I0w6cluw+Z
04Rw7Ountkmyx/hq3Q8ScedtDQ0zfGAzXWxrDCbdLDQjoHz3nam7D3LpYK3GqjCm
v251yitzUuybSbHjgJp1+zsJIwwQ24h2P5/GpwjewYgaOpbsVcz1TZO0Pn2qICaD
nFOSlWezi1UIfNBR5kuuEizV9rsOsVOEc8LWqhD8wU9t2cSjXIbgRh+0odMVmzuI
iGnaLdGgtbgSCjhpsmqO8IiDrk0rAGa2l51JmT+Op9IJt9llAWlp9TZvHtVH5Vvd
pwCnGcHCa0W2Ts999Jqj1egy+SIWnRnYPhxBZXRIP7rbCiUc9aRNRFAoiEAkiYMQ
/kLZk2ACZcx/pLgPcmNNkZfRXKG8IlZ/FxcAegDCDeK7ivlyMx4=
=OGlU
-----END PGP SIGNATURE-----

--6t6iikw3q7qs4u4b--

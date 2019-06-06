Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD337702
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfFFOm7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 10:42:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbfFFOm6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 10:42:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3547CAF85;
        Thu,  6 Jun 2019 14:42:55 +0000 (UTC)
Message-ID: <98084e7c78b1a280345616f4ced6cd6511ae96f1.camel@suse.de>
Subject: Re: [PATCH v2 2/7] clk: bcm283x: add driver interfacing with
 Raspberry Pi's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org
Date:   Thu, 06 Jun 2019 16:42:53 +0200
In-Reply-To: <20190606142255.29454-3-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
         <20190606142255.29454-3-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/MqWYVsa7WbiCtFCPQxf"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-/MqWYVsa7WbiCtFCPQxf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-06 at 16:22 +0200, Nicolas Saenz Julienne wrote:
> Raspberry Pi's firmware offers an interface though which update it's
> clock's frequencies. This is specially useful in order to change the CPU
> clock (pllb_arm) which is 'owned' by the firmware and we're unable to
> scale using the register interface provided by clk-bcm2835.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
>=20
> ---
>=20
> Changes since v1:
>   - Use BIT()
>   - Add Kconfig entry, with compile test
>   - remove prepare/unprepare
>   - Fix uninitialized init.name in pllb registration
>   - Add MODULE_ALIAS()
>   - Use determine_rate() instead of round_rate()
>   - Add small introduction explaining need for driver
>=20
>  drivers/clk/bcm/Kconfig           |   7 +
>  drivers/clk/bcm/Makefile          |   1 +
>  drivers/clk/bcm/clk-raspberrypi.c | 302 ++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
>  create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
>=20
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 29ee7b776cd4..a4a2775d65e1 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -64,3 +64,10 @@ config CLK_BCM_SR
>  	default ARCH_BCM_IPROC
>  	help
>  	  Enable common clock framework support for the Broadcom Stingray SoC
> +
> +config CLK_RASPBERRYPI
> +	tristate "Raspberry Pi firmware based clock support"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST &&
> !RASPBERRYPI_FIRMWARE)
> +	help
> +	  Enable common clock framework support for Raspberry Pi's firmware
> +	  dependent clocks
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index 002661d39128..eb7159099d82 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_BCM_KONA)	+=3D clk-bcm21664.o
>  obj-$(CONFIG_COMMON_CLK_IPROC)	+=3D clk-iproc-armpll.o clk-iproc-pll.o
> clk-iproc-asiu.o
>  obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-bcm2835-aux.o
> +obj-$(CONFIG_CLK_RASPBERRYPI)	+=3D clk-raspberrypi.o
>  obj-$(CONFIG_ARCH_BCM_53573)	+=3D clk-bcm53573-ilp.o
>  obj-$(CONFIG_CLK_BCM_CYGNUS)	+=3D clk-cygnus.o
>  obj-$(CONFIG_CLK_BCM_HR2)	+=3D clk-hr2.o
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> raspberrypi.c
> new file mode 100644
> index 000000000000..b1365cf19f3a
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Raspberry Pi driver for firmware controlled clocks
> + *
> + * Even though clk-bcm2835 provides an interface to the harware register=
s for
> + * the system clocks we've had to factor out 'pllb' as the firmware 'own=
s'
> it.
> + * We're not allowed to change it directly as we might race with the
> + * over-temperature and under-voltage protections provided by the firmwa=
re.
> + *
> + * Copyright (C) 2019 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_FIRMWARE_ARM_CLK_ID		0x000000003
> +
> +#define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
> +#define RPI_FIRMWARE_STATE_WAIT_BIT	BIT(1)
> +
> +/*
> + * Even though the firmware interface alters 'pllb' the frequencies are
> + * provided as per 'pllb_arm'. We need to scale before passing them trou=
gh.
> + */
> +#define RPI_FIRMWARE_PLLB_ARM_DIV_RATE	2
> +
> +#define A2W_PLL_FRAC_BITS		20
> +
> +struct raspberrypi_clk {
> +	struct device *dev;
> +	struct rpi_firmware *firmware;
> +
> +	unsigned long min_rate;
> +	unsigned long max_rate;
> +
> +	struct clk_hw pllb;
> +	struct clk_hw *pllb_arm;
> +	struct clk_lookup *pllb_arm_lookup;
> +};
> +
> +/*
> + * Structure of the message passed to Raspberry Pi's firmware in order t=
o
> + * change clock rates. The 'disable_turbo' option is only available to t=
he
> ARM
> + * clock (pllb) which we enable by default as turbo mode will alter mult=
iple
> + * clocks at once.
> + *
> + * Even though we're able to access the clock registers directly we're b=
ound
> to
> + * use the firmware interface as the firmware ultimately takes care of
> + * mitigating overheating/undervoltage situations and we would be changi=
ng
> + * frequencies behind his back.
> + *
> + * For more information on the firmware interface check:
> + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interfa=
ce
> + */
> +struct raspberrypi_firmware_prop {
> +	__le32 id;
> +	__le32 val;
> +	__le32 disable_turbo;
> +} __packed;
> +
> +static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32=
 tag,
> +				      u32 clk, u32 *val)
> +{
> +	struct raspberrypi_firmware_prop msg =3D {
> +		.id =3D clk,
> +		.val =3D *val,
> +		.disable_turbo =3D 1,
> +	};
> +	int ret;
> +
> +	ret =3D rpi_firmware_property(firmware, tag, &msg, sizeof(msg));
> +	if (ret)
> +		return ret;
> +
> +	*val =3D msg.val;
> +
> +	return 0;
> +}
> +
> +static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
> +{
> +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_clk=
,
> +						   pllb);
> +	u32 val =3D 0;
> +	int ret;
> +
> +	ret =3D raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_CLOCK_STATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID, &val);
> +	if (ret)
> +		return 0;
> +
> +	return !!(val & RPI_FIRMWARE_STATE_ENABLE_BIT);
> +}
> +
> +
> +static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
> +						 unsigned long parent_rate)
> +{
> +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_clk=
,
> +						   pllb);
> +	u32 val =3D 0;
> +	int ret;
> +
> +	ret =3D raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &val);
> +	if (ret)
> +		return ret;
> +
> +	return val * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +}
> +
> +static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long =
rate,
> +				       unsigned long parent_rate)
> +{
> +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_clk=
,
> +						   pllb);
> +	u32 new_rate =3D rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +	int ret;
> +
> +	ret =3D raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_SET_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &new_rate);
> +	if (ret)
> +		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency:
> %d",
> +				    clk_hw_get_name(hw), ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Sadly there is no firmware rate rounding interface. We borrowed it fr=
om
> + * clk-bcm2835.
> + */
> +static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
> +				           struct clk_rate_request *req)
> +{
> +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_clk=
,
> +						   pllb);
> +	u64 div, final_rate;
> +	u32 ndiv, fdiv;
> +
> +	/* We can't use req->rate directly as it would overflow */
> +	final_rate =3D clamp(req->rate, rpi->min_rate, rpi->max_rate);
> +
> +	div =3D (u64)final_rate << A2W_PLL_FRAC_BITS;
> +	do_div(div, req->best_parent_rate);
> +
> +	ndiv =3D div >> A2W_PLL_FRAC_BITS;
> +	fdiv =3D div & ((1 << A2W_PLL_FRAC_BITS) - 1);
> +
> +	final_rate =3D ((u64)req->best_parent_rate *
> +					((ndiv << A2W_PLL_FRAC_BITS) + fdiv));
> +
> +	req->rate =3D final_rate >> A2W_PLL_FRAC_BITS;
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops raspberrypi_firmware_pll_clk_ops =3D {
> +	.is_prepared =3D raspberrypi_fw_pll_is_on,
> +	.recalc_rate =3D raspberrypi_fw_pll_get_rate,
> +	.set_rate =3D raspberrypi_fw_pll_set_rate,
> +	.determine_rate =3D raspberrypi_pll_determine_rate,
> +};
> +
> +static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
> +{
> +	u32 min_rate =3D 0, max_rate =3D 0;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	memset(&init, 0, sizeof(init));
> +
> +	/* All of the PLLs derive from the external oscillator. */
> +	init.parent_names =3D (const char *[]){ "osc" };
> +	init.num_parents =3D 1;
> +	init.name =3D "pllb";
> +	init.ops =3D &raspberrypi_firmware_pll_clk_ops;
> +	init.flags =3D CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
> +
> +	/* Get min & max rates set by the firmware */
> +	ret =3D raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &min_rate);
> +	if (ret) {
> +		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
> +			init.name, ret);
> +		return ret;
> +	}
> +
> +	ret =3D raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &max_rate);
> +	if (ret) {
> +		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
> +			init.name, ret);
> +		return ret;
> +	}
> +
> +	if (!min_rate || !max_rate) {
> +		dev_err(rpi->dev, "Unexpected frequency range: min %u, max
> %u\n",
> +			min_rate, max_rate);
> +		return -EINVAL;
> +	}
> +
> +	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
> +		 min_rate, max_rate);
> +
> +	rpi->min_rate =3D min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +	rpi->max_rate =3D max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +
> +	rpi->pllb.init =3D &init;
> +
> +	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
> +}
> +
> +static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
> +{
> +	rpi->pllb_arm =3D clk_hw_register_fixed_factor(rpi->dev,
> +				"pllb_arm", "pllb",
> +				CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> +				1, 2);
> +	if (IS_ERR(rpi->pllb_arm)) {
> +		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
> +		return PTR_ERR(rpi->pllb_arm);
> +	}
> +
> +	rpi->pllb_arm_lookup =3D clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
> +	if (!rpi->pllb_arm_lookup) {
> +		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
> +		clk_hw_unregister_fixed_factor(rpi->pllb_arm);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int raspberrypi_clk_probe(struct platform_device *pdev)
> +{
> +	struct device_node *firmware_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct rpi_firmware *firmware;
> +	struct raspberrypi_clk *rpi;
> +	int ret;
> +
> +	firmware_node =3D of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (!firmware_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	firmware =3D rpi_firmware_get(firmware_node);
> +	of_node_put(firmware_node);
> +	if (!firmware)
> +		return -EPROBE_DEFER;
> +
> +	rpi =3D devm_kzalloc(dev, sizeof(*rpi), GFP_KERNEL);
> +	if (!rpi)
> +		return -ENOMEM;
> +
> +	rpi->dev =3D dev;
> +	rpi->firmware =3D firmware;
> +
> +	ret =3D raspberrypi_register_pllb(rpi);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize pllb, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D raspberrypi_register_pllb_arm(rpi);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize pllb_arm, %d\n", ret);

Sorry Stefan, I missed removing this message. It's done for the next revisi=
on.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver raspberrypi_clk_driver =3D {
> +	.driver =3D {
> +		.name =3D "raspberrypi-clk",
> +	},
> +	.probe          =3D raspberrypi_clk_probe,
> +};
> +module_platform_driver(raspberrypi_clk_driver);
> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
> +MODULE_DESCRIPTION("Raspberry Pi firmware clock driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:raspberrypi-clk");


--=-/MqWYVsa7WbiCtFCPQxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz5Jm0ACgkQlfZmHno8
x/5yuAgAiFX8VMXzZXqx7lOltR1Qd2Lo1Gii37FKW68dmuP103//STyNOjugRAnL
6zZty+RiSkCp53ub/Mdj42Vb2UqfFfGtUqnGpspQxAlGechaqOARe6puMxjDGRBa
HQCWjd0Ku9z89VpthU6ry8DFEQhGTjenUE5VUht+qUyA8aieG5aeILiORnsqVIZX
yEBAOS4fE5Rr+zlhx6CALCWBa2Ka4P9DTa+AKBKmH+A4DryLQdxq/w6Z4NxHbxz7
Sljs64LsSJg7BuSNOol4casJXRoiZGh3/27MJz+3Wh3ACiakgiJEAMZhcQ7/TXZP
6FIaqjtohl/1/6Ove5s2U4oMEijBOA==
=XOb2
-----END PGP SIGNATURE-----

--=-/MqWYVsa7WbiCtFCPQxf--


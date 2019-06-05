Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEB835CA9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfFEMX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 08:23:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbfFEMX1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 08:23:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECA9FAEF8;
        Wed,  5 Jun 2019 12:23:24 +0000 (UTC)
Message-ID: <3455ad811500486a9144bb45a0e0933c533e5b66.camel@suse.de>
Subject: Re: [PATCH 2/4] clk: bcm283x: add driver interfacing with Raspberry
 Pi's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, mbrugger@suse.de,
        eric@anholt.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ssuloev@orpaltech.com
Date:   Wed, 05 Jun 2019 14:23:22 +0200
In-Reply-To: <7ff78cd1-3c39-925d-c66c-f7f295fe6d6e@gmx.net>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
         <20190604173223.4229-3-nsaenzjulienne@suse.de>
         <7ff78cd1-3c39-925d-c66c-f7f295fe6d6e@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CaIs5UzJsQf89/5WfJE7"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-CaIs5UzJsQf89/5WfJE7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,
thanks for your review.

On Wed, 2019-06-05 at 12:44 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
> > Raspberry Pi's firmware offers and interface though which update it's
> > clock's frequencies. This is specially useful in order to change the CP=
U
> > clock (pllb_arm) which is 'owned' by the firmware and we're unable to
> > scale using the register interface.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes since RFC:
> >   - Moved firmware interface into own driver
> >   - Use of_find_compatible_node()
> >   - Remove error message on rpi_firmware_get() failure
> >   - Ratelimit messages on set_rate() failure
> >   - Use __le32 on firmware interface definition
> >=20
> >  drivers/clk/bcm/Makefile          |   1 +
> >  drivers/clk/bcm/clk-raspberrypi.c | 316 ++++++++++++++++++++++++++++++
> >  2 files changed, 317 insertions(+)
> >  create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
> >=20
> > diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> > index 002661d39128..07abe92df9d1 100644
> > --- a/drivers/clk/bcm/Makefile
> > +++ b/drivers/clk/bcm/Makefile
> > @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_BCM_KONA)	+=3D clk-bcm21664.o
> >  obj-$(CONFIG_COMMON_CLK_IPROC)	+=3D clk-iproc-armpll.o clk-iproc-pll.o
> > clk-iproc-asiu.o
> >  obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-bcm2835.o
> >  obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-bcm2835-aux.o
> > +obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-raspberrypi.o
> Hm, on the one side it would be nice to avoid building this driver in
> case the firmware driver is disabled on the other side it would be good
> to keep compile test.
> >  obj-$(CONFIG_ARCH_BCM_53573)	+=3D clk-bcm53573-ilp.o
> >  obj-$(CONFIG_CLK_BCM_CYGNUS)	+=3D clk-cygnus.o
> >  obj-$(CONFIG_CLK_BCM_HR2)	+=3D clk-hr2.o
> > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> > raspberrypi.c
> > new file mode 100644
> > index 000000000000..485c00288414
> > --- /dev/null
> > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > @@ -0,0 +1,316 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2019 Nicolas Saenz Julienne
> > + */
> > +
> > +#include <linux/clkdev.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > +
> > +#define RPI_FIRMWARE_ARM_CLK_ID		0x000000003
> > +
> > +#define RPI_FIRMWARE_STATE_ENABLE_BIT	0x1
> > +#define RPI_FIRMWARE_STATE_WAIT_BIT	0x2
> how about using the BIT() macro?
> > +
> > +/*
> > + * Even though the firmware interface alters 'pllb' the frequencies ar=
e
> > + * provided as per 'pllb_arm'. We need to scale before passing them tr=
ough.
> > + */
> > +#define RPI_FIRMWARE_PLLB_ARM_DIV_RATE	2
> > +
> > +#define A2W_PLL_FRAC_BITS		20
> > +
> > +struct raspberrypi_clk {
> > +	struct device *dev;
> > +	struct rpi_firmware *firmware;
> > +
> > +	unsigned long min_rate;
> > +	unsigned long max_rate;
> > +
> > +	struct clk_hw pllb;
> > +	struct clk_hw *pllb_arm;
> > +	struct clk_lookup *pllb_arm_lookup;
> > +};
> > +
> > +/*
> > + * Structure of the message passed to Raspberry Pi's firmware in order=
 to
> > + * change clock rates. The 'disable_turbo' option is only available to=
 the
> > ARM
> > + * clock (pllb) which we enable by default as turbo mode will alter
> > multiple
> > + * clocks at once.
> > + *
> > + * Even though we're able to access the clock registers directly we're
> > bound to
> > + * use the firmware interface as the firmware ultimately takes care of
> > + * mitigating overheating/undervoltage situations and we would be chan=
ging
> > + * frequencies behind his back.
> > + *
> > + * For more information on the firmware interface check:
> > + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-inter=
face
> > + */
> > +struct raspberrypi_firmware_prop {
> > +	__le32 id;
> > +	__le32 val;
> > +	__le32 disable_turbo;
> > +} __packed;
> > +
> > +static int raspberrypi_clock_property(struct rpi_firmware *firmware, u=
32
> > tag,
> > +				      u32 clk, u32 *val)
> > +{
> > +	struct raspberrypi_firmware_prop msg =3D {
> > +		.id =3D clk,
> > +		.val =3D *val,
> > +		.disable_turbo =3D 1,
> > +	};
> > +	int ret;
> > +
> > +	ret =3D rpi_firmware_property(firmware, tag, &msg, sizeof(msg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val =3D msg.val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
> > +{
> > +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > +						   pllb);
> > +	u32 val =3D 0;
> > +	int ret;
> > +
> > +	ret =3D raspberrypi_clock_property(rpi->firmware,
> > +					 RPI_FIRMWARE_GET_CLOCK_STATE,
> > +					 RPI_FIRMWARE_ARM_CLK_ID, &val);
> > +	if (ret)
> > +		return 0;
> > +
> > +	return !!(val & RPI_FIRMWARE_STATE_ENABLE_BIT);
> > +}
> > +
> > +
> > +static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
> > +						 unsigned long parent_rate)
> > +{
> > +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > +						   pllb);
> > +	u32 val =3D 0;
> > +	int ret;
> > +
> > +	ret =3D raspberrypi_clock_property(rpi->firmware,
> > +					 RPI_FIRMWARE_GET_CLOCK_RATE,
> > +					 RPI_FIRMWARE_ARM_CLK_ID,
> > +					 &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return val * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> > +}
> > +
> > +static int raspberrypi_fw_pll_on(struct clk_hw *hw)
> > +{
> > +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > +						   pllb);
> > +	u32 val;
> > +	int ret;
> > +
> > +	val =3D RPI_FIRMWARE_STATE_ENABLE_BIT | RPI_FIRMWARE_STATE_WAIT_BIT;
> > +
> > +	ret =3D raspberrypi_clock_property(rpi->firmware,
> > +					 RPI_FIRMWARE_SET_CLOCK_STATE,
> > +					 RPI_FIRMWARE_ARM_CLK_ID, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> return ret;
> > +}
> > +
> > +static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned lon=
g
> > rate,
> > +				       unsigned long parent_rate)
> > +{
> > +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > +						   pllb);
> > +	u32 new_rate =3D rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> > +	int ret;
> > +
> > +	ret =3D raspberrypi_clock_property(rpi->firmware,
> > +					 RPI_FIRMWARE_SET_CLOCK_RATE,
> > +					 RPI_FIRMWARE_ARM_CLK_ID,
> > +					 &new_rate);
> > +	if (ret)
> > +		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency:
> > %d",
> > +				    clk_hw_get_name(hw), ret);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Sadly there is no firmware rate rounding interface. We borred it fr=
om
> borrowed?

Yes

> > + * clk-bcm2835.
> > + */
> > +static long raspberrypi_pll_round_rate(struct clk_hw *hw, unsigned lon=
g
> > rate,
> > +				       unsigned long *parent_rate)
> > +{
> > +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > +						   pllb);
> > +	u64 div, final_rate;
> > +	u32 ndiv, fdiv;
> > +
> > +	rate =3D clamp(rate, rpi->min_rate, rpi->max_rate);
> > +
> > +	div =3D (u64)rate << A2W_PLL_FRAC_BITS;
> > +	do_div(div, *parent_rate);
> > +
> > +	ndiv =3D div >> A2W_PLL_FRAC_BITS;
> > +	fdiv =3D div & ((1 << A2W_PLL_FRAC_BITS) - 1);
> > +
> > +	/* We can't use rate directly as it would overflow */
> > +	final_rate =3D ((u64)*parent_rate * ((ndiv << A2W_PLL_FRAC_BITS) + fd=
iv));
> > +
> > +	return final_rate >> A2W_PLL_FRAC_BITS;
> > +}
> > +
> > +static void raspberrypi_fw_pll_off(struct clk_hw *hw)
> > +{
> > +	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_c=
lk,
> > +						   pllb);
> > +	u32 val =3D RPI_FIRMWARE_STATE_WAIT_BIT;
> > +
> > +	raspberrypi_clock_property(rpi->firmware,
> > +				   RPI_FIRMWARE_SET_CLOCK_STATE,
> > +				   RPI_FIRMWARE_ARM_CLK_ID, &val);
> > +}
> I'm not sure. Does this operation really make sense?

You're right, I implemented it mindlessly as I saw the API available in the
firmware interface. I'll remove both prepare and unprepare as one is redund=
ant
and the other harmful (though I wonder what whould happen if called).

Regards,
Nicolas


--=-CaIs5UzJsQf89/5WfJE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz3tDsACgkQlfZmHno8
x/7O3Qf+PrJ/wkQhLSFrJaROEcNj//C0XizXWMOpsuRjn+bdm+w1i0ea9R7LAvuq
v6vUqz9PQkIuP10YfD7xVhQhTTCkCjooavG0fCCmwry3fjT+UHCXihjegTlmuoIQ
T0XTLdIcmhHRC6YW4lJFg5zfp8qj0ZgQzyHVToP2BUaX0ZT7+2sXT3Anyzz218TF
LaeXkMoMGcZo1B5ajXfEgV/cAe+iU3zCIyAUJ9OIiJyeusA0DejX5KivhlrDWEsH
mxqgc7DqxtvR8hqsdwgjlYSxOhV3R6qRFaXNihCBG/0XFQvaLZb4l1Wp42JVeG3t
HmK4vqzmdr/VkSzW/NaQRejkuS1U9g==
=paIB
-----END PGP SIGNATURE-----

--=-CaIs5UzJsQf89/5WfJE7--


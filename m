Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C72535A9F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfFEKpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:45:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:36713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfFEKo7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559731474;
        bh=sh1qIohboAjI8zx1h3HAngV41iu0wgn/neR3ClIblpQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rto7jdSL/BwkoR1CkTYGKskRXRBOLa8kunlf+b4pQT5AGXCdw+Ffh8QMX/RTqoEvZ
         BcZN74ncla2W6FFri55rhU3XdzD4UdAaY21B/MIlBXlG4FF/eSYmOYYkF3TNxAmPjq
         c1VR+U2NUGx3r+5CYLn8Arx5lscMUnXqOcjgU+ik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNHqL-1hVyId2ZZZ-00703F; Wed, 05
 Jun 2019 12:44:34 +0200
Subject: Re: [PATCH 2/4] clk: bcm283x: add driver interfacing with Raspberry
 Pi's firmware
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, sboyd@kernel.org, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
 <20190604173223.4229-3-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <7ff78cd1-3c39-925d-c66c-f7f295fe6d6e@gmx.net>
Date:   Wed, 5 Jun 2019 12:44:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604173223.4229-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:f+MR9hVpZSEGtFXCFscm14tsRiDKqFasQNAcpatHhdNnsRTjyKZ
 2Dz0q6AzjVF3vadknEq/xaqPqvhPa+Bxa+f47OcLXHiV+7VYQYiJFtupwH8zccIvSAj6ha7
 UZQYqjDAmEvh0+wB0s1wglBytkePXtw+dyKP1h2uqKlsWufG+KGmVFex0RKvwBBRNJ3kVVM
 ZatY1tvXfCdJbyGmqh6KA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DbqK99Qbwfs=:evDsDa7sabjJS9PpIqE0V5
 Iwng5CNjFIBU7wPn60eWljsA6hzI31KEYOFZW6GzM+/D1YuK5UrRhIswvuNlekGXm1NSaSexe
 Mb8cpNaWWM9aqU/0uk1jChkBxB2l4+yVllnIWPRLzVZpdwISgt26vIHbrONOM1DK/oQqp4H4Q
 ogA4DA1KBkI+Jtv1JQdcmKkT1iwm38vPFXV7XZrk2GBYI1TgYz6boYqnBi7TFA4TMLaauQ2hh
 wo6DuDAa5gW1+JfeN43u0opY/xpXC7DvoP1ip989ZFlzk/3i8vppedBkQkU3QKcz5mmWeg6Uu
 o4+bNYDWm7AuuBzAw81nAP7kC5XMek9yE7o2wemjCwXBXnbMiSMs/yMZLsI6R8nBLEoVDpslF
 v7o4aNcyES6Z7413lVcDHkUfgErt4VMiLsjGVPtx44JFZFyDafeFXznvwtbSJVYk2WxrRSRq5
 aLTvrnZ+fi0pVQKKpUvUBq8oQqrZ6SXYaOTRvHdOprs9bh/TMA2V/6wS43Z7evkk9iL41nF6Z
 Wu3wpPTWAOTGyUhF1Ez/zZw9sBUlCuWfVJMAIRZgXz0ioCZJrURLO12BCjmqe8fq0UrTCACNP
 LP8aHg40xBGL/RcatJ/H4ueuHs3h+ifHwUsOes+n8I5d7D6rhg4//dHYYg/08vch8Af7EreT0
 9LWMdf0MHHTsNXwSw0HIsYhNu2UBnukYH+Q14DMeTWSNNTltoLQg4szqNrP3OJfTBuO1F+0JG
 ti71QPUBFbHycgCyUbU3dOJT/oNcY4KHSW+MDknt9Y817K4aUHjkz+y7dYicwQQHb32gY83AK
 r7cSKXjhjLgs7WjqtZEGgEO8xEeAFSHyF7LV+Wri9OaHurCo4YmELfLBtDHy5btVwZKz2AJV7
 YC8Ru4Nuk30fa+yzWzXnLg2rfHv/DHGo0guN0r1IRfHm/J4Hns5DhnjB2Ft1oLbegH1gPmhIS
 E+Qrq+1KWoDeQVDv6yEDshJ7ai9CeQb112gFw1jOmZVtJFekZbV0UHdYF8sAhQjVZlzVexLEe
 3w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
> Raspberry Pi's firmware offers and interface though which update it's
> clock's frequencies. This is specially useful in order to change the CPU
> clock (pllb_arm) which is 'owned' by the firmware and we're unable to
> scale using the register interface.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> Changes since RFC:
>   - Moved firmware interface into own driver
>   - Use of_find_compatible_node()
>   - Remove error message on rpi_firmware_get() failure
>   - Ratelimit messages on set_rate() failure
>   - Use __le32 on firmware interface definition
>
>  drivers/clk/bcm/Makefile          |   1 +
>  drivers/clk/bcm/clk-raspberrypi.c | 316 ++++++++++++++++++++++++++++++
>  2 files changed, 317 insertions(+)
>  create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
>
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index 002661d39128..07abe92df9d1 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
>  obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835-aux.o
> +obj-$(CONFIG_ARCH_BCM2835)	+= clk-raspberrypi.o
Hm, on the one side it would be nice to avoid building this driver in
case the firmware driver is disabled on the other side it would be good
to keep compile test.
>  obj-$(CONFIG_ARCH_BCM_53573)	+= clk-bcm53573-ilp.o
>  obj-$(CONFIG_CLK_BCM_CYGNUS)	+= clk-cygnus.o
>  obj-$(CONFIG_CLK_BCM_HR2)	+= clk-hr2.o
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> new file mode 100644
> index 000000000000..485c00288414
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Nicolas Saenz Julienne
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
> +#define RPI_FIRMWARE_STATE_ENABLE_BIT	0x1
> +#define RPI_FIRMWARE_STATE_WAIT_BIT	0x2
how about using the BIT() macro?
> +
> +/*
> + * Even though the firmware interface alters 'pllb' the frequencies are
> + * provided as per 'pllb_arm'. We need to scale before passing them trough.
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
> + * Structure of the message passed to Raspberry Pi's firmware in order to
> + * change clock rates. The 'disable_turbo' option is only available to the ARM
> + * clock (pllb) which we enable by default as turbo mode will alter multiple
> + * clocks at once.
> + *
> + * Even though we're able to access the clock registers directly we're bound to
> + * use the firmware interface as the firmware ultimately takes care of
> + * mitigating overheating/undervoltage situations and we would be changing
> + * frequencies behind his back.
> + *
> + * For more information on the firmware interface check:
> + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> + */
> +struct raspberrypi_firmware_prop {
> +	__le32 id;
> +	__le32 val;
> +	__le32 disable_turbo;
> +} __packed;
> +
> +static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
> +				      u32 clk, u32 *val)
> +{
> +	struct raspberrypi_firmware_prop msg = {
> +		.id = clk,
> +		.val = *val,
> +		.disable_turbo = 1,
> +	};
> +	int ret;
> +
> +	ret = rpi_firmware_property(firmware, tag, &msg, sizeof(msg));
> +	if (ret)
> +		return ret;
> +
> +	*val = msg.val;
> +
> +	return 0;
> +}
> +
> +static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
> +{
> +	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
> +						   pllb);
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(rpi->firmware,
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
> +	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
> +						   pllb);
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &val);
> +	if (ret)
> +		return ret;
> +
> +	return val * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +}
> +
> +static int raspberrypi_fw_pll_on(struct clk_hw *hw)
> +{
> +	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
> +						   pllb);
> +	u32 val;
> +	int ret;
> +
> +	val = RPI_FIRMWARE_STATE_ENABLE_BIT | RPI_FIRMWARE_STATE_WAIT_BIT;
> +
> +	ret = raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_SET_CLOCK_STATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID, &val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
return ret;
> +}
> +
> +static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				       unsigned long parent_rate)
> +{
> +	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
> +						   pllb);
> +	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_SET_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &new_rate);
> +	if (ret)
> +		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d",
> +				    clk_hw_get_name(hw), ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Sadly there is no firmware rate rounding interface. We borred it from
borrowed?
> + * clk-bcm2835.
> + */
> +static long raspberrypi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				       unsigned long *parent_rate)
> +{
> +	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
> +						   pllb);
> +	u64 div, final_rate;
> +	u32 ndiv, fdiv;
> +
> +	rate = clamp(rate, rpi->min_rate, rpi->max_rate);
> +
> +	div = (u64)rate << A2W_PLL_FRAC_BITS;
> +	do_div(div, *parent_rate);
> +
> +	ndiv = div >> A2W_PLL_FRAC_BITS;
> +	fdiv = div & ((1 << A2W_PLL_FRAC_BITS) - 1);
> +
> +	/* We can't use rate directly as it would overflow */
> +	final_rate = ((u64)*parent_rate * ((ndiv << A2W_PLL_FRAC_BITS) + fdiv));
> +
> +	return final_rate >> A2W_PLL_FRAC_BITS;
> +}
> +
> +static void raspberrypi_fw_pll_off(struct clk_hw *hw)
> +{
> +	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
> +						   pllb);
> +	u32 val = RPI_FIRMWARE_STATE_WAIT_BIT;
> +
> +	raspberrypi_clock_property(rpi->firmware,
> +				   RPI_FIRMWARE_SET_CLOCK_STATE,
> +				   RPI_FIRMWARE_ARM_CLK_ID, &val);
> +}
I'm not sure. Does this operation really make sense?
> +
> +static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
> +	.is_prepared = raspberrypi_fw_pll_is_on,
> +	.prepare = raspberrypi_fw_pll_on,
> +	.unprepare = raspberrypi_fw_pll_off,
> +	.recalc_rate = raspberrypi_fw_pll_get_rate,
> +	.set_rate = raspberrypi_fw_pll_set_rate,
> +	.round_rate = raspberrypi_pll_round_rate,
> +};
> +
> +static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
> +{
> +	u32 min_rate = 0, max_rate = 0;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	/* Get min & max rates set by the firmware */
> +	ret = raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &min_rate);
> +	if (ret) {
> +		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
> +			init.name, ret);
at this point init isn't initialized
> +		return ret;
> +	}
> +
> +	ret = raspberrypi_clock_property(rpi->firmware,
> +					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
> +					 RPI_FIRMWARE_ARM_CLK_ID,
> +					 &max_rate);
> +	if (ret) {
> +		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
> +			init.name, ret);
> +		return ret;
ditto
> +	}
> +
> +	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
> +		 min_rate, max_rate);
> +
> +	rpi->min_rate = min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> +	rpi->max_rate = max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
I know we have to trust the firmware, but i would at least check that
min_rate and max_rate are greater than zero.
> +
> +	memset(&init, 0, sizeof(init));
> +
> +	/* All of the PLLs derive from the external oscillator. */
> +	init.parent_names = (const char *[]){ "osc" };
> +	init.num_parents = 1;
> +	init.name = "pllb";
> +	init.ops = &raspberrypi_firmware_pll_clk_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
> +
> +	rpi->pllb.init = &init;
> +
> +	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
> +}
> +
> +static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
> +{
> +	rpi->pllb_arm = clk_hw_register_fixed_factor(rpi->dev,
> +				"pllb_arm", "pllb",
> +				CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> +				1, 2);
> +	if (IS_ERR(rpi->pllb_arm)) {
> +		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
> +		return PTR_ERR(rpi->pllb_arm);
> +	}
> +
> +	rpi->pllb_arm_lookup = clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
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
> +	struct device *dev = &pdev->dev;
> +	struct rpi_firmware *firmware;
> +	struct raspberrypi_clk *rpi;
> +	int ret;
> +
> +	firmware_node = of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (!firmware_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	firmware = rpi_firmware_get(firmware_node);
> +	of_node_put(firmware_node);
> +	if (!firmware)
> +		return -EPROBE_DEFER;
> +
> +	rpi = devm_kzalloc(dev, sizeof(*rpi), GFP_KERNEL);
> +	if (!rpi)
> +		return -ENOMEM;
> +
> +	rpi->dev = dev;
> +	rpi->firmware = firmware;
> +
> +	ret = raspberrypi_register_pllb(rpi);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize pllb, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = raspberrypi_register_pllb_arm(rpi);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize pllb_arm, %d\n", ret);
I think the error messages in raspberrypi_register_pllb_arm() are enough.
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver raspberrypi_clk_driver = {
> +	.driver = {
> +		.name = "raspberrypi-clk",
> +	},
> +	.probe          = raspberrypi_clk_probe,
> +};
> +builtin_platform_driver(raspberrypi_clk_driver);
> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
> +MODULE_DESCRIPTION("Raspberry Pi firmware clock driver");
> +MODULE_LICENSE("GPLv2");

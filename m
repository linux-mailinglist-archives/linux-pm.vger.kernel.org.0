Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38021012
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfEPVf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 17:35:59 -0400
Received: from vps.xff.cz ([195.181.215.36]:39844 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfEPVf7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 17:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1558042554; bh=oQGzUor0EEvzaV0gFD1oa/3oh2BDc+DO/IE05UxRCiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpztznVyWSz/tQwQEFf5QbC33ya/in8FAd9eZ7RDfW3evK4Lchwo7zguAfv+DKLsq
         kOvU+8CJMTvcOFSysTfqv1DJhW3Md5vhftxC9wp7WUznc30N48rfLkT3HjoUClVjS3
         mIkBciTs4BsB3AtuFGdfv7MyskwfukmAjHyByvDc=
Date:   Thu, 16 May 2019 23:35:54 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] thermal: sun8i: add thermal driver for h6
Message-ID: <20190516213554.kkt26aywxn67zsxj@core.my.home>
Mail-Followup-To: Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190516172633.12607-1-tiny.windzz@gmail.com>
 <20190516172633.12607-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516172633.12607-2-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Yangtao,

On Thu, May 16, 2019 at 01:26:32PM -0400, Yangtao Li wrote:
> This patch adds the support for allwinner thermal sensor, within
> allwinner SoC. It will register sensors for thermal framework
> and use device tree to bind cooling device.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  MAINTAINERS                     |   7 +
>  drivers/thermal/Kconfig         |  14 ++
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/sun8i_thermal.c | 422 ++++++++++++++++++++++++++++++++
>  4 files changed, 444 insertions(+)
>  create mode 100644 drivers/thermal/sun8i_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 005902ea1450..4e753ed20cd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -674,6 +674,13 @@ L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  F:	drivers/crypto/sunxi-ss/
>  
> +ALLWINNER THERMAL DRIVER
> +M:	Yangtao Li <tiny.windzz@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
> +F:	drivers/thermal/sun8i_thermal.c
> +
>  ALLWINNER VPU DRIVER
>  M:	Maxime Ripard <maxime.ripard@bootlin.com>
>  M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 66a709d5d6b9..f03d941c5686 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -263,6 +263,20 @@ config SPEAR_THERMAL
>  	  Enable this to plug the SPEAr thermal sensor driver into the Linux
>  	  thermal framework.
>  
> +config SUN8I_THERMAL
> +	tristate "Allwinner sun8i thermal driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on NVMEM_SUNXI_SID
> +	depends on OF
> +	depends on RESET_CONTROLLER
> +	help
> +	  Support for the sun8i thermal sensor driver into the Linux thermal
> +	  framework.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sun8i-thermal.
> +
>  config ROCKCHIP_THERMAL
>  	tristate "Rockchip thermal driver"
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 74a37c7f847a..fa6f8b206281 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -31,6 +31,7 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>  obj-y				+= broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
> +obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
>  obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> new file mode 100644
> index 000000000000..c9920f58fc80
> --- /dev/null
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Thermal sensor driver for Allwinner SOC
> + * Copyright (C) 2019 Yangtao Li
> + *
> + * Based on the work of Icenowy Zheng <icenowy@aosc.io>
> + * Based on the work of Ondrej Jirman <megous@megous.com>
> + * Based on the work of Josef Gajdusek <atx@atx.name>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#define MAX_SENSOR_NUM	4
> +
> +#define FT_TEMP_MASK				GENMASK(11, 0)
> +#define TEMP_CALIB_MASK				GENMASK(11, 0)
> +#define TEMP_TO_REG				672
> +#define CALIBRATE_DEFAULT			0x800
> +
> +#define SUN50I_THS_CTRL0			0x00
> +#define SUN50I_H6_THS_ENABLE			0x04
> +#define SUN50I_H6_THS_PC			0x08
> +#define SUN50I_H6_THS_DIC			0x10
> +#define SUN50I_H6_THS_DIS			0x20
> +#define SUN50I_H6_THS_MFC			0x30
> +#define SUN50I_H6_THS_TEMP_CALIB		0xa0
> +#define SUN50I_H6_THS_TEMP_DATA			0xc0
> +
> +#define SUN50I_THS_CTRL0_T_ACQ(x)		((GENMASK(15, 0) & (x)) << 16)
> +#define SUN50I_THS_FILTER_EN			BIT(2)
> +#define SUN50I_THS_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
> +#define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
> +#define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
> +
> +/* millidegree celsius */
> +#define SUN50I_H6_FT_DEVIATION			7000
> +
> +struct ths_device;
> +
> +struct tsensor {
> +	struct ths_device		*tmdev;
> +	struct thermal_zone_device	*tzd;
> +	int				id;
> +};
> +
> +struct ths_thermal_chip {
> +	int		sensor_num;
> +	int		offset;
> +	int		scale;
> +	int		ft_deviation;
> +	int		temp_calib_base;
> +	int		temp_data_base;
> +	int		(*enable)(struct ths_device *tmdev);
> +	int		(*disable)(struct ths_device *tmdev);
> +	irqreturn_t	(*irq_thread)(int irq, void *data);
> +};
> +
> +struct ths_device {
> +	const struct ths_thermal_chip		*chip;
> +	struct device				*dev;
> +	struct regmap				*regmap;
> +	struct reset_control			*reset;
> +	struct clk				*bus_clk;
> +	struct tsensor				sensor[MAX_SENSOR_NUM];
> +};
> +
> +/* Temp Unit: millidegree Celsius */
> +static int ths_reg2temp(struct ths_device *tmdev,
> +			int reg)
> +{
> +	return (reg + tmdev->chip->offset) * tmdev->chip->scale;
> +}
> +
> +static int ths_get_temp(void *data, int *temp)
> +{
> +	struct tsensor *s = data;
> +	struct ths_device *tmdev = s->tmdev;
> +	int val;
> +
> +	regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> +		    0x4 * s->id, &val);
> +
> +	/* ths have no data yet */
> +	if (unlikely(val == 0))

You probably forgot to change this to !val and drop unlikely.

> +		return -EBUSY;
> +
> +	*temp = ths_reg2temp(tmdev, val);
> +	if (tmdev->chip->ft_deviation)
> +		*temp += tmdev->chip->ft_deviation;

Please move this to ths_reg2temp, so that ths_reg2temp returns the final
temperature.

> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops ths_ops = {
> +	.get_temp = ths_get_temp,
> +};
> +
> +static const struct regmap_config config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +};
> +
> +static irqreturn_t sun50i_h6_irq_thread(int irq, void *data)
> +{
> +	struct ths_device *tmdev = data;
> +	int i, state;
> +
> +	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
> +
> +	for (i = 0; i < tmdev->chip->sensor_num; i++) {
> +		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
> +			/* clear data irq pending */
> +			regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
> +				     SUN50I_H6_THS_DATA_IRQ_STS(i));
> +
> +			thermal_zone_device_update(tmdev->sensor[i].tzd,
> +						   THERMAL_EVENT_UNSPECIFIED);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ths_init_resource(struct ths_device *tmdev)
> +{
> +	struct device *dev = tmdev->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *mem;
> +	void __iomem *base;
> +	int irq, ret;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	tmdev->regmap = devm_regmap_init_mmio(dev, base, &config);
> +	if (IS_ERR(tmdev->regmap))
> +		return PTR_ERR(tmdev->regmap);
> +
> +	tmdev->reset = devm_reset_control_get(dev, 0);
> +	if (IS_ERR(tmdev->reset))
> +		return PTR_ERR(tmdev->reset);
> +
> +	tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +	if (IS_ERR(tmdev->bus_clk))
> +		return PTR_ERR(tmdev->bus_clk);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					tmdev->chip->irq_thread,
> +					IRQF_ONESHOT, "ths", tmdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ths_calibrate(struct ths_device *tmdev)
> +{
> +	struct nvmem_cell *calcell;
> +	struct device *dev = tmdev->dev;
> +	u16 *caldata;
> +	size_t callen;
> +	int ft_temp;
> +	int i, ret = 0;
> +
> +	calcell = devm_nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(calcell)) {
> +		if (PTR_ERR(calcell) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		/*
> +		 * Even if the external calibration data stored in sid is
> +		 * not accessible, the THS hardware can still work, although
> +		 * the data won't be so accurate.
> +		 *
> +		 * The default value of calibration register is 0x800 for
> +		 * every sensor, and the calibration value is usually 0x7xx
> +		 * or 0x8xx, so they won't be away from the default value
> +		 * for a lot.
> +		 *
> +		 * So here we do not return error if the calibartion data is
> +		 * not available, except the probe needs deferring.
> +		 */
> +		goto out;
> +	}
> +
> +	caldata = nvmem_cell_read(calcell, &callen);
> +	if (IS_ERR(caldata)) {
> +		ret = PTR_ERR(caldata);
> +		goto out;
> +	}
> +
> +	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	/*
> +	 * efuse layout:
> +	 *
> +	 *	0   11  16	 32
> +	 *	+-------+-------+-------+
> +	 *	|temp|  |sensor0|sensor1|
> +	 *	+-------+-------+-------+
> +	 *
> +	 * The calibration data on the H6 is the ambient temperature and
> +	 * sensor values that are filled during the factory test stage.
> +	 *
> +	 * The unit of stored FT temperature is 0.1 degreee celusis.
> +	 * Through the stored ambient temperature and the data read
> +	 * by the sensor, after a certain calculation, the calibration
> +	 * value to be compensated can be obtained.
> +	 */
> +	ft_temp = caldata[0] & FT_TEMP_MASK;
> +
> +	for (i = 0; i < tmdev->chip->sensor_num; i++) {
> +		int reg = (int)caldata[i + 1];
> +		int sensor_temp = ths_reg2temp(tmdev, reg);
> +		int delta, cdata, calib_offest;
> +
> +		/*
> +		 * To calculate the calibration value:
> +		 *
> +		 * X(in Celsius) = Ts - ft_temp
> +		 * delta = X * 10000 / TEMP_TO_REG
> +		 * cdata = CALIBRATE_DEFAULT - delta
> +		 *
> +		 * cdata: calibration value
> +		 */
> +		delta = (sensor_temp - ft_temp * 100) * 10 / TEMP_TO_REG;
> +		cdata = CALIBRATE_DEFAULT - delta;
> +		if (cdata & ~TEMP_CALIB_MASK) {
> +			/*
> +			 * Calibration value more than 12-bit, but calibration
> +			 * register is 12-bit. In this case, ths hardware can
> +			 * still work without calibration, although the data
> +			 * won't be so accurate.
> +			 */
> +			dev_warn(dev, "sensor%d is not calibrated.\n", i);
> +
> +			continue;
> +		}
> +
> +		calib_offest = tmdev->chip->temp_calib_base + (i / 2) * 0x4;
> +
> +		if (i % 2) {
> +			int val;
> +
> +			regmap_read(tmdev->regmap, calib_offest, &val);
> +			val = (val & TEMP_CALIB_MASK) | (cdata << 16);
> +			regmap_write(tmdev->regmap, calib_offest, val);
> +		} else {
> +			regmap_write(tmdev->regmap, calib_offest, cdata);
> +		}
> +	}
> +
> +out_free:
> +	kfree(caldata);
> +out:
> +	return ret;
> +}
> +
> +static int ths_register(struct ths_device *tmdev)
> +{
> +	struct thermal_zone_device *tzd;
> +	int i = 0;
> +
> +	for (; i < tmdev->chip->sensor_num; i++) {
> +		tmdev->sensor[i].tmdev = tmdev;
> +		tmdev->sensor[i].id = i;
> +		tmdev->sensor[i].tzd =
> +			devm_thermal_zone_of_sensor_register(tmdev->dev,
> +							     i,
> +							     &tmdev->sensor[i],
> +							     &ths_ops);
> +		if (IS_ERR(tmdev->sensor[i].tzd))
> +			return PTR_ERR(tzd);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ths_probe(struct platform_device *pdev)
> +{
> +	struct ths_device *tmdev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	tmdev = devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> +	if (!tmdev)
> +		return -ENOMEM;
> +
> +	tmdev->dev = dev;
> +	tmdev->chip = of_device_get_match_data(&pdev->dev);
> +	if (!tmdev->chip)
> +		return -EINVAL;
> +
> +	ret = ths_init_resource(tmdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ths_register(tmdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = tmdev->chip->enable(tmdev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, tmdev);
> +
> +	return ret;
> +}
> +
> +static int ths_remove(struct platform_device *pdev)
> +{
> +	struct ths_device *tmdev = platform_get_drvdata(pdev);
> +
> +	tmdev->chip->disable(tmdev);
> +
> +	return 0;
> +}
> +
> +static int sun50i_thermal_enable(struct ths_device *tmdev)
> +{
> +	int ret, val;
> +
> +	ret = reset_control_deassert(tmdev->reset);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(tmdev->bus_clk);
> +	if (ret)
> +		goto assert_reset;

What if we rename sun50i_thermal_enable to sun50i_thermal_setup and
put clock setup and reset deassert to probe?

> +	ret = ths_calibrate(tmdev);
> +	if (ret)
> +		goto assert_reset;

ths_calibrate will be SoC specific. On H3 for example, it would just be
moving values from SID directly to some register. Maybe we can rename
this to make this reflect that it's for H6 only, right now.

You also need to unprepare and disable the clock on failure.

Perhaps move this to struct ths_thermal_chip right away.

> +	/*
> +	 * clkin = 24MHz
> +	 * T acquire = clkin / (x + 1)
> +	 *           = 20us
> +	 */
> +	regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> +		     SUN50I_THS_CTRL0_T_ACQ(479));
> +	/* average over 4 samples */
> +	regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> +		     SUN50I_THS_FILTER_EN |
> +		     SUN50I_THS_FILTER_TYPE(1));
> +	/* period = (x + 1) * 4096 / clkin; ~10ms */
> +	regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> +		     SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> +	/* enable sensor */
> +	val = GENMASK(tmdev->chip->sensor_num - 1, 0);
> +	regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> +	/* thermal data interrupt enable */
> +	val = GENMASK(tmdev->chip->sensor_num - 1, 0);
> +	regmap_write(tmdev->regmap, SUN50I_H6_THS_DIC, val);

It's probably better to clear the interrupt flags prior to enabling
interrupts.

> +	return 0;
> +
> +assert_reset:
> +	reset_control_assert(tmdev->reset);
> +
> +	return ret;
> +}
> +
> +static int sun50i_thermal_disable(struct ths_device *tmdev)
> +{
> +	clk_disable_unprepare(tmdev->bus_clk);
> +	reset_control_assert(tmdev->reset);
> +
> +	return 0;
> +}

I suggest moving this to ths_remove directly. And dropping
sun50i_thermal_disable and ->disable callback completely.

thank you and regards,
	o.

> +static const struct ths_thermal_chip sun50i_h6_ths = {
> +	.sensor_num = 2,
> +	.offset = -2794,
> +	.scale = -67,
> +	.ft_deviation = SUN50I_H6_FT_DEVIATION,
> +	.temp_calib_base = SUN50I_H6_THS_TEMP_CALIB,
> +	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> +	.enable = sun50i_thermal_enable,
> +	.disable = sun50i_thermal_disable,
> +	.irq_thread = sun50i_h6_irq_thread,
> +};
> +
> +static const struct of_device_id of_ths_match[] = {
> +	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, of_ths_match);
> +
> +static struct platform_driver ths_driver = {
> +	.probe = ths_probe,
> +	.remove = ths_remove,
> +	.driver = {
> +		.name = "sun8i-thermal",
> +		.of_match_table = of_ths_match,
> +	},
> +};
> +module_platform_driver(ths_driver);
> +
> +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner SOC");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

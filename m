Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE850A53
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFXMFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 08:05:40 -0400
Received: from vps.xff.cz ([195.181.215.36]:47542 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfFXMFk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 08:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1561377938; bh=T4BXa4VwDBoEc4A4HcwS0Dl0bssMv2ECXblVliRU+Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mziuWN5kTFFpcq304OoQGK6gxdzqSCt3c4v+QPAJAN2Xr/rjVgJt8bguMb+m+Bs0+
         vDVZ1NmuEY1NyjB18a9F+pwxlCIMHxTyDOcZCQvhN8Zz//HRyQr+mAtuE+Xl8Kl2Lr
         IWjXiq/GG8qikZgtD4XyWJPxehxIBwPjI1F10fGA=
Date:   Mon, 24 Jun 2019 14:05:37 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 11/11] thermal: sun8i: add thermal driver for h3
Message-ID: <20190624120537.sxdm4y3jec3ksr4u@core.my.home>
Mail-Followup-To: Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
 <20190623164206.7467-12-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623164206.7467-12-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Yangtao,

On Sun, Jun 23, 2019 at 12:42:06PM -0400, Yangtao Li wrote:
> This patch adds the support for allwinner h3 thermal sensor.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 72 +++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 260b24340f5b..c8ee291f3b17 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -27,6 +27,14 @@
>  #define TEMP_TO_REG				672
>  #define CALIBRATE_DEFAULT			0x800
>  
> +#define SUN8I_THS_CTRL0				0x00
> +#define SUN8I_THS_CTRL2				0x40
> +#define SUN8I_THS_IC				0x44
> +#define SUN8I_THS_IS				0x48
> +#define SUN8I_THS_MFC				0x70
> +#define SUN8I_THS_TEMP_CALIB			0x74
> +#define SUN8I_THS_TEMP_DATA			0x80
> +
>  #define SUN50I_THS_CTRL0			0x00
>  #define SUN50I_H6_THS_ENABLE			0x04
>  #define SUN50I_H6_THS_PC			0x08
> @@ -36,6 +44,9 @@
>  #define SUN50I_H6_THS_TEMP_CALIB		0xa0
>  #define SUN50I_H6_THS_TEMP_DATA			0xc0
>  
> +#define SUN8I_THS_CTRL0_T_ACQ0(x)		(GENMASK(15, 0) & (x))
> +#define SUN8I_THS_CTRL2_T_ACQ1(x)		((GENMASK(15, 0) & (x)) << 16)
> +
>  #define SUN50I_THS_CTRL0_T_ACQ(x)		((GENMASK(15, 0) & (x)) << 16)
>  #define SUN50I_THS_FILTER_EN			BIT(2)
>  #define SUN50I_THS_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
> @@ -121,6 +132,21 @@ static const struct regmap_config config = {
>  	.fast_io = true,
>  };
>  
> +static int sun8i_h3_irq_ack(struct ths_device *tmdev)
> +{
> +	int state, ret = 0;
> +
> +	regmap_read(tmdev->regmap, SUN8I_THS_IS, &state);
> +
> +	if (state & BIT(8)) {
> +		regmap_write(tmdev->regmap, SUN8I_THS_IS,
> +			     BIT(8));
> +		ret |= BIT(1);
> +	}
> +
> +	return ret;
> +}
> +
>  static int sun50i_h6_irq_ack(struct ths_device *tmdev)
>  {
>  	int i, state, ret = 0;
> @@ -154,6 +180,14 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int sun8i_h3_ths_calibrate(struct ths_device *tmdev,
> +			       u16 *caldata, int callen)
> +{
> +	regmap_write(tmdev->regmap, SUN8I_THS_TEMP_CALIB, *caldata);

You're missing a sanity check for callen here.

regards,
	o.

> +	return 0;
> +}
> +
>  static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>  				   u16 *caldata, int callen)
>  {
> @@ -325,6 +359,32 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>  	return ret;
>  }
>  
> +static int sun8i_h3_thermal_init(struct ths_device *tmdev)
> +{
> +	/* average over 4 samples */
> +	regmap_write(tmdev->regmap, SUN8I_THS_MFC,
> +		     SUN50I_THS_FILTER_EN |
> +		     SUN50I_THS_FILTER_TYPE(1));
> +	/*
> +	 * period = (x + 1) * 4096 / clkin; ~10ms
> +	 * enable data interrupt
> +	 */
> +	regmap_write(tmdev->regmap, SUN8I_THS_IC,
> +		     SUN50I_H6_THS_PC_TEMP_PERIOD(58) | BIT(8));
> +	/*
> +	 * clkin = 24MHz
> +	 * T acquire = clkin / (x + 1)
> +	 *           = 20us
> +	 * enable sensor
> +	 */
> +	regmap_write(tmdev->regmap, SUN8I_THS_CTRL0,
> +		     SUN8I_THS_CTRL0_T_ACQ0(479));
> +	regmap_write(tmdev->regmap, SUN8I_THS_CTRL2,
> +		     SUN8I_THS_CTRL2_T_ACQ1(479) | BIT(0));
> +
> +	return 0;
> +}
> +
>  static int sun50i_thermal_init(struct ths_device *tmdev)
>  {
>  	int val;
> @@ -431,6 +491,17 @@ static int sun8i_ths_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct ths_thermal_chip sun8i_h3_ths = {
> +	.sensor_num = 1,
> +	.offset = -1794,
> +	.scale = -121,
> +	.has_ahb_clk = true,
> +	.temp_data_base = SUN8I_THS_TEMP_DATA,
> +	.calibrate = sun8i_h3_ths_calibrate,
> +	.init = sun8i_h3_thermal_init,
> +	.irq_ack = sun8i_h3_irq_ack,
> +};
> +
>  static const struct ths_thermal_chip sun50i_h6_ths = {
>  	.sensor_num = 2,
>  	.offset = -2794,
> @@ -443,6 +514,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
>  };
>  
>  static const struct of_device_id of_ths_match[] = {
> +	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
>  	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
>  	{ /* sentinel */ },
>  };
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

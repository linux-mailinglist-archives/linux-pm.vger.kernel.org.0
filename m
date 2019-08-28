Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC9A021B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1MpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 08:45:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:58478 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfH1MpS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 08:45:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 05:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="197548308"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 05:45:13 -0700
Message-ID: <6665337688eb070af04d47e6fdd979350783d9f9.camel@intel.com>
Subject: Re: [PATCH v5 09/18] thermal: sun8i: rework for ths calibrate func
From:   Zhang Rui <rui.zhang@intel.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 20:45:22 +0800
In-Reply-To: <20190810052829.6032-10-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
         <20190810052829.6032-10-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2019-08-10 at 05:28 +0000, Yangtao Li wrote:
> Here, we do something to prepare for the subsequent
> support of multiple platforms.
> 
> 1) rename sun50i_ths_calibrate to sun8i_ths_calibrate, because
>    this function should be suitable for all platforms now.
> 
> 2) introduce calibrate callback to mask calibration method
>    differences.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

IMO, patch 4/18 to patch 9/18 are all changes to a new file introduced
in patch 1/18, so why not have a prettier patch 1/18 instead of
separate patches?

thanks,
rui

> ---
>  drivers/thermal/sun8i_thermal.c | 86 ++++++++++++++++++-------------
> --
>  1 file changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c
> index 6f4294c2aba7..47c20c4c69e7 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -60,6 +60,8 @@ struct ths_thermal_chip {
>  	int		scale;
>  	int		ft_deviation;
>  	int		temp_data_base;
> +	int		(*calibrate)(struct ths_device *tmdev,
> +				     u16 *caldata, int callen);
>  	int		(*init)(struct ths_device *tmdev);
>  	int             (*irq_ack)(struct ths_device *tmdev);
>  };
> @@ -152,45 +154,14 @@ static irqreturn_t sun8i_irq_thread(int irq,
> void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int sun50i_ths_calibrate(struct ths_device *tmdev)
> +static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
> +				   u16 *caldata, int callen)
>  {
> -	struct nvmem_cell *calcell;
>  	struct device *dev = tmdev->dev;
> -	u16 *caldata;
> -	size_t callen;
> -	int ft_temp;
> -	int i, ret = 0;
> -
> -	calcell = devm_nvmem_cell_get(dev, "calib");
> -	if (IS_ERR(calcell)) {
> -		if (PTR_ERR(calcell) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -		/*
> -		 * Even if the external calibration data stored in sid
> is
> -		 * not accessible, the THS hardware can still work,
> although
> -		 * the data won't be so accurate.
> -		 *
> -		 * The default value of calibration register is 0x800
> for
> -		 * every sensor, and the calibration value is usually
> 0x7xx
> -		 * or 0x8xx, so they won't be away from the default
> value
> -		 * for a lot.
> -		 *
> -		 * So here we do not return error if the calibartion
> data is
> -		 * not available, except the probe needs deferring.
> -		 */
> -		goto out;
> -	}
> +	int i, ft_temp;
>  
> -	caldata = nvmem_cell_read(calcell, &callen);
> -	if (IS_ERR(caldata)) {
> -		ret = PTR_ERR(caldata);
> -		goto out;
> -	}
> -
> -	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num) {
> -		ret = -EINVAL;
> -		goto out_free;
> -	}
> +	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
> +		return -EINVAL;
>  
>  	/*
>  	 * efuse layout:
> @@ -245,7 +216,45 @@ static int sun50i_ths_calibrate(struct
> ths_device *tmdev)
>  				   cdata << offset);
>  	}
>  
> -out_free:
> +	return 0;
> +}
> +
> +static int sun8i_ths_calibrate(struct ths_device *tmdev)
> +{
> +	struct nvmem_cell *calcell;
> +	struct device *dev = tmdev->dev;
> +	u16 *caldata;
> +	size_t callen;
> +	int ret = 0;
> +
> +	calcell = devm_nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(calcell)) {
> +		if (PTR_ERR(calcell) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		/*
> +		 * Even if the external calibration data stored in sid
> is
> +		 * not accessible, the THS hardware can still work,
> although
> +		 * the data won't be so accurate.
> +		 *
> +		 * The default value of calibration register is 0x800
> for
> +		 * every sensor, and the calibration value is usually
> 0x7xx
> +		 * or 0x8xx, so they won't be away from the default
> value
> +		 * for a lot.
> +		 *
> +		 * So here we do not return error if the calibartion
> data is
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
> +	tmdev->chip->calibrate(tmdev, caldata, callen);
> +
>  	kfree(caldata);
>  out:
>  	return ret;
> @@ -294,7 +303,7 @@ static int sun8i_ths_resource_init(struct
> ths_device *tmdev)
>  	if (ret)
>  		goto bus_disable;
>  
> -	ret = sun50i_ths_calibrate(tmdev);
> +	ret = sun8i_ths_calibrate(tmdev);
>  	if (ret)
>  		goto mod_disable;
>  
> @@ -422,6 +431,7 @@ static const struct ths_thermal_chip
> sun50i_h6_ths = {
>  	.scale = -67,
>  	.ft_deviation = SUN50I_H6_FT_DEVIATION,
>  	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> +	.calibrate = sun50i_h6_ths_calibrate,
>  	.init = sun50i_h6_thermal_init,
>  	.irq_ack = sun50i_h6_irq_ack,
>  };


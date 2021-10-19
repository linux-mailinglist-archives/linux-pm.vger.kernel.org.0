Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685AE433515
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhJSLyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhJSLyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 07:54:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC1FC061745
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 04:51:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mcner-0005ja-Cv; Tue, 19 Oct 2021 13:51:53 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mcnep-0003xz-H0; Tue, 19 Oct 2021 13:51:51 +0200
Date:   Tue, 19 Oct 2021 13:51:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, Petr Benes <petrben@gmail.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] thermal: imx: implement runtime PM support
Message-ID: <20211019115151.GC16320@pengutronix.de>
References: <20210924115032.29684-1-o.rempel@pengutronix.de>
 <19b2ab33-aa56-75fb-f6ef-3c928be9c50c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19b2ab33-aa56-75fb-f6ef-3c928be9c50c@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:51:06 up 243 days, 15:14, 128 users,  load average: 0.17, 0.12,
 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Tue, Oct 19, 2021 at 01:04:46PM +0200, Daniel Lezcano wrote:
> On 24/09/2021 13:50, Oleksij Rempel wrote:
> > Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
> > data to decide whether to run a measurement") this driver stared using
> > irq_enabled flag to make decision to power on/off the thermal core. This
> > triggered a regression, where after reaching critical temperature, alarm
> > IRQ handler set irq_enabled to false,  disabled thermal core and was not
> > able read temperature and disable cooling sequence.
> > 
> > In case the cooling device is "CPU/GPU freq", the system will run with
> > reduce performance until next reboot.
> > 
> > To solve this issue, we need to move all parts implementing hand made
> > runtime power management and let it handle actual runtime PM framework.
> > 
> > Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether to run a measurement")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Thanks for this fix.
> 
> Petr or Oleksij,
> 
> could you confirm it is tested and working without CONFIG_PM ?

Petr was right, no it is not working without PM.

> > ---
> >  drivers/thermal/imx_thermal.c | 145 +++++++++++++++++++++-------------
> >  1 file changed, 91 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > index 2c7473d86a59..1db7ce6221b1 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/thermal.h>
> >  #include <linux/nvmem-consumer.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #define REG_SET		0x4
> >  #define REG_CLR		0x8
> > @@ -194,6 +195,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
> >  };
> >  
> >  struct imx_thermal_data {
> > +	struct device *dev;
> >  	struct cpufreq_policy *policy;
> >  	struct thermal_zone_device *tz;
> >  	struct thermal_cooling_device *cdev;
> > @@ -252,44 +254,15 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
> >  	const struct thermal_soc_data *soc_data = data->socdata;
> >  	struct regmap *map = data->tempmon;
> >  	unsigned int n_meas;
> > -	bool wait, run_measurement;
> >  	u32 val;
> > +	int ret;
> >  
> > -	run_measurement = !data->irq_enabled;
> > -	if (!run_measurement) {
> > -		/* Check if a measurement is currently in progress */
> > -		regmap_read(map, soc_data->temp_data, &val);
> > -		wait = !(val & soc_data->temp_valid_mask);
> > -	} else {
> > -		/*
> > -		 * Every time we measure the temperature, we will power on the
> > -		 * temperature sensor, enable measurements, take a reading,
> > -		 * disable measurements, power off the temperature sensor.
> > -		 */
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -			    soc_data->power_down_mask);
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -			    soc_data->measure_temp_mask);
> > -
> > -		wait = true;
> > -	}
> > -
> > -	/*
> > -	 * According to the temp sensor designers, it may require up to ~17us
> > -	 * to complete a measurement.
> > -	 */
> > -	if (wait)
> > -		usleep_range(20, 50);
> > +	ret = pm_runtime_resume_and_get(data->dev);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	regmap_read(map, soc_data->temp_data, &val);
> >  
> > -	if (run_measurement) {
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -			     soc_data->measure_temp_mask);
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -			     soc_data->power_down_mask);
> > -	}
> > -
> >  	if ((val & soc_data->temp_valid_mask) == 0) {
> >  		dev_dbg(&tz->device, "temp measurement never finished\n");
> >  		return -EAGAIN;
> > @@ -328,6 +301,8 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
> >  		enable_irq(data->irq);
> >  	}
> >  
> > +	pm_runtime_put(data->dev);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -335,24 +310,16 @@ static int imx_change_mode(struct thermal_zone_device *tz,
> >  			   enum thermal_device_mode mode)
> >  {
> >  	struct imx_thermal_data *data = tz->devdata;
> > -	struct regmap *map = data->tempmon;
> > -	const struct thermal_soc_data *soc_data = data->socdata;
> >  
> >  	if (mode == THERMAL_DEVICE_ENABLED) {
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -			     soc_data->power_down_mask);
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -			     soc_data->measure_temp_mask);
> > +		pm_runtime_get(data->dev);
> >  
> >  		if (!data->irq_enabled) {
> >  			data->irq_enabled = true;
> >  			enable_irq(data->irq);
> >  		}
> >  	} else {
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> > -			     soc_data->measure_temp_mask);
> > -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> > -			     soc_data->power_down_mask);
> > +		pm_runtime_put(data->dev);
> >  
> >  		if (data->irq_enabled) {
> >  			disable_irq(data->irq);
> > @@ -393,6 +360,11 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
> >  			     int temp)
> >  {
> >  	struct imx_thermal_data *data = tz->devdata;
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(data->dev);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	/* do not allow changing critical threshold */
> >  	if (trip == IMX_TRIP_CRITICAL)
> > @@ -406,6 +378,8 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
> >  
> >  	imx_set_alarm_temp(data, temp);
> >  
> > +	pm_runtime_put(data->dev);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -681,6 +655,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  	if (!data)
> >  		return -ENOMEM;
> >  
> > +	data->dev = &pdev->dev;
> > +
> >  	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
> >  	if (IS_ERR(map)) {
> >  		ret = PTR_ERR(map);
> > @@ -801,6 +777,14 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> >  		     data->socdata->measure_temp_mask);
> >  
> > +	/* the core was configured and enabled just before */
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(data->dev);
> > +
> > +	ret = pm_runtime_resume_and_get(data->dev);
> > +	if (ret < 0)
> > +		goto disable_runtime_pm;
> > +
> >  	data->irq_enabled = true;
> >  	ret = thermal_zone_device_enable(data->tz);
> >  	if (ret)
> > @@ -814,10 +798,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  		goto thermal_zone_unregister;
> >  	}
> >  
> > +	ret = pm_runtime_put(data->dev);
> > +	if (ret < 0)
> > +		goto disable_runtime_pm;
> > +
> >  	return 0;
> >  
> >  thermal_zone_unregister:
> >  	thermal_zone_device_unregister(data->tz);
> > +disable_runtime_pm:
> > +	pm_runtime_put_noidle(data->dev);
> > +	pm_runtime_disable(data->dev);
> >  clk_disable:
> >  	clk_disable_unprepare(data->thermal_clk);
> >  legacy_cleanup:
> > @@ -829,13 +820,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  static int imx_thermal_remove(struct platform_device *pdev)
> >  {
> >  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > -	struct regmap *map = data->tempmon;
> >  
> > -	/* Disable measurements */
> > -	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> > -		     data->socdata->power_down_mask);
> > -	if (!IS_ERR(data->thermal_clk))
> > -		clk_disable_unprepare(data->thermal_clk);
> > +	pm_runtime_put_noidle(data->dev);
> > +	pm_runtime_disable(data->dev);
> >  
> >  	thermal_zone_device_unregister(data->tz);
> >  	imx_thermal_unregister_legacy_cooling(data);
> > @@ -858,29 +845,79 @@ static int __maybe_unused imx_thermal_suspend(struct device *dev)
> >  	ret = thermal_zone_device_disable(data->tz);
> >  	if (ret)
> >  		return ret;
> > +
> > +	return pm_runtime_force_suspend(data->dev);
> > +}
> > +
> > +static int __maybe_unused imx_thermal_resume(struct device *dev)
> > +{
> > +	struct imx_thermal_data *data = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = pm_runtime_force_resume(data->dev);
> > +	if (ret)
> > +		return ret;
> > +	/* Enabled thermal sensor after resume */
> > +	return thermal_zone_device_enable(data->tz);
> > +}
> > +
> > +static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
> > +{
> > +	struct imx_thermal_data *data = dev_get_drvdata(dev);
> > +	const struct thermal_soc_data *socdata = data->socdata;
> > +	struct regmap *map = data->tempmon;
> > +	int ret;
> > +
> > +	ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> > +			   socdata->measure_temp_mask);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
> > +			   socdata->power_down_mask);
> > +	if (ret)
> > +		return ret;
> > +
> >  	clk_disable_unprepare(data->thermal_clk);
> >  
> >  	return 0;
> >  }
> >  
> > -static int __maybe_unused imx_thermal_resume(struct device *dev)
> > +static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
> >  {
> >  	struct imx_thermal_data *data = dev_get_drvdata(dev);
> > +	const struct thermal_soc_data *socdata = data->socdata;
> > +	struct regmap *map = data->tempmon;
> >  	int ret;
> >  
> >  	ret = clk_prepare_enable(data->thermal_clk);
> >  	if (ret)
> >  		return ret;
> > -	/* Enabled thermal sensor after resume */
> > -	ret = thermal_zone_device_enable(data->tz);
> > +
> > +	ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> > +			   socdata->power_down_mask);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
> > +			   socdata->measure_temp_mask);
> >  	if (ret)
> >  		return ret;
> >  
> > +	/*
> > +	 * According to the temp sensor designers, it may require up to ~17us
> > +	 * to complete a measurement.
> > +	 */
> > +	usleep_range(20, 50);
> > +
> >  	return 0;
> >  }
> >  
> > -static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
> > -			 imx_thermal_suspend, imx_thermal_resume);
> > +static const struct dev_pm_ops imx_thermal_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume)
> > +	SET_RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
> > +			   imx_thermal_runtime_resume, NULL)
> > +};
> >  
> >  static struct platform_driver imx_thermal = {
> >  	.driver = {
> > 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

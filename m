Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E62DA3B
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfE2KS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 06:18:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46231 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2KS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 06:18:29 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hVvf9-0005sa-MY; Wed, 29 May 2019 12:18:27 +0200
Message-ID: <1559125106.4039.27.camel@pengutronix.de>
Subject: Re: [PATCH] thermal: imx: register as OF sensor
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Date:   Wed, 29 May 2019 12:18:26 +0200
In-Reply-To: <1549966759.2546.25.camel@pengutronix.de>
References: <20181105165134.28963-1-l.stach@pengutronix.de>
         <20181106001152.GA4242@localhost.localdomain>
         <1541495682.2508.11.camel@pengutronix.de>
         <1549966759.2546.25.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Eduardo,

Am Dienstag, den 12.02.2019, 11:19 +0100 schrieb Lucas Stach:
> Hi all,
> 
> Am Dienstag, den 06.11.2018, 10:14 +0100 schrieb Lucas Stach:
> > Hi Eduardo,
> > 
> > Am Montag, den 05.11.2018, 16:11 -0800 schrieb Eduardo Valentin:
> > > On Mon, Nov 05, 2018 at 05:51:34PM +0100, Lucas Stach wrote:
> > > > To make the internal sensor usable with a thermal zone description
> > > > provided via DT, also register our device as a OF sensor.
> > > 
> > > Not sure I understand your patch. I see you probably want to
> > > have thermal zones described in DT that can make use of the
> > > imx sensors, but here you may end up in a situation with double
> > > registration of the same driver.
> > > 
> > > Typically drivers will have either mode. Some of them kept
> > > both modes, legacy and of- based, but at run time one is picked,
> > > not both at the same time.
> > 
> > So the thing here is that the thermal zone registered by the driver has
> > a value on its own, as it adds a critical trip-point for the maximum
> > SoC temperature, as determined by the fuses.
> > 
> > So I think there is some merit in keeping both the "legacy" thermal
> > zone and the OF sensor. I also don't see where this would be an issue,
> > but I admit not having looked too closely at all the details of the
> > thermal framework. Do you have any guidance here?
> 
> Any preference on how to move forward with this? This patch is blocking
> the introduction of thermal policies to some mainline DTs.

Please let me know how we can move forward with this. This is blocking
other patches and has been in limbo for quite a long time.

Regards,
Lucas
> > 
> > > > 
> > > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > 
> > > > ---
> > > >  drivers/thermal/imx_thermal.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > > > index aa452acb60b6..32f406099479 100644
> > > > --- a/drivers/thermal/imx_thermal.c
> > > > +++ b/drivers/thermal/imx_thermal.c
> > > > @@ -202,7 +202,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
> > > >  
> > > >  struct imx_thermal_data {
> > > > > > > > > > > > > > > > > > > > > >  	struct cpufreq_policy *policy;
> > > > > > > > > > > > > > > > > > > > > > -	struct thermal_zone_device *tz;
> > > > > > > > > > > > > > > > > > > > > > +	struct thermal_zone_device *tz, *sensor;
> > > > > > > > > > > > > > > > > > > > > >  	struct thermal_cooling_device *cdev;
> > > > > > > > > > >  	enum thermal_device_mode mode;
> > > > > > 
> > > > > >  	struct regmap *tempmon;
> > > > 
> > > > @@ -338,6 +338,13 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
> > > > > >  	return 0;
> > > > 
> > > >  }
> > > >  
> > > > +static int imx_of_sensor_get_temp(void *data, int *temp)
> > > > +{
> > > > > > +	struct imx_thermal_data *thermal_data = data;
> > > > 
> > > > +
> > > > > > +	return imx_get_temp(thermal_data->tz, temp);
> > > > 
> > > > +}
> > > > +
> > > >  static int imx_get_mode(struct thermal_zone_device *tz,
> > > > > >  			enum thermal_device_mode *mode)
> > > > 
> > > >  {
> > > > @@ -482,6 +489,10 @@ static struct thermal_zone_device_ops imx_tz_ops = {
> > > > > >  	.set_trip_temp = imx_set_trip_temp,
> > > > 
> > > >  };
> > > >  
> > > > +static const struct thermal_zone_of_device_ops imx_tz_of_ops = {
> > > > > > +	.get_temp = imx_of_sensor_get_temp,
> > > > 
> > > > +};
> > > > +
> > > >  static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
> > > >  {
> > > > > >  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > > > 
> > > > @@ -798,6 +809,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
> > > > > > > > > > >  		return ret;
> > > > > > 
> > > > > >  	}
> > > > 
> > > >  
> > > > > > > > > > > +	data->sensor = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
> > > > > > 
> > > > > > +						       &imx_tz_of_ops);
> > > > 
> > > > +
> > > > > > > > > > > > > > > > > > > > > >  	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
> > > > > > > > > > >  		 " critical:%dC passive:%dC\n", data->temp_grade,
> > > > > > 
> > > > > >  		 data->temp_max / 1000, data->temp_critical / 1000,
> > > > 
> > > > @@ -848,6 +862,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
> > > > > > > > > > >  	if (!IS_ERR(data->thermal_clk))
> > > > > > 
> > > > > >  		clk_disable_unprepare(data->thermal_clk);
> > > > 
> > > >  
> > > > > > > > > > > > > > > > > > > > > > +	thermal_zone_of_sensor_unregister(&pdev->dev, data->sensor);
> > > > > > > > > > > > > > > > > > > > > >  	thermal_zone_device_unregister(data->tz);
> > > > > > > > > > >  	cpufreq_cooling_unregister(data->cdev);
> > > > > > 
> > > > > >  	cpufreq_cpu_put(data->policy);
> > > > 
> > > > -- 
> > > > 2.19.1
> > > > 
> > 
> > 
> 
> 

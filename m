Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C668F750
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 19:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBHSpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 13:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHSpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 13:45:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7291217CFA
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 10:45:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h3so2531533eda.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 10:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yB3BjrPvVLN7DZjGp5r+HU7XwZ73Ug5bYRKAsmr3OqI=;
        b=0QkLnUI1M34+NBXYTOIjvAfoM9LJlLZRVHy17u5TkKk0PKdSFsRx0KQq0yk8DkBoXW
         spdGfiXWoKdHxeTBgbvx0j19xbbe9dtKMHpb88GdZzS6xpExDIKxXx7gF5NZNPhM85fL
         bDPHBKZ635ZTA5v7k+ToGT6CoWhHmeR4hbkTASHXkuYU2OL3o9YKqjXNkR49QRGEG7JZ
         qm4uwlA7GFh5+AKMij61ZHsPypDImX5EfaKOS9ZeSBfdT+A+yui27gSfMLMhEtD7Xkig
         uevukE5uzbzdg/tz/2QEHhcibxe1Vj5pF6tEr5r4THImqaNPUfrP2tpivVx3xQN0HS/z
         wkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB3BjrPvVLN7DZjGp5r+HU7XwZ73Ug5bYRKAsmr3OqI=;
        b=LuNbB5gHRhGEomH8jnRMj0J6BKCJNw/GKKWkfNnvajckc/2l9J9zbz+koYvxeftj9z
         6AJ7fneK3+ExuNW4apWasqQrf6s01qdyoJXJ9wULI/H8Wo93/XGzxR29O4PMS4yx2rE1
         fBS+2a2/PLr2lwp4O3chwpGA1iYt75Yg+08OS+AculWkCOz8DCijyYKg3LlA/qo3eFbD
         5vQsmVCRc5mSBrEX/ISHhPngO9Wn3DHZWy5dW2KnsoisIqTr0o4g16Wt00ksewlYOpkj
         hjrh/RGfL4QYv+E81qMjrRmogMRCA0n34zZJJSX/kwySUZEIBLXLpD2D77ec1H6Sd1st
         eh8w==
X-Gm-Message-State: AO0yUKWqvdergdtnHILgoNCUoTrM5Esm/LZGlMakLRha0H2UpfLklYgX
        CxFz5PqvngQzTZfQESt70Th3sw==
X-Google-Smtp-Source: AK7set+H9FA8/jPb/2iLEmgs5OgkTRiYJS6T9Xkzr1RtQ3FvkQ9rx3hbSIEq8E/lsfoKpyYqWXCwtA==
X-Received: by 2002:a50:9eca:0:b0:4aa:a5b3:15e6 with SMTP id a68-20020a509eca000000b004aaa5b315e6mr7963674edf.0.1675881900009;
        Wed, 08 Feb 2023 10:45:00 -0800 (PST)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id l21-20020a50d6d5000000b004aab36ad060sm4348952edj.92.2023.02.08.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:44:59 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:44:58 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers/thermal/rcar_gen3_thermal: Fix device
 initialization
Message-ID: <Y+PtqiTL1BmqCZiM@oden.dyn.berto.se>
References: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
 <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
 <8649a674-bbd4-435c-5574-c0c633988e66@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8649a674-bbd4-435c-5574-c0c633988e66@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thanks for your feedback.

On 2023-02-08 12:06:37 +0100, Daniel Lezcano wrote:
> On 07/02/2023 18:10, Niklas Söderlund wrote:
> > The thermal zone is registered before the device is register and the
> > thermal coefficients are calculated, providing a window for very
> > incorrect readings.
> > 
> > The reason why the zone was register before the device was fully
> > initialized was that the presence of the set_trips() callback is used to
> > determine if the driver supports interrupt or not, as it is not defined
> > if the device is incapable of interrupts.
> > 
> > Fix this by using the operations structure in the private data instead
> > of the zone to determine if interrupts are available or not, and
> > initialize the device before registering the zone.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >   drivers/thermal/rcar_gen3_thermal.c | 25 ++++++++++++++-----------
> >   1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> > index bfa2ff20b945..1dedeece1a00 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -89,7 +89,8 @@ struct rcar_gen3_thermal_priv {
> >   	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
> >   	struct thermal_zone_device_ops ops;
> >   	unsigned int num_tscs;
> > -	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
> > +	void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
> > +			     struct rcar_gen3_thermal_tsc *tsc);
> >   	int ptat[3];
> >   };
> > @@ -240,7 +241,7 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
> >   	for (i = 0; i < priv->num_tscs; i++) {
> >   		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
> >   		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> > -		if (status)
> > +		if (status && priv->tscs[i]->zone)
> >   			thermal_zone_device_update(priv->tscs[i]->zone,
> >   						   THERMAL_EVENT_UNSPECIFIED);
> >   	}
> > @@ -311,7 +312,8 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
> >   	return true;
> >   }
> > -static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
> > +static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_priv *priv,
> > +					      struct rcar_gen3_thermal_tsc *tsc)
> >   {
> >   	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
> >   	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
> > @@ -322,7 +324,7 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
> >   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
> >   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> > -	if (tsc->zone->ops->set_trips)
> > +	if (priv->ops.set_trips)
> >   		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
> >   					IRQ_TEMPD1 | IRQ_TEMP2);
> > @@ -338,7 +340,8 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
> >   	usleep_range(1000, 2000);
> >   }
> > -static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> > +static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
> > +				   struct rcar_gen3_thermal_tsc *tsc)
> >   {
> >   	u32 reg_val;
> > @@ -350,7 +353,7 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> >   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
> >   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> > -	if (tsc->zone->ops->set_trips)
> > +	if (priv->ops.set_trips)
> >   		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
> >   					IRQ_TEMPD1 | IRQ_TEMP2);
> > @@ -510,6 +513,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >   	for (i = 0; i < priv->num_tscs; i++) {
> >   		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> > +		priv->thermal_init(priv, tsc);
> > +		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
> > +
> >   		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
> >   		if (IS_ERR(zone)) {
> >   			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
> > @@ -518,9 +524,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >   		}
> >   		tsc->zone = zone;
> > -		priv->thermal_init(tsc);
> > -		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
> > -
> >   		tsc->zone->tzp->no_hwmon = false;
> >   		ret = thermal_add_hwmon_sysfs(tsc->zone);
> >   		if (ret)
> > @@ -559,8 +562,8 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> >   		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> >   		struct thermal_zone_device *zone = tsc->zone;
> > -		priv->thermal_init(tsc);
> > -		if (zone->ops->set_trips)
> > +		priv->thermal_init(priv, tsc);
> > +		if (priv->ops.set_trips)
> >   			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
> >   						    zone->prev_high_trip);
> 
> This is not needed, at resume time, the thermal framework has a pm_notifier
> and calls thermal_zone_device_update() which in turn calls
> thermal_zone_set_trips(). If the ops is not set, it will continue.
> 
> Actually, no call to set_trips should happen in the driver, just pass the
> ops the thermal framework and it will do the actions.
> 
> The same happens when you call thermal_zone_device_register(), it calls
> thermal_zone_device_update(), then thermal_zone_set_trips().

I will send a v2 of this series addressing this before fixing the issue 
addressed in this patch.

> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
Kind Regards,
Niklas Söderlund

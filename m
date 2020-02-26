Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4516FE5E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 12:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBZLzV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 06:55:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43108 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgBZLzV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:55:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id e3so1698576lja.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 03:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fdeavgxgnxhsv/ZkcYCw8cApzXf34OmqZ4N7IntoRPU=;
        b=zxgyvUeS0Xg94Ioy0XZqYGbUyyyj9B5L7d7THRh+Do+o1Akm/8RhR+ZeO3vHcA+ZiO
         VVJ0hWrtrW8DH7xFfA+gBDzvNWvLbc4OCOTnP8zxV3lDr7ZtrMKgnF/UhD0gX7UniYbj
         ynXWHzevC7bg0lhjTKrxXZWXvh9iHHrrGqEmnR1GtgvcyLyjnK/nKIrt6ZDsZ450zKG2
         AHcTG09cCfCDjDhOzjBjInvZ5GYc+32UNPdCMt5InJYBwtPHDmxpblo9aOkyyOZ0QkzE
         qC3dpd2zsY1hXIzleuXTh46lZ0ScTlE2vYMxzbHJP+ApZNMwYBmVkzSDO6WPdREdAuvP
         jpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fdeavgxgnxhsv/ZkcYCw8cApzXf34OmqZ4N7IntoRPU=;
        b=cSZrQG/PSNE2Fw4U5BR2kk6gRsdOVRfoqe5zEVj3vIMQBzSvLMk6r4X3IHbFGqs40E
         b6sBMnZGMCR1iqcE+F1c3O29JDeXURukEurQBkBCzWaMd/6XD5okcAN7JWwE1PIwszrj
         Fo9/ZI/The0FiPycNNwuMsVpm7ovWSHi8QN0yggyxsSMmO4lsfo9fn0xRlu2yVjKEpZJ
         cZ3rJuECUZm4CiEmbxo73/ZWq4d2c+GJSNHZxtqQTIbhy5Iw21MwxdNdIYn6uNZaWoxx
         UVLVGGLciktZoBUVfnkrwsA587MkijMslV/2n2mtjnb/loGn8A+RKahvsZPVisG7Y6Wt
         2nPA==
X-Gm-Message-State: APjAAAVg9BVhLgi+OfX1HE2ds/wPWSjy5+cOQyY47RjwFwOfrREGMBUR
        Ie/HNwxkHNzLsxHQxqRHgIe99cIKQSE=
X-Google-Smtp-Source: ADFU+vvChiyxf++IVTaw/rQSmqMNkeBEqPMgGM2bc0FbdOsCmGpXjt5uMhEprCpDiI6PRQa8jjuJcA==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2823346ljj.97.1582718117454;
        Wed, 26 Feb 2020 03:55:17 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id q8sm1064411lfn.90.2020.02.26.03.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:55:16 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:55:16 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
Message-ID: <20200226115516.GF3165317@oden.dyn.berto.se>
References: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
 <46d8fe77-57f1-83e3-33ae-5080c6de2424@kernel.org>
 <20200226112433.GD3165317@oden.dyn.berto.se>
 <317d0a0d-8046-237b-9c22-7729e6053ab0@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <317d0a0d-8046-237b-9c22-7729e6053ab0@ideasonboard.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kieran,

Thanks for your feedback.

On 2020-02-26 11:35:45 +0000, Kieran Bingham wrote:
> Hi Niklas,
> 
> On 26/02/2020 11:24, Niklas Söderlund wrote:
> > Hi Kieran,
> > 
> > Thanks for your feedback.
> > 
> > On 2020-02-26 09:05:22 +0000, Kieran Bingham wrote:
> >> Hi Niklas,
> >>
> >> On 12/02/2020 22:49, Niklas Söderlund wrote:
> >>> The desired behavior of the driver is to generate an interrupt and call
> >>
> >> s/behavior/behaviour/ but that's me being English, so you can ignore
> >> that ... (at your peril ... :-D )
> >>
> > 
> > I have a hard time as it is trying to spell the "other" version of the 
> > language I been exposed to since early years, throwing more 'u' at it 
> > will only add to my confusion ;-)
> > 
> >>> thermal_zone_device_update() as soon as the temperature have changed
> >>> more then one degree.
> >>>
> >>> When the set_trips operation was implemented it was believed that the
> >>> trip window set by the framework would move around the current
> >>> temperature and the hysteresis value described in devicetree. The
> >>
> >> Should the hysteresis value described in devicetree be a part of the
> >> +-MCELCIUS(1) calculations? or is it determined that a one degree window
> >> each side is sufficient to contain such hysteresis of the readings?
> > 
> > The hardware testers wanted a fixed 1 degree window.
> 
> But my question is what is the value described in devicetree.
> Should it be involved in the calculation somewhere?

Not for the window used to trigger and IRQ, the hysteresis is used with 
the trip points. This change does not effect that part. This change adds 
an interrupt if the temperature suddenly spikes more then 1 degree in 
addition to the polling mode implemented in thermal core (described as 
polling-delay-passive, polling-delay) which reads the temperature 
periodically for the trip points.

> 
> I.e. if the devicetree specifies that the hysteresis of the hardware is
> (guessing) say "0.2 degree", does that mean that the 'window' must be at
> least that value.
> 
> And picking on that purely as an example as I don't know the value or
> meaning of the one in DT, but therefore - if there was hardware that
> then had a 2 degree hysteresis, this fixed-1-degree window would have to
> be:
> 
>  +	low = temperature - min(MCELSIUS(1), MCELSIUS(hysteresis_val);
>  +	high = temperature + min(MCELSIUS(1), MCELSIUS(hysteresis_val));
> 
> 
> Or perhaps I'm just mis-understanding the reference of the hysteresis
> value anyway.
> 
> 
> I see there is still a 'trips' section in the thermal documentation example.
> 
> Should that be removed? or is it handled by core?

It's handled by core. The trip points define different operations that 
could happen if the temperature go above/bellow it. For the example in 
the documentation it says if the temperature go above 90 with a 
hysteresis of 2 we reached the critical stage and the SoC will be 
powered off (I think the action can be specified in user space).

> 
> 
> 
> 
> >>> behavior of the framework is however to set a window based on the trip
> >>> points described in devicetree.
> >>>
> >>> Remove the set_trips operation which was not used correctly and update
> >>> the temperatures that triggers interrupts directly from the interrupt
> >>> handler.
> >>>
> >>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> >>
> >> Sounds good to me.
> >>
> >> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > Thanks! Unfortunately the patch is already merged so it will be hard to 
> > add your tag.
> 
> No problem, I saw it on linux-renesas-soc and was curious ;-)
> --
> Kieran
> 
> 
> > 
> >>
> >>> ---
> >>>  drivers/thermal/rcar_gen3_thermal.c | 24 ++++++++++++------------
> >>>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> >>> index 72877bdc072daaed..55d1736f532cdb33 100644
> >>> --- a/drivers/thermal/rcar_gen3_thermal.c
> >>> +++ b/drivers/thermal/rcar_gen3_thermal.c
> >>> @@ -81,8 +81,6 @@ struct rcar_gen3_thermal_tsc {
> >>>  	void __iomem *base;
> >>>  	struct thermal_zone_device *zone;
> >>>  	struct equation_coefs coef;
> >>> -	int low;
> >>> -	int high;
> >>>  	int tj_t;
> >>>  	int id; /* thermal channel id */
> >>>  };
> >>> @@ -204,12 +202,14 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
> >>>  	return INT_FIXPT(val);
> >>>  }
> >>>  
> >>> -static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> >>> +static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
> >>>  {
> >>> -	struct rcar_gen3_thermal_tsc *tsc = devdata;
> >>> +	int temperature, low, high;
> >>>  
> >>> -	low = clamp_val(low, -40000, 120000);
> >>> -	high = clamp_val(high, -40000, 120000);
> >>> +	rcar_gen3_thermal_get_temp(tsc, &temperature);
> >>> +
> >>> +	low = temperature - MCELSIUS(1);
> >>> +	high = temperature + MCELSIUS(1);
> >>>  
> >>>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
> >>>  				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
> >>> @@ -217,15 +217,11 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> >>>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
> >>>  				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
> >>>  
> >>> -	tsc->low = low;
> >>> -	tsc->high = high;
> >>> -
> >>>  	return 0;
> >>>  }
> >>>  
> >>>  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> >>>  	.get_temp	= rcar_gen3_thermal_get_temp,
> >>> -	.set_trips	= rcar_gen3_thermal_set_trips,
> >>>  };
> >>>  
> >>>  static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
> >>> @@ -246,9 +242,11 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
> >>>  	for (i = 0; i < priv->num_tscs; i++) {
> >>>  		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
> >>>  		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> >>> -		if (status)
> >>> +		if (status) {
> >>> +			rcar_gen3_thermal_update_range(priv->tscs[i]);
> >>>  			thermal_zone_device_update(priv->tscs[i]->zone,
> >>>  						   THERMAL_EVENT_UNSPECIFIED);
> >>> +		}
> >>>  	}
> >>>  
> >>>  	return IRQ_HANDLED;
> >>> @@ -454,6 +452,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >>>  		if (ret < 0)
> >>>  			goto error_unregister;
> >>>  
> >>> +		rcar_gen3_thermal_update_range(tsc);
> >>> +
> >>>  		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
> >>>  	}
> >>>  
> >>> @@ -492,7 +492,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> >>>  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> >>>  
> >>>  		priv->thermal_init(tsc);
> >>> -		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
> >>> +		rcar_gen3_thermal_update_range(tsc);
> >>>  	}
> >>>  
> >>>  	rcar_thermal_irq_set(priv, true);
> >>>
> >>
> > 
> 

-- 
Regards,
Niklas Söderlund

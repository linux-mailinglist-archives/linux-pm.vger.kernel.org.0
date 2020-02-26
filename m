Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF04816FD6C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 12:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBZLYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 06:24:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33823 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZLYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:24:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so2685651ljc.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EPHgzFYs7QzqIt9nBY4EYuu/F8O9Sp2fSHekThnbgzg=;
        b=IdiwVBeHXd3tD7DoMmW6bSA3sHMeb2XWKjRq9VMY3ffjN7rWpata6u22yH6leapxOM
         alH59vYC++9OHzUQg33R/RNNcCviUIAYb3CZ+ZasgJsXJLEJprBouGHInf8+wwuOid4c
         XYLSVuzljMgRQ/kyErAVVJ6V3v0jfBEX2DrfGPs1cL9T4l1zAmkjMy1TLHdaJMypDO7u
         uXIObYecTxpgahQ5PVtyU6NBGU5CqgAmXrCD+RN16oB8+seWsNk370BuL+UaGDN1wW4R
         scv0DUeiYdfvtfM4XB6sjpxq05Kgev80y8Mwwj/+GELhECCFIoCK/AhOyIitHyNKdV86
         A6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EPHgzFYs7QzqIt9nBY4EYuu/F8O9Sp2fSHekThnbgzg=;
        b=t9dEi2GxEQAiKarJQVfIuAT2RfdFwF/7NZj0ivjxHuz/sOkgD4RWbIPLvjVK+YZQ6y
         GDnCWPq/xh/cAhGxgUR6rYYFpJbKshFqb715XCIS2RWbJCG246n94Zsl9N1ZtPI4v+jW
         gwFuqTGu6MQS/2MoEumVmQThmtG5X6XMAjR9sexcWey8cwI3NV/DQ/bFNaq1OAgD96rh
         39Kv+EoqjIJXHPTj3fXjuPq6tG5cwD9hKX6bVjQyXhxfgV3fjRSYU8CE31rrQ29pIXZ0
         7eUkL5YTB+FlgYMSIQKy9DH++VL3sz/FNTGV+U+hqoiDWkCChG7tJKN5pKVfVbak22Bm
         EDdQ==
X-Gm-Message-State: APjAAAXghRjwTuojYF3WyXxXctGvDjcPjebIBpm3KwF+qzr5Yo3WVksA
        Oj8+Qw4K7gce7wRKdIYJF8xWCUzKOIw=
X-Google-Smtp-Source: APXvYqwkac5LM/aAO6i6HmhOicbmB2PRJd04eJzaCZAf/fSGmkZxRPhle8mDD57FkhU+9YzxxSOxTA==
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr2709521ljk.228.1582716275305;
        Wed, 26 Feb 2020 03:24:35 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id p12sm842798lfc.43.2020.02.26.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:24:33 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:24:33 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Kieran Bingham <kbingham@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
Message-ID: <20200226112433.GD3165317@oden.dyn.berto.se>
References: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
 <46d8fe77-57f1-83e3-33ae-5080c6de2424@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46d8fe77-57f1-83e3-33ae-5080c6de2424@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kieran,

Thanks for your feedback.

On 2020-02-26 09:05:22 +0000, Kieran Bingham wrote:
> Hi Niklas,
> 
> On 12/02/2020 22:49, Niklas Söderlund wrote:
> > The desired behavior of the driver is to generate an interrupt and call
> 
> s/behavior/behaviour/ but that's me being English, so you can ignore
> that ... (at your peril ... :-D )
> 

I have a hard time as it is trying to spell the "other" version of the 
language I been exposed to since early years, throwing more 'u' at it 
will only add to my confusion ;-)

> > thermal_zone_device_update() as soon as the temperature have changed
> > more then one degree.
> > 
> > When the set_trips operation was implemented it was believed that the
> > trip window set by the framework would move around the current
> > temperature and the hysteresis value described in devicetree. The
> 
> Should the hysteresis value described in devicetree be a part of the
> +-MCELCIUS(1) calculations? or is it determined that a one degree window
> each side is sufficient to contain such hysteresis of the readings?

The hardware testers wanted a fixed 1 degree window.

> 
> > behavior of the framework is however to set a window based on the trip
> > points described in devicetree.
> > 
> > Remove the set_trips operation which was not used correctly and update
> > the temperatures that triggers interrupts directly from the interrupt
> > handler.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Sounds good to me.
> 
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Thanks! Unfortunately the patch is already merged so it will be hard to 
add your tag.

> 
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> > index 72877bdc072daaed..55d1736f532cdb33 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -81,8 +81,6 @@ struct rcar_gen3_thermal_tsc {
> >  	void __iomem *base;
> >  	struct thermal_zone_device *zone;
> >  	struct equation_coefs coef;
> > -	int low;
> > -	int high;
> >  	int tj_t;
> >  	int id; /* thermal channel id */
> >  };
> > @@ -204,12 +202,14 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
> >  	return INT_FIXPT(val);
> >  }
> >  
> > -static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> > +static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
> >  {
> > -	struct rcar_gen3_thermal_tsc *tsc = devdata;
> > +	int temperature, low, high;
> >  
> > -	low = clamp_val(low, -40000, 120000);
> > -	high = clamp_val(high, -40000, 120000);
> > +	rcar_gen3_thermal_get_temp(tsc, &temperature);
> > +
> > +	low = temperature - MCELSIUS(1);
> > +	high = temperature + MCELSIUS(1);
> >  
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
> >  				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
> > @@ -217,15 +217,11 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
> >  				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
> >  
> > -	tsc->low = low;
> > -	tsc->high = high;
> > -
> >  	return 0;
> >  }
> >  
> >  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> >  	.get_temp	= rcar_gen3_thermal_get_temp,
> > -	.set_trips	= rcar_gen3_thermal_set_trips,
> >  };
> >  
> >  static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
> > @@ -246,9 +242,11 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
> >  	for (i = 0; i < priv->num_tscs; i++) {
> >  		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
> >  		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> > -		if (status)
> > +		if (status) {
> > +			rcar_gen3_thermal_update_range(priv->tscs[i]);
> >  			thermal_zone_device_update(priv->tscs[i]->zone,
> >  						   THERMAL_EVENT_UNSPECIFIED);
> > +		}
> >  	}
> >  
> >  	return IRQ_HANDLED;
> > @@ -454,6 +452,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  		if (ret < 0)
> >  			goto error_unregister;
> >  
> > +		rcar_gen3_thermal_update_range(tsc);
> > +
> >  		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
> >  	}
> >  
> > @@ -492,7 +492,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> >  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> >  
> >  		priv->thermal_init(tsc);
> > -		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
> > +		rcar_gen3_thermal_update_range(tsc);
> >  	}
> >  
> >  	rcar_thermal_irq_set(priv, true);
> > 
> 

-- 
Regards,
Niklas Söderlund

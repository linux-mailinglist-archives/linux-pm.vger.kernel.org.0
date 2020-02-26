Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94316FA32
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 10:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgBZJF3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 04:05:29 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34780 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBZJF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 04:05:29 -0500
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 570C543F;
        Wed, 26 Feb 2020 10:05:26 +0100 (CET)
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
From:   Kieran Bingham <kbingham@kernel.org>
Message-ID: <46d8fe77-57f1-83e3-33ae-5080c6de2424@kernel.org>
Date:   Wed, 26 Feb 2020 09:05:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On 12/02/2020 22:49, Niklas Söderlund wrote:
> The desired behavior of the driver is to generate an interrupt and call

s/behavior/behaviour/ but that's me being English, so you can ignore
that ... (at your peril ... :-D )

> thermal_zone_device_update() as soon as the temperature have changed
> more then one degree.
> 
> When the set_trips operation was implemented it was believed that the
> trip window set by the framework would move around the current
> temperature and the hysteresis value described in devicetree. The

Should the hysteresis value described in devicetree be a part of the
+-MCELCIUS(1) calculations? or is it determined that a one degree window
each side is sufficient to contain such hysteresis of the readings?

> behavior of the framework is however to set a window based on the trip
> points described in devicetree.
> 
> Remove the set_trips operation which was not used correctly and update
> the temperatures that triggers interrupts directly from the interrupt
> handler.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Sounds good to me.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 72877bdc072daaed..55d1736f532cdb33 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -81,8 +81,6 @@ struct rcar_gen3_thermal_tsc {
>  	void __iomem *base;
>  	struct thermal_zone_device *zone;
>  	struct equation_coefs coef;
> -	int low;
> -	int high;
>  	int tj_t;
>  	int id; /* thermal channel id */
>  };
> @@ -204,12 +202,14 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
>  	return INT_FIXPT(val);
>  }
>  
> -static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> +static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
>  {
> -	struct rcar_gen3_thermal_tsc *tsc = devdata;
> +	int temperature, low, high;
>  
> -	low = clamp_val(low, -40000, 120000);
> -	high = clamp_val(high, -40000, 120000);
> +	rcar_gen3_thermal_get_temp(tsc, &temperature);
> +
> +	low = temperature - MCELSIUS(1);
> +	high = temperature + MCELSIUS(1);
>  
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
>  				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
> @@ -217,15 +217,11 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
>  				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
>  
> -	tsc->low = low;
> -	tsc->high = high;
> -
>  	return 0;
>  }
>  
>  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
>  	.get_temp	= rcar_gen3_thermal_get_temp,
> -	.set_trips	= rcar_gen3_thermal_set_trips,
>  };
>  
>  static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
> @@ -246,9 +242,11 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>  	for (i = 0; i < priv->num_tscs; i++) {
>  		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
>  		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> -		if (status)
> +		if (status) {
> +			rcar_gen3_thermal_update_range(priv->tscs[i]);
>  			thermal_zone_device_update(priv->tscs[i]->zone,
>  						   THERMAL_EVENT_UNSPECIFIED);
> +		}
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -454,6 +452,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto error_unregister;
>  
> +		rcar_gen3_thermal_update_range(tsc);
> +
>  		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
>  	}
>  
> @@ -492,7 +492,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>  
>  		priv->thermal_init(tsc);
> -		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
> +		rcar_gen3_thermal_update_range(tsc);
>  	}
>  
>  	rcar_thermal_irq_set(priv, true);
> 


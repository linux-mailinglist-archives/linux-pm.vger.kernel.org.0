Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D668ED7B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBHLGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 06:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBHLGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 06:06:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3420696
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 03:06:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y1so16366391wru.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 03:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/O99q2mqAnU1YJFg0RL3IQ6v1yxtSNH23Gl9fNWxd0=;
        b=teX6wrX/Q97Bvr5pqIzAFCji9BfOB31/BQFFkpvxEmvMu54kF5elITaRwQIOdiPb7E
         k+xxjj7idBEyEjwFSYhlHQHtXMkzJ9DHdYKck/aQEAxUk7M91EJMXyszC33vRv5c+0ja
         4AT5QM/NOgyUSPTYngDp4/LNhCas8myXTKzKt8XkppYY8GkcUKBj9bzdk2GkXEDVdRIe
         32Z8i5LA+da6SkTtB2SNt74B9Q8ItYOMxfAwqlQPBWz+tdhgLdjch4SvVBrQigfG7FlZ
         GljpKADp/RGS9qmGKWUlDrW8HPuP02TaRAbL0NFO0j+cs8o9+Gvkd5Q3bbpV2MsbcUFI
         FEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/O99q2mqAnU1YJFg0RL3IQ6v1yxtSNH23Gl9fNWxd0=;
        b=RELRvyP16/dFBoT7W5e4TNkBhixE2VtMOcqOrLA62vxBmxEStUH2KMYimuSyXHNBoj
         F6UcnO1uxIQvMtfo3FkgMFfpNjUo6fgFMUIsL/70ErXIILL1/zsgIapay9luIID7v3sn
         youGvsjMBzs/lARwLW0e44Oxf93O+NVI7hDgVi6X4dkPNhUotDR9W36lSkj1NDxrWoQO
         PzZvQy3gSH8iMFxs2EDOjV8cfqUJVjxeq4LsltPUgdoL/jvu5JkkOqb6MKi1fgqHSRN7
         VLdj8HDO8B7eHJLoZWpHt1HZ/TZuG5qxJV49rrZvnm6U9BlQ3eXQVRHv7VtQH01lJj3y
         Ql5w==
X-Gm-Message-State: AO0yUKWa0wO8gDI0UsEFgcgpbbttShEDlXj/EYWl8iF9xdFmLKf9Y4JT
        pzj2f8w/zXRzj6QIYjP4/YMk1ftS9ddB40Xi
X-Google-Smtp-Source: AK7set8ADPhyhkhxlwNghIAevpvA+VWCXiTsS1EXnFuaiGNqTjHGrIXZD2kzfFHVr0QflAg80zAnHA==
X-Received: by 2002:adf:e950:0:b0:2bf:d2d8:d604 with SMTP id m16-20020adfe950000000b002bfd2d8d604mr6535615wrn.46.1675854399613;
        Wed, 08 Feb 2023 03:06:39 -0800 (PST)
Received: from [172.17.49.168] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id p10-20020a5d59aa000000b002be5401ef5fsm13764145wrr.39.2023.02.08.03.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 03:06:39 -0800 (PST)
Message-ID: <8649a674-bbd4-435c-5574-c0c633988e66@linaro.org>
Date:   Wed, 8 Feb 2023 12:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drivers/thermal/rcar_gen3_thermal: Fix device
 initialization
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
 <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/02/2023 18:10, Niklas Söderlund wrote:
> The thermal zone is registered before the device is register and the
> thermal coefficients are calculated, providing a window for very
> incorrect readings.
> 
> The reason why the zone was register before the device was fully
> initialized was that the presence of the set_trips() callback is used to
> determine if the driver supports interrupt or not, as it is not defined
> if the device is incapable of interrupts.
> 
> Fix this by using the operations structure in the private data instead
> of the zone to determine if interrupts are available or not, and
> initialize the device before registering the zone.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>   drivers/thermal/rcar_gen3_thermal.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index bfa2ff20b945..1dedeece1a00 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -89,7 +89,8 @@ struct rcar_gen3_thermal_priv {
>   	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>   	struct thermal_zone_device_ops ops;
>   	unsigned int num_tscs;
> -	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
> +	void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
> +			     struct rcar_gen3_thermal_tsc *tsc);
>   	int ptat[3];
>   };
>   
> @@ -240,7 +241,7 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>   	for (i = 0; i < priv->num_tscs; i++) {
>   		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
>   		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> -		if (status)
> +		if (status && priv->tscs[i]->zone)
>   			thermal_zone_device_update(priv->tscs[i]->zone,
>   						   THERMAL_EVENT_UNSPECIFIED);
>   	}
> @@ -311,7 +312,8 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
>   	return true;
>   }
>   
> -static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
> +static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_priv *priv,
> +					      struct rcar_gen3_thermal_tsc *tsc)
>   {
>   	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
>   	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
> @@ -322,7 +324,7 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
>   
>   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
>   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> -	if (tsc->zone->ops->set_trips)
> +	if (priv->ops.set_trips)
>   		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
>   					IRQ_TEMPD1 | IRQ_TEMP2);
>   
> @@ -338,7 +340,8 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
>   	usleep_range(1000, 2000);
>   }
>   
> -static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> +static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
> +				   struct rcar_gen3_thermal_tsc *tsc)
>   {
>   	u32 reg_val;
>   
> @@ -350,7 +353,7 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>   
>   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
>   	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> -	if (tsc->zone->ops->set_trips)
> +	if (priv->ops.set_trips)
>   		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
>   					IRQ_TEMPD1 | IRQ_TEMP2);
>   
> @@ -510,6 +513,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>   	for (i = 0; i < priv->num_tscs; i++) {
>   		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>   
> +		priv->thermal_init(priv, tsc);
> +		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
> +
>   		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
>   		if (IS_ERR(zone)) {
>   			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
> @@ -518,9 +524,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>   		}
>   		tsc->zone = zone;
>   
> -		priv->thermal_init(tsc);
> -		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
> -
>   		tsc->zone->tzp->no_hwmon = false;
>   		ret = thermal_add_hwmon_sysfs(tsc->zone);
>   		if (ret)
> @@ -559,8 +562,8 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>   		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>   		struct thermal_zone_device *zone = tsc->zone;
>   
> -		priv->thermal_init(tsc);
> -		if (zone->ops->set_trips)
> +		priv->thermal_init(priv, tsc);
> +		if (priv->ops.set_trips)
>   			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
>   						    zone->prev_high_trip);

This is not needed, at resume time, the thermal framework has a 
pm_notifier and calls thermal_zone_device_update() which in turn calls 
thermal_zone_set_trips(). If the ops is not set, it will continue.

Actually, no call to set_trips should happen in the driver, just pass 
the ops the thermal framework and it will do the actions.

The same happens when you call thermal_zone_device_register(), it calls 
thermal_zone_device_update(), then thermal_zone_set_trips().


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


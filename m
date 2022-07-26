Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73258580B90
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiGZGYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 02:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiGZGYd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 02:24:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7C6599
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 23:20:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b21so8427051ljk.8
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rb2ySu9Zl15fxW44cCCElhq9r7i1rewTrkcmDvDCTaM=;
        b=Jvru7a9cQHQg1z3Swh1/i6cXvh1uCzrdqEcaYUFamriLhRu31E8JfCG2tw0VnSFufN
         OAB78nmv2gqj6ZfGBakm7xqAgk7ftWngPu37XwD0WaukBFkaNfWn9d5+BWOR4Kwz8WaE
         0wqx1CDqn5Na/advzEgn0KOas7d+2daAkrteIs0WCTxJT8QLW7VXF9tIBbdROze6iSSq
         PXgUaODqG0+LSP0Ft8lJJn5i4m+u5CQyFDptKjRi+zvrRIiFdNCk1vJGW6+USvEDgrKk
         7ESVFfcjXXYhGMflJJ28zaJPvr+qAUwKWaxiliRPoHd+4JOzw7nsYVTEtdGxnzAy2DWJ
         rNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rb2ySu9Zl15fxW44cCCElhq9r7i1rewTrkcmDvDCTaM=;
        b=L+VTqmsZrRCPL56IH8/1cwEzEBnzYM/coTNtgK04kw0rjFh0aSeIjT7ochTwr6QLON
         75HpG8qHqrS0fxffhOyF1zPYQwoTBhAWR1CVkQOwTsKTwk5G+5PHJtE6rNFB+b2QIq1k
         jBtxJXlw+r2egjzeVMCmbZs6eGnvDtGzccAXwLH+e2qVwOMFP6Rfsi6yxfJ/Psyq+FtR
         0Sn0RX0aako8Dd1dRMiBHNVCJZlGst9zKgO+HVp/Jkt2UVrPA8yESbzQrqVADH+jpadQ
         Wa8gx1If6mh3zheQkeWJqjnbdmEM9HEQTVukrRa7hTxfxeVWzBofJCnYYsPzfxu56DHk
         ksvA==
X-Gm-Message-State: AJIora9zsIEbbV286JLgohA71xg32F+BLOCJHeS96SxaBa8h+DFy/BAy
        ulGoMuxHD16GDM8l2CccWHJM+A==
X-Google-Smtp-Source: AGRyM1uPiaqoGs0X58ByTAteooNM8/4fhGpT9go52rlHyI421NNxbtpvAL3YGLvlwmdLm8KKSAnQ4A==
X-Received: by 2002:a2e:9e17:0:b0:25d:78d8:407f with SMTP id e23-20020a2e9e17000000b0025d78d8407fmr5622681ljk.433.1658816410141;
        Mon, 25 Jul 2022 23:20:10 -0700 (PDT)
Received: from localhost (h-46-59-88-103.A463.priv.bahnhof.se. [46.59.88.103])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651234ce00b0048a7ce3ff84sm1979332lfr.285.2022.07.25.23.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 23:20:09 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:20:08 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 17/32] thermal/drivers/rcar: Switch to new of API
Message-ID: <Yt+HmDK/NX2AUDMr@oden.dyn.berto.se>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
 <20220725212637.2818207-18-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725212637.2818207-18-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 2022-07-25 23:26:22 +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

The series do not apply to the branch in the cover-letter so this is 
tested with the two series directly from the list on-top of v5.19-rc2.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 16 ++++++++--------
>  drivers/thermal/rcar_thermal.c      | 13 +++----------
>  2 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 43eb25b167bc..29946114a8f9 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -164,9 +164,9 @@ static int rcar_gen3_thermal_round(int temp)
>  	return result * RCAR3_THERMAL_GRAN;
>  }
>  
> -static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> +static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct rcar_gen3_thermal_tsc *tsc = devdata;
> +	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
>  	int mcelsius, val;
>  	int reg;
>  
> @@ -203,9 +203,9 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
>  	return INT_FIXPT(val);
>  }
>  
> -static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
> +static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
>  {
> -	struct rcar_gen3_thermal_tsc *tsc = devdata;
> +	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;

Hi Daniel,

The series do not apply to the 
>  	u32 irqmsk = 0;
>  
>  	if (low != -INT_MAX) {
> @@ -225,7 +225,7 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
>  	return 0;
>  }
>  
> -static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> +static struct thermal_zone_device_ops rcar_gen3_tz_of_ops = {
>  	.get_temp	= rcar_gen3_thermal_get_temp,
>  	.set_trips	= rcar_gen3_thermal_set_trips,
>  };
> @@ -504,8 +504,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	for (i = 0; i < priv->num_tscs; i++) {
>  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>  
> -		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
> -							    &rcar_gen3_tz_of_ops);
> +		zone = devm_thermal_of_zone_register(dev, i, tsc,
> +						     &rcar_gen3_tz_of_ops);
>  		if (IS_ERR(zone)) {
>  			dev_err(dev, "Can't register thermal zone\n");
>  			ret = PTR_ERR(zone);
> @@ -556,7 +556,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>  
>  		priv->thermal_init(tsc);
>  		if (zone->ops->set_trips)
> -			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
> +			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
>  						    zone->prev_high_trip);
>  	}
>  
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 1d729ed4d685..4df42d70d867 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -271,13 +271,6 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
>  	return 0;
>  }
>  
> -static int rcar_thermal_of_get_temp(void *data, int *temp)
> -{
> -	struct rcar_thermal_priv *priv = data;
> -
> -	return rcar_thermal_get_current_temp(priv, temp);
> -}
> -
>  static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
>  {
>  	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> @@ -323,8 +316,8 @@ static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
>  	return 0;
>  }
>  
> -static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops = {
> -	.get_temp	= rcar_thermal_of_get_temp,
> +static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
> +	.get_temp	= rcar_thermal_get_temp,
>  };
>  
>  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> @@ -534,7 +527,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			goto error_unregister;
>  
>  		if (chip->use_of_thermal) {
> -			priv->zone = devm_thermal_zone_of_sensor_register(
> +			priv->zone = devm_thermal_of_zone_register(
>  						dev, i, priv,
>  						&rcar_thermal_zone_of_ops);
>  		} else {
> -- 
> 2.25.1
> 

-- 
Kind Regards,
Niklas Söderlund

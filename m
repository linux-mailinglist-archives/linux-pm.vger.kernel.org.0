Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3F54C659
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbiFOKkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbiFOKkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 06:40:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED5506FD
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 03:40:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o1QRJ-000199-KQ; Wed, 15 Jun 2022 12:39:57 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o1QRI-0004FZ-SO; Wed, 15 Jun 2022 12:39:56 +0200
Date:   Wed, 15 Jun 2022 12:39:56 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 4/9] imx: thermal: Configure trip point from DT
Message-ID: <20220615103956.qm3o45n2hyuylgwf@pengutronix.de>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
 <20220615094804.388280-5-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615094804.388280-5-francesco.dolcini@toradex.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,

nice patch, only a few nits.

On 22-06-15, Francesco Dolcini wrote:
> Allow over-writing critical and passive trip point for each
> temperature grade from the device tree, by default the pre-existing
> hard-coded trip points are used.
> 
> This change enables configuring the system thermal characteristics into
> the system-specific device tree instead of relying on global hard-coded
> temperature thresholds that does not take into account the specific
> system thermal design.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/thermal/imx_thermal.c | 49 +++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 16663373b682..ef3e152b5ee2 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -17,6 +17,8 @@
>  #include <linux/nvmem-consumer.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "thermal_core.h"
> +
>  #define REG_SET		0x4
>  #define REG_CLR		0x8
>  #define REG_TOG		0xc
> @@ -479,36 +481,83 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
>  	return 0;
>  }
>  
> +static void imx_init_temp_from_of(struct platform_device *pdev, const char *name)
> +{
> +	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> +	struct device_node *thermal, *trips, *trip_point;
> +
> +	thermal = of_get_child_by_name(pdev->dev.of_node, name);

here I would do:

	if (!thermal)
		return;

since the thermal node is only available with your dt-changes in place.

> +	trips = of_get_child_by_name(thermal, "trips");
> +
> +	for_each_child_of_node(trips, trip_point) {
> +		struct thermal_trip t;
> +
> +		if (thermal_of_populate_trip(trip_point, &t))
> +			continue;
> +
> +		switch (t.type) {
> +		case THERMAL_TRIP_PASSIVE:
> +			data->temp_passive = t.temperature;
> +			break;
> +		case THERMAL_TRIP_CRITICAL:
> +			data->temp_critical = t.temperature;
> +			break;
> +		default:
> +			dev_dbg(&pdev->dev, "Ignoring trip type %d\n", t.type);
			  ^
Maybe it is worth to use dev_info() since this never should happen and
if it happen, it is a bug/misconfiguration/misusage.

> +			break;
> +		}
> +	};
> +
> +	of_node_put(trips);
> +	of_node_put(thermal);
> +
> +	if (data->temp_passive >= data->temp_critical) {
> +		dev_warn(&pdev->dev,
> +			 "passive trip point must be lower than critical, fixing it up\n");
> +		data->temp_passive = data->temp_critical - (1000 * 5);
								^
			Magic number? Maybe it would be worth a comment.

Regards,
  Marco

> +	}
> +}
> +
>  static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
>  {
>  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> +	const char *thermal_node_name;
>  
>  	/* The maximum die temp is specified by the Temperature Grade */
>  	switch ((ocotp_mem0 >> 6) & 0x3) {
>  	case 0: /* Commercial (0 to 95 °C) */
> +		thermal_node_name = "commercial-thermal";
>  		data->temp_grade = "Commercial";
>  		data->temp_max = 95000;
>  		break;
>  	case 1: /* Extended Commercial (-20 °C to 105 °C) */
> +		thermal_node_name = "extended-commercial-thermal";
>  		data->temp_grade = "Extended Commercial";
>  		data->temp_max = 105000;
>  		break;
>  	case 2: /* Industrial (-40 °C to 105 °C) */
> +		thermal_node_name = "industrial-thermal";
>  		data->temp_grade = "Industrial";
>  		data->temp_max = 105000;
>  		break;
>  	case 3: /* Automotive (-40 °C to 125 °C) */
> +		thermal_node_name = "automotive-thermal";
>  		data->temp_grade = "Automotive";
>  		data->temp_max = 125000;
>  		break;
>  	}
>  
>  	/*
> +	 * Set defaults trips
> +	 *
>  	 * Set the critical trip point at 5 °C under max
>  	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
>  	 */
>  	data->temp_critical = data->temp_max - (1000 * 5);
>  	data->temp_passive = data->temp_max - (1000 * 10);
> +
> +	/* Override critical/passive temperature from devicetree */
> +	imx_init_temp_from_of(pdev, thermal_node_name);
>  }
>  
>  static int imx_init_from_tempmon_data(struct platform_device *pdev)
> -- 
> 2.25.1
> 
> 
> 

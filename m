Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17466528DB3
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbiEPTGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 May 2022 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbiEPTGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 15:06:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853421268
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 12:06:15 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nqg2m-0002na-G3; Mon, 16 May 2022 21:06:12 +0200
Message-ID: <92ae0fd5-f827-ae3c-bbef-d551c9fa5b76@pengutronix.de>
Date:   Mon, 16 May 2022 21:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        l.stach@pengutronix.de, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220516190001.147919-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16.05.22 21:00, Francesco Dolcini wrote:
> Currently the imx thermal driver has a hardcoded critical temperature
> value offset of 5 Celsius degrees from the actual SoC maximum
> temperature.
> 
> This affects applications and systems designed to be working on this close
> to the limit, but yet valid, temperature range.
> 
> Given that there is no single value that will fit all the use cases make
> the critical trip point offset from the max temperature configurable
> using a newly added trip_offset module parameter, passive trip point is
> set to 5 Celsius degrees less than the critical. By default the
> system behaves exactly as before.
> 
> Link: https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/thermal/imx_thermal.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 16663373b682..42d1f8a3eccb 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -86,6 +86,10 @@ enum imx_thermal_trip {
>  #define TEMPMON_IMX6SX			2
>  #define TEMPMON_IMX7D			3
>  
> +static int trip_offset = 5;
> +module_param(trip_offset, int, 0444);

Is this being r--r--r-- intended?

> +MODULE_PARM_DESC(trip_offset, "Critical trip point offset from CPU max temp in Celsius degrees (default 5)");
> +
>  struct thermal_soc_data {
>  	u32 version;
>  
> @@ -504,11 +508,11 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
>  	}
>  
>  	/*
> -	 * Set the critical trip point at 5 °C under max
> -	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
> +	 * Set the critical trip point at 5 °C under max (changeable via module param)
> +	 * Set the passive trip point at 5 °C under critical (changeable via sysfs)
>  	 */
> -	data->temp_critical = data->temp_max - (1000 * 5);
> -	data->temp_passive = data->temp_max - (1000 * 10);
> +	data->temp_critical = data->temp_max - (1000 * trip_offset);
> +	data->temp_passive = data->temp_critical - (1000 * 5);
>  }
>  
>  static int imx_init_from_tempmon_data(struct platform_device *pdev)


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

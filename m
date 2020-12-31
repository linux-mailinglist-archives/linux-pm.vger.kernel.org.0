Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17B22E8023
	for <lists+linux-pm@lfdr.de>; Thu, 31 Dec 2020 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLaMzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Dec 2020 07:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgLaMzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2020 07:55:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60235C061573;
        Thu, 31 Dec 2020 04:55:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o13so43915092lfr.3;
        Thu, 31 Dec 2020 04:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o561zXcFz+lprPcoBSWJ30moRo9BkHfNcbWfQxWHUqY=;
        b=u97whO8Cdc3ZdgBeh5qxgBHcuR2NcoCXxumLQLydgqgxVQTHwVCPdaHWcx3tLSbzC5
         FuxIaGK4zf+0FqtTLsEEacdr9ItvDpY8/OEmXog5EcNMlPyB4IwlyBHTr8YZGU0FgNVc
         CrfZpK+13fkKm1XN3NrRWO/pVveCSz5AStMiTm/C3IROpr7lay1yEwCtHPw7JpIcQ/lH
         +AMYeu890Qd8cuoa/RkkfjFNgsIr2a9XGYUXzMs5jwByjzm0cFmD03wfyWLbalgPNm/+
         tfIuNt5MYAo7ee8z2OZFFXklamQrK4sa0qslBO/+dylr7nnfqUed3B8KZfPrLUpeHubL
         Eo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o561zXcFz+lprPcoBSWJ30moRo9BkHfNcbWfQxWHUqY=;
        b=aoNYD+ZX5721iI6vvyOoCngR3eyVe3qrXxY4tWVKoPr9lWmmK7FX0WbEXEPXIHo2u9
         9+k17EZ7dpzRwknw7MFyKDwhqSuliGq5/08fFVUgoQFcb+fdXa1ZztERRILTgYVEh+C4
         CxozsU461E6m+MKSeJmcSaRUb90/sKfr6rntk1fBUzAOtDkvjxz5oertHr/EeRR+miDo
         MfwrYgGtN9qkepP2SB7vet+UuPaFTjMcPgyB6aeucgxFes/WtuyEd/X28vHWZZVagW+w
         T6apoqmBAIkDQkwlP1aSNVlpLvKeL9Fsj3gZwu7pn/tl9M/GhglFlKXZ6fFyMqenTmC9
         zy7Q==
X-Gm-Message-State: AOAM532YsH2n6+KJfAG5CgiBB/PBg+nynteYGwXYUpL9c17kY1PYWmfB
        EHNlYN+vYnyBQd4HPgl8cHP/MHO9QwA0ghS2
X-Google-Smtp-Source: ABdhPJzTM8k/uHVd+cyYYtY/sjtS3fFiFFrrr75EhaENHljWGUdEQ6ezZVlEhThcOyIMLtWj0h8JCQ==
X-Received: by 2002:ac2:4d28:: with SMTP id h8mr23119748lfk.263.1609419309811;
        Thu, 31 Dec 2020 04:55:09 -0800 (PST)
Received: from [10.0.0.113] (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id 2sm6219535lff.188.2020.12.31.04.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 04:55:09 -0800 (PST)
To:     Tony Lindgren <tony@atomide.com>, Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
References: <20201230084338.19410-1-tony@atomide.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Fix stuck sensor with
 continuous mode for 4430
Message-ID: <f108ac41-b38f-2d19-97ee-aaa5a7fdd1cc@gmail.com>
Date:   Thu, 31 Dec 2020 14:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230084338.19410-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tony,

On 12/30/20 10:43 AM, Tony Lindgren wrote:
> At least for 4430, trying to use the single conversion mode eventually
> hangs the thermal sensor. This can be quite easily seen with errors:
> 
> thermal thermal_zone0: failed to read out thermal zone (-5)
> 
> Also, trying to read the temperature shows a stuck value with:
> 
> $ while true; do cat /sys/class/thermal/thermal_zone0/temp; done
> 
> Where the temperature is not rising at all with the busy loop.
> 
> Additionally, the EOCZ (end of conversion) bit is not rising on 4430 in
> single conversion mode while it works fine in continuous conversion mode.
> It is also possible that the hung temperature sensor can affect the
> thermal shutdown alert too.
> 
> Let's fix the issue by adding TI_BANDGAP_FEATURE_CONT_MODE_ONLY flag and
> use it for 4430.
> 
> Note that we also need to add udelay to for the EOCZ (end of conversion)
> bit polling as otherwise we have it time out too early on 4430. We'll be
> changing the loop to use iopoll in the following clean-up patch.

I don't yet have my setup in working condition, so I can not test these.

> Cc: Adam Ford <aford173@gmail.com>
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 3 ++-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c         | 9 +++++++--
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h         | 2 ++
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
> --- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
> @@ -58,7 +58,8 @@ omap4430_adc_to_temp[OMAP4430_ADC_END_VALUE - OMAP4430_ADC_START_VALUE + 1] = {
>  const struct ti_bandgap_data omap4430_data = {
>  	.features = TI_BANDGAP_FEATURE_MODE_CONFIG |
>  			TI_BANDGAP_FEATURE_CLK_CTRL |
> -			TI_BANDGAP_FEATURE_POWER_SWITCH,
> +			TI_BANDGAP_FEATURE_POWER_SWITCH |
> +			TI_BANDGAP_FEATURE_CONT_MODE_ONLY,

Can we add a comment with the observations?

>  	.fclock_name = "bandgap_fclk",
>  	.div_ck_name = "bandgap_fclk",
>  	.conv_table = omap4430_adc_to_temp,
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> @@ -605,8 +606,10 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
>  	u32 counter = 1000;
>  	struct temp_sensor_registers *tsr;
>  
> -	/* Select single conversion mode */
> -	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
> +	/* Select continuous or single conversion mode */
> +	if (TI_BANDGAP_HAS(bgp, CONT_MODE_ONLY))
> +		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 1);
> +	else if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
>  		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);

Would not be better to:
if (TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
	if (TI_BANDGAP_HAS(bgp, CONT_MODE_ONLY))
		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 1);
	else
		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);
}

One can only switch to cont/single mode if the mode config is possible.

>  
>  	/* Start of Conversion = 1 */
> @@ -619,6 +622,7 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
>  		if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
>  		    tsr->bgap_eocz_mask)
>  			break;
> +		udelay(1);
>  	}
>  
>  	/* Start of Conversion = 0 */
> @@ -630,6 +634,7 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
>  		if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
>  		      tsr->bgap_eocz_mask))
>  			break;
> +		udelay(1);
>  	}
>  
>  	return 0;
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -280,6 +280,7 @@ struct ti_temp_sensor {
>   *	has Errata 814
>   * TI_BANDGAP_FEATURE_UNRELIABLE - used when the sensor readings are too
>   *	inaccurate.
> + * TI_BANDGAP_FEATURE_CONT_MODE_ONLY - used when single mode hangs the sensor
>   * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable of a
>   *      specific feature (above) or not. Return non-zero, if yes.
>   */
> @@ -295,6 +296,7 @@ struct ti_temp_sensor {
>  #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
>  #define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
>  #define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(11)
> +#define TI_BANDGAP_FEATURE_CONT_MODE_ONLY	BIT(12)
>  #define TI_BANDGAP_HAS(b, f)			\
>  			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
>  
> 

-- 
Péter

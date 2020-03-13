Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8A184680
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 13:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMMHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 08:07:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41093 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMMHX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 08:07:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14so11781304wrt.8
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9/Bcd6qwUNn4qva18bEYWevO0dvh9c67JG56aKrCUDU=;
        b=zvSNVtLVtwSV+BNzcy6pPgkURNzDdgsfWbuzKOq96veGk/+0iraX2gzFaJderacZlc
         CDg04BWUFdUBRWthqjutxzn3cR7+PXVDDBU1Z43rwzX7tBVE9H7RDdmik2B0mloM2Vwe
         OSbnLRDXUX59N1OFBi4whJ1SQRXeH3MBCW4E3pkPR9l3W8LlFLbBOiUYNUylglH1rXWo
         AYQDj93P1lg2Sm/gC1FvUUgEXq5AlHSl+57gUulx2B+3hF8obycSqDGoEUODM8DecW6C
         a7keymvBphtuGvfQjKVYW7DMNsOsqMyFTy5V9I0J1CY5oepc8WvPAMzMq++Z60d7r51S
         mkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9/Bcd6qwUNn4qva18bEYWevO0dvh9c67JG56aKrCUDU=;
        b=qM3RJa/+XLckMQCR91whztjfynj5wjBoCsEXhgNRr3gb0lUCpugxcmaj96Y8D0lJWX
         cnsd9H1LK7VPLwo+ZoF0cIDLqBEMmyjtM4Y9/XUdnyFOeX3raZXLjl1aXYvcFhMfFSDD
         /CZV2gXqIDemD5at1BwML51s6uhNOaftAJudE1+TQzO/HF5oNmQToO1uwzet1dAAs5NJ
         xCgV+a4iN5/Obb/M+0lT/MSZpUOQQQGn+Y5yqtKozgeI23eF9gH4bupENc/vqxxIQwxN
         KDEMLZkXcG40wjFJrCpTAsn9JurWuQQ8IEm6Hr3aKWUWZUfX1Hi+L6SItKlXPl1UJt1Y
         tmXg==
X-Gm-Message-State: ANhLgQ0NGawQX1PusDQ1xYWlvEoFFbJtY7yM+EGFFdLa2e+UMFA/vXMm
        0IAL3qZQp4/M0aQRW2ZObzgUWA==
X-Google-Smtp-Source: ADFU+vvZ5aEJ3y7Vb2awEaAg+kJj6tljAPYMMXx120cBGz9smvGCBGqHZCiRe0nNluq8D4mD+n4KdQ==
X-Received: by 2002:adf:f545:: with SMTP id j5mr17388487wrp.295.1584101240954;
        Fri, 13 Mar 2020 05:07:20 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:40fb:3990:3519:cc26? ([2a01:e34:ed2f:f020:40fb:3990:3519:cc26])
        by smtp.googlemail.com with ESMTPSA id z6sm23937704wru.15.2020.03.13.05.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:07:20 -0700 (PDT)
Subject: Re: [PATCH resend] thermal: imx: register as OF sensor
To:     Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
References: <20200313110139.28558-1-l.stach@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <208912d8-b15c-278a-0c3b-174d9d82d9ef@linaro.org>
Date:   Fri, 13 Mar 2020 13:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313110139.28558-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/03/2020 12:01, Lucas Stach wrote:
> To make the internal sensor usable with a thermal zone description
> provided via DT, also register out device as a OF sensor.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Are you calling the DT or non-DT at the same function unconditionally ?


> ---
>  drivers/thermal/imx_thermal.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index bb6754a5342c..714be941fe6c 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -202,7 +202,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
>  
>  struct imx_thermal_data {
>  	struct cpufreq_policy *policy;
> -	struct thermal_zone_device *tz;
> +	struct thermal_zone_device *tz, *sensor;
>  	struct thermal_cooling_device *cdev;
>  	enum thermal_device_mode mode;
>  	struct regmap *tempmon;
> @@ -338,6 +338,13 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  	return 0;
>  }
>  
> +static int imx_of_sensor_get_temp(void *data, int *temp)
> +{
> +	struct imx_thermal_data *thermal_data = data;
> +
> +	return imx_get_temp(thermal_data->tz, temp);
> +}
> +
>  static int imx_get_mode(struct thermal_zone_device *tz,
>  			enum thermal_device_mode *mode)
>  {
> @@ -482,6 +489,10 @@ static struct thermal_zone_device_ops imx_tz_ops = {
>  	.set_trip_temp = imx_set_trip_temp,
>  };
>  
> +static const struct thermal_zone_of_device_ops imx_tz_of_ops = {
> +	.get_temp = imx_of_sensor_get_temp,
> +};
> +
>  static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
>  {
>  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> @@ -816,6 +827,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	data->sensor = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
> +						       &imx_tz_of_ops);
> +
>  	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
>  		 " critical:%dC passive:%dC\n", data->temp_grade,
>  		 data->temp_max / 1000, data->temp_critical / 1000,
> @@ -871,6 +885,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
>  	if (!IS_ERR(data->thermal_clk))
>  		clk_disable_unprepare(data->thermal_clk);
>  
> +	thermal_zone_of_sensor_unregister(&pdev->dev, data->sensor);
>  	thermal_zone_device_unregister(data->tz);
>  	cpufreq_cooling_unregister(data->cdev);
>  	cpufreq_cpu_put(data->policy);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


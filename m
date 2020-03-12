Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30EB182F01
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCLLYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 07:24:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46715 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLLYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 07:24:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so6894043wrw.13
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GFmNKQyMSZMwZUCnsk2pyKF7rtWxqi2AMD/Ce8iu334=;
        b=BZ9RRCO7J1gCZUSAUfurnrudPNRoqhHqdna+O3owBnlsNEA1BTPEO5tXQtN2UWJQex
         iOJabv12bn2j3Nccci5IaWgYZpRMKYUmOnVDsCm4Ji76aLP4wvvPma10muW9MOc08OHS
         VrL12iUgE8EozfD4I637VWtJif7Bb6+ZnXrwyNjnjxji8yX0oGS03mzGlmd+79IahV/w
         AhODGNiOxQbbBQef0kpGfd4/QGB0XwzxTpSFLk7vtX6pR2YUsiH7fkA4XHLNlfVEyU9R
         DUvoePovM8UdcYIAIWVHoBelhKBsU1kke4nSx6hPm+2ia5/QnukCIvOMakbYgSv73zWI
         cMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GFmNKQyMSZMwZUCnsk2pyKF7rtWxqi2AMD/Ce8iu334=;
        b=M7vej5lshJL6aXXhbM3IlRuMJe/CjK4UZkn5AI3ahFYg8NOR/yK/tTTl81AbgE7Wrt
         Aah6CAYH1g8SMU6d6/b8gpoxVyr0S/O2IK8m4W52iU/8X8vWkpicOHazRt1OXachByrg
         QIUes4hucg/TRaGqFcgqjrRCcJPwYzFYnLt7xaKM1DpglFUCpkDtgD4lAFilGjGvDH9k
         ybLt46ChLfpiiDf/yWM52OQP1z7ZhRUzVMQb4ONjKzs8quCKDkO9DjUYBW/zGFeV0uUD
         knfxatthVGhAhffk7GvhMuqMPZ3qQCk6QTiWNwZm3B1FG9yWLAX8Z94WnRRRkX10J+0z
         KjtA==
X-Gm-Message-State: ANhLgQ3sFqRa9lWk3FUxg6lesPuaRSDUMmmEVlWlqlrKluwWANN8JYu6
        0Cns6vQgvxsGSD4Yc4MQ78QkHg==
X-Google-Smtp-Source: ADFU+vuAAFF/o2WgExiRQPfrS5IN5zyWXfAyr8mpXgg/I3/uRsx9fM4Ay67mnUYfMv8N3bHWcuh98Q==
X-Received: by 2002:a05:6000:189:: with SMTP id p9mr10507281wrx.391.1584012254155;
        Thu, 12 Mar 2020 04:24:14 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3880:fdc2:ef6b:879f? ([2a01:e34:ed2f:f020:3880:fdc2:ef6b:879f])
        by smtp.googlemail.com with ESMTPSA id m187sm12108022wme.16.2020.03.12.04.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:24:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
To:     Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
Date:   Thu, 12 Mar 2020 12:24:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/03/2020 06:07, Anson Huang wrote:
> Use devm_add_action_or_reset() to handle all cleanups of failure in
> .probe and .remove, then .remove callback can be dropped.

Is this change compatible with the tristate?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 874bc46..67a8d84 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -228,6 +228,14 @@ static const struct regmap_access_table qoriq_rd_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges),
>  };
>  
> +static void qoriq_tmu_action(void *p)
> +{
> +	struct qoriq_tmu_data *data = p;
> +
> +	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> +	clk_disable_unprepare(data->clk);
> +}
> +
>  static int qoriq_tmu_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -278,6 +286,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
> +	if (ret)
> +		return ret;
> +
>  	/* version register offset at: 0xbf8 on both v1 and v2 */
>  	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
>  	if (ret) {
> @@ -290,35 +302,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
>  	if (ret < 0)
> -		goto err;
> +		return ret;
>  
>  	ret = qoriq_tmu_register_tmu_zone(dev, data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
> -		ret = -ENODEV;
> -		goto err;
> +		return ret;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> -
> -err:
> -	clk_disable_unprepare(data->clk);
> -
> -	return ret;
> -}
> -
> -static int qoriq_tmu_remove(struct platform_device *pdev)
> -{
> -	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> -
> -	/* Disable monitoring */
> -	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> -
> -	clk_disable_unprepare(data->clk);
> -
> -	return 0;
>  }
>  
>  static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
> @@ -365,7 +359,6 @@ static struct platform_driver qoriq_tmu = {
>  		.of_match_table	= qoriq_tmu_match,
>  	},
>  	.probe	= qoriq_tmu_probe,
> -	.remove	= qoriq_tmu_remove,
>  };
>  module_platform_driver(qoriq_tmu);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


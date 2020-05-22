Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA21DEE49
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgEVRdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgEVRdN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 13:33:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB9C061A0E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 10:33:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so6680109wru.12
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VLbtYmWmQJbiFJ2E3A6qyIEbqWJ+t8w0WcuXKvFftBM=;
        b=ptf99yRrw4EIojq7DT7XBDmqVK3BXlNklUP+YLMzHqL9DxIWWzT112sAOKqee3nSRn
         QUFCueS41OH+yUGAj8gAo4vfU1shdTCVKxxjH2JGeEMqbu8qaTe1mkEK+POyDPJF6X0O
         6GzrTuu2uCQ1tSS8OsCTDnqsFkxDmnNirxW1x1NmNgro481PJr/aUsJpyixsdU3uDLqy
         3l6ZQ++xMuHYXJXJ3eoXs6veh+0m6QfvZOo5N8Rl26/bSaYxgtupN427Z345+slPvbo8
         JgwpKw7kT96xeTJ0b10F4kVepUjw2nKaQdhuCgq5jIZQ990Y07uGjssycHTt0B01fcVn
         4Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VLbtYmWmQJbiFJ2E3A6qyIEbqWJ+t8w0WcuXKvFftBM=;
        b=UjTM0LmhPFX8Um3WjW2/oW9WNW8+stXnnzTCJmzrI3Ch5aUqNjPTIw4KaEEbn5R/V1
         RiZa6D3BqV4jrBVw7zVjvfhIzT68SXwDhEkApMentBvzCtSCAqu9D3cvggQjvyCbVevu
         5/vjJK54fRhDuUy/ntDxxZzX2PIhxZpqowc/GBcVWESrSXmS8QT8bN2eUq0Cldh81zAP
         m8VqnK202nywN0YDa8IP4Ucv8sVlpl8dLZGfGxdVFlS99T34LLaxEiDfjzw3tcUtZB0r
         RKvDPAjNlucy5cJObkOo3WC2jYap46F+5PeYtVIYz0lAzmYYUO/irvXTs36yQ30F20GG
         viLQ==
X-Gm-Message-State: AOAM5313xLLFIB4fr4v6KMPvIZgd9E3LnMyDU5hY0ONFl64fli3VBPYX
        8oXG3l1gJvP+XMxrntxlQ8wV+Q==
X-Google-Smtp-Source: ABdhPJwFuU20ErMvBhjnpeWy50ODfZq0wx6XE5USegDcr9gAnvfvgAu8t++gYGjZrIdQJ6pCG8K/Eg==
X-Received: by 2002:a5d:4390:: with SMTP id i16mr1540564wrq.186.1590168792082;
        Fri, 22 May 2020 10:33:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id i6sm11436865wmb.41.2020.05.22.10.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 10:33:11 -0700 (PDT)
Subject: Re: [PATCH] thermal: imx8mm: Add get_trend ops
To:     Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
Date:   Fri, 22 May 2020 19:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/05/2020 04:58, Anson Huang wrote:
> Add get_trend ops for i.MX8MM thermal to apply fast cooling
> mechanism, when temperature exceeds passive trip point, the
> highest cooling action will be applied, and when temperature
> drops to lower than the margin below passive trip point, the
> lowest cooling action will be applied.

You are not describing what is the goal of this change.

IIUC, the resulting change will be an on/off action. The thermal zone is
mitigated with the highest cooling effect, so the lowest OPP, then the
temperature trend is stable until it goes below the trip - margin where
the mitigation is stopped.

Except, I'm missing something, setting a trip point with a 10000
hysteresis and a cooling map min/max set to the highest opp will result
on the same.


> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/imx8mm_thermal.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index e6061e2..8f6a0b8 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -38,6 +38,8 @@
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
>  
> +#define IMX_TEMP_COOL_MARGIN	10000
> +
>  struct thermal_soc_data {
>  	u32 num_sensors;
>  	u32 version;
> @@ -103,8 +105,33 @@ static int tmu_get_temp(void *data, int *temp)
>  	return tmu->socdata->get_temp(data, temp);
>  }
>  
> +static int tmu_get_trend(void *p, int trip, enum thermal_trend *trend)
> +{
> +	struct tmu_sensor *sensor = p;
> +	int trip_temp, temp, ret;
> +
> +	if (!sensor->tzd)
> +		return -EINVAL;
> +
> +	ret = sensor->tzd->ops->get_trip_temp(sensor->tzd, trip, &trip_temp);
> +	if (ret)
> +		return ret;
> +
> +	temp = READ_ONCE(sensor->tzd->temperature);
> +
> +	if (temp > trip_temp)
> +		*trend = THERMAL_TREND_RAISE_FULL;
> +	else if (temp < (trip_temp - IMX_TEMP_COOL_MARGIN))
> +		*trend = THERMAL_TREND_DROP_FULL;
> +	else
> +		*trend = THERMAL_TREND_STABLE;
> +
> +	return 0;
> +}
> +
>  static struct thermal_zone_of_device_ops tmu_tz_ops = {
>  	.get_temp = tmu_get_temp,
> +	.get_trend = tmu_get_trend,
>  };
>  
>  static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

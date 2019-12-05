Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E726113FDE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 12:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLELDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 06:03:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34359 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 06:03:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so7056790wmj.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 03:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ll+ZtZqLRijkfOMt87UUlKzqpetlzgFXOkJtkxIK6vI=;
        b=VXqEvpic35wnyYpK3MKRzoGflEHuC/+9gT2bCRjdLD0RAeKRbWCkzUiB7t5/40X1hX
         TPfxZxXUKLUrX9ZP4bNf8UpSwVFiZBbBK5dRNVk78i9qd39lPHYWSZ4KpFjJ42H3e9gS
         z+P08eLk3qv6yqNQyvVY7G3nzDYjLfa2fSrxmgtCmWTx7qx16woFqBwOobX0AiXK0cXx
         0Xvs/hQ7ooij8f4m+fsFMAjZqq8KNGYqO0wmaYS4QLp41Rz8v/iKfOrUO9Wo+16ZqcDr
         8SK5+XBRJ7C+l3RbYEm34LpcAxoMtv0FvqI6KVXvQa1FbdHncGBH+pICgzzvstwy3r/G
         LWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ll+ZtZqLRijkfOMt87UUlKzqpetlzgFXOkJtkxIK6vI=;
        b=IHDIwKswFsNMKicDBbE1JDBwkJ8LUac2JlZgM/EnQjgm5MgQ0FlYSjxHnhWuqtC9LY
         hRWqOiyrJQYOHOxId1vgsNtJsPobQw1qREvUkVYhsog0ulz7PWzHXYQ3AY4UyY90h/6c
         pbpGIXZjWd3w8bRROjcL9FJ93h0/v2hpi/LlsWPih7NQDhCA8pz0eQm4xmmOREMnXOqp
         YsqDrFS+fYteaTEmRxYhowHZm44IQZPbyKgUR39G83PlCZ1MzTyKrXMt6OD8siYw3PBm
         9b9DsME++fhEAS6Jj81IN7fcSWcJEPI6a7EoRj8lPGnOiKW3IAm0HWySFLb0YfLVDA3A
         lHIQ==
X-Gm-Message-State: APjAAAVMu+h7fFf/cZoDnCUZA4xZH2l7lG6TDIXOjNvcIhXwI7z1afuW
        nFLKbXWd9KOsaB4a5aeGx7YCpw==
X-Google-Smtp-Source: APXvYqyIRwj1nXM2zCeMTzAQ4xNTqJSTZ7e3VmBNn2JjMioUXR04pAYD0HF8HBsaHFNFCfs4+VsX5Q==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr4507943wmb.47.1575543792686;
        Thu, 05 Dec 2019 03:03:12 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6? ([2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6])
        by smtp.googlemail.com with ESMTPSA id n1sm11710937wrw.52.2019.12.05.03.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 03:03:12 -0800 (PST)
Subject: Re: [PATCH v2 4/5] thermal: stm32: improve temperature resolution
To:     Pascal Paillet <p.paillet@st.com>, rui.zhang@intel.com,
        edubezval@gmail.com, amit.kucheria@verdurent.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        david.hernandezsanchez@st.com, horms+renesas@verge.net.au,
        wsa+renesas@sang-engineering.com, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191104133020.8820-1-p.paillet@st.com>
 <20191104133020.8820-5-p.paillet@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <25652640-90ed-2b62-c06a-728bfc771c46@linaro.org>
Date:   Thu, 5 Dec 2019 12:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191104133020.8820-5-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/11/2019 14:30, Pascal Paillet wrote:
> Currently, the temperature is rounded by 1 or 2 degrees.
> Change the way of computing to avoid rounds.
> Also simplify the sampling time management.

Give more details about the changes in order to let us understand them.

> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
>  drivers/thermal/st/stm_thermal.c | 58 ++++++++------------------------
>  1 file changed, 14 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index cb72252f2800..9986716b17c1 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -59,7 +59,6 @@
>  
>  /* Less significant bit position definitions */
>  #define TS1_T0_POS		16
> -#define TS1_SMP_TIME_POS	16
>  #define TS1_HITTHD_POS		16
>  #define TS1_LITTHD_POS		0
>  #define HSREF_CLK_DIV_POS	24
> @@ -83,15 +82,10 @@
>  #define ONE_MHZ			1000000
>  #define POLL_TIMEOUT		5000
>  #define STARTUP_TIME		40
> -#define TS1_T0_VAL0		30
> -#define TS1_T0_VAL1		130
> +#define TS1_T0_VAL0		30000  /* 30 celsius */
> +#define TS1_T0_VAL1		130000 /* 130 celsius */
>  #define NO_HW_TRIG		0
> -
> -/* The Thermal Framework expects millidegrees */
> -#define mcelsius(temp)		((temp) * 1000)
> -
> -/* The Sensor expects oC degrees */
> -#define celsius(temp)		((temp) / 1000)
> +#define SAMPLING_TIME		15
>  
>  struct stm_thermal_sensor {
>  	struct device *dev;
> @@ -259,27 +253,17 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
>  					   int temp, u32 *th)
>  {
>  	int freqM;
> -	u32 sampling_time;
> -
> -	/* Retrieve the number of periods to sample */
> -	sampling_time = (readl_relaxed(sensor->base + DTS_CFGR1_OFFSET) &
> -			TS1_SMP_TIME_MASK) >> TS1_SMP_TIME_POS;
>  
>  	/* Figure out the CLK_PTAT frequency for a given temperature */
> -	freqM = ((temp - sensor->t0) * sensor->ramp_coeff)
> -		 + sensor->fmt0;
> -
> -	dev_dbg(sensor->dev, "%s: freqM for threshold = %d Hz",
> -		__func__, freqM);
> +	freqM = ((temp - sensor->t0) * sensor->ramp_coeff) / 1000 +
> +		sensor->fmt0;
>  
>  	/* Figure out the threshold sample number */
> -	*th = clk_get_rate(sensor->clk);
> +	*th = clk_get_rate(sensor->clk) * SAMPLING_TIME / freqM;
>  	if (!*th)
>  		return -EINVAL;
>  
> -	*th = *th / freqM;
> -
> -	*th *= sampling_time;
> +	dev_dbg(sensor->dev, "freqM=%d Hz, threshold=0x%x", freqM, *th);
>  
>  	return 0;
>  }
> @@ -371,40 +355,26 @@ static int stm_thermal_set_trips(void *data, int low, int high)
>  static int stm_thermal_get_temp(void *data, int *temp)
>  {
>  	struct stm_thermal_sensor *sensor = data;
> -	u32 sampling_time;
> +	u32 periods;
>  	int freqM, ret;
>  
>  	if (sensor->mode != THERMAL_DEVICE_ENABLED)
>  		return -EAGAIN;
>  
> -	/* Retrieve the number of samples */
> -	ret = readl_poll_timeout(sensor->base + DTS_DR_OFFSET, freqM,
> -				 (freqM & TS1_MFREQ_MASK), STARTUP_TIME,
> -				 POLL_TIMEOUT);
> -
> +	/* Retrieve the number of periods sampled */
> +	ret = readl_relaxed_poll_timeout(sensor->base + DTS_DR_OFFSET, periods,
> +					 (periods & TS1_MFREQ_MASK),
> +					 STARTUP_TIME, POLL_TIMEOUT);
>  	if (ret)
>  		return ret;
>  
> -	if (!freqM)
> -		return -ENODATA;
> -
> -	/* Retrieve the number of periods sampled */
> -	sampling_time = (readl_relaxed(sensor->base + DTS_CFGR1_OFFSET) &
> -			TS1_SMP_TIME_MASK) >> TS1_SMP_TIME_POS;
> -
> -	/* Figure out the number of samples per period */
> -	freqM /= sampling_time;
> -
>  	/* Figure out the CLK_PTAT frequency */
> -	freqM = clk_get_rate(sensor->clk) / freqM;
> +	freqM = (clk_get_rate(sensor->clk) * SAMPLING_TIME) / periods;
>  	if (!freqM)
>  		return -EINVAL;
>  
> -	dev_dbg(sensor->dev, "%s: freqM=%d\n", __func__, freqM);
> -
>  	/* Figure out the temperature in mili celsius */
> -	*temp = mcelsius(sensor->t0 + ((freqM - sensor->fmt0) /
> -			 sensor->ramp_coeff));
> +	*temp = (freqM - sensor->fmt0) * 1000 / sensor->ramp_coeff + sensor->t0;
>  
>  	return 0;
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


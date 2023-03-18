Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD56BFAA2
	for <lists+linux-pm@lfdr.de>; Sat, 18 Mar 2023 15:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCROCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Mar 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCROCm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2023 10:02:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462D32520
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2023 07:02:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x36so7825173ljq.7
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2023 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679148157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRZv8HFmSWp+jd53Rhrn74J/QIYBoBtEs9x9jM7BMwc=;
        b=N2rGfYnQO2wXQV18IQXwS/8Rui80++iZo6VKbBHWu5PAWkXliG3DkiwcxPYo3y2dg8
         IYfhj8VJESgECvSjVIbGqCFd+/jbVpmWVRjcYG4CXZFK5orinLGtkQysUwLlFSIh/yuF
         gG4lQtU4EI9APpROZaW/7G0rDZbDAOHmRQUWMpPOivHOV0tPJBcILnhK4wDhXPRenykS
         erhTsiLYZj9K6jyUJDlql6vW9d1u8Zz9AbuxjbazJ/ubiSkCECX1fArhb+O8f2qbBVqR
         Rzueqr8EFtIKX0d9zXuEbkpJqAIfMln6ZON5Xr4GKXWf4BYpnLNIz6WxR8bdvN5Xl+GD
         I9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679148157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRZv8HFmSWp+jd53Rhrn74J/QIYBoBtEs9x9jM7BMwc=;
        b=TfsCMX08nHpJEEa149yecm1lDVpeEntppvvHwOy0U0RB8tLC+mtPHavBK++vB04fi+
         mpAT54UE6n3hSzv9dWLd5zq+cDGVJVnIA22pjHA24u1+1Coh+xtbN3tcQIkGYfyqT0xS
         svlkLZ1gee5P9/zPCy4DV1tV2oADLCzR/w8jopHGPk1XHMgmCB0puZYyeHsfDy3UqpG4
         5lUVeBQfRPmbSOATIzpo5O5TqJYRbuYY8kcbZk6mzAGsQ2k+xfP/Aqe+E0SFwBPjszgu
         SugPyV5Hy2yvL/J1ySJziwyheHN1K2s8ltflmnCDMoAXOpNWS+HRbCSFTLrk+DH013Pm
         zbRw==
X-Gm-Message-State: AO0yUKWa2MiYgOw7VpLfLfcdllx+NSDKImw3rzKsmuXs4eq2voa2XBlA
        D5otj3BtNlHYijzopVNrgHM4wQ==
X-Google-Smtp-Source: AK7set/y30IUNrQJ7pZ91meccGbLsoOXLcbkzv751uA8FJO+MLxEf8ct+aVkfra39OTO3jxtJTN+8Q==
X-Received: by 2002:a2e:9281:0:b0:294:899:afc3 with SMTP id d1-20020a2e9281000000b002940899afc3mr5151085ljh.35.1679148156920;
        Sat, 18 Mar 2023 07:02:36 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id w2-20020a2e9582000000b00295a43fa3dfsm884034ljh.76.2023.03.18.07.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 07:02:36 -0700 (PDT)
Message-ID: <30e4ee62-0297-0ffe-23a5-87db096a6154@linaro.org>
Date:   Sat, 18 Mar 2023 15:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/6] thermal: qcom: tsens-v0_1: Add mdm9607 correction
 offsets
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
 <20230315103950.2679317-4-stephan.gerhold@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315103950.2679317-4-stephan.gerhold@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 15.03.2023 11:39, Stephan Gerhold wrote:
> According to the msm-3.18 vendor kernel from Qualcomm, mdm9607 needs
> "correction factors" to adjust for additional offsets observed after the
> factory calibration values in the fuses [1, 2].
> 
> The fixed offsets should be applied unless there is a special
> calibration mode value that indicates that no offsets are needed [3].
> 
> Note that the new calibration mode values are called differently in this
> patch compared to the vendor kernel:
>   - TSENS_TWO_POINT_CALIB_N_WA        -> ONE_PT_CALIB2_NO_OFFSET
>   - TSENS_TWO_POINT_CALIB_N_OFFSET_WA -> TWO_PT_CALIB_NO_OFFSET
> This is because close inspection of the calibration function [3] reveals
> that TSENS_TWO_POINT_CALIB_N_WA is actually a "one point" calibration
> because the if statements skip all "point2" related code for it.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d9d2db1b82bf3f72f5de0803d55e6849eb5b671e
> [2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d75aef53a760e8ff7bac54049d00c8b2ee1b193e
> [3]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/drivers/thermal/msm-tsens.c#L2987-3136
> 
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

BTW, did you notice some crazy readouts or would this have gone
unnoticed had you not dug in the code?

Konrad
> Changes in v3: None
> Changes in v2: New patch
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 11 +++++++++++
>  drivers/thermal/qcom/tsens.c      | 16 +++++++++++++++-
>  drivers/thermal/qcom/tsens.h      |  4 ++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 1b454de3928d..e69889dd524a 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -229,6 +229,17 @@ static int __init init_9607(struct tsens_priv *priv)
>  	for (i = 0; i < priv->num_sensors; ++i)
>  		priv->sensor[i].slope = 3000;
>  
> +	priv->sensor[0].p1_calib_offset = 1;
> +	priv->sensor[0].p2_calib_offset = 1;
> +	priv->sensor[1].p1_calib_offset = -4;
> +	priv->sensor[1].p2_calib_offset = -2;
> +	priv->sensor[2].p1_calib_offset = 4;
> +	priv->sensor[2].p2_calib_offset = 8;
> +	priv->sensor[3].p1_calib_offset = -3;
> +	priv->sensor[3].p2_calib_offset = -5;
> +	priv->sensor[4].p1_calib_offset = -4;
> +	priv->sensor[4].p2_calib_offset = -4;
> +
>  	return init_common(priv);
>  }
>  
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 8020ead2794e..32d2907f76e5 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -134,10 +134,12 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
>  			p1[i] = p1[i] + (base1 << shift);
>  		break;
>  	case TWO_PT_CALIB:
> +	case TWO_PT_CALIB_NO_OFFSET:
>  		for (i = 0; i < priv->num_sensors; i++)
>  			p2[i] = (p2[i] + base2) << shift;
>  		fallthrough;
>  	case ONE_PT_CALIB2:
> +	case ONE_PT_CALIB2_NO_OFFSET:
>  		for (i = 0; i < priv->num_sensors; i++)
>  			p1[i] = (p1[i] + base1) << shift;
>  		break;
> @@ -149,6 +151,18 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
>  		}
>  	}
>  
> +	/* Apply calibration offset workaround except for _NO_OFFSET modes */
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p2[i] += priv->sensor[i].p2_calib_offset;
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p1[i] += priv->sensor[i].p1_calib_offset;
> +		break;
> +	}
> +
>  	return mode;
>  }
>  
> @@ -254,7 +268,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  
>  		if (!priv->sensor[i].slope)
>  			priv->sensor[i].slope = SLOPE_DEFAULT;
> -		if (mode == TWO_PT_CALIB) {
> +		if (mode == TWO_PT_CALIB || mode == TWO_PT_CALIB_NO_OFFSET) {
>  			/*
>  			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
>  			 *	temp_120_degc - temp_30_degc (x2 - x1)
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dba9cd38f637..880be6be5c3f 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -10,6 +10,8 @@
>  #define ONE_PT_CALIB		0x1
>  #define ONE_PT_CALIB2		0x2
>  #define TWO_PT_CALIB		0x3
> +#define ONE_PT_CALIB2_NO_OFFSET	0x6
> +#define TWO_PT_CALIB_NO_OFFSET	0x7
>  #define CAL_DEGC_PT1		30
>  #define CAL_DEGC_PT2		120
>  #define SLOPE_FACTOR		1000
> @@ -57,6 +59,8 @@ struct tsens_sensor {
>  	unsigned int			hw_id;
>  	int				slope;
>  	u32				status;
> +	int				p1_calib_offset;
> +	int				p2_calib_offset;
>  };
>  
>  /**

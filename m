Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADC651E77
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiLTKKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiLTKKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:10:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F3F5E
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:09:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so2630766lfv.10
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yab3EUiSANSBkdQp95lM7FntTvkCHT0RSbYeGxIgxbA=;
        b=MbJ6Z1kwvEZYSxX5LfkaVHtNVoLLKcGSM87z6B6YAVRe6qqCJuNgdaIT80XNlI4M/z
         JGDcF43UB+ONsY2Nv/xuU5HhndAq9exyNy3xyqcHSAFiLnzBnkjn/hhL5N9tI1m4Dd89
         Czq1LnXR3Bf5D+YxXZwcOpco7Ic3hAk146Vj/d9Rk5w4ZSKgAKtZ/yqX5FgpIPRDHtFD
         lwUq0vSSZKaypWtSmwbqz4oXiq1zB4knb6aG+6GBjfxJpAy0AKc73T6+ZDSfG4l2BNDC
         HfX+kt8ZYSBr2KugNw5yrmaU3gw2AyDutuL6LIWNksRfmt6US7O3ZC/gtpJdwOcEXPrC
         QFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yab3EUiSANSBkdQp95lM7FntTvkCHT0RSbYeGxIgxbA=;
        b=1kt7jp4uKO9qYaox23U+O2HuXLY7nK/drZSj5AS9j92iw67mrWoRrGDyGpZYdN+Heo
         RwuvWulrtnVZOQEhcS3X7cBpqs0iMtNzyhfP/ycgXqfNpjKM0Rsg8WoxUw5bgr8nalKL
         /m9Fmw8vHEQlV6HkqjsqgYQsfsNe8jdYNuYKxHGUneyKxzr0Rm7hBebM6IglPrkcIkaq
         a/81ra4PBa1LFg+JC+0dhbYI/I0VsF/sCkEEnC30zmyftRF4RaKNrSKGpMqquIo9rh/1
         7nxJpMULR8ZAnMQG6wnQIzV1/6HvoECBUo5DkwId30OWTRqPV+9mnVVtY5MoSe0u4PXC
         4OOw==
X-Gm-Message-State: ANoB5pks925q0QLc9L5VACh48eFfdOtnu2yV6sRIcf75oAWr/cVoqJh3
        cXgBQbGIIuzQk3RfTOzppN6kKQ==
X-Google-Smtp-Source: AA0mqf7f4dFVpaSo8Y1VDRsU1EorZWyzkf8cPRiqBE1CpZ/rM5JKj35Z9fh0v+aTkSDehpai0hI+1Q==
X-Received: by 2002:ac2:4f0a:0:b0:4ac:ec52:e063 with SMTP id k10-20020ac24f0a000000b004acec52e063mr12588091lfr.29.1671530995464;
        Tue, 20 Dec 2022 02:09:55 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id b16-20020a05651c033000b0026dced9840dsm949074ljp.61.2022.12.20.02.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:09:55 -0800 (PST)
Message-ID: <688059f8-64f6-cb56-0443-f0e992e01baa@linaro.org>
Date:   Tue, 20 Dec 2022 11:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 06/15] thermal/drivers/tsens: Sort out msm8976 vs
 msm8956 data
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-7-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 03:47, Dmitry Baryshkov wrote:
> Tsens driver mentions that msm8976 data should be used for both msm8976
> and msm8956 SoCs. This is not quite correct, as according to the
> vendor kernels, msm8976 should use standard slope values (3200), while
> msm8956 really uses the slope values found in the driver.
> 
> Add separate compatibility string for msm8956, move slope value
> overrides to the corresponding init function and use the standard
> compute_intercept_slope() function for both platforms.
> 
> Fixes: 0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v1.c | 56 ++++++++++++++++++---------------
>  drivers/thermal/qcom/tsens.c    |  3 ++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index a7f53966156b..83c2853546d0 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -137,30 +137,6 @@
>  #define CAL_SEL_MASK	7
>  #define CAL_SEL_SHIFT	0
>  
> -static void compute_intercept_slope_8976(struct tsens_priv *priv,
> -			      u32 *p1, u32 *p2, u32 mode)
> -{
> -	int i;
> -
> -	priv->sensor[0].slope = 3313;
> -	priv->sensor[1].slope = 3275;
> -	priv->sensor[2].slope = 3320;
> -	priv->sensor[3].slope = 3246;
> -	priv->sensor[4].slope = 3279;
> -	priv->sensor[5].slope = 3257;
> -	priv->sensor[6].slope = 3234;
> -	priv->sensor[7].slope = 3269;
> -	priv->sensor[8].slope = 3255;
> -	priv->sensor[9].slope = 3239;
> -	priv->sensor[10].slope = 3286;
> -
> -	for (i = 0; i < priv->num_sensors; i++) {
> -		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
> -				(CAL_DEGC_PT1 *
> -				priv->sensor[i].slope);
> -	}
> -}
> -
>  static int calibrate_v1(struct tsens_priv *priv)
>  {
>  	u32 base0 = 0, base1 = 0;
> @@ -286,7 +262,7 @@ static int calibrate_8976(struct tsens_priv *priv)
>  		break;
>  	}
>  
> -	compute_intercept_slope_8976(priv, p1, p2, mode);
> +	compute_intercept_slope(priv, p1, p2, mode);
>  	kfree(qfprom_cdata);
>  
>  	return 0;
> @@ -360,6 +336,22 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int __init init_8956(struct tsens_priv *priv) {
> +	priv->sensor[0].slope = 3313;
> +	priv->sensor[1].slope = 3275;
> +	priv->sensor[2].slope = 3320;
> +	priv->sensor[3].slope = 3246;
> +	priv->sensor[4].slope = 3279;
> +	priv->sensor[5].slope = 3257;
> +	priv->sensor[6].slope = 3234;
> +	priv->sensor[7].slope = 3269;
> +	priv->sensor[8].slope = 3255;
> +	priv->sensor[9].slope = 3239;
> +	priv->sensor[10].slope = 3286;
> +
> +	return init_common(priv);
> +}
> +
>  static const struct tsens_ops ops_generic_v1 = {
>  	.init		= init_common,
>  	.calibrate	= calibrate_v1,
> @@ -372,13 +364,25 @@ struct tsens_plat_data data_tsens_v1 = {
>  	.fields	= tsens_v1_regfields,
>  };
>  
> +static const struct tsens_ops ops_8956 = {
> +	.init		= init_8956,
> +	.calibrate	= calibrate_8976,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_8956 = {
> +	.num_sensors	= 11,
> +	.ops		= &ops_8956,
> +	.feat		= &tsens_v1_feat,
> +	.fields		= tsens_v1_regfields,
> +};
> +
>  static const struct tsens_ops ops_8976 = {
>  	.init		= init_common,
>  	.calibrate	= calibrate_8976,
>  	.get_temp	= get_temp_tsens_valid,
>  };
>  
> -/* Valid for both MSM8956 and MSM8976. */
>  struct tsens_plat_data data_8976 = {
>  	.num_sensors	= 11,
>  	.ops		= &ops_8976,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b5b136ff323f..b191e19df93d 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -983,6 +983,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8939-tsens",
>  		.data = &data_8939,
> +	}, {
> +		.compatible = "qcom,msm8956-tsens",
> +		.data = &data_8956,
>  	}, {
>  		.compatible = "qcom,msm8960-tsens",
>  		.data = &data_8960,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 899af128855f..7dd5fc246894 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -594,7 +594,7 @@ extern struct tsens_plat_data data_8960;
>  extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
>  
>  /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8976;
> +extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>  
>  /* TSENS v2 targets */
>  extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;

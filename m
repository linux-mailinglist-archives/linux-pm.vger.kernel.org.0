Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E618651E6D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiLTKIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiLTKIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:08:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA630B
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:08:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so17815742lfu.8
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PF3WhBZPrqZkUx2iR7sKjx/b40NNBklcPphMLo49bpo=;
        b=yjpQzFChoYrSc2LQOa2hogExuJ5IpT/jF2Wug1kMYJObcrEl5C4+Tr8aleZMO7bHof
         DG21vU6tHoMlFUiRbIc0HtZQjuih3Vh5HsLhpyUhHxQgAmXvDkETnggzZgoZVR8GLtHR
         cXnS/zCMqP8nXl9kO4IcAr20/qPdUEXspL135JbhFLw/3EaEP+ELDtg8fqeFVAafRqFf
         hQ9bZpEtbHuM+MI79Ymizk+KfLARzS4c2bl52vTs9pDfUz4+mI52v+ah+KesRDHgQSeE
         sAhZFhEuAbVRoq7eW+2d+y7YPMSlTurEO1unFAMLNw1pUNJDUKMwBmQShR1kaYxjMMh6
         nnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PF3WhBZPrqZkUx2iR7sKjx/b40NNBklcPphMLo49bpo=;
        b=IqUIpLw6wqEcuSodhiwBkaTRGWxFggcN2crPsy1KarNBnKvhTZy7d/E9hoIH7/tVW+
         Q7pzIfB2goGmrkTxOcwR6iP/F6AxTBas4YPg7YRRdsLAmtO8OD3owOk1V0L/1UxwztWg
         Mv9kYPvqdu878D4JCG/ONrkjCjsQTmWtw2dlLUtEsLZAHH5xW4SzEQCt4qESutCItktH
         tOcUNi66pFaSM1U3/+7HwOZ5ouo7bgASsSp5ZZghPIuKyCmpJ76+vyOTYRcsvVEjcapU
         vZth+mmaEcQ+1QONCPVExiYN0y5PQalpHJ4EZzPimqiq7E6cGYoPL5UNiVK6Q7U0hxAJ
         8Z2A==
X-Gm-Message-State: AFqh2koxc/JkkN2/qzUbq8a/B4uQSrpMIds6TdH+2N+DwB31T3ve3mvo
        Sn/E90SOzRjNnlVXGp90rL3hpA==
X-Google-Smtp-Source: AMrXdXtVstP+G6cxSsiGdo33znLYjHjgAgv6sotEnb9igOCNhUrEH6f6P4Wok+NwgOBQCbN+kVndlw==
X-Received: by 2002:a05:6512:251f:b0:4a4:68b7:dec0 with SMTP id be31-20020a056512251f00b004a468b7dec0mr609718lfb.28.1671530922782;
        Tue, 20 Dec 2022 02:08:42 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b004ca0ea7af24sm245720lfr.174.2022.12.20.02.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:08:42 -0800 (PST)
Message-ID: <f42002a1-a08b-e371-6ccd-3acafd446bb6@linaro.org>
Date:   Tue, 20 Dec 2022 11:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 05/15] thermal/drivers/tsens: Drop msm8976-specific
 defines
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
 <20221220024721.947147-6-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-6-dmitry.baryshkov@linaro.org>
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
> Drop msm8976-specific defines, which duplicate generic ones.
> 
> Fixes: 0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v1.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 96ef12d47bff..a7f53966156b 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -78,11 +78,6 @@
>  
>  #define MSM8976_CAL_SEL_MASK	0x3
>  
> -#define MSM8976_CAL_DEGC_PT1	30
> -#define MSM8976_CAL_DEGC_PT2	120
> -#define MSM8976_SLOPE_FACTOR	1000
> -#define MSM8976_SLOPE_DEFAULT	3200
> -
>  /* eeprom layout data for qcs404/405 (v1) */
>  #define BASE0_MASK	0x000007f8
>  #define BASE1_MASK	0x0007f800
> @@ -160,8 +155,8 @@ static void compute_intercept_slope_8976(struct tsens_priv *priv,
>  	priv->sensor[10].slope = 3286;
>  
>  	for (i = 0; i < priv->num_sensors; i++) {
> -		priv->sensor[i].offset = (p1[i] * MSM8976_SLOPE_FACTOR) -
> -				(MSM8976_CAL_DEGC_PT1 *
> +		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
> +				(CAL_DEGC_PT1 *
>  				priv->sensor[i].slope);
>  	}
>  }

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2996651E66
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLTKHq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLTKHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:07:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE230B
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:07:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b13so17855257lfo.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqFRU8P7zqmZfaYVXOcDfL9WuQYKC06tycOM2BCpeho=;
        b=Q5ZMnjaem8ibVMO/h2fyvyqnR12hGQjkbE4WcOcFnneyo3AWbg0wqBUzH3xfz7Tzk/
         aoDEAGG7P71V6nRA0gqVhqh1GmTil89peE9ntDAU10I1dhUzAXt2+HTnlu7EGd5IZAm+
         lwLQtS/AFemlsvvE4bC85Ky69Pf1kVMbXRx20+zr8goGmABpZYVgMfZtCkcrCuO9yceS
         8eSlaB4gKsqMF0VLprZ2BS3sjJHttHoiVAj+zez0Q/zLDNWf5VQaf3qyAljYur06OkGe
         UQV1O3vWtUxLtbXxgRDX6UYKpOSNqtRg1AWq7k3F8Y3i7jPnvheATAqDjk4hMIvN//EM
         qBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqFRU8P7zqmZfaYVXOcDfL9WuQYKC06tycOM2BCpeho=;
        b=fc9YuCCyRyurCbgVvXbDaMonauO1x4dzss2Z2NbiCTw97CY0Lp7q1mYew3kSrE4G3m
         0m3AqL4QaqXJpbLSyqXAB7qYr+fYg2Cbwp/oyvFGOcJ2ZDgHCQ5ke6sUvyoT1eEEGL07
         WV1bb0QHVPIUBjsfekK+YvdN1kOwY69tYcOu5CfpACsh37fCvbquBwUB6h2MiP6ZAePg
         5wwL6mAOTDxCf8Vx2AJhRc7KS8ftLIx13CqDsWbQUNwtMVxKb9nYIRDK+GXY86XpXoyC
         oMdTROm1HldDS/lHSUiLftceYcwGMJqN5TixynJ/Y2l7zAx1KS0yVRIA/uwJ2gzYj8XW
         fdrQ==
X-Gm-Message-State: ANoB5pmMoGDieW3JPEzjza81dlHaiTEarWrECukxIv2A9OoTdtxZIIk/
        QUGHTd8JmsNEBw8Etqr3AmQMkw==
X-Google-Smtp-Source: AA0mqf4Rsq+WF0/EsDCXOfhDk0WK7wbdiGXl4R1p74gdF5pkAZE3k7+uCbJ78GRNpVrjqNW5j5BVfg==
X-Received: by 2002:a05:6512:39c2:b0:4b4:f303:9b3f with SMTP id k2-20020a05651239c200b004b4f3039b3fmr15110281lfu.66.1671530862859;
        Tue, 20 Dec 2022 02:07:42 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id q8-20020a056512210800b00498f871f33fsm1399330lfr.86.2022.12.20.02.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:07:42 -0800 (PST)
Message-ID: <8b20bf1d-af39-dcba-cb79-5ad037c1364a@linaro.org>
Date:   Tue, 20 Dec 2022 11:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 04/15] thermal/drivers/tsens: Drop unnecessary hw_ids
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
        devicetree@vger.kernel.org
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-5-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 03:47, Dmitry Baryshkov wrote:
> The tsens driver defaults to using hw_id equal to the index of the
> sensor. Thus it is superfluous to declare such hw_id arrays. Drop such
> arrays from mdm9607 and msm8976 data.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 1 -
>  drivers/thermal/qcom/tsens-v1.c   | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 04d012e4f728..0bc4e5cec184 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -635,7 +635,6 @@ static const struct tsens_ops ops_9607 = {
>  struct tsens_plat_data data_9607 = {
>  	.num_sensors	= 5,
>  	.ops		= &ops_9607,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,
>  };
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 1d7f8a80bd13..96ef12d47bff 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -387,7 +387,6 @@ static const struct tsens_ops ops_8976 = {
>  struct tsens_plat_data data_8976 = {
>  	.num_sensors	= 11,
>  	.ops		= &ops_8976,
> -	.hw_ids		= (unsigned int[]){0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
>  	.feat		= &tsens_v1_feat,
>  	.fields		= tsens_v1_regfields,
>  };

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A165376A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 21:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiLUUO0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Dec 2022 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiLUUOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2022 15:14:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DCBBBA
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 12:14:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o6so20264805lfi.5
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTojYDu6t1WZMYAiBD25KdZKtAIrjPF2oUIAZd2kJ/8=;
        b=gfr0FX41ftXWGKNCnBw5mRo5nWbRvFlLyRFJGavf6CU7vOCO6rcEAF/bSHnHPKHtO6
         mrMV4ouUrS7K78mzRGK72ggNAzKsuTOLPFPILrR6W5iyNYA42D4J324UIw1voDkC3/0L
         bzk6qsy7fMnenVf/SYolVbEGiRa6p5KwTitBg9tEXltImHHCexdFkTIGApDa7hT08UXj
         nVkvhvllTORf6hyiHI0E6OiQMy3JjH93o3PVBU0zDxXa3Dv5jFMuiBAD2xpTJu9yccsc
         F0nosOHRU1yBs1uEDnl40X8C0TJW6jpM5Wj5iPjhij+ll6wZ0cOx8wX4IU9Z7P92ixDc
         4+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTojYDu6t1WZMYAiBD25KdZKtAIrjPF2oUIAZd2kJ/8=;
        b=sobLQRx6lZXMe3qw4vMFxTmoyDpgQzySAFWU82uBWo1WF6uZZGOHPfhr1sOSMxaXOg
         6tJiW9QN/aw7r9UYwMy+DtK3ljmNoFkj9SqDnwcGEGBX1CKvjBLgn8OINq20xywEMqjd
         VJcBJFPKsHlmVluljySCjibQnH04iDPfVp6apZPD6GCHw9nM0bb0Sk+eoQ+FRTdRX0yb
         GLTYrcxkw7CTOU4sT69Rci+4lgrVddXPQ7q77m0BxGh616T+Qj87wTUuOGQM3J41Tswj
         2QPKaz/wxU3705WSGULX27euK8cieSi69SaUeZF0y4P8w0mBiGCovxPJQKHTxUpAHEvE
         wJvg==
X-Gm-Message-State: AFqh2kqD9jOol6jIv+Znop4CZe4Tjnpm1MZ/aKICghBG3Dkk1pkqOpWD
        R7hFIMtWB0/QqPG1643yFNJuXA==
X-Google-Smtp-Source: AMrXdXtzJ/aCVmUD0psHsH/+qLcP/ciPwob/9Fe6AfIOw9h1tDTRlNf5GxXIK7XLp9Ioh1CSUBEl6Q==
X-Received: by 2002:a05:6512:3288:b0:4a4:68b7:f87a with SMTP id p8-20020a056512328800b004a468b7f87amr1282657lfe.30.1671653662493;
        Wed, 21 Dec 2022 12:14:22 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id v19-20020ac25613000000b004ad5f5c2b28sm1916239lfd.119.2022.12.21.12.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 12:14:22 -0800 (PST)
Message-ID: <108abd37-e302-8f7f-f7bf-fe98fc88250c@linaro.org>
Date:   Wed, 21 Dec 2022 21:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 08/20] thermal/drivers/tsens: fix slope values for
 msm8939
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
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
 <20221221020520.1326964-9-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221221020520.1326964-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 21.12.2022 03:05, Dmitry Baryshkov wrote:
> According to the vendor kernels (msm-3.10, 3.14 and 3.18), msm8939
> uses non-standard slope values for calibrating the sensors. Fill them
> accordingly.
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 57ac23f9d9b7..be173220a939 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -534,6 +534,20 @@ static int calibrate_9607(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> +static int __init init_8939(struct tsens_priv *priv) {
> +	priv->sensor[0].slope = 2911;
> +	priv->sensor[1].slope = 2789;
> +	priv->sensor[2].slope = 2906;
> +	priv->sensor[3].slope = 2763;
> +	priv->sensor[4].slope = 2922;
> +	priv->sensor[5].slope = 2867;
> +	priv->sensor[6].slope = 2833;
> +	priv->sensor[7].slope = 2838;
> +	priv->sensor[8].slope = 2840;
> +
> +	return init_common(priv);
> +}
> +
>  /* v0.1: 8916, 8939, 8974, 9607 */
>  
>  static struct tsens_features tsens_v0_1_feat = {
> @@ -599,7 +613,7 @@ struct tsens_plat_data data_8916 = {
>  };
>  
>  static const struct tsens_ops ops_8939 = {
> -	.init		= init_common,
> +	.init		= init_8939,
>  	.calibrate	= calibrate_8939,
>  	.get_temp	= get_temp_common,
>  };

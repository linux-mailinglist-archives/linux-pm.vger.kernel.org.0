Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0E6BDDB9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 01:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCQAjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Mar 2023 20:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCQAja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2023 20:39:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D8F584AB
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 17:39:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp27so4566143lfb.6
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 17:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679013567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upiehW/yJZLSDpEf4y2yHj38zYrZBw51z7iV6HWK5w0=;
        b=el9iDT2FL1/oZc4arzlytDjKbPCTshS4fLFg5039eYuml9JbYvXmfE1SCbje5PjUkF
         cNwTvTRUAoKKpjRKopzkaxW6NhRTGYV/LJkpbBn0tp3TNpd1xVKRi3nxPe37PtkvkKck
         Xd9Qtak51zUNaI8M14KJeXLW5lEgRDxZ5Wt6n28jL+Xwc+ycVFAOu7bZ+7BivIhui1AR
         pV0nwz+sZEr6c6J/uNpl5Nh/w4x/CYFXCbZ0YsSheZucqk/ZpebtuPkGoRg9Q8F4jBHO
         IITRzZNNT212Y7JAJJ7aW8Sby4CKMgquBwTVK1sDEGDazYJwtUO6Bd5bZwTlcN9hE3aq
         lJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679013567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upiehW/yJZLSDpEf4y2yHj38zYrZBw51z7iV6HWK5w0=;
        b=nmnl0c8yY54uFYxamsX622/UgXUQCbrt2MwfgWtLmULidk4okCMm+ZiDKMjV1ue1Jj
         GeW4Hou5wCzd6MA/t2PH/JagJrHzqQrzKpiFqU3PIX96Wpn8788nq/95PAYagwDa/n+v
         wGNBedFzyNQ5Hd6v71SlGz844LCYCKt0EQy+BWxjOSQ1Ov4pLvBHgFJNGmeox3mtBvCP
         po/OXs0bXpDULAUiSkU3oG9222lUZp+nnd06Lo6wG/fjWkx3VntOk33xVoUnzONzny7f
         sU8uR4j7GUMkAvbFK0bodx6w8PPStiqttUWJ2qmMfwnQl5KVBPpoX4frftdBjgDeg9B1
         mMKw==
X-Gm-Message-State: AO0yUKXWui+BmkSEi12Qj5TL8gMMFdBVk2HYRGVOs/0TzWE2QVn0Vh4c
        Ka13npqiUQWA1D05DLkybnQgKg==
X-Google-Smtp-Source: AK7set9/5sjpev/ZL/osDaH1GWk4W3mmN0oW9qnRUD8kjrs1+643wwtvBj1UevDajcQUv/2O1M4dJg==
X-Received: by 2002:a05:6512:3092:b0:4db:3902:c709 with SMTP id z18-20020a056512309200b004db3902c709mr322158lfd.32.1679013567039;
        Thu, 16 Mar 2023 17:39:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id e4-20020a056512090400b004a91df49508sm107764lft.177.2023.03.16.17.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 17:39:26 -0700 (PDT)
Message-ID: <ad64143c-13c0-63e3-561a-620c44f26b9d@linaro.org>
Date:   Fri, 17 Mar 2023 01:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope
 values
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
 <20230315103950.2679317-3-stephan.gerhold@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315103950.2679317-3-stephan.gerhold@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 15.03.2023 11:39, Stephan Gerhold wrote:
> According to the msm-3.18 vendor kernel from Qualcomm [1], mdm9607 uses
> a non-standard slope value of 3000 (instead of 3200) for all sensors.
> Fill it properly similar to the 8939 code added recently.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi#L875
> 
FWIW there's a 4.9 release for 9607

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.2.3.6.c5-03900-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in v3: Drop now unused ops_v0_1 definition
> Changes in v2: New patch
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 106d26076e3f..1b454de3928d 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -222,6 +222,16 @@ static int __init init_8939(struct tsens_priv *priv) {
>  	return init_common(priv);
>  }
>  
> +static int __init init_9607(struct tsens_priv *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3000;
> +
> +	return init_common(priv);
> +}
> +
>  /* v0.1: 8916, 8939, 8974, 9607 */
>  
>  static struct tsens_features tsens_v0_1_feat = {
> @@ -271,12 +281,6 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> -static const struct tsens_ops ops_v0_1 = {
> -	.init		= init_common,
> -	.calibrate	= tsens_calibrate_common,
> -	.get_temp	= get_temp_common,
> -};
> -
>  static const struct tsens_ops ops_8916 = {
>  	.init		= init_common,
>  	.calibrate	= calibrate_8916,
> @@ -320,9 +324,15 @@ struct tsens_plat_data data_8974 = {
>  	.fields	= tsens_v0_1_regfields,
>  };
>  
> +static const struct tsens_ops ops_9607 = {
> +	.init		= init_9607,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_common,
> +};
> +
>  struct tsens_plat_data data_9607 = {
>  	.num_sensors	= 5,
> -	.ops		= &ops_v0_1,
> +	.ops		= &ops_9607,
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,
>  };

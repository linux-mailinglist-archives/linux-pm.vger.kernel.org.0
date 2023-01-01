Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027B65AB83
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjAAURl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 15:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjAAURj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 15:17:39 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DABC2610
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 12:17:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so62556448eji.5
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICumxnqx79Zlt31ygyhoGVRMM9iZ4lSSUIEGeCPK1SU=;
        b=vt8F3nsolkG24gJe8VyvRmNJqEGZdUBGs2I5embe4ADHcvEUOZvF7toC+OlXigM1sx
         5vI2TsTf3GsVF9gLb0wjUte7QvzmQBovqgk0dtyqprqmXUdsKGlj+e7pMVJJ7A3viirH
         8TjGDNfZMkQbqsNg2I07Te1u1kLlAOFy9zFL+KnbG2PpejmYyBQTOaKjxMvyR9aC2Uj4
         I47n5GRMTPTyoJY9kGLKFvLri9g36G0VPwlrV+9wpElqv0WrwnumPtNEbSdoDqn5a2js
         IWIor1nvLpuuF0sqKedSb1ckwiwDoxc1UjWBZfubQ+bA6LtUZ3xQabZCVA7256nbJQwK
         oZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICumxnqx79Zlt31ygyhoGVRMM9iZ4lSSUIEGeCPK1SU=;
        b=IQGMIpWNV8OsNdqT2Jf0YcbOHWG7w82rQ9LZs3SwgeElDfI4gonCvtUc5MjffDGQsq
         OU8BQ1PUiMMOdMkopIBHybHWNuGPQ4VrqI+QNQ3wzSOKBqZL46HwvMIPf4lj7z8+eZf8
         FOQqR6VdrL3vxejSwcn+J/bkZ5zhQxnC8Jm1WkI4T2jOqUa+rQnJSi2ZT21B0zCrYXQu
         TOdfhmKVd7CRN5CjyMtjgZMNRaXPAqVJfDnRhnHaNXccjkHnpyCb6Czp6tjZL+EhzJ94
         pur+RTPUMXCERgwrYg7wqELSH26KGoYQetoHg86pIEEFfcubFs4IEzhv+cXm6e/Ms5OD
         wNZg==
X-Gm-Message-State: AFqh2kqnTrBuTKXiwA00YIzcoNYy4heSBxM3lVaZ1vKKYBqTPLyCklL7
        j/Jo+HN51QtyInWe2LrPTiP7hOv/0B1A9Pk9
X-Google-Smtp-Source: AMrXdXvVYNcR65AI2UIc/mTj7k+sO1EyevNqwxCRT4oghrcx7YBR8nO56Ng2K3BbmumLu2lLK+Ph6w==
X-Received: by 2002:a17:906:30c9:b0:78d:f457:1052 with SMTP id b9-20020a17090630c900b0078df4571052mr32479352ejb.15.1672604256854;
        Sun, 01 Jan 2023 12:17:36 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:5825:7f8d:c381:cef4? (2001-1c06-2302-5600-5825-7f8d-c381-cef4.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:5825:7f8d:c381:cef4])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b0084c5a355f28sm8297876eje.179.2023.01.01.12.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 12:17:34 -0800 (PST)
Message-ID: <8dd9f17b-957c-61b3-ae64-85309cd1332c@linaro.org>
Date:   Sun, 1 Jan 2023 20:17:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 08/20] thermal/drivers/tsens: limit num_sensors to 9
 for msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
 <20230101194034.831222-9-dmitry.baryshkov@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230101194034.831222-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/01/2023 19:40, Dmitry Baryshkov wrote:
> On msm8939 last (hwid=10) sensor was added in the hw revision 3.0.
> Calibration data for it was placed outside of the main calibration data
> blob, so it is not accessible by the current blob-parsing code.
> 
> Moreover data for the sensor's p2 is not contiguous in the fuses. This
> makes it hard to use nvmem_cell API to parse calibration data in a
> generic way.
> 
> Since the sensor doesn't seem to be actually used by the existing
> hardware, disable the sensor for now.
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 6645c98ff56c..579028ea48f4 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -285,7 +285,7 @@ static int calibrate_8939(struct tsens_priv *priv)
>   	u32 p1[10], p2[10];
>   	int mode = 0;
>   	u32 *qfprom_cdata;
> -	u32 cdata[6];
> +	u32 cdata[4];
>   
>   	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>   	if (IS_ERR(qfprom_cdata))
> @@ -296,8 +296,6 @@ static int calibrate_8939(struct tsens_priv *priv)
>   	cdata[1] = qfprom_cdata[13];
>   	cdata[2] = qfprom_cdata[0];
>   	cdata[3] = qfprom_cdata[1];
> -	cdata[4] = qfprom_cdata[22];
> -	cdata[5] = qfprom_cdata[21];
>   
>   	mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
>   	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> @@ -314,8 +312,6 @@ static int calibrate_8939(struct tsens_priv *priv)
>   		p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
>   		p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
>   		p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
> -		p2[9] = (cdata[4] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
> -		p2[9] |= ((cdata[5] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5) << 5;
>   		for (i = 0; i < priv->num_sensors; i++)
>   			p2[i] = (base1 + p2[i]) << 2;
>   		fallthrough;
> @@ -331,7 +327,6 @@ static int calibrate_8939(struct tsens_priv *priv)
>   		p1[6] = (cdata[2] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
>   		p1[7] = (cdata[3] & MSM8939_S7_P1_MASK) >> MSM8939_S7_P1_SHIFT;
>   		p1[8] = (cdata[3] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
> -		p1[9] = (cdata[4] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
>   		for (i = 0; i < priv->num_sensors; i++)
>   			p1[i] = ((base0) + p1[i]) << 2;
>   		break;
> @@ -544,7 +539,7 @@ static int __init init_8939(struct tsens_priv *priv) {
>   	priv->sensor[6].slope = 2833;
>   	priv->sensor[7].slope = 2838;
>   	priv->sensor[8].slope = 2840;
> -	priv->sensor[9].slope = 2852;
> +	/* priv->sensor[9].slope = 2852; */
>   
>   	return init_common(priv);
>   }
> @@ -620,9 +615,9 @@ static const struct tsens_ops ops_8939 = {
>   };
>   
>   struct tsens_plat_data data_8939 = {
> -	.num_sensors	= 10,
> +	.num_sensors	= 9,
>   	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, /* 10 */ },
>   
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,


Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

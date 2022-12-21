Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE365339E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiLUPpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Dec 2022 10:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiLUPpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2022 10:45:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4E25E9
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 07:45:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso1860779wms.4
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGbeBQRjTmGtaWEzjEWMVtiqNlsW5lW0CoNY9zIiLc4=;
        b=k81vhdDhN4j7y0R2uh1f2NxwYOxgXJp7lobsFLPPvq/M6F8hB3TFqsN9lZCSAyYnEd
         w8o1nWeu7EELY58lSlSwPPEf7OHtsaeK5VqI5NdERLRgDlkuD8VoffEoiseBO4Me6Xwa
         ifuxfqerftFrPqfHxkggSkp/dgjNFkopcT3j7tY3CoHu1j/tr6DqJjhfL2jhzkknG2rW
         IWHIdkiqSdq/Pns8ulArC0uAW88dF2pnfmWI7AL3zmnA+w8GrN/9mTN8E/U3g+CIdDvs
         Oo5yH1AG6gEDamjIdU0nuUxw+S7xyIawnU/iFCFr8jrFNF/KdSPBc+13/EGs2AsfNPYz
         dHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGbeBQRjTmGtaWEzjEWMVtiqNlsW5lW0CoNY9zIiLc4=;
        b=ekSII8c8ejvtedz6PlMgYqKvZ/f9SCpxzavU3FP7R1BsLL2J3Ue+iMuUOd4ZbjvFxf
         5ShcvWj+a3FJLXnoXlKEqhbhLAw1g5oFQYcQ3B1EaeeFq96YsYbLsourjdHfXTJvj92v
         bmAYuMxph5pzytHK6Ywm6TrzQ/pLBALgE8+JxnpoQ2FW2yGKVof/qb2r5SUKpwmSnIiT
         9lwqROwxbNAXJ4zzGN3050+pxU2lPHvQ1WEVtdHk3i92K3qDV91iwnPRvyBS4yLw1r2C
         xBWjy3jB5v3Uysq/bdNXNz1SDjjGOOqMXPkbLjz12NWjdLMXLNm7mmwj9pXy2MhZJj04
         YiFA==
X-Gm-Message-State: AFqh2koBRS1LNYcJEYezR7jcOCNvgxOpR5LFarcx5BwiiMhQmgeGWwWV
        Jjscv/aSOpJFmrHCaSvNpyI0ug==
X-Google-Smtp-Source: AMrXdXsMuyF2s0KfLk6G49bLBkUwiohwuGsdWlz+hiiVccvbYcehjbTwlBshzkeCA5pNWrZvwQufJQ==
X-Received: by 2002:a05:600c:a51:b0:3d2:3376:6f38 with SMTP id c17-20020a05600c0a5100b003d233766f38mr2020662wmq.20.1671637538618;
        Wed, 21 Dec 2022 07:45:38 -0800 (PST)
Received: from [192.168.175.23] (pur13-1-78-242-214-186.fbx.proxad.net. [78.242.214.186])
        by smtp.googlemail.com with ESMTPSA id v192-20020a1cacc9000000b003cfd4e6400csm2531518wme.19.2022.12.21.07.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:45:37 -0800 (PST)
Message-ID: <ed4aafb9-c33e-6f24-1e9c-7c7efa0e58ae@linaro.org>
Date:   Wed, 21 Dec 2022 16:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 07/20] thermal/drivers/tsens: limit num_sensors to 9
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
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
 <20221221020520.1326964-8-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221221020520.1326964-8-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/12/2022 03:05, Dmitry Baryshkov wrote:
> According to the vendor kernels (msm-3.10, 3.14 and 3.18), msm8939
> supports only 9 sensors. Remove the rogue sensor's hw_id.
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 0bc4e5cec184..57ac23f9d9b7 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -605,9 +605,9 @@ static const struct tsens_ops ops_8939 = {
>   };
>   
>   struct tsens_plat_data data_8939 = {
> -	.num_sensors	= 10,
> +	.num_sensors	= 9,
>   	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9 },

Does not patch 4 says we can drop those hw_ids ?

>   
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


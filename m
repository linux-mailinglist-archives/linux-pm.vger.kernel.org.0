Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F8653767
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiLUUN3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Dec 2022 15:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLUUN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2022 15:13:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9BBDE
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 12:13:26 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f34so9939522lfv.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMyITnYC6iA3G/LtEs1ZWz7dfXVBOhvaku8kkCxxo2s=;
        b=NJ8AI4l2bQDByL8abuo9ZMfM5BPB4rECN8H01ymKifVUY+P87GD6cLLj1DOw8UYrXJ
         RFj0+t9/IMWcKCfvpaHXpHjAn8jiwV/W6dJmariZAs0zaIQC27W6YLXL83pkN9LJofS7
         sWKSxrAIlzfqj1KmTovKHodA+XZN86a5usHWzOFMUwEnlQMqkKT5yXpmlymD1ASRwS9b
         O5ZYDOZGSNYO896EYzazZhQI25k7JEwA4bka5JyJmOFLXIpCX0QvDDJvssCvHX69ea98
         GZ8tE+9HSrIapYUsDAlESvqazowB1JwXFO5oZIzKT+HgKLJxBN1x1QEOWdBtaQb5U6VQ
         Gjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMyITnYC6iA3G/LtEs1ZWz7dfXVBOhvaku8kkCxxo2s=;
        b=6PjoLGneC8PbpxGG1f1uZ4kmYFEb7asLjAgDy6k6OAmZRbDSA6I4lR+1m3229Y2K9m
         ZXROqq8hxHrioxMJdELOzARa9f1G1bwN4maL7dYF+2ltlgVQYFSJCqgVJ3E8/inVBRjp
         ywocLbDfpj3dpmfRtbBOCmwcn+EjFL7GYrtB7qLHBl31yvr+1EhRk8KNAuEdk1TBmDWB
         aDlIN52v/nJinxOtwCckQP1V350aAAykK52YyxYnu0Ikyydg3c7nOe22ATYmDNtZamX7
         5r9JwAzaLpll7SlDytC9lW9I+/NI0gfMOebDKrgmZWRQW9ySqToukxMkWzfupDwUibhA
         I7AQ==
X-Gm-Message-State: AFqh2koj0ewm9hZljB90lch/3IRmWLo8R+82jRfDComryRTWY/Os7lb9
        wOyRVVt/seoIdxa9lOBElPNuwQ==
X-Google-Smtp-Source: AMrXdXute0xsVtVJ10dXcWI2H6DJdIl5HiEylBrKZzmX9Ceo5peUrYXWQp5vg+dwntUF5danaNmPtQ==
X-Received: by 2002:ac2:5975:0:b0:4b5:8f03:a2bc with SMTP id h21-20020ac25975000000b004b58f03a2bcmr756347lfp.9.1671653604897;
        Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b004ca0ea7af24sm788834lfr.174.2022.12.21.12.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Message-ID: <37ee797c-02e5-f35b-2066-feb58e48fb0f@linaro.org>
Date:   Wed, 21 Dec 2022 21:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 07/20] thermal/drivers/tsens: limit num_sensors to 9
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
 <20221221020520.1326964-8-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221221020520.1326964-8-dmitry.baryshkov@linaro.org>
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
> supports only 9 sensors. Remove the rogue sensor's hw_id.
msm-3.18 and 8939.. I would have never thought it was there!


> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 0bc4e5cec184..57ac23f9d9b7 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -605,9 +605,9 @@ static const struct tsens_ops ops_8939 = {
>  };
>  
>  struct tsens_plat_data data_8939 = {
> -	.num_sensors	= 10,
> +	.num_sensors	= 9,
>  	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9 },
>  
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,

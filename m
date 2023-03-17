Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323BA6BDDAF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 01:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCQAfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Mar 2023 20:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQAe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2023 20:34:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62460199EF
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 17:34:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o8so4615419lfo.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 17:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679013296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcGZyf6/fP2eUFJzU25+SHbHn5xFjGzT+o4MUU1iFIE=;
        b=BklvjG3TVnUVx560XPiS0+gDhDksm+rRHqIrDIBpJ4Tq1LC6rAwSD7XB34MKCACvga
         4PZZPufmIkCP0hL1loSFshmjs0Z5Es6XoCBTkoCmAH1g+G5ik/v0CZ32FyXMyF6YW50G
         sqvNEy1FxbIvw5sZa8/SNfbr1WyDjHxJTif/Cvaiko9slCaSttOHmcuGpmziGbGoF0JS
         YVlwmpRDsVIeXqzjuvCT5vu7pP3fK6TkWL08P9XADNYPHC5sTMlCqojbnzrqlAmEQC8K
         /mjlB+A2zAlKzvJvblHUvEv2kt8+Cmte1PjN3k6QQvFD7orLkeIunVHIeDq10ksmRK4+
         kX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679013296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcGZyf6/fP2eUFJzU25+SHbHn5xFjGzT+o4MUU1iFIE=;
        b=D+vwS3kBTXBCy/Vi1Q1KC3Ej8z9R/49pt8T3vLZfBXmyshd1vyRc1DwM/kroNIfdij
         r4gdn6tjWdM/0CQ/RgOeSnd+qq7LtuDPvjqyZz5A+9dBj9v9dLfwUS4OFNsmI4HEgH3P
         Sggl1YLbj12kqP0B6P/BtiW23fXpNeH9q0l/H7/P+Vcw/9LDE/8F1q/99aV7fEMRGsJQ
         r2IuuHBo1HqKP/Z8cdMNg5+XGvOvss7Ga02dzQiaJfgHfpB99wv+JKrkD8xdfJn/sclB
         srfNTNz3r1s5TcvuQOTSM2FWMdRewerYYa4TmZNF5ImnqMBwTUSw87Co+uLQH1M0G5YO
         6uDA==
X-Gm-Message-State: AO0yUKXFPhdzGRxX8ne7AID2CYaj2sJKAJloPHx5cWLM/wi0wXXi4J1z
        OVHZtn0zMwYIp16veqb3jNyfIA==
X-Google-Smtp-Source: AK7set/U9dXnEda15D3c3H4W6GnNH+mKM+19pEigXH0y4nOPnXk+mOT8rBhmTsIEAYUa7jr38IA55w==
X-Received: by 2002:ac2:43a8:0:b0:4dc:7ff4:83f9 with SMTP id t8-20020ac243a8000000b004dc7ff483f9mr3431720lfl.16.1679013296615;
        Thu, 16 Mar 2023 17:34:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id f7-20020ac24e47000000b004d85a7e8b17sm103067lfr.269.2023.03.16.17.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 17:34:56 -0700 (PDT)
Message-ID: <af2dbf53-5353-0c35-c333-2798752e01ac@linaro.org>
Date:   Fri, 17 Mar 2023 01:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/6] thermal: qcom: tsens: Drop unused legacy structs
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
 <20230315103950.2679317-2-stephan.gerhold@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315103950.2679317-2-stephan.gerhold@kernkonzept.com>
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
> The old single-cell parsing code was removed for MSM8939, MDM9607 and
> MSM8976 but for some reason the structs defining the bit positions etc
> were kept around (unused). Drop them now.
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 51d78b8b1beb ("thermal/drivers/tsens: Drop single-cell code for mdm9607")
> Fixes: dfadb4599ab0 ("thermal/drivers/tsens: Drop single-cell code for msm8939")
> Fixes: 3a908971f7cb ("thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> Changes in v3: None
> Changes in v2: New patch
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 36 -------------------------------
>  drivers/thermal/qcom/tsens-v1.c   | 22 -------------------
>  2 files changed, 58 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index e89c6f39a3ae..106d26076e3f 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -39,26 +39,6 @@ struct tsens_legacy_calibration_format tsens_8916_nvmem = {
>  	},
>  };
>  
> -struct tsens_legacy_calibration_format tsens_8939_nvmem = {
> -	.base_len = 8,
> -	.base_shift = 2,
> -	.sp_len = 6,
> -	.mode = { 12, 0 },
> -	.invalid = { 12, 2 },
> -	.base = { { 0, 0 }, { 1, 24 } },
> -	.sp = {
> -		{ { 12, 3 },  { 12, 9 } },
> -		{ { 12, 15 }, { 12, 21 } },
> -		{ { 12, 27 }, { 13, 1 } },
> -		{ { 13, 7 },  { 13, 13 } },
> -		{ { 13, 19 }, { 13, 25 } },
> -		{ { 0, 8 },   { 0, 14 } },
> -		{ { 0, 20 },  { 0, 26 } },
> -		{ { 1, 0 },   { 1, 6 } },
> -		{ { 1, 12 },  { 1, 18 } },
> -	},
> -};
> -
>  struct tsens_legacy_calibration_format tsens_8974_nvmem = {
>  	.base_len = 8,
>  	.base_shift = 2,
> @@ -103,22 +83,6 @@ struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
>  	},
>  };
>  
> -struct tsens_legacy_calibration_format tsens_9607_nvmem = {
> -	.base_len = 8,
> -	.base_shift = 2,
> -	.sp_len = 6,
> -	.mode = { 2, 20 },
> -	.invalid = { 2, 22 },
> -	.base = { { 0, 0 }, { 2, 12 } },
> -	.sp = {
> -		{ { 0, 8 },  { 0, 14 } },
> -		{ { 0, 20 }, { 0, 26 } },
> -		{ { 1, 0 },  { 1, 6 } },
> -		{ { 1, 12 }, { 1, 18 } },
> -		{ { 2, 0 },  { 2, 6 } },
> -	},
> -};
> -
>  static int calibrate_8916(struct tsens_priv *priv)
>  {
>  	u32 p1[5], p2[5];
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index b822a426066d..51322430f1fe 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -42,28 +42,6 @@ struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
>  	},
>  };
>  
> -struct tsens_legacy_calibration_format tsens_8976_nvmem = {
> -	.base_len = 8,
> -	.base_shift = 2,
> -	.sp_len = 6,
> -	.mode = { 4, 0 },
> -	.invalid = { 4, 2 },
> -	.base = { { 0, 0 }, { 2, 8 } },
> -	.sp = {
> -		{ { 0, 8 },  { 0, 14 } },
> -		{ { 0, 20 }, { 0, 26 } },
> -		{ { 1, 0 },  { 1, 6 } },
> -		{ { 1, 12 }, { 1, 18 } },
> -		{ { 2, 8 },  { 2, 14 } },
> -		{ { 2, 20 }, { 2, 26 } },
> -		{ { 3, 0 },  { 3, 6 } },
> -		{ { 3, 12 }, { 3, 18 } },
> -		{ { 4, 2 },  { 4, 9 } },
> -		{ { 4, 14 }, { 4, 21 } },
> -		{ { 4, 26 }, { 5, 1 } },
> -	},
> -};
> -
>  static int calibrate_v1(struct tsens_priv *priv)
>  {
>  	u32 p1[10], p2[10];

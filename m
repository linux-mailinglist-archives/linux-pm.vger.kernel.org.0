Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0565C0DF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 14:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbjACNb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 08:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbjACNbq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 08:31:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946AD331
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 05:31:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j17so36179806lfr.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 05:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4F07qx/QVlS2RAoXeqbSO8X5f50BArwoSvnoJo3aGw=;
        b=XfKHz0owizOb1M8oze5ybsZSstPeuRmOw5Osh7no/tCYwo2GxK5ASeSfUKjsWAutdL
         o1qT7Pxc/P0Bftl1pC7oi4a4Mfpvn5Do8TY9gKiWSTDZlqm908grTca4ghMRhwen8ff+
         yyai57hBSrI44W4pvwyGos3gqeHbo4SYX1t0X1y6OhENsztKIXJZbntjF1cm0LN52yD2
         P8oi6yXffgNe8UxRgwr/x+5ifol/iBk060R7Bc2IpF3zfI3LiA1zorkL0xvc/FIV/Zeu
         Fvmu6AsuLCqx4FL1Di0xCs0PqRKLoY5ZtUXXfv9VHujPYmIEB93DGK4Pa8SsPZ2B/K6x
         YyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4F07qx/QVlS2RAoXeqbSO8X5f50BArwoSvnoJo3aGw=;
        b=HmtQSsmMHEUrw4rurOlztlsNrTmiUtpYHcRFsN3Orkq7S1OD7Cg8rjJUyIIOYftk9c
         +gm7Umxrde2yKZajoQ9m26W3QJyhyCyNl8Pa2TCTFX+NuJ93DF0KDQaqegI+JyrydY6I
         2YbNkh0y7sb6svgaRk9cjLDZfBBQCz+CVyiq24JsBPjOnMKLNpquOqHsVw7N9ihLZFsy
         V1AnMgBNYoezCoI8U7v5OrUQlMASySeuymgHEKwhNOZCEXH99aj+kgQbUmy/ramknBS7
         2xBfp+zrFp4EC/QnMSD7pkUD2/F123fj+kNv5Snl9qOv9CxLF7nKQCWE2Qq692mTo0Y4
         T+7A==
X-Gm-Message-State: AFqh2krrx2xxyU5rV+V+/HSGv7rlE3v6Lpbni23uaAREyjOpatj0g/bh
        dxpd/9AtGX8Oc0+f5qSe0csshw==
X-Google-Smtp-Source: AMrXdXvUjM9oU81WsMfVf8yfr4w3MhaFjnuZ4sFElY3etij9CxmsN8LK51kzJpmsxsjyR9umYznc+w==
X-Received: by 2002:a05:6512:32cc:b0:4cb:4378:9c6 with SMTP id f12-20020a05651232cc00b004cb437809c6mr118398lfg.23.1672752702906;
        Tue, 03 Jan 2023 05:31:42 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25312000000b004cb2995de37sm1537942lfh.265.2023.01.03.05.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:31:42 -0800 (PST)
Message-ID: <944603e6-d898-30d9-b5a1-16cb553c0d04@linaro.org>
Date:   Tue, 3 Jan 2023 14:31:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] interconnect: qcom: drop obsolete OSM_L3/EPSS defines
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230103045717.1079067-1-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103045717.1079067-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3.01.2023 05:57, Dmitry Baryshkov wrote:
> Since Qualcomm platforms have switched to the separate OSM_L3/EPSS
> driver, old related defines became unused. Drop them now.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/sc7180.h  | 2 --
>  drivers/interconnect/qcom/sc7280.h  | 2 --
>  drivers/interconnect/qcom/sc8180x.h | 2 --
>  drivers/interconnect/qcom/sdm845.h  | 2 --
>  drivers/interconnect/qcom/sm8150.h  | 2 --
>  drivers/interconnect/qcom/sm8250.h  | 2 --
>  6 files changed, 12 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
> index c6212a10c2f6..c2d8388bb880 100644
> --- a/drivers/interconnect/qcom/sc7180.h
> +++ b/drivers/interconnect/qcom/sc7180.h
> @@ -145,7 +145,5 @@
>  #define SC7180_SLAVE_SERVICE_SNOC			134
>  #define SC7180_SLAVE_QDSS_STM				135
>  #define SC7180_SLAVE_TCU				136
> -#define SC7180_MASTER_OSM_L3_APPS			137
> -#define SC7180_SLAVE_OSM_L3				138
>  
>  #endif
> diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
> index 1fb9839b2c14..175e400305c5 100644
> --- a/drivers/interconnect/qcom/sc7280.h
> +++ b/drivers/interconnect/qcom/sc7280.h
> @@ -150,7 +150,5 @@
>  #define SC7280_SLAVE_PCIE_1			139
>  #define SC7280_SLAVE_QDSS_STM			140
>  #define SC7280_SLAVE_TCU			141
> -#define SC7280_MASTER_EPSS_L3_APPS		142
> -#define SC7280_SLAVE_EPSS_L3			143
>  
>  #endif
> diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
> index 2eafd35543c7..ce32295af8f3 100644
> --- a/drivers/interconnect/qcom/sc8180x.h
> +++ b/drivers/interconnect/qcom/sc8180x.h
> @@ -168,8 +168,6 @@
>  #define SC8180X_SLAVE_EBI_CH0_DISPLAY		158
>  #define SC8180X_SLAVE_MNOC_SF_MEM_NOC_DISPLAY	159
>  #define SC8180X_SLAVE_MNOC_HF_MEM_NOC_DISPLAY	160
> -#define SC8180X_MASTER_OSM_L3_APPS		161
> -#define SC8180X_SLAVE_OSM_L3			162
>  
>  #define SC8180X_MASTER_QUP_CORE_0		163
>  #define SC8180X_MASTER_QUP_CORE_1		164
> diff --git a/drivers/interconnect/qcom/sdm845.h b/drivers/interconnect/qcom/sdm845.h
> index 776e9c2acb27..bc7e425ce985 100644
> --- a/drivers/interconnect/qcom/sdm845.h
> +++ b/drivers/interconnect/qcom/sdm845.h
> @@ -136,7 +136,5 @@
>  #define SDM845_SLAVE_SERVICE_SNOC			128
>  #define SDM845_SLAVE_QDSS_STM				129
>  #define SDM845_SLAVE_TCU				130
> -#define SDM845_MASTER_OSM_L3_APPS			131
> -#define SDM845_SLAVE_OSM_L3				132
>  
>  #endif /* __DRIVERS_INTERCONNECT_QCOM_SDM845_H__ */
> diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
> index 97996f64d799..3e01ac76ae1d 100644
> --- a/drivers/interconnect/qcom/sm8150.h
> +++ b/drivers/interconnect/qcom/sm8150.h
> @@ -148,7 +148,5 @@
>  #define SM8150_SLAVE_VSENSE_CTRL_CFG		137
>  #define SM8150_SNOC_CNOC_MAS			138
>  #define SM8150_SNOC_CNOC_SLV			139
> -#define SM8150_MASTER_OSM_L3_APPS		140
> -#define SM8150_SLAVE_OSM_L3			141
>  
>  #endif
> diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
> index b31fb431a20f..7eb6c709c30d 100644
> --- a/drivers/interconnect/qcom/sm8250.h
> +++ b/drivers/interconnect/qcom/sm8250.h
> @@ -158,7 +158,5 @@
>  #define SM8250_SLAVE_VSENSE_CTRL_CFG		147
>  #define SM8250_SNOC_CNOC_MAS			148
>  #define SM8250_SNOC_CNOC_SLV			149
> -#define SM8250_MASTER_EPSS_L3_APPS		150
> -#define SM8250_SLAVE_EPSS_L3			151
>  
>  #endif

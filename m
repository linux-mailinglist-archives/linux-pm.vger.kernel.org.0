Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C049658C28
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 12:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiL2L1f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 06:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiL2L1d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 06:27:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257CC13DCE
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:27:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so27105188lfa.12
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6cYkADYaTEQWo01yc2kQCg0VkSDlJKWqZ/VQrXh2xc=;
        b=DmWyc1xr4IO7Mkcpw0v2O7eJo30YKYPi4KMBi/FEtoB7/vqmjxtKzazVnWrHKcBCkK
         LaoGJpH47+S827vyzNsmt2t5zMObZsPBIiBTrQEphQfDQS0YFvqtLWE+MT7lU2D0qLcO
         5yXQIlNzfLfT8J2m7MTxRbd6AYMSUeslhAs9p50Nrb1ymvjS4NkFhwp99pJ64QkVOxn/
         vlUSnYqlPZkans/JMb111NgRI3byS+JGaYAv7AxIa9aEXDcjF0UVA+ZQ7ilbrJm7CcIo
         V8NdvREjoP6IinwFUZzHoBLAi/pPe3xyuczMjROSqupSV7Q05Yy0lfysw1kIeMjwB5e1
         hHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6cYkADYaTEQWo01yc2kQCg0VkSDlJKWqZ/VQrXh2xc=;
        b=vr22HN75xJucg8h3J5kDSH9yYdE0zPcNd1F0CsYBtQvNA772aNnJ1WwSq1Yc/0I1aG
         bXeZm3qChNQqItG1x6f4q0cJj0HsgEuQ8gyVqJdfW6UIOocJifbSJGwT9Llhq5xUsQD4
         AeA0bjQVSInV8xbx5b2c/DWFph1gEcVdEJxDa3HRssLZZaMM0Qng5oolj3t2rQQRa2sO
         rLmslPp1F1zh7pM4TpHaWI6a11xSdwhy7wcv1Lvm8fsvDJQ2LStbN0kQJUWF0KfiQCca
         vexMeVu+Q/XXUNxMOudbGG5JtKdWheG00g+y9I7F9am/E23X5/Jrn6Ey5JtVndmgNUgq
         C82g==
X-Gm-Message-State: AFqh2kqj1bdx9zpD0IwLwazvVqX9a3jT8MpMxqzYS+yUdYLGmEHdzDOI
        bZMgXqmFJzhjQBQdl3XuyImhWA==
X-Google-Smtp-Source: AMrXdXu9IGyWcY9fCbLX60r0Ul/05e6XBEfNfIqaeUSf3sa7dyWXd3eS0rWayB/S9cqRFqznY0CAKg==
X-Received: by 2002:a05:6512:70b:b0:4b4:8bc3:21f9 with SMTP id b11-20020a056512070b00b004b48bc321f9mr8904892lfs.36.1672313252700;
        Thu, 29 Dec 2022 03:27:32 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id i20-20020a0565123e1400b004a91df49508sm3016911lfv.177.2022.12.29.03.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 03:27:32 -0800 (PST)
Message-ID: <c787e25f-dddb-2b17-4bad-0c5a87e30c42@linaro.org>
Date:   Thu, 29 Dec 2022 12:27:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 14/20] thermal/drivers/tsens: Drop single-cell code for
 msm8976/msm8956
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
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-15-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221229030106.3303205-15-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29.12.2022 04:01, Dmitry Baryshkov wrote:
> There is no dtsi file for msm8976 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8976.
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v1.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 6d1ea430f90b..b822a426066d 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -88,31 +88,6 @@ static int calibrate_v1(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> -static int calibrate_8976(struct tsens_priv *priv)
> -{
> -	u32 p1[11], p2[11];
> -	u32 *qfprom_cdata;
> -	int mode, ret;
> -
> -	ret = tsens_calibrate_common(priv);
> -	if (!ret)
> -		return 0;
> -
> -	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(qfprom_cdata))
> -		return PTR_ERR(qfprom_cdata);
> -
> -	mode = tsens_read_calibration_legacy(priv, &tsens_8976_nvmem,
> -					     p1, p2,
> -					     qfprom_cdata, NULL);
> -
> -
> -	compute_intercept_slope(priv, p1, p2, mode);
> -	kfree(qfprom_cdata);
> -
> -	return 0;
> -}
> -
>  /* v1.x: msm8956,8976,qcs404,405 */
>  
>  static struct tsens_features tsens_v1_feat = {
> @@ -211,7 +186,7 @@ struct tsens_plat_data data_tsens_v1 = {
>  
>  static const struct tsens_ops ops_8956 = {
>  	.init		= init_8956,
> -	.calibrate	= calibrate_8976,
> +	.calibrate	= tsens_calibrate_common,
>  	.get_temp	= get_temp_tsens_valid,
>  };
>  
> @@ -224,7 +199,7 @@ struct tsens_plat_data data_8956 = {
>  
>  static const struct tsens_ops ops_8976 = {
>  	.init		= init_common,
> -	.calibrate	= calibrate_8976,
> +	.calibrate	= tsens_calibrate_common,
>  	.get_temp	= get_temp_tsens_valid,
>  };
>  

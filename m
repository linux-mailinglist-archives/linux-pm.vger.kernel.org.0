Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4E4F7AF6
	for <lists+linux-pm@lfdr.de>; Thu,  7 Apr 2022 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiDGJE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Apr 2022 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiDGJEv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2022 05:04:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04222FFB61
        for <linux-pm@vger.kernel.org>; Thu,  7 Apr 2022 02:02:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso3206558wml.5
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2022 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pjTtN3AtheF0vn4ZuwhbnCGLFVHktDXUfGX7a5M8YqM=;
        b=sah5F0KV3kWlryn659cbatWIbwr+TIDj4vqgX+7AQ/QQT3lJ+phXRNSUAviN/ZWRTF
         d+o01cxs9n/OGmRoWEMF9I+nEZdN9g6xL7SoSVTmy3zLRJMwVH68/PyTKi2c8IjlQUhK
         fcEr+s3dip1TSjHKwdp98LRT188nl+tNdjG9zJA+29BR3EjlRzDv8YWb5FipH8Mx0LnS
         AFdi613Wo7JoqP7Kch16/N7/bpAB6cNmUupuwnilwBoThcatet43Qrqgt0F69v2eifli
         wpR83PKSH2nh2JAe7+JBQ1+qKyklZICJB0i2bSbh9E2ByrFEl2h0fo2q9qx5XtcjhIuC
         Qg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pjTtN3AtheF0vn4ZuwhbnCGLFVHktDXUfGX7a5M8YqM=;
        b=qEFYv2Q3ax4b2PVzE3F2k8UbTBUKo/O4DTBgUVfptpkNur7yzlCBVDvFoi41sIaREi
         VD/FnEOO60leV8vNpnEYDEXs4v13V65ZQDGibHKxK1QemhN+VSK6KvzbpJt9DXYeNcRg
         9a/cg+rEx+BRMrf3mu4Hvo+pBJ4eEesWWcXSMwycc1kFZPYXs12R07EAfqP9WelQH/lD
         Sm2xdOBNPTCERzJXnGgGvRbT3C5fg8m/WrjiOjzia4O056mX5uGzyzB2PuLRYWajJ0LT
         4BCdvumBWx688ePF6msbS+/5yVmx+bOXPMn5ZYLNLJ2HQHpcLG/gX2nyHVquR1Z0WcYF
         9srA==
X-Gm-Message-State: AOAM531pBROCXTubewemnyR2/bUEwpXVBxfaXsrhoz/8oh2g75yyb8pa
        nakl4KNJpM1cvpuO2o9pLnsYvA==
X-Google-Smtp-Source: ABdhPJw5/Kl2zo4WFzmxgemr3M64uxM6RL7llDDspMhcdYPQZLBhjeUjaMkR243zjxjIS44aW6fslw==
X-Received: by 2002:a05:600c:190e:b0:38c:b19d:59ff with SMTP id j14-20020a05600c190e00b0038cb19d59ffmr11198807wmq.1.1649322157299;
        Thu, 07 Apr 2022 02:02:37 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:f2a2:7d81:4e67:6c1c? ([2a01:e34:ed2f:f020:f2a2:7d81:4e67:6c1c])
        by smtp.googlemail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm7668871wmq.42.2022.04.07.02.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:02:36 -0700 (PDT)
Message-ID: <a8c085bc-3a69-ea4c-bcfe-9742e0fde852@linaro.org>
Date:   Thu, 7 Apr 2022 11:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] thermal/drivers/tsens: add compat string for the
 qcom,msm8960
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
 <20220406002648.393486-3-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220406002648.393486-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/04/2022 02:26, Dmitry Baryshkov wrote:
> On apq8064 (msm8960) platforms the tsens device is created manually by
> the gcc driver. Prepare the tsens driver for the qcom,msm8960-tsens
> device instantiated from the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/thermal/qcom/tsens.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 154d3cb19c88..7963ee33bf75 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -979,6 +979,9 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,msm8939-tsens",
>   		.data = &data_8939,
> +	}, {
> +		.compatible = "qcom,msm8960-tsens",
> +		.data = &data_8960,
>   	}, {
>   		.compatible = "qcom,msm8974-tsens",
>   		.data = &data_8974,

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

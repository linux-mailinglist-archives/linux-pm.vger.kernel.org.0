Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494062D4D0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 09:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiKQILk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 03:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiKQILf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 03:11:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436E7299F
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 00:11:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h9so2490188wrt.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 00:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GSDs5LdHc1GClN9BOpJmoylm0WvCAVObkEVsoDAxlO4=;
        b=r0FZO5s1ap9cOFsk6RQQUgILd1eQ1KJmXqoERRVEk+SDEr69Mqp8/jO3SOq0pPyEfg
         xyRLsw4Z9JBl1sS1B9KSDjDGNRWdcz4DLmn+arCWrwAx68GIksomq1vpKgpU9a0wRXhJ
         DhrrAy/1ibC0Ye3Pp4uEXfXAEqWY187CdROqTcy47ex0w0W5GKfRwyUNZDOSYvMaa+Py
         Ao+RZDsaReU7SGo5IFohN2VHtgwKjUoELoRNZDrbdFUKJ1e+nPzNfWhFGV36f7rZDWMy
         rPo7RDEOHso8gEQr8Q/5iA9eazVaSLfQ5knRqusznHXuMBxlGE6w2f5wOfeEGkw9q9tb
         Qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSDs5LdHc1GClN9BOpJmoylm0WvCAVObkEVsoDAxlO4=;
        b=aktu4fJy2M9A9sagLjUuQ47pyI9FTsGNYjmAF+wnj+uie3CaWjBGc561tcx/a+aJz2
         ObQqG0Rm5FioYsdB8qyiEyFAaLTGnZahRijQO58+9s+L78GKjv69R170Wb/50T2ezvSX
         tg0PbfBRDLr9PuXugxTxtZv8ozzonMhpcKf1eJx4oYgRrvKRjwGafSso5zhDxr35vsDv
         tsBaCG7tRXQTWktoI8SAvCHJoJUJ5nC8d/pjkO9bmQWggxIUnaGNQGoEJjHpg5tSF314
         CwxAzN6cR/G+zpN2MKU9CH/ZkUcuc8HhYCzO72tgOy3ieD9Cipw8tj+cOeh0CTknnIFF
         KdJg==
X-Gm-Message-State: ANoB5plb4DBMIcB1EGpR9cSSWseP4ZhWB2szDr7ciokUpNnvIMHDRyB8
        xyg0yhnJmkW4o4ckL1+s3UGpsQ==
X-Google-Smtp-Source: AA0mqf7qpnoW4oon/wCyl92ramVcqcJQ8WoPvAUNR9afh+NQwKZzCFTqLi93tM56RVJUXW9fbx6Kow==
X-Received: by 2002:a5d:4752:0:b0:236:d479:b0b7 with SMTP id o18-20020a5d4752000000b00236d479b0b7mr679838wrs.559.1668672676540;
        Thu, 17 Nov 2022 00:11:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b? ([2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b0022cd96b3ba6sm285288wrt.90.2022.11.17.00.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:11:16 -0800 (PST)
Message-ID: <30034a1e-1a68-65eb-627e-744c53ae854f@linaro.org>
Date:   Thu, 17 Nov 2022 09:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: narrow interrupts for
 SC8280XP, SM6350 and SM8450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/11/2022 12:31, Krzysztof Kozlowski wrote:
> Narrow number of interrupts per variants: SC8280XP, SM6350 and SM8450.
> The compatibles are already used and described.  They only missed the
> constraints of number of interrupts.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index f0bd4b979e28..5bcfddc877d3 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -146,11 +146,14 @@ allOf:
>                 - qcom,sc7180-tsens
>                 - qcom,sc7280-tsens
>                 - qcom,sc8180x-tsens
> +              - qcom,sc8280xp-tsens
>                 - qcom,sdm630-tsens
>                 - qcom,sdm845-tsens
> +              - qcom,sm6350-tsens
>                 - qcom,sm8150-tsens
>                 - qcom,sm8250-tsens
>                 - qcom,sm8350-tsens
> +              - qcom,sm8450-tsens
>                 - qcom,tsens-v2
>       then:
>         properties:

Thanks, I will rebase the SM8550 change on this patch,

Neil

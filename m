Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9862E512D9F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbiD1IDx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343720AbiD1IDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 04:03:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463F9D4C4
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 01:00:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i19so7871519eja.11
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hoO0z6ox/0MpErRBciBUS6KXmSs/8Ul8Shji/6D5s6Y=;
        b=jZR3MnpAJ0mog/qurS4zjfNeTVjwu1R7dSeZynWmrRUlEZfEoirRMAK3v6lTFs5aVR
         K/IrQ+bSRwQLSvEehuSzvgPTugl+v8t7cVjMD6NekHDNTbNmUGJIjGwK30LFkBdg48I/
         mFEfqXI64C1SFJMPO3C7VNKI/9Xu8sN7YCfO/8g6Z6qTDHL/JaAXK9BKv+kdpnb5M7CQ
         4MGS0X/j5eZ17YI1xOUk4alTxSK4qStpr7lX8GXDmhLB+qzov5iAeomdKLn5cFhbu5Pf
         LIqJV62giHlfnTfPfbUC/Z2SeHwsjm1udPgr43A8zInqYCW2xVtBRqLK23maRIk07asU
         s4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hoO0z6ox/0MpErRBciBUS6KXmSs/8Ul8Shji/6D5s6Y=;
        b=fRSshG713ynAQTGyj7EgHDyMFWlqLYtTa/mc1ZB+iXzsAYT2GdqJXnwPrY+OOlBT+k
         PHzRLRdaZBHrEjfyHAVBA+jKGme8MW2GGiZSgSMgjWbyiMSYKFrO8R++Jz302yR/p5Cn
         ue11sTDbJiji+9aUNrky2agedPn8LWsF3iqqkQ7TB0P/zv6RydSEl3D9z3+3B993WWh5
         9f3buysHy/vv2pYMSrcvzTfvNb48PLC0UA7LjkkEfJthshPrW/p8YRXW8kDqOs0l0d4J
         5Q5xhR2phbmN1v+rVaAEm4Az777JAnFHVoCyHGm9C9zPk716d8OQxQybATgp4T1YbUsu
         3Oiw==
X-Gm-Message-State: AOAM533ytAGJksrDoL4oDApConBxq2HiQoWielNQCMm1Obcgv/rXX/A5
        2BR8cfTze04e5bwkMv8i8QYQZA==
X-Google-Smtp-Source: ABdhPJxY0l6cGk55GfOnpY/HEIBGRKGps3VQWZY7889JQ0r8sNS6Iig2RknQXv0yzdCXTzT7tNj+Nw==
X-Received: by 2002:a17:906:2294:b0:6f3:bd02:95a3 with SMTP id p20-20020a170906229400b006f3bd0295a3mr9758882eja.201.1651132827289;
        Thu, 28 Apr 2022 01:00:27 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709060f4700b006e8d0746969sm7855860ejj.222.2022.04.28.01.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 01:00:26 -0700 (PDT)
Message-ID: <e41bad2a-3453-e5ce-2f92-b4655a5453f6@linaro.org>
Date:   Thu, 28 Apr 2022 10:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] dt-bindings: clock: qcom,gcc-apq8064: split tsens
 to the child node
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
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_tdas@quicinc.com
References: <20220427125423.3166138-1-dmitry.baryshkov@linaro.org>
 <20220427125423.3166138-4-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427125423.3166138-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 27/04/2022 14:54, Dmitry Baryshkov wrote:
> Split tsens properties to the child node of the gcc. This follows the
> lead of ipq8064 (which also uses a separate node for tsens) and makes
> device tree closer to other platforms, where tsens is a completely
> separate device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 49 +++++++++----------
>  1 file changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index bd7b04c75e50..3a8bb5a5b37f 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -23,47 +23,42 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,gcc-apq8064
> -      - qcom,gcc-msm8960
> -
> -  nvmem-cells:
> -    minItems: 1
> -    maxItems: 2
> -    description:
> -      Qualcomm TSENS (thermal sensor device) on some devices can
> -      be part of GCC and hence the TSENS properties can also be part
> -      of the GCC/clock-controller node.
> -      For more details on the TSENS properties please refer
> -      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> -
> -  nvmem-cell-names:

All these properties (and old compatible list) should be rather instead
made deprecated:true. These bindings exists since some time, so it's not
like refactoring during development.

> -    minItems: 1
>      items:
> -      - const: calib
> -      - const: calib_backup
> +      - enum:
> +          - qcom,gcc-apq8064
> +          - qcom,gcc-msm8960
> +      - const: syscon
> +
> +  thermal-sensor:
> +    type: object
>  
> -  '#thermal-sensor-cells':
> -    const: 1
> +    allOf:
> +      - $ref: /schemas/thermal/qcom-tsens.yaml#

No need for allOf and type, just $ref and description.

>  
>  required:
>    - compatible
> -  - nvmem-cells
> -  - nvmem-cell-names
> -  - '#thermal-sensor-cells'
>  
>  unevaluatedProperties: false


Best regards,
Krzysztof

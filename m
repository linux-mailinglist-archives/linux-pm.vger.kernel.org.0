Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02B50F258
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiDZH3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbiDZH3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 03:29:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889013E16
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 00:26:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l19so8171976ljb.7
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ip4yKprUwa5CWGfKSGf6LxYHkAhSkHn2zyYdRVkuKYU=;
        b=lM/cGyNPCgOlRbQmCDv2N0LFI8Z/V1E3GPTN3qhv6IeGaKXN89UYs3/xI2kcwElbtG
         g4o7WQ9jIP5pxzL9gWHSBOjFqAIZilmXBnEWYQbWRlG+Vvr6Uu2mZXDNgx7F6qhoP6p7
         KaIajNLuJH6vtSFd0Cptuqa6QLdml1zWy9D/S4XCiWhQOyKo2zKpYW8fOhzah8JTnb86
         byhACWCLlrYEWu40468Fal0BIm0Ber8W91ukxTecLm6UqPyfCBNLhBWoewva5Gu7p9wu
         q6TWpnHeZ36EqEBakXDRlUbSiJXMjItpxV2Ynu6tgFrxGp+jmdY5mQuKU/zP36H7BgBq
         q9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ip4yKprUwa5CWGfKSGf6LxYHkAhSkHn2zyYdRVkuKYU=;
        b=6ur7RNmQY7yCO8sKDTg0yBi4Zzuk9t8NUbHsl27ICMVYBd7/m69Fdb+V1//dskec17
         ztJ2D3mJjK+iqcGxGI4cmXumKV6VKcdBMGrr2DcKUmReABbfI/diSs/WNpepQ6LSk8c5
         6NpMUDDlcaLCBVxqUIfojlDuKqWviOuBzMQz2LL+QZgYc8rFCVE8QkqndMTsgvx4leUt
         9yBLgCRmljeOddlrs0R7hlfLboVgBtOJTTrTK624lVpr0xitfUw4NC2qYX+EX7J+Q2Mc
         XEAhpTmT2Iwnu0zobr31YwP8YBoBSUbL828zC+N6dVJyEduDJOErPBWE1APvGLBTHjZv
         qecQ==
X-Gm-Message-State: AOAM532+D8kl2g3aLfDcjLez6a0W8wJYg4aMAgGn7aiBDyWsNvcxCojn
        y2UvzagM5Qq+2n+2AG1HE7ZzpA==
X-Google-Smtp-Source: ABdhPJwYgtV/i5ybL48Y+kjThwzp8oCL1bzTgORpgBsO3BcnlY+Ccb/X9tyWeGjjIRdQU0g/NK/9JQ==
X-Received: by 2002:a2e:bf12:0:b0:249:3a3b:e91a with SMTP id c18-20020a2ebf12000000b002493a3be91amr13833393ljr.343.1650957963192;
        Tue, 26 Apr 2022 00:26:03 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h13-20020a056512338d00b0047203470747sm795653lfg.245.2022.04.26.00.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:26:02 -0700 (PDT)
Message-ID: <3f407912-be75-19a8-d406-ae042d23fd9e@linaro.org>
Date:   Tue, 26 Apr 2022 10:26:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: qcom,gcc-apq8064: split tsens
 to the child node
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
References: <20220425212750.2749135-1-dmitry.baryshkov@linaro.org>
 <20220425212750.2749135-4-dmitry.baryshkov@linaro.org>
 <8579a3df-1a1d-c258-f65e-531cf0731949@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8579a3df-1a1d-c258-f65e-531cf0731949@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/04/2022 10:08, Krzysztof Kozlowski wrote:
> On 25/04/2022 23:27, Dmitry Baryshkov wrote:
>> Split tsens properties to the child node of the gcc. This follows the
>> lead of ipq8064 (which also uses a separate node for tsens) and makes
>> device tree closer to other platforms, where tsens is a completely
>> separate device.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../bindings/clock/qcom,gcc-apq8064.yaml      | 45 +++++++------------
>>   1 file changed, 17 insertions(+), 28 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
>> index b867da12761e..f2762599f679 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
>> @@ -23,47 +23,36 @@ description: |
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,gcc-apq8064
>> -      - qcom,gcc-msm8060
> 
> Hm, such list does not exist in mainline, so is your set rebased on
> something? See also:
> https://lore.kernel.org/linux-devicetree/20220425133527.3723233-1-robh@kernel.org/
> https://lore.kernel.org/linux-devicetree/20220426064241.6379-1-krzysztof.kozlowski@linaro.org/

Ugh, yes. I missed a patch during git send-email. I've sent it 
separately (dt-bindings: clock: gcc-apq8064: move qcom,apq8084 back to 
gcc-other.yaml)

> 
> 
>> -
>> -  nvmem-cells:
>> -    minItems: 1
>> -    maxItems: 2
>> -    description:
>> -      Qualcomm TSENS (thermal sensor device) on some devices can
>> -      be part of GCC and hence the TSENS properties can also be part
>> -      of the GCC/clock-controller node.
>> -      For more details on the TSENS properties please refer
>> -      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> -
>> -  nvmem-cell-names:
>> -    minItems: 1
>>       items:
>> -      - const: calib
>> -      - const: calib_backup
> 
> I see the removal of tsens properties, but I do not see the other part
> of split - adding them as child. It does not come from qcom,gcc.yaml,
> either.
> 
>> -
>> -  '#thermal-sensor-cells':
>> -    const: 1
>> +      - enum:
>> +          - qcom,gcc-apq8064
>> +          - qcom,gcc-msm8060
>> +      - const: syscon
>>   
>>   required:
>>     - compatible
>> -  - nvmem-cells
>> -  - nvmem-cell-names
>> -  - '#thermal-sensor-cells'
>>   
>>   unevaluatedProperties: false
>>   
>>   examples:
>>     - |
>>       clock-controller@900000 {
>> -      compatible = "qcom,gcc-apq8064";
>> +      compatible = "qcom,gcc-apq8064", "syscon";
>>         reg = <0x00900000 0x4000>;
>> -      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>> -      nvmem-cell-names = "calib", "calib_backup";
>>         #clock-cells = <1>;
>>         #reset-cells = <1>;
>>         #power-domain-cells = <1>;
>> -      #thermal-sensor-cells = <1>;
>> +
>> +      thermal-sensor {
>> +        compatible = "qcom,msm8960-tsens";
>> +
>> +        nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>> +        nvmem-cell-names = "calib", "calib_backup";
>> +        interrupts = <0 178 4>;
> 
> 0 and 4 look like GIC/interrupt flags, so please use defines.
> 
>> +        interrupt-names = "uplow";
>> +
>> +        #qcom,sensors = <11>;
>> +        #thermal-sensor-cells = <1>;
>> +        };
> 
> Indentation looks weird here.
> 
>>       };
>>   ...
> 
> 
> Best regards,
> Krzysztof


-- 
With best wishes
Dmitry

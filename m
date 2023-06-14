Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB657308FA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjFNUL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjFNULT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 16:11:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8922107
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 13:11:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso9492918e87.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686773475; x=1689365475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POY0ce7wWbwfbzD7JE6CSS9GHiPnt327xrkIS29uLi8=;
        b=jORvPwymCYV5GjMtAC9SjTWv11dPTRLUEfaKnWn9iU5Ynaz2mF3qkCf769+oBfRLi9
         OVht5oqqxk+k++5MKfqyIaS4R1shrZr3fCkCdnSZUMxmthUyj6GziH1FFr/oGcdE0Tyz
         +15D77IhxIp1cFW0wNWB9c1b6zAhl1/Mi8FrNTKafl2XwRYf+lcjc2ihqdkdF9ZkAl7r
         xTcvuvvS1sQ4K0paPJnkDURGLDUvW7ZLLcuRpJ8W3B8DhVGx15e9UBr7LphGeUd60XFT
         IdcvYV7/tzrU1ge3B2NrAqrndjgoMmCtBL7xUhLNZ/TryRzfhzVQ08vFta0KNym10Aiz
         Zn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686773475; x=1689365475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POY0ce7wWbwfbzD7JE6CSS9GHiPnt327xrkIS29uLi8=;
        b=fIbz0LXCOZlxQAIqGUtgkv3gZEISc6Zry1Efu2Fh6q1Qq7YyI01N41lcgwCF4T70ZV
         jfzeHfWgRXOSF81shRm1Ew24Vitx9gpu61Ur0jgAGquuSS46Ev3rhoFmlxcEmAGFK6Et
         5TwmW8cV5tu9t46eC4uGcKifksnqocikOxbaJ/Yw8kX7Mj244hU5Ppof3LCQvWZywr8r
         EZx9w1vN1DDxUHLBMfe+VdGC+WtvEwcTqkzGYZxS+vTZIRHi02x/P7+bJ2j9jnLvd4K9
         LKYs4ZKpZyDftTzRhY2rNs0iSEEdthROLszneYiBKrqWw2728cPwKLAyZ2LAeJEP3Wsz
         7PJg==
X-Gm-Message-State: AC+VfDy3qFCSKCxWd/p+h9+CsSNXxBuH3heCyG5yvq8t4QS7IEDbk3OD
        QRbGVX5CEFRVz5eTYOFqfxbqvw==
X-Google-Smtp-Source: ACHHUZ7lux0NZKiXoqw6xpxgceYsRJYfelW/Q3xaVMgdjmssULE780vQO2/2t2SlpUASJd7IHLBtCw==
X-Received: by 2002:a19:e345:0:b0:4f4:c973:c97d with SMTP id c5-20020a19e345000000b004f4c973c97dmr8552770lfk.25.1686773475433;
        Wed, 14 Jun 2023 13:11:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm76844lfc.259.2023.06.14.13.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 13:11:14 -0700 (PDT)
Message-ID: <678a3750-0a89-aedf-b5cf-e68da003f4a0@linaro.org>
Date:   Wed, 14 Jun 2023 23:11:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/18] dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm
 Krait SoCs
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-2-dmitry.baryshkov@linaro.org>
 <5c750c6a-a0f8-c6f7-64fe-716da434d819@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5c750c6a-a0f8-c6f7-64fe-716da434d819@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/06/2023 19:01, Krzysztof Kozlowski wrote:
> On 12/06/2023 07:39, Dmitry Baryshkov wrote:
>> Exted the opp-v2-kryo-cpu.yaml to support defining OPP tables for the
>> previous generation of Qualcomm CPUs, 32-bit Krait-based platforms.
>>
>> It makes no sense to use 'operating-points-v2-kryo-cpu' compatibility
>> node for the Krait cores. Add support for the Krait-specific
>> 'operating-points-v2-krait-cpu' compatibility string and the relevant
>> opp-microvolt subclasses properties.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml      | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>> index bbbad31ae4ca..93ec778bf333 100644
>> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>> @@ -26,7 +26,9 @@ description: |
>>   
>>   properties:
>>     compatible:
>> -    const: operating-points-v2-kryo-cpu
>> +    enum:
>> +      - operating-points-v2-krait-cpu
>> +      - operating-points-v2-kryo-cpu
>>   
>>     nvmem-cells:
>>       description: |
>> @@ -63,14 +65,15 @@ patternProperties:
>>             5:  MSM8996SG, speedbin 1
>>             6:  MSM8996SG, speedbin 2
>>             7-31:  unused
>> -        enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
>> -               0x9, 0xd, 0xe, 0xf,
>> -               0x10, 0x20, 0x30, 0x70]
> 
> Why?
> 
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> You are changing the type. No. It should be fixed instead (enum applies
> to items).

Currenlty this bindings are only usable for msm8996/msm8996pro. As such 
we listed opp-supported-hw values that are applicable to this platform. 
This series adds support for apq8064 platform, which will add new items 
to this enum. I think it is not very sensible to list all of them here.

However granted there is already a good enough base type definition, I 
think it would be better to drop the $ref, drop the enum, add ': true' 
(is it necessary if we have a description already?) and expand 
documentation.

> 
>>   
>>         clock-latency-ns: true
>>   
>>         required-opps: true
>>   
>> +    patternProperties:
>> +      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$': true
> 
> I don't think it is a common property, so it needs description and
> specific type. Specifically "pvs[0-9]" something entirely new.

Ack.

> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry


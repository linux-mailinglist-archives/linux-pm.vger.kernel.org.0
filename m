Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503A737EA7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjFUIqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjFUIqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 04:46:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A0C1726
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 01:46:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-988689a5f44so420947866b.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687337182; x=1689929182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GflvE0roPSdSbGvWDUkng37TEfI0UgvNgk9OrUiAXgg=;
        b=IcHaWSJyViXSUhu1kU4YbjkKQo3cyhjXO5TxFn0/x7bspgST9bG6wmFihhp5GiFDqy
         zU2zIg6geWOCZTVRuKjUYZmL7nIBDA99twkxsf75TNvnRNeaVKxkGAkzde5k0oUP8gjf
         VFjjWkeCnqYI4Lbit6xZLnpsqHoiGSyvsLCxdYN8OlFn5f3zdTI+tp6WdhPHh8ep15Om
         xxid5A/zoJJN0gaBlQ4oC8fmSwBK57dT0lK2wN1+gi6SYueIIakDyzrH5ts525fUpkab
         W+M40bpnB/9Yf7oVfi8WWAw3/4h04UMIZCl+pq+nj/AvqmX+8Q6d6L/RD0FiyGi0qfqo
         bWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337182; x=1689929182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GflvE0roPSdSbGvWDUkng37TEfI0UgvNgk9OrUiAXgg=;
        b=VrrGpQl1XwFP2YI7775YTSAmuF3vCFD+94eq1DyLhbnlLndAD7QppZb+xW9B5scNlD
         hZzouxRDwp1VZF7DSPV9mywNA4uQ1Is+3VS6CfMgagRVew4RWDhNGHWP7gY+0B705zXY
         /sG9VF+qUZjrEPi+8dJNYguaADLRh+DM3ZfKlLLxfo0AzK4A+lKF5IzNTOLBmP5SU2hd
         jpcwCA9FbcDGepR1NdNrHPAZnGanKAUZ4YouXF9PHpdKbhbCPILqlQyHmEi6rzLVK7Pm
         WZt69LAnJmQwcdiBDjwESlsrP99ENQSbT2L5gNW+H9Elgmijp8aW1pb+YqPdKRHYuGt5
         sihQ==
X-Gm-Message-State: AC+VfDxiIeahkEazDWSCJUXCkl7D/ujnqYjM/QcecDhb/gBqvAP/r5Dp
        hvhbKKGtshCuyTXG/DUvmMDxnQ==
X-Google-Smtp-Source: ACHHUZ75Ib9mgET+SuFnggOlzImf1yD7bISLiyp7cqP7i+51zkAOt08tWIrxe5qkk/VpAcGrKE4n+Q==
X-Received: by 2002:a17:907:1c07:b0:982:84c9:96bd with SMTP id nc7-20020a1709071c0700b0098284c996bdmr15416351ejc.76.1687337182265;
        Wed, 21 Jun 2023 01:46:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id la18-20020a170906ad9200b009888f0bbd38sm2702486ejb.169.2023.06.21.01.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:46:21 -0700 (PDT)
Message-ID: <c487c05e-f6b9-1dbd-065b-19aca19d130d@linaro.org>
Date:   Wed, 21 Jun 2023 10:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/18] dt-bindings: soc: qcom: qcom,saw2: define optional
 regulator node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <20230612053922.3284394-4-dmitry.baryshkov@linaro.org>
 <e48f6153-0485-9fb9-5fe0-145251a8b367@linaro.org>
 <e70520a9-6c97-07b3-326a-6fa80aad0d6a@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e70520a9-6c97-07b3-326a-6fa80aad0d6a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/06/2023 00:49, Dmitry Baryshkov wrote:
> On 14/06/2023 19:05, Krzysztof Kozlowski wrote:
>> On 12/06/2023 07:39, Dmitry Baryshkov wrote:
>>> The SAW2 device can optionally provide a voltage regulator supplying the
>>> CPU core, cluster or L2 cache. Describe it in the device bindings.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   .../devicetree/bindings/soc/qcom/qcom,saw2.yaml | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
>>> index a016242367b9..b809a9cc0916 100644
>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
>>> @@ -47,6 +47,10 @@ properties:
>>>         - description: Base address and size of the alias register region
>>>       minItems: 1
>>>   
>>> +  regulator:
>>> +    $ref: /schemas/regulator/regulator.yaml#
>>
>> There was such property in the binding (and DTS!) but a bool. Previous
>> patch silently dropped it, so re-introducing it with different type is
>> confusing.
> 
> Could you please propose a better name here? saw-regulator? Or maybe 
> regulator-saw? (as we might get regulator-avs at some point).

regulator name is OK for me, but any ABI change should be:
1. Clearly expressed with rationale,
2. Done probably in one DT commit, not two. IOW, first silently dropping
a property and then adding a new one like nothing happened is not good.
It should be clear that old property is wrong because foo bar and we
make it now different with breaking all the DTS because foo bar.

Best regards,
Krzysztof


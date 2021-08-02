Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849D63DE1AA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 23:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhHBV3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhHBV33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 17:29:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120DC0613D5
        for <linux-pm@vger.kernel.org>; Mon,  2 Aug 2021 14:29:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t66so18117995qkb.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Aug 2021 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O8azjKnReE8xSiyBnxqqAL7gBgZx+sYiW82Vr3OzBV8=;
        b=PKuK8Piq9Ojx7NxEt0nf3Jyi6/3cagHknsWKBHPrVPRE4fo26WU+Ef3jH9aQGjXcj8
         F2ykxPWMlnNJAjw/VY5VZz91VqvP9eUsO6wJclFzUhTUn8Pm6jOPhFcFG0WOOuof5V2V
         UtdwayiIf/60an0ukFs3hYkuj/3kJah6OsmSLw7s59SLacTaRsgdlw4UCNnT0Dx59W6N
         SJ/dO1E0G4Q4FTP8kKfK9rQjJJlnMBP6ZprjtNtwajJ9VThhtcpz7+CDtxOxuK1fmfAe
         hoV1hJdX+0SkXPxbwUg3riofycSCk24EqVFcR9FVX6R5kY/KpJv1MPR6OoLPGfm1SjYB
         wm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8azjKnReE8xSiyBnxqqAL7gBgZx+sYiW82Vr3OzBV8=;
        b=FX49UEZwRaKD0qjiM1SaQBjvb8C9w4Q0YhraWh6QJQhr5LdbT/gNjklFjJsZarDVS1
         aOfbCKAPGGvzFGWjTnnTk+mPFD1UKrebk320ndo1wgQno6lfozaCEEb64p3T2Gmod9VQ
         yNKxKLMi0mj4VLM2znah2eKHbHrzXEfNCSXCrTxvA7rZjimWqehn6u5Ylu5GBTQqkojL
         I1DsbwWmRBfvixHBK8sPAiTe6UbMHFe40ssJ/mKV6YEMHhgzYBFfuFAj4DavDM5sqp6V
         ofv4oWJy33EMqGQyNVbIb1bWajT/CHcJ3FQyU052dBNo5WRDpBf1wgw4Q2YsKKrPIj29
         QA/A==
X-Gm-Message-State: AOAM530v3TDD0d3JkKcsl9WTHmHGQ8eNlTu/GRJHnVlfFNVKphQjLEwq
        KhUfhN3IEVn/ag9WbCabkOZudg==
X-Google-Smtp-Source: ABdhPJynegevwH2ssks++pWFk1eGBNRCiO6YfoYhu6pvqCNq34yM9jyAcp26PMtDxLHBdd6OgLYxkA==
X-Received: by 2002:a05:620a:248d:: with SMTP id i13mr17622100qkn.106.1627939757950;
        Mon, 02 Aug 2021 14:29:17 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id c3sm6689675qkd.12.2021.08.02.14.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 14:29:17 -0700 (PDT)
Subject: Re: [Patch v4 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
 <20210727152512.1098329-7-thara.gopinath@linaro.org>
 <20210728161000.GA1153621@robh.at.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2fd4d897-4eb0-e841-f0fa-2650e1aad832@linaro.org>
Date:   Mon, 2 Aug 2021 17:29:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728161000.GA1153621@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Thanks for the reviews.

On 7/28/21 12:10 PM, Rob Herring wrote:
> On Tue, Jul 27, 2021 at 11:25:12AM -0400, Thara Gopinath wrote:
>> Add dt binding documentation to describe Qualcomm
>> Limits Management Hardware node.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v3->v4:
>> 	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
>> 	  a phandle pointing to the cpu node instead of a number as per
>> 	  Rob Herring's review comments.
>> 	- Added suffix -millicelsius to all temperature properties as per
>> 	  Rob Herring's review comments.
>> 	- Dropped unnecessary #includes in the example as pointed out by Bjorn.
>> 	- Other minor fixes.
>>
>>   .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
>> new file mode 100644
>> index 000000000000..0978f458b9ec
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
>> @@ -0,0 +1,100 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright 2021 Linaro Ltd.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/qcom-lmh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Limits Management Hardware(LMh)
>> +
>> +maintainers:
>> +  - Thara Gopinath <thara.gopinath@linaro.org>
>> +
>> +description:
>> +  Limits Management Hardware(LMh) is a hardware infrastructure on some
>> +  Qualcomm SoCs that can enforce temperature and current limits as
>> +  programmed by software for certain IPs like CPU.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sdm845-lmh
>> +
>> +  reg:
>> +    items:
>> +      - description: core registers
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  '#interrupt-cells':
>> +    const: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  qcom,lmh-cpu:
>> +    description:
>> +      phandle of the first cpu in the LMh cluster
>> +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> 'cpus' property is the somewhat standard way to reference a cpu.

So are you suggesting renaming qcom,lmh-cpu to cpus ? I need the cpu-id 
here to identify the LMh cluster. Depending on the LMh cluster, I have 
different node ids which is a parameter in the LMh smc call.

> 
> But you should already have cpu topology information, why do you need
> this?
> 
>> +
>> +  qcom,lmh-temp-arm-millicelsius:
>> +    description:
>> +      An integer expressing temperature threshold at which the LMh thermal
>> +      FSM is engaged.
>> +    $ref: /schemas/types.yaml#/definitions/int32
> 
> Standard unit-suffixes already have a type.

yep.. I will remove this

> 
>> +
>> +  qcom,lmh-temp-low-millicelsius:
>> +    description:
>> +      An integer expressing temperature threshold at which the state machine
>> +      will attempt to remove frequency throttling.
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +
>> +  qcom,lmh-temp-high-millicelsius:
>> +    description:
>> +      An integer expressing temperature threshold at which the state machine
>> +      will attempt to throttle the frequency.
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - #interrupt-cells
>> +  - interrupt-controller
>> +  - qcom,lmh-cpu
>> +  - qcom,lmh-temp-arm-millicelsius
>> +  - qcom,lmh-temp-low-millicelsius
>> +  - qcom,lmh-temp-high-millicelsius
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    lmh_cluster1: lmh@17d70800 {
> 
> Drop unused labels.

sure.

> 
>> +      compatible = "qcom,sdm845-lmh";
>> +      reg = <0x17d70800 0x401>;
> 
> 0x401 is an odd size...

I double checked the spec and this is the size. But also there is no 
register specified around this address. So I will make the size to 0x400 
so that it looks sane.


> 
>> +      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +      qcom,lmh-cpu = <&CPU4>;
>> +      qcom,lmh-temp-arm-millicelsius = <65000>;
>> +      qcom,lmh-temp-low-millicelsius = <94500>;
>> +      qcom,lmh-temp-high-millicelsius = <95000>;
>> +      interrupt-controller;
>> +      #interrupt-cells = <1>;
>> +    };
>> +  - |
> 
> Seems like this is 1 example, not 2.

Will fix it.

> 
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    lmh_cluster0: lmh@17d78800 {
>> +      compatible = "qcom,sdm845-lmh";
>> +      reg = <0x17d78800 0x401>;
>> +      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +      qcom,lmh-cpu = <&CPU0>;
>> +      qcom,lmh-temp-arm-millicelsius = <65000>;
>> +      qcom,lmh-temp-low-millicelsius = <94500>;
>> +      qcom,lmh-temp-high-millicelsius = <95000>;
>> +      interrupt-controller;
>> +      #interrupt-cells = <1>;
>> +    };
>> +  - |
>> -- 
>> 2.25.1
>>
>>

-- 
Warm Regards
Thara (She/Her/Hers)

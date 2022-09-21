Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371C55BFB08
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIUJbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiIUJbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:31:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBE86897
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:31:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j16so8227712lfg.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aBTuL9SjMu+niu2bgdDeMZqV/Q884/XIIR11SbrmcQ4=;
        b=ypNgFnyB98NxXieqEzulnH4MfVyFFiIn3iDSAj0gBR5UyA11Vmvv8nW7NgXLonPMEL
         qTX7aD4L9czChoOwt0XfmZ5MKwx8gj2VMqXzpUZ8L+B5c5DBXgC+0TMbCYcPy9EoSTbj
         OCfzvyYOZeZyw1qQCM84Xldfe9Ma/jyZdlPQrI9ivnS/mubY4wwdAIHLbVy4YbSVI6kF
         nX5irG3S1Ozq+n7MmGKvCuIw7DYNuiHK/ny3ovicLZRrIpFcGx8gN7upUST6mOrzTpkD
         pVA/gVzM9BrhfW2vxLxavO6spXiXCdjCYsrgiz4z9oLYYSXjwausooUChbgN6GSOO+EJ
         E/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aBTuL9SjMu+niu2bgdDeMZqV/Q884/XIIR11SbrmcQ4=;
        b=tRHsnv6yYrrtrG8qL6c142D3QQE3/rAFjAxykKI2rvqV9fO0115KmCTi993384IZoM
         0egtxEV49Ep8oUU8nGYWYazn1UdkH4vv4Clw5G20frZqGHOC7DqAa2CUSRFGdfDwZM1T
         NZFDVJffoLY0wa9yWtxGHsDyOpNHfcntfmzm3V2TxLVxY+vP6h6DGqmYXzrSai6mOoAj
         5t27H+S7qdAK5Acdr+cauZaG6LSwhhBIeO3p41IzkXVwEhBT6Vmgj9OVd+0zVpS6t84o
         CIru5Z58yj4K7rIqNPpgzkBOQYYRey9dgdJfnsvYey7SZBCzm2pRWvH4TIYh4UaKAHZr
         vUww==
X-Gm-Message-State: ACrzQf1vE6KzaDzAJck4RstO7Eat6s9NKAl9iMGtnOi2ljfr3VYcUkU0
        TngSqXGUllmKwyP76s7cI3CfkIdp2Qt0wQ==
X-Google-Smtp-Source: AMsMyM7imla2gyivn1Wxj+LUHqHrRTuV07wXEB/2fzo8MW/2iGvfoBHnCr/SNRGCBHvuUeSU4SLtVw==
X-Received: by 2002:a05:6512:3502:b0:496:8e:9307 with SMTP id h2-20020a056512350200b00496008e9307mr9256516lfs.504.1663752673275;
        Wed, 21 Sep 2022 02:31:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d19-20020ac24c93000000b00497ab34bf5asm361815lfl.20.2022.09.21.02.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:31:12 -0700 (PDT)
Message-ID: <a44244f2-fb96-0483-b529-d0f2b0b7e5d8@linaro.org>
Date:   Wed, 21 Sep 2022 11:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
Content-Language: en-US
To:     =?UTF-8?B?5pyx6ZO25rOi?= <zhuyinbo@loongson.cn>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
 <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
 <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2022 11:22, 朱银波 wrote:
>> -----原始邮件-----
>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> 发送时间:2022-09-21 15:05:00 (星期三)
>> 收件人: "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>> 抄送: zhanghongchen <zhanghongchen@loongson.cn>
>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>
>> On 21/09/2022 03:56, Yinbo Zhu wrote:
>>> Convert the loongson2 thermal binding to DT schema format using
>>> json-schema.
>>
>> Incorrect subject and incorrect commit msg. There is no conversion here.
> Our soc architecture is the loongson2 series, so we will modify it accordingly.

How the soc architecture is related to my comment that you do not
perform conversion?

> 
>>
>>>
>>> Signed-off-by: Yinbo Zhu <c>
>>> ---
>>> Change in v2:
>>> 		1. Add description and type about the "id".	
>>> 		2. Make the filename was based on compatible.
>>>
>>>  .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
>>>  1 file changed, 52 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>> new file mode 100644
>>> index 000000000000..2994ae3a56aa
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>
>>
>> No improvements here. You ignore my comments, so I am going to NAK it.
> I don't get your point, that dts compatible is "loongson,loongson2-thermal", so this driver file name is named
> loongson2-thermal that according what you said about "Filename based on compatible."
> If what I understand is not what you expect, please tell me how to modify it.


Filename must match the compatible, so: loongson,loongson2-thermal.yaml

>>
>>
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Thermal sensors on loongson2 SoCs
>>> +
>>> +maintainers:
>>> +  - zhanghongchen <zhanghongchen@loongson.cn>
>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: loongson,loongson2-thermal
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  id:
>>> +    $ref: '//schemas/types.yaml#/definitions/uint32'
>>
>> No improvements here, so let me be specific - you need to really justify
>> such property or it cannot go to schema.
> The loongson2_thermal.c driver need parse this "id" property.

This is not reason to add properties to DT. DT describes the hardware,
not driver behavior.

Why hardware needs arbitrary, additional addressing number instead of
standard unit address?

>>
>>> +    description: |
>>> +      Specify the thermal sensor id.
>>> +    minimum: 0
>>> +    maximum: 3
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  "#thermal-sensor-cells":
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - id
>>> +  - interrupt-parent
>>
>> Why?
> The interrupts of our dts do not specify an interrupt parent,
> eg. interrupts = <7 IRQ_TYPE_LEVEL_LOW>
> so we need to add an interrupt parent property.

You can add but I am asking why is it required?

>>
>>> +  - interrupts
>>> +  - '#thermal-sensor-cells'
>>
>> Use the same style of quote: ' or ".
> okay, I will have a change.
>>
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    thermal: thermal@1fe01500 {
>>
>> How other similar nodes are named (in other DTS files)?
> I refer qoriq platform,
>     tmu@f0000 {
>         compatible = "fsl,qoriq-tmu";
> 
>  You mean to modify it like this
> - thermal: thermal@1fe01500 {
> + thermal@1fe01500 {
> 

No, just thermal-sensor@1fe01500


Best regards,
Krzysztof


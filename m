Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BE46168DE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiKBQah (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiKBQaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 12:30:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755B175AE
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 09:26:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1650750wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zv7Fq5k50QWQLxnPbss2vXizhHRaHgo0CLWyEMOtNXY=;
        b=XLT+2bOf52xM6JdQqN+Tbi3UN/LLLCaptLMtL5KvSTYPvI/lUr4ONN2+m47aatNmUE
         rdrtReOAY4RmLpenQiqcMEofRRUhxktec1oIjlF4j6H6wmkxi5XEDnpOZ9QGJaSBxv+F
         LhWZTjMyJ0KzHsT2tice4ZplDy8smvhGjPpxQ+xekviGu2gOZfr+P+dYshaOnkeqsqVi
         uLKwI/Sm12ueV22i0iRvO64/ABCyk4cZb6c2neFCEhma60LYtaOmfJBEUoWMY7xkEKJ/
         WLGsayqA2AIVW/hhoObdJU0oqJ/+fBkdyyFvsfYKhIOtXxaDfx5ozca5oUxePLiG0MUO
         U5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv7Fq5k50QWQLxnPbss2vXizhHRaHgo0CLWyEMOtNXY=;
        b=Ik/sVE8ZgIb5L+DRUHhisO4WuJTIS2RMsQ5kg/x99l+9NcsXz/DyUA9vbFnoMYBkIo
         GC9+fTOSmv158FFZcYIPdxCqr6/qWGqV2q18YqIhRxNUBm871yuClqNoc2gh/YQmPlJu
         tPEEq7l2so16vte53MGseClqUYt3Pby6ACJZIRy4bXeniRzPHq7hLS8dWy1Ml69VHJNy
         IGHSfY5/QwPrAzL4yz/9/u5oOj3NhDNRJpa6FPVNU32KKqX19CILLyO7v7+dRuy08JgT
         JKywF1XFKk5q1tOOe4tGh1SXtJ7FO+qrgTScnINXG5uX+AgoujQIKPyVaRXjkfnA5DJv
         9ZnQ==
X-Gm-Message-State: ACrzQf2acs9+lJ/dxqDa12DEnZnjQw77h9h6sI0QHPkhzNTrA2+c2Khv
        fwN9bIHq1AwnM9EhBclwaSPBkQ==
X-Google-Smtp-Source: AMsMyM58DL/hkAn4DnGcSmAn4Lnobs2eqhlbRBLy1/I33qod5riKNI2cBWPxvRt82gxskj2IR0PZIw==
X-Received: by 2002:a05:600c:4ed1:b0:3cf:86ab:3a0f with SMTP id g17-20020a05600c4ed100b003cf86ab3a0fmr2853053wmq.106.1667406377451;
        Wed, 02 Nov 2022 09:26:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3541:e8cb:4c8c:e204? ([2a01:e0a:982:cbb0:3541:e8cb:4c8c:e204])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003c70191f267sm2844571wmn.39.2022.11.02.09.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:26:17 -0700 (PDT)
Message-ID: <f7f0ced5-d8b8-08cb-e354-780dc69a68cd@linaro.org>
Date:   Wed, 2 Nov 2022 17:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: document Odroid Go Ultra
 power-off
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
 <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
 <20221102162344.GA3993882-robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20221102162344.GA3993882-robh@kernel.org>
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

Hi,

On 02/11/2022 17:23, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 05:47:25PM +0100, Neil Armstrong wrote:
>> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
>> to its two PMICs in order, this represents the poweroff scheme needed to complet
>> a clean poeroff of the system.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../reset/hardkernel,odroid-go-ultra-poweroff.yaml | 42 ++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml
>> new file mode 100644
>> index 000000000000..65e42258717c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hardkernel Odroid Go Ultra poweroff
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +description:
>> +  The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
>> +  to its two PMICs in order, this represents the poweroff scheme needed to complete
>> +  a clean poeroff of the system.
> 
> You don't really need a node for this. Test against the top level
> compatible and then find the PMIC nodes by their compatible strings.

Hmm ok, indeed would be simpler.

Neil

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: hardkernel,odroid-go-ultra-poweroff
>> +
>> +  hardkernel,rk817-pmic:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the RK817 PMIC node
>> +
>> +  hardkernel,rk818-pmic:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the RK818 PMIC node
>> +
>> +required:
>> +  - compatible
>> +  - hardkernel,rk817-pmic
>> +  - hardkernel,rk818-pmic
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    poweroff {
>> +        compatible = "hardkernel,odroid-go-ultra-poweroff";
>> +        hardkernel,rk817-pmic = <&rk817>;
>> +        hardkernel,rk818-pmic = <&rk818>;
>> +    };
>>
>> -- 
>> b4 0.10.1
>>


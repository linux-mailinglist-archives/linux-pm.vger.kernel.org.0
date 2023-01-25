Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38C67AABB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 08:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjAYHQJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 02:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjAYHQI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 02:16:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AB38025
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 23:16:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b7so16080798wrt.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 23:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqVnz5dHE+H8EBqWuT4m2bnfmcW1edtMXQTUn/uHibA=;
        b=iI1Q+Ner3x7gfdxiAzK3mur3wDEWCKn9dxfIlWuEpFSxsQzxWuRG7X2pLeQN1I5xel
         +/v3dUdnrUtxdcuwqtWLOkUW+eJngWmIT+MPRIQXRgW175yJpTmLSxcFB0w7vsu7ZRG6
         5KWHHkNWIilYMfDYT4uI/vwyF3PIBy/TuwDWygtGcvDeeaDbaOZU09haKxYnGMYAGkn3
         c5FIebWU0ol3EqoHLIYnxGUiaxfdB2ltNWnOxNiia87ULZoB9CL5bp+F1isWrpWsfGLO
         FZbcb2brECcbs+PkKYu6x+NgahwJrTM0Bux310+vKUbOiZGSFuj7v5f1d0IaU4Ane4lx
         JJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqVnz5dHE+H8EBqWuT4m2bnfmcW1edtMXQTUn/uHibA=;
        b=Ijmyrq/0kO/eqmmVhIDRFV7bQ9a0riXm4DQwFeevzxMEjvsOfGvE8yPdhuhyC3fMOt
         YHx7BfEZso2TlmhBUjve18507kyqS/FtMKuHJUBNz2eGMKLRoYAdj9NNN5V62Uz5OzSC
         tua2O0HUhScCbSJFFxIrPxdCDcH/OCP1NxUvuXpb5m/l+gwqZtcWKxU9ZP4IVl6pzApm
         D2CxBIhJE7DTw3UNi7R8ByA8vVC7BE2jExwkKdtgOz2KSAwXlwRZVv6VehWSDd79vN/I
         K5qRc25uvadxtR1H/x7rENU0gyySR5IkAUQO4YCExg1kUYIoFMTc1lszWsYrLtqaYlpu
         T1Ag==
X-Gm-Message-State: AFqh2krWOVBHDSjiui9465WQuU4gAMRHQTw/2sJZIMzg4UglMPtA5PkO
        JD4oXx85Ra337l+gmci3Zn2gdw==
X-Google-Smtp-Source: AMrXdXsQTc3tcSZ5O/Y+CPqj3BvK3F17J/9RhcE/qU182Xl1ciIA3AMHZDscUVB9vIS8xkIVoWcA6Q==
X-Received: by 2002:a05:6000:1816:b0:2bd:fe5a:b579 with SMTP id m22-20020a056000181600b002bdfe5ab579mr24770799wrh.70.1674630961690;
        Tue, 24 Jan 2023 23:16:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d4906000000b002bc6c180738sm4135881wrq.90.2023.01.24.23.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:16:01 -0800 (PST)
Message-ID: <c1e206f2-7e86-a7ad-c6fa-c80cc1c3f77d@linaro.org>
Date:   Wed, 25 Jan 2023 08:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-6-bryan.odonoghue@linaro.org>
 <e80b98bc-54e8-f7ab-b9a9-dd888108a0cd@linaro.org>
 <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
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

On 25/01/2023 02:21, Bryan O'Donoghue wrote:
> On 23/01/2023 16:29, Krzysztof Kozlowski wrote:
>> On 23/01/2023 03:31, Bryan O'Donoghue wrote:
>>> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
>>> chipset.
>>>
>>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>> Co-developed-by: Jun Nie <jun.nie@linaro.org>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> Co-developed-by: Benjamin Li <benl@squareup.com>
>>> Signed-off-by: Benjamin Li <benl@squareup.com>
>>> Co-developed-by: James Willcox <jwillcox@squareup.com>
>>> Signed-off-by: James Willcox <jwillcox@squareup.com>
>>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> Co-developed-by: Joseph Gates <jgates@squareup.com>
>>> Signed-off-by: Joseph Gates <jgates@squareup.com>
>>> Co-developed-by: Max Chen <mchen@squareup.com>
>>> Signed-off-by: Max Chen <mchen@squareup.com>
>>> Co-developed-by: Zac Crosby <zac@squareup.com>
>>> Signed-off-by: Zac Crosby <zac@squareup.com>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>>   arch/arm64/boot/dts/qcom/apq8039-t2.dts | 545 ++++++++++++++++++++++++
>>>   2 files changed, 546 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index b0423ca3e79fd..73ff8d3213d99 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -1,5 +1,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>> new file mode 100644
>>> index 0000000000000..734b4d6054132
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>> @@ -0,0 +1,545 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2020-2023, Linaro Ltd.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8939.dtsi"
>>> +#include "msm8939-pm8916.dtsi"
>>> +#include <dt-bindings/arm/qcom,ids.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>> +#include <dt-bindings/sound/apq8016-lpass.h>
>>> +
>>> +/ {
>>> +	model = "Square, Inc. T2 Devkit";
>>> +	compatible = "square,apq8039-t2", "qcom,msm8939";
>>
>> There is no square vendor prefix.
> 
> commit d3e2262cd0d1105bb3a71012693876d01e8de203
> Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Date:   Tue Jan 17 02:48:39 2023 +0000
> 
>      dt-bindings: arm: qcom: Document MSM8939 SoC binding
> 
> +      - items:
> +          - enum:
> +              - sony,kanuti-tulip
> +              - square,apq8039-t2
> +          - const: qcom,msm8939

This is board compatible. You still missing vendor prefix in
vendor-prefixes.

Best regards,
Krzysztof


Return-Path: <linux-pm+bounces-829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A796809D9D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 08:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EA61F20EEB
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148563AF;
	Fri,  8 Dec 2023 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gx8dOrbl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D661720
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 23:55:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c317723a8so7258485e9.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 23:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702022144; x=1702626944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHm62M5jwRi7iYi7IHAISb40o03/KQfYK7QFQL572kA=;
        b=gx8dOrblD7VTDayrZPyl8kqge4JP9Uc0CcyrNLnriKaIqQVIqYhTool6xKxipnSMmB
         ccJIi7+/8cP2i/0GhZz2vnUcI7drNdaI0o6YWLaUmYA60fkat31f0Wks/ZqpncHRm7It
         3Avx9Uhos3/snUp8cxEf/rkeE9lE3LHrOxd6NKR709fJjlsgEfM5TtkoVLhAgcDc/i+q
         tB4cTRFrg6eXXXxAb01Ay8mfuGnib75S4lzxWQ8vM6fjqxhRww3mRAfbOUPRV3CBf918
         CZO543ka5IyUAq8/C5ou9szrMHP7KsQZL5EkFBLyjxlwRuPv31XG9ILF0W982UgRnW7/
         8acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702022144; x=1702626944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHm62M5jwRi7iYi7IHAISb40o03/KQfYK7QFQL572kA=;
        b=M48Ped0iHAQNRO8C4bxAdv8qRK2SeKB85tz3cQCcJbEyNH+D9V3Acnf9WrM+YUKjt8
         oOpi5eBnKe3ljUUQHj9kOYb3nS7lf9CL4XoiCA85B19wNNqDsZIrB5eEMHMMGHjQF7AN
         0/Cj0tJcOtRUvB82ACk12DNXajgCyJDcy7clm9NQnk946PU1aaTgNBk40ICKvtNPlvEv
         dMxQXyDY6AeWtMrpootThmZj/LuKFSWOlxEkd/DYVzbpt3EOcaQT6F0Q/j01jBQeeiWM
         +fIYhXpD0vj7wojf6puIPS9x2VwHvwdiwxcGr7nyJq+FhFzMDtQkVbf441HO74vLb25c
         B6rA==
X-Gm-Message-State: AOJu0YxDukj99/E8BGfG7p28a3tcoYa/SJiCJ3+PYrypo1iGVAOsAvlq
	6uvoWawG0jroKZL67G/iJybfWQ==
X-Google-Smtp-Source: AGHT+IGifDXkEn0OeTASRJ3qAeneLdfWlqJjxkOxATBQnYLCawzcT498tM5YBxDS8Aomow8q1jOYdA==
X-Received: by 2002:a05:600c:1e16:b0:40c:2082:a38f with SMTP id ay22-20020a05600c1e1600b0040c2082a38fmr2182773wmb.14.1702022144112;
        Thu, 07 Dec 2023 23:55:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id az23-20020a05600c601700b0040c0902dc22sm2033038wmb.31.2023.12.07.23.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 23:55:43 -0800 (PST)
Message-ID: <11ec89a8-5fdd-456c-b070-988bbf8f312d@linaro.org>
Date: Fri, 8 Dec 2023 08:55:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Steve Twiss <stwiss.opensource@diasemi.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <20231206155740.5278-9-biju.das.jz@bp.renesas.com>
 <114c9baf-66d1-4055-a47c-916642b6dedd@linaro.org>
 <TYCPR01MB11269C774B8FFE9E43455EB61868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYCPR01MB11269C774B8FFE9E43455EB61868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2023 18:03, Biju Das wrote:

Trim the quote from irrelevant context, especially if your email client
malforms replies... (because it does)

>>> @@ -35,6 +42,19 @@ properties:
>>>    "#interrupt-cells":
>>>      const: 2
>>>
>>> +  gpio:
>>
>> Old binding did not have such node and nothing in commit msg explained
>> changes from pure conversion.
> 
> OK will update the commit message. Check patch complained about undocumented compatible.
> 
>>
>>> +    type: object
>>> +    $ref: /schemas/gpio/gpio.yaml#
>>
>> ?!? Why? First: It's always selected. Second, so you have two gpio
>> controllers? And original binding had 0? Why this is not explained at all?
>> Open the binding and look at its properties.
> 
> 
> I have referred[1] and [2] to add gpio controller property. 
> 
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi?h=next-20231207#n95
> 
> [2]
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mfd/da9062.txt?h=next-20231207#n38

But does it make sense? Don't just blindly copy things, but actually
investigate whether this is correct DTS.

> 
>>
>>
>>> +    unevaluatedProperties: false
>>> +    properties:
>>> +      compatible:
>>> +        const: dlg,da9062-gpio
>>> +
>>> +  gpio-controller: true
>>
>> And here is the second gpio-controller...
> 
> So you mean it is redundant as $ref: /schemas/gpio/gpio.yaml
> has already defined gpio-controller for this object??

I meant this would mean you have two GPIO controllers. Why one device
would have two GPIO controllers? Please answer to this in commit msg, so
there will be no questions/concerns. You have entire commit msg to
explain all weird and unexpected things with this binding.

...

>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      pmic@58 {
>>> +        compatible = "dlg,da9062";
>>> +        reg = <0x58>;
>>> +        #interrupt-cells = <2>;
>>> +        interrupt-parent = <&gpio1>;
>>> +        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>>> +        interrupt-controller;
>>> +
>>> +        gpio {
>>> +          compatible = "dlg,da9062-gpio";
>>> +          status = "disabled";
>>
>> Why?

Why disabling? Drop all statuses from all your binding examples.

>> Where are gpio-controller and cells? For this node and for parent? Why
>> this example is incomplete?
> 
> I have used a real example [1] here.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi?h=next-20231207#n95
> 
> Currently I don't see any driver is using this compatible other than MFD.

Open the MFD so you will see it...


Best regards,
Krzysztof



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530AD78FC93
	for <lists+linux-pm@lfdr.de>; Fri,  1 Sep 2023 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbjIALpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Sep 2023 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349281AbjIALpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2023 07:45:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B191724
        for <linux-pm@vger.kernel.org>; Fri,  1 Sep 2023 04:44:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso2520807a12.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2023 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693568666; x=1694173466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccQYapkyLHudPKqBjBN4Jee+XKRx/affoccRGde5aC4=;
        b=Azd2jTRcGpqJto14hS1IXNlImHpL5gpfD85s6DufCP44oU4XvWnP/Nkglz78gE6Jl2
         Us/d94rbPUAbyU6wIqYtzpDalP92uOohRipWQtaWrRIlPZd2Hoy5expYkBOIHJy+SRpG
         c7zH/tn0ZE/86okkGDoBja6mfHhIQmRc/HElxouzgZTzvpuJKDYOEMYiBEUqk/h1YijE
         2JHHh5ILx/zuBg/D5mZS51Mk+Ry69vlIvZ3+pb6hsK8/zsejn24UUCW2yNRTfKaKob3z
         dZPkXLpzxJnwPbumJ7BHYkAGDUcmj0qpY91crXCT1O+LveWgN8jzTsTiJL9X092FerPD
         IFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568666; x=1694173466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccQYapkyLHudPKqBjBN4Jee+XKRx/affoccRGde5aC4=;
        b=E0KgHMuHdWKiTzmab2++EfFIY8FPRBYgMLXiEGAXE4UydcVxrnJ2JKE6K1Vc7EmeDK
         XCvC7suboYqtAjr2oIYVmjSQpvKRjF3LjwSqIsa0LNnuYKTIQLVxufbHe84xsnm1DDw6
         xPlYzfqidLwna0/qpndn0CrA/miTG6zSuKkphMrP7JoNn02YxpR4r4HQBsjxoxmHyBL8
         Uxdt3CC3R3Q4IAgi7inqJrWSVbQJoFAqci3fkq0nKgKYR1OkQmc4pXe5KxdjuzvdITpe
         PBEO6nPVNeFx4R03qWGkQ7iwNJCM0WPiE4SZybwzQRazwcT2kVv7tm1MxI3Tm2G4pcL6
         H/Lg==
X-Gm-Message-State: AOJu0Yw7ROK+nX9RqtUdCkZvapg35j42qv8dBAYL9LHOXhjjTYVZyRJT
        sAMLSIXx3c2kuwqAJ1JFNJEN5UaYqTw0ZzERrZU=
X-Google-Smtp-Source: AGHT+IF3f42PZsx9Wukf/yRVc3BWJ32P+eejGXCQuTJM1PrdyFFe4dk1dU4UWk7fw7dwwyBWpvA+RQ==
X-Received: by 2002:aa7:d513:0:b0:52c:164:efe9 with SMTP id y19-20020aa7d513000000b0052c0164efe9mr1648382edq.29.1693568665864;
        Fri, 01 Sep 2023 04:44:25 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d749000000b005257da6be23sm1985731eds.75.2023.09.01.04.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 04:44:25 -0700 (PDT)
Message-ID: <db785937-1a71-7596-aab4-1c698a632211@linaro.org>
Date:   Fri, 1 Sep 2023 13:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 4/5] dt-bindings: soc: loongson,ls2k-pmc: Allow
 syscon-reboot/syscon-poweroff as child
Content-Language: en-US
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
References: <cover.1693474728.git.zhoubinbin@loongson.cn>
 <38e811816c37a2d52374fa04864654ff1e9b4dc8.1693474728.git.zhoubinbin@loongson.cn>
 <cfa55813-946e-7aad-b7a4-54450a1ea5d5@linaro.org>
 <CAMpQs4Jrvd=KAXUBYYdixvvhBx1hAXxECUhGVsuEED1Jp9SPDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMpQs4Jrvd=KAXUBYYdixvvhBx1hAXxECUhGVsuEED1Jp9SPDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/09/2023 11:27, Binbin Zhou wrote:
> Hi Krzysztof:
> 
> 
> On Fri, Sep 1, 2023 at 5:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 31/08/2023 13:43, Binbin Zhou wrote:
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -54,4 +66,18 @@ examples:
>>>          interrupt-parent = <&liointc1>;
>>>          interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>>>          loongson,suspend-address = <0x0 0x1c000500>;
>>> +
>>> +        syscon-reboot {
>>> +            compatible = "syscon-reboot";
>>> +            offset = <0x30>;
>>> +            mask = <0x1>;
>>> +        };
>>> +
>>> +        syscon-poweroff {
>>> +            compatible = "syscon-poweroff";
>>> +            regmap = <&pmc>;
>>
>> ???
> 
> I did notice that commit [1] changed "regmap" to "unrequired" for
> "syscon-reboot", but "syscon-poweroff" did not do the same.
> So, at least under the current "syscon-poweroff" rule, "regmap" is "required".
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml?h=v6.5#n41
> 
> I had my doubts before, but seeing that some dts do have
> "syscon-poweroff" as a separate node, I assumed there was a
> difference.
> 
> commit[1]: 2140d68d69d4 dt-bindings: power: reset: Unrequired regmap
> property in syscon-reboot node
> 

You are right. I wonder why Serge did not change others.

Looks good, thanks for clarification.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


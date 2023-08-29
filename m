Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828D978BE74
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjH2GaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjH2G3z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 02:29:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6EA1B9
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 23:29:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a5be3166a2so168002066b.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693290585; x=1693895385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfulV8l9fAUi9Tsip5/92M0tbm/MGDJ64gWqHZKs5QM=;
        b=M6U9uxGnbQr/fqYwdYbCqGLGUC5TUD21umeX91HrRYhQ9ru4ZrV22Oc73gfV+qTpfr
         7xrf8ZFp3iXsdNCL9aJs+1orL7o0WUwiM/7C/U1GpYfzEj2hKL4B3rkscQzmw0hL9kcd
         F+B0mr/KR0tu8xq/cbfrcyWYEiI8A9+IRlG4YYJjFt1xCFNZ6Xo6XU/LM7n29+9JSb0l
         jMdltpPxtOW5wPQkWFY5lgUW4HxkuKHrBFA5tsqR1D+J6j5PqiRmomqNTRqLTf0XF39Y
         QIgxnwhEkEgqQc3jKhkzwSpJ2uuPpfX5ulMqOkbRSriLqBkx67qgLplaaW1+G0Jd9XN6
         JY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693290585; x=1693895385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfulV8l9fAUi9Tsip5/92M0tbm/MGDJ64gWqHZKs5QM=;
        b=gpB2Xp1Mb3FMgkf4PKgjBJSoZbwqFLEXz98CfC6YKiNRpClcqMrf3q+IVnU5NqEtzy
         QUnuaDpRkBSOHJufS4RVnAInVHx6/ud6aMSEgP6vulI4EgcNkgutsxMhpU7f2b+oOefq
         WKntUkApFY/SA21Cj1WQS2zJTBAyL/djcs/BIOD1/v7eI5iirhyWRstlXqanMWZkSpxJ
         NeLVRmfgWzyaBAK/asbcfNIxlV7XG4B8FcRmCRwKhEXCCqpjCX5ChDUXMN9iQz1mkCaU
         7FAX6vByblm1ImFFPg9lFzJ3nmRMo7pf4W4e0TKSfh3BclZLObZ16sUIf6IyZFySiE3D
         fVVQ==
X-Gm-Message-State: AOJu0Yzy5RoYqctgxBMV2ykX6nCtnJg97Kj1yuD815Ixzbk2Sdp3B03X
        +Hjb3z+Fqf6y2QNiN52Q2Vywvg==
X-Google-Smtp-Source: AGHT+IHmnbiTbRrVI1+kiRm4p8e06XXGWlBZtkv3p5iM1pfrWN1Ql5/ryaWvi4l3r6rYzjx7fJXLvw==
X-Received: by 2002:a17:906:113:b0:9a2:120a:5779 with SMTP id 19-20020a170906011300b009a2120a5779mr11507129eje.60.1693290584856;
        Mon, 28 Aug 2023 23:29:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id k16-20020a170906971000b009a0955a7ad0sm5573160ejx.128.2023.08.28.23.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:29:44 -0700 (PDT)
Message-ID: <3fd27e64-2221-ec38-1320-9ae966f998aa@linaro.org>
Date:   Tue, 29 Aug 2023 08:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] dt-bindings: soc: loongson,ls2k-pmc: Add missing
 compatible for Loongson-2K2000
Content-Language: en-US
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <54ee114c08f35ab8b5dc584fd76135ac9076f5a7.1693218539.git.zhoubinbin@loongson.cn>
 <20230828-shrewdly-payee-c5eb091a0417@spud>
 <CAMpQs4Jp0rb8sbrLrPnNziLph4Ym4LxBsFt-00G69ecd8bUHNg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMpQs4Jp0rb8sbrLrPnNziLph4Ym4LxBsFt-00G69ecd8bUHNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/08/2023 05:21, Binbin Zhou wrote:
> HI Conor:
> 
> Thanks for your reply.
> 
> On Mon, Aug 28, 2023 at 11:49 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Mon, Aug 28, 2023 at 08:38:32PM +0800, Binbin Zhou wrote:
>>> Document the Power Management Unit system controller compatible for
>>> Loongson-2K2000.
>>>
>>> This is a missing compatible, now we add it.
>>>
>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>> ---
>>>  .../devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml      | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>>> index da2dcfeebf12..7473c5659929 100644
>>> --- a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
>>> @@ -15,6 +15,7 @@ properties:
>>>        - enum:
>>>            - loongson,ls2k0500-pmc
>>>            - loongson,ls2k1000-pmc
>>> +          - loongson,ls2k2000-pmc
>>
>> Same thing here as the driver patch, the pmc on this newly added SoC
>> appears to use the same codepaths as the existing ones. Does it share a
>> programming model & should there be a fallback compatible here?
> 
> I noticed the guideline about fallback compatible:
> 
> "DO use fallback compatibles when devices are the same as or a subset
> of prior implementations."
> 
> But in fact, ls2k0500/ls2k1000/ls2k2000 are independent, there is no subset.

We do not consider here ls2k0500/ls2k1000/ls2k2000, but PMC in each of
them. If they are independent, why would they use the same interface?

> Can we define a "loongson,ls2k-pmc" superset for each ls2k SoC
> compatible fallback.
> 
> Such as:
> 
>   compatible:
>     oneOf:
>       - enum:
>           - loongson,ls2k0500-pmc
>           - loongson,ls2k1000-pmc
>           - loongson,ls2k2000-pmc
>       - const: loongson,ls2k-pmc

This is discouraged. Use 0500 as fallback.



Best regards,
Krzysztof


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7860E2F5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiJZONL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiJZONK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 10:13:10 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576B10DE4E
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 07:13:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z17so7922621qkj.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BJkQ2Lvx038FbiNzpk9wcXe4nIQwkZdE8UfXIihqNk=;
        b=QhFXvTvNJUlIUlpQDnzeAFmF6+ln6IFY1BFH21RP3EDt2LD6+1BYjRCN8caiSBm9uE
         CPrOIRLVIOU+Xb1tuA5uzcHXRF7ZgVxAc3k82P8Mz5y9pR/HX2TepOaNrgwIXyEfqtfl
         QsEycG67flPJyLlIIpQxjnPapaGi5xAXZNMh5iU8UZ+zTDI3D5A9QIQQMOFjr9FUJEx5
         ep/+BMxyL5A6mYuUnVqMPJX0r7bnvvrSfWFLqz1HyLxOhEAIlz6nj4ZNidzji5N/SsPi
         fc+x4k16tPOTNEtcw7GO9Dlfd2ijEz1Dxx7dGrYQsJjNfiEKfoRKjwN5btuyQQQnNAfu
         mjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BJkQ2Lvx038FbiNzpk9wcXe4nIQwkZdE8UfXIihqNk=;
        b=Orj0ORWs6MsZ37ejNg9mcKwec363GZC4xSpT5O2dkRLmus0XzE3Qdx6S6oOdcu6EVT
         9lN5djKEOm0pxOxmkn1PPKM5ICny1Eu1KT65f1g/T43zIkGziH6V4IryIa4KXKoJ0arc
         /NuzGbPFncC7DR5KRAl0lDqzUV1Z4ufjs3F4IkWH/EUGxP9tAFRUFLN2R7C42E7UcLrl
         P3WuFkLZ3uy3w41YtNaq0tDG5fH+EuCUg/9imvq1mpohtTnx4O2QJp5pxy+7NKQLgD4v
         rW09WQ8f0ND3bujkYBzeI92HD+Axgpr4fK6DobTSgV/Ir2kIJDTg264LSOaJU2k97qCx
         nT6g==
X-Gm-Message-State: ACrzQf244e9ixs3orTOPfpdP6rh0+JV0CiRbVFbraN/OzfJs+wMgdnTn
        5/VeAUWJoB6MjlAdaQqhzt9LRw==
X-Google-Smtp-Source: AMsMyM5HJOoGv/K2f7op+AS1jKZWgMgm9sMjTfvjwWkv3/yGR1lYtHuWo60wwCaoDlDuxiFnqa7Rig==
X-Received: by 2002:a05:620a:28d3:b0:6ee:cffb:21ef with SMTP id l19-20020a05620a28d300b006eecffb21efmr30529027qkp.123.1666793588691;
        Wed, 26 Oct 2022 07:13:08 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a2a0e00b006cbc00db595sm4164494qkp.23.2022.10.26.07.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:13:07 -0700 (PDT)
Message-ID: <bcf5ef3c-a17d-e174-2b97-cef4d728cb35@linaro.org>
Date:   Wed, 26 Oct 2022 10:13:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/5] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-3-marcan@marcan.st>
 <5c3126fb-8fdb-5163-95a8-136a4a7ee2ce@linaro.org>
 <97d3d6d4-b19c-a194-de41-f17e65bf3eb6@marcan.st>
 <21602556-8312-fb7a-1981-cd03a314d904@linaro.org>
 <0f76c1b5-8fe5-e3dc-dc9a-7b0ad9660275@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0f76c1b5-8fe5-e3dc-dc9a-7b0ad9660275@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/10/2022 00:18, Hector Martin wrote:
>>>> With the first one (t8103) - it's an enum.
>>>
>>> This is deliberate. t6000 is compatible with t8103, but t8112 is not
>>> (though all are compatible with what the generic apple,cluster-cpufreq
>>> compatible implies).
>>
>> I was not talking about t6000. I was talking about two entries - first
>> and last - which should be just an enum. There is no compatibility, so
>> what is here deliberate? To not make enum things which are an enum?
> 
> Sorry, I didn't understand what you meant. You mean that the two entries
> should be merged, with an enum for the first item listing both SoCs, right?

Yes

Best regards,
Krzysztof


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E957560D441
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiJYS4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiJYS4x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 14:56:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB251D0FB
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 11:56:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h10so9385728qvq.7
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qLSpogfW3OQu3eVlGO6LKpsYjIV1r1MhY4lvAzTskc=;
        b=KX4Mi+BLarTQIYnjBPsFf/oCYyAVBxh0ePagIS0BJ2Wbo7g7d//418+ayy+2I8rARM
         s3FCaqvCsNzcaKfHSPBiOjG1a/AkPSHHXqh9lqymOWXRLoY8Hxu8ZLzFBsFMAi7XT5w3
         D4e2wLoajRDUFOpl6Z0Hq4VN+d5WWMVNcx26Bn60ZLQR5kHqgdNWqIGIjjHcTIDhiKpr
         AKN/8YO23QXoQEssPmhql5yGZkzekKpDM/u0SYRfBAFntru/bZriZoTBptZHp1ZWVqw+
         IzdwdTMm9R3E0idMrn0gqrSdX9/+2h0nALoD/VrnkI0rC3BzIXan0vDWTceceWLuiLT1
         +CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qLSpogfW3OQu3eVlGO6LKpsYjIV1r1MhY4lvAzTskc=;
        b=TjTpvhFzg+iDkpHWAEzDoAuJIlCIqM+Y6ju/s+x8bMwjYVmMk9y21FnrbQXG8Hl3GT
         pWfrjJ5eot0JIGXIe/YODptR+C2jN47Ds11KERJz0cC+N1Y2Dg06gXTdGnA/NMAWxC0f
         0DDH5oofU7aknwtzT8m5dPb4OINUsQSTVx7l4yUFeQFUX1G56Hlmb0C9Yap1rvEZaIuO
         +HdST05IRXoA2TT86S/VymUlKFQNVMzlhI6VbY03tmFNkmMC//B3prbsWfsIBx77uOW5
         EK0vNXh4Y0PqEl4LuXAxpVYY19Kh4RttHfrGgP8Bcuxawy6X+VzNqzIufMvKAGLz4EPz
         4pvg==
X-Gm-Message-State: ACrzQf10TlrN6S9Tpzd/QSaF+19MN2CJtSg0D73jgfY6SEGAtDhh/lGh
        pwG/ShqdECqMR5G6YlNcw4wE9g==
X-Google-Smtp-Source: AMsMyM4bCIbXwBiHy/Q3UOvNd8jZjJ7e5ZS+wJwzwYzIb8/YnaoXKvANkVRVKcLnP84ZJQ4p7ieKbA==
X-Received: by 2002:ad4:5dc6:0:b0:4bb:798f:5272 with SMTP id m6-20020ad45dc6000000b004bb798f5272mr8134448qvh.131.1666724211165;
        Tue, 25 Oct 2022 11:56:51 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id b23-20020ac87557000000b003a4ec43f2b5sm195614qtr.72.2022.10.25.11.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:56:50 -0700 (PDT)
Message-ID: <21602556-8312-fb7a-1981-cd03a314d904@linaro.org>
Date:   Tue, 25 Oct 2022 14:56:48 -0400
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <97d3d6d4-b19c-a194-de41-f17e65bf3eb6@marcan.st>
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

On 25/10/2022 13:22, Hector Martin wrote:
> On 26/10/2022 01.01, Krzysztof Kozlowski wrote:
>> On 24/10/2022 00:39, Hector Martin wrote:
>>> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
>>> The hardware has an independent controller per CPU cluster, and we
>>> represent them as unique nodes in order to accurately describe the
>>> hardware. The driver is responsible for binding them as a single cpufreq
>>> device (in the Linux cpufreq model).
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>>  .../cpufreq/apple,cluster-cpufreq.yaml        | 119 ++++++++++++++++++
>>>  1 file changed, 119 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>> new file mode 100644
>>> index 000000000000..b11452f91468
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>> @@ -0,0 +1,119 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Apple SoC cluster cpufreq device
>>
>> Few nits, in general looks fine to me.
>>
>>> +
>>> +maintainers:
>>> +  - Hector Martin <marcan@marcan.st>
>>> +
>>> +description: |
>>> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
>>> +  the cluster management register block. This binding uses the standard
>>> +  operating-points-v2 table to define the CPU performance states, with the
>>> +  opp-level property specifying the hardware p-state index for that level.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: apple,t8103-cluster-cpufreq
>>> +          - const: apple,cluster-cpufreq
>>> +      - items:
>>> +          - const: apple,t6000-cluster-cpufreq
>>> +          - const: apple,t8103-cluster-cpufreq
>>> +          - const: apple,cluster-cpufreq
>>> +      - items:
>>> +          - const: apple,t8112-cluster-cpufreq
>>
>> With the first one (t8103) - it's an enum.
> 
> This is deliberate. t6000 is compatible with t8103, but t8112 is not
> (though all are compatible with what the generic apple,cluster-cpufreq
> compatible implies).

I was not talking about t6000. I was talking about two entries - first
and last - which should be just an enum. There is no compatibility, so
what is here deliberate? To not make enum things which are an enum?

Best regards,
Krzysztof


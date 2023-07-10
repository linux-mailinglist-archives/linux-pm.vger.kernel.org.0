Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9F74D9A1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjGJPOA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjGJPN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 11:13:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3786B7
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 08:13:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so47195085e9.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689002036; x=1691594036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85ipMnKhTmCRR/+ctL9Ale6MVh3KnIeTA4oNiNxzq0Y=;
        b=ZL1I+X9kQ2ElwDmG+AEK8KwT/B08w/my8Sc4CIOHtVXTwmQ+PgCzzFJZ3Akw2b3y3T
         1fnzKN5De4XH/rii8aIyjr73nPV2T28m7SZ2fCN2RHnnhWQlkGaA9R+/rPAyUrsqjsXV
         VsAXMW2D8OlEfiPvhovXj47rzAu0Unx5urxgY/u6fxTUrilLOAq7wmavdMr1bkb+JIxt
         zVNEDySJWILQPgM1DJAHSdMOwDmDJatkQBQrsjhkDumSpBw40PtY0tZpViOIVZz+Vh+B
         CcOuj7FvNWveG1KXUD4UFxU6CAa1jGrSfaV3bI97KaGKRLEJOl8DjrPHo83nd0CXDLJ5
         1UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002036; x=1691594036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85ipMnKhTmCRR/+ctL9Ale6MVh3KnIeTA4oNiNxzq0Y=;
        b=mFqwFd2xRqUvFcZ6UGlXTSovl/biDLY3tlC3q8kGCh+IE8XfB4wxS/lXIp+FnfOicD
         kJHK9jtdb0ecBMmOm8nYFfGFMZL2evKFUyaejihNaS8NSYwgpp5HTCf75LEN28bo6n0J
         iozZv2I4s9Ksm+V178gqbT/gyzlOd6ZP2XZu40xel8y19ZfPO6WQaDsrJh+iTDq/lDSv
         xme7lbgjlF8j750++0IzOTEJKHd191XNQmrAg8B2mJDGQPbvmaRWq15InCH5zTOV976L
         pJIuqIggQg/buq9+7eyMQli1duJXjNERV6MURdzM+GHU3qPCpuF5NzGTmkUtuuCDCKKV
         jkQA==
X-Gm-Message-State: ABy/qLYydm9DL85PSgPAoxeuxH22+VxvvX7SMK39kG/OAfIBPKdI0CxK
        d8dx7H+pYhUdZem9seQza+2wOQ==
X-Google-Smtp-Source: APBJJlGNw8LoIwWE17CDwj/ZPC8coYJt6YKpgmsEOFoHFqk4VAZJrlyE7FZLzg584jpHlBes6qR02Q==
X-Received: by 2002:adf:e0cf:0:b0:314:4bf5:2c73 with SMTP id m15-20020adfe0cf000000b003144bf52c73mr636696wri.64.1689002036327;
        Mon, 10 Jul 2023 08:13:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402165a00b0051df1797222sm5805120edx.11.2023.07.10.08.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:13:55 -0700 (PDT)
Message-ID: <a184cf8c-19c1-e2fe-d4f4-adeaf0b8d42e@linaro.org>
Date:   Mon, 10 Jul 2023 17:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: thermal: tegra: Convert to json-schema
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20230707133333.2998802-1-thierry.reding@gmail.com>
 <d6386a66-4cc2-9358-e65e-b09e614800c3@linaro.org> <ZKwW58xHD0cGfxvM@orome>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZKwW58xHD0cGfxvM@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/07/2023 16:34, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 10:09:18AM +0200, Krzysztof Kozlowski wrote:
>> On 07/07/2023 15:33, Thierry Reding wrote:
> [...]
>>> +          nvidia,cpu-throt-percent:
>>
>> Missing type
> 
> Isn't this already taken care of by core/property-units.yaml?

You are right, I did not notice unit suffix.


> That has
> anything matching "-percent$" marked as int32-array. I suppose I could
> override this with just uint32 to narrow it further down, but I was
> under the impression that overriding standard properties this way was
> frowned upon.

Yep.

Best regards,
Krzysztof


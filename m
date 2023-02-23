Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AE6A0945
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 14:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjBWNC7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Feb 2023 08:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjBWNC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2023 08:02:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB5193E8
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 05:02:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id iv11-20020a05600c548b00b003dc52fed235so8111605wmb.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 05:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a12AtM4kB0fb0LIep6/H6rCKcXD5v7yagMHvTBNIp4I=;
        b=tRgyJxREQeMXPea7+vx3UPjFq4TkFelKzdqwI1cVZTlOeC8AT79fcVRewh154+KVtt
         E8gwkM+jx2H/sAebVbRwpC0Z6BGMdtmJwhnCF7OGkI1/DVZfhOXsPdY+WNtSpsWcrcza
         OJYpvm+CTxW9r5BxoUp3oq9n1mrY+99c6TRkm3NM5qAP78IEAnaN0Nu2bExMHcJ9F33H
         Fbbivvy04kS2JRefHtFpQlY2gMz+X2qG6wWv6Z0fcGC9Is6lcY+3Mh9PctcnmisQEDzr
         H9F5x2Sl9alPT6cWFyJO/Tu8OVMxzf/MrZ7lqJ1D9eq5yqNtukc+O+TDfqrUG5q9Ep6Z
         SXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a12AtM4kB0fb0LIep6/H6rCKcXD5v7yagMHvTBNIp4I=;
        b=3zKfdLugEl/r5RXSuh0tkWVu/kgGRZWA+5EjU7hC9CBXVx0F+LDmrkXm6FrrmzU6pN
         tqHcgDrwozltyMTBp3cV/RmwVD203BFFD4mfsMLfXE8B4hthQHPVQstmyIEQVw483ck0
         14no9ysf+lLigHrvLvAWRALHB/h8rrpjJY4W9x82K5yFIlG95wuifwktNNIXDZl7Ug3G
         jByKjlNMxqZHKA8F4nuxN2SfIVfyLuqBctkIdMCNnOmNjk6ZT0xdXj7dzHEN7WA6SyfY
         nXV2mIENOQAmrkbkVcISKPXq1CQ3wF7CUqLB8rsHSfAJ66/WNm6d5A/j5D+qKsiFzoe1
         PMtQ==
X-Gm-Message-State: AO0yUKW7e1wuQznDI8mJrdHgCKT8MCxjfeDafabrKhNoN7UET72OY9LL
        7HCI8DLQt9GXmim/kaFS4cbH1A==
X-Google-Smtp-Source: AK7set/0u/f08lXDj6areZhyG0tl0Hcl/XgHidaibgl3WMxirXbbJf1yGhx03ozCxKT3l0WAGDbyKA==
X-Received: by 2002:a05:600c:a28f:b0:3ea:bc08:8f1f with SMTP id hu15-20020a05600ca28f00b003eabc088f1fmr670739wmb.20.1677157375764;
        Thu, 23 Feb 2023 05:02:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c23-20020a05600c149700b003e2066a6339sm8924833wmh.5.2023.02.23.05.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:02:55 -0800 (PST)
Message-ID: <a662b604-0bef-6ee4-43d5-0480171539c3@linaro.org>
Date:   Thu, 23 Feb 2023 13:02:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-3-bryan.odonoghue@linaro.org>
 <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
 <f852bf35-6f29-a91a-00ab-9f7b2d709328@linaro.org>
 <78f9f327-283d-c7f9-b54b-a54efd1d264b@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <78f9f327-283d-c7f9-b54b-a54efd1d264b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/02/2023 12:53, Konrad Dybcio wrote:
> 
> 
> On 23.02.2023 13:51, Bryan O'Donoghue wrote:
>> On 22/02/2023 17:08, Konrad Dybcio wrote:
>>>> +            interrupt-names = "wdog", "fatal", "ready",
>>>> +                      "handover", "stop-ack";
>>> This should be a vertical list
>>>
>>>> +
>>>> +            clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>>>> +                 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>>>> +                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
>>>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>> +            clock-names = "iface", "bus", "mem", "xo";
>>> This could also be one
>>>
>>
>> Sorry what are you asking for here Konrad
>>
>> clock-names = "iface",
>>                "bus",
>>
>> if so, why ?
> Yep!
> 
> It's just easier to read.. you don't have to count the
> nth entry in a single line. Maybe this specific example
> is still easy for the human brain to quickly cross-reference,
> longer lists or lists with longer entries than 3 or so are
> confusing..
> 
> Konrad

I'm not necessarily opposed to that, I just don't see much precedent for it.

But... fine.

---
bod

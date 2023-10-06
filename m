Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8497BC178
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjJFVo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjJFVoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 17:44:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93010D
        for <linux-pm@vger.kernel.org>; Fri,  6 Oct 2023 14:44:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405524e6768so25191845e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Oct 2023 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696628690; x=1697233490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJM3i291v2QugmEKmLTZguR5dO9/xbtzKBboNYneqHA=;
        b=jFO8uIXCbSCU8e5tiwBJSWruc5GW5/qA3ADqk24ceImXwQST9wBiUYxvurfoolDNZn
         dQZL2OyCJ1C23myoJz1PFCCFAmnMnZa+t0d5WJFdtTf4lyYIyd1MtfM4OOgduw45ZwXi
         irnYi7+0UvxrjUFf6lBLjdddGk+DZ2d7loHYZ3O1WOKU0iQCfmbBPplKFZZVClAKwoIb
         ROxNS4yADyOt+BsMlrpsXeGt+zYBDW1qnGumt6AdMrT13u9BVTgREDUKumyKyL1PGaIJ
         k7K5ykyVp3jucJE6NSuhf+lKaQDaqtenG71VQMpdsa9sQx6/jxNFwONfViYnzQ3zuOcH
         4IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696628690; x=1697233490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJM3i291v2QugmEKmLTZguR5dO9/xbtzKBboNYneqHA=;
        b=Jh4kZJPJBNEpdA2Qz8FbJgZ3N5OA9Hob/LGEGKTs8CKyfIDFc9SW2q6UQZ0orkmnOb
         5HCO5SSSTe6rjmBt24QJnFrDt3cbh/qxYy4jQG+ICoUVmegvBhNDntJ9pCntG7UQjGls
         yVJmHY03TtoN9d8xQJylaonZIkNu6z9/aLupMFY76hDQmaiiz4jXVOV599/nxofPUqiG
         qCim8Hi2vN1imkniGi0eFJZcMoezJZBImSz0Yz//UU/UprrmbUXc0DrGLiZxzNkSPegl
         XVPlvovHOukXK2F1kjdDuz8pwSzWIaYzGOVnbqa3H+z90bKwHG6CjCLL7xOSGDHeYqKj
         eoHA==
X-Gm-Message-State: AOJu0YzCMmiGIe1M0I7TMS+JfXFVZF5jzH+XUcE2w8P/MjzVDLI3FRWm
        BDehm8Qbq/5RpXtfQ+sOXc6MTg==
X-Google-Smtp-Source: AGHT+IHNGp9wN1FEMydl8FfeyM/0EeBWsAlnmmZUbcfQU1BhWNEAtJwj68zwg+jXii180gDebhsDJg==
X-Received: by 2002:a7b:cbcf:0:b0:406:545a:f8fe with SMTP id n15-20020a7bcbcf000000b00406545af8femr8773574wmi.29.1696628690405;
        Fri, 06 Oct 2023 14:44:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae93:531e:11ce:c83d? ([2a05:6e02:1041:c10:ae93:531e:11ce:c83d])
        by smtp.googlemail.com with ESMTPSA id y11-20020a05600c364b00b004063977eccesm6810458wmq.42.2023.10.06.14.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:44:50 -0700 (PDT)
Message-ID: <ca4b87ea-7b59-4465-ba29-3280e82149e4@linaro.org>
Date:   Fri, 6 Oct 2023 23:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: Remove Amit Kucheria from MAINTAINERS
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
References: <5716404.DvuYhMxLoT@kreacher>
 <f0daa859-f9eb-4631-b2f9-6ee3ce5b691f@linaro.org>
 <9833cebf-e951-47c6-97b7-458ae1a5b747@linaro.org>
 <908fc8d6-10d2-51f9-fd70-171522c7e67d@arm.com>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <908fc8d6-10d2-51f9-fd70-171522c7e67d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2023 15:48, Lukasz Luba wrote:
> 
> 
> On 10/6/23 14:43, Krzysztof Kozlowski wrote:
>> On 06/10/2023 15:43, Krzysztof Kozlowski wrote:
>>> On 06/10/2023 13:21, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Amit Kucheria has not been participating in kernel development in any
>>>> way or form for quite some time, so it is not useful to list him as a
>>>> designated reviewer for the thermal subsystem or as the maintainer of
>>>> the thermal zone device bindings.
>>>>
>>>> Remove him from those two places accordingly.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/thermal/thermal-zones.yaml |    
>>>> 3 ---
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> and unAcked. We need a maintainer for the bindings. Someone else from
>> thermal?
>>
> 
> I'm going to handle the review in thermal subsystem. Although,
> I forgot about this 'binding' thing...
> 
> Daniel, what do you think?

I can handle the bindings, I rewrote the thermal-of code and worked with 
Amit on the txt to yaml conversion.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


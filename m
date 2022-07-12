Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B3571A02
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 14:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiGLMa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jul 2022 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiGLMa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 08:30:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327C32079
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 05:30:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so11009732wrx.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pdE+7/hZPq79wCoXpn9rFOlgdi97u3PZ/r+EPsFhDeY=;
        b=o81yN9sWzq5eQjIY4mfvvV4OPH0w1kUJC4cpzwXZqid2BBmy05yYjNyCO2ToIK8Se/
         oHO9tkj31bc2uWkXREwCfuDBysqtDBuk38WOVGdUOS0ROKzCxb+kVKBkEBdrIhfBwEFc
         J5ZHGzMgP3HpAlV056oaHucjoEMW19BlAfiH8mpvqgelCJ/XINIoLO1Id8HpBEhnEyw0
         DSS08OeRyT/c8S9o4+bJSb+Oi44uXbRagFMrOtgLXchjJ9xxVl4+6xEv8FQPSRUFAR+O
         sPYmJcrnpBsj9o0GgahNb1FYyrwstJEHbOrBK1wmcflFr5pY7b8sXnL9mDJRVDh1ufXf
         V2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pdE+7/hZPq79wCoXpn9rFOlgdi97u3PZ/r+EPsFhDeY=;
        b=EyS0IAGQYEdV6zjuEKt+aVl8j6KqPZZ90LC8KVh6FMe/RyjnFUCYWvn39DSgoQ8lYO
         JV7iVakGFB4Xaa+oMwm4h1Nf4KCfsUdqBKdeyBQ8r3Ig0Y8fvfMfuhj6oZyEhLzIKnbc
         uIUGLXqAFyL88bINtSQQzIdUJHuP8wkwURsVPGOb+ITdZadOZC25ylgnWY4Z/6PJx/ig
         rfeIfySKraItvDMRbG172iQX9e9sexd1f1xInKNsQABWRXMcm2xZr6Cg+x7mLtQgt1VB
         hFAadKp3d3QUNPBGL7o275uhuWFhW1kTgGWgY7kLyQhsOcJcu/Rank6aYaC7IYToQEw1
         /Oiw==
X-Gm-Message-State: AJIora8pLMkGt1D812HrfZm426fvMvDmMA0ur8geHa1O/IZO6u3sfpNm
        S7VGn/VETHheV1lfdcu2dH/e4A==
X-Google-Smtp-Source: AGRyM1vWnMsWizvn0NHwp16dGrKtMXgMx4knV5hRn1oLKRKxVGf1q28H1IGF4yqJWJ+zk1FOB5cCvw==
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id bw12-20020a0560001f8c00b0021d7e9851bamr20612671wrb.442.1657629055677;
        Tue, 12 Jul 2022 05:30:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:da26:64bf:ffc2:b735? ([2a05:6e02:1041:c10:da26:64bf:ffc2:b735])
        by smtp.googlemail.com with ESMTPSA id q13-20020adff94d000000b0020e6ce4dabdsm8105451wrr.103.2022.07.12.05.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 05:30:55 -0700 (PDT)
Message-ID: <2d680cd9-9e97-e06c-55c2-2a3a1504488e@linaro.org>
Date:   Tue, 12 Jul 2022 14:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] thermal/core: Fix thermal trip cross point
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
 <20220708183210.1334839-3-daniel.lezcano@linaro.org>
 <6ce87fbb-1460-503b-f1f1-8cf53e702cdf@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6ce87fbb-1460-503b-f1f1-8cf53e702cdf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/07/2022 13:29, Lukasz Luba wrote:

[ ... ]

>> @@ -511,8 +528,13 @@ void thermal_zone_device_update(struct 
>> thermal_zone_device *tz,
>>       tz->notify_event = event;
>> -    for (count = 0; count < tz->trips; count++)
>> -        handle_thermal_trip(tz, count);
>> +    if (tz->last_temperature <= tz->temperature) {
>> +        for (count = 0; count < tz->trips; count++)
>> +            handle_thermal_trip(tz, count);
>> +    } else {
>> +        for (count = tz->prev_trip; count >= 0; count--)
>> +            handle_thermal_trip(tz, count);
>> +    }
> 
> In general the code look good. I have one question, though:
> Is it always true that these trip points coming from the DT
> and parsed in thermal_of_build_thermal_zone() populated by
>      for_each_child_of_node(child, gchild) {
>           thermal_of_populate_trip(gchild, &tz->trips[i++]);
> 
> are always defined in right order in DT?

Hmm, that is a good question. Even if the convention is to put the trip 
point in the ascending order, I don't find any documentation telling it 
is mandatory. Given that I don't feel particularly comfortable to assume 
that is the case.

Perhaps, it would make more sense to build a map of indexes telling the 
order in the trip points and work with it instead.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

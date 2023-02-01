Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF15686935
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 15:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBAO6Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 09:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjBAO6P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 09:58:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6960565EF9
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 06:58:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hx15so32659129ejc.11
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1K2QLZf20WzArFF57Z/oEEEaWTDipa37/z/55nd9EU0=;
        b=Nah5PAYnu9QEq0n/OmutLtBjUogzMhh9m73d6Xr5n7GVEgZfedfxeLFxc4lFeXx7Oz
         k0KgkcX45oYCSXdQ2zUSlumSazh8qpkxFnCLIqQABKPjHpSzvnDjaj9+jHjM0Dh3JNfO
         eAdUydJSCxh9ISJUGThAmA8wEb+bHcOX+3dpxf9uCkjvM3WIVQ3waeJqV3Luc9U2/+Yg
         Q607oF5XKVzNMRK+tQSk+Fsx+zUZ3Z7uWg58B/yOjAsg6EbYb3OcWXwbEwYEasrUWkVK
         4M/jMrpwHj6XvqSTrAJnDFxxHovYCkCp0o+b8LnJr5RU0P49g7yxpdbyg0ed1yZ2tqxR
         EdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K2QLZf20WzArFF57Z/oEEEaWTDipa37/z/55nd9EU0=;
        b=V8m8FAWMf+9DOs7hQwAzHkSJ5vgIxaqgrWw0g5Oy5f2IhYt7koTdqwR2Gl6/tYa+dt
         0rSBM3Np6oCNzIkQqemCOBQjKhdRpft84qeu1quPjvXq29GySs0ziyYk+S/BkrP7el7T
         nBdrCEQNJw7zbHWEFNxcaqQQkK/TIVZQqkGu7CfyKH/hBdTWk1WazbMcs/iCBnS9aAWW
         IhsmSObtGLXxZM5/Itt8T5RDsFQraZeqp0cxcg/FJMacP4uocCmGfZ2wIuKqaVbXQ0rW
         5kDwl4z8TOqCrGGb7IDimw1B3tHb33j5QhPal7Vr7BWjDXBHTmDgXNsLervZsO8nZdNV
         5TCw==
X-Gm-Message-State: AO0yUKUyk1OKR9C4aoKB5e/f9p4wsNFazCoOMmR1oWKgvmAQ8P2nfx9E
        2iYzMYL4ctT1uysU5LpaJd2me9idgUwr9A4X
X-Google-Smtp-Source: AK7set8UfepV6n09w0GbCwgH4ikTcH7SQ7W6ASYt5eg4QMpwzBniDMArfRtN+7iLV0dbCgXMD++YjQ==
X-Received: by 2002:a17:906:88a:b0:7c1:8f53:83a0 with SMTP id n10-20020a170906088a00b007c18f5383a0mr2566070eje.13.1675263492024;
        Wed, 01 Feb 2023 06:58:12 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bt7-20020a170906b14700b0080345493023sm10043281ejb.167.2023.02.01.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 06:58:11 -0800 (PST)
Message-ID: <1d33eb58-95d1-643d-52cc-2888ff0cea43@linaro.org>
Date:   Wed, 1 Feb 2023 16:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
 <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
 <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
 <58a5e856-3e8b-d660-09ee-7a18b184452f@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <58a5e856-3e8b-d660-09ee-7a18b184452f@linaro.org>
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

On 01/02/2023 16:45, Bryan O'Donoghue wrote:
> On 01/02/2023 13:41, Dmitry Baryshkov wrote:
>>>                           cci-cpufreq {
>>>                                   target-dev = <&cci_cache>;
>>>                                   cpu-to-dev-map-0 =
>>>                                           <  200000  200000000 >,
>>>                                           <  345600  200000000 >,
>>>                                           <  400000  200000000 >,
>>>                                           <  533330  297600000 >,
>>>                                           <  800000  297600000 >,
>>>                                           <  960000  297600000 >,
>>>                                           < 1113600  297000000 >,
>>>                                           < 1344000  595200000 >,
>>>                                           < 1459200  595200000 >,
>>>                                           < 1497600  595200000 >,
>>>                                           < 1651200  595200000 >;
>>>                                   cpu-to-dev-map-4 =
>>>                                           <  200000 200000000 >,
>>>                                           <  249600 200000000 >,
>>>                                           <  499200 297600000 >,
>>>                                           <  800000 297600000 >,
>>>                                           <  998400 595200000 >,
>>>                                           < 1113600 595200000 >;
>> These should map to existing opp entries.
>>
>> I ended up doing the interconnect driver that maps a clock to the
>> interconnect. Then I can use it in the cpu opp tables.
>>
> 
> Can you point us at what it is you are proposing ?

https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-9-dmitry.baryshkov@linaro.org/

> 
> ---
> bod

-- 
With best wishes
Dmitry


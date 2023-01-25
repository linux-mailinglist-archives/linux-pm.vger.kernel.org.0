Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F54C67AB1C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 08:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjAYHnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 02:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjAYHnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 02:43:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B17113CE
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 23:43:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b7so16133157wrt.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 23:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muf/zGy7zrsCMgmkKGOZ9RAmuniRIs8c0Xd0aflWQ38=;
        b=jNX0/NkH6hZfgYCdnz9BCQYtQPrh32i6DY87qckF8MY2LT1y61b2YHTZr72e/lPDo8
         x/2SkxmN8KLA7IbUIFrdMkQmLxzXwu4JBiI0+duaA2eSbnu7LlhiFrzh3YMv5y8ngWft
         JFqQIpTu+kdEkXqCogFRb+BvOneNBarLE5GooEFBaFyGPPF0G3+6cBS1YZ41Xh2dHP0R
         oVqlGG/XmJk3ddxP0QpCQkWFkT9v9augtrtUk8Nw3B/AkoUmPotuSFhg5d7IwfuMEmX4
         ab6lYheHKcyYctGon6MdCLHhvMceliG0ZiG/LEzHnnZhfpatPe2eJ5tTJ13UqycpzlCT
         PgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muf/zGy7zrsCMgmkKGOZ9RAmuniRIs8c0Xd0aflWQ38=;
        b=KX3NyDVfvwXUa5h6Qg/XNwF1K3103PwBDGFPDWgdpdWv4Ip1JArnVcvy0Glfc/NUwH
         BcRQ0dRN9pgtuGez/8v1SjtFayh9NBo3Dz5BZPjB7rbSn9mfZhnypRnUc4BIcx1XNDn1
         j10kCCwjY/FaQnRoKjcxfodmrPhQBVzV92Y1MXuURAlRP9ZqBHZp1MSRAL0Af2Wa4Itj
         a/TI8a+X6jqzShI0ik7LCRUa5+0THdc63OUxfabOvu3sYXSEYg6P77fFk9QPEdweb5zX
         +wWYpJI8WM0WgCrF5Bzf4gEWZNsNkGTZ9pfYmXPNP4nMyYKhOp3vd+CyVhnY8MYuUWqS
         HplA==
X-Gm-Message-State: AFqh2kpk5vC4gaAQryiw8ZUF7d6bw3lR2BTzMMbcFrL4csj/kouihthr
        rq0i8b0SmUoXPMfV12L24vF2tw==
X-Google-Smtp-Source: AMrXdXvKSkwmMo6myk0f8HJh2ddDrbZC58zRqOXu6kIgMq+6CNWDJAqwj9wiFLx7d/lVZnDlpJ7vSg==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr28555562wro.48.1674632582224;
        Tue, 24 Jan 2023 23:43:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002bddac15b3dsm3291815wrf.33.2023.01.24.23.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:43:01 -0800 (PST)
Message-ID: <c247710b-369a-67d0-0637-b32192d25e4d@linaro.org>
Date:   Wed, 25 Jan 2023 08:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
 <20230124153411.nwkbjgoqgkua2icm@bogus>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124153411.nwkbjgoqgkua2icm@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/01/2023 16:34, Sudeep Holla wrote:
> On Thu, Jan 19, 2023 at 07:42:28PM +0100, Krzysztof Kozlowski wrote:
>> The runtime Power Management of CPU topology is not compatible with
>> PREEMPT_RT:
>> 1. Core cpuidle path disables IRQs.
>> 2. Core cpuidle calls cpuidle-psci.
>> 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
>>    pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
>>    spinlocks (which are sleeping on PREEMPT_RT).
>>
>> Deep sleep modes are not a priority of Realtime kernels because the
>> latencies might become unpredictable.  On the other hand the PSCI CPU
>> idle power domain is a parent of other devices and power domain
>> controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
>>
>> Disable the runtime PM calls from cpuidle-psci, which effectively stops
>> suspending the cpuidle PSCI domain.  This is a trade-off between making
>> PREEMPT_RT working and still having a proper power domain hierarchy in
>> the system.
>>
>> Cc: Adrien Thierry <athierry@redhat.com>
>> Cc: Brian Masney <bmasney@redhat.com>
>> Cc: linux-rt-users@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Re-work commit msg.
>> 2. Add note to Kconfig.
>>
>> Several other patches were dropped, as this is the only one actually
>> needed.  It effectively stops PSCI cpuidle power domains from suspending
>> thus solving all other issues I experienced.
>> ---
>>  drivers/cpuidle/Kconfig.arm    | 3 +++
>>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index 747aa537389b..24429b5bfd1c 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -24,6 +24,9 @@ config ARM_PSCI_CPUIDLE
>>  	  It provides an idle driver that is capable of detecting and
>>  	  managing idle states through the PSCI firmware interface.
>>  
>> +	  The driver is not yet compatible with PREEMPT_RT: no idle states will
>> +	  be entered by CPUs on such kernel.
>> +
> 
> Any particular reason for even compiling this file in or allowing the
> ARM_PSCI_CPUIDLE when PREEMPT_RT=y ? If we can't enter idle states, we
> can as well compile this file out ?

It's the power domain sued for other devices, so we need it. Otherwise
other devices will keep waiting for this missing power domain provider.

Best regards,
Krzysztof


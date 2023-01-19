Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9756673DB8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjASPkf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Jan 2023 10:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjASPke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2023 10:40:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362A80177
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 07:40:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so3006977wmq.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 07:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9eecqrYtchr5+5zvHi6jZ2e/F/uZL1DzfEv71w8FuU=;
        b=MPen3eTR6V2Mh5lQr1ZYzk8Tvkiz95AVej3+xkugmNtZtnYxzXAicSJTxdM8rcBbqu
         8x+NoaypFZJuIw6lfe/YI47aKAxTIDdma1u1AkPkFVZwP9PM/3TycDPuOCE/0+XjV0N9
         zLAv45esYz6h8y8OupAgT4+QTF8B6OFiLsvZO5c+mkrIz5M+v7Ioa2WCz664TdA1/RyD
         NOGl8Z/vfb8uk65YS7Vxp2nrrGbronaBl6tGYU2h+UTN/3MWolssWwSrABxTEd49ltU3
         ckkxWZwHt7b7xMSA/mr0cuIt/3YY2k7XTZRcrCG/o+LT3754wbLRFRE2BX2sfyHZt8Py
         oytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9eecqrYtchr5+5zvHi6jZ2e/F/uZL1DzfEv71w8FuU=;
        b=ijEW0c5wY/iI1/wlDZHucrE//eEHA6jdkJSAAWVFfnV5aN2/UHNDCVqw4CjIafeXAL
         eX1pv/Y6FChhW4U8nVzf/N30LaNcmC2HTI0MoEX3tfnpATEr2zEzT3LWcNstY/G9pDaH
         d78ioyD3w7agJhtpqgta2ESlnuFfHRUJKVSET1TZt2eZO8SBMzVDezTsM9tLUKZF7BHF
         dfB19BjEeV+V+h188C5/OR2sYC6a/xEb0Y+WjGw5H0LVPOSWa565SmhjI1oiudTSYeTY
         rnQjAlvap663LvzLoXQILqCg78UaPqu9czUbu4py15jPUPoLkGFpcKanhsES/mNxOee5
         RUtA==
X-Gm-Message-State: AFqh2kpmAz7PpGrxDs6Q+WKCXZUD2aMSeLGJ+MmGrrwRqLUEHCuFWTSS
        2KvsIJoG2hb+U5j2pS08xEmeVw==
X-Google-Smtp-Source: AMrXdXtvH8OpxLaXRiGQI42UENaMcJ9LN2u7ETCOWyBEvBM3A6vWwt6jvAcdoL5Ehyl8W3FT3Rvp2w==
X-Received: by 2002:a05:600c:a4d:b0:3db:1d6:16f7 with SMTP id c13-20020a05600c0a4d00b003db01d616f7mr6886216wmq.23.1674142831861;
        Thu, 19 Jan 2023 07:40:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003db09eaddb5sm6349159wmb.3.2023.01.19.07.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 07:40:31 -0800 (PST)
Message-ID: <26e431a5-9666-0c72-7b0b-1a6c1bfaec22@linaro.org>
Date:   Thu, 19 Jan 2023 16:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
 <CAPDyKFr=-Mts4QtdizW5-D5qO3aP=9ODMhgST4Nx74n5xXxi5A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFr=-Mts4QtdizW5-D5qO3aP=9ODMhgST4Nx74n5xXxi5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/01/2023 16:27, Ulf Hansson wrote:
> On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The PSCI cpuidle power domain in power_off callback uses
>> __this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in
>> Realtime kernels and solves errors like:
>>
>>   BUG: scheduling while atomic: swapper/2/0/0x00000002
>>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>>   Call trace:
>>    dump_backtrace.part.0+0xe0/0xf0
>>    show_stack+0x18/0x40
>>    dump_stack_lvl+0x68/0x84
>>    dump_stack+0x18/0x34
>>    __schedule_bug+0x60/0x80
>>    __schedule+0x628/0x800
>>    schedule_rtlock+0x28/0x5c
>>    rtlock_slowlock_locked+0x360/0xd30
>>    rt_spin_lock+0x88/0xb0
>>    genpd_lock_nested_spin+0x1c/0x30
>>    genpd_power_off.part.0.isra.0+0x20c/0x2a0
>>    genpd_runtime_suspend+0x150/0x2bc
>>    __rpm_callback+0x48/0x170
>>    rpm_callback+0x6c/0x7c
>>    rpm_suspend+0x108/0x660
>>    __pm_runtime_suspend+0x4c/0x8c
>>    __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
>>    psci_enter_domain_idle_state+0x18/0x2c
>>    cpuidle_enter_state+0x8c/0x4e0
>>    cpuidle_enter+0x38/0x50
>>    do_idle+0x248/0x2f0
>>    cpu_startup_entry+0x24/0x30
>>    secondary_start_kernel+0x130/0x154
>>    __secondary_switched+0xb0/0xb4
>>
>> Cc: Adrien Thierry <athierry@redhat.com>
>> Cc: Brian Masney <bmasney@redhat.com>
>> Cc: linux-rt-users@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>> index c80cf9ddabd8..d15a91fb7048 100644
>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>> @@ -62,7 +62,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>>         if (!pd_provider)
>>                 goto free_pd;
>>
>> -       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
>> +       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_RT_SAFE | \
>> +                    GENPD_FLAG_CPU_DOMAIN;
> 
> My main concern with this, is that it will affect the parent domains
> too. Whether those would be able to use the GENPD_FLAG_RT_SAFE or not,
> is a different story.
> 
> In one way or the other, I think it would be better to limit the
> GENPD_FLAG_RT_SAFE to be used only for PREEMPT_RT kernels.

I can do it... or maybe we should just drop the flags (RT and IRQ safe)
when parent domain does not have it?

Best regards,
Krzysztof


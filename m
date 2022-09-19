Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD365BCB52
	for <lists+linux-pm@lfdr.de>; Mon, 19 Sep 2022 13:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiISL7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Sep 2022 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiISL7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2022 07:59:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C42B5
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 04:58:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f14so45566217lfg.5
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tOSWQ/Fkk0V5oAcdCK1GczlPJaCXPeT7oD2Ukr849gI=;
        b=ud8s1MDjz5DX1o47iaJrLJF00O4hgWcsSs4er19vmHaPKcrqBfPysZ3TwkVrzhEr45
         25HKqPWspOgbLAGoPSu1xN+HGQLU9ZcdoNW7eHHYRRlnF82EvqCnDCZREAVj5j5+Qks/
         BaTEgJkD1GAYxtIHBV2NHPjwpOIDXkMXM2Tp0WJ3LphcddWQvJaaJiUiDUVko0zHtiBC
         eCKvzETT3zU/u82k0ZGnmPXggaQ1qZCIsnhX1AtuJ8YXc+hrs6xWD7lTmDUgB79yGe8f
         rfEFfAFco+cIdLL5HRiC4/vgNa0TWpe24JFgCwRMhvoIwkdN7kFwm9jMHn+u0bBRWah6
         pMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tOSWQ/Fkk0V5oAcdCK1GczlPJaCXPeT7oD2Ukr849gI=;
        b=kmuq/yDl7Qm0uLRyZIUXCbAORO20UUNhvWupOGAhb7/rpWER1WTdZB8wIWBItB6tzf
         iTWvhg6GzFzVTh0S1Qbb0R5LMU66uH6s6POzuaqP93kbFtGQ0oNJqgdYFEzNBx2ank1w
         s7A0r5h724rTt/SuFdvL2D7rzMeKT6WyiMsMJyTMDnsHN4OMFaTfAL/O32R637FrcAi/
         K+USvvibkJCu+LP0jb/hvQyQJZ9nwBaKXcyQTl+a2YG0+T9uct75tQJOxxKivfhlgWVB
         pjMKFUka28LNt2pyY/oI9SHD0cdb3untX1/o9e9CkBodYYI4Gskv6zboiGjWZSlpgwyy
         pxww==
X-Gm-Message-State: ACrzQf0jN0aqn2Zh1F1iF1bjMnyYipHac7wqMXFJiR3GU9jceSjFUGgj
        Vss+Xfe23PsPVL1LeI9N+e/6TYCZfncbTw==
X-Google-Smtp-Source: AMsMyM5q+6jx2f3SL4JC+p1u5O/iO5UAPFCnIdCUDD/xQ+gkohX0TWipZ7CN/CJOab2xJP98btYxmg==
X-Received: by 2002:a05:6512:c17:b0:498:f034:1c30 with SMTP id z23-20020a0565120c1700b00498f0341c30mr5879136lfu.408.1663588738088;
        Mon, 19 Sep 2022 04:58:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e7303000000b0026bca725cd0sm4881188ljc.39.2022.09.19.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:58:57 -0700 (PDT)
Message-ID: <eea4d8ec-d6de-5262-b73f-609b2f1bea86@linaro.org>
Date:   Mon, 19 Sep 2022 14:58:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept
 PC mode
Content-Language: en-GB
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
 <Yu0m6yzLr5fhEMtu@FVFF77S0Q05N>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yu0m6yzLr5fhEMtu@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/08/2022 17:19, Mark Rutland wrote:
> On Thu, Aug 04, 2022 at 04:07:50PM +0300, Dmitry Baryshkov wrote:
>> The function psci_pd_try_set_osi_mode() will print an error if enabling
>> OSI mode fails. To ease debugging PSCI issues print corresponding
>> message if switching to PC mode fails too.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.

Granted that this patch has been acked by the maintainers of PSCI 
interface, how do I proceed? Should I submit it to Russel's patch 
tracker? Or do PSCI patches land via some other tree?

> 
>> ---
>> This is a replacement for [1], now moving the warning from
>> psci_set_osi_mode() callers to the function iself.
>>
>> https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
>>
>> ---
>>   drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
>>   drivers/firmware/psci/psci.c          | 2 ++
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>> index 3db4fca1172b..821984947ed9 100644
>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>> @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
>>   		return false;
>>   
>>   	ret = psci_set_osi_mode(true);
>> -	if (ret) {
>> -		pr_warn("failed to enable OSI mode: %d\n", ret);
>> +	if (ret)
>>   		return false;
>> -	}
>>   
>>   	return true;
>>   }
>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>> index cfb448eabdaa..1628f1edef4a 100644
>> --- a/drivers/firmware/psci/psci.c
>> +++ b/drivers/firmware/psci/psci.c
>> @@ -163,6 +163,8 @@ int psci_set_osi_mode(bool enable)
>>   			PSCI_1_0_SUSPEND_MODE_PC;
>>   
>>   	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>> +	if (err < 0)
>> +		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
>>   	return psci_to_linux_errno(err);
>>   }
>>   
>> -- 
>> 2.35.1
>>

-- 
With best wishes
Dmitry


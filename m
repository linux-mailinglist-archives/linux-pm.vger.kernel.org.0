Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ECC5C0025
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiIUOnL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIUOnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 10:43:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3CD979CA
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 07:43:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so9597481lfb.6
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WESwEi3j2DFdElRDB8MsQvGJzzzvCA6pcIKirPEViJE=;
        b=wS7B5p2Ev3eBfNiO3Jnt0IMTOPdVSbT3gA59vvxhavEY8NmzjE0kxLA57OIgrk/9JE
         9YULYVtSr1OrgEwjjzuGJM/l3nAj4x27iBFPob4nfHDffAAX074cq9KWCdUMwEWKe6eH
         sorCugqwO/uoShgzdnYNhzbgdzCEJfclPSNTvhaosFvl+4CExVd3atlR+Xf0NvD+jGW4
         CYF9EqKl3AfumsdQAePEHdlHowG6jhFHLwiUGRGmzLrLig1EDShgT6L7n60cbFud2cBI
         uJFvkdi0+m7d4E6nJrE6svkAUQVhkp5kIZvbWo3S3tgy6K/BiRmcCW0CuA8WntVhHjba
         YcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WESwEi3j2DFdElRDB8MsQvGJzzzvCA6pcIKirPEViJE=;
        b=A2hEmX+14KU2t606tnr9d3h0Pd0FHHMFtpozP18pf6U/Ufy0cpsexmYAIr4WowoKyw
         7YT3e2F0A+M2OdJ9oxwASBTWM4aq0VJJAEJe697SdwFIWgLS4qRPq/5VncKIqQooxcK5
         XpR50wCd9u8VHx12WVuHNf3meF+XKB49FYnkjEVKCR9BWSwoMp0F8d/3+qTzSbYTjsf2
         739gKnpOS1mLffVlGgLgxQVMwLOlyEI2DLbExWWGONJKlnYezE4BESctffz/k6RhUJmy
         Sq2rGA2pk0ixNb1OGSa4K0xbDcLOe0femc/yN51HWhS4qm35SmynzSR/qPoETxUkwEOW
         aXOg==
X-Gm-Message-State: ACrzQf2wmAQLSRZoEnCJanUhYDVNeJjguh0NcZHSFknSrU9Ju+pFb3h/
        yFeBFB2qFaMCBicoLmj1HB++WQ==
X-Google-Smtp-Source: AMsMyM6bbWseHItUfMcsCa2d8nN+Vr7tOmYKgbBq6MGow3oXi2YTQ3shZb7hU2ShCmvKwO38JODCYg==
X-Received: by 2002:a05:6512:15a0:b0:49b:1eba:89d4 with SMTP id bp32-20020a05651215a000b0049b1eba89d4mr9539745lfb.188.1663771384860;
        Wed, 21 Sep 2022 07:43:04 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b0026c2e0258bcsm470761ljb.42.2022.09.21.07.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 07:43:03 -0700 (PDT)
Message-ID: <38ccaa39-0438-2303-6502-63902abbb044@linaro.org>
Date:   Wed, 21 Sep 2022 17:43:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept
 PC mode
Content-Language: en-GB
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
 <Yu0m6yzLr5fhEMtu@FVFF77S0Q05N>
 <eea4d8ec-d6de-5262-b73f-609b2f1bea86@linaro.org>
 <20220921143624.eulpt56r4cn4vcrx@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220921143624.eulpt56r4cn4vcrx@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2022 17:36, Sudeep Holla wrote:
> On Mon, Sep 19, 2022 at 02:58:57PM +0300, Dmitry Baryshkov wrote:
>> On 05/08/2022 17:19, Mark Rutland wrote:
>>> On Thu, Aug 04, 2022 at 04:07:50PM +0300, Dmitry Baryshkov wrote:
>>>> The function psci_pd_try_set_osi_mode() will print an error if enabling
>>>> OSI mode fails. To ease debugging PSCI issues print corresponding
>>>> message if switching to PC mode fails too.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>
>>> Mark.
>>
>> Granted that this patch has been acked by the maintainers of PSCI interface,
>> how do I proceed? Should I submit it to Russel's patch tracker? Or do PSCI
>> patches land via some other tree?
>>
> 
> Not sure if I mentioned it elsewhere or in v1, we generally ask Arm SoC
> team to pick up patches directly as they are always 1-2 and rarely large
> set. You need to cc soc@kernel.org for the same.

Ack, I'll resend v2 cc'ing soc@

> 
>>>
>>>> ---
>>>> This is a replacement for [1], now moving the warning from
>>>> psci_set_osi_mode() callers to the function iself.
>>>>
>>>> https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
>>>>
>>>> ---
>>>>    drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
>>>>    drivers/firmware/psci/psci.c          | 2 ++
>>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>>>> index 3db4fca1172b..821984947ed9 100644
>>>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>>>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>>>> @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
>>>>    		return false;
>>>>    	ret = psci_set_osi_mode(true);
>>>> -	if (ret) {
>>>> -		pr_warn("failed to enable OSI mode: %d\n", ret);
>>>> +	if (ret)
>>>>    		return false;
>>>> -	}
>>>>    	return true;
>>>>    }
>>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>>> index cfb448eabdaa..1628f1edef4a 100644
>>>> --- a/drivers/firmware/psci/psci.c
>>>> +++ b/drivers/firmware/psci/psci.c
>>>> @@ -163,6 +163,8 @@ int psci_set_osi_mode(bool enable)
>>>>    			PSCI_1_0_SUSPEND_MODE_PC;
>>>>    	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>>>> +	if (err < 0)
>>>> +		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
>>>>    	return psci_to_linux_errno(err);
>>>>    }
>>>> -- 
>>>> 2.35.1
>>>>
>>
>> -- 
>> With best wishes
>> Dmitry
>>
> 

-- 
With best wishes
Dmitry


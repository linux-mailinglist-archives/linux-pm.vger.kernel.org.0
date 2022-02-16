Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F544B9121
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiBPTZT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 14:25:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiBPTZS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 14:25:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95573293B50
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 11:25:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso3279402wmi.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DVuGB1+1BYbqRj+AN8S/Uoct07jT/PTU+VlOhYM2FTw=;
        b=NM0kROqU+bhzzWJ8HIU1UuM8FoJYwn3hCVQ6ztO7vlK9frHhFCQTPYcTzmVFEiXah9
         AOZIyHsVrlyLPEFq1D5LCkf/MSY4p+s0bKl+njKVRxQcT0VDMg7pgY4YxE/Y2x6k8JlS
         j+i4M21d0BHVZVG1HM1syD85YN1k40JR01rymXEEJGgjADt6wK18xah3yYbN3/1Uhykp
         s4g0YeekOyDhgFQeTCARIqoQc4c+6rGPO1HeahP6AG+QEwmT18+2xeRaoSa8BrVCTUFj
         SgHVEX3SgxDRpFDOM4Ga+N+wvJ6EHHDZDtb1Q0zajrLkF2Ljjn0IjJ2L2IlHrXlIJ/e/
         dw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DVuGB1+1BYbqRj+AN8S/Uoct07jT/PTU+VlOhYM2FTw=;
        b=llAL5mFDyU7YuhJBqF57hmBqhHOJX46vTIBygR61OPSliZFS+k4q0/wHkP0/bKXMfY
         eZ9DLTYUe9LuidvRz42Imhg9Vart7619U3NiOfZ3n6cPsChToGGDHvLwCGMoNaa2VKbX
         83iQGX+vgNvj0fWUUcZTIwYClPFYdRVB/JVi7Nsx5/nyJ8SUXNjZp/9NhyE0ySjOopdk
         4ef/xGeqdhulL1SzSb5Hya2Wxy5P0vhmn8s2jMa/HGcFow5KiCcuWbWbNTV8tNDkFk3Y
         386OZU5uWBGRY3UQNMd8G1Xc3GfOOnyfv93BQDGQbEGS1ErAHnga3HeoRfU7t7x76Q+L
         R3ww==
X-Gm-Message-State: AOAM533mWcHwbbIVdt640lweCjtOAofSeTSHXYeInqb+H2GIiLNPx9ic
        5GmBZ7+yhCIWPGA9fadaNv0MCg==
X-Google-Smtp-Source: ABdhPJwfzeXCETM6B4XQFnv92P4/LtQzENMqF/LsDdvfnscFzsZm0FjNrzeKBZL5cKRXH7Qqqfu6aQ==
X-Received: by 2002:a1c:f003:0:b0:37b:d5fc:5c9e with SMTP id a3-20020a1cf003000000b0037bd5fc5c9emr2922539wmb.154.1645039504076;
        Wed, 16 Feb 2022 11:25:04 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id f18sm11424614wmg.21.2022.02.16.11.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:25:03 -0800 (PST)
Message-ID: <0e7bf391-08f1-88b3-14c2-8bbf45ad7491@linaro.org>
Date:   Wed, 16 Feb 2022 20:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 4/7] powercap/dtpm: Destroy hierarchy function
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-4-daniel.lezcano@linaro.org>
 <CAPDyKFp5X7JuhXWSb--FUVwF=r-wtnPW0My9=oG14vHaPxSZFQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPDyKFp5X7JuhXWSb--FUVwF=r-wtnPW0My9=oG14vHaPxSZFQ@mail.gmail.com>
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

On 16/02/2022 17:31, Ulf Hansson wrote:
> On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The hierarchy creation function exits but without a destroy hierarchy
>> function. Due to that, the modules creating the hierarchy can not be
>> unloaded properly because they don't have an exit callback.
>>
>> Provide the dtpm_destroy_hierarchy() function to remove the previously
>> created hierarchy.
>>
>> The function relies on all the release mechanisms implemented by the
>> underlying powercap framework.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/powercap/dtpm.c | 43 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/dtpm.h    |  3 +++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
>> index 7bddd25a6767..d9d74f981118 100644
>> --- a/drivers/powercap/dtpm.c
>> +++ b/drivers/powercap/dtpm.c
>> @@ -617,3 +617,46 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>>          return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
>> +
>> +static void __dtpm_destroy_hierarchy(struct dtpm *dtpm)
>> +{
>> +       struct dtpm *child, *aux;
>> +
>> +       list_for_each_entry_safe(child, aux, &dtpm->children, sibling)
>> +               __dtpm_destroy_hierarchy(child);
>> +
>> +       /*
>> +        * At this point, we know all children were removed from the
>> +        * recursive call before
>> +        */
>> +       dtpm_unregister(dtpm);
>> +}
>> +
>> +void dtpm_destroy_hierarchy(void)
>> +{
>> +       int i;
>> +
>> +       mutex_lock(&dtpm_lock);
>> +
>> +       if (!pct)
> 
> As I kind of indicated in one of the earlier replies, it looks like
> dtpm_lock is being used to protect the global "pct". What else?

The root node pointer and the lists describing the hierarchy

> Rather than doing it like this, couldn't you instead let
> dtpm_create_hiearchy() return a handle/cookie for a "dtpm hierarchy".
> This handle then needs to be passed to dtpm_destroy_hierarchy().
> 
> In this way, the "pct" doesn't need to be protected and you wouldn't
> need the global "pct" at all. Although, maybe there would be other
> problems with this?

The only problem I see with this approach is the dtpm framework is 
designed to be a singleton, no other instance of the hierarchy can exists.

By allowing returning a pointer or whatever, that implies multiple 
controller can be created.

In addition that would mean duplicating a global variable for each 
module to store the pointer at init time in order to reuse it at exit time.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

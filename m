Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBBD30A994
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhBAOWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 09:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhBAOWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 09:22:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69669C06174A
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 06:21:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z6so16708668wrq.10
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2021 06:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8XjWTbQhqnFv71QlyVt2mGpNw84Z3L2ccctveC/TiiU=;
        b=ue22nFHSBDOkW15vxggQeVwQ5JHrmeuv9BMM6LuzX+/TXfwfdxN/HYKo7gcm15zRrC
         a+X1wuq0LYLV8iKvMEbbVxVuJ+zr9dDyEJeHnWfIbQccS/2libGbVxKhGXaDG3VsThH4
         z999r1vuaHwXwyOvsoVwybGjo3wihVY0diF7M3IBM642jEXzcUP/jUsoUpLTc1xfOP3R
         A13KAssCNoHBRxnDa5MHBUNFevOTSt82wjs6QtaVu6s7jMxv8EbAflwcFphUp3PE4LRw
         5ZNNYX97Bo4Ymoql874UBYb76Wf7W5Y8dId9QIQ8eYhHBYyeSRx39gmAfcb8jM1QlwJd
         UskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XjWTbQhqnFv71QlyVt2mGpNw84Z3L2ccctveC/TiiU=;
        b=ODYaLh6sg453obf3YDrfJqY2OmA51WN0tKZ+dfK/zGIqumxJJkNAeU01pvsvMaZ0XH
         D4Aq6DxuL+9+4uAx9AAJ3Wt4OQsDBU0VWup7xfJ1iRWADC09lJz1Pbm5Wf0U/E5GuGyY
         mVsBOqBkQmBXRkIm3xJ51WyxTFnIiT+DdAES8Kr4JGtk0ISWWsSk52eH2fiTkI2iezJL
         jEWDYnLf4f9CUwJlLDx7FrFRBRyGJnOGHRECjJRKXP1TY6IaEUHVZ9bdimcyiPwXeyYN
         2xTlUdPnzpNUFpHkzUB0KjHaCgmh1Tkr5QXfEIKzmFP+f26qmIXBejrqNZKRGrrswtLE
         fnPg==
X-Gm-Message-State: AOAM5300dktP2Bu/C06XCHUnHSxRWkeHTm+giSBOsbEaYQwp6ev6icsa
        xv8LU56GO2NU8vshR8Dt9Dg/MQ==
X-Google-Smtp-Source: ABdhPJwjdQG4b/ifSL62xiAH0E6DlU//X0RcSBD9iKqGD4/5U4SPWR+nt/5UhQflb/kqMTxlsoviIg==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr19146868wrt.248.1612189292945;
        Mon, 01 Feb 2021 06:21:32 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:51de:fd48:4b89:6536? ([2a01:e34:ed2f:f020:51de:fd48:4b89:6536])
        by smtp.googlemail.com with ESMTPSA id r17sm12927555wro.46.2021.02.01.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:21:32 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     Lukasz Luba <lukasz.luba@arm.com>, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, Dietmar.Eggemann@arm.com,
        amitk@kernel.org, rui.zhang@intel.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <5751adfa-6e25-3f3c-4a60-9b3c739fec1f@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <de40eb55-8309-e9a5-68da-eab936cd0580@linaro.org>
Date:   Mon, 1 Feb 2021 15:21:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5751adfa-6e25-3f3c-4a60-9b3c739fec1f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

On 01/02/2021 12:23, Lukasz Luba wrote:
> Daniel, Chanwoo
> 
> Gentle ping. Have you have a chance to check these patches?

I will review the patches in a couple of days

  -- Daniel


> On 1/26/21 10:39 AM, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set tries to add the missing feature in the Intelligent Power
>> Allocation (IPA) governor which is: frequency limit set by user space.
>> User can set max allowed frequency for a given device which has impact on
>> max allowed power. In current design there is no mechanism to figure this
>> out. IPA must know the maximum allowed power for every device. It is then
>> used for proper power split and divvy-up. When the user limit for max
>> frequency is not know, IPA assumes it is the highest possible frequency.
>> It causes wrong power split across the devices.
>>
>> This new mechanism provides the max allowed frequency to the thermal
>> framework and then max allowed power to the IPA.
>> The implementation is done in this way because currently there is no way
>> to retrieve the limits from the PM QoS, without uncapping the local
>> thermal limit and reading the next value. It would be a heavy way of
>> doing these things, since it should be done every polling time (e.g.
>> 50ms).
>> Also, the value stored in PM QoS can be different than the real OPP
>> 'rate'
>> so still would need conversion into proper OPP for comparison with EM.
>> Furthermore, uncapping the device in thermal just to check the user freq
>> limit is not the safest way.
>> Thus, this simple implementation moves the calculation of the proper
>> frequency to the sysfs write code, since it's called less often. The
>> value
>> is then used as-is in the thermal framework without any hassle.
>>
>> As it's a RFC, it still misses the cpufreq sysfs implementation, but
>> would
>> be addressed if all agree.
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (3):
>>    PM /devfreq: add user frequency limits into devfreq struct
>>    thermal: devfreq_cooling: add new callback to get user limit for min
>>      state
>>    thermal: power_allocator: get proper max power limited by user
>>
>>   drivers/devfreq/devfreq.c             | 41 ++++++++++++++++++++++++---
>>   drivers/thermal/devfreq_cooling.c     | 33 +++++++++++++++++++++
>>   drivers/thermal/gov_power_allocator.c | 17 +++++++++--
>>   include/linux/devfreq.h               |  4 +++
>>   include/linux/thermal.h               |  1 +
>>   5 files changed, 90 insertions(+), 6 deletions(-)
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2543748D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhJVJRj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 05:17:39 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:46810 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJVJRi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 05:17:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634894121; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uQr8BvZjWmmKxBH750LS9eoWoqnWOCF3cqNu/hoRFm4=; b=uAQqsdq5QRj42+KlGBjqrZbvywh4fDibb3MKgzPw46hfmMjUMyaSld9eqCoYTZ225xd0QEHs
 rGOXASJx47Rg6Ui/oVIArF7jxG8VPCzjqtNKdU2svaXB4WJBTAxAxsSDd04pT3HLcktqcTIv
 BV645bkl70pUAAfxRLlxpfq96NQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6172812314914866fa7834c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Oct 2021 09:15:15
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF800C43619; Fri, 22 Oct 2021 09:15:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.43.137] (unknown [27.61.247.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E390C4338F;
        Fri, 22 Oct 2021 09:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3E390C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org>
 <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
 <CAJZ5v0itweerfbq8NE9rEonZ2Nfu_nfKgERv2tweeLO4fgAgLg@mail.gmail.com>
 <CAPDyKFrOSd2xEXuvDki9Em+xFLHfeTfZz3NtnWwNmWB1H6i=Kg@mail.gmail.com>
 <CAJZ5v0j3a_m5T9nbxk4VSuABOq12JEC0fi=0SQ8+=Vwv-qDeOA@mail.gmail.com>
 <CAPDyKFpjy5sZo6ayqPx07Jzs4J2yePy=cZk=k6VjhWB7zGeedg@mail.gmail.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <28b0c55c-aa3e-8956-7be3-594e7b340107@codeaurora.org>
Date:   Fri, 22 Oct 2021 14:45:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpjy5sZo6ayqPx07Jzs4J2yePy=cZk=k6VjhWB7zGeedg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/22/2021 1:26 AM, Ulf Hansson wrote:
> On Thu, 21 Oct 2021 at 21:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Oct 21, 2021 at 8:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> On Thu, 21 Oct 2021 at 18:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Thu, Oct 21, 2021 at 6:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> [cut]
>>
>>>> So in theory you could check the pm_runtime_put_sync_suspend() return
>>>> value and fall back to something like WFI if that's an error code.
>>>
>>> I have already tried that, but it simply got too complicated. The main
>>> issue was that runtime PM could become disabled for the device in the
>>> middle of executing the ->enter() callback.
>>
>> So IIUC the problem is that you cannot resume after suspending in that case.
>>
>> IOW, you need to guarantee that if the suspend is successful, the
>> resume also will take place, but if the suspend fails, you basically
>> don't care.
> 
> Exactly.
> 
>>
>>> For example, if pm_runtime_get_sync() fails, I still need to make sure
>>> the reference counting in genpd becomes correct - and I can't do that
>>> using dev_pm_genpd_resume(). That's because it's not designed to be
>>> called in this "unknown" suspend phase, but should be called after the
>>> noirq phase and be properly balanced with dev_pm_genpd_suspend().
>>>
>>> In other words, the error path didn't work out for me.
>>
>> It should be sufficient to call wake_up_all_idle_cpus() in the suspend
>> path before dpm_suspend_late(), because system suspend acquires a
>> PM-runtime reference on every device.  IOW, it won't let any devices
>> runtime-suspend, so if your power domain devices are resumed in that
>> path, they will never suspend again in it and the
>> pm_runtime_put_sync_suspend() in __psci_enter_domain_idle_state()
>> becomes a reference counter management call which works regardless of
>> whether or not PM runtime is disabled.
> 
> That sounds like a great idea, this should work too! Then the question
> is, how to make that call to wake_up_all_idle_cpus() to become
> optional - or only invoked for the cpuidle drivers that need it.
> 
> In any case, I will try this out, thanks for the suggestion!
> 
> Kind regards
> Uffe

This may not work given that CPUs may re-enter idle after call to 
wake_up_all_idle_cpus() is finished.

say a case where,

1. wake_up_all_idle_cpus() is called first then
2. __device_suspend_late() does __pm_runtime_disable() for all CPU devices.

inbetween 1 and 2, CPUs may have entered idle again and would have done
pm_runtime_put_sync_suspend() while entering idle from cpuidle-psci.

I was thinking if PM-QoS may be of help here, before runtime PM is 
disabled, if QoS is taken with less value (say 1us) then all CPUs will
wake up to serve the QoS and then stay in simple WFI() due to QoS and 
won't do any runtime put/get, which serve similar to cpuidle_pause() + 
default idle call.

if QoS can be somehow taken from cpuidle-psci driver registering for 
suspend ops? it won't effect other archs/idle drivers.

Thanks,
Maulik
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation

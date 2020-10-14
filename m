Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9A28E480
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgJNQbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 12:31:42 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:32713 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgJNQbm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 12:31:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602693100; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=nwmkIyVnrwwZhY3pgmfTJO53deH3CqLRAs2tZtJHcgk=; b=mZaP8ot35AYdiF/H07YPE9ed+YzI1yRqHlrpcvsGfijU9Zaqx9g5SxlpT4BewhjF3jBCrpnS
 XgyOGNyaA5nhJMzx36OXDP7lrMXYG6LtVmrtPGMjwlD/szac71SBS2XYjMGwmc28+6uBkNUm
 f9g1kKkWUUKtRdx5t73rIHKpuHc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f8727daf9168450ea08e67a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 16:31:22
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58E10C433FF; Wed, 14 Oct 2020 16:31:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DED3C433F1;
        Wed, 14 Oct 2020 16:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DED3C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 14 Oct 2020 10:31:20 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 1/2] PM / runtime: register device's next wakeup
Message-ID: <20201014163120.GJ2908@codeaurora.org>
References: <20201012223400.23609-1-ilina@codeaurora.org>
 <20201012223400.23609-2-ilina@codeaurora.org>
 <CAPDyKFo0KrxQ8W0pawEca0_Ae0gs3OSBzHN2KY85YMnQp3ek8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFo0KrxQ8W0pawEca0_Ae0gs3OSBzHN2KY85YMnQp3ek8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

Thanks for taking time to review this.

On Wed, Oct 14 2020 at 04:29 -0600, Ulf Hansson wrote:
>On Tue, 13 Oct 2020 at 00:34, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Some devices have a predictable interrupt pattern while executing a
>> particular usecase. An example would be the VSYNC interrupt on devices
>> associated with displays. A 60 Hz display could cause a periodic
>> interrupt every 16 ms. A PM domain that holds such a device could power
>> off and on at similar intervals.
>>
>> Entering a domain idle state saves power, only if the domain remains in
>> the idle state for the amount of time greater than or equal to the
>> residency of the idle state. Knowing the next wakeup event of the device
>> will help the PM domain governor make better idle state decisions.
>>
>> Let's add the pm_runtime_set_next_wake() API for the device and document
>> the usage of the API.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  Documentation/power/runtime_pm.rst | 21 ++++++++++++++++++++
>>  drivers/base/power/runtime.c       | 31 ++++++++++++++++++++++++++++++
>>  include/linux/pm.h                 |  2 ++
>>  include/linux/pm_runtime.h         |  1 +
>>  4 files changed, 55 insertions(+)
>>
>> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
>> index 0553008b6279..90a5ac481ad4 100644
>> --- a/Documentation/power/runtime_pm.rst
>> +++ b/Documentation/power/runtime_pm.rst
>> @@ -515,6 +515,14 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>>        power.use_autosuspend isn't set, otherwise returns the expiration time
>>        in jiffies
>>
>> +  `int pm_runtime_set_next_event(struct device *dev, ktime_t next);`
>
>Rather than specifying the next event, could it make sense to specify
>the delta instead? I guess it depends on the behaviour of the
>driver/client that calls this API...
>
I guess, drivers would calculate the next event from an interval, but
the usage of this feature needs to account for the time from when this
call was received. I am open to taking in interval as the input and
saving the next actual time (adding the current ktime) to it.

>> +    - notify runtime PM of the next event on the device. Devices that are
>
>I would prefer to change from "notify" to "inform", just to make it
>clear that this isn't a notification mechanism we are talking about.
>
Okay.

>>  5. Runtime PM Initialization, Device Probing and Removal
>>  ========================================================
>> @@ -639,6 +648,18 @@ suspend routine).  It may be necessary to resume the device and suspend it again
>>  in order to do so.  The same is true if the driver uses different power levels
>>  or other settings for runtime suspend and system sleep.
>>
>> +When a device enters idle at runtime, it may trigger the runtime PM up the
>> +hierarchy. Devices that have an predictable interrupt pattern, may help
>> +influence a better idle state determination of its parent. For example, a
>> +display device could get a VSYNC interrupt every 16ms. A PM domain containing
>> +the device, could also be entering and exiting idle due to runtime PM
>
>/containing the device/that has the device attached to it
>
>> +coordination. If the domain were also entering runtime idle, we would know when
>> +the domain would be waken up as a result of the display device waking up. Using
>> +the device's next_event, the PM domain governor can make a better choice of the
>> +idle state for the domain, knowing it would be be woken up by the device in the
>> +near future. This is specially useful when the device is sensitive to its PM
>> +domain's idle state enter and exit latencies.
>
>The above sounds a little hand wavy, can you try to be a little more exact?
>
I can try and rephrase this. But what I think I should be saying is that
if the domain has multiple devices and if some devices are sensitive to
the exit latency of the domain idle, then knowing the next wakeup would
help the governor make better domain idle state decision.

>Perhaps, rather than just saying "sensitive to it's PM domain's idle
>state..", how about explaining that by using the "next event" the
>governor is able to select a more optimal domain idle state, thus we
>should avoid wasting energy and better conform to QoS latency
>constraints.
>
QoS is not what we are trying to conform to. We are trying to provide
residency information to the domain to help it make better choice. Just
like we use the CPU's next wakeup in the cluster domain governor.
>> +
>>  During system resume, the simplest approach is to bring all devices back to full
>>  power, even if they had been suspended before the system suspend began.  There
>>  are several reasons for this, including:
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 8143210a5c54..53c2b3d962bc 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -122,6 +122,33 @@ u64 pm_runtime_suspended_time(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
>>
>> +/**
>> + * pm_runtime_set_next_wakeup_event - Notify PM framework of an impending event.
>> + * @dev: Device to handle
>> + * @next: impending interrupt/wakeup for the device
>
>At what typical points do you expect this function to be called?
>
Most likely from at the start of the usecase and periodically when the
interrupt/work is being handled. I would think this change to a
different periodicity when the usecase parameters changes.

>> + */
>> +int pm_runtime_set_next_event(struct device *dev, ktime_t next)
>> +{
>> +       unsigned long flags;
>> +       int ret = -EINVAL;
>> +
>> +       /*
>> +        * Note the next pending wakeup of a device,
>> +        * if the device does not have runtime PM enabled.
>> +        */
>
>/s/Note/Store
>
>Do you really need to check if runtime PM is enabled? Does it matter?
>
Hmm.. This has no meaning without runtime PM. Any reason why we don't
need the check? I am okay to removing the check.

>> +       spin_lock_irqsave(&dev->power.lock, flags);
>> +       if (!dev->power.disable_depth) {
>> +               if (ktime_before(ktime_get(), next)) {
>> +                       dev->power.next_event = next;
>> +                       ret = 0;
>> +               }
>> +       }
>> +       spin_unlock_irqrestore(&dev->power.lock, flags);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_runtime_set_next_event);
>> +
>>  /**
>>   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
>>   * @dev: Device to handle.
>> @@ -1380,6 +1407,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
>>         /* Update time accounting before disabling PM-runtime. */
>>         update_pm_runtime_accounting(dev);
>>
>> +       /* Reset the next wakeup for the device */
>> +       dev->power.next_event = KTIME_MAX;
>> +
>
>I am not sure I get the purpose of this, can you elaborate?
>
I was trying to make sure that we clean up any next_events when we
disable runtime PM. But your following point negates the need.

>I am thinking that the genpd governor doesn't allow to power off of
>the PM domain, unless all devices that are attached to it are runtime
>PM enabled and runtime PM suspended (see pm_runtime_suspended). That
>said, it looks like the above isn't needed? No?
>
Makes sense.

>Perhaps it's better to use pm_runtime_enable() as the point of
>resetting the dev->power.next_event?
>
Okay.

Thanks,
Lina

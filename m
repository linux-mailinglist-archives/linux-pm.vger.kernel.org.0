Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFA3E2D34
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbhHFPH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 11:07:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60279 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbhHFPH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 11:07:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628262460; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=U2gWLih9uciIhm8iVL7BcWi6jOu2je6McpAae1wKTBU=;
 b=HqUSHAA3zOkf4Sgda3FEiygz/nGbcjdhqO4vvL5689WGxCkU4jedZfgLpPfgV2pnkCbzxAaF
 obc2zqFvwAzNp1xmbfxcbD9K1hO9HjV4A/nhPuaPnPP0rp2/Y6MLzWoSEmqTc0QO7kl/BYFF
 I3Es4eNWi8RQ/SRYyvm6RnsI3vo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 610d50201b76afb4467b0fa7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Aug 2021 15:07:12
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5C3EC433F1; Fri,  6 Aug 2021 15:07:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3BEDC433D3;
        Fri,  6 Aug 2021 15:07:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 06 Aug 2021 08:07:08 -0700
From:   psodagud@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: sleep: core: Avoid setting power.must_resume to false
In-Reply-To: <YQl6Bnjrnypbsz/s@kroah.com>
References: <1627313074-436260-1-git-send-email-psodagud@codeaurora.org>
 <YQl6Bnjrnypbsz/s@kroah.com>
Message-ID: <0fe9a873ca77293151a61f64d355895f@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-03 10:16, Greg KH wrote:
> On Mon, Jul 26, 2021 at 08:24:34AM -0700, Prasad Sodagudi wrote:
>> There are variables(power.may_skip_resume and dev->power.must_resume)
>> and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices 
>> after
>> a system wide suspend transition.
>> 
>> Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
>> its "noirq" and "early" resume callbacks to be skipped if the device
>> can be left in suspend after a system-wide transition into the working
>> state. PM core determines that the driver's "noirq" and "early" resume
>> callbacks should be skipped or not with dev_pm_skip_resume() function 
>> by
>> checking power.may_skip_resume variable.
>> 
>> power.must_resume variable is getting set to false in 
>> __device_suspend()
>> function without checking device's DPM_FLAG_MAY_SKIP_RESUME and
>> dev->power.usage_count variables. This is leading to failure to call
>> resume handler for some of the devices suspended in early suspend 
>> phase.
>> So check device's DPM_FLAG_MAY_SKIP_RESUME flag before
>> setting power.must_resume variable.
>> 
>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>> ---
>>  drivers/base/power/main.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index d568772..8eebc4d 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, 
>> pm_message_t state, bool async)
>>  	}
>> 
>>  	dev->power.may_skip_resume = true;
>> -	dev->power.must_resume = false;
>> +	if ((atomic_read(&dev->power.usage_count) <= 1) &&
>> +			(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
> 
> What is preventing that atomic value from changing _right_ after you
> just read this?
> 
> and very odd indentation, checkpatch didn't complain about this?
Sure. I will fix indentation problem once Rafael reviewed this patch.

> What commit does this fix?  Does it need to be backported to older
> kernels?

No. LTS - 5.4 do not have this problem.

> Wait, how is your "noirq" device even getting called here?  Shouldn't
> __device_suspend_noirq() be called instead?  Why isn't that the path 
> for
> your device?

Hi Gregh and Rafael,

This is regarding suspend/resume(s2idle) scenario of devices and 
differences between the LTS kernel 5.4 and 5.10 with respect to devices 
suspend and resume. Observing that devices suspended in suspend_late 
stage are not getting resumed in resume_early stage.
1)	LTS kernel 5.4 kernel do not have this problem but 5.10 kernel shows 
this problem.
2)	Commit - 6e176bf8d46194353163c2cb660808bc633b45d9 (PM: sleep: core: 
Do not skip callbacks in the resume phase) is skipping the driver 
early_resume callbacks.
@@ -804,15 +793,25 @@ static int device_resume_early(struct device *dev, 
pm_message_t state, bool asyn
         } else if (dev->bus && dev->bus->pm) {
                 info = "early bus ";
                 callback = pm_late_early_op(dev->bus->pm, state);
-       } else if (dev->driver && dev->driver->pm) {
+       }
+       if (callback)
+               goto Run;
+
+       if (dev_pm_may_skip_resume(dev))
+               goto Skip;
In device_resume_early function dev->power.must_resume is used to skip 
the resume call back. It looks this function is expecting that, 
__device_suspend_noirq() would set dev->power.must_resume = true for the 
devices which does not have DPM_FLAG_MAY_SKIP_RESUME flag set.

static int __device_suspend_noirq(struct device *dev, pm_message_t 
state, bool async)
{
…
…
         /*
          * Skipping the resume of devices that were in use right before 
the
          * system suspend (as indicated by their PM-runtime usage 
counters)
          * would be suboptimal.  Also resume them if doing that is not 
allowed
          * to be skipped.
          */
         if (atomic_read(&dev->power.usage_count) > 1 ||
             !(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
               dev->power.may_skip_resume))
                 dev->power.must_resume = true;


3)	Problematic scenario is as follows -  During the device 
suspend/resume scenario all the devices in  the suspend_late stage are 
successful and some device can fail to suspend in 
suspend_noirq(device_suspend_noirq-> __device_suspend_noirq) phase.
As a device failed in dpm_noirq_suspend_devices phase, dpm_resume_noirq 
is getting called to resume devices in dpm_late_early_list in the noirq 
phase.
4)	During the Devices_early_resume stage 
dpm_resume_early()-->device_resume_early() functions skipping the 
devices early resume callbacks.
  799         if (dev_pm_skip_resume(dev))
800	              goto Skip;

5)	Devices suspended in suspend_late stage are not getting resumed in 
Devices_early_resume stage because of Commit - 
6e176bf8d46194353163c2cb660808bc633b45d9 (PM: sleep: core: Do not skip 
callbacks in the resume phase) is skipping the driver early_resume 
callbacks when dev->power.must_resume is false.

6)	Below portion of the code in __device_suspend_noirq is not getting 
executed for some drivers successfully suspended in suspend_late stage 
and there is no chance to set must_resume to true.  So these devices are 
always having dev->power.must_resume=false.
For example -
i)	Devices A, B, C have suspend_late and resume_early handlers.
ii)	Devices X, Y, Z  have suspend_noirq and resume_noirq handlers.
Devices are getting suspended in this order – A, B, X , C , Y and Z and 
device X return failure for suspend_noirq callback. In this scenario, 
device C would never execute below portion of the code to set 
dev->power.must_resume = true and device – C would not get resumed in 
resume_early  stage.

1192 static int __device_suspend_noirq(struct device *dev, pm_message_t 
state, bool async)
1193 {
….
….
1245         /*
1246          * Skipping the resume of devices that were in use right 
before the
1247          * system suspend (as indicated by their PM-runtime usage 
counters)
1248          * would be suboptimal.  Also resume them if doing that is 
not allowed
1249          * to be skipped.
1250          */
1251         if (atomic_read(&dev->power.usage_count) > 1 ||
1252             !(dev_pm_test_driver_flags(dev, 
DPM_FLAG_MAY_SKIP_RESUME) &&
1253               dev->power.may_skip_resume))
1254                 dev->power.must_resume = true;
1255
1256         if (dev->power.must_resume)
1257                 dpm_superior_set_must_resume(dev);
1258

> thanks,
> 
> greg k-h

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA623F4B54
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhHWNGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 09:06:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24864 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237164AbhHWNGX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 09:06:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629723941; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=E/fEWaEX6Seb48cm6rL3CGJPlVqJg5lWlfTNvs0q/oI=;
 b=FtVZl9AzBxe5P+QdKTK+e4APtJaeJdoSHVSiz1NvzLhJuQP3Gkq6RSHr2dAxeGX1WAU0TXiI
 0pfNRnn88yh9qubCq4QfScqZxT+IrhnMvQ8QAzSASKNUq+eyo88VaDiJtgosrLql6vX1g5bu
 82g9GLS3yuij1YLIgn/lJ4XlHFk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61239cb00f9b337f11b9693c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Aug 2021 13:03:44
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D93AC43460; Mon, 23 Aug 2021 13:03:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7520EC4338F;
        Mon, 23 Aug 2021 13:03:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Aug 2021 06:03:41 -0700
From:   psodagud@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz
Subject: Re: [PATCH v3] PM: sleep: core: Avoid setting power.must_resume to
 false
In-Reply-To: <YRYd+dSdWa7Mr+n9@kroah.com>
References: <1628625938-149376-1-git-send-email-psodagud@codeaurora.org>
 <YRYd+dSdWa7Mr+n9@kroah.com>
Message-ID: <6cc2d5677d246352e13b766d4fbef6af@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-13 00:23, Greg KH wrote:
> On Tue, Aug 10, 2021 at 01:05:38PM -0700, Prasad Sodagudi wrote:
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
>> dev->power.usage_count variables. In problematic scenario, where
>> all the devices in the suspend_late stage are successful and some
>> device can fail to suspend in suspend_noirq phase. So some devices
>> successfully suspended in suspend_late stage are not getting chance
>> to execute __device_suspend_noirq() to set dev->power.must_resume
>> variable to true and not getting resumed in early_resume phase.
>> 
>> Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
>> setting power.must_resume variable in __device_suspend function.
>> 
>> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the 
>> resume phase")
>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>> ---
>>  V2 -> V3: Format issues patch posting
>>  V1 -> V2: Fixed indentation and commit text to include scenario
>>  drivers/base/power/main.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index d568772..9ee6987 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, 
>> pm_message_t state, bool async)
>>  	}
>> 
>>  	dev->power.may_skip_resume = true;
>> -	dev->power.must_resume = false;
>> +	if ((atomic_read(&dev->power.usage_count) <= 1) &&
>> +	     (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
>> +		dev->power.must_resume = false;
>> +	else
>> +		dev->power.must_resume = true;
> 
> Again, what happens if the usage_count changes right after reading the
> value?  What protects that from happening?

Hi Gregh KH,
Yes. you are right.  I think, relying on  the usage_count at the  
__device_suspend stage may not be correct.
Devices IRQs are still enabled and usage_count can be changed even after 
reading.
I will send next patchset without power.usage_count check.

@@ -1649,7 +1651,10 @@ static int __device_suspend(struct device *dev, 
pm_message_t state, bool async)
         }

         dev->power.may_skip_resume = true;
-       dev->power.must_resume = false;
+       if (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME))
+               dev->power.must_resume = false;
+       else
+               dev->power.must_resume = true;


> 
> thanks,
> 
> greg k-h

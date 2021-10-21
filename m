Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB84436645
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJUPct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 11:32:49 -0400
Received: from foss.arm.com ([217.140.110.172]:44314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbhJUPcs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Oct 2021 11:32:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B57D6E;
        Thu, 21 Oct 2021 08:30:32 -0700 (PDT)
Received: from [10.57.21.86] (unknown [10.57.21.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21CC43F694;
        Thu, 21 Oct 2021 08:30:30 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] thermal/core: Make the userspace governor
 deprecated
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
 <6372f16d-7d2d-cb1e-be86-23b21b41816b@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <942b9998-9858-7776-97b7-b5ac1c637a2e@arm.com>
Date:   Thu, 21 Oct 2021 16:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6372f16d-7d2d-cb1e-be86-23b21b41816b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,


On 10/20/21 11:47 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> Do you agree with these changes ?

Yes, I agree with these changes.

> 
> On 19/10/2021 18:35, Daniel Lezcano wrote:
>> The userspace governor is sending temperature when polling is active
>> and trip point crossed events. Nothing else.
>>
>> AFAICT, this governor is used with custom kernels making the userspace
>> governor co-existing with another governor on the same thermal zone
>> because there was no notification mechanism, implying a hack in the
>> framework to support this configuration.
>>
>> The new netlink thermal notification is able to provide more
>> information than the userspace governor and give the opportunity to
>> the users of this governor to replace it by a dedicated notification
>> framework.
>>
>> The userspace governor will be removed as its usage is no longer
>> needed.
>>
>> Add a warning message to tell the userspace governor is deprecated.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/thermal/gov_user_space.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
>> index 82a7198bbe71..f4fe050e1cbc 100644
>> --- a/drivers/thermal/gov_user_space.c
>> +++ b/drivers/thermal/gov_user_space.c
>> @@ -15,6 +15,14 @@
>>   
>>   #include "thermal_core.h"
>>   
>> +static int user_space_bind(struct thermal_zone_device *tz)
>> +{
>> +	pr_warn("Userspace governor deprecated: use thermal netlink "	\
>> +		"notification instead\n");
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * notify_user_space - Notifies user space about thermal events
>>    * @tz: thermal_zone_device
>> @@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
>>   static struct thermal_governor thermal_gov_user_space = {
>>   	.name		= "user_space",
>>   	.throttle	= notify_user_space,
>> +	.bind_to_tz	= user_space_bind,
>>   };
>>   THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
>>
> 
> 


You can add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC86368601
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDVRdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 13:33:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236660AbhDVRdj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 13:33:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11ED31063;
        Thu, 22 Apr 2021 10:33:04 -0700 (PDT)
Received: from [10.57.27.187] (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A919B3F694;
        Thu, 22 Apr 2021 10:33:02 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Improve IPA mechanisms in low temperature state
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210422114308.29684-1-lukasz.luba@arm.com>
 <423f5f3a-aa3c-dbcd-6783-3bfe04f9781f@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <00e2b778-c00e-a0ba-cff4-e3be16d37805@arm.com>
Date:   Thu, 22 Apr 2021 18:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <423f5f3a-aa3c-dbcd-6783-3bfe04f9781f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/22/21 6:30 PM, Daniel Lezcano wrote:
> On 22/04/2021 13:43, Lukasz Luba wrote:
>> Hi all,
>>
>> This v4 patch set aims to address the issues present in IPA when the
>> temperature is below the first trip point and cooling devices are not
>> throttled.
>> The last patch 1/3 is co-developed by Daniel, who presented the code
>> during v2 review. I have created a helper function based on his idea,
>> which can now be used inside IPA governor lock protected code.
>> The patch 2/3 adds a basic check of cooling devices power to keep the
>> internal statistics fresh. This allows to avoid issue when the statistics
>> cover very long period, because they were not maintained.
>> The patch 3/3 addresses an issue described in bugzilla [1], which is:
>> unnecessary updating cooling devices when their state has not changed
>> because they are not throttled. This update triggers sending an event,
>> which should be avoided. Thus, patch 2/3 adds a tracking mechanism if
>> the update was triggered and makes sure it will be done only once when
>> the temperature continue to stay below first trip point.
>>
>> changelog:
>> v4:
>> - reordered the patches, patch 3/3 from v3 is now 1/3
>> v3:
>> - new patch 3/3 co-developed with Daniel
>> v2:
>> - patch 2/2 uses now simple 'update' bool flag and information from
>>    'tz->last_temperature'
>> - patch 1/2 has small change in the comment
>> - re-based on top of today's thermal/next branch
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=212501
>>
>> Lukasz Luba (3):
>>    thermal: create a helper __thermal_cdev_update() without a lock
>>    thermal: power_allocator: maintain the device statistics from going
>>      stale
>>    thermal: power_allocator: update once cooling devices when temp is low
>>
>>   drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++----
>>   drivers/thermal/thermal_core.h        |  1 +
>>   drivers/thermal/thermal_helpers.c     | 27 +++++++++++++++++----------
>>   3 files changed, 35 insertions(+), 14 deletions(-)
> 
> Applied, thanks
> 
> 

Thank you Daniel!

Regards,
Lukasz

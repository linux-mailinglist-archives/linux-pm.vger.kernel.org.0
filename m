Return-Path: <linux-pm+bounces-1437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049681A4E8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B06128A1AF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CF40BF5;
	Wed, 20 Dec 2023 16:22:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85946432;
	Wed, 20 Dec 2023 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 898C31FB;
	Wed, 20 Dec 2023 08:23:37 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C19F93F64C;
	Wed, 20 Dec 2023 08:22:51 -0800 (PST)
Message-ID: <65b879ad-aff2-4f7e-bad1-ac85dc5fd146@arm.com>
Date: Wed, 20 Dec 2023 16:23:59 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] thermal/sysfs: Update instance->weight under tz
 lock
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
 <20231212134844.1213381-7-lukasz.luba@arm.com>
 <CAJZ5v0hes13rmAgcyMYtz1ZXxV72pM3QgRY=LKF9jK=GbAyS=g@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hes13rmAgcyMYtz1ZXxV72pM3QgRY=LKF9jK=GbAyS=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 14:53, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The user-space can change thermal instance weight value while the
>> throtte() callback is running for a governor.
> 
> This needs to be more precise IMV.  Something like
> 
> "User space can change the weight of a thermal instance via sysfs
> while the .throttle() callback is running for a governor, because
> weight_store() does not use the zone lock."

Agree, I'll use it.

> 
>> The IPA governor uses the
>> 'weight' value for power calculation and also keeps it in 'total_weight'.
>> Therefore, the 'weight' value must not change during the throttle()
>> callback. Use 'tz->lock' mutex which also guards the throttle() to make
>> the update value safe.
> 
> "The IPA governor uses instance weight values for power calculations
> and caches the sum of them as total_weight, so it gets confused when
> one of them changes while its .throttle() callback is running.
> 
> To prevent that from happening, use thermal zone locking in weight_store()."

Agree, thanks.

> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/thermal_sysfs.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
>> index eef40d4f3063..df85df7d4a88 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -961,6 +961,7 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
>>                       const char *buf, size_t count)
>>   {
>>          struct thermal_instance *instance;
>> +       struct thermal_zone_device *tz;
> 
> IMO the local var doesn't help much.  You may as well use
> instance->tz->lock directly below.

OK, I'll change that.

> 
>>          int ret, weight;
>>
>>          ret = kstrtoint(buf, 0, &weight);
>> @@ -968,7 +969,12 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
>>                  return ret;
>>
>>          instance = container_of(attr, struct thermal_instance, weight_attr);
>> +       tz = instance->tz;
>> +
>> +       /* Don't race with governors using the 'weight' value */
>> +       mutex_lock(&tz->lock);
>>          instance->weight = weight;
>> +       mutex_unlock(&tz->lock);
>>
>>          return count;
>>   }
>> --


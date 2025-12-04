Return-Path: <linux-pm+bounces-39184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89ECA2D0F
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45FB03011F8E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61D32824F;
	Thu,  4 Dec 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iSRNmd3z"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77DC2D7DC4;
	Thu,  4 Dec 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836953; cv=none; b=mTJJzhVzEYJRMfCtyIa2m9bC1s3y6ePQRv07wH6oeq58k50J+DlR7G60iF/5I0v4FA1jTV9bvUfkl5N/CQcsUu9zX1udiSGcfFlawXZvMuksgd8hqDfzuQWbvTewzqVEtz8vmP7PdVUK2Mt5jbkhYhhcGuPfhvOMoL/t3jb+khw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836953; c=relaxed/simple;
	bh=YlYaD3JY+Su/GL5w1//2E/dkDO9Fa7gMh/7bLXL54cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Js3F/N5AypLUAXj+qSfk2D8nkhvocq8abjRo+xgk8EETrecT4f/1al8ozJ3r4gbsLoRfohxcrhcnfr4kG3UKXqge6F0owgdNrtW/Vri0T2UlE/qfFlDXikMd0RXebYktMMFjtOubB+159zXCcrosRRCaHOHpcNQgTPm3/xd/MOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iSRNmd3z; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ytDFUtBfANqvTOMX6sH7XhDaSq8++09CEdRrXoQRHA0=;
	b=iSRNmd3z7BK0GitioKVke08Ff9gHjhCLUFDoErwP5kKHF6bu4zk/dsg+829ZaKVEOxuFRuOta
	mAgtEYnreEeI1s5/qXpTXh3WALGSBWMYpGndj07hiC24dnfQdXJvo+fxYRhpKsdRfOugx2H7Dny
	rwRPhoDFPbdoOS0bSL60y5g=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dMSKx2H4RzLlTc;
	Thu,  4 Dec 2025 16:27:17 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B48B8140278;
	Thu,  4 Dec 2025 16:29:09 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:29:09 +0800
Message-ID: <1402fe0a-13ff-4e6c-bcea-660acb383177@huawei.com>
Date: Thu, 4 Dec 2025 16:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: Jie Zhan <zhanjie9@hisilicon.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20251107031706.1698396-1-zhangpengjie2@huawei.com>
 <1f89f5f1-8743-4902-b103-66287a33c5ba@hisilicon.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <1f89f5f1-8743-4902-b103-66287a33c5ba@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)

hello，Jie

On 12/4/2025 3:36 PM, Jie Zhan wrote:
> On 11/7/2025 11:17 AM, Pengjie Zhang wrote:
>> Previously, non-generic attributes (polling_interval, timer) used separate
>> create/delete logic, leading to race conditions during concurrent access in
>> creation/deletion. Multi-threaded operations also caused inconsistencies
>> between governor capabilities and attribute states.
>>                                                                             
>> 1.Use is_visible + sysfs_update_group() to unify management of these
>> attributes, eliminating creation/deletion races.
>> 2.Add locks and validation to these attributes, ensuring consistency
>> between current governor capabilities and attribute operations in
>> multi-threaded environments.
>>                                                                             
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> Hi Pengjie,
>
> The motivation looks fine but the implementation of gov_group_visible() and
> gov_attr_visible() doesn't work right in my view.
>
> See comments below.
>
> Thanks!
> Jie
>>   /*
>>    * devfreq core provides delayed work based load monitoring helper
>> @@ -785,11 +786,6 @@ static void devfreq_dev_release(struct device *dev)
>>   	kfree(devfreq);
>>   }
>>   
>>   
>>   static ssize_t polling_interval_show(struct device *dev,
>>   				     struct device_attribute *attr, char *buf)
>>   {
>>   	struct devfreq *df = to_devfreq(dev);
>> +	int ret;
> No need of this if restore the last line.
>>   
>> -	if (!df->profile)
>> +	guard(mutex)(&devfreq_list_lock);
>> +
>> +	if (!df->profile || !df->governor ||
>> +	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>>   		return -EINVAL;
>>   
>> -	return sprintf(buf, "%d\n", df->profile->polling_ms);
> It's fine to keep this line.
>> +	ret = sprintf(buf, "%d\n", df->profile->polling_ms);
>> +
>> +	return ret;
>>   }
>>   
>>
>>   
>> -/* Create the specific sysfs files which depend on each governor. */
>> -static void create_sysfs_files(struct devfreq *devfreq,
>> -				const struct devfreq_governor *gov)
>> +static umode_t gov_attr_visible(struct kobject *kobj,
>> +				struct attribute *attr, int n)
>>   {
>> -	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
>> -		CREATE_SYSFS_FILE(devfreq, polling_interval);
>> -	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
>> -		CREATE_SYSFS_FILE(devfreq, timer);
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct devfreq *df = to_devfreq(dev);
>> +
>> +	if (!df->governor || !df->governor->attrs)
>> +		return 0;
>> +
>> +	if (IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>> +		return attr->mode;
>> +	if (IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>> +		return attr->mode;
> This would expose both 'timer' and 'polling_interval' if either of them is
> supported, which is wrong.

ok，i see，may be

     if (attr == &dev_attr_polling_interval.attr) {
         if (IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
             return attr->mode;
         return 0;
     }

     if (attr == &dev_attr_timer.attr) {
         if (IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
             return attr->mode;
         return 0;
     }

>> +
>> +	return 0;
>>   }
>>   
>> -/* Remove the specific sysfs files which depend on each governor. */
>> -static void remove_sysfs_files(struct devfreq *devfreq,
>> -				const struct devfreq_governor *gov)
>> +static bool gov_group_visible(struct kobject *kobj)
>>   {
>> -	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
>> -		sysfs_remove_file(&devfreq->dev.kobj,
>> -				&dev_attr_polling_interval.attr);
>> -	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
>> -		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
>> +	struct device *dev = kobj_to_dev(kobj);
>> +
>> +	if (!dev)
>> +		return false;
> kobj_to_dev(kobj) can't fail.  This check is unnecessary.
>> +
>> +	return true;
>>   }
>> +DEFINE_SYSFS_GROUP_VISIBLE(gov);
> The implementation of gov_group_visible() and gov_attr_visible() doesn't
> seem to comply with the design of DEFINE_SYSFS_GROUP_VISIBLE().
>
> DEFINE_SYSFS_GROUP_VISIBLE is defined as:
>
> #define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
>          static inline umode_t sysfs_group_visible_##name(            \
>                  struct kobject *kobj, struct attribute *attr, int n) \
>          {                                                            \
>                  if (n == 0 && !name##_group_visible(kobj))           \
>                          return SYSFS_GROUP_INVISIBLE;                \
>                  return name##_attr_visible(kobj, attr, n);           \
>          }
>
> That means:
> _group_visible controls whether to hide all the attrs in this group;
> _attr_visible further decides whether to show each attr.
>
> Hence,
> 1. gov_group_visible() should check if any attr in 'governor_attrs' should
> be present, i.e. checking df->governor->attrs.
> 2. gov_attr_visible identifies which attr it is and checks whether the
> governor supports it.
>
> Neither is done in the above code, so this should be updated.

we can move the check|if (!df->governor || !df->governor->attrs)|

from|gov_attr_visible|to|gov_group_visible|.

thanks !



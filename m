Return-Path: <linux-pm+bounces-39186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C03CA2D92
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36EB9301CD9B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173B32694E;
	Thu,  4 Dec 2025 08:41:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986618C332;
	Thu,  4 Dec 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837679; cv=none; b=Eq3p10Gfeg5HdYA+7mCtUgTBxtH/kcnpRjsTtPSQwhbiD9EB27UBEjntPLRJoOigXCy7pNmEiHufMydTgOfgaNqEZ+nwmESqa5fjVJVvjck/lOvpcFEjXc3/O7He298RGtrzEyTrU3kgvVUmEv9JLCgGhCtctebEOBY3TdPqEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837679; c=relaxed/simple;
	bh=yR/qIJLgZzHQQ4hg+mPkserLAHOn/bILJyZP8Fzklsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9O1SuPt0wmzgHL7VWFFgghw7ePYh5+8DsIII0DJQNXTglLilH9jrJmpH/igSh2msurroCS7KUMHKsLDESEi96+gJTzwdquuwOa3FcjH/xLez6NX24kY5nYRSDfLgMIEE00a87kloLe3YzUywQYXPrkDr6Ip/QrDpyA43Kzk6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dMSbq43SMz1cySR;
	Thu,  4 Dec 2025 16:39:19 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id A67AE18001B;
	Thu,  4 Dec 2025 16:41:12 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:41:11 +0800
Message-ID: <07c098d7-979b-44b5-aae0-7999581d8d90@hisilicon.com>
Date: Thu, 4 Dec 2025 16:41:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20251107031706.1698396-1-zhangpengjie2@huawei.com>
 <1f89f5f1-8743-4902-b103-66287a33c5ba@hisilicon.com>
 <1402fe0a-13ff-4e6c-bcea-660acb383177@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <1402fe0a-13ff-4e6c-bcea-660acb383177@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



...

>>> +static umode_t gov_attr_visible(struct kobject *kobj,
>>> +                struct attribute *attr, int n)
>>>   {
>>> -    if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
>>> -        CREATE_SYSFS_FILE(devfreq, polling_interval);
>>> -    if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
>>> -        CREATE_SYSFS_FILE(devfreq, timer);
>>> +    struct device *dev = kobj_to_dev(kobj);
>>> +    struct devfreq *df = to_devfreq(dev);
>>> +
>>> +    if (!df->governor || !df->governor->attrs)
>>> +        return 0;
>>> +
>>> +    if (IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>>> +        return attr->mode;
>>> +    if (IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>>> +        return attr->mode;
>> This would expose both 'timer' and 'polling_interval' if either of them is
>> supported, which is wrong.
> 
> ok，i see，may be
> 
>     if (attr == &dev_attr_polling_interval.attr) {
>         if (IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
>             return attr->mode;
>         return 0;
>     }
> 
>     if (attr == &dev_attr_timer.attr) {
>         if (IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
>             return attr->mode;
>         return 0;
>     }
> 
Yeah.

Could be cleaner like:
	if (attr == &dev_attr_polling_interval.attr &&
	    IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
		return attr->mode;

	if (attr == &dev_attr_timer.attr &&
	    IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
		return attr->mode;

	return 0;
}
>>> +
>>> +    return 0;
>>>   }
>>>   -/* Remove the specific sysfs files which depend on each governor. */
>>> -static void remove_sysfs_files(struct devfreq *devfreq,
>>> -                const struct devfreq_governor *gov)
>>> +static bool gov_group_visible(struct kobject *kobj)
>>>   {
>>> -    if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
>>> -        sysfs_remove_file(&devfreq->dev.kobj,
>>> -                &dev_attr_polling_interval.attr);
>>> -    if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
>>> -        sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
>>> +    struct device *dev = kobj_to_dev(kobj);
>>> +
>>> +    if (!dev)
>>> +        return false;
>> kobj_to_dev(kobj) can't fail.  This check is unnecessary.
>>> +
>>> +    return true;
>>>   }
>>> +DEFINE_SYSFS_GROUP_VISIBLE(gov);
>> The implementation of gov_group_visible() and gov_attr_visible() doesn't
>> seem to comply with the design of DEFINE_SYSFS_GROUP_VISIBLE().
>>
>> DEFINE_SYSFS_GROUP_VISIBLE is defined as:
>>
>> #define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
>>          static inline umode_t sysfs_group_visible_##name(            \
>>                  struct kobject *kobj, struct attribute *attr, int n) \
>>          {                                                            \
>>                  if (n == 0 && !name##_group_visible(kobj))           \
>>                          return SYSFS_GROUP_INVISIBLE;                \
>>                  return name##_attr_visible(kobj, attr, n);           \
>>          }
>>
>> That means:
>> _group_visible controls whether to hide all the attrs in this group;
>> _attr_visible further decides whether to show each attr.
>>
>> Hence,
>> 1. gov_group_visible() should check if any attr in 'governor_attrs' should
>> be present, i.e. checking df->governor->attrs.
>> 2. gov_attr_visible identifies which attr it is and checks whether the
>> governor supports it.
>>
>> Neither is done in the above code, so this should be updated.
> 
> we can move the check|if (!df->governor || !df->governor->attrs)|
> 
> from|gov_attr_visible|to|gov_group_visible|.
Exactly.
> 
> thanks !
> 


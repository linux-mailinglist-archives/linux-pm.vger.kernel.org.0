Return-Path: <linux-pm+bounces-37282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F5C29DC5
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 03:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8233B0173
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E927FB10;
	Mon,  3 Nov 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KJXbNtmb"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A732158DA3;
	Mon,  3 Nov 2025 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136960; cv=none; b=A9GUmP5cG3lk2PCJCvLGhlEGZ7OlWL4DPS8AnY+BWrnlrwIbOjhiGbolON9gmJEMkwRBl0mAKAHSXaTI5IrP7QdZrkgw+YBsyS3DufJSqDPrMTEBAWbC7aQLqDMrheatAreMCNK9VWjPPKHp/M9YfWCfEQkpKf33WLZ4EkB5zG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136960; c=relaxed/simple;
	bh=fJ2ruscm7I3Xohe37RN2AI4TRhVZHxRLydfYSkkz3u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TFnPYZtoIBh3JLO43M/zCnutJF2dzXS6XyK4rBHGF4I2skQZVXSaitQ7JVctMyajJ2/6A5jmjjsZqWwbuP7gw9tqos8zcmZHlAWKKs7Hdv8aTcTASlANFA6QK34Ao3HDhTAjZ7SL/uUhT3/YtjbTqN8IhRsyYEPiAXskh2pgHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KJXbNtmb; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2FIFKl4Ynnc+iqkNHSte7fiKEcb41ATkE5hAwgWBU9A=;
	b=KJXbNtmb56EtHFpnd5u341hyFmFf3AMfX8FWvhZ6DKQI4lkRoEhXy2iV+lVAvWlGTY7U1aC1K
	OZQlloeezykOpQ7kvHK4JwWmEyFgK75WCaBtc0JscJhCECeI/Hpxk6eOpS4SPuyygqA/Yl9XPxo
	LZ03V7dYAZem0Jfp59MqJ8s=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d0FqR4X1WzpSt8;
	Mon,  3 Nov 2025 10:27:47 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D1FB180B62;
	Mon,  3 Nov 2025 10:29:14 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 10:29:13 +0800
Message-ID: <68936aeb-20d7-429c-af5a-590b765f7351@huawei.com>
Date: Mon, 3 Nov 2025 10:29:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM / devfreq: use _visible attribute to replace
 create/remove_sysfs_files()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>
References: <20251028022458.2824872-1-zhangpengjie2@huawei.com>
 <20251031144157.00000e51@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20251031144157.00000e51@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)

On 10/31/2025 10:41 PM, Jonathan Cameron wrote:
> On Tue, 28 Oct 2025 10:24:58 +0800
> Pengjie Zhang <zhangpengjie2@huawei.com> wrote:
>
>>   static ssize_t polling_interval_store(struct device *dev,
>> @@ -1828,15 +1831,22 @@ static ssize_t polling_interval_store(struct device *dev,
>>   	unsigned int value;
>>   	int ret;
>>   
>> -	if (!df->governor)
>> +	mutex_lock(&devfreq_list_lock);
> As below I'd use guard() to simplify this.  Applies in various other places in this
> patch.
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
>> +	struct devfreq *df;
>> +
>> +	if (!dev)
>> +		return false;
>> +
>> +	df = to_devfreq(dev);
>> +	if (!df)
>> +		return false;
> Isn't to_devfreq() just a container_of() wrapper?
> If that's the case it will always be there if dev is not NULL.
>
> As such I not seeing how this group is likely to ever be
> invisible.
>
Thank you for your review and comments.  I will address all your feedback

in the necessary revisions and submit the third version shortly.

Best regards,

Pengjie Zhang



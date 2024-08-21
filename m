Return-Path: <linux-pm+bounces-12632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2197959A76
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A5F1C22530
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7211BFDF3;
	Wed, 21 Aug 2024 11:23:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258231B1D59;
	Wed, 21 Aug 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239383; cv=none; b=ZjD2H0OHkbSkuqCZg7pJgle6sMRivU4huYLa3MSA+hB44wFSRwA+hDgQHWF//nsy0cPtG/ZnDM4LpjLeC/EdD0dOqopeniwXJc7zgB2azoPdZUN3tUh4RTEhv0g7Jq560F7zrSfVRlpOkCQ+ZzOZWvPkePrSsj6mW+tuxuQrIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239383; c=relaxed/simple;
	bh=Hdmp5u6r2ZCBG5/1/JMr2LDYkecTKqDHT17FSeTqD0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=blSmfGYJO3a+z0qfl3+IQKxWZBHutdKSOcnJHPxqD5MlRLlxk3KMNvajTrdB61dSkXYuyDSd8KFBy2jCSI0s9KO7e2vkL6+3F9NUBs6g6HNth3IfkgbiP5ONzx3n89pewWp1ikkXLC2aq9Sb1AAx/6uBgtus6vtO4t5HvNaRXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WpkTS68F5z1S8Pn;
	Wed, 21 Aug 2024 19:22:52 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id C016F1400C9;
	Wed, 21 Aug 2024 19:22:55 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 19:22:55 +0800
Message-ID: <c54858ed-e263-fe80-96aa-9ac8b6f85b1c@huawei.com>
Date: Wed, 21 Aug 2024 19:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3324214.44csPzL39Z@rjwysocki.net>
 <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
 <66bb19a0-00ba-40a5-91ef-73368659b30a@linaro.org>
 <8744a789-0424-0cc6-7cb1-b7c9b17f56cc@huawei.com>
 <c90b53af-1641-4c8a-97d9-27feed7b2a7d@linaro.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <c90b53af-1641-4c8a-97d9-27feed7b2a7d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/21 18:49, Daniel Lezcano 写道:
> On 21/08/2024 11:44, lihuisong (C) wrote:
>>
>> 在 2024/8/21 17:28, Daniel Lezcano 写道:
>>> On 21/08/2024 10:49, lihuisong (C) wrote:
>>>
>>> [ ... ]
>>>
>>>>> -    list_for_each_entry(pos2, &thermal_cdev_list, node) {
>>>>> -        if (pos2 == cdev)
>>>>> -            break;
>>>>> -    }
>>>>> +    lockdep_assert_held(&thermal_list_lock);
>>>>> -    if (tz != pos1 || cdev != pos2)
>>>>> +    if (list_empty(&tz->node) || list_empty(&cdev->node))
>>>> The old verification is ensure that tz and cdev already add to 
>>>> thermal_tz_list and thermal_cdev_list，respectively.
>>>> Namely, tz and cdev are definitely registered and intialized.
>>>> The check is ok for all untizalized thermal_zone_device and cooling 
>>>> device.
>>>> But the new verification doesn't seem to do that.
>>>
>>> If the tz or the cdev are registered then their "->node" is not 
>>> empty because they are linked with the thermal_list and cdev_list
>>>
>>> So either way is browsing the lists to find the tz/cdev or just 
>>> check "->node" is not empty. The latter the faster.
>> Assume that tz/cdev isn't intiazlized and registered to 
>> thermal_tz_list or thermal_cdev_list. And then directly call this 
>> interface.
>
> Then there is a bug in the internal code because the 
> thermal_zone_device_register*() and cooling_device_device_register() 
> allocate and initialize those structures.
>
> The caller of the function is supposed to use the API provided by the 
> thermal framework. It is not possible to plan every stupid things a 
> driver can do. In this particular case, very likely the kernel will 
> crash immediately which is a sufficient test for me and coercive 
> enough to have the API user to put its code in question ;)

A good point. Agree.



Return-Path: <linux-pm+bounces-29261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE3AE38D1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 10:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739F3172174
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC32217660;
	Mon, 23 Jun 2025 08:45:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC52A1D8
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668337; cv=none; b=tCLhPEKeOk0tAePp0aFPO7v5ODS6pixFkTbe5bNi0Sm1NUJ66JJnd1hV/6z0xBL2HX01Hcpn2bPP6+1BCvWXu7JA8uAooKRW0/DL7F4GaPyA70Ip0y169yGt0CoQVTDqrQzwvw/Y6C174Dheu4aNLpRunNXqKERhpYLhbcIWw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668337; c=relaxed/simple;
	bh=8LzrUZpO7Nu5m/AopRbqdpcppf7Fj9oO71RyUkhfrdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FC4CuNT51FIT5zOdOTKQhO2lHMyV+BpeTb/DFOBavFKY1Rw5H5Qw99KRU1MRtXklJLt6gym4iU3+kdS5gZ/LaxmtVjT8BW2Pnau2mfh+SfseGoKWXWiHyFv9BsSOAbMgli05qtxncNaSLBynb+0XUv7SZiO9+/KDs5v1rQgGl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bQhRr2l9Dz28fQJ;
	Mon, 23 Jun 2025 16:43:04 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 55DD2140276;
	Mon, 23 Jun 2025 16:45:31 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 16:45:30 +0800
Message-ID: <c7222b9c-316a-d6a9-efd0-49de136f2fbd@hisilicon.com>
Date: Mon, 23 Jun 2025 16:45:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 0/2] PM / devfreq: Add HiSilicon uncore frequency
 scaling driver
To: "lihuisong (C)" <lihuisong@huawei.com>, <cw00.choi@samsung.com>,
	<myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<jonathan.cameron@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20250619151456.3328624-1-zhanjie9@hisilicon.com>
 <508bdca6-eab8-4661-a8e8-560b1ef0a325@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <508bdca6-eab8-4661-a8e8-560b1ef0a325@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 23/06/2025 11:39, lihuisong (C) wrote:
> LGTM, for series,
> Reviewed-by: lihuisong@huawei.com
> 

Huisong, thanks for reviewing!
> 
> 在 2025/6/19 23:14, Jie Zhan 写道:
>> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
>> the devfreq framework.  The uncore domain contains shared computing
>> resources, including system interconnects and L3 cache.  The uncore
>> frequency significantly impacts the system-wide performance as well as
>> power consumption.  This driver adds support for runtime management of
>> uncore frequency from kernel and userspace.  The main function includes
>> setting and getting frequencies, changing frequency scaling policies, and
>> querying the list of CPUs whose performance is significantly related to
>> this uncore frequency domain, etc.  The driver communicates with a platform
>> controller through an ACPI PCC mailbox to take the actual actions of
>> frequency scaling.
>>
>> Changelog:
>>
>> v5:
>> - Comment more on error code related stuff about
>>    hisi_uncore_mark_related_cpus(), and return failure early on errors
>>    except for -EINVAL, which indicates possibly broken firmware.
>> - Separate error prints apart for two cases in hisi_platform_gov_handler()
>> - Make the 'related_cpus' sysfs ABI description more generic
>> - Some coding style cleanups and typo fixes
>>
>> v4:
>> https://lore.kernel.org/linux-pm/20250530081722.280776-1-zhanjie9@hisilicon.com/
>> - Allow devfreq core to accept device-specific sysfs ABIs
>> - Replace custom sysfs attrs with dev_groups and let the devfreq core
>>    manage it
>> - Update 'related_cpus' description in the devfreq ABI doc
>> - Remove COMPILE_TEST in Kconfig as the mailbox_client.h doesn't support
>>    this yet
>> - Replace dev_err() with dev_err_probe() during drv->probe()
>> - Replace mutex_init() with devm_mutex_init() to warn on UAF
>> - Replace uncore->dev with dev in some places to make code a bit shorter
>> - Remove redundant uncore->pchan check in hisi_uncore_free_pcc_chan()
>> - Use __free() to let compiler release temporary memory
>> - Clean up the error handling and redundant 'status = 0' in
>>    hisi_uncore_send_cmd()
>> - Some coding style cleanup
>>
>> v3:
>> https://lore.kernel.org/linux-pm/20250522031701.1912458-1-zhanjie9@hisilicon.com/
>> - Remove redundant resource freeing processes when drv->probe() fails as
>>    they're already handled by devm
>>
>> v2:
>> https://lore.kernel.org/linux-pm/20250520074120.4187096-1-zhanjie9@hisilicon.com/
>> - Make devm manage the release sequence, remove drv->remove()
>> - Warn on !uncore or !uncore->pchan as they're no longer expected
>> - Remove ioremap of pcc shared memory because it's done by the pcc driver
>> - Fix compiler warning of discarding 'const'
>> - Minor trivial coding style changes
>>
>> v1:
>> https://lore.kernel.org/linux-pm/20250506021434.944386-1-zhanjie9@hisilicon.com/
>>
>> Jie Zhan (2):
>>    PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
>>    PM / devfreq: Add HiSilicon uncore frequency scaling driver
>>
>>   Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>>   drivers/devfreq/Kconfig                       |  11 +
>>   drivers/devfreq/Makefile                      |   1 +
>>   drivers/devfreq/devfreq.c                     |   1 +
>>   drivers/devfreq/hisi_uncore_freq.c            | 664 ++++++++++++++++++
>>   include/linux/devfreq.h                       |   4 +
>>   6 files changed, 690 insertions(+)
>>   create mode 100644 drivers/devfreq/hisi_uncore_freq.c
>>


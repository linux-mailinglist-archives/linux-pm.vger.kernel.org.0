Return-Path: <linux-pm+bounces-29949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC627AF09AE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 06:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85FF3AC871
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 04:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E3137923;
	Wed,  2 Jul 2025 04:16:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E410F9
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429806; cv=none; b=Z1n06QJdeV3JeclmQO+C2QWeANB0KXX05EKn3ORsJAhW/kxl0ZUhhD7CbStiopb2EHcdjE1OnsdDIepp82s+D646zzuAVgXOonXfo/Fc8xETRAEYRCd/tJhfkOZcKjruDfCh+qJua4UFX/4nTSh9Ej3s2nIBZgdKxbkqOWEcSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429806; c=relaxed/simple;
	bh=2BSEqDhqjameDmbndFVKYM+5w5Ke+tlE8kaq0+VdzHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q9i3dFYe3jhUYssuoVFaFS3XOzwwylPgKx7sjn9oeV4kCYp4EEZV4QKTYY2H1klGmUp/sOZG/XB0nP4j1UcZOesfaIUyF9ihna9iTEC+675rm4CuzGqyuEZfLvw/dN9FAjgFE0B+D1lnEIjVTkXC7cRDsPPzUQzVVLc37QY1zXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bX63J38RBz1d1q9;
	Wed,  2 Jul 2025 12:14:04 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id B9A87180064;
	Wed,  2 Jul 2025 12:16:33 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Jul
 2025 12:16:32 +0800
Message-ID: <fd16c235-b6be-7334-4a34-38b62e7b5cc9@hisilicon.com>
Date: Wed, 2 Jul 2025 12:16:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 0/2] PM / devfreq: Add HiSilicon uncore frequency
 scaling driver
To: Chanwoo Choi <chanwoo@kernel.org>
CC: =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux
 PM list <linux-pm@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, <alireza.sanaee@huawei.com>, Lifeng
 Zheng <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <liwei728@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250623143401.4095045-1-zhanjie9@hisilicon.com>
 <9e028620-75b9-5a9a-dab6-8374b0a4fa4e@hisilicon.com>
 <CAGTfZH0eHz8aRDkSOTNosNqZGv9Qhf2K-Rtz-Yt+_GpNQzXo5g@mail.gmail.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAGTfZH0eHz8aRDkSOTNosNqZGv9Qhf2K-Rtz-Yt+_GpNQzXo5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100006.china.huawei.com (7.202.195.47)

No worries. Thanks in advance!

On 02/07/2025 11:21, Chanwoo Choi wrote:
> Hi, 
> 
> I'm sorry for late review. I'll review and then merge until this week.
> 
> Best Regards,
> Chanwoo Choi
> 
> 2025년 7월 2일 (수) 오전 11:37, Jie Zhan <zhanjie9@hisilicon.com <mailto:zhanjie9@hisilicon.com>>님이 작성:
> 
>     Hi devfreq maintainers,
> 
>     A kindly ping on this series.
>     I believe it's in a good shape now.
> 
>     Jie
> 
>     On 23/06/2025 22:33, Jie Zhan wrote:
>     > Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
>     > the devfreq framework.  The uncore domain contains shared computing
>     > resources, including system interconnects and L3 cache.  The uncore
>     > frequency significantly impacts the system-wide performance as well as
>     > power consumption.  This driver adds support for runtime management of
>     > uncore frequency from kernel and userspace.  The main function includes
>     > setting and getting frequencies, changing frequency scaling policies, and
>     > querying the list of CPUs whose performance is significantly related to
>     > this uncore frequency domain, etc.  The driver communicates with a platform
>     > controller through an ACPI PCC mailbox to take the actual actions of
>     > frequency scaling.
>     >
>     > Changelog:
>     >
>     > v6:
>     > Consolidate hisi_uncore_init_pcc_chan() related stuff:
>     > - Move devm_mutex_init() to hisi_uncore_init_pcc_chan()
>     > - Move devm_add_action_or_reset() into hisi_uncore_request_pcc_chan()
>     >
>     > v5:
>     > https://lore.kernel.org/all/20250619151456.3328624-1-zhanjie9@hisilicon.com/ <https://lore.kernel.org/all/20250619151456.3328624-1-zhanjie9@hisilicon.com/>
>     > - Comment more on error code related stuff about
>     >   hisi_uncore_mark_related_cpus(), and return failure early on errors
>     >   except for -EINVAL, which indicates possibly broken firmware.
>     > - Separate error prints apart for two cases in hisi_platform_gov_handler()
>     > - Make the 'related_cpus' sysfs ABI description more generic
>     > - Some coding style cleanups and typo fixes
>     >
>     > v4:
>     > https://lore.kernel.org/linux-pm/20250530081722.280776-1-zhanjie9@hisilicon.com/ <https://lore.kernel.org/linux-pm/20250530081722.280776-1-zhanjie9@hisilicon.com/>
>     > - Allow devfreq core to accept device-specific sysfs ABIs
>     > - Replace custom sysfs attrs with dev_groups and let the devfreq core
>     >   manage it
>     > - Update 'related_cpus' description in the devfreq ABI doc
>     > - Remove COMPILE_TEST in Kconfig as the mailbox_client.h doesn't support
>     >   this yet
>     > - Replace dev_err() with dev_err_probe() during drv->probe()
>     > - Replace mutex_init() with devm_mutex_init() to warn on UAF
>     > - Replace uncore->dev with dev in some places to make code a bit shorter
>     > - Remove redundant uncore->pchan check in hisi_uncore_free_pcc_chan()
>     > - Use __free() to let compiler release temporary memory
>     > - Clean up the error handling and redundant 'status = 0' in
>     >   hisi_uncore_send_cmd()
>     > - Some coding style cleanup
>     >
>     > v3:
>     > https://lore.kernel.org/linux-pm/20250522031701.1912458-1-zhanjie9@hisilicon.com/ <https://lore.kernel.org/linux-pm/20250522031701.1912458-1-zhanjie9@hisilicon.com/>
>     > - Remove redundant resource freeing processes when drv->probe() fails as
>     >   they're already handled by devm
>     >
>     > v2:
>     > https://lore.kernel.org/linux-pm/20250520074120.4187096-1-zhanjie9@hisilicon.com/ <https://lore.kernel.org/linux-pm/20250520074120.4187096-1-zhanjie9@hisilicon.com/>
>     > - Make devm manage the release sequence, remove drv->remove()
>     > - Warn on !uncore or !uncore->pchan as they're no longer expected
>     > - Remove ioremap of pcc shared memory because it's done by the pcc driver
>     > - Fix compiler warning of discarding 'const'
>     > - Minor trivial coding style changes
>     >
>     > v1:
>     > https://lore.kernel.org/linux-pm/20250506021434.944386-1-zhanjie9@hisilicon.com/ <https://lore.kernel.org/linux-pm/20250506021434.944386-1-zhanjie9@hisilicon.com/>
>     >
>     > Jie Zhan (2):
>     >   PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
>     >   PM / devfreq: Add HiSilicon uncore frequency scaling driver
>     >
>     >  Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>     >  drivers/devfreq/Kconfig                       |  11 +
>     >  drivers/devfreq/Makefile                      |   1 +
>     >  drivers/devfreq/devfreq.c                     |   1 +
>     >  drivers/devfreq/hisi_uncore_freq.c            | 658 ++++++++++++++++++
>     >  include/linux/devfreq.h                       |   4 +
>     >  6 files changed, 684 insertions(+)
>     >  create mode 100644 drivers/devfreq/hisi_uncore_freq.c
>     >
> 


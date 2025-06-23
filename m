Return-Path: <linux-pm+bounces-29246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36879AE3405
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 05:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C9D188C8D2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381919C554;
	Mon, 23 Jun 2025 03:40:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18978C2FA
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750650009; cv=none; b=XLHPSidFRvNjLLKhL3Ftsv8Tl5MpQveb8BpW4S1Ao/jaS7Mw6Q6dTjlyay2gExVEfArXH1ypsI66wZ8xLgRBLGErcN7c8gNkIdLFrBpVyl169tyS4AcrZEHE8f3bJCHTeiZtfKLI4+jB8nt8ZeYC2emaflK6j1ohHD4euG7lhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750650009; c=relaxed/simple;
	bh=y4k45HWqWlXgR7j2MU4TV5tbD3QUXGC7ArWzV+Az8Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MfL3YZFj96WhEfPwUZ1YKVXKIDzIE847n9KxO5vqgfUo7W0hFF/GJBVtdb6k2W4vylIw6auIVblvuiOdqXk4DGH8aYUNZ67+ef6QYzOf6SMUv4OiR/0qu3tN8GAPvukj/Zf9GqLTduE/UslL3mDUbiC6TBZph3irEyz5SRQsd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQYd56Qd5zTgrY;
	Mon, 23 Jun 2025 11:35:37 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 68E8218007F;
	Mon, 23 Jun 2025 11:39:56 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 11:39:56 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 11:39:55 +0800
Message-ID: <508bdca6-eab8-4661-a8e8-560b1ef0a325@huawei.com>
Date: Mon, 23 Jun 2025 11:39:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] PM / devfreq: Add HiSilicon uncore frequency
 scaling driver
To: Jie Zhan <zhanjie9@hisilicon.com>, <cw00.choi@samsung.com>,
	<myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<jonathan.cameron@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20250619151456.3328624-1-zhanjie9@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250619151456.3328624-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

LGTM, for series,
Reviewed-by: lihuisong@huawei.com


在 2025/6/19 23:14, Jie Zhan 写道:
> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
> the devfreq framework.  The uncore domain contains shared computing
> resources, including system interconnects and L3 cache.  The uncore
> frequency significantly impacts the system-wide performance as well as
> power consumption.  This driver adds support for runtime management of
> uncore frequency from kernel and userspace.  The main function includes
> setting and getting frequencies, changing frequency scaling policies, and
> querying the list of CPUs whose performance is significantly related to
> this uncore frequency domain, etc.  The driver communicates with a platform
> controller through an ACPI PCC mailbox to take the actual actions of
> frequency scaling.
>
> Changelog:
>
> v5:
> - Comment more on error code related stuff about
>    hisi_uncore_mark_related_cpus(), and return failure early on errors
>    except for -EINVAL, which indicates possibly broken firmware.
> - Separate error prints apart for two cases in hisi_platform_gov_handler()
> - Make the 'related_cpus' sysfs ABI description more generic
> - Some coding style cleanups and typo fixes
>
> v4:
> https://lore.kernel.org/linux-pm/20250530081722.280776-1-zhanjie9@hisilicon.com/
> - Allow devfreq core to accept device-specific sysfs ABIs
> - Replace custom sysfs attrs with dev_groups and let the devfreq core
>    manage it
> - Update 'related_cpus' description in the devfreq ABI doc
> - Remove COMPILE_TEST in Kconfig as the mailbox_client.h doesn't support
>    this yet
> - Replace dev_err() with dev_err_probe() during drv->probe()
> - Replace mutex_init() with devm_mutex_init() to warn on UAF
> - Replace uncore->dev with dev in some places to make code a bit shorter
> - Remove redundant uncore->pchan check in hisi_uncore_free_pcc_chan()
> - Use __free() to let compiler release temporary memory
> - Clean up the error handling and redundant 'status = 0' in
>    hisi_uncore_send_cmd()
> - Some coding style cleanup
>
> v3:
> https://lore.kernel.org/linux-pm/20250522031701.1912458-1-zhanjie9@hisilicon.com/
> - Remove redundant resource freeing processes when drv->probe() fails as
>    they're already handled by devm
>
> v2:
> https://lore.kernel.org/linux-pm/20250520074120.4187096-1-zhanjie9@hisilicon.com/
> - Make devm manage the release sequence, remove drv->remove()
> - Warn on !uncore or !uncore->pchan as they're no longer expected
> - Remove ioremap of pcc shared memory because it's done by the pcc driver
> - Fix compiler warning of discarding 'const'
> - Minor trivial coding style changes
>
> v1:
> https://lore.kernel.org/linux-pm/20250506021434.944386-1-zhanjie9@hisilicon.com/
>
> Jie Zhan (2):
>    PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
>    PM / devfreq: Add HiSilicon uncore frequency scaling driver
>
>   Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>   drivers/devfreq/Kconfig                       |  11 +
>   drivers/devfreq/Makefile                      |   1 +
>   drivers/devfreq/devfreq.c                     |   1 +
>   drivers/devfreq/hisi_uncore_freq.c            | 664 ++++++++++++++++++
>   include/linux/devfreq.h                       |   4 +
>   6 files changed, 690 insertions(+)
>   create mode 100644 drivers/devfreq/hisi_uncore_freq.c
>


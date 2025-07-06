Return-Path: <linux-pm+bounces-29948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DABD2AF0882
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 04:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3741C2046A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BB1A08A3;
	Wed,  2 Jul 2025 02:37:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD419CD0B
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423872; cv=none; b=Qc9+tN5ixsciYAKoqKmn7A8MLcxJjLGI20VKqja4/hzY0tOAXIWeuzCaVAPqVFPEo9kumFprwUSaBH7pcP3W33659dpbJt1XqG3Kymfd8kTSOnRW/P+AyXZ4WITrZfHMfFqqw9NA/Q2/knPq4OZRKph2c3d1/BMp+lhC4YzEmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423872; c=relaxed/simple;
	bh=HVjL7HK87CxrSrivqpRSpns/6hCd/29aWlLYIt0v1H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HEBomTKz96tsD1Jj28ss1HsF/A9A9f7Vr0XudJIu9uVeEK17Wa0VWuSqkTfL81Z/iTtpyMea6ypv8wmmPY1zEamO+IJjeLM+cB2HU2KwNsKEDgoHegxS34Pp06qP4gSkkKS85het7KWPFzigbar2eeOflQ2y7q64rsY4oGdIh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bX3xG2Yb7z27j0R;
	Wed,  2 Jul 2025 10:38:42 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id F2C4F140294;
	Wed,  2 Jul 2025 10:37:45 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Jul
 2025 10:37:45 +0800
Message-ID: <9e028620-75b9-5a9a-dab6-8374b0a4fa4e@hisilicon.com>
Date: Wed, 2 Jul 2025 10:37:44 +0800
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
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20250623143401.4095045-1-zhanjie9@hisilicon.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250623143401.4095045-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Hi devfreq maintainers,

A kindly ping on this series.
I believe it's in a good shape now.

Jie

On 23/06/2025 22:33, Jie Zhan wrote:
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
> v6:
> Consolidate hisi_uncore_init_pcc_chan() related stuff:
> - Move devm_mutex_init() to hisi_uncore_init_pcc_chan()
> - Move devm_add_action_or_reset() into hisi_uncore_request_pcc_chan()
> 
> v5:
> https://lore.kernel.org/all/20250619151456.3328624-1-zhanjie9@hisilicon.com/
> - Comment more on error code related stuff about
>   hisi_uncore_mark_related_cpus(), and return failure early on errors
>   except for -EINVAL, which indicates possibly broken firmware.
> - Separate error prints apart for two cases in hisi_platform_gov_handler()
> - Make the 'related_cpus' sysfs ABI description more generic
> - Some coding style cleanups and typo fixes
> 
> v4:
> https://lore.kernel.org/linux-pm/20250530081722.280776-1-zhanjie9@hisilicon.com/
> - Allow devfreq core to accept device-specific sysfs ABIs
> - Replace custom sysfs attrs with dev_groups and let the devfreq core
>   manage it
> - Update 'related_cpus' description in the devfreq ABI doc
> - Remove COMPILE_TEST in Kconfig as the mailbox_client.h doesn't support
>   this yet
> - Replace dev_err() with dev_err_probe() during drv->probe()
> - Replace mutex_init() with devm_mutex_init() to warn on UAF
> - Replace uncore->dev with dev in some places to make code a bit shorter
> - Remove redundant uncore->pchan check in hisi_uncore_free_pcc_chan()
> - Use __free() to let compiler release temporary memory
> - Clean up the error handling and redundant 'status = 0' in
>   hisi_uncore_send_cmd()
> - Some coding style cleanup
> 
> v3:
> https://lore.kernel.org/linux-pm/20250522031701.1912458-1-zhanjie9@hisilicon.com/
> - Remove redundant resource freeing processes when drv->probe() fails as
>   they're already handled by devm
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
>   PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
>   PM / devfreq: Add HiSilicon uncore frequency scaling driver
> 
>  Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>  drivers/devfreq/Kconfig                       |  11 +
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/devfreq.c                     |   1 +
>  drivers/devfreq/hisi_uncore_freq.c            | 658 ++++++++++++++++++
>  include/linux/devfreq.h                       |   4 +
>  6 files changed, 684 insertions(+)
>  create mode 100644 drivers/devfreq/hisi_uncore_freq.c
> 


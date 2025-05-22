Return-Path: <linux-pm+bounces-27480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF46AC02FB
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E884E19FF
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 03:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2131527B1;
	Thu, 22 May 2025 03:27:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB27482
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884437; cv=none; b=iC0cv+NpaYKIldbuN/0y5Zj6/PjdGyn+8VSck+TvLbaY+cxrFGI/ZOgUk84fepHFPt5ETyucCZwDLZBDsBp4pfdQ3Ct9378jczwZBx4n1qG39i7rZSfTovQ6dGy6598W/iHRk8bMOo0jD45NUHvkw/DyHyjMI3vIw9XjP4olBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884437; c=relaxed/simple;
	bh=D8hLKJVcu/CyQp52cwWk5qa0fmj0mzdNIdpWJxXf8L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=erLZTYDXYjIm4i6/1oITae3pFs9I2+SW9dFMOzy2aD4EVNXj5axLDe6J0J5Eu4EmGlJ30yiXK6RseiWoCWst2tcL2P84Z0ctphc2CGM1Yxab5U/wCOO2a344nUBVYDnpZd/I+Re+1ZQXgzDm7qdBSCC91lKDJV165LEtilP9b5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4b2twB6sCsz1d1Bh;
	Thu, 22 May 2025 11:25:30 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 10ED5140132;
	Thu, 22 May 2025 11:27:07 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 May
 2025 11:27:06 +0800
Message-ID: <f69ff550-ec27-af8f-ac5c-b52eb7eb0a6f@hisilicon.com>
Date: Thu, 22 May 2025 11:27:06 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3] PM / devfreq: Add HiSilicon uncore frequency scaling
 driver
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20250522031701.1912458-1-zhanjie9@hisilicon.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250522031701.1912458-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Sorry, my bad.  Please ignore this one.

Keep onto this v3 thread: https://lore.kernel.org/linux-pm/20250521104956.2780150-1-zhanjie9@hisilicon.com/

Jie

On 22/05/2025 11:17, Jie Zhan wrote:
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
> Co-developed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
> v3:
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
> ---
>  drivers/devfreq/Kconfig            |  11 +
>  drivers/devfreq/Makefile           |   1 +
>  drivers/devfreq/hisi_uncore_freq.c | 722 +++++++++++++++++++++++++++++
>  3 files changed, 734 insertions(+)
>  create mode 100644 drivers/devfreq/hisi_uncore_freq.c


Return-Path: <linux-pm+bounces-25897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5FA96A17
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0A0189C25D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580FF2857C3;
	Tue, 22 Apr 2025 12:33:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103228540E;
	Tue, 22 Apr 2025 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325186; cv=none; b=YQ9CL1WqazPx/vZEryQQhE6tMTCQyacC3qAK+O8dVd+10muSuBL+INo80GujmHCh6Lx7WAQSsJiJyhRVKUr03EVWLvCdbLrec3W1G7zkj99lKlleBwKsAxGc1QAfUR+XXlQlKX2UFD2CHql8B0yAWW+D/HUllyVmQ/Hj7tYKaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325186; c=relaxed/simple;
	bh=4tH+zpe/YSXkHKzfy3rNqv/0qp2UaJnSNBUtrafhjpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D2fjo7lqMcwLWLJLVDUqjcWdOg1l6Vk6nqtXLj2+5ZQIMjadHHYvvBcCKROh3fri8Y0VQzDDpelzES0FR2fGFaz4StjMCBYu6B1CRwUsok1ELBhKEZdXpP+427QimjcOAsgzkJPdUspnF0G6NCs5Piuq08LX6MO9gr7HrX/UIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZhhTV1kj3z1j5wc;
	Tue, 22 Apr 2025 20:32:46 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DD221A016C;
	Tue, 22 Apr 2025 20:33:01 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:33:00 +0800
Message-ID: <93b0a8ad-8de7-4a17-a908-4ef0eb316e1f@huawei.com>
Date: Tue, 22 Apr 2025 20:33:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cpufreq: Boost related cleanups / fixes
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>, <linux-kernel@vger.kernel.org>, "Rafael
 J. Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <cover.1745315548.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/22 17:53, Viresh Kumar wrote:

> Hello,
> 
> This series tries to fix boost related issues found recently.
> 
> The first two patches (hopefully) fixes the boost related breakage
> introduced recently. These should be applied for v6.15-rc4. Nicholas,
> please give the first two patches a try.
> 
> The other four patches are general optimizations and fixes for boost
> handling in general. These can be applied to -rc or next merge window.
> 
> --
> Viresh
> 
> Viresh Kumar (6):
>   cpufreq: acpi: Don't enable boost on policy exit
>   cpufreq: acpi: Re-sync CPU boost state on system resume
>   cpufreq: Don't unnecessarily call set_boost()
>   cpufreq: Introduce policy_set_boost()
>   cpufreq: Preserve policy's boost state after resume
>   cpufreq: Force sync policy boost with global boost on sysfs update
> 
>  drivers/cpufreq/acpi-cpufreq.c | 38 ++++++++++------------
>  drivers/cpufreq/cpufreq.c      | 58 ++++++++++++++++++++--------------
>  2 files changed, 50 insertions(+), 46 deletions(-)
> 

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>


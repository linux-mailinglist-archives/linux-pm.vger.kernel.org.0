Return-Path: <linux-pm+bounces-29423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B2AE6311
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 12:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A4819255A5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC91288538;
	Tue, 24 Jun 2025 10:55:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FF19F40F
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762532; cv=none; b=OkpK8ePJxI+7gOo7Q7MXjMU/lsvssNlXXV2BcPaG7NqoiU03dFyQi4jPNgH5pmnnXtX6u9kZwML/VEoFl7UejRjhl8u/bcpRMMpwAjkL+AJSfP68kNl+rePWsstVByruSwEEeF1h0bbMZA27kkzq7wKzRYFVXlYWDconJCxzgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762532; c=relaxed/simple;
	bh=FIrINBwqfO8pXLdE0f3Jt/Ft4G2vg5Fl2huimuPz+oA=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JFHKGugUN2h+Un7vn6qaFlEArpG73QY7EgjP/EDOSwqavLIZmw/47AlC0H/L2DBLo4yUJGItBNSUoMhP1pEKjT57dzjksyr84fPwMbZi/8fdDNmHkhWNDsUkbsjzY53e/ug/7SILoCux4WN5LM8lw6hiy7dGWteqjSKqWR00EZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bRMM40RWHz2QVL1;
	Tue, 24 Jun 2025 18:56:16 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 168711A0188;
	Tue, 24 Jun 2025 18:55:21 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 18:55:20 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 18:55:19 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<dianders@chromium.org>, <sumit.garg@linaro.org>, <kernelfans@gmail.com>,
	<lecopzer.chen@mediatek.com>, <tglx@linutronix.de>, <song@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 0/2] Update the watchdog period according to
 real CPU frequency
To: Andrew Morton <akpm@linux-foundation.org>
References: <20250619114805.16968-1-yangyicong@huawei.com>
 <20250623163028.1914d7ec909eb9bfc1daa666@linux-foundation.org>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <a23d3a95-665f-d7b6-064c-770b1c30a05f@huawei.com>
Date: Tue, 24 Jun 2025 18:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250623163028.1914d7ec909eb9bfc1daa666@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/6/24 7:30, Andrew Morton wrote:
> On Thu, 19 Jun 2025 19:48:03 +0800 Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> watchdog perf needs architecture to provide method for converting the watchdog
>> thresh to counter period. For arm64 we're using the max CPU frequency for
>> doing the conversion which is from cpufreq driver. But some cpufreq driver
>> are registered lately, for example cppc_cpufreq will be registered at late
>> initcall which is after the initialization of watchdog perf (initialized in
>> armv8_pmuv3 of device initcall). In such case the period of watchdog will not
>> be accurate enough. Fix this by registering a cpufreq notifier and update the
>> watchdog period once the cpufreq driver is initialized.
> 
> Great, thanks.  I'll add these to mm.git for testing.
> 

thanks.

>> arch/arm64/kernel/watchdog_hld.c | 58 ++++++++++++++++++++++++++++++++
>> include/linux/nmi.h              |  2 ++
>> kernel/watchdog_perf.c           | 23 +++++++++++++
> 
> This is not exactly my comfort zone so additional review would be
> appreciated, please.  Even though it doesn't touch drivers/cpufreq,
> perhaps the developers over there could take a look?
> .

sure. I've already cc'ed them.

thanks.


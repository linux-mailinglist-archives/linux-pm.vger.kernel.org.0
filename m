Return-Path: <linux-pm+bounces-20680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB5CA168ED
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35671881F10
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870419D07C;
	Mon, 20 Jan 2025 09:10:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181B199921;
	Mon, 20 Jan 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364250; cv=none; b=q6wpBqQ4Glg/GhB1sCGyPuCpoa2ORN7eWTXcChugjBPZbzTzSKm4wY0KcVmEVnxHntUmATggWa+yJRzYZGqu0pKieM5Esv6KW8h1fMlz30G0fjpxPYXLv177y1IdKRKQWXOwfxyohsR4fnWPium6EgqzdUi1AEOVOzQlQ5iOyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364250; c=relaxed/simple;
	bh=q0VBnKCmw+5OnTK2AIDD3tmYEST1iWDXyjpZYnWgjzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GxB+VYR84STyu2SQGtwSnkaMv+pmQ13P+hSfME1LK4q2d8qC5cDkyo5ozV/xseb5KBiYSpsIvTfyRf1MAXKkuU8ajEyNMj+Bc3hsPMN6iMrJB9KR4wi4qHVWLKoXVzFGsHJR/Bqb0VrBUuwE7CBN/x5A1sLH3YucY02tJCpLLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yc4J164K4z22lcK;
	Mon, 20 Jan 2025 17:08:17 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C13C8180042;
	Mon, 20 Jan 2025 17:10:45 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Jan
 2025 17:10:45 +0800
Message-ID: <6c58e779-db21-4553-a4da-dcc8591f8c34@huawei.com>
Date: Mon, 20 Jan 2025 17:10:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] cpufreq: Fix re-boost issue after hotplugging a
 cpu
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-2-zhenglifeng1@huawei.com>
 <20250120082723.am7rxujmdvzz4eky@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250120082723.am7rxujmdvzz4eky@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/20 16:27, Viresh Kumar wrote:

> Hi,
> 
> I am bit confused by the sequence of events here and need some
> clarification. Lets assume that CPU can go from 1 GHz to 1.5 GHz
> without boost enabled and with boost it can go to 2 GHz.
> 
> On 17-01-25, 18:14, Lifeng Zheng wrote:
>> It turns out that cpuX will stay on the base frequency after performing
>> these operations:
>>
>> 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> Boost enabled here, max_freq_req = 2 GHz.
> 
>> 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
>>
>> 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
>>
>> 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online
> 
> Boost is disabled currently here, but max_freq_req = 2 GHz, which is
> incorrect and the current change you are proposing fixes it I think.
> But it is not what you are claiming to fix.

Since boost is disabled, policy->max and policy->cpuinfo.max_freq will be
1.5GHz, this limits the actual frequency of the final.

> 
>> 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> Boost enabled again here, and max_freq_req = 2 GHz is the correct
> value.

In freq_qos_update_request(), if req->pnode.prio == new_value, it will
directly return 0 and not excecute freq_qos_apply(), in which will refresh
frequency. So the frequency will stay on base.

> 
> So the CPU doesn't stay at base frequency here, but 2 GHz only.
> 
>> This is because max_freq_req of the policy is not updated during the online
>> process, and the value of max_freq_req before the last offline is retained.
> 
> which was 2 GHz in your example.
> 
>> When the CPU is boosted again, freq_qos_update_request() will do nothing
>> because the old value is the same as the new one. This causes the CPU stay
>> on the base frequency. Update max_freq_req  in cpufreq_online() will solve
>> this problem.
> 



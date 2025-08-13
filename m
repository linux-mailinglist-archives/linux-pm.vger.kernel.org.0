Return-Path: <linux-pm+bounces-32246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B817B24261
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 09:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCDE188E9F9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2802D3ED5;
	Wed, 13 Aug 2025 07:15:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C582D3A72;
	Wed, 13 Aug 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069321; cv=none; b=CzYhb4Lsh1NBBLogPYvBcVSBCrjU5B5xij2JKT9Ldg+mP/v8OIFLquih2YiW5z3zO3HWKYlQAgHx+77j2XeurkBs4ZoSqCRP8ceyaNLftfLCN62/sCPJ3VNjix3Hi1BfNVD0sFkR5M9BxuZ7wpGWxy3jq//kU1QV1VFxplQpsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069321; c=relaxed/simple;
	bh=ZO4uXaV0NI/Fp2cMH1ZgqG/dmqdn8Lgy2YSgXofQT9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lbthLDWG9zhGCYGG28T2lHAFi72QGyXSyYXrM0PVHDbeg7F9cVWYZTxFDGauFUN4gL+ai11Hfs8woNOX8XGQis6mWdiEOZNi39+omAnBhsGtJmFgMgmuJpALfQOUMamHDEHyTtClWyFQK7S7j4o8apHEKfB2YNc9MpNt50WR9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c20121PTTz13N7N;
	Wed, 13 Aug 2025 15:11:50 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 41C7E1401F1;
	Wed, 13 Aug 2025 15:15:14 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 15:15:13 +0800
Message-ID: <8aa1efad-8f30-9548-259a-09fccb9da48a@hisilicon.com>
Date: Wed, 13 Aug 2025 15:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
To: Prashant Malani <pmalani@google.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>,
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
	<zhenglifeng1@huawei.com>, Beata Michalska <beata.michalska@arm.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
 <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
 <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
 <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
 <7a9030d0-e758-4d11-11aa-d694edaa79a0@hisilicon.com>
 <CAFivqmJyYJ+d+TH4qYBKf_5t-AqWZuzgk2H_4nHmynTjoUHnYQ@mail.gmail.com>
 <CAFivqm+4Mir8hgGw-HMLdW=dBYuUw1wJ4xG4a+WAtqfG1vYKXQ@mail.gmail.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAFivqm+4Mir8hgGw-HMLdW=dBYuUw1wJ4xG4a+WAtqfG1vYKXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 05/08/2025 12:58, Prashant Malani wrote:
> On Mon, 4 Aug 2025 at 18:12, Prashant Malani <pmalani@google.com> wrote:
>>
>> On Sun, 3 Aug 2025 at 23:21, Jie Zhan <zhanjie9@hisilicon.com> wrote
>>> On 01/08/2025 16:58, Prashant Malani wrote:
>>>> This begs the question: why is this work function being scheduled
>>>> for CPUs that are in reset or offline/powered-down at all?
>>>> IANAE but it sounds like it would be better to add logic to ensure this
>>>> work function doesn't get scheduled/executed for CPUs that
>>>> are truly offline/powered-down or in reset.
>>> Yeah good question.  We may discuss that on your thread.
>>
>> OK.
>> Quickly looking around, it sounds having in the CPPC tick function [1]
>> might be a better option (one probably doesn't want to lift it beyond the
>> CPPC layer, since other drivers might have different behaviour).
>> One can add a cpu_online/cpu_enabled check there.
> 
> Fixed link:
> [1] https://elixir.bootlin.com/linux/v6.13/source/drivers/cpufreq/cppc_cpufreq.c#L125
I don't think a cpu_online/cpu_enabled check there would help.

Offlined CPUs don't make cppc_scale_freq_workfn() fail because they won't
have FIE triggered.  It fails from accessing perf counters on powered-down
CPUs.

Perhaps the CPPC FIE needs a bit rework.  AFAICS, FIE is meant to run in
ticks, but currently the CPPC FIE eventually runs in a thread due to the
possible PCC path when reading CPC regs I guess.


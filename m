Return-Path: <linux-pm+bounces-31853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B92B19B87
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE861770C7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D974227581;
	Mon,  4 Aug 2025 06:21:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74A126BF7;
	Mon,  4 Aug 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288497; cv=none; b=KCxZZfKoETFOKIvOt1tpUzjbAoKgsliE6XeYkIRGwXbu7hxlMwrzjyRKfQ+wRpgdV8SuLGavvmj2gWyjmJgyhRKbetLBfg02VwEAzcwxlTKM+sCqAmzZnAzanvXV91DGnzrXUU0RACnuDqxdx+BMaN5GhG27vjXzcZdGOsqYCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288497; c=relaxed/simple;
	bh=A4N4og6EdwIUVjzPjtlrfpPkBuTKRz78PuMwMhOthZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lUO2xX4/nKvx2T45+0HJKcTqQQpovmBpX6iqcZZK190I/dUkslh2u6sgM4/56N9O7IUxH2pAXrzStHzq6f4LnSYkNW9uCXsnRorTbefuUu3kmmfLX4PutJ4hKbPVYPCAtgzbQp0zwJL208IMfrS/QTlaVb9M0IiTeybNtoOeVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bwRG83dgGz2TT1x;
	Mon,  4 Aug 2025 14:18:56 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 04D0B140278;
	Mon,  4 Aug 2025 14:21:25 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 14:21:24 +0800
Message-ID: <7a9030d0-e758-4d11-11aa-d694edaa79a0@hisilicon.com>
Date: Mon, 4 Aug 2025 14:21:23 +0800
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
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 01/08/2025 16:58, Prashant Malani wrote:
> Hi Jie,
> 
> On Thu, 31 Jul 2025 at 01:32, Jie Zhan <zhanjie9@hisilicon.com> wrote:
>>
>>
>>
>> On 31/07/2025 06:34, Prashant Malani wrote:
>>
>> Hi Prashant,
>>
>> The perf counters could return 0 when a CPU is enters a low-power idle
>> state, e.g. reset or powered down, and the perf counters are in the system
>> memory space (the target CPU is not woken up unfortunately).
>>
> 
> Thanks for the clarification. Reset and powered down are not typically
> considered "low-power idle states".
Actually, power down and reset is a common low-power idle state defined in
ACPI spec and implemented on Intel chips.
Some quick references:
[1] ACPI spec 6.5, 8 PROCESSOR CONFIGURATION AND CONTROL
https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
Also, the C1, C2, C3 states are refered as Clock Gated, Retention, and
Power Down respectively in 8.4.3 Lower Power Idle States.
[2] Intel 3rd gen Xeon Scalable, the C6 state.
https://www.intel.com/content/www/us/en/content-details/637748/power-management-technology-overview-technology-guide.html?wapkw=c-state

Nevertheless, it's still not widely supported in practice, so I understand
what you said.
> Please re-word your commit message to specifically call out the "reset and
> powered-down" CPU states.
Sure.  I'll try to make it a bit more straightforward in V2.
> 
> This begs the question: why is this work function being scheduled
> for CPUs that are in reset or offline/powered-down at all?
> IANAE but it sounds like it would be better to add logic to ensure this
> work function doesn't get scheduled/executed for CPUs that
> are truly offline/powered-down or in reset.
Yeah good question.  We may discuss that on your thread.
> 
> BR,
> 
Thanks!
Jie


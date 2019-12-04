Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42B112998
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLDK4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 05:56:05 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14728 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfLDK4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 05:56:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de790b50000>; Wed, 04 Dec 2019 02:55:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Dec 2019 02:56:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Dec 2019 02:56:04 -0800
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Dec
 2019 10:56:00 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
From:   sumitg <sumitg@nvidia.com>
Message-ID: <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
Date:   Wed, 4 Dec 2019 16:25:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575456949; bh=ro08D4nTCDKA4g/LLllSz/rbWxxm0KL/lEFg2RZ47Wg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=P4H8jDxrbYNjwagumhpUnHqnetpmMZzW87JXeCX1JSxVhjfywTV1YyPYsSFU4yJV5
         98IVAqHE8ZEO4q26s7lq/9ZFuZi2cgn7mQNFNRcL3oJYTrYYGmPV9OsxjpvgcOGJEH
         BACSgNHLeZmwUmxT3ZEm3ZNxvDPnJgEPxItaiwELRwh9fah9jVpBwyo50jyP/rEjWj
         yNj8tu4mSPYFpY6pOlxMIXcNPQIjADM3ba4CAozwjR+xqyI5AC0eNPFlUwnflDgfCg
         CpwT45CN/exfjs9u0qLC+GtyrqbO/OJg+EuisdZ4a9x3OTEY0dJ+nqaMkZknpFY+xR
         I2TyXKPywKNoQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 04/12/19 11:10 AM, Viresh Kumar wrote:
> Hi Sumit,
>
> On 03-12-19, 23:02, Sumit Gupta wrote:
>> Add support for CPU frequency scaling on Tegra194. The frequency
>> of each core can be adjusted by writing a clock divisor value to
>> an MSR on the core. The range of valid divisors is queried from
>> the BPMP.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/Kconfig.arm        |   6 +
>>   drivers/cpufreq/Makefile           |   1 +
>>   drivers/cpufreq/tegra194-cpufreq.c | 423 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 430 insertions(+)
>>   create mode 100644 drivers/cpufreq/tegra194-cpufreq.c
> Overall these are the things that you are doing here in the driver:
>
> - open coded clk_{get|set}_rate(), why can't you implement a clock
>    driver for the CPU and use the clk framework? You may not need the
>    (hacky) work-queue usage then probably.

In T194, CCPLEX doesn't have access to set clocks and the

clk_{get|set}_rate() functions set clocks by hook to BPMP R5.

CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).

As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is

used to read the counters and calculate "actual" cpu freq at CCPLEX.

So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not

given by node "scaling_cur_freq".

>
> - populating cpufreq table, you can probably add OPPs instead using
>    the same mechanism

We are reading available frequencies from BPMP to populate

cpufreq table and not using static opp table.

>
> - And then you can reuse the cpufreq-dt driver for your platform as
>    well, as is the case for few other tegra platforms.
>

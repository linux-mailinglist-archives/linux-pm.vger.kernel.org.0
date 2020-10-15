Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5628F444
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgJOODT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:03:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5795 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgJOODQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 10:03:16 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8856780000>; Thu, 15 Oct 2020 07:02:32 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Oct
 2020 14:03:14 +0000
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
Date:   Thu, 15 Oct 2020 15:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602770552; bh=eRgeXVS4aq9/V8pwtpNTI0b0bs2u2Bi0+5Nq1/rRJ/g=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=qEwpwMzM7i9FfEYLGu5uUpqtYd0r4W5IxvxZ9OWKr67U3mbPVJuqN4nSRAXi0Kmub
         2y3OUrMnAwDsiGw+Ro7UVFqjW/zbuXS8N7fPTo/IeGjpgqFbcmdNfup16NZ5aTvntU
         tOK2E5HXc569wt/X/g7j8kFgZtyORK9BdI3fKZ7umLtCzfSq+nex2fLkM+VEzQx7Gw
         VwmopBc6ICM4pk4U3EoCR8w9MWj8xqSq+caQZOV/Blm8me84XgwFQfxab8VUcG+5+W
         vPC0HV7VC2kx2q0a35f6nmMLYt4qClYZ/cyWOoLmKpwTMIN0QKJ5qhRkiZJwzcSGMn
         IL+OIlDqDC/1A==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 25/08/2020 06:50, Viresh Kumar wrote:
> On 24-08-20, 15:59, Jon Hunter wrote:
>> Commit 6cc3d0e9a097 ("cpufreq: tegra186: add
>> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag") fixed CPUFREQ support for
>> Tegra186 but as a consequence the following warnings are now seen on
>> boot ...
>>
>>  cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU1: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU1: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU3: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU3: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU5: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU5: Unlisted initial frequency changed to: 2035200 KHz
>>
>> Fix this by adding a 'get' callback for the Tegra186 CPUFREQ driver to
>> retrieve the current operating frequency for a given CPU. The 'get'
>> callback uses the current 'ndiv' value that is programmed to determine
>> that current operating frequency.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> Changes since V1:
>> - Moved code into a 'get' callback
>>
>>  drivers/cpufreq/tegra186-cpufreq.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
>> index 01e1f58ba422..0d0fcff60765 100644
>> --- a/drivers/cpufreq/tegra186-cpufreq.c
>> +++ b/drivers/cpufreq/tegra186-cpufreq.c
>> @@ -14,6 +14,7 @@
>>  
>>  #define EDVD_CORE_VOLT_FREQ(core)		(0x20 + (core) * 0x4)
>>  #define EDVD_CORE_VOLT_FREQ_F_SHIFT		0
>> +#define EDVD_CORE_VOLT_FREQ_F_MASK		0xffff
>>  #define EDVD_CORE_VOLT_FREQ_V_SHIFT		16
>>  
>>  struct tegra186_cpufreq_cluster_info {
>> @@ -91,10 +92,39 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
>>  	return 0;
>>  }
>>  
>> +static unsigned int tegra186_cpufreq_get(unsigned int cpu)
>> +{
>> +	struct cpufreq_frequency_table *tbl;
>> +	struct cpufreq_policy *policy;
>> +	void __iomem *edvd_reg;
>> +	unsigned int i, freq = 0;
>> +	u32 ndiv;
>> +
>> +	policy = cpufreq_cpu_get(cpu);
>> +	if (!policy)
>> +		return -EINVAL;
> 
> This should be return 0;
> 
> Applied with that change. Thanks.


If not too late, would you mind dropping this patch for v5.10?

The patch was working for me locally, but when testing on more boards, I
actually found this broke CPUFREQ support on some Tegra186 boards. The
reason is that the boot frequency may not be in the frequency table on
all boards. The boot frequency is constant across all boards, but the
frequency table can vary slightly with device. Therefore, for some
boards, such as mine, the boot frequency is found the in frequency table
but this is not always the case.

Now that you have made the warning an info print, this change is not
really needed and the simplest thing to do is dropped this completely.
Sorry about that.

Jon

-- 
nvpublic

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25F4251416
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgHYIWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 04:22:43 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4669 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHYIWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 04:22:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f44ca440002>; Tue, 25 Aug 2020 01:22:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 01:22:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 01:22:42 -0700
Received: from [10.26.74.41] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 08:22:40 +0000
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ab693b02-9ae2-48c2-0104-e82d949d82b7@nvidia.com>
Date:   Tue, 25 Aug 2020 09:22:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598343748; bh=LkkmwW6Ou5KUyXiZ9GFzOWPI5DK3g7/4RUVRkK4oGKk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gJV28BEOFvRtdFiEGfwtPMV9+KMj2wVPpgmf+wPdzt4yXxsbxi6eJjkjARn8ho1ED
         RFsZbjZMTmgM+wU4V0PCz8l2u6gYmkj9+x7k/558EHveYWxFEIOLfJa2FlgycXMX31
         ivG6lNFQ/966NIFZu/i8iEOFn2e6Qhg6N3RGwK3cc3OQZx4DuwOox7KoEZA8YeXHNV
         +XIHri+B3MUoLTglzV5ICmURBfeaeHOmwcA7uUVdvIkudMXMRF/ILs8uXQpJhsBiGI
         Ut6AuKgQ7hi6334gfIwOqZdLR9bmSKyAr12aCi2OZb+BMCAr/HfNUyasy101Fqq98U
         usCthjRAs0E/w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


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


OK, thanks!

Jon

-- 
nvpublic

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A567526D6F4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIQIoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 04:44:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5781 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQIoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 04:44:38 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:44:38 EDT
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63219d0000>; Thu, 17 Sep 2020 01:43:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 01:44:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 01:44:38 -0700
Received: from [10.26.74.242] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 08:44:33 +0000
Subject: Re: [Patch 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Sumit Gupta <sumitg@nvidia.com>, <viresh.kumar@linaro.org>,
        <rjw@rjwysocki.net>, <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
 <81d2517d-6581-b491-c509-832fd1c0321e@nvidia.com>
Message-ID: <6dcc664e-e4d2-6334-f0f5-4ead5935cbc7@nvidia.com>
Date:   Thu, 17 Sep 2020 09:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81d2517d-6581-b491-c509-832fd1c0321e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600332189; bh=ZqTdLMM7dV4IVa02a6CrfqjKc/g6ok1JiKfZ8dbx/Fo=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AOFPdVZ8WEURhEbEtgA5loxB4rp0X6coUvNS56dJb+5wpLtwzABgJgxxp9j/7aaw+
         rs31eLWKCLXTudLAaLxjzfu2JdLszjvP/5D6umn2Ef24idfK5qdfNSNnazT2w4J/kX
         ZkH6rvhFinsoMnH+I9Mtr53hWKtvW+bGkFt2T6UZLArNccG4+G7eJi/1r70TFMfEbs
         g9ilXrFM0XVT1RXnizL+7/afX5bSR5fsPnQuZP4/cnT3tqXgmLPy2TzCiVeUnriQOV
         aLmvTgCTvAMFPVsFilCNGozt9seETUlhCQ98/LLIwYPNBQd/NrI2HczUlS3aJ4Nu8I
         sLQiGKrrqGv2Q==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding Sudeep ...

On 17/09/2020 09:36, Jon Hunter wrote:
> 
> 
> On 16/09/2020 18:11, Sumit Gupta wrote:
>> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
>> and keeps changing slightly. This change returns a consistent value
>> from freq_table. If the reconstructed frequency has acceptable delta
>> from the last written value, then return the frequency corresponding
>> to the last written ndiv value from freq_table. Otherwise, print a
>> warning and return the reconstructed freq.
> 
> We should include the Fixes tag here ...
> 
> Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
> 
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> 
> Otherwise ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Viresh, ideally we need to include this fix for v5.9. Do you need Sumit
> to resend with the Fixes tag or are you happy to add?


Sudeep, Rafael, looks like Viresh is out of office until next month.
Please let me know if we can pick up both this patch and following patch
for v5.9.

Thanks!
Jon

-- 
nvpublic

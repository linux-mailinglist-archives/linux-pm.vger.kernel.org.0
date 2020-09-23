Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2027534A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgIWIe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 04:34:28 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4049 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWIe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 04:34:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b08650000>; Wed, 23 Sep 2020 01:33:41 -0700
Received: from [10.26.74.254] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 08:34:20 +0000
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
 <6dcc664e-e4d2-6334-f0f5-4ead5935cbc7@nvidia.com>
Message-ID: <86356902-5488-bb34-70a4-b6a916ccca7d@nvidia.com>
Date:   Wed, 23 Sep 2020 09:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6dcc664e-e4d2-6334-f0f5-4ead5935cbc7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600850021; bh=2pX9LlyppSFkcWLjsdQA46jR7c0N+/P/KPu5e9cVUhM=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=dGD/kF+pgPYMk/1CEZkcw2a9lw7N8AO3y3kPAuqAL24H7ca3RJJ86STmfXc5a/o/e
         iKJqVcjnei95TFbVognObhEza+h+9snfgLX+9i4gpFqMenjxRM2/FYILSDy7U79OoR
         YxOSUP6VQwxu6uIXsfsJ0a3tCUsVmB7mR2U7hWLZnykVY2cA1Jt4bwiaZYxn7oRPUd
         j0KKI2IZfsINA7FvHIgGn8Mjy3hWrZMbSBT1399IZi2tJhrs7C0fFpwrv2BSRdZ7AQ
         cfnHpiaZMzjYpOHTWcJmEjGRPKZvve8IMOo7FbU3cmQL7Ztgldd65Igj7a5VpK03hv
         Usasw0dtKaDiA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael, Sudeep,

On 17/09/2020 09:44, Jon Hunter wrote:
> Adding Sudeep ...
> 
> On 17/09/2020 09:36, Jon Hunter wrote:
>>
>>
>> On 16/09/2020 18:11, Sumit Gupta wrote:
>>> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
>>> and keeps changing slightly. This change returns a consistent value
>>> from freq_table. If the reconstructed frequency has acceptable delta
>>> from the last written value, then return the frequency corresponding
>>> to the last written ndiv value from freq_table. Otherwise, print a
>>> warning and return the reconstructed freq.
>>
>> We should include the Fixes tag here ...
>>
>> Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
>>
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>
>> Otherwise ...
>>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> Viresh, ideally we need to include this fix for v5.9. Do you need Sumit
>> to resend with the Fixes tag or are you happy to add?
> 
> 
> Sudeep, Rafael, looks like Viresh is out of office until next month.
> Please let me know if we can pick up both this patch and following patch
> for v5.9.

Any chance we can get these patches into v5.9?

Thanks!
Jon

-- 
nvpublic

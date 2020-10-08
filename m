Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17415287327
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgJHLLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 07:11:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17180 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbgJHLLN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 07:11:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ef3c40000>; Thu, 08 Oct 2020 04:11:00 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 11:11:09 +0000
Subject: Re: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ksitaraman@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
 <20201005045414.fmntm7ejad7zxcrv@vireshk-i7>
 <2c0daaa5-4aec-925d-c1e3-0f15fb93cc20@nvidia.com>
 <20201006053856.dth6ut22pvwpgfz5@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <7e285f41-e1ae-e352-9d1b-efd4d20ddfa3@nvidia.com>
Date:   Thu, 8 Oct 2020 16:41:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201006053856.dth6ut22pvwpgfz5@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602155460; bh=hR+PWuPTBEUl+VVWHX31EggS7H8qb+R7ZpsXaE0Epu0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ao0j86RLttzZX8O9MHWgexWKwOryKCi+GkFEnZRe2QUANKDxB4j9iHQca2GuGIi2w
         XJ/uDV6etWopwbRNTFnkne8hr1W9A4mlQS20PcAigOJgThI9o5ftRMSM6w4T8K1Z4e
         oz2uaH3WfUK3GZwibveyhcH/qXoctjAj/SLyvlb/RtAiTT0fX1BUxVMs6dbC+Yhk6b
         Z7+vBPqp8soOWkFvuGp46yYc/cDMrY7uiW4wMRrv0FsGS2muwRef2KaCtjpYelelwO
         E9IsNr76dARDUVjgoxofjgW8EcUdj/WDdFh+rFELLxxILtMF6jPbmfegKgjTeH0uWt
         VLcgWKh77tCPQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>>
>>>> Warning coming during boot because the boot freq set by bootloader
>>>> gets filtered out due to big freq steps while creating freq_table.
>>>> Fixing this by setting closest ndiv value from freq_table.
>>>> Warning:
>>>>     cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>>>>     cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
>>>>
>>>> Also, added change in init to wait till current frequency becomes
>>>> equal or near to the previously requested frequency. This is done
>>>> because it takes some time to restore the previous frequency while
>>>> turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
>>>
>>> So you are trying to figure if the frequency is listed in freq-table or not,
>>> otherwise setting the frequency to a value you think is appropriate. Right ?
>> During boot, want to set the frequency from freq_table which is closest to
>> the one set by bootloader.
> 
> Right.
> 
>> During resume from suspend-to-idle, want to restore the frequency which was
>> set on non-boot cores before they were hotplug powered off.
> 
> Why exactly do you want to do that ? Rather you should provide
> online/offline hooks for the cpufreq driver and do light-weight
> suspend/resume as is done by cpufreq-dt.c as well.
> 
Thank you for pointer. Added online hook to avoid warning during 
hot-plug-on for the non-boot CPU's while exiting from Suspend-to-RAM. Will
send new version with the changes.

>>>
>>> This is what the cpufreq core already does when it printed these boot time
>>> messages. Do we really need to add this much code in here ?
>> We want to avoid the warning messages.
> 
> Hmm, okay.
> 
>>>
>>> If you really don't want to see the warning, how about fixing it the way cpufreq
>>> core does ? i.e. with this call:
>>>
>>> ret = __cpufreq_driver_target(policy, policy->cur - 1, CPUFREQ_RELATION_L);
>>>
>> The cpufreq core change will help in bootup case but not during the case of
>> resume.
>> In this change, reading the previously stored value and restoring it will
>> also fix the warning message during resume.
> 
> You were getting the message during resume as well ? Why ? The
> firmware is updating the frequency to a previous value ? If that is
> so, you should just set the frequency again to some other value during
> resume to fix it.
Yes, it boots at a predefined frequency and then some time is taken to 
restore the last frequency which software requested before entering 
Suspend-to-RAM. We don't need to re-write the register again.

> 
> --
> viresh
> 

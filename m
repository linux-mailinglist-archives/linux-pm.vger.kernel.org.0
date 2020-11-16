Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171322B4A12
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 16:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgKPPz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 10:55:27 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12832 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbgKPPz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 10:55:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2a0f30000>; Mon, 16 Nov 2020 07:55:31 -0800
Received: from [10.26.75.250] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 15:55:25 +0000
Subject: Re: [PATCH] cpufreq: tegra186: Fix get frequency callback
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201103115514.547047-1-jonathanh@nvidia.com>
 <20201104093349.l3r3eftwyvaoqjf2@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c4c384cd-2d8f-6f19-cd6b-18450cbf957b@nvidia.com>
Date:   Mon, 16 Nov 2020 15:55:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104093349.l3r3eftwyvaoqjf2@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605542131; bh=prnEH1LcsAwXu7hHuEMMYjPWoCkjQia/rAmzh/Hqu/I=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=cnzTumrNVjfPzHypZW9c1rPcTi06Rp1UkpXmERZtXndKM4iBoFvFQwti5imoRl98O
         vCtILSa5k4EILJAqQkvHuOnYuYVNo0gw6Mbi8i0I52pbMNpGssMnsLmIFUJnepJclt
         GTpK+geDVI5SPAzPQVtJunGM1UJitW/bxSby0zFWbzosvrxrSaU7NcH/MV49K5/XJQ
         zJH0tYvtgHZ5+YXpj22+MFrb6Dz+DsWYJDWcx10/JFiyIhsyHNoRaWoL1mzkqEfnB0
         D6vy3JnAFL7LMY4vBUJJYQH9Pp1kyk1P6IJ2DQequk9sEZkTIaeLQ+CZ62WSsTvAwd
         PaQjSgoJoqaJw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 04/11/2020 09:33, Viresh Kumar wrote:
> On 03-11-20, 11:55, Jon Hunter wrote:
>> Commit b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
>> implemented the CPUFREQ 'get' callback to determine the current
>> operating frequency for each CPU. This implementation used a simple
>> looked up to determine the current operating frequency. The problem
>> with this is that frequency table for different Tegra186 devices may
>> vary and so the default boot frequency for Tegra186 device may or may
>> not be present in the frequency table. If the default boot frequency is
>> not present in the frequency table, this causes the function
>> tegra186_cpufreq_get() to return 0 and in turn causes cpufreq_online()
>> to fail which prevents CPUFREQ from working.
>>
>> Fix this by always calculating the CPU frequency based upon the current
>> 'ndiv' setting for the CPU. Note that the CPU frequency for Tegra186 is
>> calculated by reading the current 'ndiv' setting, multiplying by the
>> CPU reference clock and dividing by a constant divisor.
>>
>> Fixes: b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Rafael: This needs to go in the next rc and so I am not applying it
> in my tree as this is the only fix I have for now.


Are you able to pick this up for v5.10 fixes?

Thanks
Jon

-- 
nvpublic

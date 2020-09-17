Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874026D6F6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIQIpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 04:45:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5878 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIQIpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 04:45:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6321c00001>; Thu, 17 Sep 2020 01:43:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 01:45:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 01:45:13 -0700
Received: from [10.26.74.242] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 08:45:06 +0000
Subject: Re: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Sumit Gupta <sumitg@nvidia.com>, <viresh.kumar@linaro.org>,
        <rjw@rjwysocki.net>, <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
 <53d4513d-0232-0287-9610-3e9ed8888273@nvidia.com>
Message-ID: <f387abcc-f68f-37fb-32cb-d8eb9c75b37a@nvidia.com>
Date:   Thu, 17 Sep 2020 09:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <53d4513d-0232-0287-9610-3e9ed8888273@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600332224; bh=hkXgHpAJCj98mhBFpX/Xx3jMKH0Fmfp4GUiqjPmKgnc=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lPIdu/lV6xPaiAJYJ/X1tTpA2Im+0Ezxo1S/l66mu3rKs1XH6HcOx7a/fhwE2ETuN
         TAxRK8mM59GciT0xIxQPbeZc2OIW0JY3sYYWiCJex6mZ1sAlAbC+5PnbAndvPdMTj4
         SwU61bhmX4daXloN00qSAoFd/1IXm8SM1RYkNGEJ+mHAfssRPpTNd+bhLIYKg2Va63
         AeproXEMWbbH9nejH60pyHdvhtv8EH2wtqb26f8vRDEKCCvEF0RFyxT2FgN8cB8mRo
         f5jW9Rl7zHF2HjSd12e2ikBkqMm6EPp43C+cCUYV747d2DDtq596fl3Jrp1rZmiHWC
         8IsfAR+sLG3vw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 17/09/2020 09:38, Jon Hunter wrote:
> 
> On 16/09/2020 18:11, Sumit Gupta wrote:
>> Warning coming during boot because the boot freq set by bootloader
>> gets filtered out due to big freq steps while creating freq_table.
>> Fixing this by setting closest ndiv value from freq_table.
>> Warning:
>>   cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>>   cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
>>
>> Also, added change in init to wait till current frequency becomes
>> equal or near to the previously requested frequency. This is done
>> because it takes some time to restore the previous frequency while
>> turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
> 
> Same here ...
> 
> Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
> 
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Viresh, this is also needed for v5.9.

Adding Sudeep.

Jon

-- 
nvpublic

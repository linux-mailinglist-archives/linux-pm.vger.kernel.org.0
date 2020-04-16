Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECE1AB954
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437954AbgDPHGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 03:06:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4641 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437186AbgDPHGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 03:06:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9803af0000>; Thu, 16 Apr 2020 00:05:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Apr 2020 00:06:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 16 Apr 2020 00:06:18 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr
 2020 07:06:18 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr
 2020 07:06:14 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20200406025549.qfwzlk3745y3r274@vireshk-i7>
 <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
 <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
 <08307e54-0e14-14a3-7d6a-d59e1e04a683@nvidia.com>
 <20200409074415.twpzu2n4frqlde7b@vireshk-i7>
 <00390070-38a1-19aa-ca59-42c4658bee7e@nvidia.com>
 <20200413062141.a6hmwipexhv3sctq@vireshk-i7>
 <64b609f1-efb1-425f-a91a-27a492bd3ec4@nvidia.com>
 <20200414054504.e3qn2cnxqur4sclw@vireshk-i7>
 <d6e0eed6-4267-fca9-59e1-02d16e17ff34@nvidia.com>
 <20200416033715.hscztwkxie2o5i3r@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <8ea80551-b47c-3dd5-4efa-6befecc279e1@nvidia.com>
Date:   Thu, 16 Apr 2020 12:36:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200416033715.hscztwkxie2o5i3r@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587020719; bh=MEcFP8G3VxgwBAt3A1oRVQWL07CnwPJfWLc3Wywyjpg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ym1Zof5kV4ZzNBXuhXOY6pCMuNXLHXbISr+b04QIKvNWYzdvddezwVuXMpid2BF5/
         dPfkdQNOTOxwvEjv0+wd7hCnNKkb8FlFD8nTuS66Zsv/E+tYrpbTFQtsnTyCM0IHed
         QJxsYrwBMxHjeNsU7m177c0g4VNPYU5YLdeyBsjHvmbkdksZ0xTbWVzZeIvZXdJgj7
         qnnuPfvuQoOA+S/MvnDcKQZN5bkim4KueK5S7THIGk9WB1KWKuJPst/htuBdxTdd78
         SsokaJxGXH+ZdN77GNGGGQ9I3cwDBWGmBrY6dMiePRVUIu9mpDj4o3swCIo5ZHNWFH
         nsLq+/ogcmUUg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 16/04/20 9:07 AM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 15-04-20, 16:55, Sumit Gupta wrote:
>>
>>
>> On 14/04/20 11:15 AM, Viresh Kumar wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 13-04-20, 17:50, Sumit Gupta wrote:
>>>> This was done considering long delay value as explained previously.
>>>> Do you think that smp_call_function_single() would be better than work queue
>>>> here?
>>>
>>> Don't work with assumptions, you should test both and see which one
>>> works better. Workqueue should never be faster than
>>> smp_call_function_single() with my understanding.
>> Checked the time taken and its almost same in both cases.
>> Earlier we used smp_call_function_single(), but delay time period was small
>> in that SOC. In T194, the time period was more. So, this is an optimization
>> done because using work queue has advantage as interrupts will not be
>> disabled for that period.
> 
> Hmm, okay, keep the workqueue and mention the required details in a
> comment for everyone to understand why the implementation is done that
> way.
> 

sure, thank you!

> --
> viresh
> 

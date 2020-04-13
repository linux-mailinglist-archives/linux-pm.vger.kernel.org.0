Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348031A6643
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 14:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgDMMTe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 08:19:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15646 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgDMMTd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 08:19:33 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9458680001>; Mon, 13 Apr 2020 05:17:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Apr 2020 05:19:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Apr 2020 05:19:32 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Apr
 2020 12:19:32 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Apr
 2020 12:19:28 +0000
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
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
 <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
 <20200406025549.qfwzlk3745y3r274@vireshk-i7>
 <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
 <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
 <08307e54-0e14-14a3-7d6a-d59e1e04a683@nvidia.com>
 <20200409074415.twpzu2n4frqlde7b@vireshk-i7>
 <00390070-38a1-19aa-ca59-42c4658bee7e@nvidia.com>
 <20200413062141.a6hmwipexhv3sctq@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <64b609f1-efb1-425f-a91a-27a492bd3ec4@nvidia.com>
Date:   Mon, 13 Apr 2020 17:50:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200413062141.a6hmwipexhv3sctq@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586780264; bh=sm196NiMqA8gyR8DT4vdRI+KvcOo8ha9TmgFSKUPb3I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SagSxSkltbuOB5/r68bXwwj2Py22FS0okY336BB5sSpzMGJd+D4SfPeDrbLizmuLi
         FL3tnoxu3StWADbYI1GhBsP9wJIoxZ94WO+1lfqHNV6qQjHaYITR8Dng3YGYwpsdqB
         CBgUXEv4fhMD+z8G7TsKXaGLnByZEWvjK4ygbim5H44rSzc2FCxRfvtpLLbz/8dYbD
         m8LYWPG47mTzvFPYr5EEYsjlfHTCod5MqtPdKHqrdXpPlVFyl+9IjxuoH0Lv/nnAht
         +ETx8yIwVHTH/LBs+15idwsSoSdYWZI4aixVx24qtttaWYIpxtGYZzsPt2VQtUHD+t
         gux1X9yQKzipA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13/04/20 11:51 AM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 09-04-20, 16:51, Sumit Gupta wrote:
>> We are using "read_counters_work" as local variable. So every invocation the
>> function will have its own copy of counters for corresponding cpu. That's
>> why are doing INIT_WORK_ONSTACK here.
> 
> Why? To support parallel calls to reading the freq ?
> 
Yes.

>>>>>>>>>> +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
>>>>>>>>>> +     flush_work(&read_counters_work.work);
>>>>>>>>>
>>>>>>>>> Why can't this be done in current context ?
>>>>>>>>>
>>>>>>>> We used work queue instead of smp_call_function_single() to have long delay.
>>>>>>>
>>>>>>> Please explain completely, you have raised more questions than you
>>>>>>> answered :)
>>>>>>>
>>>>>>> Why do you want to have long delays ?
>>>>>>>
>>>>>> Long delay value is used to have the observation window long enough for
>>>>>> correctly reconstructing the CPU frequency considering noise.
>>>>>> In next patch version, changed delay value to 500us which in our tests is
>>>>>> considered reliable.
>>>>>
>>>>> I understand that you need to put a udelay() while reading the freq from
>>>>> hardware, that is fine, but why do you need a workqueue for that? Why can't you
>>>>> just read the values directly from the same context ?
>>>>>
>>>> The register to read frequency is per core and not accessible to other
>>>> cores. So, we have to execute the function remotely as the target core to
>>>> read frequency might be different from current.
>>>> The functions for that are smp_call_function_single or queue_work_on.
>>>> We used queue_work_on() to avoid long delay inside ipi interrupt context
>>>> with interrupts disabled.
>>>
>>> Okay, I understand this now, finally :)
>>>
>>> But if the interrupts are disabled during some call, won't workqueues face the
>>> same problem ?
>>>
>> Yes, we are trying to minimize the case.
> 
> But how do you know workqueues will perform better than
> smp_call_function_single() ? Just asking for clarity on this as normally
> everyone tries to do smp_call_function_single().
> 
This was done considering long delay value as explained previously.
Do you think that smp_call_function_single() would be better than work 
queue here?

> --
> viresh
> 

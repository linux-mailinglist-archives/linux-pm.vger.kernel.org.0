Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2BD447E31
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhKHKrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 05:47:07 -0500
Received: from foss.arm.com ([217.140.110.172]:48720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhKHKrH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 05:47:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB6DD6E;
        Mon,  8 Nov 2021 02:44:22 -0800 (PST)
Received: from [10.57.27.158] (unknown [10.57.27.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8E4D3F800;
        Mon,  8 Nov 2021 02:44:18 -0800 (PST)
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
 <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
 <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
 <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
 <b7e76c2a-ceac-500a-ff75-535a3f0d51d6@linaro.org>
 <f955a2aa-f788-00db-1ed8-dc9c7a1b2572@kali.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7bd9aa9f-1d1f-ea12-57ba-adf5d69cbbfb@arm.com>
Date:   Mon, 8 Nov 2021 10:44:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f955a2aa-f788-00db-1ed8-dc9c7a1b2572@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/5/21 10:46 PM, Steev Klimaszewski wrote:
> 
>> [snip]
>> Hi,
>>
>> So IIUC the below logs correctly, you are never hitting boost 
>> frequency (with or without this patch series). Is that correct ?
>>
>> w.r.t temperature , how are you measuring it? Do you have LMh enabled 
>> or are you using tsens to mitigate cpu temperature ?
> 
> 
> Hi,
> 
> I was wrong - it does indeed go boost with the patchset applied, it's 
> just that it doesn't boost up to 2.96GHz very often at all. As noted by 
> the 0.03% when i ran it while compiling zellij; I reapplied the patches 
> (and the 6th patch from Lukasz's email) and after boot, 2.96GHz was 
> showing at 0.39%.
> 
> Most tools that read the cpu frequency don't really seem to be well 
> suited for big.LITTLE, and seem to throw an average of the speed, so 
> cpufreq-info was the best I have.  We're apparently supposed to be using 
> cpupower these days, but it doesn't seem to know anything about arm64 
> devices.
> 
> Temperature wise, I'm just getting from the sensors, and I am using LMh.
> 
> Now, I have to admit, while I've thrown a patch here or there, I'm not 
> exactly a kernel developer, just enough knowledge to be somewhat 
> dangerous and know how to backport things.  In my mind, and my line of 
> thinking, I would expect with boost enabled, that the cpu would boost up 
> to that as often as possible, not require a specific workload to 
> actually hit it.  But then again, I would expect multiple compilation 
> jobs to be one of the workloads that would?
> 
> So I think, the part about never hitting 2.96GHz can be dismissed, and 
> was simply my lack of knowledge about the cpufreq-info tool's averages. 
> It does seem however to rarely ever hit 2.96GHz and I would actually 
> expect it to hit it far more often.
> 

Thank you for the logs and re-testing it with the debug changes.
That's valuable information. I'll work on it today.

Regarding the 'boost' frequency, as you observed, it's hard to
measure it properly. Normally when you use the frequency governor
'schedutil' (which is your case), you need a high utilization workload
to request highest frequency. The task scheduler does this calculation
and then asks for the frequency.
I'll spend more time trying to understand how this Qcom driver and HW
handles it. The patch set itself should not block it.

I'll get back to you soon.

Regards,
Lukasz

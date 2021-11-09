Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230E644A858
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbhKIIcO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 03:32:14 -0500
Received: from foss.arm.com ([217.140.110.172]:58328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241549AbhKIIcO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 03:32:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57ED02B;
        Tue,  9 Nov 2021 00:29:28 -0800 (PST)
Received: from [10.57.26.224] (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718EB3F5A1;
        Tue,  9 Nov 2021 00:29:24 -0800 (PST)
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
 <59054c90-c1cd-85bf-406e-579df668d7b4@linaro.org>
 <eac00041-a1b8-0780-931d-52249d538800@kali.org>
 <2c54dbbd-2ecb-fb76-fa9f-9752f429c20e@linaro.org>
 <97e93876-d654-0a89-dce1-6fe1189345e2@kali.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d83a5c25-2eae-3626-f78a-e42915076556@arm.com>
Date:   Tue, 9 Nov 2021 08:29:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <97e93876-d654-0a89-dce1-6fe1189345e2@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Steev,

That's interesting what you've done with Rockchip RK3399.
I would like to reproduce your experiment on my RockPI 4B v1.3.
Could you tell me how you to add this boost frequency that you have
mentioned in some previous emails?

I want to have similar setup to yours and I'll check all the subsystems
involved in the decision making process for triggering this boost freq.

On 11/8/21 11:21 PM, Steev Klimaszewski wrote:
> Hi Thara,
>> Hi Steev,
>>
>> IIUC, PineBook Pro has Rockchip RK3399 which has 2 Cortex A-72 and 4 
>> Cortex A-52 where as C630 has Qualcomm sdm845 which has 4 Cortex A-75 
>> and 4 Cortex A-55. Task placements and subsequently cpu load will be 
>> different for both the platforms. With the same workload, I will 
>> expect Rockchip to system to be more loaded than sdm845. Having said 
>> that, what cpu-freq governor are you using on both the systems.
>>
> I'm using sched-util on both of the systems.
> 
> I've tried a number of different ways of forcing builds only on the A-75 
> cores, and I simply cannot get the load to be "enough" to kick in the 
> boost frequency.
> 
> An example being
> 
> git clone https://github.com/zellij-org/zellij.git
> 
> cd zellij
> 
> taskset --cpu-list 4-7 cargo build --release
> 
> git clean -fdx
> 
> taskset --cpu-list 6-7 cargo build --release

Thanks for the pointers, I'll give it a try when I sort out this
Rockchip boost setup.

> 
> 
> On my C630, it never goes higher than 85C with the 4 cores being used, 
> and with 2, it never goes about 65C and I do not get any 2.96GHz.  It's 
> currently sitting at "6" in the time_in_state for 2965800.
> 
> 
> --steev
> 

Thank you for your support.

Regards,
Lukasz

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2444B28B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 19:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbhKISQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 13:16:26 -0500
Received: from foss.arm.com ([217.140.110.172]:37040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239343AbhKISQZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 13:16:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 468DEED1;
        Tue,  9 Nov 2021 10:13:39 -0800 (PST)
Received: from [10.57.26.224] (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB763F7F5;
        Tue,  9 Nov 2021 10:13:35 -0800 (PST)
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
From:   Lukasz Luba <lukasz.luba@arm.com>
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
 <d83a5c25-2eae-3626-f78a-e42915076556@arm.com>
 <ac3f1771-0516-48dd-ee4d-5752e0433472@kali.org>
 <19ecab72-4a2f-1f4a-b999-d3967a4a1a76@arm.com>
Message-ID: <676d79ca-ae2e-f5fa-1e54-253efd6934d4@arm.com>
Date:   Tue, 9 Nov 2021 18:13:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <19ecab72-4a2f-1f4a-b999-d3967a4a1a76@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/9/21 4:22 PM, Lukasz Luba wrote:
> 
> 
> On 11/9/21 3:46 PM, Steev Klimaszewski wrote:
>>
>> On 11/9/21 2:29 AM, Lukasz Luba wrote:
>>> Hi Steev,
>>>
>>> That's interesting what you've done with Rockchip RK3399.
>>> I would like to reproduce your experiment on my RockPI 4B v1.3.
>>> Could you tell me how you to add this boost frequency that you have
>>> mentioned in some previous emails?
>>>
>>> I want to have similar setup to yours and I'll check all the subsystems
>>> involved in the decision making process for triggering this boost freq.
>>>
>>> Thank you for your support.
>>>
>>> Regards,
>>> Lukasz
>>
>>
>> Hi Lukasz,
>>
>> It was actually something that Armbian had been doing as an overlay 
>> for their setup, and I thought, why does it need to be an overlay, 
>> when we could simply hide it behind turbo-mode so that if users want 
>> to overclock, they simply echo 1 and if it's unstable or cooling/power 
>> isn't enough, they can echo 0 or leave it off (boost defaults to off) 
>> - so that being said:
>>
>> I apply this patch 
>> https://gitlab.com/kalilinux/build-scripts/kali-arm/-/blob/master/patches/pinebook-pro/pbp-5.14/rk3399-opp-overclock-2GHz-turbo-mode.patch 
>> which adds the 1.5GHz for little cores and 2GHz for the big to the 
>> rk3399 dtsi
>>
>> To enable at boot time, I simply have "echo 1 > 
>> /sys/devices/system/cpu/cpufreq/boost" in my /etc/rc.local  And to 
>> disable, simply echo 0 in there (it defaults to 0 so it's off and most 
>> users won't know it exists.)
>>
>> I'm pretty sure this is "abusing" turbo-mode, but it works well enough...
>>
>> Hope that helps,
>>
> 
> Yes, that help. Thank you for the info.
> I'll play a bit with this boosting and try to figure out
> the mechanisms.
> 
> For the $subject patch set, I'm going to send v4, since
> it's not affecting the boost usage. The newly introduced
> interface must handle these boost frequency values and not
> simply ignore them with also printing a warning.
> They are valid frequencies and we should just put 0 to
> the thermal pressure in such cases.
> 

I think I have figure out what is going on with the issue that
you've reported. On this rockchip platform you are probably using
step-wise thermal governor, which tries to decrease/increase
max allowed frequency step-by-step walking through the sorted
frequencies. So it would always set the thermal pressure to 0
when the thermal throttling is gone.
On the Qcom platform there is a different policy in HW/FW which
controls thermal and it can simple remove clamping 'instantly'
and allow all frequencies also the boost one. The highest possible
frequency is passed then to the this thermal pressure machinery.
So we see the warning that the boost frequency value is trying to
be passed to this arch_update_thermal_pressure(), but we ignore
such big frequency value and unfortunately do not clean the previously
set thermal pressure. Then the scheduler still sees the reduced
capacity on that CPU and cannot request higher frequencies.

The v4 patch would allow to pass the boost frequencies values, so
the issue would be solved.

Regards,
Lukasz

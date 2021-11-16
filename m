Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBA452CC6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 09:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhKPIb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 03:31:59 -0500
Received: from foss.arm.com ([217.140.110.172]:41582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhKPIb5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Nov 2021 03:31:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BAEAD6E;
        Tue, 16 Nov 2021 00:28:59 -0800 (PST)
Received: from [10.57.28.207] (unknown [10.57.28.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 410693F5A1;
        Tue, 16 Nov 2021 00:28:55 -0800 (PST)
Subject: Re: [PATCH v4 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure
 update function
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211109195714.7750-1-lukasz.luba@arm.com>
 <20211109195714.7750-5-lukasz.luba@arm.com>
 <02a848c8-a672-f3df-7144-979a9df71fcb@linaro.org>
 <911760d9-b137-5c79-d072-c2f473a3cc6a@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6d667cef-3c37-7c8f-bc69-da907ac06e3f@arm.com>
Date:   Tue, 16 Nov 2021 08:28:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <911760d9-b137-5c79-d072-c2f473a3cc6a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thara,

On 11/15/21 11:39 PM, Thara Gopinath wrote:
> 
> 
> On 11/15/21 3:57 PM, Thara Gopinath wrote:
>>
>>
>> On 11/9/21 2:57 PM, Lukasz Luba wrote:
>>> Thermal pressure provides a new API, which allows to use CPU frequency
>>> as an argument. That removes the need of local conversion to capacity.
>>> Use this new API and remove old local conversion code.
>>>
>>> The new arch_update_thermal_pressure() also accepts boost frequencies,
>>> which solves issue in the driver code with wrong reduced capacity
>>> calculation. The reduced capacity was calculated wrongly due to
>>> 'policy->cpuinfo.max_freq' used as a divider. The value present there 
>>> was
>>> actually the boost frequency. Thus, even a normal maximum frequency 
>>> value
>>> which corresponds to max CPU capacity (arch_scale_cpu_capacity(cpu_id))
>>> is not able to remove the capping.
> 
> Also I failed to mention that, currently freq_factor is initialized as 
> cpuinfo.max_freq / 1000 which means again all the issues you mentioned 
> below can be hit, if some cpufreq driver decides to set boost at init.
> I have sent a patch earlier today to fix this.

Yes, you are right.

> 
> https://lore.kernel.org/linux-arm-msm/20211115201010.68567-1-thara.gopinath@linaro.org/T/#u 
> 
> 

Looking at the change, it makes sense. I'll try to respond to that
patch.

Thank you for looking into this issue.

Regards,
Lukasz

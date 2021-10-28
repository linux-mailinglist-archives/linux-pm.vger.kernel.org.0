Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFA43DBD6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhJ1HVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 03:21:45 -0400
Received: from foss.arm.com ([217.140.110.172]:51590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhJ1HVi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 03:21:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 965D01063;
        Thu, 28 Oct 2021 00:19:11 -0700 (PDT)
Received: from [10.57.25.153] (unknown [10.57.25.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1B13F73D;
        Thu, 28 Oct 2021 00:19:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-2-lukasz.luba@arm.com>
 <20211028054459.dve6s2my2tq7odem@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3e1807d3-82cd-7ade-d361-e1982a4848a9@arm.com>
Date:   Thu, 28 Oct 2021 08:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20211028054459.dve6s2my2tq7odem@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/28/21 6:44 AM, Viresh Kumar wrote:
> On 15-10-21, 15:45, Lukasz Luba wrote:
>> +/**
>> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
>> + * @cpus	: The related CPUs for which capacity has been reduced
>> + * @capped_freq	: The maximum allowed frequency that CPUs can run at
> 
> Maybe replace tabs with spaces here ?

Sure

> 
>> + *
>> + * Update the value of thermal pressure for all @cpus in the mask. The
>> + * cpumask should include all (online+offline) affected CPUs, to avoid
>> + * operating on stale data when hot-plug is used for some CPUs. The
>> + * @capped_freq must be less or equal to the max possible frequency and
>> + * reflects the currently allowed max CPUs frequency due to thermal capping.
>> + * The @capped_freq must be provided in kHz.
>> + */
>> +void topology_thermal_pressure_update(const struct cpumask *cpus,
>> +				      unsigned long capped_freq)
>> +{
>> +	unsigned long max_capacity, capacity;
>> +	int cpu;
>> +
>> +	if (!cpus)
> 
> I will drop this and let the kernel crash :)

OK :)

> 
>> +		return;
>> +
>> +	cpu = cpumask_first(cpus);
>> +	max_capacity = arch_scale_cpu_capacity(cpu);
>> +
>> +	/* Convert to MHz scale which is used in 'freq_factor' */
>> +	capped_freq /= 1000;
> 
> We should make sure capped_freq > freq_factor and WARN if not. This will also
> get rid of similar checks at the users.

OK, I'll change that.

Thank you for the review.

Regards,
Lukasz

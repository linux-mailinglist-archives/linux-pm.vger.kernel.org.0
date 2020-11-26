Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FEC2C5697
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 15:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbgKZOCp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 09:02:45 -0500
Received: from foss.arm.com ([217.140.110.172]:33816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389434AbgKZOCp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 09:02:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C030A31B;
        Thu, 26 Nov 2020 06:02:44 -0800 (PST)
Received: from [10.57.29.239] (unknown [10.57.29.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82CB33F71F;
        Thu, 26 Nov 2020 06:02:43 -0800 (PST)
Subject: Re: [PATCH v4 0/3] Improve the estimations in Intelligent Power
 Allocation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, Dietmar.Eggemann@arm.com, ionela.voinescu@arm.com
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <e953e887-0fc7-8375-9e5d-1be339f48216@arm.com>
 <f9899f7b-0bc9-40e2-4969-eb76bd11ed5b@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ef6bcc10-7034-0ac1-b832-938393682d2f@arm.com>
Date:   Thu, 26 Nov 2020 14:02:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f9899f7b-0bc9-40e2-4969-eb76bd11ed5b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/26/20 1:09 PM, Daniel Lezcano wrote:
> On 26/11/2020 13:49, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 11/24/20 4:10 PM, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The Intelligent Power Allocation (IPA) estimates the needed
>>> coefficients for
>>> internal algorithm. It can also estimate the sustainable power value
>>> when the
>>> DT has not provided one. Fix the 'k_i' coefficient which might be to big
>>> related to the other values, when the sustainable power is in an abstract
>>> scale. Do the estimation of sustainable power only once and avoid
>>> expensive
>>> calculation every time the IPA is called. Do the estimation of PID
>>> constants
>>> when there was user update via sysfs to sustainable power.
>>>
>>> The patch set should apply on top next-20201124
>>>
>>> Changes:
>>> v4:
>>> - added new function get_sustainable_power() which handles use cases
>>>     when the value should be estimated again or simply returned
>>> - added sustainable_power in the power_allocator_params to track if there
>>>     was a change to sustainable_power by the user via sysfs
>>> - addressed Daniel's comments that sustainable power set via sysfs should
>>>     trigger PID coefficients estimation
>>> - removed 'force' argument from estimate_pid_constants() and make it
>>> ready
>>>     for updates due to new value for sust. power from sysfs
>>> - abandoned the design from v3 with a single function responsible for
>>>     estimation both sust. power and PID const. requested by Ionela
>>> v3 [1]:
>>> - changed estimate_pid_constants to estimate_tzp_constants and related
>>> comments
>>> - estimate the PID coefficients always together with sust. power
>>> - added print indicating that we are estimating sust. power and PID
>>> const.
>>> - don't use local variable 'sustainable_power'
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/20201009135850.14727-1-lukasz.luba@arm.com/
>>>
>>> Lukasz Luba (3):
>>>     thermal: power allocator: change the 'k_i' coefficient estimation
>>>     thermal: power allocator: refactor sustainable power estimation
>>>     thermal: power allocator: change the 'k_*' always in
>>>       estimate_pid_constants()
>>>
>>>    drivers/thermal/gov_power_allocator.c | 76 +++++++++++++++++----------
>>>    1 file changed, 49 insertions(+), 27 deletions(-)
>>>
>>
>> Gentle ping. This is a self contained change to only power allocator
>> file. It addresses also your requirement regarding sustainable_power
>> changed via sysfs.
>>
>> Could you take it please? It should apply smoothly in your tree.
> 
> Actually, I'm waiting for Ionela and Dietmar ack.
> 
> 

Are they maintainers of this file that you need their ACKs?
Maybe I should drop mine then.

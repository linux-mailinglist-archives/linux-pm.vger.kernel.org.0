Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C59F44AF0E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 14:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhKIN4Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 08:56:24 -0500
Received: from foss.arm.com ([217.140.110.172]:34088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhKIN4Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 08:56:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26AAF2B;
        Tue,  9 Nov 2021 05:53:38 -0800 (PST)
Received: from [10.57.26.224] (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33FB3F70D;
        Tue,  9 Nov 2021 05:53:34 -0800 (PST)
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
 <2160a0b8-59ec-03a1-1fd5-a3f98085be07@arm.com>
 <e244e3aa9fc323973d7da8d3ebc3e1fad1fdb731.camel@linux.intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5e4d7661-1e91-0c72-ae02-b2c60c2ad95e@arm.com>
Date:   Tue, 9 Nov 2021 13:53:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e244e3aa9fc323973d7da8d3ebc3e1fad1fdb731.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

On 11/9/21 1:23 PM, Srinivas Pandruvada wrote:
> Hi Lukasz,
> 
> On Tue, 2021-11-09 at 12:39 +0000, Lukasz Luba wrote:
>> Hi Ricardo,
>>
>>
>> On 11/6/21 1:33 AM, Ricardo Neri wrote:
>>> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>
>>> Add a new netlink event to notify change in CPU capabilities in
>>> terms of
>>> performance and efficiency.
>>
>> Is this going to be handled by some 'generic' tools? If yes, maybe
>> the values for 'performance' might be aligned with capacity
>> [0,1024] ? Or are they completely not related so the mapping is
>> simply impossible?
>>
> 
> That would have been very useful.
> 
> The problem is that we may not know the maximum performance as system
> may be booting with few CPUs (using maxcpus kernel command line) and
> then user hot adding them. So we may need to rescale when we get a new
> maximum performance CPU and send to user space.
> 
> We can't just use max from HFI table at in instance as it is not
> necessary that HFI table contains data for all CPUs.
> 
> If HFI max performance value of 255 is a scaled value to max
> performance CPU value in the system, then this conversion would have
> been easy. But that is not.

I see. I was asking because I'm working on similar interface and
just wanted to understand your approach better. In my case we
would probably simply use 'capacity' scale, or more
precisely available capacity after subtracting 'thermal pressure' value.
That might confuse a generic tool which listens to these socket
messages, though. So probably I would have to add a new
THERMAL_GENL_ATTR_CPU_CAPABILITY_* id
to handle this different normalized across CPUs scale.

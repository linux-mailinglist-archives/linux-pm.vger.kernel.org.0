Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F562C6753
	for <lists+linux-pm@lfdr.de>; Fri, 27 Nov 2020 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgK0N6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 08:58:51 -0500
Received: from foss.arm.com ([217.140.110.172]:42562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgK0N6v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Nov 2020 08:58:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C10FF1516;
        Fri, 27 Nov 2020 05:58:50 -0800 (PST)
Received: from [10.57.26.227] (unknown [10.57.26.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197433F70D;
        Fri, 27 Nov 2020 05:58:47 -0800 (PST)
Subject: Re: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal
 documentation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, gao.yunxiao6@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, robh+dt@kernel.org,
        javi.merino@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
References: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
 <724ddf78-483c-2cf3-441c-4885af8425a9@arm.com>
 <1af5220c-f598-58f4-488e-fdd505477ed5@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <fc2e095f-d417-1547-4075-9ece1aeaaf4d@arm.com>
Date:   Fri, 27 Nov 2020 13:58:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1af5220c-f598-58f4-488e-fdd505477ed5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/27/20 1:26 PM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 27/11/2020 10:27, Lukasz Luba wrote:
>>
>>
>> On 11/27/20 8:35 AM, gao.yunxiao6@gmail.com wrote:
>>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>>
>>> virtual thermal node definition description in dts file
>>>
>>> Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
>>> ---
> 
> [ ... ]
> 
>> It's coming back. There were attempts to solve this problem.
>> Javi tried to solved this using hierarchical thermal zones [1].
>> It was even agreed (IIRC during LPC) but couldn't continue. Then Eduardo
>> was going to continue this (last message at [3]). Unfortunately,
>> development stopped.
>>
>> I also have out-of-tree similar implementation for my Odroid-xu4,
>> which does no have an 'SoC' sensor, but have CPU sensors and needs
>> some aggregation function to get temperature.
>>
>> I can pick up Javi's patches and continue 'hierarchical thermal zones'
>> approach.
>>
>> Javi, Daniel, Rui what do you think?
> 
> I already worked on the hierarchical thermal zones and my opinion is
> that fits not really well.
> 
> We want to define a new feature because the thermal framework is built
> on the 1:1 relationship between a governor and a thermal zone.
> 
> Practically speaking, we want to mitigate two thermal zones from one
> governor, especially here the IPA governor.
> 
> The DTPM framework is being implemented to solve that by providing an
> automatic power rebalancing between the power manageable capable devices.
> 
> In our case, the IPA would stick on the 'sustainable-power' resulting on
> the aggregation of the two performance domains and set the power limit
> on the parent node. The automatic power rebalancing will ensure maximum
> throughput between the two performance domains instead of capping the whole.
> 
> 

Make sense. Thank you for sharing valuable opinion.

Regards,
Lukasz

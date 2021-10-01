Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BBD41EB7D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJALNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 07:13:37 -0400
Received: from foss.arm.com ([217.140.110.172]:40486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352896AbhJALNh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Oct 2021 07:13:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F548106F;
        Fri,  1 Oct 2021 04:11:53 -0700 (PDT)
Received: from [10.57.23.247] (unknown [10.57.23.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034B43F70D;
        Fri,  1 Oct 2021 04:11:51 -0700 (PDT)
Subject: Re: [RFD] Remove the userspace governor and the cooling device set
 state sysfs entry
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <d46b5007-428b-5f31-52d9-a964cc60ad92@linaro.org>
 <39728f24-7781-543c-ad28-fd1c7552d96a@arm.com>
 <2b8300b2-4678-3e3c-71e3-6d276b99eb07@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a3f2807b-0d67-b159-430b-33be22409179@arm.com>
Date:   Fri, 1 Oct 2021 12:11:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2b8300b2-4678-3e3c-71e3-6d276b99eb07@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/1/21 11:30 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 30/09/2021 12:10, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 9/22/21 10:59 AM, Daniel Lezcano wrote:
>>>
>>> Hi,
>>>
>>> the userspace governor is sending temperature when polling is active and
>>> trip point crossed events. Nothing else.
>>>
>>> In the other side, the cooling device have their cooling device
>>> set_cur_state read-writable all the time.
>>>
>>> The thermal framework is wrongly used by userspace as a power capping
>>> framework by acting on the cooling device opaque state. This one then
>>> competes with the in-kernel governor decision.
>>>
>>> As the new netlink thermal notification is able to provide the same
>>> information than the userspace governor.
>>>
>>> I propose to remove the userspace governor and the cur_state entry in
>>> the sysfs exported file.
>>>
>>> The DTPM framework is the right framework to do power capping and
>>> moreover it deals with the aggregation via the dev pm qos.
>>>
>>> Does it make sense ?
>>
>> It sounds that we should be OK with the information from netlink.
>> I don't see objections. We can also extend the netlink packet when
>> needed. I'm fine with removing the user-space governor.
> 
> thank you for your answer. I'll propose a patch with a warn when the
> userspace governor is registered in order to let know people the
> governor is deprecated.
> 
> Probably, it would make sense to emit a warning also when the cooling
> device state is set from userspace.
> 
> For the next release, we should be able to drop the userspace governor
> and make the cooling device state read-only.
> 
> Does it make sense ?
> 
> 

Yes, it makes sense.

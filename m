Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4436673D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhDUIqr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 04:46:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237188AbhDUIqq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 04:46:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B3711B3;
        Wed, 21 Apr 2021 01:46:13 -0700 (PDT)
Received: from [10.57.27.219] (unknown [10.57.27.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AC43F73B;
        Wed, 21 Apr 2021 01:46:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: power_allocator: update once cooling
 devices when temp is low
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210419084536.25000-1-lukasz.luba@arm.com>
 <20210419084536.25000-3-lukasz.luba@arm.com>
 <c69e2ba0-b382-01a0-292f-019fffd365e0@linaro.org>
 <55943d6f-0f72-215d-1dd4-bf3996092df7@arm.com>
 <91411c9c-d78e-8ba6-1cd3-da6879bc5ceb@linaro.org>
 <0fc57590-cc7c-9e04-16bc-13b7b787ad2f@arm.com>
 <6ca7915a-9d31-10bd-4f9b-2f815a41df05@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <aa57e829-082a-6387-445b-d1f7aba488d9@arm.com>
Date:   Wed, 21 Apr 2021 09:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6ca7915a-9d31-10bd-4f9b-2f815a41df05@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/20/21 10:03 PM, Daniel Lezcano wrote:
> On 20/04/2021 22:01, Lukasz Luba wrote:
>>
>>
>> On 4/20/21 4:24 PM, Daniel Lezcano wrote:
>>> On 20/04/2021 16:21, Lukasz Luba wrote:
>>>> Hi Daniel,
>>>>
>>>> On 4/20/21 2:30 PM, Daniel Lezcano wrote:
>>>>> On 19/04/2021 10:45, Lukasz Luba wrote:
>>>>
>>>> [snip]
> 
> [ ... ]
> 
>>
>> That new approach should work. I can test your patch with this new
>> functions and re-base my work on top of it.
>> Or you like me to write such patch and send it?
> 
> At your convenience. I'm pretty busy ATM with more patches to review, so
> if you can handle that change that will be nice. Otherwise, I can take
> care of it but later.
> 

OK, so I will create such patch and add your name in tags:
Co-developed-by: and Signed-off-by:
plus also a lore.kernel.org link in the patch commit message into this
discussion. Thanks for having a look at this.

Regards,
Lukasz

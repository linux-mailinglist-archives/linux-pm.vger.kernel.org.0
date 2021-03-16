Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4A33D4AE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 14:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhCPNQQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 09:16:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhCPNQP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 09:16:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C06FE101E;
        Tue, 16 Mar 2021 06:16:14 -0700 (PDT)
Received: from [10.57.20.184] (unknown [10.57.20.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6A43F792;
        Tue, 16 Mar 2021 06:16:11 -0700 (PDT)
Subject: Re: [PATCH] thermal: power_allocator: using round the division when
 re-divvying up power
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     gao.yunxiao6@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
References: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
 <9c14451e-be6f-0713-4c26-8b67e1fa51a5@arm.com>
 <381a12bf-c917-c2c4-1915-f129221d6475@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <922427b0-4140-6f4a-4bad-9043bdc5ba99@arm.com>
Date:   Tue, 16 Mar 2021 13:16:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <381a12bf-c917-c2c4-1915-f129221d6475@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/16/21 1:15 PM, Daniel Lezcano wrote:
> On 15/03/2021 10:51, Lukasz Luba wrote:
>>
>>
>> On 3/15/21 8:25 AM, gao.yunxiao6@gmail.com wrote:
>>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>>
>>> The division is used directly in re-divvying up power, the decimal
>>> part will
>>> be discarded, devices will get less than the extra_actor_power - 1.
>>> if using round the division to make the calculation more accurate.
>>>
>>> For example:
>>> actor0 received more than it's max_power, it has the extra_power 759
>>> actor1 received less than it's max_power, it require extra_actor_power
>>> 395
>>> actor2 received less than it's max_power, it require extra_actor_power
>>> 365
>>> actor1 and actor2 require the total capped_extra_power 760
>>>
>>> using division in re-divvying up power
>>> actor1 would actually get the extra_actor_power 394
>>> actor2 would actually get the extra_actor_power 364
>>>
>>> if using round the division in re-divvying up power
>>> actor1 would actually get the extra_actor_power 394
>>> actor2 would actually get the extra_actor_power 365
>>>
>>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
>>> ---
> 
> Applied, thanks
> 

thank you Daniel!

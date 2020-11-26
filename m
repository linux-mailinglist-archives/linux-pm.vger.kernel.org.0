Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6532C5748
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbgKZOpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 09:45:17 -0500
Received: from foss.arm.com ([217.140.110.172]:35256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389316AbgKZOpR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 09:45:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A6E31B;
        Thu, 26 Nov 2020 06:45:16 -0800 (PST)
Received: from [10.57.29.239] (unknown [10.57.29.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E76B3F71F;
        Thu, 26 Nov 2020 06:45:15 -0800 (PST)
Subject: Re: [PATCH v4 0/3] Improve the estimations in Intelligent Power
 Allocation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, Dietmar.Eggemann@arm.com, ionela.voinescu@arm.com
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <e953e887-0fc7-8375-9e5d-1be339f48216@arm.com>
 <f9899f7b-0bc9-40e2-4969-eb76bd11ed5b@linaro.org>
 <ef6bcc10-7034-0ac1-b832-938393682d2f@arm.com>
 <fc3228c2-d668-6f32-8965-00896b630351@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9680cd44-c22e-2f5e-43ec-4a7f16680a45@arm.com>
Date:   Thu, 26 Nov 2020 14:45:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fc3228c2-d668-6f32-8965-00896b630351@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/26/20 2:30 PM, Daniel Lezcano wrote:
> On 26/11/2020 15:02, Lukasz Luba wrote:
> 
> [ ... ]
> 
>>>> changed via sysfs.
>>>>
>>>> Could you take it please? It should apply smoothly in your tree.
>>>
>>> Actually, I'm waiting for Ionela and Dietmar ack.
>>>
>>>
>>
>> Are they maintainers of this file that you need their ACKs?
>> Maybe I should drop mine then.
> 
> Ok let me clarify :)
> 
> In general when someone comments on the changes, I usually wait for the
> consensus before merging the patches. If the persons who commented
> before are unresponsive, depending on the context and my perception, I
> apply the changes or not.
> 
> I'm giving the opportunity to Ionela to review the series again as she
> commented the previous version (and gave a reviewed-by). I thought also
> Dietmar commented the series but apparently I was wrong.
> 
> As you stated, you are the maintainer of the subsystem, so if there are
> no acked-by or reviewed-by, the series will be applied anyway soon.
> 
> Meanwhile, they are in the 'testing' branch of the tree, the antechamber
> of 'linux-next' and 'next' ;)
> 

Thank you clarifying this and taking the patches into the testing
branch.

Regards,
Lukasz

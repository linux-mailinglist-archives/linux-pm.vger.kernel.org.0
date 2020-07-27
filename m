Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF122E7A1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgG0IVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:21:48 -0400
Received: from foss.arm.com ([217.140.110.172]:39372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0IVs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 04:21:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B2CD6E;
        Mon, 27 Jul 2020 01:21:48 -0700 (PDT)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113F43F71F;
        Mon, 27 Jul 2020 01:21:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Exynos5422 DMC: adjust to new devfreq monitoring
 mechanism
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
References: <CGME20200710191144epcas1p30f82bf6371f7f09a4e1ea1262234f392@epcas1p3.samsung.com>
 <20200710191122.11029-1-lukasz.luba@arm.com>
 <b6e3e7af-203d-a24e-2757-c32236f494d4@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <82080e84-a400-88e3-274c-58e57c80c4c0@arm.com>
Date:   Mon, 27 Jul 2020 09:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b6e3e7af-203d-a24e-2757-c32236f494d4@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/24/20 2:40 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 7/11/20 4:11 AM, Lukasz Luba wrote:
>> Hi all,
>>
>> This is a v2 patch set adjusting Exynos5422 DMC to the new devfreq monitoring
>> mechanism. This time the IRQ mode is explicitly controlled using module
>> parameter (in default the driver uses polling mode = devfreq monitoring).
>>
>> The detailed cover letter describing the topic can be found here [1].
>>
>> The patches should apply on top of Chanwoo's devfreq-next branch, where
>> the new devfreq mechanism is queued [2]. If there is no objections
>> I think they can go via this tree, since they logically use it.
>>
>> Changes:
>> v2:
>> - added Reviewed-by from Chanwoo for patch 1/2
>> - added module_param which controls the mode in which the driver operates
>> - switched in default to devfreq monitoring mechanism instead of interrupts
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://lore.kernel.org/linux-pm/20200708153420.29484-1-lukasz.luba@arm.com/
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next
>>
>> Lukasz Luba (2):
>>    memory: samsung: exynos5422-dmc: Adjust polling interval and
>>      uptreshold
>>    memory: samsung: exynos5422-dmc: Add module param to control IRQ mode
>>
>>   drivers/memory/samsung/exynos5422-dmc.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
> 
> Applied them to devfreq-next branch. Thanks.
> 

Thank you Chanwoo

Regards,
Lukasz

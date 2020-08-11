Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27D62418DB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHKJ1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 05:27:36 -0400
Received: from foss.arm.com ([217.140.110.172]:35860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgHKJ1f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 05:27:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0DC1063;
        Tue, 11 Aug 2020 02:27:35 -0700 (PDT)
Received: from [10.37.12.49] (unknown [10.37.12.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CED8D3F22E;
        Tue, 11 Aug 2020 02:27:33 -0700 (PDT)
Subject: Re: [RFC] memory: exynos5422-dmc: Document mutex scope
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200724180857.22119-1-krzk@kernel.org>
 <3522860a-8158-6e71-9d65-01d0e0c15f0d@arm.com>
 <CAJKOXPe3OeKFhmtbF4OZup_ii_rxRHTaSK5BT-3T6ijqUukqtg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6db3a6a4-fe56-d448-14c7-ed43de809acb@arm.com>
Date:   Tue, 11 Aug 2020 10:27:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe3OeKFhmtbF4OZup_ii_rxRHTaSK5BT-3T6ijqUukqtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/9/20 10:12 AM, Krzysztof Kozlowski wrote:
> On Tue, Aug 04, 2020 at 11:40:07AM +0100, Lukasz Luba wrote:
>> Hi Krzysztof,
>>
>> On 7/24/20 7:08 PM, Krzysztof Kozlowski wrote:
>>> Document scope of the mutex used by driver.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>> ---
>>>
>>> It seems mutex was introduced to protect:
>>> 1. setting actual frequency/voltage,
>>> 2. dmc->curr_rate (in exynos5_dmc_get_cur_freq()).
>>>
>>> However dmc->curr_rate in exynos5_dmc_get_status() is not protected. Is
>>> it a bug?
>>
>> The callback get_dev_status() from devfreq->profile, which here is the
>> exynos5_dmc_get_status() should be already called with devfreq->lock
>> mutex hold, like e.g from simple_ondemand governor or directly
>> using update_devfreq exported function:
>> update_devfreq()
>>    ->get_target_freq()
>>      devfreq_update_stats()
>>          df->profile->get_dev_status()
>>
>> The dmc->curr_rate is also used from sysfs interface from devfreq.
>> The local dmc lock serializes also this use case (when the HW freq
>> has changed but not set yet into curr_rate.
> 
> These are different locks. You cannot protect dmc->curr_rate with
> devfreq->lock in one place and dmc-lock in other place. This won't
> protect it.

There are different paths that framework goes and mainly they are
protected by the df->lock.
But I tend to agree, I will send a patch which adds some locking.

Regards,
Lukasz

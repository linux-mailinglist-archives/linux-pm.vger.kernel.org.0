Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AD330D0E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 13:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCHMEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 07:04:32 -0500
Received: from foss.arm.com ([217.140.110.172]:36840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhCHMET (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 07:04:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC600D6E;
        Mon,  8 Mar 2021 04:04:18 -0800 (PST)
Received: from [10.57.19.192] (unknown [10.57.19.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCB353F70D;
        Mon,  8 Mar 2021 04:04:16 -0800 (PST)
Subject: Re: [PATCH v5 1/4] PM / devfreq: Register devfreq as a cooling device
 on demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     cwchoi00@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
 <c6d6781a-759c-0361-aaaa-28a625e4809b@arm.com>
 <bd6c8e7f-e626-b6f4-65b9-f7ea96098677@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c33ea5f5-1f0e-d081-5f8d-9319536ca215@arm.com>
Date:   Mon, 8 Mar 2021 12:04:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bd6c8e7f-e626-b6f4-65b9-f7ea96098677@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/8/21 12:00 PM, Daniel Lezcano wrote:
> On 08/03/2021 10:53, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> In general the approach is good. If there is a special GPU driver, which
>> would like to provide 'struct devfreq_cooling_power *' it would leave
>> 'is_cooling_device=false' and register manually:
>> devfreq_cooling_em_register(df, dfc_power);
>>
>> Please find only a few minor comments below.
>>
>>
>> On 3/8/21 9:16 AM, Daniel Lezcano wrote:
>>> Currently the default behavior is to manually having the devfreq
>>> backend to register themselves as a devfreq cooling device.
>>>
>>> Instead of adding the code in the drivers for the thermal cooling
>>> device registering, let's provide a flag in the devfreq's profile to
>>> tell the common devfreq code to register the newly created devfreq as
>>> a cooling device.
>>>
>>> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
> 
> [ ... ]
> 
>>> +    struct thermal_cooling_device *cdev;
>>
>> The linux/thermal.h for 'cdev' would be needed in this header.
> 
> May be just a forward declaration ?
> 
> struct thermal_cooling_device;

Make sense

Regards,
Lukasz

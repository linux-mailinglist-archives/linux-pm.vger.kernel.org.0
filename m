Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF133AE8F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCOJWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 05:22:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCOJWK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 05:22:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFBBA1FB;
        Mon, 15 Mar 2021 02:22:09 -0700 (PDT)
Received: from [10.57.12.51] (unknown [10.57.12.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72EFB3F70D;
        Mon, 15 Mar 2021 02:22:08 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: unlock mutex and free devfreq struct in
 error path
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <CGME20210312184551epcas1p2fe579b2a736cac2814b8a236869c4c27@epcas1p2.samsung.com>
 <20210312184534.6423-1-lukasz.luba@arm.com>
 <aa65398e-6de6-92df-3c27-a8a7f43eda10@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ecd8866a-85a3-e2cc-7e35-06b3e2afb003@arm.com>
Date:   Mon, 15 Mar 2021 09:22:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aa65398e-6de6-92df-3c27-a8a7f43eda10@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 3/15/21 7:20 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 3/13/21 3:45 AM, Lukasz Luba wrote:
>> The devfreq->lock is held for time of setup. Release the lock in the
>> error path, before jumping to the end of the function.
>>
>> Change the goto destination which frees the allocated memory.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/devfreq/devfreq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index b6d3e7db0b09..99b2eeedc238 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -822,7 +822,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>   
>>   	if (devfreq->profile->timer < 0
>>   		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
>> -		goto err_out;
>> +		mutex_unlock(&devfreq->lock);
>> +		goto err_dev;
>>   	}
>>   
>>   	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>>
> 
> Looks good to me. But, need to add the following information
> and please use capital letter of the first character of patch title. Thanks.

thanks for looking at this, sure, I'll use the capital letter.

> 
> Fixes: 4dc3bab8687f ("PM / devfreq: Add support delayed timer for polling mode")
> 
> Also, need to send it to stable lkml.
> 

I'll add the 'Fixes' tag and send v2 also into stable v5.8+:

Cc: v5.8+ <stable@vger.kernel.org> # v5.8+

Regards,
Lukasz

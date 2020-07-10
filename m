Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC59C21B6AE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJNlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:41:36 -0400
Received: from foss.arm.com ([217.140.110.172]:47256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJNlg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 09:41:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F14C1FB;
        Fri, 10 Jul 2020 06:41:35 -0700 (PDT)
Received: from [10.37.12.58] (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6843F3F8C6;
        Fri, 10 Jul 2020 06:41:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
 <c016e256-65a6-8075-d88d-c3fad4815b4d@samsung.com>
 <20200710131921.GA23039@pi3>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4bfa227e-3a6b-dfe2-140b-b402dea52231@arm.com>
Date:   Fri, 10 Jul 2020 14:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200710131921.GA23039@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/10/20 2:19 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 10, 2020 at 03:13:18PM +0200, Marek Szyprowski wrote:
>> Hi Lukasz,
>>
>> On 10.07.2020 10:34, Lukasz Luba wrote:
>>> Hi Chanwoo,
>>>
>>> On 7/9/20 5:08 AM, Chanwoo Choi wrote:
>>>> Hi Lukasz,
>>>>
>>>> On 7/9/20 12:34 AM, Lukasz Luba wrote:
>>>>> In order to react faster and make better decisions under some
>>>>> workloads,
>>>>> benchmarking the memory subsystem behavior, adjust the polling interval
>>>>> and upthreshold value used by the simple_ondemand governor.
>>>>>
>>>>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>>    drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c
>>>>> b/drivers/memory/samsung/exynos5422-dmc.c
>>>>> index 93e9c2429c0d..e03ee35f0ab5 100644
>>>>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>>>>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>>>>> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct
>>>>> platform_device *pdev)
>>>>>             * Setup default thresholds for the devfreq governor.
>>>>>             * The values are chosen based on experiments.
>>>>>             */
>>>>> -        dmc->gov_data.upthreshold = 30;
>>>>> +        dmc->gov_data.upthreshold = 10;
>>>>>            dmc->gov_data.downdifferential = 5;
>>>>>    -        exynos5_dmc_df_profile.polling_ms = 500;
>>>>> +        exynos5_dmc_df_profile.polling_ms = 100;
>>>>>        }
>>>>>
>>>>
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>
>>> Thank you for the review. Do you think this patch could go through
>>> your tree together with your patches?
>>>
>>> I don't know Krzysztof's opinion about the patch 2/2, but
>>> I would expect, assuming the patch itself is correct, he would
>>> like to take it into his next/dt branch.
>>
>> Is there really a need to remove the interrupts property? imho they are
>> correct hw description, it just a matter of the driver to use or not to
>> use them.

Marek, I agree with you, they are correct hw description. Unfortunately,
I don't have TRM to experiment and maybe fix the interrupt mode code.

> 
> That's actually very good point. I would also prefer to leave them.
> However I understood that driver chooses mode depending on the property.

Correct

> 
> In such case, maybe as you said, let's switch to polling mode
> unconditionally?

I can make happen that the polling mode will be unconditionally
set as default.

Do you think that the interrupt mode code can still stay in the
driver, because maybe in future could be fixed?


> 
> Best regards,
> Krzysztof
> 

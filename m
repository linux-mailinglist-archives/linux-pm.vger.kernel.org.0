Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C221B590
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGJM4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 08:56:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgGJM4j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0381FB;
        Fri, 10 Jul 2020 05:56:38 -0700 (PDT)
Received: from [10.37.12.58] (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FC3C3F8C6;
        Fri, 10 Jul 2020 05:56:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com> <20200710124503.GB22897@pi3>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <0bfb4332-9a2e-9ff9-1a86-d9875a8f34bb@arm.com>
Date:   Fri, 10 Jul 2020 13:56:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200710124503.GB22897@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/10/20 1:45 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 10, 2020 at 09:34:45AM +0100, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 7/9/20 5:08 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> On 7/9/20 12:34 AM, Lukasz Luba wrote:
>>>> In order to react faster and make better decisions under some workloads,
>>>> benchmarking the memory subsystem behavior, adjust the polling interval
>>>> and upthreshold value used by the simple_ondemand governor.
>>>>
>>>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>    drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>>>> index 93e9c2429c0d..e03ee35f0ab5 100644
>>>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>>>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>>>> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>>>    		 * Setup default thresholds for the devfreq governor.
>>>>    		 * The values are chosen based on experiments.
>>>>    		 */
>>>> -		dmc->gov_data.upthreshold = 30;
>>>> +		dmc->gov_data.upthreshold = 10;
>>>>    		dmc->gov_data.downdifferential = 5;
>>>> -		exynos5_dmc_df_profile.polling_ms = 500;
>>>> +		exynos5_dmc_df_profile.polling_ms = 100;
>>>>    	}
>>>>
>>>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>>
>> Thank you for the review. Do you think this patch could go through
>> your tree together with your patches?
>>
>> I don't know Krzysztof's opinion about the patch 2/2, but
>> I would expect, assuming the patch itself is correct, he would
>> like to take it into his next/dt branch.
> 
> In the cover letter you mentioned that this is a follow up for the
> Chanwoo's patchset. But are these patches really depending on it? Can
> they be picked up independently?


They are not heavily dependent on Chanwoo's patches.
Yes, they can be picked up independently.
I just wanted to mention that the patch 1/2 was produced on the
code base which had already applied Chanwoo's patch for DMC.
If you like to take both 1/2 and 2/2 into your tree, it's good.

Thank you for having a look on this.

Regards,
Lukasz


> 
> The DTS patch must go through arm soc, so I will take it. If it really
> depends on driver changes, then it has to wait for next release.
> 
> Best regards,
> Krzysztof
> 

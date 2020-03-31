Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1980019A257
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgCaXOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 19:14:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53364 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgCaXOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 19:14:31 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200331231430epoutp0315937ebab566a37a46a778bebc50d3ee~BhonKfJq51846318463epoutp03R
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 23:14:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200331231430epoutp0315937ebab566a37a46a778bebc50d3ee~BhonKfJq51846318463epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585696470;
        bh=Jfjav/syMA5mc33iuPE6H6qKp+mhWqXJuvcs/sUiTh4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HhC/8jaUr+gra30hEzC+ikUdrmdIJkwfsiaFcwB2jNUi8XBw58+APH1my9mC4W1xQ
         W5hQJyx1RoyqiYTKTXLZb5YLKIIz3kvv3fh6uQTTz7ajFm4WUsPhksehntsvNxfwMg
         lVmMFDLpyhZsIqXQJ28mt1IO3AdRWljbdOsQz+Sc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200331231429epcas1p24e84bb389283da0816f373e27b8dac0d~BhomuokTN2867928679epcas1p2n;
        Tue, 31 Mar 2020 23:14:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48sQBq34M5zMqYkp; Tue, 31 Mar
        2020 23:14:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.93.04145.0DEC38E5; Wed,  1 Apr 2020 08:14:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200331231424epcas1p32f24710db3a151c4653964b0cc48968b~Bhoh5n9rR1745217452epcas1p3-;
        Tue, 31 Mar 2020 23:14:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331231424epsmtrp1e7b545d85d584c2bb916538b594df2ed~Bhoh4lhQk2203522035epsmtrp1E;
        Tue, 31 Mar 2020 23:14:24 +0000 (GMT)
X-AuditID: b6c32a35-28dff70000001031-9f-5e83ced06fd9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.B5.04158.0DEC38E5; Wed,  1 Apr 2020 08:14:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331231424epsmtip2be0a4f56dda902cd8335741db9b7335a~BhohnzheB2561625616epsmtip2F;
        Tue, 31 Mar 2020 23:14:24 +0000 (GMT)
Subject: Re: [PATCH v1 3/5] PM / devfreq: tegra20: Use
 clk_round_rate_unboundly()
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <d74555b7-81c5-0c00-9c4e-3d923e8e6e5d@samsung.com>
Date:   Wed, 1 Apr 2020 08:23:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <8e62e4ac-081c-a1ac-f0a9-b4e882fcd3b5@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TWUwTURSGve10OqDVS92OPGgZiQsJywCVcSloXNKgiUQTH3wAxzIphG7p
        DG6YWK0ioLiBRkdBI2gUjQSoIBCCAYyiQQWC+27dFYKoUYlL28HI23/P/c79738XSqltJkOp
        TJvIO22chSaDidrWmdGRt2+6U2P6XQnsuf6XiN0unSTYjm0f1Wz/7icqtrvhGMkOFLYhNv+L
        RLKd1xezD7eeIdnfd6oI9kdDKTF/pLHv3g61sV56rDZWV+STxkJ3L2nc46lAxoHqySnk6qx5
        GTyXzjt1vM1kT8+0mQ300pVpC9P0s2KYSGY2m0DrbJyVN9CLlqVELsm0+LZH69ZxlmxfKYUT
        BDo6cZ7Tni3yugy7IBpo3pFuccx2RAmcVci2maNMduscJiYmVu8D12Rl9F3rVTl+4g2PLl5W
        uNBHTQEKogDHw5cTkqoABVNafAmB+0muQh58RvBhQFLKg28IDt3oRv9aHpUNInmiCUFpT91Q
        Sx+Cg887CD81Fq+Eo3uLFX5N4ghofnuP9EPjcJkCPtSUBCAlFqFxf1sAGoPDoOf7y4CFBieC
        5/5XpV8TOByevrgf4MfjVdBeu32ICYH2I95APQgnQdOVRrW85kR44D2ukPUUqPt0LJABcJEa
        mirzlHKGRVD54AAh67Hw/qpHLetQeLc3d0jnwNn2NlJuzkPgab6tkifioPlUkc+B8jnMhMqG
        aLkcBvWDJUg2Hg29X3er/AhgDeTlamVkKnQ/e6yQ9SQo25lP7kO0NCyONCyCNCyC9N/sBCIq
        0ATeIVjNvMA4mOH3XY0CjzdCfwkV31zWgjCF6FEa3Rx3qlbFrRM2WlsQUEp6nIZc7krVatK5
        jZt4pz3NmW3hhRak9532fmXoeJPd9xVsYhqjj42Li2PjmVl6hqEnag7etaRqsZkT+Syed/DO
        f30KKijUhTo1nxMLS8pXTNtsXvv8Bfnq8Omks4e9My68yZnWEu7Nc7RDsrGnUxvuGiF5is3U
        n9dvy/KvbbgyXzTd6roQUornnu9K2lHv/uku1z80TF+z81tsDTV5dE5yYWXY4MVaQ1QNsd4V
        9CN4S4IrqaDKu8sk/kruKhfji8wd7+oWuI+20oSQwTERSqfA/QVbzlAw0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvO6Fc81xBqePS1ms/viY0aJl1iIW
        i7NNb9gtPvbcY7W4vGsOm8Xn3iOMFp1fZrFZXDzlanG7cQWbxb9rG1ksfu6ax+LA7fH+Riu7
        x85Zd9k9Nq3qZPPobX7H5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ70+8Yy34JVBxZ+sB
        pgbGN7xdjJwcEgImEncW/2bsYuTiEBLYzSjx8lUHG0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl
        vk5qZwGpERYIlpjdP4UJxGYT0JLY/+IGG0iRiMBSJokVN7+wgySYBUokTjz7xwrR/YpR4ve8
        P2AJfgFFias/HjOC2LwCdhJbbn5lBrFZBFQk7j+6CbZBVCBMYueSx0wQNYISJ2c+AYtzCthL
        7D26G2qBusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcARqae1gPHEi/hCjAAejEg+volVznBBrYllxZe4h
        RgkOZiURXjb/hjgh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwc
        nFINjDb2go/mBbM6SxlMrORd35H/VERLOPT8HFXHs1OiecVvZej6d02WWx/0npGtdsbFzQYb
        eue3mp//Gm8YsUQ7UHrOniNpHHGir3f+rzku/Wnq3qdvzc8/ObX98t8y90dObT5WMzZqehyp
        1dT07t2hZHTI93fT/HtqKgsteA6UxZ+ZIy8t0nGoR4mlOCPRUIu5qDgRAOyX5pG8AgAA
X-CMS-MailID: 20200331231424epcas1p32f24710db3a151c4653964b0cc48968b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330232035epcas1p4dc533fd4e30d543a1cd12ebb5c5e80b3
References: <20200330231617.17079-1-digetx@gmail.com>
        <CGME20200330232035epcas1p4dc533fd4e30d543a1cd12ebb5c5e80b3@epcas1p4.samsung.com>
        <20200330231617.17079-4-digetx@gmail.com>
        <8e62e4ac-081c-a1ac-f0a9-b4e882fcd3b5@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/1/20 8:22 AM, Chanwoo Choi wrote:
> Hi Dmitry,
> 
> On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
>> The clk_round_rate() doesn't work for us properly if clock rate is bounded
>> by a min/max rate that is requested by some other clk-user because we're
>> building devfreq's OPP table based on the rounding.
>>
>> In particular this becomes a problem if display driver is probed earlier
>> than devfreq, and thus, display adds a memory bandwidth request using
>> interconnect API, which results in a minimum clock-rate being set for
>> the memory clk. In a result, the lowest devfreq OPP rate is getting
>> limited to the minimum rate imposed by the display driver.
>>
>> Let's use new clk_round_rate_unboundly() that resolves the problem by
>> rounding clock rate without taking into account min/max limits imposed by
>> active clk users.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra20-devfreq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>> index ff82bac9ee4e..1bb10ef11dfe 100644
>> --- a/drivers/devfreq/tegra20-devfreq.c
>> +++ b/drivers/devfreq/tegra20-devfreq.c
>> @@ -149,10 +149,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  
>>  	tegra->regs = mc->regs;
>>  
>> -	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>> +	max_rate = clk_round_rate_unboundly(tegra->emc_clock, ULONG_MAX);
>>  
>>  	for (rate = 0; rate <= max_rate; rate++) {
>> -		rate = clk_round_rate(tegra->emc_clock, rate);
>> +		rate = clk_round_rate_unboundly(tegra->emc_clock, rate);
>>  
>>  		err = dev_pm_opp_add(&pdev->dev, rate, 0);
>>  		if (err) {
>>
> 
> Firstly, patch1 have to be reviewed for this patch.
> I have no any objection. It looks good to me.
> 
> If patch1 get the confirmation from clock maintainer,
> feel free to add my acked tag:
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Sorry. I mean the patch2 about clk_round_rate_unboundly() function.
instead of patch1. 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4F26D118
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 04:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIQC1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 22:27:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41008 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIQC1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 22:27:07 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:27:04 EDT
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200917021919epoutp036af006c8e2c017612a48360df5c845ef~1cLOccr8x2685526855epoutp03E
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2020 02:19:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200917021919epoutp036af006c8e2c017612a48360df5c845ef~1cLOccr8x2685526855epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600309159;
        bh=Y2WbprGh1QdL8poMPL+mRB1yv/xvwknGbXce4Q04kAU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KzeVBbp+C6jUaot+SRX7ZGzc5ZUHtl7nK9PcUlXHkj6Ww5ysEypFVu9nHZyFO46RZ
         D2hxIa/kojEE3PbX6CRe0pldCzcJjMPfqOzghcey20t1A3doVieVG8HUHd7h1FktQS
         ErEaqE6nJBseAbXkUM+0jV3FRUT2qzX12aEqk50E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200917021918epcas1p3bf33ef8cbc9fb85c14e4121c2a17f753~1cLNvtKSB0798907989epcas1p3b;
        Thu, 17 Sep 2020 02:19:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BsLJ35fcpzMqYm0; Thu, 17 Sep
        2020 02:19:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.D4.29173.1A7C26F5; Thu, 17 Sep 2020 11:19:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200917021912epcas1p19acb32265d42a0c244d994282c25c56f~1cLIUmX3w0828608286epcas1p1m;
        Thu, 17 Sep 2020 02:19:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200917021912epsmtrp26a9ce8f57d53ba759b7f6bde82863be8~1cLIT5CEk2220522205epsmtrp2E;
        Thu, 17 Sep 2020 02:19:12 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-69-5f62c7a17b2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.C0.08303.0A7C26F5; Thu, 17 Sep 2020 11:19:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200917021912epsmtip18445e10d8f8c50c1e50355e300086b6f~1cLIE4Or21303513035epsmtip1K;
        Thu, 17 Sep 2020 02:19:12 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
Date:   Thu, 17 Sep 2020 11:32:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmge7C40nxBov+ilu8/jedxWL1x8eM
        Fi2zFrFYbL0lbXG26Q27xefeI4wWnV9msVncblzBZvFz1zwWB06PnbPusnv0Nr9j8/j49BaL
        R9+WVYwenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vO
        z7UyNDAwMgUqTMjO2N32k6lgj1LFrn+LmBoYt8h0MXJySAiYSMyb2MTaxcjFISSwg1Fi+vsG
        NgjnE6PEo4ZdjBDOZ0aJPa/OMsK0rJlzgx0isQuoZfMLZgjnPaPEjCef2EGqhAW8JX4/+MUK
        YosIBEns+jwTrIhZoJ1JYnr7O7AEm4CWxP4XN9hAbH4BRYmrPx4DreDg4BWwk9jyMhzEZBFQ
        ldjeaQ1SISoQJnFyWwvYEbwCghInZz5hAbE5BWwllr3qArOZBcQlbj2ZzwRhy0s0b50NtlZC
        YCmHxPdvy9ghPnCR2LbiN9Q3whKvjm+BiktJfH63lw3CrpZYefIIG0RzB6PElv0XWCESxhL7
        l05mAjmOWUBTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1JicXsn
        2wRGpVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCY+TY3sQITqta5jsYp739oHeIkYmD
        8RCjBAezkgjvgcb4eCHelMTKqtSi/Pii0pzU4kOMpsDwncgsJZqcD0zseSXxhqZGxsbGFiaG
        ZqaGhkrivA9vKcQLCaQnlqRmp6YWpBbB9DFxcEo1MJmeej/F9GhBfsvBz5f+nNJl/Hkgftn9
        Ber14u9EPJJ91uVq3eHUssuxfXz95+LLq401/BexaDQdnmrs43dK8RbfxV83mtclBqu7zrr9
        4YqT7pf4xMMHT5zmKwrx2NSocKfAfcGXUIHdP0/eK/uzuqzi77uHrKvZ2//dLJ177lSh8Ld6
        51YfFpbY9k9LeecJe693mfSof//5E08s7bJvpmc7OJ+tePUhZcFpho6Gl7K8ewVWp5lLHfvf
        9WnnSYm3Z77KurQqNRv/CA9oXqd9RczYqermgo0P7+zP8plusbXTad6n2T/rD3B3m9235cqT
        eTmzQP1Y9+xVIumhITN4WrodL3wrWRSmP7tybVBwKqsSS3FGoqEWc1FxIgA3GTbYNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTnfB8aR4g+5Hahav/01nsVj98TGj
        RcusRSwWW29JW5xtesNu8bn3CKNF55dZbBa3G1ewWfzcNY/FgdNj56y77B69ze/YPD4+vcXi
        0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBm7234yFexRqtj1bxFTA+MWmS5GTg4JAROJNXNu
        sHcxcnEICexglJg6/QkrREJSYtrFo8xdjBxAtrDE4cPFEDVvGSUerl8HViMs4C3x+8EvMFtE
        IEji1Oa3jCA2s0Ank8TxM3ZQDcwS7ydPAStiE9CS2P/iBhuIzS+gKHH1x2NGkAW8AnYSW16G
        g5gsAqoS2zutQSpEBcIkdi55zARi8woISpyc+YQFxOYUsJVY9qqLBWKVusSfeZeYIWxxiVtP
        5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
        Lzk/dxMjOLq0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeA43x8UK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5v85aGCckkJ5YkpqdmlqQWgSTZeLglGpgutz9v7vuZODWfIdtAjphxme/Z2wQaK1W2LC0
        8887g6K6L2bnb2vvXBQYL3x+TWnfxGpe/3fcXCwCKxYwztvKeFY9J5FFKPh408PQnXLyfzu0
        DptMirnMnf0jbX+i9C+htbds5jFJLppunZNW68VX0Sma1LQ946TU61BXy2zTU2uzZy9uZWcX
        6F65//pdwcun0558Z8kIDKpvkyjQ2FN35vWkZfwtOT3KF64fPeR1dNYm6+XrZBoD/2St6uX/
        v1fjkbCbSn3aQaWN70/V/GeyLvYqfq8WqK+6+9mUj9PSw1fmCDJd5fwmkXwgZ1FRaIlKCkPH
        JunPMVN9ZzlP/v1D8ell8eqN+etSsn8v+rtfiaU4I9FQi7moOBEABQrxOx0DAAA=
X-CMS-MailID: 20200917021912epcas1p19acb32265d42a0c244d994282c25c56f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
        <20200908072557.GC294938@mwanda>
        <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
        <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
        <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
        <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
        <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
        <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
        <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/17/20 4:07 AM, Dmitry Osipenko wrote:
> 16.09.2020 05:38, Chanwoo Choi пишет:
>> On 9/16/20 2:01 AM, Dmitry Osipenko wrote:
>>> 15.09.2020 05:13, Chanwoo Choi пишет:
>>>> On 9/15/20 11:00 AM, Chanwoo Choi wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> On 9/14/20 10:56 PM, Dmitry Osipenko wrote:
>>>>>> 14.09.2020 10:09, Chanwoo Choi пишет:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>>>>>>>> This error path needs to call clk_disable_unprepare().
>>>>>>>>
>>>>>>>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>>>>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>>>>> ---
>>>>>>>> ---
>>>>>>>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>>>>>> index e94a27804c20..dedd39de7367 100644
>>>>>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>>>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>>>>>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>>>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>>>>>>  	if (rate < 0) {
>>>>>>>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>>>>>>> -		return rate;
>>>>>>>> +		err = rate;
>>>>>>>> +		goto disable_clk;
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>>  	tegra->max_freq = rate / KHZ;
>>>>>>>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>>>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>>>>>>>  
>>>>>>>>  	reset_control_reset(tegra->reset);
>>>>>>>> +disable_clk:
>>>>>>>>  	clk_disable_unprepare(tegra->clock);
>>>>>>>
>>>>>>> Is it doesn't need to reset with reset_contrl_reset()?
>>>>>>
>>>>>> Hello, Chanwoo!
>>>>>>
>>>>>> It's reset just before the clk_round_rate() invocation, hence there
>>>>>> shouldn't be a need to reset it second time.
>>>>>
>>>>> Do you mean that reset is deasserted automatically
>>>>> when invoke clk_round_rate() on tegra?
>>>
>>> I only mean that the tegra30-devfreq driver deasserts the reset before
>>> the clk_round_rate():
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n834
>>>
>>>>> If tree, I think that 'reset_control_reset(tegra->reset)' invocation
>>>>
>>>> I'm sorry for my typo. s/tree/true.
>>>>
>>>>> is not needed on 'remove_opp:' goto. Because already reset deassertion
>>>>> is invoked by clk_round_rate(), it seems that doesn't need to invoke
>>>>> anymore during exception case.
>>>>>
>>>>> Actually, it is not clear in my case.
>>>
>>> The reset_control_reset() in the error path of the driver probe function
>>> is placed that way to make the tear-down order match the driver removal
>>> order. Perhaps the reset could be moved before the remove_opp, but this
>>> change won't make any real difference, hence it already should be good
>>> as-is.
>>>
>>>
>>
>> I have one more question.
>> When failed to enable clock on line829[1],
>> does it need any reset_control invocation?
>> In this case on line829, just return without any restoration 
>> about reset control.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n829
>>
> 
> There is no need to deassert the reset if clk-enable fails because reset
> control of tegra30-devfreq is exclusive, i.e it isn't shared with any
> other peripherals, and thus, reset control could asserted/deasserted at
> any time by the devfreq driver. If clk-enable fails, then reset will
> stay asserted and it will be fine to re-assert it again.
>

Thanks for the detailed explanation. 
But, I think that almost people don't know the detailed h/w information.
If possible, how about matching the pair when clk-enable fails as following?

--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -828,6 +828,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
        if (err) {
                dev_err(&pdev->dev,
                        "Failed to prepare and enable ACTMON clock\n");
+               reset_control_deassert(tegra->reset);
                return err;
        }


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

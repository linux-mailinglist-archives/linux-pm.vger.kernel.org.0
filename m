Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4F26A56C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIOMoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 08:44:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48390 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOMnj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 08:43:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200915124309euoutp011755dc512770c07fc0c4306fee86e73a~09ZVec8yd2364223642euoutp01N
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 12:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200915124309euoutp011755dc512770c07fc0c4306fee86e73a~09ZVec8yd2364223642euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600173789;
        bh=neMABDveNM+YfgI7cV05Snghwve9pnFQDi0Bd3F3O18=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HPDnB1BmilY6EoSn7a4RNJJLtMssnlNE+X7Msu6+KcAcMKeu5M1QHAJtgIq21Z/IC
         qkSl1ucXIbSL5e2h+z8t5KqZyjopcbyReOKrjqqvHZ2s7Ch49SA+l4b610Kywcy4Yh
         b8KfUWy8/dCbqWhwkQf2u4iSVKqdeix6fAaMzqT4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200915124309eucas1p13b682cc4f847f2c91923a42edbcb9a14~09ZVSbG4a2565525655eucas1p14;
        Tue, 15 Sep 2020 12:43:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.CF.06318.DD6B06F5; Tue, 15
        Sep 2020 13:43:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200915124308eucas1p15bfb141a491a564b5b5c6a7683d5b755~09ZU7abAh2613026130eucas1p1k;
        Tue, 15 Sep 2020 12:43:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200915124308eusmtrp24a17123047471dff714aa7bb71cb488b~09ZU6xzsP2113121131eusmtrp2g;
        Tue, 15 Sep 2020 12:43:08 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-27-5f60b6ddac80
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.C7.06314.CD6B06F5; Tue, 15
        Sep 2020 13:43:08 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200915124307eusmtip1c61f0a32f8a0bd7c9e2aaf1c8365dac7~09ZT1xIaA2752827528eusmtip1B;
        Tue, 15 Sep 2020 12:43:07 +0000 (GMT)
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x
 enabled
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <8d90ada6-ac26-9d7a-6ad5-7f7704cfffc5@samsung.com>
Date:   Tue, 15 Sep 2020 14:43:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3ba7cf94-1b1f-a500-4c4f-a9769531097b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87p3tyXEG3SfELDYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF594jjBYzzu9jsljY1MJusfbIXXaLf9c2sjhweqyZt4bRY9OqTjaPvi2r
        GD0+b5ILYInisklJzcksSy3St0vgyti8ooWloEmgYsWhv6wNjO28XYycHBICJhIrjx1g7GLk
        4hASWMEosbPlG5TzhVFi4qtpLBDOZ0aJFyu+scC0/D72iBkisZxRYtqXZ1DOR0aJySv3sIFU
        CQv4S5zcd4IdxGYTMJToPdrHCGKLCHhJHLs1hQ2kgVmgh0libdcmVpAEr4CdxM7Li8EaWARU
        JVa86gMbJCoQJ3Hs1CMWiBpBiZMzn4DZnAL2EhtX3ALrZRYQl7j1ZD4ThC0vsf3tHGaIU/ex
        S/zstoOwXSTu7FzMBGELS7w6voUdwpaR+L8TpJcLyG5mlOjZfZsdwpnAKHH/+AJGiCpriTvn
        fgFdxAG0QVNi/S59iLCjxPR7s5lAwhICfBI33gpC3MAnMWnbdGaIMK9ER5sQRLWKxO9V06FO
        kJLofvKfZQKj0iwkn81C8s0sJN/MQti7gJFlFaN4amlxbnpqsXFearlecWJucWleul5yfu4m
        RmBCOv3v+NcdjPv+JB1iFOBgVOLh5SiNjxdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYwejzgqdOqW1vZ3yilGqDdN
        6NJ8EOD+Rrn1wusL5lMKily3Ks85xmt6Rux0iM/PJtZlLLODih8HPNjL+/Mq46H7nwzMw+tF
        2ernP3xX/Gh/oJn+zm3bxZaGC67kfCyw/Qt33rY2A+O7q5V2rqm437vBfOZc7aTc6Xo5gq83
        Wk+/+17xY+fbJk8lluKMREMt5qLiRAC/v9goRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7p3tiXEG2z8Y2ixccZ6VovrX56z
        Wpw/v4Hd4mPPPVaLz71HGC1mnN/HZLGwqYXdYu2Ru+wW/65tZHHg9Fgzbw2jx6ZVnWwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl7F5RQtLQZNAxYpDf1kbGNt5uxg5OSQETCR+H3vEDGILCSxllHj83LiLkQMoLiUxv0UJ
        okRY4s+1LrYuRi6gkveMEo0Xv7KCJIQFfCX6Ni0Cs9kEDCV6j/YxgtgiAl4Sx25NAWtgFuhj
        kriz9worRPcsZonlXx6wgVTxCthJ7Ly8mB3EZhFQlVjxqg8sLioQJ3Gm5wVUjaDEyZlPWEBs
        TgF7iY0rboFtYxZQl/gz7xIzhC0ucevJfCYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKs
        YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIy/bcd+bt7BeGlj8CFGAQ5GJR7ehPL4eCHWxLLi
        ytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wNeSVxBuaGppbWBqa
        G5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamAM6NAN7yzqrU2y81R9uduoawrve5XV
        GstbHi1ddHBLacJPgbsmC2aeLXwiseTylx0nlOrOdRf0Nks8mFX32pL/X+xNkX99Pe8XfLoy
        mfmPf6/8xMUdc1uW2gadNt9+Xv6xUGfiFl/l+Yc4J76Zzn4h9HjMnrxVHROrVc/6cbG8MWCq
        UfU8ufuDEktxRqKhFnNRcSIAVl9vgNUCAAA=
X-CMS-MailID: 20200915124308eucas1p15bfb141a491a564b5b5c6a7683d5b755
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
        <20200807133143.22748-1-m.szyprowski@samsung.com>
        <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com>
        <f4c87130-25a0-2195-9caa-be805d207c34@kernel.org>
        <fff07b05-f1f6-5333-a056-69ba6995ed4f@kernel.org>
        <20200824103123.GD25860@kozik-lap>
        <3ba7cf94-1b1f-a500-4c4f-a9769531097b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02.09.2020 11:24, Sylwester Nawrocki wrote:
> On 24.08.2020 12:31, Krzysztof Kozlowski wrote:
>> On Mon, Aug 24, 2020 at 12:28:51PM +0200, Sylwester Nawrocki wrote:
>>> On 8/23/20 12:12, Sylwester Nawrocki wrote:
>>>> On 8/19/20 05:14, Stephen Boyd wrote:
>>>>> Quoting Marek Szyprowski (2020-08-07 06:31:43)
>>>>>> BPLL clock must not be disabled because it is needed for proper DRAM
>>>>>> operation. This is normally handled by respective memory devfreq driver,
>>>>>> but when that driver is not yet probed or its probe has been
>>>>>> deferred the
>>>>>> clock might got disabled what causes board hang. Fix this by calling
>>>>>> clk_prepare_enable() directly from the clock provider driver.
>>>>>>
>>>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>>> ---
>>>>>
>>>>> Can I pick this up for clk-fixes?
>>>>
>>>> Sure, thanks for taking care of this.
>>>
>>> OTOH, I planned to queue that patch for next merged window, together 
>>> with a patch that depends on that one, since the fix is not for an issue
>>> introduced in the last merge window.
>>> I guess it's better to avoid pulling (part of) the clk-fixes branch to
>>> the clk/samsung tree for next merge window?
>>
>> All current multi_v7 and some of exynos defconfig boots fail on Odroid
>> XU3-family, starting from v5.9-rc1. On kernelci and my boot systems. If
>> I understand correctly, this is a fix for this issue, so it should go as
>> fast as possible to v5.9 cycle.
>>
>> Otherwise we cannot test anything. The current v5.9 RC is then simply
>> broken.
> 
> Right, we need that patch in v5.9. Stephen, can you please apply
> the patch to your clk-fixes?

So I applied the patch to my tree and sent you a pull request
instead... :) I thought it will handling subsequent patches
that depend on that one more straightforward.

-- 
Regards,
Sylwester

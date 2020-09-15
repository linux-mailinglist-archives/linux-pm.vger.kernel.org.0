Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A90269BB2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 04:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgIOCBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 22:01:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43740 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOCBP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 22:01:15 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200915020112epoutp011c436358757e3fd7b95c3545b4a9fc88~00o10hRwU1151111511epoutp01P
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 02:01:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200915020112epoutp011c436358757e3fd7b95c3545b4a9fc88~00o10hRwU1151111511epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600135272;
        bh=wGMymztbJmfEZTOOZj2lpRmtKls5pkqELPQ6OqgpQVE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EweiNUmRF5I2K6bxf/sYtXvXaim0P6akaDZU+H9MHjKf6BUes1YVIe1J+lIUTr6FC
         yrccl1mnPTEssm/7lwKd4G7UmiAJoGx0Eq76vGyEAAJaZRitYYiPyqDCaiqAlMfp4W
         4q9Z4vpE1x5RNzd2u5p7EkhVCkMcC+XEQaa3ofI4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200915020111epcas1p3c53ad8bd16abcd812f51bb3bb4484d1c~00o1Hkqjl2759427594epcas1p3N;
        Tue, 15 Sep 2020 02:01:11 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Br6052l8TzMqYkp; Tue, 15 Sep
        2020 02:01:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.5B.29173.060206F5; Tue, 15 Sep 2020 11:01:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200915020102epcas1p35fd3921fff8a0e384828efa769c85c1d~00oszblS12745227452epcas1p3L;
        Tue, 15 Sep 2020 02:01:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200915020102epsmtrp2199f36a719970a28a4e5f335998a8dc7~00osyrfU70882908829epsmtrp2I;
        Tue, 15 Sep 2020 02:01:02 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-6c-5f602060f878
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.2B.08303.E50206F5; Tue, 15 Sep 2020 11:01:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200915020102epsmtip2f3cf3a905568dd4d1ab7ef342df6f704~00oscZtpz1190411904epsmtip2I;
        Tue, 15 Sep 2020 02:01:02 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
Date:   Tue, 15 Sep 2020 11:13:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmvm6CQkK8wZbnyhav/01nsVj98TGj
        RcusRSwWW29JW5xtesNu8bn3CKNF55dZbBa3G1ewWfzcNY/FgdNj56y77B69ze/YPD4+vcXi
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Iz+qf+Zym4IFAx89I75gbG67xdjJwcEgImEo+mbmLsYuTiEBLYwSjxY/k6
        VgjnE6PE2VNXWCCcz4wSfYe3scK0fOzugGrZxSixftJkJgjnPaNEQ+sVNpAqYQFvid8PfoF1
        sAloSex/cQMsLiIQJLHr80xmkAZmgXYmient78CK+AUUJa7+eMwIYvMK2EncOb2WHcRmEVCV
        uHj5OFhcVCBM4uS2FqgaQYmTM5+wgNicAvYSLdd3gcWZBcQlbj2ZzwRhy0s0b50NtkxCYCmH
        xK597cwQP7hI7GjcBmULS7w6voUdwpaS+PxuLxuEXS2x8uQRNojmDkaJLfsvQAPAWGL/UpCf
        OYA2aEqs36UPEVaU2Pl7LtQRfBLvvvawgpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyTaBUWkW
        kndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwBg5vjcxglOrlvkOxmlvP+gdYmTiYDzEKMHB
        rCTCe6AxPl6INyWxsiq1KD++qDQntfgQoykwgCcyS4km5wOTe15JvKGpkbGxsYWJoZmpoaGS
        OO/DWwrxQgLpiSWp2ampBalFMH1MHJxSDUxGQhG9fNPNA2vZ1Hubl/9flbJk/aL9/2rEj1zW
        +rXroPTc6y1XpK81bJn5haFQ9XXDQdPMNsGZV0Rdp5YmKE0MWxo9qZW3tIuNh1Nzu5p64vTj
        y5jVdA8s6ODpuWru1ZLsXOK4kdk54FGTtv3myKWPn4TstE51nBwsmH/sePWugGSbD+Xfthil
        MF55YvWWt/xOaYb4qsvfyrV3sL9SF/Wve/dX+ItcnnKC0yXlfedfMCQsKV26P2Lb3szyfYlb
        ZhUv1PzCMudy9EOf8/w7s+c3eczsnzjnWMTy70EvNr+SrG08Z9Nq9uPUR1MjqZSiy0bhpr/l
        jYJ3zr0s9Iz7sNP++svbfbpPbN5464Fz5GIlluKMREMt5qLiRABu8LA2NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXjdOISHeYFG3gcXrf9NZLFZ/fMxo
        0TJrEYvF1lvSFmeb3rBbfO49wmjR+WUWm8XtxhVsFj93zWNx4PTYOesuu0dv8zs2j49Pb7F4
        9G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV0b/1P8sBRcEKmZeesfcwHidt4uRk0NCwETiY3cH
        YxcjF4eQwA5Gidv79rNCJCQlpl08ytzFyAFkC0scPlwMUfOWUeJ5/0tGkBphAW+J3w9+gdWz
        CWhJ7H9xgw3EFhEIkji1+S1YDbNAJ5PE8TN2EM1zmSR2zDkMVsQvoChx9cdjsCJeATuJO6fX
        soPYLAKqEhcvHweLiwqESexc8pgJokZQ4uTMJywgNqeAvUTL9V1QC9Ql/sy7xAxhi0vcejKf
        CcKWl2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ
        +bmbGMERpqW1g3HPqg96hxiZOBgPMUpwMCuJ8B5ojI8X4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zvt11sI4IYH0xJLU7NTUgtQimCwTB6dUA9O2T5/Fq59VLtnw/f6mz/NzlGTKPl1c0sHzJ/PE
        nNOLWx5kvG8rmbL6QvoCy1ef7pukiS7auvXdj5yff6N4hLZm7j+feytrdfDUsguTxNnfZZx2
        s3pr//0kx85Tr9rNcrTO+SwoaP4pr+Pn2h4hJaIm0d49x01bpkv6Pp+vdJ/vpB2/NWrW6ZoF
        LmVwn/LnvEDXHdHlP93V94czfc3abSv1qUozfXHNdt6YmwnTbYR/PnB86WOfNc11xcRXF55x
        NVTmS9x9khty8J3squqymxIGNQo3w/2elqtOYhO1CVD6Gn3uZ6aYT/gm5sSeonARr+kLFN4U
        LXXYUmPDOZk/teha4q/vy3l9pm+z9vp6PF2JpTgj0VCLuag4EQCQWZN7HwMAAA==
X-CMS-MailID: 20200915020102epcas1p35fd3921fff8a0e384828efa769c85c1d
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/15/20 11:00 AM, Chanwoo Choi wrote:
> Hi Dmitry,
> 
> On 9/14/20 10:56 PM, Dmitry Osipenko wrote:
>> 14.09.2020 10:09, Chanwoo Choi пишет:
>>> Hi,
>>>
>>> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>>>> This error path needs to call clk_disable_unprepare().
>>>>
>>>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> ---
>>>> ---
>>>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>> index e94a27804c20..dedd39de7367 100644
>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>>  	if (rate < 0) {
>>>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>>> -		return rate;
>>>> +		err = rate;
>>>> +		goto disable_clk;
>>>>  	}
>>>>  
>>>>  	tegra->max_freq = rate / KHZ;
>>>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>>>  
>>>>  	reset_control_reset(tegra->reset);
>>>> +disable_clk:
>>>>  	clk_disable_unprepare(tegra->clock);
>>>
>>> Is it doesn't need to reset with reset_contrl_reset()?
>>
>> Hello, Chanwoo!
>>
>> It's reset just before the clk_round_rate() invocation, hence there
>> shouldn't be a need to reset it second time.
> 
> Do you mean that reset is deasserted automatically
> when invoke clk_round_rate() on tegra?
> 
> If tree, I think that 'reset_control_reset(tegra->reset)' invocation

I'm sorry for my typo. s/tree/true.

> is not needed on 'remove_opp:' goto. Because already reset deassertion
> is invoked by clk_round_rate(), it seems that doesn't need to invoke
> anymore during exception case.
> 
> Actually, it is not clear in my case.
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

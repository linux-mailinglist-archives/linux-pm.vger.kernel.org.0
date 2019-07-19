Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A818A6D832
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfGSBMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:12:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44348 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfGSBMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:12:02 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190719011159epoutp020951121ff04d00fe7e08f46943fdf77c~yqc04YMb21279512795epoutp02M
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:11:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190719011159epoutp020951121ff04d00fe7e08f46943fdf77c~yqc04YMb21279512795epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563498719;
        bh=pJRiEDTVb1Q1jLaaq6PSgmh/0pib9kUoncylR8poF1A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cbXvmSvrDiYL03HLkDx8+/6XH94COSdJx5IR4d02O0CiO6JBAvl/eFMDwI4UmnVZD
         qcfdIqIMvmB33i5tRQKHVVHwYbA39De0l15Gskitiv+H0gsWNEiozjAq6zi/LZdscV
         z4aITaekHY2ZNhJYYusxxfF22AAXJY3lN9U5ebKQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190719011159epcas1p3d3a8cdc5ef4a93467847de938e131da7~yqc0aEusX0518505185epcas1p3N;
        Fri, 19 Jul 2019 01:11:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45qXz04Kg0zMqYkd; Fri, 19 Jul
        2019 01:11:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.0B.04075.CD8113D5; Fri, 19 Jul 2019 10:11:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190719011156epcas1p35fa6bc396c4d828c5f534dedb89fdebd~yqcxmzM0V0393503935epcas1p3P;
        Fri, 19 Jul 2019 01:11:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719011156epsmtrp18187d6ec609595767b8540e11b2ed5e1~yqcxmCJRp1723917239epsmtrp1I;
        Fri, 19 Jul 2019 01:11:56 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-c6-5d3118dc213b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.80.03638.BD8113D5; Fri, 19 Jul 2019 10:11:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719011155epsmtip15bdb56468880e51e8f973a5703044945~yqcxbroiN1683216832epsmtip1q;
        Fri, 19 Jul 2019 01:11:55 +0000 (GMT)
Subject: Re: [PATCH v4 19/24] PM / devfreq: tegra30: Optimize upper
 consecutive watermark selection
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e45a250c-1860-ca86-4b60-4896166752a8@samsung.com>
Date:   Fri, 19 Jul 2019 10:15:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719034025.67c82123@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuTuz42ht3Vatk710KlHBdUfbbSyNopCFCoS+VLRsg06u7bOd
        NbK+ZPZyUSuiwO1tmmbKWlmYFda2IhWK9C4VJRNSyuglVkbtOBv57Xf+538493/vpQl1IxVD
        59vdgsvOWxkqgrz5IDEluQdYo7bnQBx35fMA4vZ7K0muY9+HMO5py2mK+1oWQFzJNy/FdRfV
        UtyPlrMkV97whFoZbmjurUKGW97eMENZ8QhlKG+qQ4av1+ZnKzdbMswCnyu4YgV7jiM3356X
        yazdYFpt0um1bDKbzi1lYu28Tchk1qzLTs7KtwYPxMTu5K0FQSmbF0UmZUWGy1HgFmLNDtGd
        yQjOXKsz3akReZtYYM/T5Dhsy1itNlUXNG61mEtvd1FOj3rX3Rt+ai9qn+ZB4TTgJXCp6Cfh
        QRG0Gjcj8N+uoOTiC4LXDYFQMYqg6FEV8W+k9FVtqHEXwYGh+lDxCUHpnZoJVyQWoG/4ZpjE
        UTgeatrGlZKJwFcV0N5Yr5AaFE6C1vevKImn4zh4PjaAJFbhFdAWKJvQSbwYuusrlRJH443w
        pf+BUvbMgIcV70gPoulwrIHBSzmSTOBZ8ObdOYXMC6D4xqmJcID/UPBxoF0pR1gDdeOjYTJH
        wnB7U4hjYOjIwRDvgcsP5fyADyNoau0KDadBa/VxhbSYwInga0mR5Ti49esMkhdPg5HvpUrJ
        AlgFhw+qZctCeNrfq5B5Nlw8VEIdRYx3UhrvpAjeSRG8/5edR2Qdmik4RVueILLO1MnPfQ1N
        /NYkfTOq7FznR5hGzFTV2HatUa3kd4qFNj8CmmCiVN1DKUa1Kpcv3C24HCZXgVUQ/UgXvOxj
        REx0jiP49+1uE6tLTUtL45aweh3LMrNUZ8cTjWqcx7sFiyA4Bde/OQUdHrMXBYqNgd2Yzni+
        aLRuzreRNt+iQCLSWpwNfVlRK7M01/X9fZusz7p6Tkwp6twxtv7+4D5zxWj5i0Jyf6PldGVE
        wpt71TvGLhZ+/23etnwOmd4893ML4+uM1sd3eBrjF/dvgcerTL7iBNtguWZTZiutntdxYdjM
        +Up+n3x5f3XP23yGFM08m0S4RP4vsR//5MMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO5tCcNYg5sd1harPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZPbsvsBV0CVXs3XqIrYHxOF8XIyeHhICJRM+N
        FWxdjFwcQgK7GSUefb7NDpGQlJh28ShzFyMHkC0scfhwMUTNW0aJbV+3gtUIC6RK3H+1DcwW
        EVCTWH70DytIEbPAZiaJs6dWQ03tZZI4uuMEC0gVm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS
        R4/0gsVZBFQlbq9ZxApiiwpESBzeMQuqRlDi5MwnLCAXcQroSTxdlgwSZhZQl/gz7xIzhC0u
        cevJfCYIW16ieets5gmMwrOQdM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX
        5qXrJefnbmIEx5iW1g7GEyfiDzEKcDAq8fAG5BrECrEmlhVX5h5ilOBgVhLhvf1SP1aINyWx
        siq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QDY5fARQHXXT2PD6V/
        bj7D4LFvmf/y37V8JckpE2LclZJztry392dsNXpzaa7fh8NP9xSzX00O2nHsFusXs0rlX1kf
        Dquf2W5ucWDT8im51fNXbpq4YX9A1cZLRupz8xyF1LmruR4Z2V3cKPfkH99rpzhbOau9HxpK
        7aSXvjd8eX9nhOVFl6LgMCWW4oxEQy3mouJEABp5uNytAgAA
X-CMS-MailID: 20190719011156epcas1p35fa6bc396c4d828c5f534dedb89fdebd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223622epcas4p48ec0d7e6fa26bc2397fa4351c0bd0c2d
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223622epcas4p48ec0d7e6fa26bc2397fa4351c0bd0c2d@epcas4p4.samsung.com>
        <20190707223303.6755-20-digetx@gmail.com>
        <17fabbaf-ceca-7551-0a58-9c8a0e7027ed@samsung.com>
        <20190719034025.67c82123@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 9:40, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 18:51:02 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> The memory activity counter may get a bit higher than a watermark
>>> which is selected based on OPP that corresponds to a highest EMC
>>> rate, in this case watermark is lower than the actual memory
>>> activity is and thus results in unwanted "upper" interrupts.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)  
>>
>> It seems that you can combine patch19 with patch20.
> 
> No, consecutive and average watermarks are different things that have
> different purposes. Consecutive are used for boosting, while average
> are for significant memory bandwidth changes.
> 
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c index
>>> 8d6bf6e9f1ae..c3cf87231d25 100644 ---
>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>> b/drivers/devfreq/tegra30-devfreq.c @@ -363,7 +363,18 @@ static
>>> void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>> tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper); 
>>>  	delta = do_percent(upper - lower,
>>> dev->config->boost_up_threshold);
>>> -	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);

This line was added on patch5 and then this line is removed on this patch.
It is wrong method to make the patch in the same patchset.

It is enough to reduce the inefficient add/remove code in the same patchset.

Have to merge this patch to patch5.

>>> +
>>> +	/*
>>> +	 * The memory events count could go a bit higher than the
>>> maximum
>>> +	 * defined by the OPPs, hence make the upper watermark
>>> infinitely
>>> +	 * high to avoid unnecessary upper interrupts in that case.
>>> +	 */
>>> +	if (freq == tegra->max_freq)
>>> +		upper = ULONG_MAX;
>>> +	else
>>> +		upper = lower + delta;
>>> +
>>> +	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
>>>  
>>>  	/*
>>>  	 * Meanwhile the lower mark is based on the average value
>>>   
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

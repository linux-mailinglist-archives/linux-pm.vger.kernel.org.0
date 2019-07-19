Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C276D839
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfGSBO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:14:29 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:45781 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfGSBO3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:14:29 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190719011427epoutp0271585eb3a7bfb639bbf21a0b738a2acc~yqe_aT7_Q1529215292epoutp02E
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:14:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190719011427epoutp0271585eb3a7bfb639bbf21a0b738a2acc~yqe_aT7_Q1529215292epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563498867;
        bh=GflqdW8XnLdWs0zAPgDV3l4T4ydPld5FQQyTPDtq2Gw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SnhJRa36sh8nqaAezWbPKNVUjWFFPAH847RxgY3ztScyLNkTdZ7VN+PRxJ33ti7jL
         W94VwGjUdzuHy6O5CBlaCwgGLwbJN0aXWElF4ZVMVelKdxHwTxCfmpuiHw7obG5wIG
         t5IfVbAR0I8I2gTNMvA9QBh/pL7Ra2N8u88klZzE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719011426epcas1p4de3d61433e5c742364dd1a498c0e6998~yqe91bOzZ1181111811epcas1p4N;
        Fri, 19 Jul 2019 01:14:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45qY1r286WzMqYkV; Fri, 19 Jul
        2019 01:14:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.90.04160.D69113D5; Fri, 19 Jul 2019 10:14:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190719011421epcas1p45532a85aa315c8fac3e31438371c1904~yqe41TbR31181011810epcas1p45;
        Fri, 19 Jul 2019 01:14:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719011421epsmtrp2f576c1b0ce4877268e91e5b9a334ef22~yqe40XCoq0267402674epsmtrp2D;
        Fri, 19 Jul 2019 01:14:21 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-0e-5d31196d08df
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.A1.03706.D69113D5; Fri, 19 Jul 2019 10:14:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719011420epsmtip1130e41dfa8669d93726e3ffb7eb6b83c~yqe4lFnQK2008820088epsmtip1a;
        Fri, 19 Jul 2019 01:14:20 +0000 (GMT)
Subject: Re: [PATCH v4 19/24] PM / devfreq: tegra30: Optimize upper
 consecutive watermark selection
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <657fc412-3fb7-5f6e-82b9-9458685b5dc5@samsung.com>
Date:   Fri, 19 Jul 2019 10:17:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e45a250c-1860-ca86-4b60-4896166752a8@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObvb3V00Oy2rn/uj7FaCgrrrnF1LKyhs9AArggjELnqa4h6X
        3WlZ//Qwm5LSk2qVvcus6LVMLRnqQgqKUqLHsIQsVGxWppUVtesl8r/P7/E939/vnMNQhqu0
        kSl0eojbKdhZeoK6vi0+KdEZw+WY6nsQf+XzO8SX+c6q+cc7B7R8Z9MJmh+qCiK+4quP5kM7
        amn+R1ONmq++1kEv1lkbus4ja6OvS2ut2hWmrdX+OmQdujUjW7OhKKOACPnEHUucea78Qqct
        k12xNndJriXNxCVy6fw8NtYpOEgmu3RldmJWoT0yEBtbItiLI6lsQZLY5IUZblexh8QWuCRP
        JkvEfLuYLiZJgkMqdtqS8lyO+ZzJlGKJNG4sKqgcnCE2Rm954x9G21EAVyKGAZwKH2pJJZrA
        GHADgtqaIFKCLwh2f+2jlWAEQfvbV/Q/xcWjBiXfjOBwXxelBIMIyryj2kqkY6ZgAm/768eY
        xgkQ6H1JyxyN4+DSg18aWUDhmypov3FVJRcm4Vnw/Ps7JLMeL4SPtZ0a2U2N58K9R3lyeipe
        D1+62zRKy2R4eKxHLbMOL4KRbyFKZgpPh9c9p1QKz4Rdd46PDQf4Dw2HDnUjZYOlEKyeI/cA
        ngL97X6twkYYCjfTCm+Dyw+DtKL1IvAHnmqUghkCFw6q5HMoHA/Xm5KV9Cxo/HkSKb5REB7e
        q1Gs9OAtNygts6Gzu0ulcAyc21NB70Osb9w2vnEb+MZt4Ptvdhqp69A0IkoOG5E4MXX8U99C
        Yz81gW9A95+sbEWYQexEfbbDlGPQCCVSqaMVAUOx0fpQX3KOQZ8vlG4lbleuu9hOpFZkidz1
        fso4Nc8V+fdOTy5nSTGbzXwql2bhOHa6vuZXfI4B2wQPKSJEJO5/OhWjM25HB24+Onb+wIvl
        HcEydej9mnBcyXKvWfvsdKOord+R+jQJLaAyVmXV7d98w7bAfn+0+3P5ut/RFZuqxHvVHzpq
        YgJ9GfbrL7JC3OXelsWeuKOrlqXfvljePPxdiNJEGVs+nRkc8Ipa97cH4bv++MNHVhvSuFFh
        k25P3Y/VO/GpTI+JVUsFApdAuSXhLwUEYsm/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG6upGGswb8JLBarPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZXe/lCnaKVNzb8pWxgXG/QBcjB4eEgInEshlC
        XYxcHEICuxkl1ky/xNLFyAkUl5SYdvEoM0SNsMThw8UQNW8ZJRZv/MsEUiMskCpx/9U2dhCb
        TUBLYv+LG2wgtoiAmsTyo39YQRqYBTYzSZw9tZoNovsQk0TrxaVgHfwCihJXfzxmBLF5Bewk
        3q64zAqyjUVAVWL3qWSQsKhAhMThHbOgSgQlTs58AnYcp4C9xLfvt5lBbGYBdYk/8y5B2eIS
        t57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwfGlp7mC8vCT+EKMAB6MSD29ArkGsEGtiWXFl7iFGCQ5mJRHe2y/1Y4V4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpg7I+8kyLW+pa57IDw
        PdFXK3cdqVxzv5BzvfXRrWLLP5/79TbpbHe5tPVLbyk3Z3Ypqe7jm0NUP6T9fsdZp+xaOv2O
        neLUY13JU+fFJs/Sd+HJfu//vmM3+9uyuXeKzVc/E692ucOiMqd004Wf4slvrZfndKtr828W
        +TNnTozP5S91uu2Ba/t2KbEUZyQaajEXFScCAPrlt5yrAgAA
X-CMS-MailID: 20190719011421epcas1p45532a85aa315c8fac3e31438371c1904
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
        <e45a250c-1860-ca86-4b60-4896166752a8@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 10:15, Chanwoo Choi wrote:
> On 19. 7. 19. 오전 9:40, Dmitry Osipenko wrote:
>> В Thu, 18 Jul 2019 18:51:02 +0900
>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>
>>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>>> The memory activity counter may get a bit higher than a watermark
>>>> which is selected based on OPP that corresponds to a highest EMC
>>>> rate, in this case watermark is lower than the actual memory
>>>> activity is and thus results in unwanted "upper" interrupts.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra30-devfreq.c | 13 ++++++++++++-
>>>>  1 file changed, 12 insertions(+), 1 deletion(-)  
>>>
>>> It seems that you can combine patch19 with patch20.
>>
>> No, consecutive and average watermarks are different things that have
>> different purposes. Consecutive are used for boosting, while average
>> are for significant memory bandwidth changes.
>>
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>> 8d6bf6e9f1ae..c3cf87231d25 100644 ---
>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -363,7 +363,18 @@ static
>>>> void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>>> tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper); 
>>>>  	delta = do_percent(upper - lower,
>>>> dev->config->boost_up_threshold);
>>>> -	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
> 
> This line was added on patch5 and then this line is removed on this patch.
> It is wrong method to make the patch in the same patchset.
> 
> It is enough to reduce the inefficient add/remove code in the same patchset.

I'm missing some expression. So, I update my comment as following:
It is possible to reduce the inefficient add/remove code in the same patchset
if you combine the patches.

> 
> Have to merge this patch to patch5.
> 
>>>> +
>>>> +	/*
>>>> +	 * The memory events count could go a bit higher than the
>>>> maximum
>>>> +	 * defined by the OPPs, hence make the upper watermark
>>>> infinitely
>>>> +	 * high to avoid unnecessary upper interrupts in that case.
>>>> +	 */
>>>> +	if (freq == tegra->max_freq)
>>>> +		upper = ULONG_MAX;
>>>> +	else
>>>> +		upper = lower + delta;
>>>> +
>>>> +	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
>>>>  
>>>>  	/*
>>>>  	 * Meanwhile the lower mark is based on the average value
>>>>   
>>>
>>>
>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30423BA50
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 14:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHDM1z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 08:27:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52322 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDM1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 08:27:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200804121927euoutp029d7a20cdb338f49b861eba517c4c4a0f~oD_qGhRDo2047920479euoutp02Y
        for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2020 12:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200804121927euoutp029d7a20cdb338f49b861eba517c4c4a0f~oD_qGhRDo2047920479euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596543567;
        bh=EDYQXtIcEFV7aN6yvN5U5eVqNnOt4HJHg2pizOb1mdg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WBeIobOVA9UzCQkCOzhdnj1QhjV3r5jYiUGxoIID5baRL89jWYjnrmUUZjzs3qy8+
         bLzwfTkjMkrz+fSKun9BhAUYnInFtw1ULURCpKBblqCWEd6WgKVJRrItDTpbeXmmHh
         zyi7qYBMrFwN1jOcGql3vFFl6XcS5gDYJoQkD8XY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200804121927eucas1p1b882fe9f76145572f4e3f57e87d31092~oD_pciIR32714927149eucas1p1e;
        Tue,  4 Aug 2020 12:19:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.02.05997.E42592F5; Tue,  4
        Aug 2020 13:19:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200804121926eucas1p1af45ed346c7f9601d570f3f7457b3340~oD_o5mN112709727097eucas1p1b;
        Tue,  4 Aug 2020 12:19:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200804121926eusmtrp21f8ebdce5bf2c7a00ae4c8afa7c7c039~oD_o47dY61747617476eusmtrp2g;
        Tue,  4 Aug 2020 12:19:26 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-ea-5f29524e6aa8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.45.06017.E42592F5; Tue,  4
        Aug 2020 13:19:26 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200804121926eusmtip190e48a53cc7bcc86d14a316f4bef39cc~oD_oeKMJu2691826918eusmtip1T;
        Tue,  4 Aug 2020 12:19:26 +0000 (GMT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: propagate error from
 exynos5_counters_get()
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <78c95f58-8142-7607-6d74-5cfa6a7ffb77@samsung.com>
Date:   Tue, 4 Aug 2020 14:19:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <24675559-b807-5b80-1318-805c1530ffb3@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7r+QZrxBm9WM1lsnLGe1eL6l+es
        FufPb2C3uLxrDpvF594jjBYzzu9jsljY1MLuwO6xZt4aRo9NqzrZPPq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugSuj5XkDU8FsyYrrdx8zNjB+EOli5OSQEDCReLlzDWsXIxeHkMAKRolbb+cx
        QzhfGCU+LdrPDuF8ZpRYNnkRC0zLnGtroRLLGSVmvHgK1f+eUWLzjpVsIFXCAskSO2Z+ZwSx
        RQTiJRYe+gDWwSywhlHi0NvjYEVsAoYSXW+7wGxeATuJq4uvsYPYLAIqElN7pjGB2KICcRJb
        j19lgqgRlDg58wnYGZwC1hLLdpwE62UWkJdo3jqbGcIWl7j1ZD4TyDIJgVXsEu/23mCDuNtF
        4s+sT1A/CEu8Or6FHcKWkfi/E6ahmVHi4TmI5yQEehglLjfNYISospa4c+4X0CQOoBWaEut3
        6UOEHSX6D/1gBglLCPBJ3HgrCHEEn8SkbdOhwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2
        C8k7s5C8Mwth7wJGllWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB6ef0v+NfdjDu+pN0
        iFGAg1GJh3cBq0a8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Gi96GSskkJ5YkpqdmlqQWgSTZeLglGpgtLjxj7egbn+63ILS6eeeXDyz46o2Vz/nnL975m+1
        sv1sXe7zOtduYsNzzh2qzAYBPc5Mqvq7jyyw5Xhf2c/tmhwq9OP4yff+t5ce1js6d59m0rMd
        nH6z7tzlnsD5Y4vWoQXvlkoqpLHcetPbrCvne4P7veOJ0x7747/N3z5TWvWbkpqigmBCsBJL
        cUaioRZzUXEiAHYP3DI7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7p+QZrxBtdPyVtsnLGe1eL6l+es
        FufPb2C3uLxrDpvF594jjBYzzu9jsljY1MLuwO6xZt4aRo9NqzrZPPq2rGL0+LxJLoAlSs+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+j5XkDU8Fs
        yYrrdx8zNjB+EOli5OSQEDCRmHNtLXsXIxeHkMBSRolL3/tZIRIyEienNUDZwhJ/rnWxQRS9
        ZZSY9v0SI0hCWCBZYsfM72C2iEC8xIQH18EmMQusYZTYs62XEaLjIKPEk92/mUGq2AQMJbre
        gozi5OAVsJO4uvgaO4jNIqAiMbVnGhOILSoQJ/G49z8zRI2gxMmZT1hAbE4Ba4llO06C9TIL
        mEnM2/yQGcKWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSK
        E3OLS/PS9ZLzczcxAuNt27GfW3Ywdr0LPsQowMGoxMO7gFUjXog1say4MvcQowQHs5IIr9PZ
        03FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MBXkl8YamhuYWlobmxubGZhZK4rwdAgdj
        hATSE0tSs1NTC1KLYPqYODilGhh3T5YXlNf8s1u9ievq654i1ZdLxNtcSuRsHeM2TT0im6uf
        xcUs4v6yePGTSCFuzh+q0k0rp3/8c9xM+vyMd6tEm79WVRtIBajNihCxcha9FLa00eHl9PKW
        R2uX9Hy+/fRYH4trWZKW3f9g33l3tLhd+1Z9e78l54OKfGpBZ0pVpahf5735F5VYijMSDbWY
        i4oTARLGHd7NAgAA
X-CMS-MailID: 20200804121926eucas1p1af45ed346c7f9601d570f3f7457b3340
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
References: <CGME20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d@eucas1p2.samsung.com>
        <20200804061210.5415-1-m.szyprowski@samsung.com>
        <24675559-b807-5b80-1318-805c1530ffb3@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 04.08.2020 11:11, Lukasz Luba wrote:
> Hi Marek,
>
> On 8/4/20 7:12 AM, Marek Szyprowski wrote:
>> exynos5_counters_get() might fail with -EPROBE_DEFER if the driver for
>> devfreq event counter is not yet probed. Propagate that error value to
>> the caller to ensure that the exynos5422-dmc driver will be probed again
>> when devfreq event contuner is available.
>>
>> This fixes boot hang if both exynos5422-dmc and exynos-ppmu drivers are
>> compiled as modules.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c 
>> b/drivers/memory/samsung/exynos5422-dmc.c
>> index b9c7956e5031..639811a3eecb 100644
>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -914,7 +914,7 @@ static int exynos5_dmc_get_status(struct device 
>> *dev,
>>       } else {
>>           ret = exynos5_counters_get(dmc, &load, &total);
>>           if (ret < 0)
>> -            return -EINVAL;
>> +            return ret;
>>             /* To protect from overflow, divide by 1024 */
>>           stat->busy_time = load >> 10;
>>
>
> Thank you for the patch, LGTM.
> Some questions are still there, though. The function
> exynos5_performance_counters_init() should capture that the counters
> couldn't be enabled or set. So the functions:
> exynos5_counters_enable_edev() and exynos5_counters_set_event()
> must pass gently because devfreq device is registered.
> Then devfreq checks device status, and reaches the state when
> counters 'get' function returns that they are not ready...
>
> If that is a kind of 2-stage initialization, maybe we should add
> another 'check' in the exynos5_performance_counters_init() and call
> the devfreq_event_get_event() to make sure that we are ready to go,
> otherwise return ret from that function (which is probably EPROBE_DEFER)
> and not register the devfreq device.

I've finally investigated this further and it turned out that the issue 
is elsewhere. The $subject patch can be discarded, as it doesn't fix 
anything. The -EPROBE_DEFER is properly returned by 
exynos5_performance_counters_init(), which redirects exynos5_dmc_probe() 
to remove_clocks label. This causes disabling mout_bpll/fout_bpll clocks 
what in turn *sometimes* causes boot hang. This random behavior mislead 
me that the $subject patch fixes the issue, but then longer tests 
revealed that it didn't change anything.

It looks that the proper fix would be to keep fout_bpll enabled all the 
time.

>
> Marek do want to submit such patch or I should bake it and submit on top
> of this patch?
>
> Could you tell me how I can reproduce this? Do you simply load one
> module after another (exynos-ppmu than exynos5422-dmc) or in parallel?

I've just boot zImage built from multi_v7_defconfig with modules 
installed. Modules are automatically loaded by udev during boot.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


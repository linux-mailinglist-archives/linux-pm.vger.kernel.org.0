Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6501621B608
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJNNZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:13:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60303 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgGJNNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:13:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710131320euoutp01d25d611a212a1ff078b08d11ba25f4f1~gZlj_i2420718507185euoutp01G
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 13:13:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710131320euoutp01d25d611a212a1ff078b08d11ba25f4f1~gZlj_i2420718507185euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594386800;
        bh=VFqvdTMmHvlepqGlDjaa6ygOKTD+VYx1evFJGbA/VNk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=boW+zVKY4IfEtLM2cbq0zXW6pQmniaT+tmQ+iHhEwfiRRcgL+uPetihhPhw0npAVH
         9pPzPtQDFC5U8BY172GBeK75mt7T0cptdS/prADfZEPtVj8ZIQadOJceUZr4eyg9yU
         SPEvNUpjdDoxfUi4a+KbOZUOS2pDAj1dE5+NZevk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200710131320eucas1p1013646b84b020ba9e196ad36c26a541a~gZljnKt3b1189711897eucas1p1i;
        Fri, 10 Jul 2020 13:13:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F0.23.06456.079680F5; Fri, 10
        Jul 2020 14:13:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200710131319eucas1p2fc0116858aa82cdb435519847825acec~gZljQ9ZQo2061420614eucas1p2B;
        Fri, 10 Jul 2020 13:13:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200710131319eusmtrp2f9282e31de0bd067bf9e742019f3bdfd~gZljJJg8j0100701007eusmtrp2j;
        Fri, 10 Jul 2020 13:13:19 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-c3-5f0869704056
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.78.06314.F69680F5; Fri, 10
        Jul 2020 14:13:19 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710131318eusmtip2d926841b07eccc9f12ef5bba1ee99e87~gZliVYOwi3204032040eusmtip2P;
        Fri, 10 Jul 2020 13:13:18 +0000 (GMT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c016e256-65a6-8075-d88d-c3fad4815b4d@samsung.com>
Date:   Fri, 10 Jul 2020 15:13:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk752w0O5vGvjSULSpK0qx+nDKsrB8Tii5/Ait16vGCTsfm
        TP1RXsJqaF6CnDPThqWpeVlz6QhDi2aaTtRsqVFLybw1UCcoaLkdLf89z/M9z/d+z8tHIIIv
        bE8iPimFViRJE8UYFzW+X+47KI8nwg+ZC1GqWdPIpoqsQyj1eXGSTVXOa9hUwfgMQlksTTjV
        mz2LU/rxYTY1aHqEUQv57wClsbSzqCfZt3FqNKsGo97O3mFTS10/wKntkvrH9UDSpv2KS/S1
        9zDJy6pbkvuGWiBZ0HtfxEK5J6LpxPhUWuEfFMGNM5qWUHkFmaZbVeOZoIunBhwCkkfha/t3
        lhpwCQFZA+Dg4+oNsgjg07JChCELAHaUjwA1IFyRh60xjF69rhuz2AyxA7isq8Oc97qTkfDZ
        zAPXVR5kP4CL6mzcSRByDEBHVjlwujAyAKrn1K4EjwyChh4Ly4lRcg9ssBlxJ95BhsHGqVcs
        xsOHH0onUCfmkIFwVGNyeRDSB+a0lCEMFsKRiQrXZEg6cPimyYExVc9CXVExYLA7nDYbcAbv
        gn/aNgM5ANr6XuAMyVvfR7ZmIxEIx/pWMOcGEHI/bDT5M/JpmL9SgDOLcYPWOT7zCDdYbCxB
        GJkH7+YKGPdeqDU3/Bvb0T+AFAKxdks17ZY62i11tP/nVgK0FghplVIWSysDkugbfkqpTKlK
        ivWLSpbpwfqH61kzz7cCx0BkJyAJIN7Gq5QS4QK2NFWZLusEkEDEHrzg3p4wAS9amp5BK5LD
        FapEWtkJvAhULOQd0U1dF5Cx0hQ6gabltGLzlEVwPDNBwvMLk9altahr59vrdrd4jHidbONP
        2NbySyy2kN+Bw5Mp34SZN8VoRXPaUGiVpbs48vCV7iLBIMc3jM61h4SKDFcl8SGGGvfRn751
        IvRcjOevDnuE3/HV9KjLCZ01eh+zSBa0jxOcgYlLz/heUn2aqhCt8Xdq8qY/Wqk872NyMaqM
        kwYcQBRK6V9Q95rmbAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xe7r5mRzxBpdvKVpsnLGe1WLijSss
        Fte/PGe1WPBpBqtF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgt
        bjeuYLM4/Kad1eLbiUeMDvwea+atYfTYOesuu8emVZ1sHpuX1Hv0bVnF6PF5k1wAW5SeTVF+
        aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrZd31gK5gtU
        LPrbxd7AeIK3i5GDQ0LARGLajrQuRi4OIYGljBKfO+6wdTFyAsVlJE5Oa2CFsIUl/lzrAosL
        CbxllFj11RHEFhZIklj2ejITSLOIwAVGiaczWsAamAXuMEocbImEmLqQSeL0hgVgCTYBQ4mu
        txCTeAXsJLacPs8EYrMIqEqse7iNHcQWFYiTWL5lPjtEjaDEyZlPWEBsTgFridszdrFDLDCT
        mLf5ITOELS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgRG87ZjPzfvYLy0MfgQowAHoxIP74JEjngh1sSy4srcQ4wSHMxKIrxOZ0/H
        CfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MNHklcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpgrPczVpfepXHs7mJ5k8Zfa97UGcTbrnLevGyeUp01+8anT2/e
        n/ajv23pidfdkje/bJnkp6c/4wnfU/uEV80LgyZNqvKpvtZvWT+zIZ5df03L85biiN0WBy7x
        9Fvu2pF2cn/gMbWg/6eOhnqlGnCqNdp9mOCr/XHJ8ovXao6tZD+fbyX9le16jRJLcUaioRZz
        UXEiAGqivvL8AgAA
X-CMS-MailID: 20200710131319eucas1p2fc0116858aa82cdb435519847825acec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501
References: <20200708153420.29484-1-lukasz.luba@arm.com>
        <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
        <20200708153420.29484-2-lukasz.luba@arm.com>
        <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
        <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 10.07.2020 10:34, Lukasz Luba wrote:
> Hi Chanwoo,
>
> On 7/9/20 5:08 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 7/9/20 12:34 AM, Lukasz Luba wrote:
>>> In order to react faster and make better decisions under some 
>>> workloads,
>>> benchmarking the memory subsystem behavior, adjust the polling interval
>>> and upthreshold value used by the simple_ondemand governor.
>>>
>>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c 
>>> b/drivers/memory/samsung/exynos5422-dmc.c
>>> index 93e9c2429c0d..e03ee35f0ab5 100644
>>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>>> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct 
>>> platform_device *pdev)
>>>            * Setup default thresholds for the devfreq governor.
>>>            * The values are chosen based on experiments.
>>>            */
>>> -        dmc->gov_data.upthreshold = 30;
>>> +        dmc->gov_data.upthreshold = 10;
>>>           dmc->gov_data.downdifferential = 5;
>>>   -        exynos5_dmc_df_profile.polling_ms = 500;
>>> +        exynos5_dmc_df_profile.polling_ms = 100;
>>>       }
>>>
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>
> Thank you for the review. Do you think this patch could go through
> your tree together with your patches?
>
> I don't know Krzysztof's opinion about the patch 2/2, but
> I would expect, assuming the patch itself is correct, he would
> like to take it into his next/dt branch.

Is there really a need to remove the interrupts property? imho they are 
correct hw description, it just a matter of the driver to use or not to 
use them.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


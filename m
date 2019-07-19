Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13AA6D8BA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfGSCDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 22:03:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30430 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSCDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 22:03:01 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190719020259epoutp048d4560dbf99920d35f0b2531cc21a371~yrJWScx1V1266012660epoutp04-
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 02:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190719020259epoutp048d4560dbf99920d35f0b2531cc21a371~yrJWScx1V1266012660epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563501779;
        bh=SD1I4CitgOBqLy/a7BM33AXflBImf0vOY5HIuOGjbN8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WHAIUD/43pMGQeZ8I/+KhDCUyrFObQzwYXtH5JfwVHkyv6k9yzwDTZ7G2/OICW20o
         5YZBryb5JRetyw/WiNFoxDh1ZNip440Vzt0TJybFcdLdk4ZyZX5RN6AWqLRhsTdeHJ
         wdob217Ix/yNOBqcTxIlybB9sPKCgq5A4QTkEWFc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190719020258epcas1p1822b8f78edb67b2cea48e192e8963bbd~yrJVqCUyX2163621636epcas1p1T;
        Fri, 19 Jul 2019 02:02:58 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45qZ5q63wczMqYlx; Fri, 19 Jul
        2019 02:02:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.82.04066.FC4213D5; Fri, 19 Jul 2019 11:02:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719020255epcas1p1ef47cbb71d96427ac80038f64cf308ba~yrJSy5gKo2163621636epcas1p1J;
        Fri, 19 Jul 2019 02:02:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719020255epsmtrp194618aadc0b0e2719863904ed9db66dc~yrJSyIyEF1521615216epsmtrp1c;
        Fri, 19 Jul 2019 02:02:55 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-9b-5d3124cf41d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.E2.03638.FC4213D5; Fri, 19 Jul 2019 11:02:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719020254epsmtip1e4599b07bf8607c4544c1a0b158a5fb1~yrJSfTYod1535715357epsmtip1m;
        Fri, 19 Jul 2019 02:02:54 +0000 (GMT)
Subject: Re: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average
 watermark selection
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
Message-ID: <1cec80ae-c03e-98a7-1d9f-6b57690610c7@samsung.com>
Date:   Fri, 19 Jul 2019 11:06:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719045943.73b53e31@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDH87rtdjFWngV05IPCeiRgoF1KdTWgJl5VSSTReJEGN7AC0ivd
        lghKolSxoHJo/OCiqHiAeCEBg0REATWYeKAxEhWDEQ/UgBa8Mdp2a+Tbb+b9Z9783xuKUNeR
        4VSWxcHbLZyJJsfIL7dHaWLuT2OM2p1lGvbs51eI3SlWydm7BR+V7KPmwyQ7tK8DsUXDIsk+
        21FDsj+aK+VsyfmH5IIgQ1PPSWS4IvYoDftcA6ShpKEWGYbqJycrNmQnZPJcOm+P4C1p1vQs
        S0YivWJV6sJU/SwtE8PMYWfTERbOzCfSi5KSY5ZkmbwD0RE5nMnpTSVzgkBr5iXYrU4HH5Fp
        FRyJNG9LN9nm2GIFziw4LRmxaVbzXEarjdN7hRuzM8vO9hK292FbPBfKie3o4fhiFEQBjgfx
        dQdRjMZQatyEYMQ1opQCD4K9f+4opOArAs+357J/JUN1LwIHLQi6dv0MBIMIrle5/aoQzEFX
        6VuFj0PxDKi+OeIXEfiSDG7XnfOLSBwNre+6SR8H40h4/P0VKkYUpcLzoOrgGl9ajqfDm7JG
        5OMwvA48ve3+nio8HjoP9cl9HIRjwTV4wt+GwBPhad9RmcRTwNVY4TcH2KWErzcuBywsgt/u
        flLiEHh/u0EpcTj0lxYGeCuc6ewgpWI3gobWBwrpQAetpw7IfIMSOAouNmukdCRc+XUESReP
        g4EvexU+CWAVuAvVkmQqPOrtCYwwCU7sLiLLEC2OsiOOsiCOsiD+v+wYkteiCbxNMGfwAmPT
        jf7ueuTf1ujZTajuXlIbwhSix6qSzVqjWsHlCLnmNgQUQYeqnvVrjGpVOpebx9utqXaniRfa
        kN772uVEeFia1bv7Fkcqo4/T6XRsPDNLzzD0RFXlSJRRjTM4B5/N8zbe/q9ORgWFb0erE4Lj
        jy9FjZu25ZVf/fay5WZkyq2C+P193ergj7nr3igLjhnFlUmd9fkFCX9yNmvfrmwnYzZpDTtk
        eeVjB6qX7e9NWp/vyd72uGJxZeH6orhOMaUx69YwPuDe8+TDjd/DF0pKu06b807P3N3+rmjg
        6PwHNcsrnbULY68NrpXn00T3J1ouZHJMNGEXuL//5Zw2wwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO55FcNYg+0HeCxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyJqx+wFzwSrTi07qJzA2MlwS7GDk5JARMJD5v
        uMfaxcjFISSwm1Hi+KodLBAJSYlpF48ydzFyANnCEocPF4OEhQTeMkqc2+ECYgsLJEpc7H/O
        CmKLCKhJLD/6B2wOs8BmJomzp1azQQztZZLoW3aZDaSKTUBLYv+LG2A2v4CixNUfjxlBFvAK
        2EksmhoGEmYRUJV4NmErI4gtKhAhcXjHLDCbV0BQ4uTMJ2C3cQroSTS/Xww2hllAXeLPvEvM
        ELa4xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlec
        mFtcmpeul5yfu4kRHGFaWjsYT5yIP8QowMGoxMMbkGsQK8SaWFZcmXuIUYKDWUmE9/ZL/Vgh
        3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjKsiv3BwPBET
        e1Kfmp9z76LOW89bmScvqgqnVtrsmzjXPnVe4rIzCUef86sYqClwmO9hefJdJjv49AdB9aum
        9Z6+0Q5sq1gu5P1dvHP2Vlb9plk1SffDPVfIen6RfrW7y27JV8YetS8Oc3WVVArvTTqR+nam
        QWDynGcVVTuk3cu1HnYdP9xRocRSnJFoqMVcVJwIAMogfx6sAgAA
X-CMS-MailID: 20190719020255epcas1p1ef47cbb71d96427ac80038f64cf308ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97@epcas4p3.samsung.com>
        <20190707223303.6755-21-digetx@gmail.com>
        <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
        <20190719045943.73b53e31@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 10:59, Dmitry Osipenko wrote:
> В Fri, 19 Jul 2019 10:36:30 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> I noticed that CPU may be crossing the dependency threshold very
>>> frequently for some workloads and this results in a lot of
>>> interrupts which could be avoided if MCALL client is keeping actual
>>> EMC frequency at a higher rate.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c index
>>> c3cf87231d25..4d582809acb6 100644 ---
>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static void
>>> tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
>>>  
>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>> *tegra,
>>> -					   struct
>>> tegra_devfreq_device *dev)
>>> +					   struct
>>> tegra_devfreq_device *dev,
>>> +					   unsigned long freq)
>>>  {
>>>  	unsigned long avg_threshold, lower, upper;
>>>  
>>> @@ -323,6 +324,15 @@ static void
>>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>> avg_threshold = dev->config->avg_dependency_threshold;
>>> avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD; 
>>> +	/*
>>> +	 * If cumulative EMC frequency selection is higher than the
>>> +	 * device's, then there is no need to set upper watermark
>>> to
>>> +	 * a lower value because it will result in unnecessary
>>> upper
>>> +	 * interrupts.
>>> +	 */
>>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>>> +		upper = freq * ACTMON_SAMPLING_PERIOD;  
>>
>> Also, 'upper value is used on the patch5. You can combine this code
>> to patch5 or if this patch depends on the cpu notifier, you can
>> combine it to the patch of adding cpu notifier without separate patch.
> 
> Well okay, I'll try to squash some of the patches in the next revision.
> Usually I'm receiving comments in the other direction, asking to
> separate patches into smaller changes ;) So that's more a personal
> preference of each maintainer, I'd say.
> 

Right. We have to make the patch with atomic attribute.
But, if there are patches which touch the same code
in the same patchset. We can squash or do refactorig
of this code.

And also, if possible, I'd like you to make the patch
list according to the role of patch. For example,
the patches related to the 'watermark' could be sequentially
listed. But, it is not forced opinion. If just possible.



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

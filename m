Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C94129D2E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 05:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLXEA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 23:00:29 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27515 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfLXEA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 23:00:29 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191224040023epoutp0439fb8f22aa38763aad5f1ba69da6d127~jMq_AxmiN2239522395epoutp04J
        for <linux-pm@vger.kernel.org>; Tue, 24 Dec 2019 04:00:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191224040023epoutp0439fb8f22aa38763aad5f1ba69da6d127~jMq_AxmiN2239522395epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577160023;
        bh=uQY0Ejr1lqxO3NWqbSaO04+QA2XF/w19ImMi7FAHKMo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Z971ftgfB69YtWGg0tqIu42m/zVgvZ1PXCvDV0EYDnjpyznUPHMJAIoTXQDe3+aIC
         lyZunAIQw+SYamFYR6QRrjsGRwQGKRHSL42BFqJq1k3ZBoauPCXW+LH0V70bJPn4rI
         WJtZ2dl+SeuOBnvwZTvhZll225yQz4BkrutMQd8k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191224040022epcas1p48e4d6cb225f0cbdb5c607610ede80378~jMq88pPbX1759517595epcas1p49;
        Tue, 24 Dec 2019 04:00:22 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47hjDN0B7KzMqYkZ; Tue, 24 Dec
        2019 04:00:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.65.48498.35D810E5; Tue, 24 Dec 2019 13:00:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191224040018epcas1p45d9c176d204a753f410567406e6be508~jMq5TnVLL1598815988epcas1p4Q;
        Tue, 24 Dec 2019 04:00:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191224040018epsmtrp1784239067cb376af17824518732bb54e~jMq5Sweos3130831308epsmtrp16;
        Tue, 24 Dec 2019 04:00:18 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-03-5e018d53b1fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.BE.10238.25D810E5; Tue, 24 Dec 2019 13:00:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191224040018epsmtip2294363190d25eeb29d81905ab27d77a0~jMq5GSuJi2529525295epsmtip2r;
        Tue, 24 Dec 2019 04:00:18 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: exynos-bus: Add error log when get event
 fails
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7230b556-7a96-14d1-ed22-43b5a6cd5a71@samsung.com>
Date:   Tue, 24 Dec 2019 13:07:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191223191923.10450-1-tiny.windzz@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUcRTH++3szo7i1K/tem1RNtEleIzb2lhaQQdLSUhSUdTaoIO7uFcz
        u9LxR3ba5RFR2JIdZlEWKCoeZRm2UYblRSGKYJhRVlZ2Sdu1s2Pkf5/f+37f7733+z2K0JWR
        esrqcAuig7cxZKi6+v6CyMiUXGSOqe9P4PL73hJcS0u5lnuy/52Wq+h7ruE6bp0juc+5PsQV
        ttxVcd37rpFckb+AXB5iqvP2aE0VpUdJU2XJXlNeVSkyfa6YkazZkplgEfh0QQwXHGnOdKsj
        I5FZm5K6ItUYF8NGsvHcIibcwduFRGZlUnLkaqst0A8TnsXbPIFQMi9JTPTSBNHpcQvhFqfk
        TmQEV7rNFe+Kkni75HFkRKU57YvZmJhYY8C4PdPSVdOmdQ3RO/9cfYCykS/0GAqhAC+Eyu5h
        9TEUSulwLYKhwQ8q5TCEYKC5eUT5hqC48pP6X0rZlTZCZh2+g6A2L1oxfUBQ72/XyMIEnAIN
        v7qRLEzE2QhKfvmCVxH4EIKiVn/QReIIaHjdSco8Ds+CZ8N9gQyKovFSqPkeL4fVeA5cHGpD
        Mk/CG6Gp+mCQaTwems6+DHYUgpdATs+rIBN4CnS9vKBSeCbUvD9HyHUBH9DC19/5IyOshIO1
        wyM8AQYeVmkV1sOb/MMjvAeuN/lIJfkIgqqGVo0iGKDhyimV3CiBF0DZrWglPAvq/EVIKTwW
        Br+e0MgWwDQcOaxTLLOho7dHpfBUuJxzlCxAjHfUON5RI3hHjeD9X+wiUpeiyYJLsmcIEuuK
        Hf3dFSi4rBFxtaj4aVIjwhRiwujy+2PMOg2fJe2yNyKgCGYifUNEZh2dzu/aLYjOVNFjE6RG
        ZAy89klCPynNGVh9hzuVNcYaDAZuIRtnZFlmCk0Nt23T4QzeLWQKgksQ/+WpqBB9NlpXYtx8
        XO1Z1uU/nTswds9t1bT8F68GzpbF21eTc27WrOkvmBm1Y9q28hwmqniyGHEvs/DRKnremUvH
        k75/sXo6qgdTDFv1iWFnwtYX9JPW9o+9KC/W96OzaNPjn6cfbDT3L+4Js8xVn2ec68UD5vrS
        x3nL6pqzet/Nn76hvevGhU23GbVk4dkIQpT4v0r0Cy/CAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvG5QL2OcQedGHYv+x6+ZLc6f38Bu
        cbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gsbjeuYLOY+3sCmwOnx85Zd9k9Nq3qZPPYvKTe
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJubb/IXvCJt+L/sqOMDYxHuLoYOTkkBEwk1i+9
        yNzFyMUhJLCbUWLDs042iISkxLSLR4ESHEC2sMThw8UQNW8ZJX7c3cgMUiMsECyx/+9tRpCE
        iEADo8Tsc+fAHGaBVkaJR9sXsEC09DFK/Fo2ix2khU1AS2L/ixtgK/gFFCWu/njMCLKCV8BO
        Yvt3S5Awi4CqxIJPFxlBbFGBMImdSx4zgdi8AoISJ2c+YQGxOQWsJdrvPgOzmQXUJf7Mu8QM
        YYtL3HoynwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoT
        c4tL89L1kvNzNzGCY0xLcwfj5SXxhxgFOBiVeHg3HGaIE2JNLCuuzD3EKMHBrCTCu7qIMU6I
        NyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTilgSL5psjJK4b31
        VOJQkcf/iN/Z09YkeTZ+KbPbZvh30ZreeOmHKnl2n+7JaLyf8vnekeuzrn15t9JI6fQXbatZ
        4pFOrRnWZ6ouFZxn32Qt/8eyo+aVxd5A8fOhK9hLfNe2iGrtCyrmebBE5YPUNcu/n4waL2s+
        zz2vt3X+lzVH9x5RWHmyfvusXUosxRmJhlrMRcWJAOkiIgytAgAA
X-CMS-MailID: 20191224040018epcas1p45d9c176d204a753f410567406e6be508
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191223191928epcas1p128d39bb875b8654d61ae21364e466ec7
References: <CGME20191223191928epcas1p128d39bb875b8654d61ae21364e466ec7@epcas1p1.samsung.com>
        <20191223191923.10450-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I think that you better to use 'devfreq-event' instead of just 'event'
as following:

PM / devfreq: exynos-bus: Add error log when fail to get devfreq-event

On 12/24/19 4:19 AM, Yangtao Li wrote:
> Adding an error log makes it easier to trace the function's error path.
> Because the error code may be rewritten on return, print error code here.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/exynos-bus.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 948e9340f91c..634d63fd00ea 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -126,6 +126,8 @@ static int exynos_bus_get_dev_status(struct device *dev,
>  
>  	ret = exynos_bus_get_event(bus, &edata);
>  	if (ret < 0) {
> +		dev_err(dev, "failed to get event from devfreq-event devices %d\n",
> +			ret);

Better to make it under 80 char as following:

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index f5d4c369c7fb..10f4fa1a0363 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -126,7 +126,8 @@ static int exynos_bus_get_dev_status(struct device *dev,
 
        ret = exynos_bus_get_event(bus, &edata);
        if (ret < 0) {
-               dev_err(dev, "failed to get event from devfreq-event devices %d\n",
+               dev_err(dev,
+                       "failed to get event from devfreq-event devices %d\n",
                        ret);
                stat->total_time = stat->busy_time = 0;
                goto err;


>  		stat->total_time = stat->busy_time = 0;
>  		goto err;
>  	}
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

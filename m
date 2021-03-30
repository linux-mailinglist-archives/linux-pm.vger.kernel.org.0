Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3834DDED
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhC3CBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 22:01:46 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42088 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhC3CBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 22:01:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210330020134epoutp048a7fe358d76c67e31ad651acf154a3cc~w-FHircms2334823348epoutp047
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 02:01:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210330020134epoutp048a7fe358d76c67e31ad651acf154a3cc~w-FHircms2334823348epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617069694;
        bh=KJz2XCDnAnpjiHm1WYr908RuJ6E7c+ZZvBSnAGipfBk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Nnt0c3Bu87JM6gd0YjmDxPn6vS7c+5GyoqUJ/5n5SlkcM0rOyqlFLIB+GHE0gFKlW
         j08AlHdT9SewVX/46B9QqwbSsOxpWZ6/q2K1p7QKSOg5BMluClJd23x4mjZN4c9ce1
         or4Im4nO6OB+RBNoOQsDjcwIB1co8HtLvkuEmoaQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210330020134epcas1p20bdb65b985f1c0840f53ff8e72e27c25~w-FHN_A5V2054420544epcas1p2x;
        Tue, 30 Mar 2021 02:01:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F8Xk34cbvz4x9QC; Tue, 30 Mar
        2021 02:01:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.F1.07927.57682606; Tue, 30 Mar 2021 11:01:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210330020119epcas1p3d828ec2df9ebfab55b4c5026c00ed07f~w-E5EC2RZ1868518685epcas1p3Y;
        Tue, 30 Mar 2021 02:01:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210330020119epsmtrp122bd91480a91c2dfdd7225971cc9ad0c~w-E5DTOQy1321013210epsmtrp1f;
        Tue, 30 Mar 2021 02:01:19 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000011ef7-78-60628675b539
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.3E.33967.F6682606; Tue, 30 Mar 2021 11:01:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210330020119epsmtip19d3ed1845ef08c32ea4891e08930350a~w-E41eKbQ0054500545epsmtip1v;
        Tue, 30 Mar 2021 02:01:19 +0000 (GMT)
Subject: Re: [PATCH 1/2] PM / devfreq: imx-bus: Remove unneeded
 of_match_ptr()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fa22d132-4f9e-2051-1db9-901b018e6dfd@samsung.com>
Date:   Tue, 30 Mar 2021 11:18:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210329122425.579386-1-festevam@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmgW5ZW1KCwcG1TBYPr/pbdP1ayWzx
        ufcIowOzx85Zd9k9Nr7bweTxeZNcAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
        pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFl
        gV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGlib1gn9sFS++97E1MF5l7WLk5JAQMJFY3jOTvYuR
        i0NIYAejxKsLS1khnE+MEpefLYLKfGOUOLBtMxNMy4WJzUwQib2MEpvu9YLNEhJ4zyix8Jkt
        iC0sECDxdvo3li5GDg4RATWJ0/P0QcLMAvoSN5c/YgOx2QS0JPa/uAFm8wsoSlz98ZgRxOYV
        sJN4Muk2WJxFQFXiwbYZYHtFBcIkTm5rgaoRlDg58wkLiM0pYCnRe2c/C8R8cYlbT+YzQdjy
        EtvfzmEGuVNC4C27xPmFy5ghHnCR+LnhHNQzwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTY
        sv8CNMCMJfYvncwE8hizgKbE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7
        UGslJRa3d7JNYFSaheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBEjutNjOAUqGW6g3Hi
        2w96hxiZOBgPMUpwMCuJ8AofSEwQ4k1JrKxKLcqPLyrNSS0+xGgKDOCJzFKiyfnAJJxXEm9o
        amRsbGxhYmhmamioJM6bZPAgXkggPbEkNTs1tSC1CKaPiYNTqoEpak/g0bkaCYpnBfaevyOy
        bIeaje6OqDnZV492aHFvUveL7f+56NTfYvklxauuLpt9qSnvRuLd3Kssk7/s3vIv42P9l7Cc
        x68qtTftOffmkH7zEb7UpXeCWGM2MmicnfWuc3ZejkbgMu2+7z8LFguZSpR/ZRLLjH3o0tMZ
        nbjTwLGoRDBD7/IVRyuRptyP3/jnLX9/bc2s4FVqZbdk8h2Ezrt51WwRWPTgXHOO2OS/p4qZ
        9iiF984Itci7se+E20aPb/FXtK8J8vw2WlPywqKA69fFD6K5L92sH60WS935fpKLx3Pjl3JH
        n/Jsk98YlGbj7hrzdqmFTI24WECS36f77HaaSXsKnz3zK3O/wfxciaU4I9FQi7moOBEA2wun
        OwoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnG5+W1KCwepjPBYPr/pbdP1ayWzx
        ufcIowOzx85Zd9k9Nr7bweTxeZNcAHMUl01Kak5mWWqRvl0CV8aWJvWCf2wVL773sTUwXmXt
        YuTkkBAwkbgwsZmpi5GLQ0hgN6PEy4WHoBKSEtMuHmXuYuQAsoUlDh8uBgkLCbxllHi+ogLE
        Fhbwk1h6fQojSImIgJrE6Xn6IGFmAX2Jm8sfsUGM7GGUeNfeDTaSTUBLYv+LG2wgNr+AosTV
        H48ZQWxeATuJJ5Nug8VZBFQlHmybwQRiiwqESexc8pgJokZQ4uTMJywgNqeApUTvnf0sEMvU
        Jf7Mu8QMYYtL3HoynwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM
        81LL9YoTc4tL89L1kvNzNzGCY0FLcwfj9lUf9A4xMnEwHmKU4GBWEuEVPpCYIMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOThJzLygeiUiocnUcn8G2t
        3ftWa6Olz8QShZ333pslB9q56Imfv7GS55eU7KuGqOvV+q1VvxYsfJ1wIcD48Cvdte5b+w4z
        /tBO2dj4a5Yhv6pVysyL36ZcX8wd2OvY6lVn7pWkxbD587/phv/N0szbHkT3xu0PffUpylBj
        uyDPucv6ZZair+vNJkc/mPkh2WepteBqG0vGChsLkT/LY37NlvN6+FhwdaCey8Gf+2MqVJb/
        3Jh7b37c+Y23/b32qMQ2ccWlbXKf7X1/p1LLJbn/hR+zlk4ULP6ucMxU4KXjjAu+ETs9eA4H
        e+h1PzWIOKmpfej70iLrK95ft6asCcjlrs7gX+/7o76277FTywYlluKMREMt5qLiRACS0vyS
        9AIAAA==
X-CMS-MailID: 20210330020119epcas1p3d828ec2df9ebfab55b4c5026c00ed07f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210329122448epcas1p23b0917657190d25e11aabed424ec46bc
References: <CGME20210329122448epcas1p23b0917657190d25e11aabed424ec46bc@epcas1p2.samsung.com>
        <20210329122425.579386-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/29/21 9:24 PM, Fabio Estevam wrote:
> i.MX is a DT-only platform, so of_match_ptr() can be safely
> removed.
> 
> Remove the unneeded of_match_ptr(). 
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/devfreq/imx-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 4f38455ad742..3fc3fd77492d 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -169,7 +169,7 @@ static struct platform_driver imx_bus_platdrv = {
>  	.probe		= imx_bus_probe,
>  	.driver = {
>  		.name	= "imx-bus-devfreq",
> -		.of_match_table = of_match_ptr(imx_bus_of_match),
> +		.of_match_table = imx_bus_of_match,
>  	},
>  };
>  module_platform_driver(imx_bus_platdrv);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

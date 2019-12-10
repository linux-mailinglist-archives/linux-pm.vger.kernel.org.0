Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE3F11815B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 08:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLJH2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 02:28:16 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52697 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfLJH2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 02:28:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191210072814euoutp02fbda1362111d25bf97c1b4f83209a10f~e8eciaBGI1948319483euoutp02u
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 07:28:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191210072814euoutp02fbda1362111d25bf97c1b4f83209a10f~e8eciaBGI1948319483euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575962894;
        bh=+YNxTjPIZisvBTjIHijRU3MzVdP8VvUUxtLcLbg9HEQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C5PjE+Q+44hznUbul6wKW8ZJX9ZEwUYudwReXu99hgNSlClvUFjA4U5iWzfnbvn7T
         Nt2uJNWuwrbHDDT8wTaZmEMN3RwUct7AcXScIP8Zkrn6sU9cZVrFv+qdWyo4aOMqCu
         aYT9EYHmYdnyhYp39DZDKY5Q/29apGBvpQ9rQTo4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210072814eucas1p2ee669fa836bd1c3a43ad292c59fd2352~e8eb9ZluX2203922039eucas1p2D;
        Tue, 10 Dec 2019 07:28:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3F.AA.60679.D094FED5; Tue, 10
        Dec 2019 07:28:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191210072813eucas1p1746e7d68d5194961b53d8daab6be0a83~e8ebrS7_d2883328833eucas1p1r;
        Tue, 10 Dec 2019 07:28:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210072813eusmtrp1daeb9169c60069bfe28040e3e1f5c12f~e8ebqj8Yv0830808308eusmtrp1s;
        Tue, 10 Dec 2019 07:28:13 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-5e-5def490d3b2f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.0B.07950.D094FED5; Tue, 10
        Dec 2019 07:28:13 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210072813eusmtip13dfd7d1a96ae400868b1143e4082ed6f~e8ebU4Od20503805038eusmtip1P;
        Tue, 10 Dec 2019 07:28:13 +0000 (GMT)
Subject: Re: [PATCH 1/4] PM / devfreq: reuse system workqueue machanism
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <6ead2998-ebe1-704b-7d89-3b0cf8beca70@samsung.com>
Date:   Tue, 10 Dec 2019 08:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2eab8a20-1701-94dc-410a-bb072a5f5b4e@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7q8nu9jDZbdt7HYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xe3GFWwOHB6bVnWyefRtWcXo8XmTXABzFJdN
        SmpOZllqkb5dAldG69HbzAVvBCrm3DrN2sB4n7eLkZNDQsBEYsO6U0xdjFwcQgIrGCUuXl7D
        DuF8YZQ4eWgpK4TzmVHi6o9rzDAtt5/PZYZILAdqebWCEcJ5yyjxfv8Kti5GDg5hAXeJvZvD
        QBpEBDQkZv69AlbDLDCPSeLNtAusIAk2AX2Jg2dPsoDYvAJ2EpuvvACLswioSmyb3s0IMkdU
        IELi9NdEiBJBiZMzn7CAhDkF7CUWrLUFCTMLiEvcejKfCcKWl9j+dg7YbRICm9gl7t2YzQxS
        LyHgIvFqhgvE/cISr45vYYewZSROT+5hgbDLJZ4u7GOH6G1hlHjQ/hEqYS1x+PhFVpA5zAKa
        Eut36UOEHSXm/n8GNZ5P4sZbQYgT+CQmbZsOFeaV6GgTgqhWlXh+qocJwpaW6Pq/jnUCo9Is
        JH/NQvLMLCTPzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg0jn97/iXHYy7
        /iQdYhTgYFTi4V3g8C5WiDWxrLgy9xCjBAezkgjv8TagEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYzKj5SnalZtvOS/yFcp04nNt+prfd/Rh3ODZpza
        ldAnuTPJ1315e0OalM8O1rM3U9yMXv3vbFL5kLTy2DKWX3tDj616o/hmw8Wr8c2vRQ/Vzwi7
        sLTxztXr1fcXf67SVXmuElK9MV7l/bzMlZbyh/dNsdM88ET7bn3Hysif650tl3c+vfLsvelF
        JZbijERDLeai4kQAQJOVnzYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7q8nu9jDa5O0bLYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xe3GFWwOHB6bVnWyefRtWcXo8XmTXABzlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5G69HbzAVv
        BCrm3DrN2sB4n7eLkZNDQsBE4vbzucxdjFwcQgJLGSUuvP3CApGQlmg8vZoJwhaW+HOtiw2i
        6DWjxIMHfxi7GDk4hAXcJfZuDgOpERHQkJj59wojSA2zwAImifk3J7JANPxglHi3eRszSBWb
        gL7EwbMnwTbwCthJbL7yghXEZhFQldg2vZsRxBYViJB4vv0GI0SNoMTJmU9YQJZxCthLLFhr
        CxJmFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZiHpnoWkZRaSlllIWhYwsqxiFEktLc5N
        zy020itOzC0uzUvXS87P3cQIjLVtx35u2cHY9S74EKMAB6MSD+8Ch3exQqyJZcWVuYcYJTiY
        lUR4j7cBhXhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmAbySuINTQ3NLSwNzY3Njc0slMR5
        OwQOxggJpCeWpGanphakFsH0MXFwSjUwatu28BtlyF+/3cd/ZKF2h6uXlvg+VpcPciFHeKMZ
        ImXD6j+cyL+YGyE7b/nRN6xNIusXvbuaYF5fvfLTfYkT9f4h0U1iOl+Mqz/G+v1+2V/yOI/t
        ieCylYfijVV6BIp+CPKVMmXMZQhI9Qrav4/R0tT+RKq4HPPRmulTWa59drVxWNihvkmJpTgj
        0VCLuag4EQBcoOa6ywIAAA==
X-CMS-MailID: 20191210072813eucas1p1746e7d68d5194961b53d8daab6be0a83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2@eucas1p1.samsung.com>
        <20191209144425.13321-2-k.konieczny@samsung.com>
        <2eab8a20-1701-94dc-410a-bb072a5f5b4e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.12.2019 02:41, Chanwoo Choi wrote:
> On 12/9/19 11:44 PM, Kamil Konieczny wrote:
>> There is no need for creating another workqueue, it is enough
>> to reuse system_freezable_power_efficient one.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 46a7ff7c2994..955949c6fc1f 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1532,11 +1532,11 @@ static int __init devfreq_init(void)
>>  		return PTR_ERR(devfreq_class);
>>  	}
>>  
>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>> +	devfreq_wq = system_freezable_power_efficient_wq;
> 
> It affect the behaviors of whole device drivers using devfreq subsystem.
> It is not good to change the workqueue type without any reasonable
> data like experiment result, power-consumption result and performance
> result for almost device drivers using devfreq subsystem.
> 
> Are there any problem or any benefit to change workqueue type?

The workqueue is freezable with additional capability of 'power_efficient',
it is already developed by linux community so why not reuse it ?

> Actually, it is not simple to change the like just one device driver
> because devfreq subsytem is very important for both performance
> and power-consumption.

I agree. The name of this wq promises what you want, both freezable
and power efficiency.

> If you hope to change the feature related to both performance 
> and power-consumption, please suggest the reasonable data
> with fundamental reason.
> 
> So, I can't agree it.
> 
> 
>>  	if (!devfreq_wq) {
>>  		class_destroy(devfreq_class);
>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>> -		return -ENOMEM;
>> +		pr_err("%s: system_freezable_power_efficient_wq isn't initialized\n", __FILE__);
>> +		return -EINVAL;
>>  	}
>>  	devfreq_class->dev_groups = devfreq_groups;
>>  
>>
> 
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland


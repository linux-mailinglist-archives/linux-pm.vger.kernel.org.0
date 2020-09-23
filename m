Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16C274DD4
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 02:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIWA3U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 20:29:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:28954 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgIWA3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 20:29:19 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200923002917epoutp01a0d75f9d36eec1d73b9f85d1bef43e4b~3Qi3nNgma0072100721epoutp01J
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 00:29:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200923002917epoutp01a0d75f9d36eec1d73b9f85d1bef43e4b~3Qi3nNgma0072100721epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600820957;
        bh=CvaL2o7JC69EwYkRQ/vq+l6H5k9Q6j2xbnvLl8EH0DQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NtNi8YZNJxhv+sq+7ZPny0gJiKNjejOI4Et9zATx/FT8EnVCe2H6y635MO2fSv/IW
         qr3Ut8iM3evKV88/SeFhz+3iFUix7gMwNi4N3i9WsZrRlOm5tHcxnxV7o+r9vah2DL
         5oe6DRF87D3Rj3zUCw4HzgDvFHzE/YqdeezUfeSg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200923002916epcas1p2abd42168f1e9f09a92627a95ae98a3e1~3Qi3KWFBh0346303463epcas1p2f;
        Wed, 23 Sep 2020 00:29:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BwzZL6s64zMqYkk; Wed, 23 Sep
        2020 00:29:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.47.10463.3D69A6F5; Wed, 23 Sep 2020 09:29:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200923002906epcas1p1de4467e639c864681dc4cd01a988ac17~3Qith4CTl0176601766epcas1p12;
        Wed, 23 Sep 2020 00:29:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200923002906epsmtrp1232e3cf7f03abe27b6fcfb700f32004f~3QithJ17c0919209192epsmtrp1K;
        Wed, 23 Sep 2020 00:29:06 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-ef-5f6a96d3307e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.DF.08745.2D69A6F5; Wed, 23 Sep 2020 09:29:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200923002906epsmtip2634ce74612369bfd59b2e71b07135f9f~3QitS7LzJ0744907449epsmtip2_;
        Wed, 23 Sep 2020 00:29:06 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <10303589-a40d-f295-e35e-5c2cf6c8f2e0@samsung.com>
Date:   Wed, 23 Sep 2020 09:42:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <cc3523ad-1295-cccb-12da-f0ea7c129e7a@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmge7laVnxBt/Wili8/jedxWL1x8eM
        Fi2zFrFYbL0lbXG26Q27xefeI4wWnV9msVncblzBZvFz1zwWB06PnbPusnv0Nr9j8/j49BaL
        R9+WVYwenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vO
        z7UyNDAwMgUqTMjO+PfLpWAtd8XxbzfZGxhncXYxcnJICJhITOuby9LFyMUhJLCDUaLr3is2
        COcTo8S1W49ZIZzPjBJrXl1ngWm5daKZGSKxi1Fi97wGqJb3jBKLVv1gAqkSFvCW+P3gFyuI
        LSIQJLHr80ywDmaBdiaJ6e3vwBJsAloS+1/cYAOx+QUUJa7+eMwIYvMK2ElsPdzEDmKzCKhK
        HF52C6xGVCBM4uS2FqgaQYmTM5+AncQpYCvxvKsNbDGzgLjErSfzoWx5ieats8EWSwgs5JBY
        tX0R1A8uEh17vkLZwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTYsv8CK0TCWGL/0slAGziA
        NmhKrN+lDxFWlNj5ey4jxGI+iXdfe1hBSiQEeCU62oQgSpQlLj+4ywRhS0osbu9km8CoNAvJ
        O7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhgghzdmxjBiVXLYgfj3Lcf9A4xMnEwHmKU4GBW
        EuFVM0qPF+JNSaysSi3Kjy8qzUktPsRoCgzgicxSosn5wNSeVxJvaGpkbGxsYWJoZmpoqCTO
        +/CWQryQQHpiSWp2ampBahFMHxMHp1QDU6syx6rH6Zr3RM0nvxT2mJrW3/reunzd9B+XTYL3
        alXUzfhx1Lkzjz8iUt5HUvvlAtUDvaf3Xam/lNX1KGDO8cs5fyav6p+aYXtxDXvqRgEfkwY9
        Pc7+oJfeG/iu3dF65V2Zo6gyzbcrf/vKy2ZWU8Utdhxd+nDb/wd9PxWkViUYZXIdLBJwcjv8
        vvB44ny2NyETf31+d9o35QTvygUrd9bu2GOsK3Rqwa7DcomH67cz7E4w7r3IXjEvfbdd2e8H
        qYcEdD7Ku146VDXp49uqgs0vLu43Xa5asOnifkdRZ9tFisVcZfEnf97PWOAu3M8umZAsmrP9
        eP4skRd+syz/SO6T4zm626GGLd35hqtDtBJLcUaioRZzUXEiAPzjeJk1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXvfStKx4g9PLFC1e/5vOYrH642NG
        i5ZZi1gstt6Stjjb9Ibd4nPvEUaLzi+z2CxuN65gs/i5ax6LA6fHzll32T16m9+xeXx8eovF
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDL+/XIpWMtdcfzbTfYGxlmcXYycHBICJhK3TjQz
        dzFycQgJ7GCU2PrpOStEQlJi2sWjQAkOIFtY4vDhYoiat4wSt/41MIHUCAt4S/x+8AusXkQg
        SOLU5reMIDazQCeTxPEzdhANH1glJu/4wgaSYBPQktj/4gaYzS+gKHH1x2OwBl4BO4mth5vY
        QWwWAVWJw8tugdWICoRJ7FzymAmiRlDi5MwnLCA2p4CtxPOuNiaIZeoSf+ZdYoawxSVuPZkP
        FZeXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5
        uZsYwfGlpbWDcc+qD3qHGJk4GA8xSnAwK4nwqhmlxwvxpiRWVqUW5ccXleakFh9ilOZgURLn
        /TprYZyQQHpiSWp2ampBahFMlomDU6qBqXVyRqwCc2Tm6jXejV8k/9oc/btyC9ucHo2geccb
        TG6wvrwU1qTE/oPnywrf9Y4vZkvXX6/2dbG/f2dug7eSYtK8S0xlJ3I2z9dRq7V7babTuDbr
        Tjfn6eOpZnY6wifSjj9MeqnzetrCS19dJ+pmszDtstJzy3Let2xx1aa+R6H1sz99ONMuz5PY
        HsJbXdsp5xfKsU/irfr6ct1KyVvTdk9Va388caHF+2kz7WzS+ZO8qutTlQs5rI2YXkYELvi/
        Zx9Hsk+J4OVoh2Oi80PZLuy0m/yMydbp41bjG0u2+31llxfJ6fzgkDq9+vaJYzZq4QERsy/d
        qtv5tE6eVW/b4Y2djWd3XF+wqTjvr5qnEktxRqKhFnNRcSIAV/62lR4DAAA=
X-CMS-MailID: 20200923002906epcas1p1de4467e639c864681dc4cd01a988ac17
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
        <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
        <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
        <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
        <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
        <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
        <57e8ccad-f0d5-febb-7a31-8d34430a5cb8@gmail.com>
        <64f4b682-00b7-60f2-902f-e50a40a04a55@samsung.com>
        <c80c6f3a-bbbf-f18b-33c8-62e63397df9c@gmail.com>
        <cc3523ad-1295-cccb-12da-f0ea7c129e7a@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/23/20 9:23 AM, Dmitry Osipenko wrote:
> 21.09.2020 00:37, Dmitry Osipenko пишет:
>> 18.09.2020 12:23, Chanwoo Choi пишет:
>> ...
>>>> Hence if we want to improve the code, I think we can make this change:
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>> b/drivers/devfreq/tegra30-devfreq.c
>>>> index ee274daa57ac..4e3ac23e6850 100644
>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>> @@ -891,8 +891,6 @@ static int tegra_devfreq_probe(struct
>>>> platform_device *pdev)
>>>>  		return err;
>>>>  	}
>>>>
>>>> -	reset_control_assert(tegra->reset);
>>>> -
>>>>  	err = clk_prepare_enable(tegra->clock);
>>>>  	if (err) {
>>>>  		dev_err(&pdev->dev,
>>>> @@ -900,7 +898,7 @@ static int tegra_devfreq_probe(struct
>>>> platform_device *pdev)
>>>>  		return err;
>>>>  	}
>>>>
>>>> -	reset_control_deassert(tegra->reset);
>>>> +	reset_control_reset(tegra->reset);
>>>>
>>>>  	for (i = 0; i < mc->num_timings; i++) {
>>>>  		/*
>>>
>>> It looks good to me for improving the readability
>>> for everyone who don't know the detailed h/w information.
>>
>> Okay, I'll make a patch sometime soon.
> 
> Chanwoo, I want to clarify that the Dan's v1 patch is still good to me
> and should be applied. I'll improve the readability on top of the Dan's
> change.
> 
> 

OK. Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

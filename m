Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17C117D39
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 02:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfLJBfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 20:35:16 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46014 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLJBfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 20:35:14 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191210013510epoutp0299dc47ba67da871723773e073389bb05~e3qLepXS_0726507265epoutp02D
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 01:35:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191210013510epoutp0299dc47ba67da871723773e073389bb05~e3qLepXS_0726507265epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575941710;
        bh=qFiCkpWdOhMk6slOqt40KxqUMhSvlXpG9cflFcoQj2I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LUHpmSPv6HLm9R/eR8aw7ZYm7SDqmlXd6lMFvxjmxKd4Y/b7+ymY8aVPMgkmpk0GH
         Ok9S387axIMRgZE3C9Nu+ajSVJ4zTVbbaURcCsyrqTVXCvim65MxP0fKn61D6+9Ham
         Gem+OKxBDuxs7kIKSY0Ui3zukZ4piotmfE9vbKhM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210013510epcas1p2248b3cbbae64420c6c1b8dd87bfd1bbb~e3qLK-vr81892118921epcas1p2d;
        Tue, 10 Dec 2019 01:35:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47X2gH5QH7zMqYlh; Tue, 10 Dec
        2019 01:35:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.40.48019.546FEED5; Tue, 10 Dec 2019 10:35:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210013501epcas1p2532f000b722aac007d096c7adc1f92b4~e3qCntqUY2119221192epcas1p22;
        Tue, 10 Dec 2019 01:35:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210013501epsmtrp1d908bcace9dc47ff1fe897fc32efc236~e3qCm_50y0823808238epsmtrp1q;
        Tue, 10 Dec 2019 01:35:01 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-16-5deef6455802
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.DC.06569.546FEED5; Tue, 10 Dec 2019 10:35:01 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210013501epsmtip14955e9626732f54cb7603b58c6c824e7~e3qCdp8pt1587015870epsmtip1X;
        Tue, 10 Dec 2019 01:35:01 +0000 (GMT)
Subject: Re: [PATCH 1/4] PM / devfreq: reuse system workqueue machanism
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2eab8a20-1701-94dc-410a-bb072a5f5b4e@samsung.com>
Date:   Tue, 10 Dec 2019 10:41:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209144425.13321-2-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTURju7G53V3N5mqlvBmVXjDKWXufqJi2KrAZFWZE/ArGLHtTcV7tT
        rP6U1MzIPijFRGtQUkplUyu1cmRqCeX6RMmKKClNUzLtgwradhf573mf93nO+z7nHIZSO+ko
        JtdsJzazYGTpYPmNe4viNWu/jaYneFzxvKuiXsE7xysUvMdzTck/KhpR8s9aq2j+a2kH4q90
        vFby/Qcu0asYQ0NdCW041lSHDF8b5qZSO/JW5BAhi9iiiTnTkpVrztazG7ZlrMnQLU3gNNxy
        fhkbbRZMRM+mbEzVrMs1ejdgowsEY76XShVEkY1fucJmybeT6ByLaNezxJpltC63LhEFk5hv
        zl6SaTElcwkJiTqvcGdejruqRWYtmlF4+k3EfnR3+hEUxABOgq6xV4ojKJhR42YEVYM9gWIc
        QU3bmFIqviGYONam+Gd52neLlhp3EJw+9FsmFWMInlR3eTsME4bXw53GNJ9hFtbASHMN5dNQ
        +KwMRsof+0+icRy4B/toHw7F8+HFj/fIh1V4JZSWOvy8HMdC5/Wfch8Ox2nQfeNgQDMTus8M
        +PkgrIfjveN+PYUj4eXAOZmE58HNz1X+wYCHaWh5+kcmRUiBMyV1tITD4NP9JqWEo2DouCOA
        90FtdwctmQ8jaHI/DuTXgrvmlMyXksKLoL41XqLnQ8uvaiQNngGjk0cVPglgFRx2qCVJDDx7
        +zqwwmw4X1xCn0Bs5ZQ4lVMiVE6JUPl/mBPJ61AEsYqmbCJy1qSpr92A/L8zjm9Gt3s2tiPM
        IDZE5Vw1mq5WCAXiHlM7AoZiZ6nuO7yUKkvYs5fYLBm2fCMR25HOe9snqajwTIv3r5vtGZwu
        UavV8kncUh3HsZEq5seTdDXOFuwkjxArsf3zyZigqP3IMfFlMiTkw+U5jelxi12hawrLNhW4
        dENprUNzn4emFNfvGvLMHO9KFotIpM55ES184VGX3Sb6mqs7LhiSD33cYD1xNHh7P2eoLV9t
        7HT39DeGXX7YFjapra13TWt4NGfXq+ESzbsHpt2tJ8tymc29MWK5eUvxRGxhp45esLXiO2Hl
        Yo7AxVE2UfgLjFYelbMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTtf127tYgyM7uCw2zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJWxf85OpoImvoop98QaGA9ydzFyckgImEhcurGbrYuRi0NIYDejxP5jc9gg
        EpIS0y4eZe5i5ACyhSUOHy4GCQsJvGWUmHGgBiQsLOAusXdzGEhYREBX4s2OpcwgY5gFFjBJ
        zL85kQVi5mFGiR3Ln7KCVLEJaEnsf3EDbD6/gKLE1R+PGUFsXgE7id7eNrA4i4CqxNGtP1lA
        bFGBMImdSx4zQdQISpyc+QQszilgK9F//RNYPbOAusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7A
        KDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcARpae1g
        PHEi/hCjAAejEg+vh927WCHWxLLiytxDjBIczEoivMfbgEK8KYmVValF+fFFpTmpxYcYpTlY
        lMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYI3p4Y0zK/j05wmgdNT1cWDXIJM9tsuTMI58V
        woJbLlilbl2+UFGxJti0rbQ4Pfl6RtEdadHNd5N9bMOi+m8dnGb0xO1W2b7Qmf/erj3yMiA8
        frr7jKkrsr6Efy+ydas+aXNy0YOQ3f9WeO5efiH5zqYvWxQk7b63TRHa8zhMTiyaI//gd6lw
        JZbijERDLeai4kQARxaNG5wCAAA=
X-CMS-MailID: 20191210013501epcas1p2532f000b722aac007d096c7adc1f92b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2@eucas1p1.samsung.com>
        <20191209144425.13321-2-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/9/19 11:44 PM, Kamil Konieczny wrote:
> There is no need for creating another workqueue, it is enough
> to reuse system_freezable_power_efficient one.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 46a7ff7c2994..955949c6fc1f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1532,11 +1532,11 @@ static int __init devfreq_init(void)
>  		return PTR_ERR(devfreq_class);
>  	}
>  
> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
> +	devfreq_wq = system_freezable_power_efficient_wq;

It affect the behaviors of whole device drivers using devfreq subsystem.
It is not good to change the workqueue type without any reasonable
data like experiment result, power-consumption result and performance
result for almost device drivers using devfreq subsystem.

Are there any problem or any benefit to change workqueue type?

Actually, it is not simple to change the like just one device driver
because devfreq subsytem is very important for both performance
and power-consumption.

If you hope to change the feature related to both performance 
and power-consumption, please suggest the reasonable data
with fundamental reason.

So, I can't agree it.


>  	if (!devfreq_wq) {
>  		class_destroy(devfreq_class);
> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
> -		return -ENOMEM;
> +		pr_err("%s: system_freezable_power_efficient_wq isn't initialized\n", __FILE__);
> +		return -EINVAL;
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

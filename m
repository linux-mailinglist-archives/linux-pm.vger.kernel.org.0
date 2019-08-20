Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B832A95283
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 02:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfHTATi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 20:19:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:64661 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTATh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 20:19:37 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190820001935epoutp020ae1dc9abd5e366f7ef27592ada99450~8eYNnBerT1299712997epoutp020
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 00:19:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190820001935epoutp020ae1dc9abd5e366f7ef27592ada99450~8eYNnBerT1299712997epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566260375;
        bh=tiKuzbBFO1qPnOxWRqi4oSHOWLECBQ8oOkwty0cA6FU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E/fXgVUADJZ78+5uW0x+Cny6oJMuBucSHhYEjHsLzVfBMpXJV/3nMW7q07x4o11pf
         UECHEqUE/fNsAt3RQ28GIovk06Acs4dQJ1cz03oSrjStBPKlofz4FEJOt8j7o5/+ls
         WYgQSvw9upYHdAiKhn+kxtR+O+8YO+0367j9d3iM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820001935epcas1p2e66a7c771ad6735e0c2adce1f97fd23a~8eYNF9xo00333803338epcas1p2H;
        Tue, 20 Aug 2019 00:19:35 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46CBHm6XfGzMqYly; Tue, 20 Aug
        2019 00:19:32 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.9C.04075.19C3B5D5; Tue, 20 Aug 2019 09:19:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190820001929epcas1p373b9a559be18d326fac7e82b69eb2a2c~8eYHqdI5D1547915479epcas1p3m;
        Tue, 20 Aug 2019 00:19:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820001929epsmtrp2b339e510f8b32c07efee19eb3198d6ab~8eYHpsbDk0760407604epsmtrp2h;
        Tue, 20 Aug 2019 00:19:29 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-a8-5d5b3c9154ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.05.03638.19C3B5D5; Tue, 20 Aug 2019 09:19:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820001929epsmtip2c11ba8b82385296ba633598e132820e9~8eYHdM6LY2532325323epsmtip2A;
        Tue, 20 Aug 2019 00:19:29 +0000 (GMT)
Subject: Re: [PATCH v6 08/19] PM / devfreq: tegra30: Ensure that target freq
 won't overflow
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c85dbd27-7536-9c51-19a2-fe1c2c6342b9@samsung.com>
Date:   Tue, 20 Aug 2019 09:23:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-9-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt7vd3Umr28w8DSq79kBhc9e1dSsNqahFBoIQWdi8ucsm7sXu
        jDICy16OlEwKupmVFvigBNFyQg10PbSHlhSVSUYWZbJKeyjRY9s18r/vfN93zu+c8zsEpmrG
        1USB08t5nKydwmOk17qStJqTaTtydT0hxDR9eYOYQ0KtlHlwcFTO9HdU48x4eRAxZV8FnBk4
        UI8zkx01UqbiymM8Q2FqH7yETH5hUG4qLw3hporWRmQab1mQJdtemGbjWAvnSeCc+S5LgdOa
        Tm3ONq8zG4w6WkOvZFZQCU7WwaVT6zOzNBsK7OGGqITdrL0oTGWxPE+lrEnzuIq8XILNxXvT
        Kc5tsbtXurU86+CLnFZtvsuxitbpUg1hY16h7WnXYeR+p9hz+Z6+BB0nfIgggFwOz3vifSiG
        UJHtCJqv/cLFYAxBbeOrqeA7gqcfKjAfUkQzQo/uykXhBoIrAx+lYvAJwdVPNdKIK5bMhfsX
        XqCIMIf8jaBsshSPCBiZA13+JkkE42QyBN4/i/KzyEXwZOINimAluQb8z/3RQlJyCVx6PRH1
        x5HbYGyoSyZ6ZkP3meGoR0EaofFEORLrx8OL4fMSES+E0razWKQJIP/gECpplYgzrIcq4SUu
        4lgYudMqF7EaxkM3pvh90NAdxMXkYwhaA30yUdBD4HKVJLI+jEyC5o4UkV4E/p/nppqYCaFv
        x2XihpVw7IhKtCRC/9DgVAvzoO5oGX4CUcK0cYRpIwjTRhD+P3YBSRvRXM7NO6wcT7tTp/92
        C4oea7KxHdU+zOxEJIGoGUrT6e25Khm7m9/r6ERAYNQc5Z7qMKW0sHuLOY/L7Cmyc3wnMoS3
        XYmp4/Jd4dN3es20IVWv1zPLaaOBpql45cUJJldFWlkvV8hxbs7zL09CKNQlSBhZm96b07Ix
        rn7JWO3qpZltDS83N93Mzk7JUB8J7pu5osZXkGQ9FwgMBYOqnKZN2lKNZjU/uRj6dGaJ/Nba
        nkS8GjOc1R74UZUXs+PHrrzeFuPI2/idlcWWwLJqX/eXCpfSdn+g2H391NYam+V2xueTo/Nj
        +0a37K/7UDncxg1SUt7G0smYh2f/AvbL5RzCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO5Em+hYg5/PeCxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyrh1uZSx4xlmx9LRxA2MPRxcjJ4eEgInEu4sn
        2LsYuTiEBHYzSvSue8sOkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxLRtbiC2sECsxJkFtxhB
        ekUEmpgkNvVeAOtlFoiU6Jm7hQ1i6FZGib6fi1lBEmwCWhL7X9xgA7H5BRQlrv54zAhi8wrY
        Sey8uZMFxGYRUJVY8vAHE4gtKhAhcXjHLKgaQYmTM5+A1XAKmEmsmtDLCLFMXeLPvEvMELa4
        xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHGFaWjsYT5yIP8QowMGoxMPrMS0qVog1say4MvcQowQHs5IIb8UcoBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZGy+la904+/mC9IX2G
        9y4B0xkrMv6KxbarnboX8Lg3Y99xyyrbAPsnMUuPNTjdPj3bgb3ysnOsdFfTXv9fCsc19pVn
        vWCflctrYbXFjGtD+83n+/V0mFeL14o0Pr6vWV1V3HyVy/fsxic69dfXLBc+6+GpuTWl6yC3
        8uTvps9tGmp2H9EtU09QYinOSDTUYi4qTgQAfIr9lqwCAAA=
X-CMS-MailID: 20190820001929epcas1p373b9a559be18d326fac7e82b69eb2a2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212546epcas1p22be9fefe18908cdd17a518950d296983
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212546epcas1p22be9fefe18908cdd17a518950d296983@epcas1p2.samsung.com>
        <20190811212315.12689-9-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
> We already had few integer overflow bugs, let's limit the freq for
> consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 70dce58212a4..ca499368ee81 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -430,7 +430,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>  	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
>  	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
>  
> -	return target_freq;
> +	return min(target_freq, tegra->max_freq);

Once again, did you meet this case sometimes?

Usually, we can prevent the overflow of target_freq
when calculating the target frequency or this style.

I think that if the overflow of target frequency happen frequently,
it might have the problem of calculation way. 

>  }
>  
>  static irqreturn_t actmon_thread_isr(int irq, void *data)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

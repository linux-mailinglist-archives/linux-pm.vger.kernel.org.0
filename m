Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0CEF455
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfKEEBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 23:01:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:58585 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfKEEBs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 23:01:48 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191105040144epoutp01377588d67371d1dd4aed77df3d1a3fb4~UKFJujlH11716617166epoutp01g
        for <linux-pm@vger.kernel.org>; Tue,  5 Nov 2019 04:01:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191105040144epoutp01377588d67371d1dd4aed77df3d1a3fb4~UKFJujlH11716617166epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572926504;
        bh=JY5jq/0o4wZe7fcmVli9Yu2A+IZHz38XOTT91amiXNM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LEjxUJjTyrM2RyAxFfDQ0qpNNUmqOikI3sfWGWo7UUBjc9py6zh18lpwwAfKQ4WDN
         WCk/9xK9lj2aO+mu2f+U3WWql2P+XYL7hPEG3zOcCJN5PxmNyylHfrL+I20MnUNh41
         RamszNKh+wIBjjl8bTroKGzKB8NBQWLurOXINroc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191105040143epcas1p291afac085b14a57a35741dab6d02a241~UKFJSzBhO2075820758epcas1p2h;
        Tue,  5 Nov 2019 04:01:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 476bZY4ndFzMqYkh; Tue,  5 Nov
        2019 04:01:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.9E.04068.524F0CD5; Tue,  5 Nov 2019 13:01:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191105040141epcas1p120bef9e833a873195ff027352604eca0~UKFGt3iYr1947619476epcas1p1X;
        Tue,  5 Nov 2019 04:01:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191105040141epsmtrp11b2c33ae40a508f67ccf14e600ff1152~UKFGtK4Dl2330223302epsmtrp1W;
        Tue,  5 Nov 2019 04:01:41 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-05-5dc0f425ac37
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.B1.24756.424F0CD5; Tue,  5 Nov 2019 13:01:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191105040140epsmtip1aaf5b9ab06e935dad80a9e6a98abd638~UKFGT4cZm2507025070epsmtip1w;
        Tue,  5 Nov 2019 04:01:40 +0000 (GMT)
Subject: Re: [PATCH v9 19/19] PM / devfreq: tegra20/30: Add Dmitry as a
 maintainer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0e7db72b-37ff-a36e-11fe-727ed43c26a6@samsung.com>
Date:   Tue, 5 Nov 2019 13:07:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104215617.25544-20-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmnq7qlwOxBg/Xq1ms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFt+en2K0uN24gs3i7DNvi5+75rFY9K29xObA7bHj7hJG
        j52z7rJ79Da/Y/OY1baPzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
        DAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
        pOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ9z4+IetYCJ3xaRjE1kaGJdydjFyckgImEic
        WzuPsYuRi0NIYAejxMnF75ghnE+MEk+OfmSBcL4xSsw73MEK03J61yd2iMReRonbM1+yQTjv
        GSWuvW1hBKkSFgiR+H7mIytIQkTgCZPE3iMtLCAJZoFIicM7VzOB2GwCWhL7X9xgA7H5BRQl
        rv54DNTMwcErYCfR+cEdJMwioCKx4/AyZpCwqECExOmviSBhXgFBiZMzn4BN5BQwl3h58xkz
        xHRxiVtP5jNB2PISzVtng70jITCdXWLfs1tMEB+4SDxe+4QNwhaWeHV8CzuELSXxsr8Nyq6W
        WHnyCBtEcwejxJb9F6DeN5bYv3QyE8hBzAKaEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6J
        jjYhiBJlicsP7kKdICmxuL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBKXJs
        b2IEJ10tyx2Mx875HGIU4GBU4uH90H4gVog1say4MvcQowQHs5II78UZe2OFeFMSK6tSi/Lj
        i0pzUosPMZoCA3sis5Rocj4wI+SVxBuaGhkbG1uYGJqZGhoqifM6Ll8aKySQnliSmp2aWpBa
        BNPHxMEp1cAYcvnS7q9NhXN/ZVmv49Y89fz8rGNzrYPnZ8yY2iq6P9ykcNG2mTlKzdl2Kk6H
        pnIFL3ZpvZjy8mrjp5oQJ0nr85N+X7b7dvDA/bcvas9KnV7C6rP86G3zHMFdK4KKKw7Pl7k2
        U38rX+eDS5Jh7ysml/vLTeltETrG+orl0JcnPxtMw4UeuCw9psRSnJFoqMVcVJwIAClbXODQ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnK7KlwOxBhseW1us/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFt+en2K0uN24gs3i7DNvi5+75rFY9K29xObA7bHj7hJG
        j52z7rJ79Da/Y/OY1baPzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgybnz8w1Ywkbti0rGJ
        LA2MSzm7GDk5JARMJE7v+sTexcjFISSwm1Hi05sZzBAJSYlpF48C2RxAtrDE4cPFEDVvGSXW
        TJrIAlIjLBAi8f3MR1aQhIjAMyaJhXt3MoEkmAUiJXrmbmGD6NjGKDH35Q5WkASbgJbE/hc3
        2EBsfgFFias/HjOCbOAVsJPo/OAOEmYRUJHYcXgZ2BGiAhESz7ffYASxeQUEJU7OfAK2mFPA
        XOLlzWfMELvUJf7MuwRli0vcejIf6gZ5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQ
        nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERx/Wpo7GC8viT/EKMDBqMTD+6H9QKwQa2JZcWXu
        IUYJDmYlEd6LM/bGCvGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbL
        xMEp1cCo4Z+wtiXxVU7v/6gZC6qbks45MShMufoi51Cou7Vz6f1H597Prix59UlmwvJX99h0
        +rPl7+0o8VjDKRQTd05lk7zg9YZ1ZfJJ+lvntL/L2cS7P2bfkcIOae03DLujplr1Ohx6vuTX
        PPMnHz00sgRbU7j1ug4xxBrVHa39fGC+U72OZPqatjolluKMREMt5qLiRAC36CAIuwIAAA==
X-CMS-MailID: 20191105040141epcas1p120bef9e833a873195ff027352604eca0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191104221855epcas4p3761ca7e09ffa66b686be8b5a840ea383
References: <20191104215617.25544-1-digetx@gmail.com>
        <CGME20191104221855epcas4p3761ca7e09ffa66b686be8b5a840ea383@epcas4p3.samsung.com>
        <20191104215617.25544-20-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
> want to help keep them working and evolving in the future.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f69d01da3a6..4b9679988514 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10632,6 +10632,15 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +F:	drivers/devfreq/tegra30-devfreq.c
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	https://protect2.fireeye.com/url?k=9d0ba644-c09508de-9d0a2d0b-0cc47a336fae-300ed90f1ba3077c&u=http://www.linux-mm.org/
> 

Looks good to me. 

But, the merge conflict might be occurred.
After getting the review from Myungjoo,
you better to send this patch separately
based on the latest MAINTAINERS file.

Thanks for your all efforts.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

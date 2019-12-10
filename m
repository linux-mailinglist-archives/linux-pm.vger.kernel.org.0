Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51D117D57
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 02:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLJBs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 20:48:28 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:53865 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfLJBs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 20:48:27 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191210014824epoutp02ac738b12ff40cf9dfedbae9d25d6cacc~e31vHpxPh2029420294epoutp02M
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 01:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191210014824epoutp02ac738b12ff40cf9dfedbae9d25d6cacc~e31vHpxPh2029420294epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575942504;
        bh=k7AI/Lr2qas6OzGrBYygZV3pRf4kGqEMg5Ib9WF0vSA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Gf5MMXByDEkWTwXDWn1ybxIwWLxfeGevpI5k+vXs8otz2A0pfgRVIiOdJqyG5UxDL
         CXcdpQa6+O4ygLifI2ZwZR3r8X8cZWqoq8LoVv/MZ3g+H4+Z7cn8iQCWWdKQ5jQH0x
         py7RkPm1pKvQuitFhn8Hz86LFtZZYwUFZwGmrSkY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210014824epcas1p12e25b46c851a1f484ddc1ea0bbe00cf1~e31uz4jt41395913959epcas1p1o;
        Tue, 10 Dec 2019 01:48:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47X2yZ2MHYzMqYkn; Tue, 10 Dec
        2019 01:48:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.71.57028.C59FEED5; Tue, 10 Dec 2019 10:48:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210014812epcas1p28ba190c592a7a17efb59b17c0a060255~e31jMOl2S2756727567epcas1p2M;
        Tue, 10 Dec 2019 01:48:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210014812epsmtrp10257692d72b7427f91000afadd93138b~e31jLc9mr1565015650epsmtrp1K;
        Tue, 10 Dec 2019 01:48:12 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-c1-5deef95c8264
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.7C.10238.B59FEED5; Tue, 10 Dec 2019 10:48:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210014811epsmtip1de99097e6676eceb4887da936929a30e~e31i_MbGR2302523025epsmtip1j;
        Tue, 10 Dec 2019 01:48:11 +0000 (GMT)
Subject: Re: [PATCH 3/4] PM / devfreq: Kconfig: add DEVFREQ_DELAYED_TIMER
 option
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4b1b94e9-890a-cce1-c33d-33864c7ed230@samsung.com>
Date:   Tue, 10 Dec 2019 10:54:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209144425.13321-4-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmnm7Mz3exBpNOSlhsnLGe1WLBpxms
        FufPb2C3ONv0ht3i8q45bBafe48wWqw9cpfd4nbjCjYHDo9NqzrZPPq2rGL0+LxJLoA5Ktsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xq95
        i9gLOvkq9ncvZ21gnMzdxcjJISFgIvF992KWLkYuDiGBHYwSu862MkM4nxglXnd0MUI43xgl
        rnX2MMG0XFl/FCqxl1Hi/47b7BDOe0aJhb1L2ECqhAWCJN59+QxmiwjoSrzZsRRsLrPAPCaJ
        N9MusIIk2AS0JPa/uAFWxC+gKHH1x2NGEJtXwE5i3aunYDUsAqoSfY0P2EFsUYEwiZPbWqBq
        BCVOznzCAmJzCthK3Nu4Eew8ZgFxiVtP5kPZ8hLb384BWywh8JpN4ubE+4wQP7hI3DhxBsoW
        lnh1fAs7hC0l8bK/Dcqullh58ggbRHMHo8SW/RBXSwgYS+xfOhloAwfQBk2J9bv0IcKKEjt/
        z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE5Qd3ocEoKbG4vZNtAqPSLCTvzELywiwkL8xCWLaA
        kWUVo1hqQXFuemqxYYEhcnxvYgSnTy3THYxTzvkcYhTgYFTi4V3g8C5WiDWxrLgy9xCjBAez
        kgjv8TagEG9KYmVValF+fFFpTmrxIUZTYGhPZJYSTc4Hpva8knhDUyNjY2MLE0MzU0NDJXFe
        jh8XY4UE0hNLUrNTUwtSi2D6mDg4pRoYSx9xR/vu8PtUv0T847uqFVxZOhqtbDtj1q8V5560
        7AJ3UFkPi4zO7pDmA8Yb2KKspx//ZbPgvmk2p03f9BgXgb3SfTcPsjzk7T5r9fBMc7es7Oe6
        WwwuV7r7NSbctXPe51nmfFgwcmOMj5l2+Xm5KcrMKvcEAqYum//zH5vpFz7ZbQem/I1RYinO
        SDTUYi4qTgQALuCLbbUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTjf657tYg3efbCw2zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJXxa94i9oJOvor93ctZGxgnc3cxcnJICJhIXFl/lLGLkYtDSGA3o8S91Y3s
        EAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZR41NXKBFIjLBAk8e7LZzYQW0RAV+LNjqXMIEXMAguY
        JObfnMgC0XGYUaL3y09WkCo2AS2J/S9ugHXwCyhKXP3xmBHE5hWwk1j36ilYDYuAqkRf4wOw
        K0QFwiR2LnnMBFEjKHFy5hMWEJtTwFbi3saNYHFmAXWJP/MuMUPY4hK3nsyHistLbH87h3kC
        o/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwXGkpbmD
        8fKS+EOMAhyMSjy8CxzexQqxJpYVV+YeYpTgYFYS4T3eBhTiTUmsrEotyo8vKs1JLT7EKM3B
        oiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qB0YltQ0nMuTfqNR7RZ4//Dt3oP+30gZ3H/y1X
        P97NM7M6LeO6sIJyzrVQ6ZIrBzjKGGaa8fQJ680NShVoX/uoz4Dd7O97baHJmV03GrXSkhqu
        Z0xy1NroX7tQTXUHx736+9/d/pvMebw2L0s3g2ndtQ/sTElrt1/dzy6XKq5h5vOsYspC/4P/
        lViKMxINtZiLihMBAcMNIp8CAAA=
X-CMS-MailID: 20191210014812epcas1p28ba190c592a7a17efb59b17c0a060255
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91@eucas1p1.samsung.com>
        <20191209144425.13321-4-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/9/19 11:44 PM, Kamil Konieczny wrote:
> Add Kconfig option DEVFREQ_DELAYED_TIMER. If set, devfreq workqueue
> will use delayed timer from its start.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 38a94df749a2..c799917c34c9 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -74,6 +74,18 @@ config DEVFREQ_GOV_PASSIVE
>  	  through sysfs entries. The passive governor recommends that
>  	  devfreq device uses the OPP table to get the frequency/voltage.
>  
> +comment "DEVFREQ Options"
> +
> +config DEVFREQ_DELAYED_TIMER
> +	bool "Use delayed timer in Simple Ondemand Governor"
> +	default false
> +	help
> +	  Simple Ondemand Governor uses polling for reading buses counters.
> +	  A default timer used is deferred, which saves power, but can
> +	  miss increased demand for higher bus frequency if timer was
> +	  assigned to idle cpu. If you want to change this to delayed
> +	  timer at the cost of more power used, say Yes here.
> +
>  comment "DEVFREQ Drivers"

I don't think that we cannot choice the all options in Kconfig
at the build time. If we add something like this patch,

we can choice the any options in Kconfig as following:
- polling time (millisecond)
- up threshold
- down threshold
- type of workqueue
- etc ...

Also, there are too much optional value and selectable value 
in the linux kernel. 

As I said, If you suggest the reasonable data with test result,
I will add the new flag to 'struct devfreq_dev_profile'.

>  
>  config ARM_EXYNOS_BUS_DEVFREQ
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

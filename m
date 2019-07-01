Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A45B2CC
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 03:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGABq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 21:46:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16431 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfGABq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 21:46:56 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190701014653epoutp019b9a36263dc6e1d6836aa97b7de331e1~tJUKLLRw52864028640epoutp01F
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 01:46:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190701014653epoutp019b9a36263dc6e1d6836aa97b7de331e1~tJUKLLRw52864028640epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561945613;
        bh=m+eqQbrZSo3RuVkRuZSW5PciV5T0jFZBN5eKTO8g78w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uY0r6/jeUFZ8oyxuOV5MWGuGpiIaCyJ/CPDZOPjUyAuFD4GQpt6axfxq/i/F9uInF
         YNmC1qplxMVs5ERB7BDWnGLLW+EdpsZUF5KDR5X8y+Xtmj0UxHhToSsAdHFZFCgGi2
         ukMRNT2AjE5P9EhxZZP1UPV4HqPQZ12d08sV1xn0=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701014650epcas1p205b2e10822aa586ed41da46e00186d32~tJUH0gaa10786807868epcas1p2z;
        Mon,  1 Jul 2019 01:46:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.EE.04142.406691D5; Mon,  1 Jul 2019 10:46:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190701014643epcas1p35762284cf05bfb0796cddf271faf1e00~tJUBPV5-Q1319013190epcas1p39;
        Mon,  1 Jul 2019 01:46:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701014643epsmtrp22add956dc07b0f6e466080cbd030acc2~tJUBOe7iJ1483114831epsmtrp2L;
        Mon,  1 Jul 2019 01:46:43 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-5a-5d196604b896
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.E8.03662.306691D5; Mon,  1 Jul 2019 10:46:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190701014643epsmtip2d6ab49c6c09dd3c6c55c15c7bb9c9b23~tJUBF2iuE3067230672epsmtip2W;
        Mon,  1 Jul 2019 01:46:43 +0000 (GMT)
Subject: Re: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <87564032-015a-323f-6d15-0abc67f6cc60@samsung.com>
Date:   Mon, 1 Jul 2019 10:49:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628103232.2467959-1-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmgS5LmmSsQedvIYu/k46xW6z++JjR
        4mzTG3aLy7vmsFl87j3CaHG7cQWbA5vH71+TGD12zrrL7tG3ZRWjx+dNcgEsUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGY37ZjMVzOKu
        eLPxD2MD42rOLkZODgkBE4m3Vy4zdzFycQgJ7GCU6H/VwAbhfGKUOHVkIZTzjVGi5cpdRriW
        LxvZIRJ7GSVO/77AAuG8Z5SY2vAbKMPBISzgIHHonDJIg4hAucTH32tZQcLMAgkS65rCQMJs
        AloS+1/cYAOx+QUUJa7+eAw2n1fATmLZnyawOIuAisTRh5/AbFGBCInLW3ZB1QhKnJz5hAVk
        JKeAqcTMOakgYWYBcYlbT+YzQdjyEs1bZzNDnPyYTeLtvUoI20Xi9v+DTBC2sMSr41vYIWwp
        ic/v9rJB2NUSK08eAftdQqCDUWLL/gusEAljif1LJzNBvKIpsX6XPkRYUWLn77mMEHv5JN59
        7QH7VkKAV6KjTQiiRFni8oO7UGslJRa3d7JNYFSaheSZWUg+mIXkg1kIyxYwsqxiFEstKM5N
        Ty02LDBCjupNjOBUqWW2g3HROZ9DjAIcjEo8vA13JGKFWBPLiitzDzFKcDArifDOPQwU4k1J
        rKxKLcqPLyrNSS0+xGgKDOuJzFKiyfnANJ5XEm9oamRsbGxhYmhmamioJM4bz30zRkggPbEk
        NTs1tSC1CKaPiYNTqoHRSYZnofjcDh9ljk2LNG5cV3v0J7z+1b+bD6SOTmHcp/e8KeZnUN2C
        TaUyrqv4Wt72NW462P67dOvZA8xRK1TenHVfuy+0Yo5o1IzIkz8/3VDKytj3cLp2kLn4Jf77
        fdVKrPNUvn8uzPRa8KDKhsvD4cIO5bLJD1SLV/Nsd4u88KqkuaDuzXFTJZbijERDLeai4kQA
        jYuA0KsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXpc5TTLWYOV2Y4u/k46xW6z++JjR
        4mzTG3aLy7vmsFl87j3CaHG7cQWbA5vH71+TGD12zrrL7tG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZjftmMxXM4q54s/EPYwPjas4uRk4OCQETibdfNrJ3MXJxCAnsZpR4MnMuM0RCUmLa
        xaNANgeQLSxx+HAxRM1bRonJa+ezgcSFBRwkDp1TBikXESiXmHa1kQkkzCyQIPHyWxVEeQej
        xPZ3LawgNWwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSSz70wQWZxFQkTj68BOYLSoQIdHXNpsN
        okZQ4uTMJywg8zkFTCVmzkkFCTMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERuFZSLpnIWmZ
        haRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNGS2sH44kT8YcYBTgY
        lXh4NW5JxAqxJpYVV+YeYpTgYFYS4Z17GCjEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQ
        QHpiSWp2ampBahFMlomDU6qB0cOj82jdrGtCyz+/WcPSrGxzV3d1XMn7kKD0HTZby+beuJa3
        Yupfhxn6uU5zje6wdAuoXZzwaLVRtdaFreXdv2cGH9j1bcvlBwf9H0z4sGz7yjX/P+jsrK6e
        W14v0DPl9sldTU4W2de3KHmUFTioHqzsEru6fFGE4Jkkdumnn/ZdfuOQpWVTPl2JpTgj0VCL
        uag4EQBsZt+ElgIAAA==
X-CMS-MailID: 20190701014643epcas1p35762284cf05bfb0796cddf271faf1e00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190628103243epcas4p133102dfa6709970b1dd49296f82425b2
References: <CGME20190628103243epcas4p133102dfa6709970b1dd49296f82425b2@epcas4p1.samsung.com>
        <20190628103232.2467959-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Arnd,

Thanks for fixup.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>



Hi Myungjoo,
This patch have to be merged for linux 5.3 before sending pull-request
because it fixed the build error of merged patch[1] on devfreq.git.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=028b3793284fa1bb4db73a90608d7cb24664480c

Best Regards,
Chanwoo Choi

On 19. 6. 28. 오후 7:32, Arnd Bergmann wrote:
> Compile-testing the new driver on platforms without CONFIG_COMMON_CLK
> leads to a link error:
> 
> drivers/devfreq/tegra20-devfreq.o: In function `tegra_devfreq_target':
> tegra20-devfreq.c:(.text+0x288): undefined reference to `clk_set_min_rate'
> 
> Add a dependency on COMMON_CLK to avoid this.
> 
> Fixes: 1d39ee8dad6d ("PM / devfreq: Introduce driver for NVIDIA Tegra20")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index f3b242987fd9..defe1d438710 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -107,6 +107,7 @@ config ARM_TEGRA_DEVFREQ
>  config ARM_TEGRA20_DEVFREQ
>  	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>  	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
> +	depends on COMMON_CLK
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_OPP
>  	help
> 

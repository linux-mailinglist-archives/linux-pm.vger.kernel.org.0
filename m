Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825FC11DD3A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 05:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfLMEvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 23:51:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38934 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfLMEvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 23:51:21 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191213045118epoutp0142c9ada672ecb543126b56c7d05b77de~f1RRjTzlQ2162921629epoutp01b
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2019 04:51:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191213045118epoutp0142c9ada672ecb543126b56c7d05b77de~f1RRjTzlQ2162921629epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576212678;
        bh=LQ5rheMErs8NK9Zb2RpTk1lFF7A7uZ/nCuqgxAB4GRI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uhMfO5JwB900CBH3rNWmAVm69BG9WGl+LF4Rm89eFv66qafqBbzO9VYwP47IGPHwB
         z1HeuPM9AA21p4mhXmMcfvX2GF9dTUaIqY2v9lxNh8w1Gqz+MUatS52bh5p/iLarMD
         hSgFPqL5azWvJjSvWGDfZhDqltiQxMw7KfiYNHwY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191213045116epcas1p2ab649d49ab9c3934f48b38a0d180055a~f1RQexoKh1146311463epcas1p2A;
        Fri, 13 Dec 2019 04:51:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Yyt36rr1zMqYkr; Fri, 13 Dec
        2019 04:51:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.EF.52419.9B813FD5; Fri, 13 Dec 2019 13:51:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191213045104epcas1p33d2c46bd14645cdc107c4ce1ecc15777~f1RFSvMQG0447904479epcas1p3P;
        Fri, 13 Dec 2019 04:51:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213045104epsmtrp243be19234618ab2f0d01b65c5d4a6107~f1RFSCR7u0520905209epsmtrp27;
        Fri, 13 Dec 2019 04:51:04 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-8c-5df318b98702
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.4C.10238.8B813FD5; Fri, 13 Dec 2019 13:51:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191213045104epsmtip17d480287a2458abf19f466669a572fbb~f1RFBu3SB2382523825epsmtip19;
        Fri, 13 Dec 2019 04:51:04 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: add COMMON_CLK dependency
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <23cc9bbb-f6a4-fc1c-7678-79040d3a18aa@samsung.com>
Date:   Fri, 13 Dec 2019 13:57:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <87v9qk4yrk.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTWxTOpdOZoVgd63aE+KxjJIJBGWtx9Fl9idu4JSTGJRqCEzppkW7O
        tEblRZG4IOl7UYuJNCpGooGKG1SkGiAWokIURdQYQeOCS4igWEEiecSWqXn8+875vnO/c869
        l1RoGvF4MtvmFEQbb6FxFVbdkJSSEoBQRmrvyUT2v+N3CPZi7zvEdjXcROyD/M8E2+t+pWRD
        /zQitrb0BsG2Ni9n2/eX4ezQs2vYXypu8OdxxH15fpDgAt6XBFfpO4JzR79241z//WMY96/f
        h7hQ5R/p5JacRWaBNwqiVrBl2Y3ZNpOBXrM+c2mmPi2VSWEWsPNprY23CgZ62dr0lBXZlnCP
        tHYnb3GFU+m8JNFzFi8S7S6noDXbJaeBFhxGi2OBY7bEWyWXzTQ7y25dyKSmztWHhdtyzD5/
        j8JxMG5XqOY2lofOxBaiWBKoedB1wqMsRCpSQ9UgCPQ1EnLwDUFD4cMo048gv6475ndJ52s/
        JhO1CIraapAcfEFwz31dGVGNo5aD+0f/MDGeakNQ1ddCRAgFVYeg2OeKYJxKhvpPz/EIHkNN
        g6cD71AEq6nF0NpaMKzHqBnwNNA8bD2B2ghN1QeimrHQVNyJRXAsZYCOymZMPn8SvOgsiZHx
        VLjRfUoRaQKocwS0e1/g8gzL4GJxHiHjcdB11x/F8RDqqY1qcqG8qRGXiwsQ+OsfKWVCB/Xn
        PWEHMuyQBFduzpHT0yAweBrJxqOhp8+tjEiAUkPBIY0smQ5tr19G1zgZSg8fwY8i2jtiHO+I
        EbwjRvD+b3YWYT40UXBIVpMgMQ7dyPuuRMMvOHl+DbrasjaIKBLRo9Rl/LcMjZLfKe22BhGQ
        Cnq8esnf4ZTayO/eI4j2TNFlEaQg0oe3fUwRPyHLHv4PNmcmo5+r0+nYeUyanmHoSWpyoDVD
        Q5l4p5AjCA5B/F0XQ8bG56EpH3Y0eWymqnND++zu4MqtptWlWR8Hg7dULXV7VaMTS9oGbx26
        1uHddHlswquEvQNFFW/UszZ39Hx/wnseV7/NVdyd+bFEyF3nZu6Jie0XtOzX9HKPlvOueIvi
        Hm/TxG2pXV9VNJSflmS+VHc7YdWTP415P90VM/XvDRsqtqeJuUtpTDLzTLJClPhfydf9ydcD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSnO4Oic+xBu9um1r8nXSM3WL1x8eM
        Fq8O72K0ONv0ht3iY889VovPvUcYLfYu3s5ucfGUq8XtxhVsFv+ubWRx4PL4/WsSo8f7G63s
        Hjtn3WX32LSqk81jwoe3bB7fzkxk8ejbsorR4/MmuQCOKC6blNSczLLUIn27BK6MVVveMRe0
        cld83nGQpYFxHmcXIyeHhICJxJMHW1i6GLk4hAR2M0qcONbFDJGQlJh28SiQzQFkC0scPlwM
        UfOWUaKjdwM7SI2wgKtEz/dvjCAJEYHLjBLdUx6wgjjMAgcYJf78XcsI0TKBUaJlwUtGkBY2
        AS2J/S9usIHY/AKKEld/PAaL8wrYSVy82AE2lkVAVeLqzlNMILaoQJjEziWPmSBqBCVOznzC
        AmJzCthK3Nl0CsxmFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYw
        sqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiORi3NHYyXl8QfYhTgYFTi4WVI+RQr
        xJpYVlyZe4hRgoNZSYTXvgYoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTU
        gtQimCwTB6dUA6Pfpuq107jcWHkr9rSnrPDqunHJeotxzpKmkwYnwkweOa7+sux22NZ7+xcJ
        TZnEzmu6NcSUN0DyvP+LtpySKbzms1knTZmwWVjSwi/po4TXzJlvrx/TS8xt9k77qv2Mmze3
        W/3khax//qt8g5OPlb1z3hYi9Ul6Gb/omjLB3uYHq5NnzZi9y1OJpTgj0VCLuag4EQDtRG2U
        wgIAAA==
X-CMS-MailID: 20191213045104epcas1p33d2c46bd14645cdc107c4ce1ecc15777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213044804epcas1p34eaf8872b5688c01255931c79bfd0ef0
References: <CGME20191213044804epcas1p34eaf8872b5688c01255931c79bfd0ef0@epcas1p3.samsung.com>
        <87v9qk4yrk.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/13/19 1:47 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Compile-testing the new driver on platforms without CONFIG_COMMON_CLK
> leads to a link error:
> 
> 	drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_target':
> 	tegra30-devfreq.c:(.text+0x288): undefined reference to `clk_set_min_rate'
> 
> Add a dependency on COMMON_CLK to avoid this.
> 
> Fixes: 35f8dbc727212 ("PM / devfreq: tegra: Enable COMPILE_TEST for the driver")
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index defe1d4..a78191c 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -94,6 +94,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> +	depends on COMMON_CLK
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
> 

Thanks for the fixup.

But, it was merged as following:
- https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=252ef98ed524612667e2e2a0ce065fe21e80ec93

Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

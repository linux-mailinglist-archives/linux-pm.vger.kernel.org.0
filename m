Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD352F8560
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKLAeg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 19:34:36 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:34642 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKLAeg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 19:34:36 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191112003433epoutp02bdda6798d3e97623f11a395df65067ae~WQxQx8QXM1582015820epoutp02w
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 00:34:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191112003433epoutp02bdda6798d3e97623f11a395df65067ae~WQxQx8QXM1582015820epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573518873;
        bh=5cKRmFEdtZROg/bAbyJ5brs/BCNo1lNRVNXelraoK/o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O+OtZkp/GmTgyFwbS4eqcv6JhS1iAXYTAwM/sBTrrrS5/tIHJ0QvQzCZZQJqcDzpY
         jEtDSqBUCi0ib8Qn3nfEjf73oQ04Z7R+1dVLMRU435YdyLF0gXUPSJE5gCGaVv4S44
         /E8VEP8PlYT/nWCBFd3Iuy2zs3ZfzgFPi+/Nj9+E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191112003432epcas1p37c6f3709f0e1157461585819aa9781f8~WQxP9sYbC2127421274epcas1p3w;
        Tue, 12 Nov 2019 00:34:32 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47BpfG5NJ6zMqYkd; Tue, 12 Nov
        2019 00:34:30 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.89.04135.61EF9CD5; Tue, 12 Nov 2019 09:34:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191112003429epcas1p11e6bc210c5fcdbd5d5990cd1f63fdefe~WQxMz12Vf2100921009epcas1p1v;
        Tue, 12 Nov 2019 00:34:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191112003429epsmtrp20fb8621b6b917056f41cb6ac5e0a69e5~WQxMy7Wq91043010430epsmtrp2N;
        Tue, 12 Nov 2019 00:34:29 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-28-5dc9fe1610da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.11.25663.51EF9CD5; Tue, 12 Nov 2019 09:34:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191112003429epsmtip184536794c4b9f97c1900235dfa464c83~WQxMnenVz2348323483epsmtip1N;
        Tue, 12 Nov 2019 00:34:29 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Kconfig: Drop explicit selection of
 PM_OPP
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2955f629-ffa2-fa5e-6734-a400428a2821@samsung.com>
Date:   Tue, 12 Nov 2019 09:40:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1fb316f5b2c4d36437a536cef46ce8e4567dee15.1573495711.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWUwTURTldZkOxOpQBK+4lXGLJCxDKQ5GcCNmDCSi+GE0CJN2LEu3dAqK
        JsZ9QUWNRqGRCAKRLVGxSjUSSG0URJZocMMqRhPUKAYr4q5tByN/5953zjv3vAUXK1qwcDzX
        aOUsRlZPYkGSa7cWxESF/e7IjH00KKMbhl8hurHfieienksyumv3exld6x6W0p6jLkT376rF
        6Hud96X05RFmaSDjcFcj5rrNLWOa6g9hzLOHNzHm8pBDxNj7DkiYEns9YjxNM9PxDfmLczhW
        y1mUnFFj0uYadUlkakbWiix1QiwVRSXSC0mlkTVwSWRKWnrUyly9dzxSWcjqC7ytdJbnyZjk
        xRZTgZVT5ph4axLJmbV6c6I5mmcNfIFRF60xGRZRsbFxai8xOz+nvXuC+WXo1obiGmwnOhFc
        jAJxIOLh24BHUoyCcAXhQPCzrkEkFJ8Q3L/7EQnFFwTNF3ahf5KuPyVjrBYEe2sqZULxEUFd
        yW6RjxVCrIbRzy1i38JkYg+Cq+0f/AtiYgTBg+YgH8aISGh98xjz4UlEBPR9feW3kBPJ8Pb0
        KX9fQsyFL217vVocDyXWQ+cIK1CCoaPstcSHA4lN0PCiWyJsPwWevj43ZjULmj+c9c8AxEkZ
        uF1HpEKEFGjqqxiLEwLv7thlAg4Hz1ALJuDtUNfhwgTxQQT21t4xsQpaa076BxITC+DijRih
        HQHXf5QjwXgiDI34vHBvXw4H9ysEymx4MOAWCXgqVB04hB1HpG1cHNu4CLZxEWz/zSqQpB6F
        cWbeoON4yhw3/rabkP/pRiY40PnuNCcicEROkAdkd2QqpGwhX2RwIsDF5GS5Y2t7pkKuZYu2
        cRZTlqVAz/FOpPYe9glxeKjG5P0IRmsWpY5TqVR0PJWgpihyinzZhZpMBaFjrVw+x5k5yz+d
        CA8M34k2Kns3/Tryp3LtqnLHaGnuE/moekbtlfeew6K4mM39tXNOa3/NGwjoPJb3fINqVpk5
        qLnVNTST0iyfnrGjKuyYK/7297kp54vX3DiT13Y3LTgvOyzgSXKIfcnU0p4dbetmSxunbVmT
        Ub1vviZ1ya3qqsHUysS1XZ91RYUV7b+d637OPzNISvgclooUW3j2LwCx27DQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnK7ov5OxBld+y1qs/viY0WLN7UOM
        FufPb2C3ONv0ht1ixd2PrBafe48wWtxuXMFmceb0JVaLjV89HDg9dtxdwuixc9Zddo9NqzrZ
        PO5c28PmsfHdDiaPLVfbWTz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr48Q5noKHohWru5ay
        NTBOFOxi5OSQEDCROPu/j6mLkYtDSGA3o8SytvWsEAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZRo
        bN/MCFIjLOAr8b3lJDtIQkSglVHizukfbCAOs8B3Ronzh5dCjd3IKDH7cis7SAubgJbE/hc3
        2EBsfgFFias/HoON4hWwk3g5bQpYnEVAVeLbgRYmEFtUIELi+fYbUDWCEidnPmEBsTkF4iRW
        3z8HZjMLqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU
        56bnFhsWGOWllusVJ+YWl+al6yXn525iBEegltYOxhMn4g8xCnAwKvHwMiScjBViTSwrrsw9
        xCjBwawkwruj4kSsEG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkm
        Dk6pBkYtz5Q3LW9d9s8NqF81I6hVOe2rzG0mBpvPCkeuiOmvTDeN07ybyqZhGdixeOKUb0t8
        ml1ywubGhdznXiBYkf6Pa1/i2SS31sfTbooeSojLEt12/2LmobayYDezpGkyf79VvrhhJvZP
        2PDkw6qlabethG15F+lvdZUPqr6i4/LLhPt2XMcpXyWW4oxEQy3mouJEAEiMDEO8AgAA
X-CMS-MailID: 20191112003429epcas1p11e6bc210c5fcdbd5d5990cd1f63fdefe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191111181617epcas4p37a34e64e080e11e7f14754dd8dce7d27
References: <CGME20191111181617epcas4p37a34e64e080e11e7f14754dd8dce7d27@epcas4p3.samsung.com>
        <1fb316f5b2c4d36437a536cef46ce8e4567dee15.1573495711.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/12/19 3:16 AM, Leonard Crestez wrote:
> CONFIG_PM_OPP is already selected by CONFIG_PM_DEVFREQ since
> commit b9c69e043266 ("PM / devfreq: Add dependency on PM_OPP")
> This means that individual drivers shouldn't "select PM_OPP" explicitly.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> Spawned by review comments on a new driver:
> https://patchwork.kernel.org/patch/11235695/#22992159
> 
> This patch shouldn't have any dependencies.
> 
>  drivers/devfreq/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index defe1d438710..066e6c4efaa2 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -81,11 +81,10 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select DEVFREQ_GOV_PASSIVE
>  	select DEVFREQ_EVENT_EXYNOS_PPMU
>  	select PM_DEVFREQ_EVENT
> -	select PM_OPP
>  	help
>  	  This adds the common DEVFREQ driver for Exynos Memory bus. Exynos
>  	  Memory bus has one more group of memory bus (e.g, MIF and INT block).
>  	  Each memory bus group could contain many memoby bus block. It reads
>  	  PPMU counters of memory controllers by using DEVFREQ-event device
> @@ -96,22 +95,20 @@ config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
>  		COMPILE_TEST
> -	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
>  
>  config ARM_TEGRA20_DEVFREQ
>  	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>  	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
>  	depends on COMMON_CLK
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> -	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
>  	  It reads Memory Controller counters and adjusts the operating
>  	  frequencies and voltages with OPP support.
>  
> @@ -119,11 +116,10 @@ config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on ARCH_ROCKCHIP
>  	select DEVFREQ_EVENT_ROCKCHIP_DFI
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_DEVFREQ_EVENT
> -	select PM_OPP
>  	help
>            This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

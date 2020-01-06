Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7682D130BDB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 02:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAFBny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 20:43:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10981 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgAFBny (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 20:43:54 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200106014349epoutp020d7e467f393ac80f97bbf21ea2fa1f2f~nKMcD1Ekv1063010630epoutp021
        for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2020 01:43:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200106014349epoutp020d7e467f393ac80f97bbf21ea2fa1f2f~nKMcD1Ekv1063010630epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578275029;
        bh=0KV/81+8NYUZoOd09j3uz5rKNhVd4P0bKNs9BXXZU2I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=n0VtdPXMRxGvT7wxI2H+AxNGxqpjRlbuxU8SnJiSdoU2gFXoKGPMRZJi3PAjLPpXZ
         0QH9O7yiqz7xKAEmsxrsOAQg8jTAYAzcQSZXHTDN+Enp+5d8ueDyhoVbQZ7lKmysHS
         AF5IWftjTgA7FXFiTdTjiMPTScp/y/+31/rOZ7Dc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200106014349epcas1p3a9be5b37643dbb8d9972653f191c6625~nKMbpE_tg2455124551epcas1p3R;
        Mon,  6 Jan 2020 01:43:49 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47rdZp0WjzzMqYl2; Mon,  6 Jan
        2020 01:43:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.F5.48019.1D0921E5; Mon,  6 Jan 2020 10:43:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200106014345epcas1p220efaa80993b31c09359f5dee6931ca7~nKMYQqFAN1612316123epcas1p2C;
        Mon,  6 Jan 2020 01:43:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200106014345epsmtrp1183fb04c0de0a96ce0f254aaa9992ea1~nKMYP7ENE3013530135epsmtrp1v;
        Mon,  6 Jan 2020 01:43:45 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-dc-5e1290d1a74d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.F8.10238.1D0921E5; Mon,  6 Jan 2020 10:43:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200106014345epsmtip2a827f50c8e9b1af55046c58e7ab473be~nKMYApXxr0734807348epsmtip2O;
        Mon,  6 Jan 2020 01:43:45 +0000 (GMT)
Subject: Re: [PATCH v2 13/20] devfreq: exynos: Rename Exynos to lowercase
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c3c083b4-a7f4-946b-aea0-d91940e5ba56@samsung.com>
Date:   Mon, 6 Jan 2020 10:50:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200104152107.11407-14-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmru7FCUJxBkvXWlv0P37NbHH+/AZ2
        i7NNb9gtNj2+xmpxedccNovPvUcYLWac38dkcbtxBZsDh8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        S1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE
        7Izf/d0sBX+UK3bMzGtgfCzbxcjJISFgIvGoZzNzFyMXh5DADkaJbduOs4IkhAQ+MUo0XtKA
        sL8xSuw5Fg/TMOvCOSaIhr2MErtewDjvGSUefPzLDlIlLOApsXXWYzBbRMBdYsH/NWwgRcwC
        9xgleuYtYAZJsAloSex/cYMNxOYXUJS4+uMxI4jNK2An8fzme7BmFgEViaPt08DqRQXCJE5u
        a4GqEZQ4OfMJC4jNKWAm0f3wBdgcZgFxiVtP5jNB2PIS29/OAftNQuAzm8TiPZdYIX5wkdi4
        diMbhC0s8er4FnYIW0riZX8blF0tsfLkETaI5g5GiS37L0A1G0vsXzoZaAMH0AZNifW79CHC
        ihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImyxOUHd5kgbEmJxe2dbBMYlWYheWcWkhdmIXlh
        FsKyBYwsqxjFUguKc9NTiw0LTJAjexMjOIFqWexg3HPO5xCjAAejEg8vQ7BQnBBrYllxZe4h
        RgkOZiUR3kY3wTgh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA9M7nkl8YamRsbGxhYmhmam
        hoZK4rwcPy7GCgmkJ5akZqemFqQWwfQxcXBKNTBKymrlTpjo0b4iJlb0379HzO3Mu7b2bnsv
        IDO9rmjilTL973v3n9RZ09bJLbXir0jxszXb7RU8Hk6W/rrv+8krF/ZMWevv7SJ5pSQxcsUG
        U/P7a/gkxf2kP0gtNvgyf1FV396IlZMK5/q5LNFmCNJpWPTpbeSF1Tv5KkRzNs+8pcbGdopP
        JPWUEktxRqKhFnNRcSIAui4TpLYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvfiBKE4g9ZfMhb9j18zW5w/v4Hd
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ3G5cwebA4bFpVSebx+Yl9R59W1YxenzeJBfA
        EsVlk5Kak1mWWqRvl8CV8bu/m6Xgj3LFjpl5DYyPZbsYOTkkBEwkZl04x9TFyMUhJLCbUWJj
        90xGiISkxLSLR5m7GDmAbGGJw4eLIWreMkpMfPiPDaRGWMBTYuusx+wgtoiAu8SC/2vYQIqY
        Be4xSjT/WAQ1dQujRP/B/0wgVWwCWhL7X9wA6+YXUJS4+uMx2DZeATuJ5zffg01iEVCRONo+
        jRnEFhUIk9i55DETRI2gxMmZT1hAbE4BM4nuhy/A5jALqEv8mXeJGcIWl7j1ZD4ThC0vsf3t
        HOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeT
        luYOxstL4g8xCnAwKvHwrggQihNiTSwrrsw9xCjBwawkwtvoJhgnxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA6Omnt5Kww2Zp49W7nr2d1HptfUaXEmv
        LlrVTt2xat3+pu2/pyz5MWGOyj0/bnX1dx4SYXzpllZpc4+naYZL37bZdIJP4jIHRwSLdM+N
        mwytDZf+xqosXuaxXIupOHxlzOFLOjZxU3gcJ14XEJ4XPIPJWM5vwUrnuqkHeQ/PmF0THtG7
        +YaAx2clluKMREMt5qLiRAAyrMe9ogIAAA==
X-CMS-MailID: 20200106014345epcas1p220efaa80993b31c09359f5dee6931ca7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200104152251epcas4p2904c6be67570b1c0fd1cc43711f24b42
References: <20200104152107.11407-1-krzk@kernel.org>
        <CGME20200104152251epcas4p2904c6be67570b1c0fd1cc43711f24b42@epcas4p2.samsung.com>
        <20200104152107.11407-14-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/5/20 12:21 AM, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> name.
> 
> "EXYNOS" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/Kconfig             | 2 +-
>  drivers/devfreq/event/Kconfig       | 4 ++--
>  drivers/devfreq/event/exynos-nocp.c | 2 +-
>  drivers/devfreq/event/exynos-nocp.h | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  drivers/devfreq/event/exynos-ppmu.h | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 1526f758daeb..0b1df12e0f21 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -77,7 +77,7 @@ config DEVFREQ_GOV_PASSIVE
>  comment "DEVFREQ Drivers"
>  
>  config ARM_EXYNOS_BUS_DEVFREQ
> -	tristate "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
> +	tristate "ARM Exynos Generic Memory Bus DEVFREQ Driver"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select DEVFREQ_GOV_PASSIVE
> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
> index a53e0a6ffdfe..878825372f6f 100644
> --- a/drivers/devfreq/event/Kconfig
> +++ b/drivers/devfreq/event/Kconfig
> @@ -15,7 +15,7 @@ menuconfig PM_DEVFREQ_EVENT
>  if PM_DEVFREQ_EVENT
>  
>  config DEVFREQ_EVENT_EXYNOS_NOCP
> -	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
> +	tristate "Exynos NoC (Network On Chip) Probe DEVFREQ event Driver"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select PM_OPP
>  	select REGMAP_MMIO
> @@ -24,7 +24,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
>  	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
>  
>  config DEVFREQ_EVENT_EXYNOS_PPMU
> -	tristate "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
> +	tristate "Exynos PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select PM_OPP
>  	help
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> index 1c565926db9f..ccc531ee6938 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * exynos-nocp.c - EXYNOS NoC (Network On Chip) Probe support
> + * exynos-nocp.c - Exynos NoC (Network On Chip) Probe support
>   *
>   * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>   * Author : Chanwoo Choi <cw00.choi@samsung.com>
> diff --git a/drivers/devfreq/event/exynos-nocp.h b/drivers/devfreq/event/exynos-nocp.h
> index 55cc96284a36..2d6f08cfd0c5 100644
> --- a/drivers/devfreq/event/exynos-nocp.h
> +++ b/drivers/devfreq/event/exynos-nocp.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * exynos-nocp.h - EXYNOS NoC (Network on Chip) Probe header file
> + * exynos-nocp.h - Exynos NoC (Network on Chip) Probe header file
>   *
>   * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>   * Author : Chanwoo Choi <cw00.choi@samsung.com>
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 055deea42c37..17ed980d9099 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * exynos_ppmu.c - EXYNOS PPMU (Platform Performance Monitoring Unit) support
> + * exynos_ppmu.c - Exynos PPMU (Platform Performance Monitoring Unit) support
>   *
>   * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
>   * Author : Chanwoo Choi <cw00.choi@samsung.com>
> diff --git a/drivers/devfreq/event/exynos-ppmu.h b/drivers/devfreq/event/exynos-ppmu.h
> index 284420047455..97f667d0cbdd 100644
> --- a/drivers/devfreq/event/exynos-ppmu.h
> +++ b/drivers/devfreq/event/exynos-ppmu.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * exynos_ppmu.h - EXYNOS PPMU header file
> + * exynos_ppmu.h - Exynos PPMU header file
>   *
>   * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>   * Author : Chanwoo Choi <cw00.choi@samsung.com>
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

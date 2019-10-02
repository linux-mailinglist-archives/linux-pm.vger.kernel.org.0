Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200B2C44B2
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfJAX76 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 19:59:58 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21997 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbfJAX76 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 19:59:58 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191001235955epoutp04e5c86eeda657d0dc5fcec380ee168f0a~Jq2UEj4sO2057720577epoutp04G
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 23:59:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191001235955epoutp04e5c86eeda657d0dc5fcec380ee168f0a~Jq2UEj4sO2057720577epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569974395;
        bh=7kuZOVvWcYXGmzbacAgCmUZfneqt43LCxLf4Sol6GY4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fBDhLOXHJzHW0qbtBvIhkOvPoKR20Mo4mFpuSeLhdLJlTyRBgbNLkAyrYH/sfD8Bs
         Zk829oyKbR4i1O6NSY2iuBpm6e1/xosUFphE43gKw5yBUAdiyTT/6TBtZy93UUCnTE
         o5bxx493uOGtwcmQOVlrkzpM0NK5zmuH307qXVwE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191001235954epcas1p25216adeb4d1c9b096008db7119f0ea24~Jq2Tj3C4g1606516065epcas1p2M;
        Tue,  1 Oct 2019 23:59:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46jbqD3StFzMqYkr; Tue,  1 Oct
        2019 23:59:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.92.04068.878E39D5; Wed,  2 Oct 2019 08:59:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191001235951epcas1p19e14f078b63c1540c3c8b0620d47d398~Jq2QjaseK2593125931epcas1p1v;
        Tue,  1 Oct 2019 23:59:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001235951epsmtrp163e1d51610d11f54024e338f59f35d3b~Jq2Qip-XP1908219082epsmtrp1w;
        Tue,  1 Oct 2019 23:59:51 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-eb-5d93e878e54d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.84.03889.778E39D5; Wed,  2 Oct 2019 08:59:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191001235951epsmtip287bcaac784ad180f54b99e7345a119d8~Jq2QVU_RS0854708547epsmtip2j;
        Tue,  1 Oct 2019 23:59:51 +0000 (GMT)
Subject: Re: [PATCH v6 14/19] PM / devfreq: tegra30: Don't enable
 consecutive-down interrupt on startup
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
Message-ID: <ebde3133-d2dd-6c3c-c898-9afb7eab5a6c@samsung.com>
Date:   Wed, 2 Oct 2019 09:04:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-15-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt93dbeHytjJPE0xvESRpu87ZNVR6EZfqD6HoYYjd3GUz92p3
        k7SCpWFqpZVQOntIKaQSpaxQQywVH4QRRQ8STVToqZZT097b7iT/+875fd855zu/IxMr7+Eq
        WabZztnMrJHEF2EPOtaqo499KEtTF3rC6PpvI4g+7bqJ0X15X6T0i5arOO0534nooikXTvef
        uo3Tcy3XMbrkznN8k5xpGqhGTLNrQMqczx/HmRJ3HWI8jeEpktSsRAPH6jhbBGfOsOgyzfok
        cufu9K3p2ng1FU0l0BvICDNr4pLIbbtSordnGr0DkRHZrNHhTaWwPE+uT060WRx2LsJg4e1J
        JGfVGa0J1hieNfEOsz4mw2LaSKnVsVov8VCWoWd8BrMWyI89H3uCnKhPWozkMiDiYKy8CCtG
        i2RKognBZU8ZLgSTCD51eaRCMINg7HWtZF7yftIZYLUiKKl0BvQTCCbqzop9rKVEJpR/f+WX
        LyP+ICiay8d9D2LiAHQ014t8GCeioO3DG38+mIiEl7MjyIcVRDI8+j3txxixGmbv3fXzQ4j9
        MDnUIRE4S6C3YhTzYTmxASqaqzChfii8Hb0hEvBKyL9fKfYNAcRfHJ6davCSZN5gGzwZihTs
        LIVP3e7ANlTwsbQggI9DbW8nLmgLEbjbngX8a6CtpkzkqyMm1sLdlvVCOhKaf15DQt/FMD59
        TiK0UkBhgVKgrIIXQwMiAa+AW2eK8AuIdC1w41rgwLXAget/syqE1aHlnJU36TmesmoXfncj
        8l9rVEIT6nq6qx0RMkQGKd7sKUtTSthsPsfUjkAmJpcpEn9dSlMqdGxOLmezpNscRo5vR1rv
        si+KVSEZFu/tm+3plDZWo9HQcVS8lqLIUAWjd6YpCT1r57I4zsrZ5nUimVzlRMn7mI3Bm6S1
        WypDD8Uoif7Sh92Gzedqma8H5w7/8VQH7Q7pPZmzLjk1ISd2OlJ+fLuuc01HKxuubtjh/vGr
        xjO8PPhE0pXPiXlT5J2wx4OD73riVcYjJ8b7LK1Pj8y5Gib2uhmKPKgO6nEcXTyM52ZYG6e6
        UWlfUHe2Jiy1JbiUxHgDS0WJbTz7D4X3+A7DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvG75i8mxBv9mqFis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlnHj3jaWgjbPi0tvTjA2MZ9m7GDk5JARMJJ5/
        amADsYUEdjNKdDxXhYhLSky7eJS5i5EDyBaWOHy4uIuRC6jkLaPExk9TGUFqhAUyJWZ8v8YO
        khARaGKS2NR7AWwos0CkRM/cLVBDtzFKvH7sDGKzCWhJ7H9xAyzOL6AocfXHY7BBvAJ2Egf+
        fgWzWQRUJH5sWM8EYosKREgc3jELqkZQ4uTMJywgNqeAucTMnQtYIHapS/yZd4kZwhaXuPVk
        PhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1
        kvNzNzGCI0xLawfjiRPxhxgFOBiVeHhvhEyOFWJNLCuuzD3EKMHBrCTCa/NnUqwQb0piZVVq
        UX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGxiWTvx+0vi5jZCAze9Hn
        n1ZbL55d90RYT9TEe8226gflu7XOOR+8dsUs5zr/ytzjv/ieRt4RuJEQ88ibI/fJI6vfc89w
        t2oKFOwu+7a//67k0c+JAlKei2Id2brCkzSd/3dE8yRc21p8cCHvNeaFyvEHNM8qin7b9JGx
        9tPc2A87p9wS35Qapa3EUpyRaKjFXFScCABSNyqorAIAAA==
X-CMS-MailID: 20191001235951epcas1p19e14f078b63c1540c3c8b0620d47d398
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212521epcas5p3570e492f3984401f59f1f82a25ddcf7f
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212521epcas5p3570e492f3984401f59f1f82a25ddcf7f@epcas5p3.samsung.com>
        <20190811212315.12689-15-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
> The consecutive-down event tells that we should perform frequency
> de-boosting, but boosting is in a reset state on start and hence the
> event won't do anything useful for us and it will be just a dummy
> interrupt request.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 5002dca4c403..a0a1ac09a824 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -708,7 +708,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
>  	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
> -	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_ENB;
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B504A6CC45
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbfGRJsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:48:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50125 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRJsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:48:07 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190718094803epoutp03a2967736540c893436370219dd20df04~yd2IUWVbc1642516425epoutp03Q
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:48:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190718094803epoutp03a2967736540c893436370219dd20df04~yd2IUWVbc1642516425epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563443283;
        bh=EnL2xp05mWqLeGDMN6DJMsvJ0i6MvNbScjk8J1uUFsU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qEGeAxPX2yWSIHKi6M/thI+UNGe+hPvbo5zBgaqb8nSZaBV3l9un2Il3fPP2E5Z6d
         MQ76hz4w47VGTXAUQh31+9XNVbOi5k8HDctW1alrnDWodXEvqYxZ07qxVTJr9QufwP
         eRUVtXD2MMoWoRM5baOsi2AYCvgb1reOiTHth3bs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718094802epcas1p2d8bf23068535be8c33835f37139f2bd7~yd2HknHGw2089520895epcas1p2Z;
        Thu, 18 Jul 2019 09:48:02 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45q8Sw5q2rzMqYkZ; Thu, 18 Jul
        2019 09:48:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.76.04075.940403D5; Thu, 18 Jul 2019 18:47:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190718094752epcas1p4660cd9d3968a1755369c6ad049eedbb9~yd1_Jxqwa2804528045epcas1p4C;
        Thu, 18 Jul 2019 09:47:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718094752epsmtrp1e11ba8d2cd74d9bfb934003ed8662826~yd1_JADS81806718067epsmtrp1C;
        Thu, 18 Jul 2019 09:47:52 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-94-5d3040496893
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.4D.03706.840403D5; Thu, 18 Jul 2019 18:47:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718094752epsmtip1c604dc5d6ad1521a6a85093ce7212561~yd197g1V61985719857epsmtip1z;
        Thu, 18 Jul 2019 09:47:52 +0000 (GMT)
Subject: Re: [PATCH v4 19/24] PM / devfreq: tegra30: Optimize upper
 consecutive watermark selection
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
Message-ID: <17fabbaf-ceca-7551-0a58-9c8a0e7027ed@samsung.com>
Date:   Thu, 18 Jul 2019 18:51:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-20-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNo9PpEitDUbj2Q2GMJDQCHbB1MEIwoKnKBy4xLiE4oRNAuqVT
        iNsHWIIULUuIC6OgQYkK7hYDGEURY2qCCogiBDFqVEAximtAtO1g5O/ce8595573nlSkvIKr
        pDlmO2szM0YSl2PX70ZGRa1O0qRrqqckdOPn14gu4uswunPfBwnd03ocp8ddHYh2fuVxeqDw
        LE7/aq3F6LIL3XiSTN88eBrpW/hBid7lGMP1Ze4GpB+/Oj9NvDV3eTbLGFhbGGvOtBhyzFkJ
        5NoNGckZWp2GiqLi6aVkmJkxsQlkSmpa1Koco3chMiyfMeZ5W2kMx5Exicttljw7G5Zt4ewJ
        JGs1GK3x1miOMXF55qzoTItpGaXRxGq9wu252YdHXZj11qyd56sOiAuQU16KZFIglkChx4GV
        IrlUSTQjqOh+Ml18QVDk2Y+E4juCrt+3sX8jjja3WCBuIqh0vRMJxScEHw41BfhUwQQLQyPX
        JT5iDjGFwPnLgfsIEbEF7rY0+kU4oYa2933+fiARDr0/XyMfVhCJ8OLikB9jxCLoL5/y6+cS
        m+FBRy0maILAU/3Gj2WEDvhTjZhwfij0vzkRIOAF4Gg65t8OiD84FJa9ms6QAkf2eXABB8PI
        fbdEwCoYLi+exnvgnKcDF4ZLELjbHosFIg7a6qu8DlKvQyRcao0R2uHQMlGDBOPZMPbtoNgn
        AUIBJcVKQbIQel4OBgh4Hpza78QrEMnPiMPPiMDPiMD/NzuJsAYUwlo5UxbLUdbYme99Ffm/
        q1rXjOoeprYjQorIWYo+MiZdKWbyuV2mdgRSETlHMTDsbSkMzK7drM2SYcszslw70npvu1Kk
        mptp8X5+sz2D0sbGxcXRSyidlqLIUEXtZGS6kshi7Gwuy1pZ27+5AKlMVYDWP2Mkf8a+9nd/
        /LEsdhO/vqC6pb4hf+9JjexZxI0fBaOB6gkid42nY+VzdXpI8Pneus6INS7M2XD57YOFj75N
        1ZQEhZuureubcCdHr46v6NLJS39Xl68oM5Xb78REji6uGwgyr7t3ZqN8T/HTVkMaOS+BSQrZ
        0dOkqppsij+7bfIoiXHZDKUW2TjmL2hMIqPEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK6Hg0GswcypeharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ0173shTs46lYM7mbtYGxk6uLkZNDQsBEonn/
        FtYuRi4OIYHdjBKPDl1lgUhISky7eJS5i5EDyBaWOHy4GKLmLaPE3M4rrCA1wgKpEvdfbWMH
        SYgINDFJbOq9wA6SYBaIlOiZu4UNomMLo8SEt8uYQRJsAloS+1/cYAOx+QUUJa7+eMwIYvMK
        2EncW3cfzGYRUJW41f+PCcQWFYiQmHRtJwtEjaDEyZlPwGxOATOJWYtXs0AsU5f4M+8SM4Qt
        LnHryXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YW
        l+al6yXn525iBEeZluYOxstL4g8xCnAwKvHw3lDSjxViTSwrrsw9xCjBwawkwnv7JVCINyWx
        siq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRq5HVnNu2j+0zdTK
        8eLYc3d/zqwZxi8/u0TGWb06nmivOMtvU0XGZa3CWIMJx/Z9MXkwZ/tGTRvn925q9b9yVl13
        UOavCOaYIvbylFxDPPvR2JnXEs9sdlDVkinKUd272ybq076otvLZee9fXpj0OKs+ewvrjg8K
        P+ubZglcVcupPMV+IurYGSWW4oxEQy3mouJEAPqLqtauAgAA
X-CMS-MailID: 20190718094752epcas1p4660cd9d3968a1755369c6ad049eedbb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223622epcas4p48ec0d7e6fa26bc2397fa4351c0bd0c2d
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223622epcas4p48ec0d7e6fa26bc2397fa4351c0bd0c2d@epcas4p4.samsung.com>
        <20190707223303.6755-20-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> The memory activity counter may get a bit higher than a watermark which
> is selected based on OPP that corresponds to a highest EMC rate, in this
> case watermark is lower than the actual memory activity is and thus
> results in unwanted "upper" interrupts.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

It seems that you can combine patch19 with patch20.

> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 8d6bf6e9f1ae..c3cf87231d25 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -363,7 +363,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
>  
>  	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
> -	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
> +
> +	/*
> +	 * The memory events count could go a bit higher than the maximum
> +	 * defined by the OPPs, hence make the upper watermark infinitely
> +	 * high to avoid unnecessary upper interrupts in that case.
> +	 */
> +	if (freq == tegra->max_freq)
> +		upper = ULONG_MAX;
> +	else
> +		upper = lower + delta;
> +
> +	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
>  
>  	/*
>  	 * Meanwhile the lower mark is based on the average value
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

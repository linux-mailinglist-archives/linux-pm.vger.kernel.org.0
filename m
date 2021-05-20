Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAC389B6D
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 04:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhETCec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 22:34:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10384 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhETCe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 22:34:27 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210520023224epoutp031779958f5a8bfc052c5cd9595ac3de11~ApZmK_MS50646306463epoutp03H
        for <linux-pm@vger.kernel.org>; Thu, 20 May 2021 02:32:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210520023224epoutp031779958f5a8bfc052c5cd9595ac3de11~ApZmK_MS50646306463epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621477944;
        bh=mPrCx264EdPlM0pzGQBddDNCB0lIGqqu3VXdBgpl+8g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d5IgPioriMhgnV4l/m2rTMAF1YAimWHuUxpntVlJjyO2kYD3H/y2D8ehv1fceJPeH
         dUBBVosmkWOZsDbj3FTDDBHSn0s3cA/6Ufch5Q0KzIX0+AR1kZpso3+4W9IfYTQJ8A
         lU6XR4wQsz4Kh+4y0Wb9YrE2r5fAx4A4IQ1wu8ow=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210520023224epcas1p29a210571ca9a00e8e6d4ca9a2383bdbc~ApZlnoDtj2773027730epcas1p2T;
        Thu, 20 May 2021 02:32:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Flv0572LVz4x9Pw; Thu, 20 May
        2021 02:32:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.E4.09578.53AC5A06; Thu, 20 May 2021 11:32:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210520023221epcas1p4ef055525be61fa87393e57e9401dde82~ApZjJuAVC1198411984epcas1p4X;
        Thu, 20 May 2021 02:32:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210520023221epsmtrp238c983e09f259d0676d3b7e11dbdf160~ApZjI0E0h2076220762epsmtrp2a;
        Thu, 20 May 2021 02:32:21 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-77-60a5ca35e684
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.B3.08163.53AC5A06; Thu, 20 May 2021 11:32:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210520023221epsmtip2c6266ad5a98c5c7a5f22879675d94377~ApZi3Es_J2345823458epsmtip2Y;
        Thu, 20 May 2021 02:32:21 +0000 (GMT)
Subject: Re: [PATCH v1 1/7] PM / devfreq: tegra30: Support thermal cooling
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <65cdeb50-7ec1-4ed4-1eeb-342c4c915aa1@samsung.com>
Date:   Thu, 20 May 2021 11:50:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210510211008.30300-2-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmga7pqaUJBs195hbzj5xjtVj98TGj
        RcusRSwWZ5vesFtc3jWHzeJz7xFGi84vs9gs7rXsZbW43biCzeLsM2+L1r1H2C1+7prH4sDj
        sXPWXXaPTas62Tx6m9+xefS0bWLy6NuyitHj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZX298Zyy4xlFx+OtWxgbGaexdjJwc
        EgImEt977rB1MXJxCAnsYJS4vH8BI0hCSOATo0T7unCIxGdGiebbDUwwHRs/9jNBJHYxShw5
        +pwZwnnPKLFn5wlmkCphAS+JOYePs4AkRAQOMUnMn9AENJeDg1mgVGL3BhuQGjYBLYn9L26w
        gdj8AooSV388BlvNK2An8eLjdbA5LAKqEnv2dYPViAqESZzc1gJVIyhxcuYTFhCbU8BMYsX3
        L2DXMQuIS9x6Mh/KlpfY/nYOM8TVRzgkuv7bQtguEuv+3YaKC0u8Or4FGhZSEp/f7WWDsKsl
        Vp48Ag4XCYEORokt+y+wQiSMJfYvncwE8YumxPpd+hBhRYmdv+cyQuzlk3j3tYcVpERCgFei
        o00IokRZ4vKDu9BAlJRY3N7JNoFRaRaSb2Yh+WAWkg9mISxbwMiyilEstaA4Nz212LDAEDmy
        NzGCk6+W6Q7GiW8/6B1iZOJgPMQowcGsJMK73XtxghBvSmJlVWpRfnxRaU5q8SFGU2D4TmSW
        Ek3OB6b/vJJ4Q1MjY2NjCxNDM1NDQyVx3nTn6gQhgfTEktTs1NSC1CKYPiYOTqkGpj1pKxcX
        Pste9ofRslTo6wYnwy1G4c2czjs2eomK1FR8KYhz/HH35y3F4gsivvVbWvreR51fxPLtqXtU
        epuMQmm85bR5Ze1S97YHzPp4tNjUWpZ9SpKTe4fgmS11NollJ1b8e1orpNXdwLFMNnWD/+aZ
        d2qZLQubynm3RU5r5Ej9ruXypGPavPM7AqO0skwTpbV+xj5sfcPId1wuIPX2TRVDm4Q1AaW2
        ploHL1neeXVkqWp7R7tS4we3Cdochp8UHt16wVDfecshZ5Yk2/GkaRY/T/9mfMHp3WdX6zjl
        lRBr1UvtDecfvrouyuXbpSEgfGKeT+7mP3F6Dk8mhsdzRBfyphnfMM71+/C24KkSS3FGoqEW
        c1FxIgA7w7R9RwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvK7pqaUJBt/PiljMP3KO1WL1x8eM
        Fi2zFrFYnG16w25xedccNovPvUcYLTq/zGKzuNeyl9XiduMKNouzz7wtWvceYbf4uWseiwOP
        x85Zd9k9Nq3qZPPobX7H5tHTtonJo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDK+3vjOWHCN
        o+Lw162MDYzT2LsYOTkkBEwkNn7sZ+pi5OIQEtjBKLHo2H0WiISkxLSLR5m7GDmAbGGJw4eL
        IWreMkocfnwbrEZYwEtizuHjYLaIwBEmiW89fiA2s0CpxLON7YwQDVsZJa4v6GICSbAJaEns
        f3GDDcTmF1CUuPrjMSOIzStgJ/Hi43VmEJtFQFViz75usBpRgTCJnUseM0HUCEqcnPkEbBmn
        gJnEiu9fmCCWqUv8mXeJGcIWl7j1ZD5UXF5i+9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRM
        LSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkQtrR2Me1Z90DvEyMTBeIhRgoNZSYR3u/fi
        BCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYpHuYrR/P
        aijfeia3kCPl7cSTH9/P3y19flXoK5uX6hGNGdcdpl3lCnjkpdk5uUDiVZ56lmnZ/um/+6XS
        r1qv7vOdxzNjh3sP+7G3TWFubg9vflPcuDI1PZPD6Nyx0KAJd3w1J4es454189rk8mjpNC8T
        fp83b+69ehIle0OBY9qh9rkvxcVFHeuzs1PC5u9k2bdnztdVYrKe9sIcTJqXtL/PW+RmVN3A
        +bV10eT9Uoda178oteS9w5krxJ4bfqij8dTexW1b/kbu3cLMZ/NB7FmJ+hPltE6TUM/0lPda
        fJI5gZmzFeaYPX+f9YKzSiVb4ej+ld9Mw44xdyYGZL7129A5Y+Eil2fHNwq8CbVRYinOSDTU
        Yi4qTgQAgQat8zMDAAA=
X-CMS-MailID: 20210520023221epcas1p4ef055525be61fa87393e57e9401dde82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510211156epcas1p4d6b1e317b12d97433fa31b43ecce23da
References: <20210510211008.30300-1-digetx@gmail.com>
        <CGME20210510211156epcas1p4d6b1e317b12d97433fa31b43ecce23da@epcas1p4.samsung.com>
        <20210510211008.30300-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/11/21 6:10 AM, Dmitry Osipenko wrote:
> Expose ACTMON devfreq device as a cooling device in order to throttle
> memory freq on overheat. Throttling of memory freq has a significant
> cooling effect on NVIDIA Tegra SoCs since higher memory freqs require
> higher SoC core voltage which is one of the main causes of the heating.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index ce83f883ca65..10661eb2aed8 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -688,6 +688,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
>  	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>  	.target		= tegra_devfreq_target,
>  	.get_dev_status	= tegra_devfreq_get_dev_status,
> +	.is_cooling_device = true,
>  };
>  
>  static int tegra_governor_get_target(struct devfreq *devfreq,
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

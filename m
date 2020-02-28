Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D49173559
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 11:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgB1K3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 05:29:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46836 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1K3Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 05:29:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200228102914euoutp01c96fa1b44bb9d5d3401ca69d516ec20f~3ijUMOmb91430514305euoutp01G
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 10:29:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200228102914euoutp01c96fa1b44bb9d5d3401ca69d516ec20f~3ijUMOmb91430514305euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582885754;
        bh=X9bajA69gmmLWJJGMdZ1IAaxS4NTZY4KpVuFVP8cbhc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hWG3L17C6ixkm7KDLp2rj5gzrDEcy8doL8QH3HvL/RBCOZCv6GHutXlwoyPDnpW7Z
         pkmnpjnRu2GjftMKCs/dhRq4Qq9q9vuogtGHZCdxMMFNeQjUYP4NWfvlRknQDFUYZn
         8PmMuTCuXirFG5IeA0sASoRXL5VsgBDy1F3Ken+E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200228102914eucas1p2064c3c403fed816687160aa2b6a212dc~3ijT2Q5Wk2855628556eucas1p2g;
        Fri, 28 Feb 2020 10:29:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.CA.61286.A7BE85E5; Fri, 28
        Feb 2020 10:29:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200228102913eucas1p1bdb0090ac327025333b40d94f847818f~3ijTnGKQu2389223892eucas1p1C;
        Fri, 28 Feb 2020 10:29:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200228102913eusmtrp1b789b9d714b0276c62da06a1934f15da~3ijTmhg-o3213732137eusmtrp1B;
        Fri, 28 Feb 2020 10:29:13 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-75-5e58eb7a3858
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.47.07950.97BE85E5; Fri, 28
        Feb 2020 10:29:13 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200228102913eusmtip2cebdd04937cd01ff5c432d1ba340398f~3ijTNwG8F0204202042eusmtip2M;
        Fri, 28 Feb 2020 10:29:13 +0000 (GMT)
Subject: Re: [PATCH] thermal: exynos: Silence warning during deferred probe
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c9433ccc-403f-699f-e945-09a33cad156b@samsung.com>
Date:   Fri, 28 Feb 2020 11:29:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200228092331.21548-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7pVryPiDPZ9ZrH4fu4nk8W8z7IW
        589vYLf43HuE0WLG+X1MFmuP3GW3ePKwj82B3WPxnpdMHptWdbJ53Lm2h82jb8sqRo+O45Ue
        nzfJBbBFcdmkpOZklqUW6dslcGXMvjqLteAJR8XEWSuYGxjnsHcxcnBICJhI7G9Q6WLk4hAS
        WMEo0bqnjR3C+cIocfZJFyuE85lR4tnVL0xdjJxgHReen2ODSCxnlPj9fztU1VtGidnPZ7OB
        zBUW8JbYftMTpEFEQF+iu+0KI0gNs8AzoLGvL4JNYhOwkpjYvooRpJ5XwE7iwFdVkDCLgKpE
        d9chRhBbVCBC4tODw6wgNq+AoMTJmU9YQGxOoPKnndfBbGYBcYlbT+YzQdjyEtvfzmEG2SUh
        sItd4v+kxSwQf7pI/PpvBvGAsMSr41vYIWwZidOTe1gg6tcxSvzteAHVvJ1RYvnkf2wQVdYS
        d879AnuMWUBTYv0ufYiwo8T3JedZIebzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ
        27VzJfMERqVZSD6bheSbWUi+mYWwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzA
        NHT63/FPOxi/Xko6xCjAwajEw7tgR3icEGtiWXFl7iFGCQ5mJRHejV9D44R4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpglBS8UvrkbPaKnSGBkgbvqtLm
        bfj/c7aD8YJWBpbGv7U2TO+apTeF3Q5VN9nY+fTjEfsAm9/mW1Vk76pv/5hw7t+cosYzktkn
        TFoN9sncfxIzqfJeA7NbRgP7Ly+bfwoL+N9nW/OttGvasMwl1dzC/tDnhC8LNDq6eN6yPb+w
        iHVCmYPNqz9CSizFGYmGWsxFxYkATY5sjD8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7qVryPiDLbcN7T4fu4nk8W8z7IW
        589vYLf43HuE0WLG+X1MFmuP3GW3ePKwj82B3WPxnpdMHptWdbJ53Lm2h82jb8sqRo+O45Ue
        nzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GXMvjqLteAJR8XEWSuYGxjnsHcxcnJICJhIXHh+jq2LkYtDSGApo8SHP19Zuhg5gBIyEsfX
        l0HUCEv8udYFVfOaUeLY47VsIDXCAt4S2296gtSICOhLdLddYQSpYRZ4xihxuOsHM0TDREaJ
        zXM3sYBUsQlYSUxsX8UI0swrYCdx4KsqSJhFQFWiu+sQI4gtKhAhcXjHLDCbV0BQ4uTMJ2Ct
        nEDlTzuvg9nMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWM
        IqmlxbnpucVGesWJucWleel6yfm5mxiBkbft2M8tOxi73gUfYhTgYFTi4fXYFh4nxJpYVlyZ
        e4hRgoNZSYR349fQOCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByaFvJJ4Q1NDcwtLQ3Nj
        c2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjJqGn26kGyVxmeV0XqrenVh3cZ377G2q
        GRYPbvOH/5j0qf3ctsnvdrx2635X/kehUCkpwo//2AntfwLSy1UXhfS3zk2V4dnQkdGn5vbv
        Qt939k0/LpcFLr/6c0tU/Nr7ihu1dbp2+h32kOn1rbjzTXHtpetZP1qOHmw6xmq9hCX3guD/
        ni9Jj5VYijMSDbWYi4oTARKQtF7SAgAA
X-CMS-MailID: 20200228102913eucas1p1bdb0090ac327025333b40d94f847818f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a
References: <CGME20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a@eucas1p1.samsung.com>
        <20200228092331.21548-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2/28/20 10:23 AM, Marek Szyprowski wrote:
> Don't confuse user with meaningless warning about the failure of
> registering sensors in case of deferred probe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index fd4a17812f33..e9a90bc23b11 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1094,7 +1094,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  						    &exynos_sensor_ops);
>  	if (IS_ERR(data->tzd)) {
>  		ret = PTR_ERR(data->tzd);
> -		dev_err(&pdev->dev, "Failed to register sensor: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to register sensor: %d\n",
> +				ret);
>  		goto err_sclk;
>  	}
>  

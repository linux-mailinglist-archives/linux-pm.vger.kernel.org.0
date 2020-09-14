Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7BE268532
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 08:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgING5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 02:57:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:18989 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgING46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 02:56:58 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200914065655epoutp013553ecac984965601af7bb9a7c05a063~0lBv8MLS12860928609epoutp01j
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 06:56:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200914065655epoutp013553ecac984965601af7bb9a7c05a063~0lBv8MLS12860928609epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600066615;
        bh=C4XSZmER5MiWAkWbGr3v851kfh36ZagoIZlAAYNfoi8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dDM5dzCM/tU6Z7wFrOzwgje3QdEWHiwQLjix4eE1MJwZmVlj9/jhBKiOqpL/lmrX2
         sp8Ao1JvB5GblylEhnHmlSSJ9iVwEo1L9IPslz/8qpFh89wcOAGYh+gu+xeuWkKvZn
         Y2/weDxpNbcb7IWmaaZTEFpDih59oC8MzrG99Oes=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200914065654epcas1p203ecdacb14b31928006da737a9880b32~0lBvWwKM40577705777epcas1p2g;
        Mon, 14 Sep 2020 06:56:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Bqcbm37TRzMqYkl; Mon, 14 Sep
        2020 06:56:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.F3.20696.3341F5F5; Mon, 14 Sep 2020 15:56:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200914065651epcas1p22e28d708d21874eca2cb84db41c976ac~0lBsKuUlt0084800848epcas1p2H;
        Mon, 14 Sep 2020 06:56:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914065651epsmtrp115b6fc19ae0a4c2c4d19ce1d9cfcb7c5~0lBsJSWzS2839628396epsmtrp1g;
        Mon, 14 Sep 2020 06:56:51 +0000 (GMT)
X-AuditID: b6c32a39-47198a80000050d8-54-5f5f14331f17
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.B4.08303.3341F5F5; Mon, 14 Sep 2020 15:56:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200914065651epsmtip2f48e276ad838e02f9bba22738298e477~0lBr2HCLy2271522715epsmtip28;
        Mon, 14 Sep 2020 06:56:51 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
Date:   Mon, 14 Sep 2020 16:09:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200908072557.GC294938@mwanda>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmga6JSHy8wfWbjBav/01nsVj98TGj
        RcusRSwWW29JW5xtesNu8bn3CKNF55dZbBa3G1ewWfzcNY/FgdNj56y77B69ze/YPD4+vcXi
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Izju78w1gwg6tiwYzvjA2MKzi6GDk5JARMJG4susDSxcjFISSwg1Hi5db9
        TBDOJ0aJO5s2QjmfGSWm/5jPBNMy5ddhZojELkaJH+cmsUE47xklbr44CVYlLOAt8fvBL9Yu
        Rg4OEYEgiYZfgiA1zALtTBLT29+xgtSwCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCfx99o0ZhCb
        RUBVYtuDT2BxUYEwiZPbWqBqBCVOznzCAmJzCuhKzN9+gh3EZhYQl7j1BOJSZgF5ie1v54Bd
        KiGwlEPi98H97BAvuEg8uvED6h1hiVfHt0DFpSRe9rdB2dUSK08eYYNo7mCU2LL/AitEwlhi
        /9LJTCCfMQtoSqzfpQ8RVpTY+XsuI8RiPol3X3vAnpcQ4JXoaBOCKFGWuPzgLtRaSYnF7Z1s
        ExiVZiF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQtMkaN7EyM4sWpZ7mCc/vaD3iFGJg7G
        Q4wSHMxKIryuKbHxQrwpiZVVqUX58UWlOanFhxhNgQE8kVlKNDkfmNrzSuINTY2MjY0tTAzN
        TA0NlcR5H95SiBcSSE8sSc1OTS1ILYLpY+LglGpgYt6kfnd2QOOp+J1bZM4rLFm44GNMRDAP
        0+yVGj/dzewOvf4lOX/b1akPMysmWQROlwnysuXcI/JE+OAkU93FQu4pv3RvstRuW/5sd9OP
        ffWTYpldMyzsXTeKzNq31/iR5LXNy1RX5dseXK/C1vC6ds7HrIsf2I5dW3mhIY/3u1XAhw9a
        7+9ONkvcujJUVyx1wdvgkLU/HDMmZ3KsE3YW+f0lstWilkOtVZr3gnC/8fe4tNxXB15fzhK6
        t4Bvp/0r6+lbVBcJeEfd8kn/cPlM8kWjaDYb7S4p519Ri6blLHz+TEvzzvYyXY0zVZ5Zq47w
        aGxfsVTnbcXHpSdP8XkslFTdvHpTxbMc0wuuUQWup5RYijMSDbWYi4oTAe+wp741BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXtdYJD7e4PgXMYvX/6azWKz++JjR
        omXWIhaLrbekLc42vWG3+Nx7hNGi88ssNovbjSvYLH7umsfiwOmxc9Zddo/e5ndsHh+f3mLx
        6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroyjO/8wFszgqlgw4ztjA+MKji5GTg4JAROJKb8O
        M3cxcnEICexglHi49SwrREJSYtrFo0AJDiBbWOLw4WKImreMEktWvQKrERbwlvj94BeYLSIQ
        JPHg2RJmEJtZoJNJ4vgZO4iGBkaJNxuawBJsAloS+1/cYAOx+QUUJa7+eMwIYvMK2En8vTYN
        rIZFQFVi24NPYHFRgTCJnUseM0HUCEqcnPmEBcTmFNCVmL/9BDvEMnWJP/MuQS0Wl7j1ZD4T
        hC0vsf3tHOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBEeYltYOxj2rPugdYmTiYDzEKMHBrCTC65oSGy/Em5JYWZValB9fVJqTWnyIUZqDRUmc
        9+ushXFCAumJJanZqakFqUUwWSYOTqkGJu2kOQ6ZiZeiA9xUDsskLmN6336Tx7s19WhrZc/H
        lxvSZm8N+/Ew67PQ3n1/hPU217SlH8njehEXe7HA6dMFl9P3BFInXrGM5JO7wjJrwublb3sK
        OULep0TvFNu0PebqUmbHyrLpbjEf2nLnt8zoYZflTM3NKp/7Oz06tcJb+Ijrxl2MK8taKx+H
        vzlVd3nP7/2dE7+nPuWd53dTiE3pWU9EgIo2d6rbqeln17Bsuf1sxxufltcy/J/vl3Sc3RT0
        4cmlXn2/Pa+Oq7z5+VN6+o61r87P/p8V6hqUGtdyzlxx9q4m50Ut/C1Ldh4vPfueeVqYOvOE
        BfdlXoY8/9X19YXcuRU7ep59nXKbN2+XNIcSS3FGoqEWc1FxIgB8r3SxHwMAAA==
X-CMS-MailID: 20200914065651epcas1p22e28d708d21874eca2cb84db41c976ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
        <20200908072557.GC294938@mwanda>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/8/20 4:25 PM, Dan Carpenter wrote:
> This error path needs to call clk_disable_unprepare().
> 
> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index e94a27804c20..dedd39de7367 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>  	if (rate < 0) {
>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> -		return rate;
> +		err = rate;
> +		goto disable_clk;
>  	}
>  
>  	tegra->max_freq = rate / KHZ;
> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
>  	reset_control_reset(tegra->reset);
> +disable_clk:
>  	clk_disable_unprepare(tegra->clock);

Is it doesn't need to reset with reset_contrl_reset()?

>  
>  	return err;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

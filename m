Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00706A7A3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfGPLrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:47:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25834 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733269AbfGPLrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:47:09 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716114706epoutp0354cc38a3ff996cfdd8eb31636a306189~x4LfzBjX21138111381epoutp03J
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:47:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716114706epoutp0354cc38a3ff996cfdd8eb31636a306189~x4LfzBjX21138111381epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563277626;
        bh=vHHe8ivww0E8RzCAtgBX1w/ZJIJbSM5l1RSGsKNENvY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dIeca58YacVE+PCXhjwGPFHRMjzbp2HvWMrKGkodFKZIm7PjhsYFACJux9NRPZ+wa
         02ee0FsHvLlxHUROdx96tZetLYTnsjC6F2G1GE8DqU3IBEIb06kkTc43PmZ/KujoxG
         nEjsIxFQ5uIWer+GAyYXtXyq9KxGPv3yI7M5qqfY=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716114705epcas1p3c42323ba345d71e1ac5d04bbf0daa9a7~x4LfIwASn2087020870epcas1p3Y;
        Tue, 16 Jul 2019 11:47:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45nzCC2wjnzMqYkX; Tue, 16 Jul
        2019 11:47:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.9A.04075.739BD2D5; Tue, 16 Jul 2019 20:47:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716114702epcas1p402685a6ab470532d329b8b0df9cae822~x4LcEXPG21278812788epcas1p4k;
        Tue, 16 Jul 2019 11:47:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716114702epsmtrp1f57c8c232ca0b2bac8a58860bad65051~x4LcBABx41911419114epsmtrp1L;
        Tue, 16 Jul 2019 11:47:02 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-45-5d2db937c65e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.3D.03638.639BD2D5; Tue, 16 Jul 2019 20:47:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716114702epsmtip134a6c94e7ebb3446e6add31a51f7f4a4~x4Lb05Y-N2972529725epsmtip1r;
        Tue, 16 Jul 2019 11:47:02 +0000 (GMT)
Subject: Re: [PATCH v4 03/24] PM / devfreq: tegra30: Handle possible
 round-rate error
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
Message-ID: <f28470ca-93dc-cdf9-b008-54c7b50cfd83@samsung.com>
Date:   Tue, 16 Jul 2019 20:50:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-4-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmvq75Tt1Yg333hC1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ8z9aVfQJFjxrqufsYHxHG8XIyeHhICJRNObJUwgtpDADkaJYwcjuxi5
        gOxPjBJrD/9hg3C+MUosubybBaZj/8yzzBCJvYwSP+69YIFw3jNKLOzYwAxSJSwQLvFj41Sw
        dhGBf4wSnT+b2UASzAKREod3rgZbyCagJbH/xQ2wOL+AosTVH48ZQWxeATuJmXN2gA1iEVCV
        mHNkIVi9qECExKkj81ggagQlTs58AmZzCphKnDt0hAlivrjErSfzoWx5ieats8FOlRD4zyYx
        59YqRogfXCS2PdvDDGELS7w6voUdwpaSeNnfBmVXS6w8eYQNormDUWLL/gusEAljif1LJwNt
        4ADaoCmxfpc+RFhRYufvuYwQi/kk3n3tYQUpkRDglehoE4IoUZa4/OAuE4QtKbG4vZNtAqPS
        LCTvzELywiwkL8xCWLaAkWUVo1hqQXFuemqxYYERcmxvYgQnVi2zHYyLzvkcYhTgYFTi4VXY
        rxMrxJpYVlyZe4hRgoNZSYTX9qt2rBBvSmJlVWpRfnxRaU5q8SFGU2BoT2SWEk3OByb9vJJ4
        Q1MjY2NjCxNDM1NDQyVx3nl/NGOFBNITS1KzU1MLUotg+pg4OKUaGI/N2rDI0PuEkcgk/uPL
        89KC6mtclRge7foadeSJzJwbTJabztRZr/rwnCnacUm93GG2OE6pyHNuVc5Xgvc+uvnm2eVr
        qVMevrgidbhKri535pT+M89rp7etNPLkctnztdXGxXN9t6a2pmyNjO3HsnLzMrGChN7mc1cT
        j31S+NPx7BVD8a9kTyWW4oxEQy3mouJEAN1+oOHCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnK7ZTt1Ygwnb+SxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy5v60K2gSrHjX1c/YwHiOt4uRk0NCwERi/8yz
        zF2MXBxCArsZJS4fW8cMkZCUmHbxKJDNAWQLSxw+XAxR85ZRYtvWA4wgNcIC4RI/Nk5lA0mI
        CDQxSWzqvcAOkmAWiJTombuFDaJjM6PEwgtvWUASbAJaEvtf3GADsfkFFCWu/ngMNolXwE5i
        5pwdYJtZBFQl5hxZyARiiwpESEy6tpMFokZQ4uTMJ2A2p4CpxLlDR5gglqlL/Jl3iRnCFpe4
        9WQ+VFxeonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al
        6yXn525iBMeYltYOxhMn4g8xCnAwKvHwntijEyvEmlhWXJl7iFGCg1lJhNf2q3asEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkaN7j9H7nd6b4xzvrVn
        9Z5Ls1bWhzJfFNy99AJ7hvDDl9W8y0/tLp1jwn7Nem+k77p/O3Yk3VqwONvHOeUiq7HAYsbZ
        ASbsbLvCpD/0vDxo4fOmUOPsrs/ZJsGpkTJJhy5ufs5maJR3JVDye62uXNiC6uMiv9fYO819
        Ub/wuMe5b8uqupf1LzyoxFKckWioxVxUnAgA22qbXK0CAAA=
X-CMS-MailID: 20190716114702epcas1p402685a6ab470532d329b8b0df9cae822
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223726epcas4p1790944443c61b34e6c8dd4d64200a2a2
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223726epcas4p1790944443c61b34e6c8dd4d64200a2a2@epcas4p1.samsung.com>
        <20190707223303.6755-4-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> The EMC clock rate rounding technically could fail, hence let's handle
> the error cases properly.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 5e2b133babdd..5e606ae3f238 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	struct tegra_devfreq_device *dev;
>  	struct tegra_devfreq *tegra;
>  	struct devfreq *devfreq;
> -	unsigned long rate;
>  	unsigned int i;
> +	long rate;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	reset_control_deassert(tegra->reset);
>  
> -	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
> +	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> +	if (rate < 0) {
> +		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> +		return rate;
> +	}
> +
>  	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
> +	tegra->max_freq = rate / KHZ;
>  
>  	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
>  		dev = tegra->devices + i;
> @@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>  		rate = clk_round_rate(tegra->emc_clock, rate);
>  

Please remove unneeded blank line.

> +		if (rate < 0) {
> +			dev_err(&pdev->dev,
> +				"Failed to round clock rate: %ld\n", rate);
> +			err = rate;
> +			goto remove_opps;
> +		}

Also, this patch doesn't contain code which restore the previous
tegra->cur_freq/max_freq when error happen.

> +
>  		err = dev_pm_opp_add(&pdev->dev, rate, 0);
>  		if (err) {
>  			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

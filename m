Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF936A846
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGPMIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:08:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41755 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPMIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:08:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716120841epoutp0400df390f9135d932f95fcd1026b54ded~x4eV2iVz52252422524epoutp04t
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:08:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716120841epoutp0400df390f9135d932f95fcd1026b54ded~x4eV2iVz52252422524epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563278921;
        bh=1gjXB11SDdzOElaLaCz38VXtg7I27G/M6KDnNos2QfI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gZFaHQng8SgG1J1YSJ5Up6WwPGkhr9tlv+SEhn3Ntcej+iOUIR1z8DSvcmkxTL6vY
         U6FRKfm8kQVqUoseiZBCOWKsIHQH4kAkiwXpsMWUw5lzxntptG9VBmc0yQyGzwuBnu
         O9IWk+bC6IxwJ8BtQJYVnqhs/vNrl6LKSTdkHoFU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716120840epcas1p251182e6c03bc82bfbd678de8a1adbeac~x4eU5YSVg0828408284epcas1p2Z;
        Tue, 16 Jul 2019 12:08:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45nzh60nmCzMqYkW; Tue, 16 Jul
        2019 12:08:38 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.4C.04088.64EBD2D5; Tue, 16 Jul 2019 21:08:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716120837epcas1p1df37dfb34f48fd69328ebe3ceaaafeb4~x4eSh9-c52801628016epcas1p18;
        Tue, 16 Jul 2019 12:08:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716120837epsmtrp1ca8ae72e5e6213d6dc92d74dd605e3c8~x4eShJMym2933029330epsmtrp1L;
        Tue, 16 Jul 2019 12:08:37 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-da-5d2dbe46339c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.CD.03706.54EBD2D5; Tue, 16 Jul 2019 21:08:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716120837epsmtip2f4928d45723529661d3e7503081e6f8f~x4eSVOTvS3108531085epsmtip2V;
        Tue, 16 Jul 2019 12:08:37 +0000 (GMT)
Subject: Re: [PATCH v4 08/24] PM / devfreq: tegra30: Move clk-notifier's
 registration to governor's start
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
Message-ID: <17d965c5-4114-4143-30c9-54cd88f9eff3@samsung.com>
Date:   Tue, 16 Jul 2019 21:11:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-9-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3c528LVaWY9Sdg6UaQ186izU2wiKDJIQwiiJLGTHjZxN3Zm
        98KysomamYXNa1dLicJmbSsd6ugmaWiRlKJQH1LKSrMSy9p2jPz2e27v//2/7yPmy+5goeIc
        o5WxGGk9gc0X3OsMVyiS2xQZUcNVQqrp6ztEnbBfFlDPj38UUX3uaoyaKPEiyvbNjlFvj93A
        qCl3rYAqvdWLJUg0zsGrSOOyD4o0JQVjmKbU0Yg0E81hacL0XJWOobMZi5wxZpmyc4xaNbFl
        W2ZipjIuilSQm6iNhNxIGxg1kZSSpkjO0fsuRMj30vo8XyqNZlliQ7zKYsqzMnKdibWqCcac
        rTdvMkeytIHNM2ojs0yGzWRUVLTS17g7V+e+1c43N4Ttry8bFeWj8mVFSCIGPBa66rv4fpbh
        TgQXvBuL0HwfjyOorGzhc8F3BCeLx9G/icLztSKu0Irg4cRVjAs+I+i3XQqcFYznQmVbmdBf
        WIzPILBNFWD+Ah/fCZ2uJp6fMTwCPB/6A/mF+Ep49fNdQEKKx4Pr06NAXoCvhvvTr4V+DsF3
        wDNvrYDrWQRPL74PsARXQsP0LyF3/lJ4876Ox/EKKGipCngA/A8GD4a8sx6S4MndUSHHwTD6
        2CHiOBRGzpya5UNw86kX44ZPI3B4XswOxIDn2jmfgtinEA633Ru49EpwTdcgTngBjE0WC/0t
        gEvh9CkZ17IK+oYHeRwvgyuFNqwMEfY5duxzLNjnWLD/F6tHgka0hDGzBi3DkmZy7nc3o8C2
        RiidqKI7pQPhYkQESeWe9RkyIb2XPWDoQCDmE4ul6sl1GTJpNn3gIGMxZVry9AzbgZS+1z7L
        Dw3JMvl232jNJJXRMTExVCwZpyRJYqm09ld4hgzX0lYml2HMjOXfHE8sCc1HsvbWGveS1ds9
        Azd4I9d74oZ0KrHq5aPfU82M83b/SDkM/KzXT+75+OUPqUzvVPWqHerP3Y2Hqz5UmBNi67bG
        e9esszsdux4mvqbuHO7a13YoJ/zog7EfM3skffu/H+me19O7vDTSJlob1q0tnbR5eOMNR1Or
        g1wlE6lXGp7MS1lPCFgdTUbwLSz9F5sSGFLDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvK7rPt1Yg1+/NSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgydq09yFywXK5iwYRX7A2MkyS7GDk5JARMJNqn
        zmMHsYUEdjNKvLjtBhGXlJh28ShzFyMHkC0scfhwcRcjF1DJW0aJG92tbCA1wgLZEjP2TWAF
        SYgINDFJbOq9ADaIWSBSomfuFjaIjs2MEpuuNIAl2AS0JPa/uAHWzS+gKHH1x2NGEJtXwE5i
        59tjYHEWAVWJ7b+vs4LYogIREpOu7WSBqBGUODnzCZjNKWAqsfz3H1aIZeoSf+ZdYoawxSVu
        PZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8
        dL3k/NxNjOAY09LcwXh5SfwhRgEORiUe3hN7dGKFWBPLiitzDzFKcDArifDaftWOFeJNSays
        Si3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoEx/ufRSgH1YB4/q69x
        LFf/2u2U+an1lHPeW6d7L9dZXBJyfa980SVAPKc1tJwr813S4wJ/dtmIOl7Z/tpZj7Re+DM9
        rViz97Ve5olqP0s7do4fVkflFydJJKy8LMCWvSGPe/2TWckTWabM/MX+zcdlZ17l6mAlPSb1
        dlfrr+eunrB5G3mbgVOJpTgj0VCLuag4EQBvFxiarQIAAA==
X-CMS-MailID: 20190716120837epcas1p1df37dfb34f48fd69328ebe3ceaaafeb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223642epcas4p4f2ab67ac52b79ed8c64dd68f89792bcd
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223642epcas4p4f2ab67ac52b79ed8c64dd68f89792bcd@epcas4p4.samsung.com>
        <20190707223303.6755-9-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitiry,

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> There is no point in receiving of the notifications while governor is
> stopped, let's keep them disabled like we do for the CPU freq-change
> notifications. This also fixes a potential use-after-free bug if
> notification happens after device's removal.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 33 ++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 48a799fa5f63..d5d04c25023b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -576,6 +576,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
>  
> +	/*
> +	 * CLK notifications are needed in order to reconfigure the upper
> +	 * consecutive watermark in accordance to the actual clock rate
> +	 * to avoid unnecessary upper interrupts.
> +	 */
> +	err = clk_notifier_register(tegra->emc_clock,
> +				    &tegra->clk_rate_change_nb);
> +	if (err) {
> +		dev_err(tegra->devfreq->dev.parent,
> +			"Failed to register rate change notifier\n");
> +		return err;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>  		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
>  
> @@ -602,6 +615,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>  		tegra_actmon_stop_device(&tegra->devices[i]);
>  
> +	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
> +
>  	return err;
>  }
>  
> @@ -618,6 +633,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>  		tegra_actmon_stop_device(&tegra->devices[i]);
> +
> +	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -862,22 +879,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> +	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
>  	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
>  	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
>  
> -	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
> -	err = clk_notifier_register(tegra->emc_clock,
> -				    &tegra->clk_rate_change_nb);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"Failed to register rate change notifier\n");
> -		goto remove_opps;
> -	}
> -
>  	err = devfreq_add_governor(&tegra_devfreq_governor);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
> -		goto unreg_notifier;
> +		goto remove_opps;
>  	}
>  
>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> @@ -893,9 +902,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  remove_governor:
>  	devfreq_remove_governor(&tegra_devfreq_governor);
>  
> -unreg_notifier:
> -	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
> -
>  remove_opps:
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
> @@ -912,7 +918,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  	devfreq_remove_device(tegra->devfreq);
>  	devfreq_remove_governor(&tegra_devfreq_governor);
>  
> -	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
>  	reset_control_reset(tegra->reset);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

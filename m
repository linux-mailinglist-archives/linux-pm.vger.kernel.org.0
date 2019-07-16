Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A566A894
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGPMU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:20:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34793 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPMU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:20:59 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716122055epoutp036928e5ef12819c53c3dad9464362c9a1~x4pBdtwI00969109691epoutp03U
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:20:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716122055epoutp036928e5ef12819c53c3dad9464362c9a1~x4pBdtwI00969109691epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563279655;
        bh=xsjneApn5zTmMogv/3sV730QisGaiz0RQiJTq4eeYAQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sNaPnPr5kkHo2nRrr/WnbIi8BB/MYeAVDcEfuvGjOh0TDXgRG1s3EqmrQ7EoIl4a1
         Pe7EpzL92Z8Po2H27Yt19wmvQfyd16hlzEEezdGnMAD9OuyWQdAGW/cPQST37UhKwq
         bwFgjWC0a6dfE5Urtk3HyLuBv+c2J1HIwOEOCHKA=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716122054epcas1p340989156d883181482e28311e7bd2648~x4pBC3NEj1358913589epcas1p33;
        Tue, 16 Jul 2019 12:20:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45nzyD57qgzMqYkW; Tue, 16 Jul
        2019 12:20:52 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.EF.04160.421CD2D5; Tue, 16 Jul 2019 21:20:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716122052epcas1p150bc214698d343bf2827e2c60be3b127~x4o_v8yVL0839208392epcas1p1P;
        Tue, 16 Jul 2019 12:20:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716122052epsmtrp2e8b34e1ee7ff523b716d9ac15d1b2857~x4o_vOOdG2555525555epsmtrp2g;
        Tue, 16 Jul 2019 12:20:52 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-8a-5d2dc124a582
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.5E.03638.421CD2D5; Tue, 16 Jul 2019 21:20:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716122052epsmtip2f4b33cee324dd065bcf06a02f8ad8c59~x4o_hfaLH2935229352epsmtip2W;
        Tue, 16 Jul 2019 12:20:52 +0000 (GMT)
Subject: Re: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
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
Message-ID: <c883bdbe-427f-35a1-9e63-5e4953a84286@samsung.com>
Date:   Tue, 16 Jul 2019 21:23:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-12-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNa6fTohbHul0blzK4gSIMpTgodYkEq2JCYmJcgnUCIyBdhpli
        XD5ki0CjBOVDrIoGl+BCQEADREQoApq44hZNE5OiESEliqi4oG0HIn/nnnvOu8u7CqmqBlcr
        0i02lrcwJhKfgN1yhoSHzW8NS4oo/bOIvvbZjeh8RwVGP8ztl9PdTWdwevBYO6KLvjpw+m1O
        JU4PN5VjdHHVM3xNgKHBdREZGh0uueFYngc3FNdfRYbB2rmJsh0ZsWksk8LyGtaSbE1Jt6Tq
        yU1bjOuMuugIKoyKoZeTGgtjZvVkXEJiWHy6ydsQqdnHmLK8VCIjCGT4qljemmVjNWlWwaYn
        WS7FxMVwywTGLGRZUpclW80rqIiISJ1XuDsjLedcrox7Tu53Frjk2ahsth0FKICIgq7+x3I7
        mqBQEQ0IRt4XIDH4gqD1XfVo8A2B83uHZMxiL+tEPqwimhEMPNkviga89nsOv2gqsR5qSiol
        vsQ0YgRB0XAe7ktIie3gbLzmF+FEKLR8fO3nJxNB8OKH2/+qklgF1b0v/DxGLIC2932YD08n
        tsGD9nJM1EyB+6d6/DiAiIaqV8NS8f2Z8KbnnETE8yDv5mmprwkg/uLwtbMSE0eIg4f2IamI
        p8Knznq5iNUw6GnGRXwIrtxvx0VzIYL6licyMaGFlkul3goKb4UQqG4KF+kgaPx1FomFA8Ez
        dFTmkwChhMIjKlESDN3vXKNbnAUXCorwEkQ6xo3jGDeCY9wIjv/FziPsKprBcoI5lRUoLmr8
        d9ci/7WG0g3o9qOENkQoEDlJ2XV7aZJKxuwTDpjbECik5DSlfmhJkkqZwhw4yPJWI59lYoU2
        pPNu+7hUPT3Z6r19i81I6SK1Wi0dRUXrKIqcqSz/HZKkIlIZG5vBshzLj/kkigB1NprTsDT6
        ZdHGu/EreZtrYXcZp175Q94a2yXj7rkP9S2+WJtbd6svcxfo11qcVaZWd0iZJKfm5OUO1Ift
        /vm8d+eUw/PtV1a/7ahze4qv3/BwFflzRzZqgxNHzjZez+QCZ3zg91ZpHk8kVQV1tVhCc++N
        R4vvGIeentiq3iCT9WzeQ2JCGkOFSnmB+Qf2dyInwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvK7KQd1Yg/27hC1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyGuc3sRZcUao43H6XvYFxhkwXIyeHhICJRNeM
        44xdjFwcQgK7GSVunV/JDpGQlJh28ShzFyMHkC0scfhwMUTNW0aJhb07mEBqhAXcJTZMWMEE
        khARaGKS2NR7AayZWSBSomfuFjaIji2MEh23b4Ml2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCT
        WP/yKlicRUBV4tDT1ywgtqhAhMSkaztZIGoEJU7OfAJmcwqYSay9/pMZYpm6xJ95l6BscYlb
        T+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQv
        XS85P3cTIzjKtLR2MJ44EX+IUYCDUYmH98QenVgh1sSy4srcQ4wSHMxKIry2X7VjhXhTEiur
        Uovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTD26K1W6MxVb/2zqnfm
        hKKnZhM7E3l9E4O49OfWcL6byra0T5PbROXivgiBts3zDFk4e42vXF970um8hZm3Z9t3sc27
        t7IfnXBY5oXku1vtD7uvTd5yrftm37mmyztVxTnXe7TOv+U66+R/PuUt8d99TBLEd37PTi3V
        eFU0LaXbqudU1wvpiWZKLMUZiYZazEXFiQDypbyjrgIAAA==
X-CMS-MailID: 20190716122052epcas1p150bc214698d343bf2827e2c60be3b127
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223640epcas4p15337f40466342832b731ad6a53be946e
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223640epcas4p15337f40466342832b731ad6a53be946e@epcas4p1.samsung.com>
        <20190707223303.6755-12-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Usually, the kernel log print for all users
such as changing the frequency, fail or success.

But, if the log just show the register dump,
it is not useful for all users. It is just used
for only specific developer.

I recommend that you better to add more exception handling
code on many points instead of just showing the register dump.

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Add debug messages to know about what's happening in hardware and how
> driver reacts.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 35 +++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 878c9396bb8c..c6c4a07d3e07 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -41,6 +41,7 @@
>  #define ACTMON_DEV_AVG_UPPER_WMARK				0x10
>  #define ACTMON_DEV_AVG_LOWER_WMARK				0x14
>  #define ACTMON_DEV_COUNT_WEIGHT					0x18
> +#define ACTMON_DEV_COUNT					0x1c
>  #define ACTMON_DEV_AVG_COUNT					0x20
>  #define ACTMON_DEV_INTR_STATUS					0x24
>  
> @@ -276,6 +277,9 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  					 unsigned long *lower,
>  					 unsigned long *upper)
>  {
> +	struct device *ddev = tegra->devfreq->dev.parent;
> +	u32 offset = dev->config->offset;
> +
>  	/*
>  	 * Memory frequencies are guaranteed to have 1MHz granularity
>  	 * and thus we need this rounding down to get a proper watermarks
> @@ -288,6 +292,9 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  	*lower = tegra_actmon_lower_freq(tegra, target_freq);
>  	*upper = tegra_actmon_upper_freq(tegra, target_freq);
>  
> +	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper freq %lu\n",
> +		offset, target_freq, *lower, *upper);
> +
>  	*lower /= KHZ;
>  	*upper /= KHZ;
>  
> @@ -367,11 +374,31 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
>  }
>  
> +static void actmon_device_debug(struct tegra_devfreq *tegra,
> +				struct tegra_devfreq_device *dev,
> +				const char *prefix)
> +{
> +	dev_dbg(tegra->devfreq->dev.parent,
> +		"%03x: %s: 0x%08x 0x%08x a %u %u %u c %u %u %u b %lu cpu %u\n",
> +		dev->config->offset, prefix,
> +		device_readl(dev, ACTMON_DEV_INTR_STATUS),
> +		device_readl(dev, ACTMON_DEV_CTRL),
> +		device_readl(dev, ACTMON_DEV_AVG_COUNT),
> +		device_readl(dev, ACTMON_DEV_AVG_LOWER_WMARK),
> +		device_readl(dev, ACTMON_DEV_AVG_UPPER_WMARK),
> +		device_readl(dev, ACTMON_DEV_COUNT),
> +		device_readl(dev, ACTMON_DEV_LOWER_WMARK),
> +		device_readl(dev, ACTMON_DEV_UPPER_WMARK),
> +		dev->boost_freq, cpufreq_get(0));
> +}
> +
>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
>  	u32 intr_status, dev_ctrl, avg_intr_mask;
>  
> +	actmon_device_debug(tegra, dev, "isr+");
> +
>  	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>  	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
>  	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
> @@ -422,6 +449,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  
>  	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
> +
> +	actmon_device_debug(tegra, dev, "isr-");
>  }
>  
>  static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
> @@ -712,6 +741,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
>  static int tegra_governor_get_target(struct devfreq *devfreq,
>  				     unsigned long *freq)
>  {
> +	struct device *ddev = devfreq->dev.parent;
>  	struct devfreq_dev_status *stat;
>  	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
> @@ -734,6 +764,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  		dev_target_freq = actmon_update_target(tegra, dev);
>  
>  		target_freq = max(target_freq, dev_target_freq);
> +
> +		dev_dbg(ddev, "%03x: upd: dev_target_freq %lu\n",
> +			dev->config->offset, dev_target_freq);
> +
> +		actmon_device_debug(tegra, dev, "upd");
>  	}
>  
>  	*freq = target_freq * KHZ;
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27CEF440
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 04:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfKED5U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 22:57:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:60090 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbfKED5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 22:57:20 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191105035717epoutp03fea6081278adf0f176c0f296062e55f9~UKBRJCDM60195301953epoutp03d
        for <linux-pm@vger.kernel.org>; Tue,  5 Nov 2019 03:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191105035717epoutp03fea6081278adf0f176c0f296062e55f9~UKBRJCDM60195301953epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572926237;
        bh=DYxMz6JqCMlTP0GtfwvhuqL15LAqP6ypmBpBVPeB1/E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cmv/3cPAT17AN172OtfiB0x1L8uOCym9LJuutHr9zyNZaKyPOUXciw36OheCCriJP
         Z+muODie3oooV83WKbHixJjr2pKDAc5XOdZdrE4ZrGWDyi4EUoVd1PyG+S29uP4piC
         oP+5ywTdOopvqCNkqQxDdYTsclXfHtXv+RO2aPlo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191105035716epcas1p283dbb70c465f9d98ce96a88b4426f472~UKBQncwol2227522275epcas1p2l;
        Tue,  5 Nov 2019 03:57:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 476bTQ4XnbzMqYkh; Tue,  5 Nov
        2019 03:57:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.7F.04224.813F0CD5; Tue,  5 Nov 2019 12:57:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191105035711epcas1p2d4293aaf1db47befb909e0030ea39158~UKBLatXu21246912469epcas1p2i;
        Tue,  5 Nov 2019 03:57:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191105035711epsmtrp111e72212747d8916bcd85d895f312a76~UKBLZ17lu2158921589epsmtrp1v;
        Tue,  5 Nov 2019 03:57:11 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-3c-5dc0f318da76
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.71.24756.713F0CD5; Tue,  5 Nov 2019 12:57:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191105035710epsmtip1608e646e77c942281d7ca5e1767fc983~UKBLCjuVC2448224482epsmtip1t;
        Tue,  5 Nov 2019 03:57:10 +0000 (GMT)
Subject: Re: [PATCH v9 15/19] PM / devfreq: tegra30: Use kHz units for
 dependency threshold
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <503e756b-4bed-2cd9-a167-2cabfd739fc3@samsung.com>
Date:   Tue, 5 Nov 2019 13:02:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104215617.25544-16-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTYRDN12O7qKufBXEkRuuqiZIAXUthPUCNqI1XSEyMGiquZVMIvdIt
        RjQxKgYUEfGKWO+jyhGtgYKAIgp4oGJUQjCaxqMoYoyiaCPxiG3Xg39v3sybmfcdpFR5lYgi
        sywO3m7hTDQxRFbbMlUdA/3X9erXecBWfvIhdrvztIxt3/ZewXY0HCXY/t2tiN35xUmw/p67
        iH22tYxg298sZgcajsvY4guPiTlDdXXes0hX7/QqdLvzPhA6Z/41QlfsqUC6/qpxqcTq7FmZ
        PJfB21W8xWDNyLIYk+jFy9PnpWsT1EwMM51NpFUWzswn0SlLUmMWZJkC69Gq9ZwpJ0ClcoJA
        xyXPsltzHLwq0yo4kmjelmGyTbfFCpxZyLEYYw1W8wxGrZ6mDRSuzc5036qS22rpDZW1pbIt
        qGBsIQojAcdDfdFpVIiGkEpch6B3n1cqBp8R1Py4SYiBH4HrkUv2T1LjlouJxoDE3acQg48I
        /N/aJcGqcKyHa+5dkmAiAndLoLF1e0guxaugpb4yVETgaGh6+4QI4hF4AnR+8wU2IUkKJ0Nn
        +ZogLcOTwP/rORGkR+GVcO8rF6QpPBLaDneHOobhRDjVXaIQu4+Gp90nJCIeD3k1R0J2AB9S
        QNenakWwD+AUqPZpRDPh8O62RyHiKOjdk/8Hb4LytlZC1O5A4Gl6KBcTGmhy7ZcE+0jxVHA3
        xIn0BKj/fgyJc4fDh69FcnEUBTvylWLJROh44ZWIeAycKdhJlCDaOciNc5AD5yAHzv/DTiJZ
        BYrkbYLZyAuMLX7wZVeh0MuNZuvQ1QdLmhEmET2M6iu4rlfKufVCrrkZASmlI6hHpY16JZXB
        5W7k7dZ0e46JF5qRNnDWe6VRowzWwD+wONIZ7TSNRsPGMwlahqFHU3PPu/RKbOQcfDbP23j7
        X52EDIvaglwHXxQfulgWeWmBUne0bN0VR3Kh98cibPTM7EwrObV04ssB5aT7WurGZso/eZmh
        d+BiGhvnNnfsUTXtvZPrqXrdEFu9oeiwoiu65U7EXIN1aML8kwtn9xxos6dUnFsxJTGCzn91
        a3NXeG1auck379KipTU/1/nO3Lt8oKgnctdZoi+PlgmZHBMttQvcb1yLlQHPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnK745wOxBq/v8Vqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFt+en2K0uN24gs3i7DNvi5+75rFY9K29xObA7bHj7hJG
        j52z7rJ79Da/Y/OY1baPzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgy1h/bxFqwTali9bYZ
        LA2M7TJdjJwcEgImEju3rmftYuTiEBLYzSjR9+ERC0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl
        3ndPZgSpERaIldi3vpsJJCEi8IxJYuHenUwgCWaBSImeuVvYQGwhgW2MEld640BsNgEtif0v
        boDF+QUUJa7+eMwIsoBXwE7i6kqwEhYBFYlv/+6DlYgKREg8334DbBevgKDEyZlPwG7jFDCX
        WPhkAjvEKnWJP/MuMUPY4hK3nsyHOkFeonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU
        56bnFhsWGOallusVJ+YWl+al6yXn525iBEefluYOxstL4g8xCnAwKvHwfmg/ECvEmlhWXJl7
        iFGCg1lJhPfijL2xQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgsky
        cXBKNTBGh2dMLXytKdJs9Gh/44Fpl34+rXzhx3dQdGd4wjnd6pKd2f9e7LxxYVZK4XEV7ueT
        Fr2Rujp36spYSZXPEzcZNHG8XPL/8MRDM6Ykcomuywkv2tAQJtDi8Ls5xPqI0LHS6O7rEyc0
        8SwUfL3kZN9Hk5eiMrqH774NrS/tsE14V571etckvpMNSizFGYmGWsxFxYkAT8O18roCAAA=
X-CMS-MailID: 20191105035711epcas1p2d4293aaf1db47befb909e0030ea39158
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191104221911epcas1p1ad970858ae85cddbb3961b1c7a727315
References: <20191104215617.25544-1-digetx@gmail.com>
        <CGME20191104221911epcas1p1ad970858ae85cddbb3961b1c7a727315@epcas1p1.samsung.com>
        <20191104215617.25544-16-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
> The dependency threshold designates a memory activity level below which
> CPU's frequency isn't accounted. Currently the threshold is given in
> "memory cycle" units and that value depends on the polling interval which
> is fixed to 12ms in the driver. Later on we'd want to add support for a
> variable polling interval and thus the threshold value either needs to be
> scaled in accordance to the polling interval or it needs to be represented
> in a units that do not depend on the polling interval.
> 
> It is nicer to have threshold value being defined independently of the
> polling interval, thus this patch converts the dependency threshold units
> from "cycle" to "kHz". Having this change as a separate-preparatory patch
> will make easier to follow further patches.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 852bde6249c7..3bd920829bfd 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -96,9 +96,10 @@ struct tegra_devfreq_device_config {
>  	unsigned int	boost_down_threshold;
>  
>  	/*
> -	 * Threshold of activity (cycles) below which the CPU frequency isn't
> -	 * to be taken into account. This is to avoid increasing the EMC
> -	 * frequency when the CPU is very busy but not accessing the bus often.
> +	 * Threshold of activity (cycles translated to kHz) below which the
> +	 * CPU frequency isn't to be taken into account. This is to avoid
> +	 * increasing the EMC frequency when the CPU is very busy but not
> +	 * accessing the bus often.
>  	 */
>  	u32		avg_dependency_threshold;
>  };
> @@ -126,7 +127,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
>  		.boost_down_coeff = 90,
>  		.boost_up_threshold = 27,
>  		.boost_down_threshold = 10,
> -		.avg_dependency_threshold = 50000,
> +		.avg_dependency_threshold = 16000, /* 16MHz in kHz units */
>  	},
>  };
>  
> @@ -311,7 +312,6 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>  	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	target_freq = do_percent(target_freq, avg_sustain_coef);
> -	target_freq += dev->boost_freq;
>  
>  	return target_freq;
>  }
> @@ -322,15 +322,18 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>  	unsigned long cpu_freq = 0;
>  	unsigned long static_cpu_emc_freq = 0;
>  
> -	if (dev->config->avg_dependency_threshold) {
> +	dev->target_freq = actmon_device_target_freq(tegra, dev);
> +
> +	if (dev->config->avg_dependency_threshold &&
> +	    dev->config->avg_dependency_threshold <= dev->target_freq) {
>  		cpu_freq = cpufreq_quick_get(0);
>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
> -	}
>  
> -	dev->target_freq = actmon_device_target_freq(tegra, dev);
> -
> -	if (dev->avg_count >= dev->config->avg_dependency_threshold)
> +		dev->target_freq += dev->boost_freq;
>  		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
> +	} else {
> +		dev->target_freq += dev->boost_freq;
> +	}
>  }
>  
>  static irqreturn_t actmon_thread_isr(int irq, void *data)
> @@ -396,15 +399,16 @@ static unsigned long
>  tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>  				  unsigned int cpu_freq)
>  {
> +	struct tegra_devfreq_device *actmon_dev = &tegra->devices[MCCPU];
>  	unsigned long static_cpu_emc_freq, dev_freq;
>  
> +	dev_freq = actmon_device_target_freq(tegra, actmon_dev);
> +
>  	/* check whether CPU's freq is taken into account at all */
> -	if (tegra->devices[MCCPU].avg_count <
> -	    tegra->devices[MCCPU].config->avg_dependency_threshold)
> +	if (dev_freq < actmon_dev->config->avg_dependency_threshold)
>  		return 0;
>  
>  	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
> -	dev_freq = actmon_device_target_freq(tegra, &tegra->devices[MCCPU]);
>  
>  	if (dev_freq >= static_cpu_emc_freq)
>  		return 0;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE02114A82
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 02:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfLFBbC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 20:31:02 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:49600 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLFBbC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 20:31:02 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191206013100epoutp01f0a07ead2389e4ee2b985836f59e6ab7~dpBZEIp6j2158721587epoutp01w
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 01:31:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191206013100epoutp01f0a07ead2389e4ee2b985836f59e6ab7~dpBZEIp6j2158721587epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575595860;
        bh=fQ2ebwvmievzi+7+A1jTenXMFKcVA+P8STbONEkIaR4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Dl8wVy/9anc9LZJVKJOfPiyDQ5U6DBJtAdWEtDoXhgDi0HDl330FRNPm4hhmYcYD1
         oiA3qERuCz/qlZBB5BuJhwe4lxgqQXh8PGaU0xyokpn4O50GxhsZfzFgesh2hBdbwR
         8a2LKPRMWnFRpyvGWfQJameAir6caXMnVTGWfi4Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206013059epcas1p1f6ddafc12ad6f86f9b30b137d8b9d48f~dpBYmsyfO2024120241epcas1p1F;
        Fri,  6 Dec 2019 01:30:59 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47TZmK19wPzMqYkV; Fri,  6 Dec
        2019 01:30:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.D1.51241.15FA9ED5; Fri,  6 Dec 2019 10:30:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191206013056epcas1p4faeb35aaaa285ceaae78ea103cfbfccc~dpBVzWPNv1303713037epcas1p4Q;
        Fri,  6 Dec 2019 01:30:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206013056epsmtrp162dbfb2b8690a5ad7075226e4ef9e2ab~dpBVymR-d1289412894epsmtrp1L;
        Fri,  6 Dec 2019 01:30:56 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-ff-5de9af51fa5a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.69.06569.05FA9ED5; Fri,  6 Dec 2019 10:30:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206013056epsmtip1b7195b60012804555598828ba403912e~dpBVlNrA83268332683epsmtip1R;
        Fri,  6 Dec 2019 01:30:56 +0000 (GMT)
Subject: Re: [PATCH v3 1/3] devfreq: change time stats to 64-bit
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7555cbdb-a930-f9e3-126d-362e5c42eda1@samsung.com>
Date:   Fri, 6 Dec 2019 10:37:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191205145527.26117-2-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuzu7s6O0dpsyTwulThEprDnp2hiuiUoYSRpBUGLb5A6ruC92
        Vnv9Y2Yv6f0wXTSNNMoKy9S2SMVHD40yqaiMXiTVlim4PYzC2t0x8r8f53zfPee791IEXU2q
        qTyLQ7BbeBNDBspbuiKiNKsb3NnRNSdJ7kp5g4KrGS1XcH19l5Xc/eIhJffoRiXJeQ50I+5S
        90sl92LHOTKJSmus30emHWyqR2mexrmZxPr8hFyBNwj2MMGSYzXkWYw6ZuUafYpeGxfNath4
        bgkTZuHNgo5JTc/ULM8zeTdgwgp5U4G3lMmLIrMoMcFuLXAIYblW0aFjBJvBZIu3RYm8WSyw
        GKNyrOalbHT0Yq1XuDE/1+V5Sthc6i2nL7Ypi1BbcCkKoADHwuumQbIUBVI0diGoLmtV+ho0
        HkVw9XGGxN8RvP/M/jOMNvfLpXorgp99Rsk8guD5lwukrzEDJ0Hl024/z8QaGHLVET4RgU/J
        YKjsocLXIHEktH985hdNw+HwZOwd8rEKJ0JdaZfMx3I8H46caPZzMF4LPS0lE5rp0FMx6N8i
        AOug9e24nwkcAgOD1TKJQ+Hal0r/YMCfSThaXiyTIqTC8aIfColnwKc7TUqJ1eA+tHuCt8P5
        nm5SMu9F0NT+cMIQA+11x7wHUd4JEdBwY5FUDofrv6qQNDgIhr/tV/gkgFWwdzctSebBozcv
        J1aYDWf27CMPI8Y5KY5zUgTnpAjO/8NqkLwezRJsotkoiKxNO/mxG5H/c0bGu9DtB+mdCFOI
        maoq93zMphV8objV3ImAIpiZKmOQO5tWGfit2wS7VW8vMAliJ9J6b/sIoQ7OsXq/usWhZ7WL
        Y2JiuFg2TsuyTIiKGuvPprGRdwj5gmAT7P98MipAXYSSh6uyaleaG27HLTu7uaI5SbddZgxx
        47KFfwyv0N2qXb9DxxIXGDpT2mpTUyriO27eexHIu4N2ZgzU7qADyE04oUq7qrBGMSctC76O
        9+KI9RtWTLusvzUlc0DTG/G8I29dcn9yyS/z5qTe6j1HezznB4tfL8vQhIfSIx+c99NjjzNy
        MZdnIwm7yP8FPqeberIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTjdg/ctYg0NT1Cw2zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJWx4/N15oIdUhUL1+xjb2DcJ9rFyMkhIWAi8WnrRRYQW0hgN6PE+beCEHFJ
        iWkXjzJ3MXIA2cIShw8XdzFyAZW8ZZSYemAWWL2wgIPEnOtH2EBsEQFdiTc7ljKDFDELLGCS
        mH9zIgtEx2FGiXNzFoB1sAloSex/cQOsg19AUeLqj8eMIDavgJ3E0q7DTCA2i4CKxMSpW8Fs
        UYEwiZ1LHjNB1AhKnJz5BGwOp4CtxN6H/8BsZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFR
        eBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgKNLS2sF4
        4kT8IUYBDkYlHt4Zn1/ECrEmlhVX5h5ilOBgVhLhTed7GSvEm5JYWZValB9fVJqTWnyIUZqD
        RUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBUfvXScV0p8bMhW0n4qtFGezV3txjlO0LnrnI
        KbzrKEebsJf5Rp2iuytc0mZbHvu8PvTllkO3q1veX/BnnR13ULJsYffxqaJ+D4K32tndPFN/
        R1bLU2DnuoUhK3r0b1z1eF/ikXO4KsggJJ4tM3Lt9yla58MviC098vyIVVL2cWV985AnRz8x
        KLEUZyQaajEXFScCAPIzwlWeAgAA
X-CMS-MailID: 20191206013056epcas1p4faeb35aaaa285ceaae78ea103cfbfccc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96@eucas1p1.samsung.com>
        <20191205145527.26117-2-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/5/19 11:55 PM, Kamil Konieczny wrote:
> Change time stats counting to bigger type by using 64-bit jiffies.
> This will make devfreq stats code look similar to cpufreq stats and
> prevents overflow (for HZ = 1000 after 49.7 days).
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v3:
> - changed types of cur_time and last_stats_updated to u64 as this is
>   returned by get_jiffies_64()
> 
> Changes in v2:
> - added Acked-by, rebased on linux-next
> ---
>  drivers/devfreq/devfreq.c | 14 +++++++-------
>  include/linux/devfreq.h   |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bdeb4189c978..abecadeb3dc2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -199,10 +199,10 @@ static int set_freq_table(struct devfreq *devfreq)
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
> -	unsigned long cur_time;
> +	u64 cur_time;
>  
>  	lockdep_assert_held(&devfreq->lock);
> -	cur_time = jiffies;
> +	cur_time = get_jiffies_64();
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq)
> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  out_update:
> -	devfreq->last_stat_updated = jiffies;
> +	devfreq->last_stat_updated = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -748,7 +748,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>  			devfreq->profile->max_state,
> -			sizeof(unsigned long),
> +			sizeof(*devfreq->time_in_state),
>  			GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
> @@ -756,7 +756,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = jiffies;
> +	devfreq->last_stat_updated = get_jiffies_64();
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1470,8 +1470,8 @@ static ssize_t trans_stat_show(struct device *dev,
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
>  				devfreq->trans_table[(i * max_state) + j]);
> -		len += sprintf(buf + len, "%10u\n",
> -			jiffies_to_msecs(devfreq->time_in_state[i]));
> +		len += sprintf(buf + len, "%10llu\n", (u64)
> +			jiffies64_to_msecs(devfreq->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2bae9ed3c783..41f15e7a22b8 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -174,8 +174,8 @@ struct devfreq {
>  	/* information for device frequency transition */
>  	unsigned int total_trans;
>  	unsigned int *trans_table;
> -	unsigned long *time_in_state;
> -	unsigned long last_stat_updated;
> +	u64 *time_in_state;
> +	u64 last_stat_updated;
>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

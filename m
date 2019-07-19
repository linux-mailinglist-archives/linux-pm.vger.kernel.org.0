Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24796D827
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGSBG7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:06:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41265 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfGSBG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:06:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190719010656epoutp02668f71a1700ce22dc2ce36e8b017fc89~yqYbGzvrC0753507535epoutp02n
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:06:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190719010656epoutp02668f71a1700ce22dc2ce36e8b017fc89~yqYbGzvrC0753507535epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563498417;
        bh=am99xISKLjJPAd9GoGBX2xQXYbqtyBs4l87iS2vTZu8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E9HbsryiNTzyaXqfzHpuHQqTPS2Xr7IWbNmCMbLmV/6qoIfP6bVX0EjW63fT5iNuB
         Iroxj/R7RupuToDucU0mV/4if9lFoAMwQ1Bwjv7u8f+7EvxRRuc5xXrOFAqpm+P+vR
         O9pLA+qOBHU9EiaEwLQBMgW8r8IcSTmzOa9+2hZo=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719010656epcas1p262a3bcaaa09a215c6bfe1ddeace1fc68~yqYajwFWT1152811528epcas1p2V;
        Fri, 19 Jul 2019 01:06:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45qXs972C5zMqYkb; Fri, 19 Jul
        2019 01:06:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.0C.04085.7A7113D5; Fri, 19 Jul 2019 10:06:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190719010647epcas1p3f6b192098c25a65d193b285f159babe7~yqYR4_cqL1567115671epcas1p3y;
        Fri, 19 Jul 2019 01:06:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719010647epsmtrp1f2b0f0c5c7396eab616a89e72bcef2b5~yqYR349e21366513665epsmtrp1T;
        Fri, 19 Jul 2019 01:06:47 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-30-5d3117a72c3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.41.03706.6A7113D5; Fri, 19 Jul 2019 10:06:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719010646epsmtip1ba5d952537c7e645cf3b2d2dff819e1e~yqYRuMInI1683216832epsmtip1O;
        Fri, 19 Jul 2019 01:06:46 +0000 (GMT)
Subject: Re: [PATCH v4 18/24] PM / devfreq: tegra30: Optimize CPUFreq
 notifier
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <02497cfd-9413-c3fb-22c3-a72659ef7b1f@samsung.com>
Date:   Fri, 19 Jul 2019 10:09:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719034258.651a9c06@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm23bOjtXqa2W+Dap1skBxuqPNjpFSJLHSYhSUFGYHPTrblXO2
        yILw0sUiLZEuTruQ3S+UYmVKSFqJlhKJ3WyUaNC6UpoU2WXbWeS/533f5/me7/m+l5Kr60gN
        lW938YKds9LkOMWNtqhY3bkIJlNfX6hjL30ZQOxOzykF21X8Qcn2NNWQ7FDZXcTuHfaQbF/R
        eZL90XRcwZZfeUwuDjM2ek8j4y2PV2ksK/lEGssbLiLjUP1ME7HessjMczm8oOXt2Y6cfHte
        Mp22JmtpliFRz+iYJHYBrbVzNj6ZTk036ZblW/0XorVbOKvb3zJxokjHpSwSHG4XrzU7RFcy
        zTtzrM4kZ6zI2US3PS8222FbyOj18QY/cZPF3P7rN+F8FbO18sVNWSE6G7kPhVGA58PVX8Oy
        fWgcpcaNCLr7L5NS8RXBoT+7QpMRBE/2v1H+k3h7u0Os2wiK6gaVUvEZwejnm0SANQWboLTv
        oSKAp+J5cO7eKBEgyXGdDNqvXZYFBiSOhpa3z8gAnoRnQ+/3ARTAKpwCtSe6ggcp8FwoLvUG
        rcNxBnx93UZInMnQUTUYNAjDsdB2qDbYl+MIeDF4QibhWVByvVoeMAZcooTfxV2hDKnQcaeT
        kPAUeNfeEOprwHdgdwhvhwsdd0lJXIqgoeVRSJAALWcq/Q6U3yEKrjbFSe3ZcOvnMSQZT4RP
        3/YTAQpgFZTuVkuUOdDz2iuT8HSo3bOXPIhoz5g4njERPGMieP6bnUSKi2ga7xRtebzIOA1j
        /7seBdc1OqkR3e9Ob0WYQvQElcmmz1QT3BaxwNaKgJLTU1V9vrhMtSqHK9jGC44swW3lxVZk
        8L92hVwTnu3wL7/dlcUY4hMSEtj5TKKBYegI1fHRqEw1zuNcvIXnnbzwTyejwjSFyFgzoSY5
        /Z5yyJBBvWmr1n5oXlJmtuiWDTJPY8jcNZH6zg0V1vKUGStyI/t1wqpTMw6npSX2VG9em1Hx
        3Xe0qMrdMOxW7vKtxk83IoV5YOBA36u4Bc+FodRm38SRK/H9N07uIQqOXNjxIHHl0kr74pd3
        0kvWvbcs7xzp/fPxZd14Da0QzRwTLRdE7i8WVm7JxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO5yccNYgzfJFqs/Pma0aJm1iMXi
        bNMbdovLu+awWXzuPcJo0fllFpvF7cYVbBY/d81jsehbe4nNgdNjx90ljB47Z91l9+htfsfm
        0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBnH//5jLbivUzH51namBsZlKl2MnBwSAiYSd6+e
        Y+ti5OIQEtjNKLHqWycTREJSYtrFo8xdjBxAtrDE4cPFIGEhgbeMEs2XskBsYQE/id7Tt5hB
        bBEBNYnlR/+wgsxhFtjMJHH21Gqoob1MEiuXzGEFqWIT0JLY/+IGG4jNL6AocfXHY0YQm1fA
        TmLx/LNgNSwCqhJNHXfZQWxRgQiJwztmQdUISpyc+YQFxOYU0JM4PHUxWD2zgLrEn3mXmCFs
        cYlbT+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3
        uDQvXS85P3cTIzjCtDR3MF5eEn+IUYCDUYmHNyDXIFaINbGsuDL3EKMEB7OSCO/tl/qxQrwp
        iZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTDWzObfcWG9RcTS
        CwGvHTrPBGQXbhYR1Oa3OPUtP9zsxheW2NMvY758i2UUkule+a/i2+P03dvuTvq4Od3ij9Ll
        6Dk/pFh+Z+wLevaE27MnVf/nvK7YBz4FeVcikw4ze2XE/dR9fOmQWFLwwXrl+TN9D/RFFdV9
        WHCAtfzCRCeNze8/eHu5Wv9RYinOSDTUYi4qTgQAmkQqr6wCAAA=
X-CMS-MailID: 20190719010647epcas1p3f6b192098c25a65d193b285f159babe7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223618epcas4p48e1e2ae7af04775ac50c68b7636f1a56
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223618epcas4p48e1e2ae7af04775ac50c68b7636f1a56@epcas4p4.samsung.com>
        <20190707223303.6755-19-digetx@gmail.com>
        <ce18694a-4281-a245-7bdf-299fedc3c724@samsung.com>
        <20190719034258.651a9c06@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 9:42, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 18:48:42 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> When CPU's memory activity is low or memory activity is high such
>>> that CPU's frequency contribution to the boosting is not taken into
>>> account, then there is no need to schedule devfreq's update. This
>>> eliminates unnecessary CPU activity during of idling caused by the
>>> scheduled work.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 73
>>> +++++++++++++++++++++++++++---- 1 file changed, 64 insertions(+), 9
>>> deletions(-)  
>>
>> Patch4 add the 'cpufreq notifier' and this patch optimize the cpufreq
>> notifier. I think t hat you can combine two patches.
> 
> I'd prefer to keep them separate for a sake of git bisection.

Sorry, patch7 instead of patch4.

Patch7 made the 'tegra_actmon_cpu_notify_cb()' function
and this patch makes 'tegra_actmon_cpufreq_contribution' function
which is only called in the 'tegra_actmon_cpu_notify_cb()' function.

It is enough to make them as the only one patch related to
the cpu notifier. As I replied on patch17, you can merge
the patch if the patches has some relationship in this patchset.

> 
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c index
>>> 43c9c5fbfe91..8d6bf6e9f1ae 100644 ---
>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>> b/drivers/devfreq/tegra30-devfreq.c @@ -216,10 +216,10 @@ static
>>> inline unsigned long do_percent(unsigned long val, unsigned int
>>> pct) return val * pct / 100; }
>>>  
>>> -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq
>>> *tegra) +static unsigned long actmon_cpu_to_emc_rate(struct
>>> tegra_devfreq *tegra,
>>> +					    unsigned int cpu_freq)
>>>  {
>>>  	const struct tegra_actmon_emc_ratio *ratio =
>>> actmon_emc_ratios;
>>> -	unsigned int cpu_freq = cpufreq_get(0);
>>>  	unsigned int i;
>>>  
>>>  	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++,
>>> ratio++) { @@ -239,15 +239,15 @@
>>> tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra, struct
>>> tegra_devfreq_device *dev, unsigned long target_freq)
>>>  {
>>> -	unsigned long static_cpu_emc_freq;
>>> +	unsigned long cpu_emc_freq = 0;
>>>  
>>> -	if (dev->config->avg_dependency_threshold &&
>>> -	    dev->config->avg_dependency_threshold < dev->avg_freq)
>>> {
>>> -		static_cpu_emc_freq =
>>> actmon_cpu_to_emc_rate(tegra);
>>> -		target_freq = max(target_freq,
>>> static_cpu_emc_freq);
>>> -	}
>>> +	if (!dev->config->avg_dependency_threshold)
>>> +		return target_freq;
>>>  
>>> -	return target_freq;
>>> +	if (dev->avg_freq > dev->config->avg_dependency_threshold)
>>> +		cpu_emc_freq = actmon_cpu_to_emc_rate(tegra,
>>> cpufreq_get(0)); +
>>> +	return max(target_freq, cpu_emc_freq);
>>>  }
>>>  
>>>  static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq
>>> *tegra, @@ -531,16 +531,71 @@ static void
>>> tegra_actmon_delayed_update(struct work_struct *work)
>>> mutex_unlock(&tegra->devfreq->lock); }
>>>  
>>> +static unsigned long
>>> +tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>>> +				  unsigned int cpu_freq)
>>> +{
>>> +	unsigned long freq, static_cpu_emc_freq;
>>> +
>>> +	/* check whether CPU's freq is taken into account at all */
>>> +	if (tegra->devices[MCCPU].avg_freq <=
>>> +	    tegra->devices[MCCPU].config->avg_dependency_threshold)
>>> +		return 0;
>>> +
>>> +	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra,
>>> cpu_freq); +
>>> +	/* compare static CPU-EMC freq with MCALL */
>>> +	freq = tegra->devices[MCALL].avg_freq +
>>> +	       tegra->devices[MCALL].boost_freq;
>>> +
>>> +	freq = tegra_actmon_upper_freq(tegra, freq);
>>> +
>>> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
>>> +		return 0;
>>> +
>>> +	/* compare static CPU-EMC freq with MCCPU */
>>> +	freq = tegra->devices[MCCPU].avg_freq +
>>> +	       tegra->devices[MCCPU].boost_freq;
>>> +
>>> +	freq = tegra_actmon_upper_freq(tegra, freq);
>>> +
>>> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
>>> +		return 0;
>>> +
>>> +	return static_cpu_emc_freq;
>>> +}
>>> +
>>>  static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
>>>  				      unsigned long action, void
>>> *ptr) {
>>> +	struct cpufreq_freqs *freqs = ptr;
>>>  	struct tegra_devfreq *tegra;
>>> +	unsigned long old, new;
>>>  
>>>  	if (action != CPUFREQ_POSTCHANGE)
>>>  		return NOTIFY_OK;
>>>  
>>>  	tegra = container_of(nb, struct tegra_devfreq,
>>> cpu_rate_change_nb); 
>>> +	/*
>>> +	 * Quickly check whether CPU frequency should be taken
>>> into account
>>> +	 * at all, without blocking CPUFreq's core.
>>> +	 */
>>> +	if (mutex_trylock(&tegra->devfreq->lock)) {
>>> +		old = tegra_actmon_cpufreq_contribution(tegra,
>>> freqs->old);
>>> +		new = tegra_actmon_cpufreq_contribution(tegra,
>>> freqs->new);
>>> +		mutex_unlock(&tegra->devfreq->lock);
>>> +
>>> +		/*
>>> +		 * If CPU's frequency shouldn't be taken into
>>> account at
>>> +		 * the moment, then there is no need to update the
>>> devfreq's
>>> +		 * state because ISR will re-check CPU's frequency
>>> on the
>>> +		 * next interrupt.
>>> +		 */
>>> +		if (old == new)
>>> +			return NOTIFY_OK;
>>> +	}
>>> +
>>>  	/*
>>>  	 * CPUFreq driver should support
>>> CPUFREQ_ASYNC_NOTIFICATION in order
>>>  	 * to allow asynchronous notifications. This means we
>>> can't block 
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

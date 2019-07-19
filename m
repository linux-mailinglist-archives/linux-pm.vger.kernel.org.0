Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94B86D85F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGSB2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:28:18 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44836 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfGSB2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:28:17 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190719012811epoutp035790ce1c003684e8be8381cdf37bb0a5~yqq97G8Th1947719477epoutp03P
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:28:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190719012811epoutp035790ce1c003684e8be8381cdf37bb0a5~yqq97G8Th1947719477epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563499691;
        bh=PZyZasIJiZyiZM7y6Zu10/ezTb9uWMiu81IaWhMvFi8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bXtlLf2rjnA9TZx0Cj5sZ0FElbhT5aeeSH49fHr/svqaFdAOxBJmtww3BjSxhs9js
         tyArp+TSvv44NpHTfNYjwuceDWJuveCIwU/mzupdrjpm5olW+WbhdnqwxdlnYVsOFE
         JDjTszkGLBvatefai4vF5T8+qAOS0nkHcBeXKst8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190719012810epcas1p3517e32eb163e71842f4de204ad35a8cf~yqq9TYR_z0916309163epcas1p3P;
        Fri, 19 Jul 2019 01:28:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45qYKh3hDgzMqYkW; Fri, 19 Jul
        2019 01:28:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.46.04160.8AC113D5; Fri, 19 Jul 2019 10:28:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719012808epcas1p119a1c09b7a819bc36b0835b590ebd69b~yqq69VOT00226202262epcas1p19;
        Fri, 19 Jul 2019 01:28:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719012808epsmtrp13166c23afa2bb1b3ecb7a9d7593052cb~yqq68PQYQ2567325673epsmtrp14;
        Fri, 19 Jul 2019 01:28:08 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-d0-5d311ca8b6ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.32.03706.7AC113D5; Fri, 19 Jul 2019 10:28:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719012807epsmtip12c29484c12a3015da60694852c230f79~yqq6vFtX32296322963epsmtip15;
        Fri, 19 Jul 2019 01:28:07 +0000 (GMT)
Subject: Re: [PATCH v4 05/24] PM / devfreq: tegra30: Set up watermarks
 properly
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
Message-ID: <038560dc-0aca-165e-e015-72c0c0dea337@samsung.com>
Date:   Fri, 19 Jul 2019 10:31:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719030058.617de581@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTURDG89rtthCrzwI6NkZxjQcklK5QXBSIByEVTKySGEUJrrApSI+1
        23rHFDEqIJ4xxqKAV8RbsSgWDeFQRIMar6BYNYgRLzxAoxGNbVcj//1m5pt8M++NQqo6T6oV
        eRY7Z7OwJooMJi42RWiiqkbSmdqap2rm5OeXiNnoOkQwbRvey5n7nv0k01vajJiiPhfJdBRU
        kcwPTznBbDt9j5wWpK/1HkH6yy6vXF9a2EPqt7lPIH1v9SiDLCM/IZdjczhbOGfJtubkWYyJ
        VFp61swsXZyWjqLjmclUuIU1c4lU8mxDVEqeyTcQFb6CNTl8KQMrCFR0UoLN6rBz4blWwZ5I
        cXyOiY/nNQJrFhwWoybbap5Ca7WTdD7hkvzcwrYHEt69H61qOLCXcKK69cUoSAE4Fur6nfJi
        FKxQ4VoELbsakBh8QXCrw/03+IbgRvUF9K+l77OTEAtXEbyr+USKwUcEFw4WSPyqEDwXdnqL
        SD+H4vFw7Fq/zC+S4vMSaDl3KiAicSTUd7cHREPwGHj4/WXAQomT4NuvApmfCTwOPK6bUj+H
        4QXw5UWTTNQMhdZ9XYSfg7AGSj48l/tZiofDk64KicijobCmTCqOXSiHzt+zRE6G5jKxF3AI
        vG1xy0VWw5vtm/7yWjje2hzYDPAWBO76uzKxEAP1R3f7DBQ+gwg464kW02Pg8s8DSPQdDD1f
        t8r8EsBK2LJJJUrGwv0XXonII+Dw5iJyB6JcA7ZxDdjANWAD13+zSkScQMM4XjAbOYHmYwf+
        dzUKnGskU4uu3J7diLACUYOUBrM2UyVjVwirzY0IFFIqVNnxJjpTpcxhV6/hbNYsm8PECY1I
        53vsnVJ1WLbVd/wWexatmxQTE8PE0nE6mqaGK8v7IzJV2MjauXyO4znbvz6JIkjtRMkZz+d0
        Vj2WXTd6lh19ndq56Hro6ZT4torpE3p7fk1NJVpD7D+bUk5e05Wktgsz2unuyh+S8ksZTVem
        79nKhy3e0LC89FmHs+xVXNqS4NjuunXPFp65c7XgSFpX3wc+IW/Q4pL5vSHzkx6V7z6r+jSR
        MjyWp2vmrbzj8JDFo73dS9+nU4SQy9KRUpvA/gF3LtAWxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnO4KGcNYgzszGS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyms9eYSrYMoex4uDc6SwNjLvruhg5OSQETCS+
        fGxg6WLk4hAS2M0o8e3RUkaIhKTEtItHmbsYOYBsYYnDh4shat4ySqy8858FpEZYIFBi4t1O
        NhBbREBNYvnRP6wgRcwCm5kkzp5azQbR0cMk8WpvI9hUNgEtif0vboB18AsoSlz98Rgszitg
        J/HtbyMriM0ioCqxa9YpZhBbVCBC4vCOWVA1ghInZz4B28wpoCfR/fY+O4jNLKAu8WfeJWYI
        W1zi1pP5TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07M
        LS7NS9dLzs/dxAiOMy3NHYyXl8QfYhTgYFTi4Q3INYgVYk0sK67MPcQowcGsJMJ7+6V+rBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MK/qOXGw7Z8rY
        H3x02bvdz/Wus6h8WLXX7TjbxEZpkYbmnEixBXbP31wNYP07/3VluDuznsfuf1e2RJ8QEt/I
        qaE9b5XJnNulhgcXWD6b78rBUmYXFGB5qibkpw3PlTfPnq/dcuLAIdszqyWDaqbMut2e+zg7
        fcf75LKviz6+VhSZ1JZ26HV5jRJLcUaioRZzUXEiAIZkmSevAgAA
X-CMS-MailID: 20190719012808epcas1p119a1c09b7a819bc36b0835b590ebd69b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223647epcas5p4eecd38dad5a5c12300f9e1945f3d07fe
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223647epcas5p4eecd38dad5a5c12300f9e1945f3d07fe@epcas5p4.samsung.com>
        <20190707223303.6755-6-digetx@gmail.com>
        <9efb75fe-994f-24c7-7872-b5e5041105a6@samsung.com>
        <20190719030058.617de581@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 9:00, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 19:17:17 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> The current implementation is inaccurate and results in very
>>> intensive interrupt activity, which neglects the whole idea of
>>> polling offload to hardware. The reason of the shortcoming is that
>>> watermarks are not set up correctly and this results in ACTMON
>>> constantly asking to change freq and then these requests are
>>> ignored. The end result of this patch is that there are few
>>> hundreds of ACTMON's interrupts instead of tens thousands after few
>>> minutes of a working devfreq, meanwhile the transitions activity
>>> stays about the same and governor becomes more reactive.
>>>
>>> Since watermarks are set precisely correct now, the boosting logic
>>> is changed a tad to accommodate the change. The "average sustain
>>> coefficient" multiplier is gone now since there is no need to
>>> compensate the improper watermarks and EMC frequency-bump happens
>>> once boosting hits the upper watermark enough times, depending on
>>> the per-device boosting threshold.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 293
>>> +++++++++++++++++++++--------- 1 file changed, 209 insertions(+),
>>> 84 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c index
>>> 4be7858c33bc..16f7e6cf3b99 100644 ---
>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>> b/drivers/devfreq/tegra30-devfreq.c @@ -47,6 +47,8 @@
>>>  
>>>  #define ACTMON_DEV_INTR_CONSECUTIVE_UPPER
>>> BIT(31) #define
>>> ACTMON_DEV_INTR_CONSECUTIVE_LOWER			BIT(30)
>>> +#define
>>> ACTMON_DEV_INTR_AVG_BELOW_WMARK
>>> BIT(25) +#define
>>> ACTMON_DEV_INTR_AVG_ABOVE_WMARK
>>> BIT(24) #define
>>> ACTMON_ABOVE_WMARK_WINDOW				1 #define
>>> ACTMON_BELOW_WMARK_WINDOW				3 @@ -63,9
>>> +65,8 @@
>>>   * ACTMON_AVERAGE_WINDOW_LOG2: default value for @DEV_CTRL_K_VAL,
>>> which
>>>   * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
>>>   */
>>> -#define ACTMON_AVERAGE_WINDOW_LOG2			6
>>> -#define ACTMON_SAMPLING_PERIOD
>>> 12 /* ms */ -#define
>>> ACTMON_DEFAULT_AVG_BAND				6  /* 1/10
>>> of % */ +#define
>>> ACTMON_AVERAGE_WINDOW_LOG2				6
>>> +#define
>>> ACTMON_SAMPLING_PERIOD					12 /*
>>> ms */ #define
>>> KHZ							1000 @@
>>> -142,9 +143,6 @@ struct tegra_devfreq_device {
>>>  	 * watermark breaches.
>>>  	 */
>>>  	unsigned long boost_freq;
>>> -
>>> -	/* Optimal frequency calculated from the stats for this
>>> device */
>>> -	unsigned long target_freq;
>>>  };
>>>  
>>>  struct tegra_devfreq {
>>> @@ -156,7 +154,6 @@ struct tegra_devfreq {
>>>  
>>>  	struct clk		*emc_clock;
>>>  	unsigned long		max_freq;
>>> -	unsigned long		cur_freq;
>>>  	struct notifier_block	rate_change_nb;
>>>  
>>>  	struct tegra_devfreq_device
>>> devices[ARRAY_SIZE(actmon_device_configs)]; @@ -205,42 +202,182 @@
>>> static unsigned long do_percent(unsigned long val, unsigned int
>>> pct) return val * pct / 100; }
>>>  
>>> +static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq
>>> *tegra) +{
>>> +	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
>>> +	unsigned int cpu_freq = cpufreq_get(0);
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++,
>>> ratio++) {
>>> +		if (cpu_freq >= ratio->cpu_freq) {
>>> +			if (ratio->emc_freq >= tegra->max_freq)
>>> +				return tegra->max_freq;
>>> +			else
>>> +				return ratio->emc_freq;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static unsigned long
>>> +tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>>> +			      struct tegra_devfreq_device *dev,
>>> +			      unsigned long target_freq)
>>> +{
>>> +	unsigned long static_cpu_emc_freq;
>>> +
>>> +	if (dev->config->avg_dependency_threshold &&
>>> +	    dev->config->avg_dependency_threshold <
>>> dev->avg_count) {
>>> +		static_cpu_emc_freq =
>>> actmon_cpu_to_emc_rate(tegra);
>>> +		target_freq = max(target_freq,
>>> static_cpu_emc_freq);
>>> +	}
>>> +
>>> +	return target_freq;
>>> +}
>>> +
>>> +static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq
>>> *tegra,
>>> +					     unsigned long
>>> target_freq) +{
>>> +	unsigned long lower = target_freq;
>>> +	struct dev_pm_opp *opp;
>>> +
>>> +	opp =
>>> dev_pm_opp_find_freq_floor(tegra->devfreq->dev.parent, &lower);
>>> +	if (IS_ERR(opp))
>>> +		lower = 0;
>>> +	else
>>> +		dev_pm_opp_put(opp);
>>> +
>>> +	return lower;
>>> +}
>>> +
>>> +static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq
>>> *tegra,
>>> +					     unsigned long
>>> target_freq) +{
>>> +	unsigned long upper = target_freq + 1;
>>> +	struct dev_pm_opp *opp;
>>> +
>>> +	opp =
>>> dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
>>> +	if (IS_ERR(opp))
>>> +		upper = ULONG_MAX;
>>> +	else
>>> +		dev_pm_opp_put(opp);
>>> +
>>> +	return upper;
>>> +}
>>> +
>>> +static void tegra_actmon_get_lower_upper(struct tegra_devfreq
>>> *tegra,
>>> +					 struct
>>> tegra_devfreq_device *dev,
>>> +					 unsigned long target_freq,
>>> +					 unsigned long *lower,
>>> +					 unsigned long *upper)
>>> +{
>>> +	/*
>>> +	 * Memory frequencies are guaranteed to have 1MHz
>>> granularity
>>> +	 * and thus we need this rounding down to get a proper
>>> watermarks
>>> +	 * range in a case where target_freq falls into a range of
>>> +	 * next_possible_opp_freq - 1MHz.
>>> +	 */
>>> +	target_freq = round_down(target_freq, 1000000);
>>> +
>>> +	/* watermarks are set at the borders of the corresponding
>>> OPPs */
>>> +	*lower = tegra_actmon_lower_freq(tegra, target_freq);
>>> +	*upper = tegra_actmon_upper_freq(tegra, target_freq);
>>> +
>>> +	*lower /= KHZ;
>>> +	*upper /= KHZ;
>>> +
>>> +	/*
>>> +	 * The upper watermark should take into account CPU's
>>> frequency
>>> +	 * because cpu_to_emc_rate() may override the target_freq
>>> with
>>> +	 * a higher value and thus upper watermark need to be set
>>> up
>>> +	 * accordingly to avoid parasitic upper-events.
>>> +	 */
>>> +	*upper = tegra_actmon_account_cpu_freq(tegra, dev, *upper);
>>> +
>>> +	*lower *= ACTMON_SAMPLING_PERIOD;
>>> +	*upper *= ACTMON_SAMPLING_PERIOD;
>>> +}
>>> +
>>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
>>> *tegra, struct tegra_devfreq_device *dev)
>>>  {
>>> -	u32 avg = dev->avg_count;
>>> -	u32 avg_band_freq = tegra->max_freq *
>>> ACTMON_DEFAULT_AVG_BAND / KHZ;
>>> -	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
>>> +	unsigned long lower, upper, freq;
>>>  
>>> -	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
>>> +	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
>>> +	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower,
>>> &upper); 
>>> -	avg = max(dev->avg_count, band);
>>> -	device_writel(dev, avg - band, ACTMON_DEV_AVG_LOWER_WMARK);
>>> +	/*
>>> +	 * We want to get interrupts when MCCPU client crosses the
>>> +	 * dependency threshold in order to take into / out of
>>> account
>>> +	 * the CPU's freq.
>>> +	 */
>>> +	if (lower < dev->config->avg_dependency_threshold &&
>>> +	    upper > dev->config->avg_dependency_threshold) {
>>> +		if (dev->avg_count <
>>> dev->config->avg_dependency_threshold)
>>> +			upper =
>>> dev->config->avg_dependency_threshold;
>>> +		else
>>> +			lower =
>>> dev->config->avg_dependency_threshold;
>>> +	}
>>> +
>>> +	device_writel(dev, lower, ACTMON_DEV_AVG_LOWER_WMARK);
>>> +	device_writel(dev, upper, ACTMON_DEV_AVG_UPPER_WMARK);
>>>  }
>>>  
>>>  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>> -				       struct tegra_devfreq_device
>>> *dev)
>>> +				       struct tegra_devfreq_device
>>> *dev,
>>> +				       unsigned long freq)
>>>  {
>>> -	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
>>> +	unsigned long lower, upper, delta;
>>> +
>>> +	/*
>>> +	 * Boosting logic kicks-in once lower / upper watermark is
>>> hit.
>>> +	 * The watermarks are based on the updated EMC rate and the
>>> +	 * average activity.
>>> +	 *
>>> +	 * The higher watermark is set in accordance to the EMC
>>> rate
>>> +	 * because we want to set it to the highest mark here and
>>> EMC rate
>>> +	 * represents that mark. The consecutive-upper interrupts
>>> are
>>> +	 * always enabled and we don't want to receive them if
>>> they won't
>>> +	 * do anything useful, hence the upper watermark is capped
>>> to maximum.
>>> +	 * Note that the EMC rate is changed once boosting pushed
>>> the rate
>>> +	 * too high, in that case boosting-up will be stopped
>>> because
>>> +	 * upper watermark is much higher now and it is
>>> *important* to
>>> +	 * stop the unwanted interrupts.
>>> +	 */
>>> +	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower,
>>> &upper); +
>>> +	delta = do_percent(upper - lower,
>>> dev->config->boost_up_threshold);
>>> +	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
>>>  
>>> -	device_writel(dev, do_percent(val,
>>> dev->config->boost_up_threshold),
>>> -		      ACTMON_DEV_UPPER_WMARK);
>>> +	/*
>>> +	 * Meanwhile the lower mark is based on the average value
>>> +	 * because it is the lowest possible consecutive-mark for
>>> this
>>> +	 * device. Once that mark is hit and boosting is stopped,
>>> the
>>> +	 * interrupt is disabled by ISR.
>>> +	 */
>>> +	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
>>> +	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower,
>>> &upper); 
>>> -	device_writel(dev, do_percent(val,
>>> dev->config->boost_down_threshold),
>>> -		      ACTMON_DEV_LOWER_WMARK);
>>> +	delta = do_percent(upper - lower,
>>> dev->config->boost_down_threshold);
>>> +	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
>>>  }
>>>  
>>>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>>>  			      struct tegra_devfreq_device *dev)
>>>  {
>>> -	u32 intr_status, dev_ctrl;
>>> +	u32 intr_status, dev_ctrl, avg_intr_mask;
>>>  
>>>  	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>> -	tegra_devfreq_update_avg_wmark(tegra, dev);
>>> -
>>>  	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
>>>  	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
>>>  
>>> +	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
>>> +			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
>>> +
>>> +	if (intr_status & avg_intr_mask)
>>> +		tegra_devfreq_update_avg_wmark(tegra, dev);
>>> +
>>>  	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
>>>  		/*
>>>  		 * new_boost = min(old_boost * up_coef + step,
>>> max_freq) @@ -253,8 +390,6 @@ static void actmon_isr_device(struct
>>> tegra_devfreq *tegra, 
>>>  		if (dev->boost_freq >= tegra->max_freq)
>>>  			dev->boost_freq = tegra->max_freq;
>>> -		else
>>> -			dev_ctrl |=
>>> ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN; } else if (intr_status
>>> & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) { /*
>>>  		 * new_boost = old_boost * down_coef
>>> @@ -263,63 +398,37 @@ static void actmon_isr_device(struct
>>> tegra_devfreq *tegra, dev->boost_freq = do_percent(dev->boost_freq,
>>>  					     dev->config->boost_down_coeff);
>>>  
>>> -		dev_ctrl |=
>>> ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN; -
>>>  		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >>
>>> 1)) dev->boost_freq = 0;
>>> -		else
>>> -			dev_ctrl |=
>>> ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN; }
>>>  
>>> -	if (dev->config->avg_dependency_threshold) {
>>> -		if (dev->avg_count >=
>>> dev->config->avg_dependency_threshold)
>>> -			dev_ctrl |=
>>> ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>>> -		else if (dev->boost_freq == 0)
>>> -			dev_ctrl &=
>>> ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>>> +	if (intr_status & avg_intr_mask) {
>>> +		/*
>>> +		 * Once average watermark is hit, it means that
>>> the memory
>>> +		 * activity changed significantly and thus
>>> boosting-up shall
>>> +		 * be reset because EMC clock rate will be changed
>>> and
>>> +		 * boosting will restart in this case.
>>> +		 */
>>> +		dev->boost_freq = 0;
>>>  	}
>>>  
>>> -	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>>> +	/* no boosting => no need for consecutive-down interrupt */
>>> +	if (dev->boost_freq == 0)
>>> +		dev_ctrl &=
>>> ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN; 
>>> +	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>>>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>> ACTMON_DEV_INTR_STATUS); }
>>>  
>>> -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq
>>> *tegra,
>>> -					    unsigned long cpu_freq)
>>> -{
>>> -	unsigned int i;
>>> -	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
>>> -
>>> -	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++,
>>> ratio++) {
>>> -		if (cpu_freq >= ratio->cpu_freq) {
>>> -			if (ratio->emc_freq >= tegra->max_freq)
>>> -				return tegra->max_freq;
>>> -			else
>>> -				return ratio->emc_freq;
>>> -		}
>>> -	}
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -static void actmon_update_target(struct tegra_devfreq *tegra,
>>> -				 struct tegra_devfreq_device *dev)
>>> +static unsigned long actmon_update_target(struct tegra_devfreq
>>> *tegra,
>>> +					  struct
>>> tegra_devfreq_device *dev) {
>>> -	unsigned long cpu_freq = 0;
>>> -	unsigned long static_cpu_emc_freq = 0;
>>> -	unsigned int avg_sustain_coef;
>>> -
>>> -	if (dev->config->avg_dependency_threshold) {
>>> -		cpu_freq = cpufreq_get(0);
>>> -		static_cpu_emc_freq =
>>> actmon_cpu_to_emc_rate(tegra, cpu_freq);
>>> -	}
>>> +	unsigned long target_freq;
>>>  
>>> -	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>>> -	avg_sustain_coef = 100 * 100 /
>>> dev->config->boost_up_threshold;
>>> -	dev->target_freq = do_percent(dev->target_freq,
>>> avg_sustain_coef);
>>> -	dev->target_freq += dev->boost_freq;
>>> +	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD +
>>> dev->boost_freq;
>>> +	target_freq = tegra_actmon_account_cpu_freq(tegra, dev,
>>> target_freq); 
>>> -	if (dev->avg_count >=
>>> dev->config->avg_dependency_threshold)
>>> -		dev->target_freq = max(dev->target_freq,
>>> static_cpu_emc_freq);
>>> +	return target_freq;
>>>  }
>>>  
>>>  static irqreturn_t actmon_thread_isr(int irq, void *data)
>>> @@ -351,8 +460,8 @@ static int tegra_actmon_rate_notify_cb(struct
>>> notifier_block *nb, unsigned long action, void *ptr)
>>>  {
>>>  	struct clk_notifier_data *data = ptr;
>>> -	struct tegra_devfreq *tegra;
>>>  	struct tegra_devfreq_device *dev;
>>> +	struct tegra_devfreq *tegra;
>>>  	unsigned int i;
>>>  
>>>  	if (action != POST_RATE_CHANGE)
>>> @@ -360,12 +469,28 @@ static int tegra_actmon_rate_notify_cb(struct
>>> notifier_block *nb, 
>>>  	tegra = container_of(nb, struct tegra_devfreq,
>>> rate_change_nb); 
>>> -	tegra->cur_freq = data->new_rate / KHZ;
>>> -
>>> +	/*
>>> +	 * EMC rate could change due to three reasons:
>>> +	 *
>>> +	 *    1. Average watermark hit
>>> +	 *    2. Boosting overflow
>>> +	 *    3. CPU freq change
>>> +	 *
>>> +	 * Once rate is changed, the consecutive watermarks need
>>> to be
>>> +	 * updated in order for boosting to work properly and to
>>> avoid
>>> +	 * unnecessary interrupts. Note that the consecutive range
>>> is set for
>>> +	 * all of devices using the same rate, hence if CPU is
>>> doing much
>>> +	 * less than the other memory clients, then its upper
>>> watermark will
>>> +	 * be very high in comparison to the actual activity
>>> (lower watermark)
>>> +	 * and thus unnecessary upper-interrupts will be
>>> suppressed.
>>> +	 *
>>> +	 * The average watermarks also should be updated because
>>> of 3.
>>> +	 */
>>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>>  		dev = &tegra->devices[i];
>>>  
>>> -		tegra_devfreq_update_wmark(tegra, dev);
>>> +		tegra_devfreq_update_avg_wmark(tegra, dev);
>>> +		tegra_devfreq_update_wmark(tegra, dev,
>>> data->new_rate); }
>>>  
>>>  	return NOTIFY_OK;
>>> @@ -374,15 +499,14 @@ static int tegra_actmon_rate_notify_cb(struct
>>> notifier_block *nb, static void
>>> tegra_actmon_configure_device(struct tegra_devfreq *tegra, struct
>>> tegra_devfreq_device *dev) {
>>> -	u32 val = 0;
>>> -
>>> -	dev->target_freq = tegra->cur_freq;
>>> +	u32 val = 0, target_freq;
>>>  
>>> -	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
>>> +	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>>> +	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
>>>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>>>  
>>>  	tegra_devfreq_update_avg_wmark(tegra, dev);
>>> -	tegra_devfreq_update_wmark(tegra, dev);
>>> +	tegra_devfreq_update_wmark(tegra, dev, target_freq);
>>>  
>>>  	device_writel(dev, ACTMON_COUNT_WEIGHT,
>>> ACTMON_DEV_COUNT_WEIGHT); device_writel(dev,
>>> ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS); @@ -469,13
>>> +593,13 @@ static int tegra_devfreq_get_dev_status(struct device
>>> *dev, struct tegra_devfreq_device *actmon_dev; unsigned long
>>> cur_freq; 
>>> -	cur_freq = READ_ONCE(tegra->cur_freq);
>>> +	cur_freq = clk_get_rate(tegra->emc_clock);
>>>  
>>>  	/* To be used by the tegra governor */
>>>  	stat->private_data = tegra;
>>>  
>>>  	/* The below are to be used by the other governors */
>>> -	stat->current_frequency = cur_freq * KHZ;
>>> +	stat->current_frequency = cur_freq;
>>>  
>>>  	actmon_dev = &tegra->devices[MCALL];
>>>  
>>> @@ -486,7 +610,7 @@ static int tegra_devfreq_get_dev_status(struct
>>> device *dev, stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>>  
>>>  	/* Number of cycles in a sampling period */
>>> -	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>>> +	stat->total_time = cur_freq / KHZ * ACTMON_SAMPLING_PERIOD;
>>>  
>>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>>  
>>> @@ -505,6 +629,7 @@ static int tegra_governor_get_target(struct
>>> devfreq *devfreq, struct devfreq_dev_status *stat;
>>>  	struct tegra_devfreq *tegra;
>>>  	struct tegra_devfreq_device *dev;
>>> +	unsigned long dev_target_freq;
>>>  	unsigned long target_freq = 0;
>>>  	unsigned int i;
>>>  	int err;
>>> @@ -520,9 +645,9 @@ static int tegra_governor_get_target(struct
>>> devfreq *devfreq, for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>>  		dev = &tegra->devices[i];
>>>  
>>> -		actmon_update_target(tegra, dev);
>>> +		dev_target_freq = actmon_update_target(tegra, dev);
>>>  
>>> -		target_freq = max(target_freq, dev->target_freq);
>>> +		target_freq = max(target_freq, dev_target_freq);
>>>  	}
>>>  
>>>  	*freq = target_freq * KHZ;
>>> @@ -642,7 +767,6 @@ static int tegra_devfreq_probe(struct
>>> platform_device *pdev) return rate;
>>>  	}
>>>  
>>> -	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>>>  	tegra->max_freq = rate / KHZ;
>>>  
>>>  	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
>>> @@ -671,7 +795,8 @@ static int tegra_devfreq_probe(struct
>>> platform_device *pdev) platform_set_drvdata(pdev, tegra);
>>>  
>>>  	tegra->rate_change_nb.notifier_call =
>>> tegra_actmon_rate_notify_cb;
>>> -	err = clk_notifier_register(tegra->emc_clock,
>>> &tegra->rate_change_nb);
>>> +	err = clk_notifier_register(tegra->emc_clock,
>>> +				    &tegra->rate_change_nb);
>>>  	if (err) {
>>>  		dev_err(&pdev->dev,
>>>  			"Failed to register rate change
>>> notifier\n"); 
>>
>>
>> Maybe, it is possible to merge patch4/patch19/patch20 to one patch.
> 
> All these three patches are completely separate changes, thus they
> should be kept separate.
> 

I replied on patch19 why it is possible to merge patch5 and patch19.
Please check my comment.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

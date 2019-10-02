Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C62C44AD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 01:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfJAX54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 19:57:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23805 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfJAX54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 19:57:56 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191001235753epoutp014ef54577e29aca2d4c9570d02f741218~Jq0idoe130665706657epoutp01b
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 23:57:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191001235753epoutp014ef54577e29aca2d4c9570d02f741218~Jq0idoe130665706657epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569974273;
        bh=JA2P+u/KMHx3gtTsOXg+j5fJB1J2DEdBhtl374G38qM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Mvi5jcMU1l+Y7hba1eTdmX7Q5r4/mhNThy4gmP4+kkt7Byb0K+9w0cRBH4Zz99IOL
         INhAqZr5Nfwc74m0gsxLS5eMHlxw7Oh0lzACnhNLKcWnwAzVSQTFkfOHKokGefDHQ7
         uvKrTbb5xXghlVkKNRHcj/RJEgYrZdvJchubke/Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191001235752epcas1p2009ac43a6d657ab40b1d42a77735f365~Jq0hLiVgT1742817428epcas1p2Q;
        Tue,  1 Oct 2019 23:57:52 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46jbms53fCzMqYkc; Tue,  1 Oct
        2019 23:57:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.25.04144.7F7E39D5; Wed,  2 Oct 2019 08:57:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191001235742epcas1p36bee3cd61a11e47d49a0f410621c8ec2~Jq0YhH4GV0430604306epcas1p3L;
        Tue,  1 Oct 2019 23:57:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001235742epsmtrp139a2e30c726c38f468d141ab0932a39a~Jq0YgXTjS1779417794epsmtrp1O;
        Tue,  1 Oct 2019 23:57:42 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-af-5d93e7f776f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.54.04081.6F7E39D5; Wed,  2 Oct 2019 08:57:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001235742epsmtip18f2e2de214307f6f8747c181f057c7b4~Jq0YT89QB2049920499epsmtip1Q;
        Tue,  1 Oct 2019 23:57:42 +0000 (GMT)
Subject: Re: [PATCH v6 11/19] PM / devfreq: tegra30: Use CPUFreq notifier
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
Message-ID: <2f7a0283-7433-b786-a8c3-7d711aafd721@samsung.com>
Date:   Wed, 2 Oct 2019 09:02:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-12-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3cf1Gq3epuVpRNnVPwnmrmt2Ddc3Y1E/pCKyULu52yb7ZHez
        MgqnUWppphY0SyUdVlNWpuIMM1SIgsISSxJJ0sgijMy+UKJt18h/zznnec45z/seUixvIRRk
        rtXJOaysmSIWSTr61ikTf36oylT6H8gY39dxxJz13JQwzwo/RzCDXdcJ5ltZP2JKZjwEM+K+
        RTC/u2olTHnLS2JrpK5ztBHpAp7RCF1Z0RShK2+7g3TfWlenSw+Z0owcq+ccsZw1x6bPtRo0
        1O592Tuy1SlKOpFOZTZSsVbWwmmonXvSE7W55uBCVGwea3YFU+ksz1NJm9McNpeTizXaeKeG
        4ux6sz3Vvp5nLbzLalifY7NsopXKZHWQeMRkLPf3I3vTjhPdE4kFqCKlFEWSgDfAwK1HolK0
        iJTjTgSdv67MB9MIvs+5I4TgBwJ/v1dcisiwZKg5rJbjbgTVFzQC5wuCmh8tKFSIwrug8v5g
        uFM0/oOg5HcRESqIcQb0BXyiECZwAvRMDofzS/FaGPo1HhbL8GZwB7rDHAmOh4a5V2G8HB+E
        6bE+qcBZBk+uTUhCOBJvhOqH9VKhfwy8magTCXgNFLXXiENLAJ4l4ObIZangYCf4H5wW/EfB
        p8dtEQJWwMdL5+bxKbj9pJ8QtMUI2noGpEJBBT3eKlGojxivA39XkpBeC4HZG0iYuwSmvl+c
        HyWD4nNygRIHg2OjIgGvhIbzJUQFojwL3HgWOPAscOD5P6weSe6gFZydtxg4nrbTC/+6FYVP
        NUHdiaqf7+lFmETUYtnw/qpMuZTN409aehGQYipaljZXmSmX6dmT+ZzDlu1wmTm+F6mDj31Z
        rFieYwsevtWZTauTVSoVs4FOUdM0FSPTGQoy5djAOjkTx9k5xz+diIxUFCA+f3tT8ouA5chW
        /bGp8Tqv/36qtjBjpS+prLGivbiptWnLsnu4sEE1o3p3nvTZ4lQD99y7P1zNR9tkq469d+mP
        m2rb1VO3Y1xZPaaOGu3bCxXaLG9WVscB19DLyb3t8dqh3omj00/P3J0+tDRN77572FspH4s6
        vPr1Gs+r2ebHPCXhjSydIHbw7F9F12n0wAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO6355NjDVa/1rJY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DK6Ft/hLFguXPF3ie6DYwTzLoYOTgkBEwkrq4B
        Mrk4hAR2M0p8urKUsYuREyguKTHt4lFmiBphicOHiyFq3jJKPN77HqxGWMBTYtLmy0wgCRGB
        JiaJTb0X2EESzAKREj1zt7BBdGxjlLh3F8Th5GAT0JLY/+IGmM0voChx9cdjsEm8AnYSjTv3
        MoHYLAIqEov/XAOzRQUiJA7vmAVVIyhxcuYTFhCbU8BcYsq+BawQy9Ql/sy7xAxhi0vcejKf
        CcKWl2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ
        +bmbGMERpqW5g/HykvhDjAIcjEo8vA1Bk2OFWBPLiitzDzFKcDArifDa/JkUK8SbklhZlVqU
        H19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVANjAcspw7iqjh07D4d/SZix
        bt/u1fkZxWnC95WLny/qfsx1seFmNceaFZJTHuemPczvaG463aQxcVImD1/KXE2TfN+6Bd1m
        jlpiSUfCZx1Pil+YeldI4I640Zvad2YikikMWzfWSL+K7RTc7OY1VZZL68Rqax/XCvuv8xcd
        mMTenZUouOuZd7ISS3FGoqEWc1FxIgA8syQ8rAIAAA==
X-CMS-MailID: 20191001235742epcas1p36bee3cd61a11e47d49a0f410621c8ec2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212534epcas4p415e9206019385d2bfb3be2c7a328a8df
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212534epcas4p415e9206019385d2bfb3be2c7a328a8df@epcas4p4.samsung.com>
        <20190811212315.12689-12-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
> The CPU's client need to take into account that CPUFreq may change
> while memory activity not, staying high. Thus an appropriate frequency
> notifier should be used in addition to the clk-notifier.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 173 ++++++++++++++++++++++++++----
>  1 file changed, 153 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index a2623de56d20..a260812f7744 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/reset.h>
> +#include <linux/workqueue.h>
>  
>  #include "governor.h"
>  
> @@ -34,6 +35,8 @@
>  #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
>  #define ACTMON_DEV_CTRL_ENB					BIT(31)
>  
> +#define ACTMON_DEV_CTRL_STOP					0x00000000
> +
>  #define ACTMON_DEV_UPPER_WMARK					0x4
>  #define ACTMON_DEV_LOWER_WMARK					0x8
>  #define ACTMON_DEV_INIT_AVG					0xc
> @@ -159,7 +162,10 @@ struct tegra_devfreq {
>  
>  	struct clk		*emc_clock;
>  	unsigned long		max_freq;
> -	struct notifier_block	rate_change_nb;
> +	struct notifier_block	clk_rate_change_nb;
> +
> +	struct delayed_work	cpufreq_update_work;
> +	struct notifier_block	cpu_rate_change_nb;
>  
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>  
> @@ -207,10 +213,10 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
>  	return val * pct / 100;
>  }
>  
> -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
> +static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
> +					    unsigned int cpu_freq)
>  {
>  	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
> -	unsigned int cpu_freq = cpufreq_quick_get(0);
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
> @@ -244,7 +250,8 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>  		return target_freq;
>  
>  	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
> -		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
> +		static_cpu_emc_freq = actmon_cpu_to_emc_rate(
> +						tegra, cpufreq_quick_get(0));
>  	else
>  		static_cpu_emc_freq = 0;
>  
> @@ -543,8 +550,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> -static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
> -				       unsigned long action, void *ptr)
> +static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
> +				      unsigned long action, void *ptr)
>  {
>  	struct clk_notifier_data *data = ptr;
>  	struct tegra_devfreq_device *dev;
> @@ -555,7 +562,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	if (action != POST_RATE_CHANGE)
>  		return NOTIFY_OK;
>  
> -	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
> +	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
>  
>  	freq = data->new_rate / KHZ;
>  
> @@ -586,6 +593,94 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static void tegra_actmon_delayed_update(struct work_struct *work)
> +{
> +	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
> +						   cpufreq_update_work.work);
> +
> +	mutex_lock(&tegra->devfreq->lock);
> +	update_devfreq(tegra->devfreq);
> +	mutex_unlock(&tegra->devfreq->lock);
> +}
> +
> +static unsigned long
> +tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
> +				  unsigned int cpu_freq)
> +{
> +	unsigned long freq, static_cpu_emc_freq;
> +
> +	/* check whether CPU's freq is taken into account at all */
> +	freq = tegra_actmon_dev_avg_dependency_freq(tegra,
> +						    &tegra->devices[MCCPU]);
> +	if (tegra->devices[MCCPU].avg_freq <= freq)
> +		return 0;
> +
> +	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
> +
> +	/* compare static CPU-EMC freq with MCALL */
> +	freq = tegra->devices[MCALL].avg_freq +
> +	       tegra->devices[MCALL].boost_freq;
> +
> +	freq = tegra_actmon_upper_freq(tegra, freq);
> +
> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
> +		return 0;
> +
> +	/* compare static CPU-EMC freq with MCCPU */
> +	freq = tegra->devices[MCCPU].avg_freq +
> +	       tegra->devices[MCCPU].boost_freq;
> +
> +	freq = tegra_actmon_upper_freq(tegra, freq);
> +
> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
> +		return 0;
> +
> +	return static_cpu_emc_freq;
> +}
> +
> +static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
> +				      unsigned long action, void *ptr)
> +{
> +	struct cpufreq_freqs *freqs = ptr;
> +	struct tegra_devfreq *tegra;
> +	unsigned long old, new, delay;
> +
> +	if (action != CPUFREQ_POSTCHANGE)
> +		return NOTIFY_OK;
> +
> +	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
> +
> +	/*
> +	 * Quickly check whether CPU frequency should be taken into account
> +	 * at all, without blocking CPUFreq's core.
> +	 */
> +	if (mutex_trylock(&tegra->devfreq->lock)) {
> +		old = tegra_actmon_cpufreq_contribution(tegra, freqs->old);
> +		new = tegra_actmon_cpufreq_contribution(tegra, freqs->new);
> +		mutex_unlock(&tegra->devfreq->lock);
> +
> +		/*
> +		 * If CPU's frequency shouldn't be taken into account at
> +		 * the moment, then there is no need to update the devfreq's
> +		 * state because ISR will re-check CPU's frequency on the
> +		 * next interrupt.
> +		 */
> +		if (old == new)
> +			return NOTIFY_OK;
> +	}
> +
> +	/*
> +	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
> +	 * to allow asynchronous notifications. This means we can't block
> +	 * here for too long, otherwise CPUFreq's core will complain with a
> +	 * warning splat.
> +	 */
> +	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
> +	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  					  struct tegra_devfreq_device *dev)
>  {
> @@ -617,9 +712,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  	device_writel(dev, val, ACTMON_DEV_CTRL);
>  }
>  
> -static void tegra_actmon_start(struct tegra_devfreq *tegra)
> +static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
> +{
> +	device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
> +	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
> +}
> +
> +static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  {
>  	unsigned int i;
> +	int err;
>  
>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
> @@ -627,7 +729,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>  		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
>  
> +	/*
> +	 * We are estimating CPU's memory bandwidth requirement based on
> +	 * amount of memory accesses and system's load, judging by CPU's
> +	 * frequency. We also don't want to receive events about CPU's
> +	 * frequency transaction when governor is stopped, hence notifier
> +	 * is registered dynamically.
> +	 */
> +	err = cpufreq_register_notifier(&tegra->cpu_rate_change_nb,
> +					CPUFREQ_TRANSITION_NOTIFIER);
> +	if (err) {
> +		dev_err(tegra->devfreq->dev.parent,
> +			"Failed to register rate change notifier: %d\n", err);
> +		goto err_stop;
> +	}
> +
>  	enable_irq(tegra->irq);
> +
> +	return 0;
> +
> +err_stop:
> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
> +		tegra_actmon_stop_device(&tegra->devices[i]);

nitpick:
Why don't you contain this for loop statement in the tegra_actmon_stop_device()?
I think that you can make it as following:

	tegra_actmon_stop_device(struct tegra_devfreq *target);
		for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)> +				
			device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);              
			device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS); 

Except for this, looks good to me. 
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

(snip)


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D681C44CC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfJBANv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 20:13:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:30751 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJBANv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 20:13:51 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191002001347epoutp01b89504ff8e8490194573c0833ca6362e~JrCanBbIa2257322573epoutp01i
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 00:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191002001347epoutp01b89504ff8e8490194573c0833ca6362e~JrCanBbIa2257322573epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569975227;
        bh=cZleCx6C90T5L2JKqTjIk2QjcIaG98wQOYNppwhBHCg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FoQz9hiXHUdwrEconDGTIK/fa3VL84ewW+JzRnxF3URXskmEqlW/LZKwST3NN6Tqn
         LtgQvhn0LvF47qIa2TRy0Z9r+LmodagT6pSxZVessktX58+cfMw4gmDBQgBROeN2Pd
         Qzb8xjx/2Zh7xFLWNac0CKv0iikU91ynRKofeCSY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191002001346epcas1p127ae6286340d66b3ad3c2d1dfffce572~JrCZ3Lw2b1651816518epcas1p1S;
        Wed,  2 Oct 2019 00:13:46 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46jc7C72yRzMqYkg; Wed,  2 Oct
        2019 00:13:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.88.04135.7BBE39D5; Wed,  2 Oct 2019 09:13:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191002001343epcas1p3cd70c7b729378103a969cefd3fd37f2d~JrCXY4TTr1657116571epcas1p3S;
        Wed,  2 Oct 2019 00:13:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002001343epsmtrp263b06e033bd32e557f4c17e1bdc3743c~JrCXYHBLZ0621306213epsmtrp2e;
        Wed,  2 Oct 2019 00:13:43 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-36-5d93ebb78702
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.85.03889.7BBE39D5; Wed,  2 Oct 2019 09:13:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191002001343epsmtip119dec1a9a5c363bbe16b074998b796e5~JrCXL2Jps2266422664epsmtip1b;
        Wed,  2 Oct 2019 00:13:43 +0000 (GMT)
Subject: Re: [PATCH v6 18/19] PM / devfreq: tegra30: Support variable
 polling interval
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
Message-ID: <721c4dd0-d667-f83d-64b5-74e4b58a7a1c@samsung.com>
Date:   Wed, 2 Oct 2019 09:18:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-19-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRj27Z49bcbyWaVXGrbDD1LZ09o6qAZRazSjkUsua51pz2xpb3PO
        FvFDZFIol2hYYacQuY2EaqRRkX5ojMuMWyNTM4xMKIQMds9h9O/5nud5r9+rlKsvkcHKTLuL
        4+2slSJHEtdbpmsjbvSWGrW1h2OY85+6EbPTXUEw93e892MeNZSTzEBxK2KKPrtJ5sX2syTz
        veEEwZRcfEjO8zfUdZ5Chnp3p5+hOL+PNJTUViPDQM2kFMWarNgMjjVzvIazpzvMmXZLHLUk
        1ZRg0kdr6Qh6NhNDaeysjYujFianRCRmWr0NUZoc1prtpVJYQaBmxsfyjmwXp8lwCK44inOa
        rc7ZzkiBtQnZdktkusM2h9Zqo/Re44asjCsl450/4jf/Lr8ry0Nu3W7krwQ8C55fbpHtRiOV
        alyHoKPbI/MJatyPoPxBriR8RdB+oc4rKMWII4NGiW9E8Pb3OSQ9PiCo7r9O+qLH4TTw3B6S
        +4QA/AtB0fd8UZDj1dBSf14sQeIwaHr7VOTH4FB48q0b+bAKx0Pj62eEDxN4KvSeOSr6A71J
        +7taFJJnLLQf7RE9/jgGCnqbZFL+IHjec/Ivngz5146JTQAeIuHYm0G5NPRCuFrcQUp4HLxr
        q/WTcDAM9DX+5bfCufZWUgouRFDb9EAhCTpoOl0q7kKOp8PlhpkSHQr1Q8eRVHg09H3Zq5DW
        pYLCArVkmQKPujplEp4AlbuKyP2Icg8bxz1sBPewEdz/i3kQUY3Gc07BZuEE2hk1/LNrkHir
        YdF1qKIjuRlhJaJGqZ4uLzWqFWyOkGtrRqCUUwGq2J8HjWqVmc3dwvEOE59t5YRmpPdu+4A8
        ODDd4b18u8tE66N0Oh0zi47W0zQVpEqy5BnV2MK6uCyOc3L8vziZ0j84D42pnMsvqCKqV2wL
        IdQ9y6LCL0V4tnjWds0w6xP9bq52Ls1ZFF74OMueoBlMu3dn6FX8oRcvb+zDy9ZH86mPP1S2
        VXkejvi85838smkr909MtnafuhtYT73eZgpf1NgWsqmmjMQbjR2LR6Un6VtXTUgLiruQcGvd
        xyeDtmcVY0+EFOS/pAghg6XD5LzA/gETokUAwQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO7215NjDV5tVLJY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DK2NgnVvDLruL/nGNMDYyzjLsYOTgkBEwkZnyP
        7WLk4hAS2M0oMW/JTKYuRk6guKTEtItHmSFqhCUOHy6GqHnLKPGpZREbSI2wQITEpI0v2EES
        IgJNTBKbei+wgySYBSIleuZuYYPo2MYo0bFwPgtIgk1AS2L/ixtg3fwCihJXfzxmBLF5Bewk
        9j68CVbDIqAi8XoZxBWiQBsO75gFVSMocXLmE7AaTgFzibbX+5kglqlL/Jl3iRnCFpe49WQ+
        VFxeonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBEeYltYOxhMn4g8xCnAwKvHw3giZHCvEmlhWXJl7iFGCg1lJhNfmz6RYId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYzNmxuvsP9q93bTfHh15eqW
        SSVet9b3MsUZ9bJc//TkfG6EqkO5wSUZPRfD5ohjrxlm358unrnzn+Bct0k5L9uLUmp0DBh0
        WSM7fE4tWWDXJ2JxtelsVuaerObUa9MZY/OuPa4sn3HNa97zFUdK1k3cLug9IfY1k/WtXkF2
        tfJTF/yfuIj67lViKc5INNRiLipOBABo2gE7rAIAAA==
X-CMS-MailID: 20191002001343epcas1p3cd70c7b729378103a969cefd3fd37f2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212509epcas4p20ec245213cedfcc066f7b0032b912a39
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212509epcas4p20ec245213cedfcc066f7b0032b912a39@epcas4p2.samsung.com>
        <20190811212315.12689-19-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
> The ACTMON governor is interrupt-driven and currently hardware's polling
> interval is fixed to 16ms in the driver. Devfreq supports variable polling
> interval by the generic governors, let's re-use the generic interface for
> changing of the polling interval. Now the polling interval can be changed
> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 71 ++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 8adc0ff48b45..e30314bd571a 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/jiffies.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -236,7 +237,7 @@ tegra_actmon_dev_avg_dependency_freq(struct tegra_devfreq *tegra,
>  				     struct tegra_devfreq_device *dev)
>  {
>  	return dev->config->avg_dependency_threshold /
> -		ACTMON_SAMPLING_PERIOD;
> +		tegra->devfreq->profile->polling_ms;
>  }
>  
>  static unsigned long
> @@ -314,8 +315,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  	 */
>  	*upper = tegra_actmon_account_cpu_freq(tegra, dev, *upper);
>  
> -	*lower *= ACTMON_SAMPLING_PERIOD;
> -	*upper *= ACTMON_SAMPLING_PERIOD;
> +	*lower *= tegra->devfreq->profile->polling_ms;
> +	*upper *= tegra->devfreq->profile->polling_ms;
>  }
>  
>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
> @@ -341,8 +342,8 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  	 * result, but this one is probably the least churning, although
>  	 * it may look a bit convoluted.
>  	 */
> -	if (freq * ACTMON_SAMPLING_PERIOD > upper)
> -		upper = freq * ACTMON_SAMPLING_PERIOD;
> +	if (freq * tegra->devfreq->profile->polling_ms > upper)
> +		upper = freq * tegra->devfreq->profile->polling_ms;
>  
>  	/*
>  	 * We want to get interrupts when MCCPU client crosses the
> @@ -420,7 +421,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>  	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
>  
> -	dev->avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
> +	dev->avg_freq = avg_count / tegra->devfreq->profile->polling_ms;
>  
>  	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
>  			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
> @@ -499,7 +500,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>  	 * outdated.
>  	 */
>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
> -	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
> +	avg_freq = avg_count / tegra->devfreq->profile->polling_ms;
>  
>  	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
>  	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
> @@ -675,7 +676,7 @@ static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
>  	 * here for too long, otherwise CPUFreq's core will complain with a
>  	 * warning splat.
>  	 */
> -	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
> +	delay = msecs_to_jiffies(tegra->devfreq->profile->polling_ms);
>  	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
>  
>  	return NOTIFY_OK;
> @@ -690,7 +691,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  	dev->boost_freq = 0;
>  
>  	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
> -	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
> +	device_writel(dev, dev->avg_freq * tegra->devfreq->profile->polling_ms,
>  		      ACTMON_DEV_INIT_AVG);
>  
>  	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
> @@ -725,7 +726,14 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  	unsigned int i;
>  	int err;
>  
> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> +	if (!tegra->devfreq->stop_polling)

I don't prefer to change the 'stop_polling' on each device driver direclty
without devfreq interface. Don't access it directly.

> +		return 0;
> +
> +	tegra->devfreq->previous_freq = clk_get_rate(tegra->emc_clock) / KHZ;
> +	tegra->devfreq->last_stat_updated = jiffies;
> +	tegra->devfreq->stop_polling = false;

ditto.

> +
> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
>  
>  	/*
> @@ -776,6 +784,11 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  {
>  	unsigned int i;
>  
> +	if (tegra->devfreq->stop_polling)

ditto.

> +		return;
> +
> +	mutex_unlock(&tegra->devfreq->lock);
> +
>  	disable_irq(tegra->irq);
>  
>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
> @@ -783,10 +796,16 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  
>  	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
>  
> +	mutex_lock(&tegra->devfreq->lock);
> +
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>  		tegra_actmon_stop_device(&tegra->devices[i]);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
> +
> +	devfreq_update_status(tegra->devfreq, tegra->devfreq->previous_freq);
> +
> +	tegra->devfreq->stop_polling = true;

ditto.

>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -846,7 +865,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>  
>  	/* Number of cycles in a sampling period */
> -	stat->total_time = cur_freq * ACTMON_SAMPLING_PERIOD;
> +	stat->total_time = cur_freq * tegra->devfreq->profile->polling_ms;
>  
>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>  
> @@ -854,7 +873,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  }
>  
>  static struct devfreq_dev_profile tegra_devfreq_profile = {
> -	.polling_ms	= 0,
> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>  	.target		= tegra_devfreq_target,
>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>  };
> @@ -895,8 +914,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  					unsigned int event, void *data)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> +	unsigned int new_delay, *delay_ptr = data;
>  	int ret = 0;
>  
> +	mutex_lock(&devfreq->lock);
> +
>  	/*
>  	 * Couple device with the governor early as it is needed at
>  	 * the moment of governor's start (used by ISR).
> @@ -905,26 +927,33 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  
>  	switch (event) {
>  	case DEVFREQ_GOV_START:
> -		devfreq_monitor_start(devfreq);
> +		devfreq->stop_polling = true;

It is not proper to initialize the 'stop_polling' on device driver directly.

> +		/* fall through */
> +	case DEVFREQ_GOV_RESUME:
>  		ret = tegra_actmon_start(tegra);
>  		break;
>  
>  	case DEVFREQ_GOV_STOP:
> -		tegra_actmon_stop(tegra);
> -		devfreq_monitor_stop(devfreq);

Why do you remove them?

> -		break;
> -
> +		/* fall through */
>  	case DEVFREQ_GOV_SUSPEND:
>  		tegra_actmon_stop(tegra);
> -		devfreq_monitor_suspend(devfreq);

Why do you remove it?

>  		break;
>  
> -	case DEVFREQ_GOV_RESUME:
> -		devfreq_monitor_resume(devfreq);
> -		ret = tegra_actmon_start(tegra);
> +	case DEVFREQ_GOV_INTERVAL:
> +		new_delay = *delay_ptr;
> +
> +		if (!new_delay || new_delay > 256) {
> +			ret = -EINVAL;
> +		} else {
> +			tegra_actmon_stop(tegra);
> +			devfreq->profile->polling_ms = new_delay;
> +			ret = tegra_actmon_start(tegra);
> +		}
>  		break;
>  	}
>  
> +	mutex_unlock(&devfreq->lock);
> +
>  	return ret;
>  }
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8C6A831
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPMFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:05:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:33333 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbfGPMFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:05:07 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716120503epoutp021cea3ce513ff7286df12f6ad51a76dd0~x4bLBdT5J0453304533epoutp02V
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:05:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716120503epoutp021cea3ce513ff7286df12f6ad51a76dd0~x4bLBdT5J0453304533epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563278703;
        bh=wj3gMtmrfGq9U+m18W2KF/JowsABKvx8+F9hvL9Ksz8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gVb577L1kJEuJr3cqhBpioMkB5p35GpxKyAc5qnudLY+tO2HbZ+ar8jXkg1JrsQU7
         RsUovfewBSb25wkJ3S6wh3GxMy027yjS1RFgeM6aUJhaZrRVs5qqYTVb79Oqd7G1Ba
         WZsJdBaQ8XkTfZu3HqWKFxIpQk3FA2549Vs8TIdk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716120502epcas1p3428e7029e5b35882248de7c61dd98780~x4bKds0uP0761207612epcas1p3m;
        Tue, 16 Jul 2019 12:05:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nzbw5VZvzMqYkV; Tue, 16 Jul
        2019 12:05:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.EE.04160.C6DBD2D5; Tue, 16 Jul 2019 21:05:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716120500epcas1p264c288876cbb2948b88a8865c0318121~x4bICc26p0946909469epcas1p23;
        Tue, 16 Jul 2019 12:05:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716120500epsmtrp1d83f3383fd3f3c84d10821ab93a5a500~x4bIBoqHi2933029330epsmtrp1S;
        Tue, 16 Jul 2019 12:05:00 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-de-5d2dbd6c2220
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.ED.03638.C6DBD2D5; Tue, 16 Jul 2019 21:05:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716120500epsmtip18a0c8f28316c05dd07854a22a0908398~x4bHztQyM0985909859epsmtip1S;
        Tue, 16 Jul 2019 12:05:00 +0000 (GMT)
Subject: Re: [PATCH v4 07/24] PM / devfreq: tegra30: Use CPUFreq notifier
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
Message-ID: <c94da786-05b4-1604-d208-f73f32ea937d@samsung.com>
Date:   Tue, 16 Jul 2019 21:08:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-8-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLcRTH82tvb29HuevKjhLqCrHS6dV1LjYRZKnwx+IVE83cbDfbsvbe
        prcVQ2SMscWMMI9rapi3Ycss3ZCxLV7JjAkRWxMxj3qHIRbPtndi/33OOd/zO4/fIZS687iB
        yOO9nIdnnRQegzW0JpjNzqtmhyV0x8Sc/dSDmM3SUYxp3/ROzTxoqsSZ3rI2xJR8kXCma+Mp
        nOlr8mPMjppOfLbGHghWI3ujFFTby4o+4PYd9WeQvbdudLpqRX5KLsdmcx4jx2cJ2Xl8Tiq1
        YHHm3ExbsoU209OZaZSRZ11cKjVvYbo5Lc8ZbogyrmadvrArnRVFasqsFI/g83LGXEH0plKc
        O9vpnu5OFFmX6ONzErME1wzaYplqCwtX5ee+vfgZd7+cs+bUp0JVIQoklyINAWQSlHcewUtR
        DKEjAwjaH0lYKSLCxmcEG7Nk/zcEtbXXVP8SKi//QnLgKoK+NzvVsvERwdGXFeqIKo6cD93+
        a1gkoCd/IyjpK8IjASWZAa2NZxURxkkTNIceR/1DybHw8HsPirCWnAXnymqiGowcD++P7I/y
        MHI53GnzY7ImFm4feB5lDWmDkw9vIPn9eHjy/LBC5jFQdOmgUm77Dw6bDnhkngdVwXKFzHHw
        5ma9WmYDvC4v7ud1cPp2W3QvQG5DUN98r39+KzQf362I7EhJJsCFpimyeyw0/jjU38MQ+PB1
        uyoiAVIL24p1smQcPHga7C87Ao5tLcF3IkoaMI00YAJpwATS/2JVCDuDhnNu0ZXDibQ7aeBn
        16HorZqYALpyd2ELIglEDdbeujLZoVOxq8UCVwsCQknptalfJzl02my2YC3nETI9PicntiBb
        eNm7lIZhWUL48nlvJm2barVamSQ62UbTVLzW/zPBoSNzWC+Xz3FuzvMvT0FoDIUoZkPTF3vo
        fYty0duJwvnuPd7OpZrmwh9PhF/GemvGhPt0cVfB7OuLxZoQYwrsfVU2p2RJnd417sSL+Fex
        +3obRvHt+sTKu3xeq5GooKqFQXsWaVIqnlX08t03u/CVPcUphu6Ocrth2czqtNiqoD9d7xgZ
        urXqsb/D12GR2tZvoTAxl6VNSo/I/gW2D+kowQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnG7OXt1Yg8UzeSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyXm/4xFbwzKlixccG1gbGHWZdjJwcEgImEnN2
        /2XsYuTiEBLYzSjxYvNsJoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKnJv9gQWkRljAU+LOvAMs
        IAkRgSYmiU29F9hBEswCkRI9c7ewQXRsZpT49GArM0iCTUBLYv+LG2wgNr+AosTVH48ZQWxe
        ATuJNb1rwTazCKhKvF04A8wWFYiQmHRtJwtEjaDEyZlPwGxOAVOJ5VePMUIsU5f4M+8SM4Qt
        LnHryXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBEeZltYOxhMn4g8xCnAwKvHwntijEyvEmlhWXJl7iFGCg1lJhNf2q3asEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBsbae8mpwa+MO9Td
        12T+sQrL89KLceBNi+PnOPVzeeaNMqW6JULTdyg08UlmZp9KP6f7+NF9dfMfW59LhqTZPtw+
        55andIrlrFybtOvTgs+kxKwL2i+wSok7ryHH4L/Dp4wPWTwyPf6z/c+crnyabNj8eXnjy6IA
        2xlNent1jmxSv7BZ7n7ENCWW4oxEQy3mouJEAAxcBieuAgAA
X-CMS-MailID: 20190716120500epcas1p264c288876cbb2948b88a8865c0318121
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223538epcas5p47ff4d1a90c3cfe7a5fb96108b1bd344a
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223538epcas5p47ff4d1a90c3cfe7a5fb96108b1bd344a@epcas5p4.samsung.com>
        <20190707223303.6755-8-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> The CPU's client need to take into account that CPUFreq may change
> while memory activity not, staying high. Thus an appropriate frequency
> notifier should be used in addition to the clk-notifier.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 105 +++++++++++++++++++++++++-----
>  1 file changed, 88 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 2bf65409ddd8..48a799fa5f63 100644
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
> @@ -154,7 +155,10 @@ struct tegra_devfreq {
>  
>  	struct clk		*emc_clock;
>  	unsigned long		max_freq;
> -	struct notifier_block	rate_change_nb;
> +	struct notifier_block	clk_rate_change_nb;
> +
> +	struct work_struct	update_work;

nitpick.
I think 'update_work' is not clear to indicate the work
for changing the clock according to the cpu clock change.
You better to change the name for more clearly.

> +	struct notifier_block	cpu_rate_change_nb;
>  
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>  
> @@ -456,8 +460,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
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
> @@ -467,7 +471,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	if (action != POST_RATE_CHANGE)
>  		return NOTIFY_OK;
>  
> -	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
> +	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
>  
>  	/*
>  	 * EMC rate could change due to three reasons:
> @@ -496,6 +500,37 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static void tegra_actmon_delayed_update(struct work_struct *work)
> +{
> +	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
> +						   update_work);
> +
> +	mutex_lock(&tegra->devfreq->lock);
> +	update_devfreq(tegra->devfreq);
> +	mutex_unlock(&tegra->devfreq->lock);
> +}
> +
> +static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
> +				      unsigned long action, void *ptr)
> +{
> +	struct tegra_devfreq *tegra;
> +
> +	if (action != CPUFREQ_POSTCHANGE)
> +		return NOTIFY_OK;
> +
> +	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);

nitpick. Better to check whether 'tegra' is NULL or not.

> +
> +	/*
> +	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
> +	 * to allow asynchronous notifications. This means we can't block
> +	 * here for too long, otherwise CPUFreq's core will complain with a
> +	 * warning splat.
> +	 */
> +	schedule_work(&tegra->update_work);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  					  struct tegra_devfreq_device *dev)
>  {
> @@ -527,9 +562,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  	device_writel(dev, val, ACTMON_DEV_CTRL);
>  }
>  
> -static void tegra_actmon_start(struct tegra_devfreq *tegra)
> +static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
> +{
> +	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);

Better to define the constant definition of 0x00000000
in order to explain the correct meaning.

For example,
#define ACTMON_DEV_RESET	0x00000000

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
> @@ -537,7 +579,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
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
> +	}> +
>  	enable_irq(tegra->irq);
> +
> +	return 0;
> +
> +err_stop:
> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
> +		tegra_actmon_stop_device(&tegra->devices[i]);
> +
> +	return err;
>  }
>  
>  static void tegra_actmon_stop(struct tegra_devfreq *tegra)
> @@ -546,11 +611,13 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  
>  	disable_irq(tegra->irq);
>  
> -	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
> -		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
> -		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
> -			      ACTMON_DEV_INTR_STATUS);
> -	}
> +	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
> +				    CPUFREQ_TRANSITION_NOTIFIER);
> +
> +	cancel_work_sync(&tegra->update_work);
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
> +		tegra_actmon_stop_device(&tegra->devices[i]);
>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -659,6 +726,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  					unsigned int event, void *data)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> +	int ret = 0;
>  
>  	/*
>  	 * Couple device with the governor early as it is needed at
> @@ -669,7 +737,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  	switch (event) {
>  	case DEVFREQ_GOV_START:
>  		devfreq_monitor_start(devfreq);
> -		tegra_actmon_start(tegra);
> +		ret = tegra_actmon_start(tegra);
>  		break;
>  
>  	case DEVFREQ_GOV_STOP:
> @@ -684,11 +752,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  
>  	case DEVFREQ_GOV_RESUME:
>  		devfreq_monitor_resume(devfreq);
> -		tegra_actmon_start(tegra);
> +		ret = tegra_actmon_start(tegra);
>  		break;
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static struct devfreq_governor tegra_devfreq_governor = {
> @@ -794,9 +862,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> -	tegra->	.notifier_call = tegra_actmon_rate_notify_cb;
> +	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
> +	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
> +
> +	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
>  	err = clk_notifier_register(tegra->emc_clock,
> -				    &tegra->rate_change_nb);
> +				    &tegra->clk_rate_change_nb);
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"Failed to register rate change notifier\n");
> @@ -823,7 +894,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	devfreq_remove_governor(&tegra_devfreq_governor);
>  
>  unreg_notifier:
> -	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> +	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>  
>  remove_opps:
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> @@ -841,7 +912,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  	devfreq_remove_device(tegra->devfreq);
>  	devfreq_remove_governor(&tegra_devfreq_governor);
>  
> -	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> +	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
>  	reset_control_reset(tegra->reset);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

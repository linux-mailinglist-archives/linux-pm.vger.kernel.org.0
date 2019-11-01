Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631C5EBE83
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 08:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfKAHgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 03:36:36 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46893 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfKAHgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 03:36:36 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191101073631epoutp02c3e6c3804a87cf3449627abe53ba77ff~S_bi9NQaw0309003090epoutp02d
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 07:36:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191101073631epoutp02c3e6c3804a87cf3449627abe53ba77ff~S_bi9NQaw0309003090epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572593791;
        bh=2E5+KKm8Hh7U4MZp1DQOpv1JHU7ES12ScpJvLbkhq+Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SFv899/5qvOvmCfKg9/VFBOBqXSQNAQ94ScJBT08hAtsQH0fo4b8CTq3JgVEeac3v
         PaNMbWNx040WDC9VAyrhFxK85pg+0v3rQ23KRtSghISE9y5MF64OirW2n3GHLl7Pl3
         Rx20lZZQI3pnEvUSLHLnZmYHuWujOWUmhuVUJrgc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191101073631epcas1p1fcb8079c1c6d67bbc3a502b141dec834~S_bigHMTm1226112261epcas1p1N;
        Fri,  1 Nov 2019 07:36:31 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 474DXF0M7fzMqYkb; Fri,  1 Nov
        2019 07:36:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.F1.04144.A70EBBD5; Fri,  1 Nov 2019 16:36:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191101073626epcas1p4bf0f9709d6aa2ba03ac037917aeab8a9~S_bd1C56l0862808628epcas1p4u;
        Fri,  1 Nov 2019 07:36:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191101073626epsmtrp227d0853ba3c39109e00ae419591e19fb~S_bd0KbFN2296422964epsmtrp2g;
        Fri,  1 Nov 2019 07:36:26 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-21-5dbbe07a9e60
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.6C.24756.A70EBBD5; Fri,  1 Nov 2019 16:36:26 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191101073626epsmtip28e19ffbe153d68cc614d9ddc9fb6d83d~S_bdnPD982715927159epsmtip2y;
        Fri,  1 Nov 2019 07:36:26 +0000 (GMT)
Subject: Re: [PATCH v7 17/19] PM / devfreq: tegra30: Support variable
 polling interval
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <00ddcbd5-262b-2130-6242-b1ec364825f3@samsung.com>
Date:   Fri, 1 Nov 2019 16:41:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029220019.26773-18-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUgUYRTn29mdHa2tr1XzaWA2SeCS5mRbs6GdIgsKGhGUZDbqtIp7sbNb
        dkDa2mGp3UVbZmhSGSmI5lEhrmZ0SWWHB5ahdBFbrRpFQe04Rv73e+/9fu/93vs+ilDXk6FU
        rtnO28yckSb95Tc7IqOidg3dSo/pKg9jr38bRmyRq1LOPt73Wcn2tF4g2dHSTsQWj7lIdqDw
        Ksk+fpfE/my9KGfLbjwjV/nrmwcvI32La1CpL3V6SH1ZQw3Sj9aHpSrS8uJyeC6bt4Xz5ixL
        dq7ZEE8nrc9Ym6FdGsNEMTp2GR1u5kx8PJ2QnBqVmGv0maLDt3NGhy+VygkCvWhFnM3isPPh
        ORbBHk/z1myjVWeNFjiT4DAborMspuVMTMxirY+4NS+nemwIWbs1+fWnC1EB2j//MPKjAC+B
        9xXvlYeRP6XGzQjc3o8KKfAiKCo+Mhl8R3C+7qfsn+RD3+Ck5A6CT6XuyeALgr52JymyAvBG
        qKn9hsRCIK6UwY27TYRYIPAm6Gi5PtGKxBpo+9A7IZiJ58GLH8NIxCq8Akou3fbxKUqOI+D5
        17kiDPL1fDjOSYxZcP/ciFzEfngZ9HpHSKl7MPSPVMgkPBecjecJybRTCSfKdBJOgKPj++US
        DoBP9xqUEg6FUc8dUsK74dr9TlK0D/gQgoa2JwqpEAtt1Sdloh8CR0Jd6yIpPQ9afpUjae4M
        8IyXKEQKYBUcOqCWKPOhZ2hw8oYhUHWwmDyGaNeUbVxTNnBN2cD1f9glJK9Bs3mrYDLwAmNl
        pj52PZr4rxptMzrVnexGmEL0dNWx7lvpagW3XdhpciOgCDpQ1VTrS6myuZ27eJslw+Yw8oIb
        aX2nPk6EBmVZfL/fbM9gtItjY2PZJcxSLcPQwarVV6rT1djA2fk8nrfytn86GeUXWoBSKvbq
        3FnFCYY3Id72OftenX7SPpCaOVSQ/vu1ifj1ZqB2Q9NKx1F1SiMeGQtLlJ11+C8c7+r0rP5c
        8ioiflvv9DWG4MwdZ4Zn/tD/fpFU8+hA29M/tr24X9PYFKc70Zmf+Fa1eZq3aEGuZ0tAYURt
        afnBB2kpTkNINdn4ck/gjHVVtFzI4RgNYRO4v/DzfuXFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvG7Vg92xBhOWcVis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZnH3mbfFz1zwWi761l9gcuDx23F3C6LFz1l12
        j97md2wefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbH0ywPGgnNaFZumNjI2MLYqdzFyckgI
        mEi8uHmXvYuRi0NIYDejxL/l25kgEpIS0y4eZe5i5ACyhSUOHy6GqHnLKHF9wjd2kLiwQITE
        tG3ZIHERgSVMEme/LGcG6WUWiJTombuFDaJhG6PEsas32UESbAJaEvtf3GADsfkFFCWu/njM
        CGLzCthJ9CzYA7aMRUBF4soHeZCwKND859tvQJUISpyc+YQFxOYUMJe48ekJG8QudYk/8y5B
        7RWXuPVkPhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoT
        c4tL89L1kvNzNzGCI01Lcwfj5SXxhxgFOBiVeHhndO2OFWJNLCuuzD3EKMHBrCTCu30dUIg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbGxnItf8Wb/b8U
        L+3p6Xxb9llgpsZtjkf3ypMKfXQXh7N6v/o+8dCad/Paeqa+5+2x5a89FrCe58yHDXcZbhou
        rmjk1Mp+1xd2etEC1q99rTJqz3JkozXdBcV9ftd2OLKERd/IWSIvXd6yYIqcsEaboVqK3FSe
        W86Z8lPCbbbO5s5Kqy8veq3EUpyRaKjFXFScCABkArmVsAIAAA==
X-CMS-MailID: 20191101073626epcas1p4bf0f9709d6aa2ba03ac037917aeab8a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191029220636epcas2p279bee6ee40d9253cdfbcf5d6da6b3a14
References: <20191029220019.26773-1-digetx@gmail.com>
        <CGME20191029220636epcas2p279bee6ee40d9253cdfbcf5d6da6b3a14@epcas2p2.samsung.com>
        <20191029220019.26773-18-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
> The ACTMON governor is interrupt-driven and currently hardware's polling
> interval is fixed to 16ms in the driver. Devfreq supports variable polling
> interval by the generic governors, let's re-use the generic interface for
> changing of the polling interval. Now the polling interval can be changed
> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 35 ++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index b745a973c35a..d0dd42856e5b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -218,7 +218,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  {
>  	u32 avg = dev->avg_count;
>  	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
> -	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
> +	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
>  
>  	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
>  
> @@ -229,7 +229,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  				       struct tegra_devfreq_device *dev)
>  {
> -	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> +	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>  
>  	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
>  		      ACTMON_DEV_UPPER_WMARK);
> @@ -308,7 +308,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>  	unsigned int avg_sustain_coef;
>  	unsigned long target_freq;
>  
> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>  	target_freq += dev->boost_freq;
> @@ -465,7 +465,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  
>  	dev->target_freq = tegra->cur_freq;
>  
> -	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> +	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>  
>  	tegra_devfreq_update_avg_wmark(tegra, dev);
> @@ -506,7 +506,11 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  	unsigned int i;
>  	int err;
>  
> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> +	if (!tegra->devfreq->profile->polling_ms ||
> +	    tegra->devfreq->stop_polling)

I think that the access of 'devfreq->stop_polling' is not good
on governor. It is possible to alter with DEVFREQ_GOV_START/STOP/SUSPEND/RESUME
notification.

> +		return 0;> +
> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
>  
>  	/*
> @@ -554,6 +558,10 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  
>  static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  {
> +	if (!tegra->devfreq->profile->polling_ms ||
> +	    tegra->devfreq->stop_polling)

ditto.

> +		return;
> +
>  	disable_irq(tegra->irq);
>  
>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
> @@ -623,7 +631,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>  
>  	/* Number of cycles in a sampling period */
> -	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
> +	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
>  
>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>  
> @@ -631,7 +639,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  }
>  
>  static struct devfreq_dev_profile tegra_devfreq_profile = {
> -	.polling_ms	= 0,
> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>  	.target		= tegra_devfreq_target,
>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>  };
> @@ -671,6 +679,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  					unsigned int event, void *data)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> +	unsigned int *new_delay = data;
>  	int ret = 0;
>  
>  	/*
> @@ -690,6 +699,17 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  		devfreq_monitor_stop(devfreq);
>  		break;
>  
> +	case DEVFREQ_GOV_INTERVAL:
> +		if (*new_delay > 256) {

Need to add the comment why the maximum delay is under 256 ms.

> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		tegra_actmon_stop(tegra);
> +		devfreq_interval_update(devfreq, new_delay);
> +		ret = tegra_actmon_start(tegra);
> +		break;
> +
>  	case DEVFREQ_GOV_SUSPEND:
>  		tegra_actmon_stop(tegra);
>  		devfreq_monitor_suspend(devfreq);
> @@ -709,6 +729,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>  	.get_target_freq = tegra_governor_get_target,
>  	.event_handler = tegra_governor_event_handler,
>  	.immutable = true,
> +	.interrupt_driven = true,
>  };
>  
>  static int tegra_devfreq_probe(struct platform_device *pdev)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

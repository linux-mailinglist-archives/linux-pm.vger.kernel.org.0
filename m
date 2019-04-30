Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CEFEE47
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfD3BSS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 21:18:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50411 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfD3BSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 21:18:18 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430011814epoutp02b27ab00bd5a5bdfb8cac278af8951456~aG7cj7Weq1957819578epoutp02z
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 01:18:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430011814epoutp02b27ab00bd5a5bdfb8cac278af8951456~aG7cj7Weq1957819578epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556587094;
        bh=NPBlrw34zA5Stxqp7skzZMXwwH08veJqTkLQTvwPKPg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nlTPMczJI0odyq9GG07pWhCUln2DE62JiF24kHnQvIPSQlOu3YkbPPqedgTfr6lOL
         9eSsdq8DdhKvTWk9BQEqvYXAImGoMaZ3mYKILGHMtJSFoJfcOPYQkR2F376FDX861R
         K0PkZl0XfILPLQmQjsyvAypPMgLZcTYm/9vjZ7Ng=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430011810epcas1p1de2c13e7057a314e636c4c3f01d799cc~aG7ZMhxRt0289402894epcas1p1w;
        Tue, 30 Apr 2019 01:18:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.B5.04257.F42A7CC5; Tue, 30 Apr 2019 10:18:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430011807epcas1p29125c6981a977d31c88ea89ff60ef91c~aG7VqmYpP1537515375epcas1p2v;
        Tue, 30 Apr 2019 01:18:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430011807epsmtrp2d805f20a5cff019b8fc1242ae19bbd70~aG7Vpy0Tz2743227432epsmtrp2_;
        Tue, 30 Apr 2019 01:18:07 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-95-5cc7a24ff53b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.63.03662.F42A7CC5; Tue, 30 Apr 2019 10:18:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430011807epsmtip11e63d43f1b4d597e59dd2acff0eb45f6~aG7Vgr6v50868808688epsmtip1X;
        Tue, 30 Apr 2019 01:18:07 +0000 (GMT)
Subject: Re: [PATCH v3 12/16] PM / devfreq: tegra: Reconfigure hardware on
 governor's restart
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2bcf8ece-c744-bf18-0b7b-177cbb09c174@samsung.com>
Date:   Tue, 30 Apr 2019 10:19:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-13-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRTHM92ji7E6VtQniYprMIABupTiSoBoRK3RKNEvSprUDWwKoVe6
        rVE08QAVGsQrHlS03lEsnqhYISgeFY1X8cCj8UCJMaYeqNFEjW1XI9/+8+b3jv/MYwj1MTqB
        KbM6RYdVMLP0APLs5RRN2tx9AYPGdzSFP/qpB/FVnn0kf2v1eyXf5W+g+b71VxBf88VD809X
        Hab5H/7dJF/XFKQnx+lbQgeQ/rwnpNSvrwzT+rrmRqTvOzW6kCoqzy0VhRLRkShai20lZVZT
        HjtrvnGqUZet4dK4SfxENtEqWMQ8tmB2Ydr0MnNkIDZxsWB2RUKFgiSxGfm5DpvLKSaW2iRn
        HivaS8z2SfZ0SbBILqspvdhmyeE0mkxdBFxUXtp72qe0n85csvvmRnIlqk1xozgGcBb4Dm2m
        3GgAo8YtCHp7V/09fEZwfc15Mkqp8TcEGx6M+5fx6vENUobaEPzq9lIy9AFB6x3BjRhmKDZC
        VePwKBOPfyP47N8RYwi8EL5eOkhENY1Tof1tNx3Vg/FYePC9B0W1CufDs4aeWJzESXDJeyvG
        D8ML4Pm1E5TMDIHO+tex4eJwNvgvnKTl+iPgyWuvQtZjoPLMTiI6BOBKJQS7jpCygwK4+/sh
        Ieuh8C7QrJR1AvSF22hZL4MjnVdoObkaQXP7XUq+0EL7wS2KqEsCp8Bxf4bcbBCEv9ZS0TBg
        FVSvVcv0OOh6EVLIeiTsX1fzt7weLr6sUWxEYz397Hj6WfD0s+D532wPIhvRcNEuWUyixNmz
        +n/2KRTb1VS+BbXent2BMIPYgSp9+JpBTQmLpaWWDgQMwcar9IGrBrWqRFhaITpsRofLLEod
        SBd57U1EwrBiW2TzrU4jp8vUarV8Fpet4zh2hOr45KkGNTYJTrFcFO2i41+egolLWInGlx/r
        nrm1on5nVWiad3xGpX9OXVvr/SK/O3l0cmGgsTPeO2PWfvQ9/UNF0d5Oj9bEfdROmZC07E3y
        Npfp7W1fzubeRXXpP0epLmyvNne5Z2xZXfYm915Qte1cRdO3XcHwCiqnNrVJc0bIp1yGG8vj
        r15MelTw7nm9oTojMC/oU4ZYUioVuFTCIQl/AMSov73BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnK7/ouMxBnv+cVis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlPNu8hr1gs1HFvNMTWBoYezS7GDk5JARMJB7d
        PMXSxcjFISSwm1GiqX0nC0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl2nfuZgeJCwvES7SsEgOJ
        iwg0MUl8ftjCBNLLLBAp0f+omxXEFhLYwiix/5QliM0moCWx/8UNNhCbX0BR4uqPx4wgNq+A
        ncSdOY/B4iwCqhIH559lBrFFBSIkzrxfwQJRIyhxcuYTMJtTwExi1+6NbBC71CX+zLvEDGGL
        S9x6Mh/qBnmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHGFaWjsYT5yIP8QowMGoxMPr8e5YjBBrYllxZe4hRgkOZiURXo/jR2OEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1ME55OlXpw/IK9jvZ
        90p/LnyQ/iJJdMvlmJl9QZ4zl+TIladJ7nqz9tIGCdVLVYx7ji9p2OpZqeWxL/GG2NMdB3dq
        ve+YlyC/7YavwckT19bmhOwp7pRbfvvsjgtsr6ozZ1Q0nTPN+fFSRPahQv2BNRd8ri5/NjlA
        6U3KzZ698VUrD/sLXki5sk9aiaU4I9FQi7moOBEAogh7D6wCAAA=
X-CMS-MailID: 20190430011807epcas1p29125c6981a977d31c88ea89ff60ef91c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224236epcas1p15d8c9b1b75ce29ac06d1ecbae46a572b
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224236epcas1p15d8c9b1b75ce29ac06d1ecbae46a572b@epcas1p1.samsung.com>
        <20190417222925.5815-13-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> Move hardware configuration to governor's start/resume methods.
> This allows to re-initialize hardware counters and reconfigure
> cleanly if governor was stopped/paused. That is needed because we
> are not aware of all hardware changes that happened while governor
> was stopped and the paused state may get out of sync with reality,
> hence it's better to start with a clean slate after the pause. In
> a result there is no memory bandwidth starvation after resume from
> suspend-to-ram that results in display controller underflowing that
> happens on resume because of improper decision made by devfreq about
> the required memory frequency. This change also cleans up code a tad
> by moving hardware-configuration code into a single location.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 98 ++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 62f35e818122..e9ab49394d35 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -392,55 +392,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> -static void tegra_actmon_enable_interrupts(struct tegra_devfreq *tegra)
> -{
> -	struct tegra_devfreq_device *dev;
> -	u32 val;
> -	unsigned int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
> -		dev = &tegra->devices[i];
> -
> -		val = device_readl(dev, ACTMON_DEV_CTRL);
> -		val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
> -		val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
> -		val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> -		val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> -
> -		device_writel(dev, val, ACTMON_DEV_CTRL);
> -	}
> -
> -	actmon_write_barrier(tegra);
> -}
> -
> -static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
> -{
> -	struct tegra_devfreq_device *dev;
> -	u32 val;
> -	unsigned int i;
> -
> -	disable_irq(tegra->irq);
> -
> -	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
> -		dev = &tegra->devices[i];
> -
> -		val = device_readl(dev, ACTMON_DEV_CTRL);
> -		val &= ~ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
> -		val &= ~ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
> -		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> -		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> -
> -		device_writel(dev, val, ACTMON_DEV_CTRL);
> -
> -		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> -			      ACTMON_DEV_INTR_STATUS);
> -	}
> -
> -	actmon_write_barrier(tegra);
> -
> -	enable_irq(tegra->irq);
> -}
> -
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  					  struct tegra_devfreq_device *dev)
>  {
> @@ -464,11 +415,47 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  		<< ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_NUM_SHIFT;
>  	val |= (ACTMON_ABOVE_WMARK_WINDOW - 1)
>  		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
> +	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
> +	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
> +	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> +	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  	val |= ACTMON_DEV_CTRL_ENB;
>  
>  	device_writel(dev, val, ACTMON_DEV_CTRL);
> +}
> +
> +static void tegra_actmon_start(struct tegra_devfreq *tegra)
> +{
> +	unsigned int i;
> +
> +	disable_irq(tegra->irq);
> +
> +	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> +		      ACTMON_GLB_PERIOD_CTRL);
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
> +		tegra_actmon_configure_device(tegra, &tegra->devices[i]);

nitpick.
I agree this patch.

In order to make it more simple, I think that you can remove
tegra_actmon_configure() function and then just do some opertion
under the for loop in the tegra_actmon_start() to keep
similar style with tegra_actmon_stop(). But there is perfect solution.
If you agree, edit it on next patch. If you think that it is not necessary,
just keep this code.

> +
> +	actmon_write_barrier(tegra);
> +
> +	enable_irq(tegra->irq);
> +}
> +
> +static void tegra_actmon_stop(struct tegra_devfreq *tegra)
> +{
> +	unsigned int i;
> +
> +	disable_irq(tegra->irq);
> +
> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
> +		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
> +		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
> +			      ACTMON_DEV_INTR_STATUS);
> +	}
>  
>  	actmon_write_barrier(tegra);
> +
> +	enable_irq(tegra->irq);
>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -580,22 +567,22 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  	switch (event) {
>  	case DEVFREQ_GOV_START:
>  		devfreq_monitor_start(devfreq);
> -		tegra_actmon_enable_interrupts(tegra);
> +		tegra_actmon_start(tegra);
>  		break;
>  
>  	case DEVFREQ_GOV_STOP:
> -		tegra_actmon_disable_interrupts(tegra);
> +		tegra_actmon_stop(tegra);
>  		devfreq_monitor_stop(devfreq);
>  		break;
>  
>  	case DEVFREQ_GOV_SUSPEND:
> -		tegra_actmon_disable_interrupts(tegra);
> +		tegra_actmon_stop(tegra);
>  		devfreq_monitor_suspend(devfreq);
>  		break;
>  
>  	case DEVFREQ_GOV_RESUME:
>  		devfreq_monitor_resume(devfreq);
> -		tegra_actmon_enable_interrupts(tegra);
> +		tegra_actmon_start(tegra);
>  		break;
>  	}
>  
> @@ -664,15 +651,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
>  	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>  
> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> -		      ACTMON_GLB_PERIOD_CTRL);
> -
>  	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
>  		dev = tegra->devices + i;
>  		dev->config = actmon_device_configs + i;
>  		dev->regs = tegra->regs + dev->config->offset;
> -
> -		tegra_actmon_configure_device(tegra, dev);
>  	}
>  
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
> 

I agree to always initialize the device when START or RESUME
and also to reset the device when STOP or SUSPEND.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

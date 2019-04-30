Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E849ED8C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 02:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfD3AO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 20:14:59 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47527 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfD3AO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 20:14:58 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190430001455epoutp04089e14852bd3ab733c94b11957633bc7~aGEKFRphw2218822188epoutp04a
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 00:14:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190430001455epoutp04089e14852bd3ab733c94b11957633bc7~aGEKFRphw2218822188epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556583295;
        bh=jgEiupZLaSbXRwWtJ4Jq3fVFlSGwme7HIaHJF92vfGM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sYTEx7asANW+hxQ2MomNRkyfx6+u+P4nKqfYPdzpLfKODwVbAa/f83Xx/M9EEi7pj
         qzRcML2F/Fa0eF96WYQfcOQu2/q6MysF5daZNlAb2c/2PbVYNr65Kdj1bgTJejKY9i
         0dBRNRRtija9aXSK0A2MHuh9KV/pW/fV01VxMbYY=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190430001451epcas1p427287f496b2816b9646bf4da504f3f8a~aGEGuRDSq2911229112epcas1p4s;
        Tue, 30 Apr 2019 00:14:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.88.04142.87397CC5; Tue, 30 Apr 2019 09:14:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190430001448epcas1p34fdfdf740532dfaf9697ec7fc3acbe16~aGEDZpNzC1158011580epcas1p3E;
        Tue, 30 Apr 2019 00:14:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430001448epsmtrp21bd6ecdb47ecf38cde5e74711bbcd49e~aGEDYu4x70555605556epsmtrp2R;
        Tue, 30 Apr 2019 00:14:48 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-09-5cc793784af0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.42.03692.77397CC5; Tue, 30 Apr 2019 09:14:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430001447epsmtip1acbc8dc5c14fdc78ca20c217bbdf2f62~aGEDMUIka2618226182epsmtip1E;
        Tue, 30 Apr 2019 00:14:47 +0000 (GMT)
Subject: Re: [PATCH v3 08/16] PM / devfreq: tegra: Clean up driver's probe /
 remove
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
Message-ID: <236a553b-ccb5-f8fd-d404-af78f04d6985@samsung.com>
Date:   Tue, 30 Apr 2019 09:16:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-9-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDHfT22BS0uVWBERVhjTDFIFyiuKOJBtFE/YIR4pLGudFOQXukW
        BP2ClKhVURQ0Ws8gnkhAqAbrgSJKNMGgRDQoUaGJhuASbjBGbbsx8u333vxn/jPvjVQor8LC
        pdkmG2M10QYCCxTde6aIjckva9Eor4+GUVUDPYgqdlaIqNaiPgnV7j6PUUMlzYhyDDsx6uP+
        Gxg14b4ooo5Vv8VWBqgbuiqR+r6zS6IusXOY+pjrFlIP1UWkibfnLM9iaB1jjWRMmWZdtkmf
        TGzYrF2jVSUqyRhyKbWEiDTRRiaZSN2YFrM22+BtiIjMow253qs0mmWJ2BXLreZcGxOZZWZt
        yQRj0RksSy2LWdrI5pr0izPNxiRSqYxTeYU7c7Ied9RjFo8i/6lnWSHyRB1GAVLAE6C7+Szm
        YznegMDOzT6MAr08iGDi/R3EB0YRlF7e+y+hvKtbwIseITjt4SS8qB/BSM0cH8/AM2DAfRLz
        iWbivxEMus+IfQEhvg1Gnl4V+hjDo6Hx+we/9XQ8Ct6N9/jdZPgK6LMP+4uK8AXwsGNQ4OMQ
        fCt8flEr5jXB8PKsR+TjAFwFz7ifEr5+GHR6Lgl4ngf2u+eEviYA/4OBq/eBNyD1HlKh800w
        P80M6G1xSXgOhyHuEcbzPrj5shnjcw8hcDW2iflAPDReLfPXEeIKqHHH8l5BwI0cFfPlZXDo
        gJxXz4f2L10CnmfBlYMOjJeoYexrSimKck4axjlpAOekAZz/vS4j0S0UylhYo55hSUvc5J+u
        Q/5FjU5sQBWvNzYhXIqIaTI190IjF9N5bIGxCYFUSMyUqVuea+QyHV2wl7GatdZcA8M2IZX3
        rU8Iw0Myzd61N9m0pCouPj6eSiATVSRJhMlqVq7RyHE9bWNyGMbCWP/lCaQB4YUoqadaeWpV
        a/HCOM21lPGyLeP9r28XRtgS5ioy3pSOfd6xqOjTfl2lw3hkir2uOtUVq29rYB0O3PUjuDf0
        wa+8xOH0oO6p3zhn+dbsV5tCGwsrzuh1uy9ot60u1rfXl1mT5le2htS2adPPdyqenLKt/5Wx
        p+jIrrt/uOMbDqwriNk8SojYLJqMFlpZ+i/D+C8JvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG755OMxBtcOm1us/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl7Lu2ma3giWbFwSfWDYxPFLsYOTkkBEwkptx9
        xNTFyMUhJLCbUWJl5zlGiISkxLSLR5m7GDmAbGGJw4eLIWreMkqcWfqbDaRGWCBU4uOuSWwg
        CRGBJiaJzw9bmEASzAKREv2PulkhOjYzSixa+wYswSagJbH/xQ2wbn4BRYmrPx6DbeMVsJN4
        0/yFHcRmEVCV2HPtE1i9qECExJn3K1ggagQlTs58AmZzCphKHH73ix1imbrEn3mXmCFscYlb
        T+ZDHSEv0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgmNMS3MH4+Ul8YcYBTgYlXh4Pd4dixFiTSwrrsw9xCjBwawkwutx/GiMEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwOR3o9tx4z/sv0Zd+m
        tb+7zx/Z9c14w3W/DdMEpqSxul+YGlvZmO27SP/1tywV1n1xLeHfz2pUea3au1/9FnPIEW2f
        S+UBPVtcFxryTC/7/WzLns1rdn7nvHJw+kse76gtT/9d3nxdcWJ/1fxrhS9S9EPVJ1lcWr/A
        cnH9Y+bM0PhNq53qPP2TlFiKMxINtZiLihMB3CI7Ja0CAAA=
X-CMS-MailID: 20190430001448epcas1p34fdfdf740532dfaf9697ec7fc3acbe16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224114epcas4p14b20e269f10a3e3bfea4c8ec4c3300b3
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224114epcas4p14b20e269f10a3e3bfea4c8ec4c3300b3@epcas4p1.samsung.com>
        <20190417222925.5815-9-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> Reset hardware, disable ACTMON clock, release OPP's and handle all
> possible error cases correctly, maintaining the correct tear down
> order. Also use devm_platform_ioremap_resource() which is now available
> in the kernel.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 83 +++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index ce1eb97a2090..70946e432d3c 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -610,7 +610,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
> -	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
>  	int err;
> @@ -619,9 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	if (!tegra)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
> +	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(tegra->regs))
>  		return PTR_ERR(tegra->regs);
>  
> @@ -643,11 +640,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->emc_clock);
>  	}
>  
> -	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
> -	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"Failed to register rate change notifier\n");
> +	tegra->irq = platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err = tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
>  		return err;
>  	}
>  
> @@ -678,54 +674,69 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>  		rate = clk_round_rate(tegra->emc_clock, rate);
> -		dev_pm_opp_add(&pdev->dev, rate, 0);
> -	}
>  
> -	tegra->irq = platform_get_irq(pdev, 0);
> -	if (tegra->irq < 0) {
> -		err = tegra->irq;
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> -		return err;
> +		err = dev_pm_opp_add(&pdev->dev, rate, 0);
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
> +			goto remove_opps;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> +	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
> +	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to register rate change notifier\n");
> +		goto remove_opps;
> +	}
> +
> +	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> +	tegra->devfreq = devfreq_add_device(&pdev->dev,
> +					    &tegra_devfreq_profile,
> +					    "tegra_actmon",
> +					    NULL);
> +	if (IS_ERR(tegra->devfreq)) {
> +		err = PTR_ERR(tegra->devfreq);
> +		goto unreg_notifier;
> +	}
> +
>  	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>  					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
>  	if (err) {
> -		dev_err(&pdev->dev, "Interrupt request failed\n");
> -		return err;
> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
> +		goto remove_devfreq;
>  	}
>  
> -	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> -	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
> -						 &tegra_devfreq_profile,
> -						 "tegra_actmon",
> -						 NULL);
> -
>  	return 0;
> +
> +remove_devfreq:
> +	devfreq_remove_device(tegra->devfreq);
> +
> +unreg_notifier:
> +	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> +
> +remove_opps:
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	reset_control_reset(tegra->reset);
> +	clk_disable_unprepare(tegra->clock);
> +
> +	return err;
>  }
>  
>  static int tegra_devfreq_remove(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> -	int irq = platform_get_irq(pdev, 0);
> -	u32 val;
> -	unsigned int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
> -		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
> -		val &= ~ACTMON_DEV_CTRL_ENB;
> -		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
> -	}
> -
> -	actmon_write_barrier(tegra);
>  
> -	devm_free_irq(&pdev->dev, irq, tegra);
> +	devfreq_remove_device(tegra->devfreq);
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);

nitpick: the probe function  has following call sequence if error case,
First, clk_notifier_unregister()
Second, dev_pm_opp_remove_all_dynamic()

If possible, you better to keep the same sequence
in the tegra_devfreq_remove(). But, it is just opinion.
If you think that it doesn't break the routine of device removal,
jut keep this code.

>  
> +	reset_control_reset(tegra->reset);
>  	clk_disable_unprepare(tegra->clock);
>  
>  	return 0;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA5ED7A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 02:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfD3AEh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 20:04:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15370 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfD3AEh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 20:04:37 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430000434epoutp0264507fde16a402716a106133b8221174~aF7Hwua5w1742417424epoutp02O
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 00:04:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430000434epoutp0264507fde16a402716a106133b8221174~aF7Hwua5w1742417424epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556582674;
        bh=+xtYg2MqUKhpLfHzCvo1anR6GJBqe6ObWJBn2wxm1Kg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=I8rU/PunU1HIa0P8qbAF8zOPUa4ztwI92rtmEad8zH+dkS3OlB+J1eaDEjOkHtU5y
         +Mrz0mNabDLKZS4ktHNqSFIsjDJ21RRqr7yW4vmG2Ii6PE15xuNah3vmtcZuO7/hJY
         oJgaNe2AxjQ/nmaroePnT2cNPyik7cUA8xY72OPo=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430000431epcas1p22a51007b76c0586bcc98b0287f75dcac~aF7FIQVbQ2608726087epcas1p2l;
        Tue, 30 Apr 2019 00:04:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.E3.04142.F0197CC5; Tue, 30 Apr 2019 09:04:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430000430epcas1p1fec76d40c7788ad0a24de4197db84a33~aF7EtGrZu1183911839epcas1p1K;
        Tue, 30 Apr 2019 00:04:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430000430epsmtrp1efef5ada5bba5bd9376bc6712c61b313~aF7EsSAur1024810248epsmtrp1d;
        Tue, 30 Apr 2019 00:04:30 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-77-5cc7910f9a40
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.D1.03692.E0197CC5; Tue, 30 Apr 2019 09:04:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430000430epsmtip169b5bc9bdb68fbce9e6a3812fb49a56f~aF7Efg71h1631616316epsmtip1X;
        Tue, 30 Apr 2019 00:04:30 +0000 (GMT)
Subject: Re: [PATCH v3 07/16] PM / devfreq: tegra: Properly disable
 interrupts
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
Message-ID: <87b5a3df-a0c2-3a6e-7e93-f1c89b0a789e@samsung.com>
Date:   Tue, 30 Apr 2019 09:05:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-8-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmni7/xOMxBicni1is/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dL
        zs+1MjQwMDIFKkzIzjgzK71gvXjFjq7/TA2Mz4W6GDk5JARMJH7u/sXUxcjFISSwg1Hi2JvL
        UM4nRomb7X8ZIZxvjBJH/vaxwrTserGYHSKxl1Hi6KU5UC3vGSXWrHnFBlIlLBAgsX1GG1i7
        iMA/RolPu2aAtTMLREp8PbiUGcRmE9CS2P/iBlgDv4CixNUfjxlBbF4BO4lrE3+A2SwCqhKH
        D59lB7FFBSIk7h/bwApRIyhxcuYTFhCbU8BU4szD/SwQ88Ulbj2ZzwRhy0s0b53NDHKEhMBv
        Nond518wQvzgIrHgQyszhC0s8er4FnYIW0riZX8blF0tsfLkETaI5g5GiS37L0ADwFhi/9LJ
        QBs4gDZoSqzfpQ+xjE/i3dceVpCwhACvREcbNISVJS4/uMsEYUtKLG7vZIOwPSSebLvMNoFR
        cRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDACDm6NzGCU6uW2Q7GRed8DjEKcDAq8fB6
        vDsWI8SaWFZcmXuIUYKDWUmE1+P40Rgh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA9M+3kl
        8YamRsbGxhYmhmamhoZK4rzrHZxjhATSE0tSs1NTC1KLYPqYODilGhhtT1VN3yC7a0mWP2fS
        tcbC5We8dqyw4bserupV9Kb04vYPqZq6j/PkxdnUC+uPfj3jKqkqPjnCJNhuiVmDZ1WwqPO6
        me+dln6sv1R64Jt+0p6l6Q1r9Y+9SWI6+m7u/IXL95U2HyqP2pPk9VVQS6rY0nD5x+P3TV56
        3D2Rac6tqHrR/dOpzFAlluKMREMt5qLiRABxEaI5wwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnC7fxOMxBsc2GFus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlnJmVXrBevGJH13+mBsbnQl2MnBwSAiYSu14s
        Zu9i5OIQEtjNKLHvwAUWiISkxLSLR5m7GDmAbGGJw4eLIWreMkocff2JGaRGWMBPYv+PTSwg
        CRGBJiaJzw9bmEASzAKREv2PulkhOjYzSqyd9gCsg01AS2L/ixtsIDa/gKLE1R+PGUFsXgE7
        iWsTf4DZLAKqQNvOsoPYogIREmfer2CBqBGUODnzCZjNKWAqcebhfhaIZeoSf+ZdYoawxSVu
        PZkPdYS8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI4xLc0djJeXxB9iFOBgVOLh9Xh3LEaINbGsuDL3EKMEB7OSCK/H8aMxQrwpiZVV
        qUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTBW2NjIlxqUZGlp17EI
        mtWq+cZ/nBD/bP26oM9bQk69jbfIfsvswlWn8OC014TlK9f6ujFqLbTTUv7y1ueipPpMXt50
        Q47SRpfTdwI6y3xLUuZainxouKP8RTDQOHK/ypQY/cwWtaaJ5k7v3H/s3n6oYinD3Q17qnO2
        n/D2X/nom/sJjbAVkkosxRmJhlrMRcWJAGuOKL6tAgAA
X-CMS-MailID: 20190430000430epcas1p1fec76d40c7788ad0a24de4197db84a33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224252epcas5p43248bf8dbebdf687c466d6985233c4e8
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224252epcas5p43248bf8dbebdf687c466d6985233c4e8@epcas5p4.samsung.com>
        <20190417222925.5815-8-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> There is no guarantee that interrupt handling isn't running in parallel
> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
> disabled in the Interrupt Controller in order to ensure that device
> interrupt is indeed being disabled.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index b65313fe3c2e..ce1eb97a2090 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>  	struct notifier_block	rate_change_nb;
>  
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
> +
> +	int irq;
>  };
>  
>  struct tegra_actmon_emc_ratio {
> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>  	u32 val;
>  	unsigned int i;
>  
> +	disable_irq(tegra->irq);
> +
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev = &tegra->devices[i];
>  
> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>  		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  
>  		device_writel(dev, val, ACTMON_DEV_CTRL);
> +
> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> +			      ACTMON_DEV_INTR_STATUS);
>  	}
>  
>  	actmon_write_barrier(tegra);
> +
> +	enable_irq(tegra->irq);
>  }
>  
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
> @@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
> -	int irq;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>  	}
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> -		return irq;
> +	tegra->irq = platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err = tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +		return err;
>  	}
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> -	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>  					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
>  	if (err) {
> 

It is ok to disable the hardware interrupt line
before completing the some operation about registers
in order to protect the interrupt occur.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

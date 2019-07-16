Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2A6A79A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfGPLoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:44:05 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25142 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387582AbfGPLoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:44:05 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716114403epoutp03129ea82fb6c700bd4f3368fe1d757efc~x4I1Lv-Nc1137411374epoutp03X
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:44:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716114403epoutp03129ea82fb6c700bd4f3368fe1d757efc~x4I1Lv-Nc1137411374epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563277443;
        bh=c2oqOCPw5RBqIycZlfV08G2j09rZKxOnK2tN+t+HP5g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FV3knKNzgESY76rjQX6/Ansmys/6fuSKic81JZHV2rJB/L/qxWb2K3UMXQoH879eA
         iCP/yW7WqOOPZKiE92Li+9uRbFg8pWp3ZKHiztyQBBS4wRXFc47wpi42MI11+7HBWM
         QflqSYFKEjwMOjwEIxS5kZdk5Bu9NS/MYXpkoA84=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716114401epcas1p1637c8fe99114d7c6f772c22bd06be793~x4I0Bfc0y0435704357epcas1p1V;
        Tue, 16 Jul 2019 11:44:01 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45nz7g5ktDzMqYkV; Tue, 16 Jul
        2019 11:43:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.4A.04088.F78BD2D5; Tue, 16 Jul 2019 20:43:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716114359epcas1p3a8ba56dea6e7b0fa12d671c5d4007ba1~x4IxqLV2f2518025180epcas1p33;
        Tue, 16 Jul 2019 11:43:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716114359epsmtrp2d7cc5b446e84d1dd2ba717abc0a47313~x4IxpajHA0321103211epsmtrp2Z;
        Tue, 16 Jul 2019 11:43:59 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-51-5d2db87f92e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.EC.03706.F78BD2D5; Tue, 16 Jul 2019 20:43:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716114359epsmtip1023b583a7a601b2916ef4eb8a0d79d01~x4Ixb6mtG1787717877epsmtip1O;
        Tue, 16 Jul 2019 11:43:59 +0000 (GMT)
Subject: Re: [PATCH v4 02/24] PM / devfreq: tegra30: Keep interrupt disabled
 while governor is stopped
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
Message-ID: <f691a845-18f3-a6fb-302c-a8a3fc13e5bf@samsung.com>
Date:   Tue, 16 Jul 2019 20:47:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-3-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0gTYRjm227nKS2vmfk6pOZlhOavU1dnOKmUGClqGNEPZB3u2MztNnYz
        MqFMo7Iy1BJplUUW9MOIzMKZMVArLYpIlLCkTKOyWj+WZSnStlPyv+d9n+f9nvf5vo+QKm7i
        SqKIt3M2njVReBB2pys6Pm5fW1xB4mhnLHPt+whiDjguYMyTis8BTF/7GZzxVHcjpuqnA2de
        7r+MM3/aGzHm+PXn+JpAbdvQRaR1OoYCtNWVblx7vPUq0npaFufJthWnGTlWz9lUHF9o0Rfx
        Bg2Vla/L0KlXJtJxdCqzilLxrJnTUJnZeXHri0zehSjVLtZU4m3lsYJAJaSn2Swldk5ltAh2
        DcVZ9SZrqjVeYM1CCW+IL7SYV9OJiUlqr3BHsXGswYmsFard0+e+Y+WoL/wICiSATIHf9SOS
        IyiIUJBtCF5/qZeJxQ8Eg3eeYWLxC4Fn7FvA7MjXpmlcJO4haL70UCoWXxG4m25hPlUIaYSh
        iS7kIxaS0wiq/lTiPkJKboUu5zWJD+NkDLg+vPD3g8lI6J8YQT4sJ9Ph7ftqP8bIZXD5ZoXf
        OpTcAo+6GzFRswB6T436cSCphpbBrgDx/DAYHD0nEfESqLx92r8dkJM41D44gIkZMuF+fQcu
        4hAYe9g6k00JHve9mX4ZXOntxsXhwwhaXc9kIpEMrksnvA6E1yEabrQniO1IcE6eRaLxfHCP
        H5P5JEDK4fBBhShZCn1vhiQiDoemQ1V4DaIcc+I45kRwzIng+G92HmFX0SLOKpgNnEBb6bnv
        3YL83zVG3YZOPs3uRCSBqHlylSu2QCFjdwml5k4EhJRaKNeMryhQyPVs6R7OZtHZSkyc0InU
        3tuulSpDCy3ez8/bdbQ6KTk5mUmhV6ppmgqTN05FFyhIA2vnijnOytlm5yREoLIcRYXXfSzP
        jX0Ts1dbdyotOoKpKCsjPmWqU+rHI/i/qGOdfiL4C1JmrFu+c21kT3qNw/lKl79pubZ54/uI
        rKjtsWeHe+7mDmw+2nw61JXzJLhXYy5VeDbwfUkbh4mQhO1L3vW7q2+nmvKdAw1ZORnvtIbB
        qbVJjy1LD1q29rwe7uAoTDCydIzUJrD/AKktZeLEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnG79Dt1Yg0cn+S1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyXk3fyVjQpFDxb/5HlgbGy5JdjJwcEgImEu8X
        /2PrYuTiEBLYzSixcOFNNoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKrJ/ymxWkRlggQ+Luj8OM
        IAkRgSYmiU29F9hBEswCkRI9c7dATd3MKLHt+wQWkASbgJbE/hc3wDbwCyhKXP3xmBHE5hWw
        k3j0vBfMZhFQlVixsQlskKhAhMSkaztZIGoEJU7OfAJmcwqYSmy6dRhqmbrEn3mXmCFscYlb
        T+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQv
        XS85P3cTIzjKtDR3MF5eEn+IUYCDUYmH98QenVgh1sSy4srcQ4wSHMxKIry2X7VjhXhTEiur
        Uovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBMrgr57S8wcUaIbMEZ
        IwXN2NI/ZXLf+Y5qW7Yc/pl2OsfillKQaPvtOubP8z9YbXFpPVx5dFVRwpO7dXpasZUfUqrM
        bzkG5nOuXjU7RD98uv/lnn4RX4tp206+8Qs38MyS3OwSxjn32imVU+JrRDs0WzSMKr6mv7p/
        qeZ4f0LDHyu+pconOpVYijMSDbWYi4oTAeJ2RHauAgAA
X-CMS-MailID: 20190716114359epcas1p3a8ba56dea6e7b0fa12d671c5d4007ba1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223724epcas4p2d82cecc2969fecddca67192417843418
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223724epcas4p2d82cecc2969fecddca67192417843418@epcas4p2.samsung.com>
        <20190707223303.6755-3-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> There is no real need to keep interrupt always-enabled, will be nicer
> to keep it disabled while governor is inactive.
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index a27300f40b0b..5e2b133babdd 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -11,6 +11,7 @@
>  #include <linux/devfreq.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> @@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>  {
>  	unsigned int i;
>  
> -	disable_irq(tegra->irq);
> -
>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
>  
> @@ -442,8 +441,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  	}
>  
>  	actmon_write_barrier(tegra);
> -
> -	enable_irq(tegra->irq);
>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -552,6 +549,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>  
> +	/*
> +	 * Couple device with the governor early as it is needed at
> +	 * the moment of governor's start (used by ISR).
> +	 */
> +	tegra->devfreq = devfreq;

I'm not sure it is necessary. Almost devfreq device get
the devfreq instance on probe timing through devfreq_add_device directly.


> +
>  	switch (event) {
>  	case DEVFREQ_GOV_START:
>  		devfreq_monitor_start(devfreq);
> @@ -586,10 +589,11 @@ static struct devfreq_governor tegra_devfreq_governor = {
>  
>  static int tegra_devfreq_probe(struct platform_device *pdev)
>  {
> -	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
> -	unsigned int i;
> +	struct tegra_devfreq *tegra;
> +	struct devfreq *devfreq;
>  	unsigned long rate;
> +	unsigned int i;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -625,6 +629,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
>  	tegra->irq = err;
>  
> +	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
> +
> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
> +					actmon_thread_isr, IRQF_ONESHOT,
> +					"tegra-devfreq", tegra);
> +	if (err) {
> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
> +		return err;
> +	}
> +
>  	reset_control_assert(tegra->reset);
>  
>  	err = clk_prepare_enable(tegra->clock);
> @@ -672,28 +686,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
>  
>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> -	tegra->devfreq = devfreq_add_device(&pdev->dev,
> -					    &tegra_devfreq_profile,
> -					    "tegra_actmon",
> -					    NULL);
> +	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> +				     "tegra_actmon", NULL);
>  	if (IS_ERR(tegra->devfreq)) {

Have to check 'devfreq' instead of 'tegra->devfreq'.
Did you test it? It might be failed because 'tegra->devfreq is NULL.

>  		err = PTR_ERR(tegra->devfreq);

ditto.

>  		goto remove_governor;
>  	}
>  
> -	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
> -					actmon_thread_isr, IRQF_ONESHOT,
> -					"tegra-devfreq", tegra);
> -	if (err) {
> -		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
> -		goto remove_devfreq;
> -	}
> -
>  	return 0;
>  
> -remove_devfreq:
> -	devfreq_remove_device(tegra->devfreq);
> -
>  remove_governor:
>  	devfreq_remove_governor(&tegra_devfreq_governor);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

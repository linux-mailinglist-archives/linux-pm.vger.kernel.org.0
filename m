Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB695207
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 02:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfHSX63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 19:58:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28543 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfHSX62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 19:58:28 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190819235824epoutp03d4938e896cf8f0a0c3876766e493763c~8eFtrYZus1586815868epoutp03Y
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 23:58:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190819235824epoutp03d4938e896cf8f0a0c3876766e493763c~8eFtrYZus1586815868epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566259104;
        bh=E+GmfLLHVZyoS88YiGMw3/qgcKxjHoLdHGPGSNkhHwQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Fw191GSz3UmRCHkMyYiG937xVNGYAP3E37IHmNHl6KrjslbOvbwTAk3mGtdIdFezF
         6e8LgCe/F5tL4X3aajq30w7XFb5/uK++oqDzlZB7NGwmMrYpHrfnfnuGHzJRGfLIpt
         LFFUDqB8LRGGUyXK+qA9puAGQtfZStVvLbh9Hqf8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190819235823epcas1p2ebf5b3268edbc3211f06e190d82e3c0b~8eFtJnXc21719917199epcas1p2Q;
        Mon, 19 Aug 2019 23:58:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46C9qJ4HHTzMqYll; Mon, 19 Aug
        2019 23:58:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.BB.04160.8973B5D5; Tue, 20 Aug 2019 08:58:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190819235816epcas1p3c84eeeed578b4d7cdf3bdb73a0ff7fa5~8eFmSqlTd0166901669epcas1p3-;
        Mon, 19 Aug 2019 23:58:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190819235816epsmtrp1c285dc1af80e3fa9aa87e23463e579a1~8eFmRzQJ82153121531epsmtrp1X;
        Mon, 19 Aug 2019 23:58:16 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-e1-5d5b37986a18
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.A3.03638.8973B5D5; Tue, 20 Aug 2019 08:58:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819235816epsmtip1aeba185f3baf196e40e80b0eaa5d7e83~8eFmGmes22298422984epsmtip1s;
        Mon, 19 Aug 2019 23:58:16 +0000 (GMT)
Subject: Re: [PATCH v6 02/19] PM / devfreq: tegra30: Keep interrupt disabled
 while governor is stopped
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f02267cb-7299-fcdb-dfff-97ea36ccf2e5@samsung.com>
Date:   Tue, 20 Aug 2019 09:02:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-3-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0hTcRTu5727u1qr29I8GNS6vdBY7Tpnt0gpilgkZPWPGWY3d9vEbXfs
        bpI9wDTygWlRRl17v+xpaSZLKkELsRdRSWaYhmbOzDAzNCnado387zvnfOd85/s9SExdQ0SQ
        6XYX77RzVpoIwWsaIrXa40u2pOi8FTrWWx/JXh/oROx+6TzOPs/pU7Kva08S7ODBR4gt+CER
        7Pt9Vwh2pPY0zhbffEWsCDF62i4i4z2pTWk8mNtPGIurryHjYNXMREVyxnILz5l4p4a3pwmm
        dLs5jl63KXVVqiFWx2iZpewSWmPnbHwcvTohUbsm3epbitZkcla3L5XIiSK9OH65U3C7eI1F
        EF1xNO8wWR1LHYtEzia67eZFaYJtGaPTRRt8xG0Zli/d3bjj48ydPWWVWDZqgUIUTAIVA20t
        Z/FCFEKqKQ+CV1XNQXLwHUHD8G+lHPxE8LXxGfav5W1RqUIuPEDwq/UdIQffEPSWXSb8rGmU
        BYYHqwKFUOoPgoKR3ECAUXkIOj4UBGYRVBTU9bQEOqZQs6F5uBP5sYqKh1GpNIBxah5cPSop
        /DiMSoLvHQ0KmTMVmk504X4cTMXC432flH6MUeHQ2nUmSMazIPduGeYXBipPCTV3cpBsYjX0
        NZeMGZoGvY3VShlHgLfkwBjeDVebHhFycz6C6rqXCrmgh7pLR3wKpE8hEm7VLpbTs+He6Kmx
        +SrIrhwdW2gy9A8VKfx0fz7/gFqmzIHXHW1Bh9AcaZwdaZwFaZwF6b/YWYRfQ9N5h2gz8yLj
        iBl/4VUo8GajWA+6/yKhHlEkoiepjMeSU9QKLlPMstUjIDE6VLXzpC+lMnFZu3inkOp0W3mx
        Hhl8p30YiwhLE3w/wO5KZQzRer2ejWFiDQxDh6vODbMpasrMufgMnnfwzn99QWRwRDbam709
        E13yrvm8o2hzrf2KI6z/YWPp4wXm4nbN7flz0e238S3r2kP3eK53d1ZKXv2GijcTkp7f6HS3
        CmG9prKEb5u2axnhfZJpa3hJ1lDj04a1A+IHvcudvLVp1kJak1O+8olqRsFxUJdHl8eudwdf
        uJjJHs2biPeSFRuFVk/GAI2LFo6Jwpwi9xdDP7IkyQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO4M8+hYgyk3pSxeHtK0WP3xMaNF
        y6xFLBZnm96wW1zeNYfN4nPvEUaLzi+z2CxuN65gs/i5ax6LRd/aS2wOXB477i5h9Ng56y67
        R2/zOzaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgynj97BlLwUO5ihezNzI3MN6Q6GLk5JAQ
        MJG43jOVtYuRi0NIYDejxMJ3L1khEpIS0y4eZe5i5ACyhSUOHy6GqHnLKNF1ZS4LSI2wQIbE
        j8+b2EASIgJNTBKbei+wgzjMAu2MEmu77zJDtGxllDh8+QUbSAubgJbE/hc3wGx+AUWJqz8e
        M4LYvAJ2Er9nTQWzWQRUJVZOmQV2hqhAhMThHbOgagQlTs58AraaU8BM4mjjU3YQm1lAXeLP
        vEvMELa4xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHG9aWjsYT5yIP8QowMGoxMPrMS0qVog1say4MvcQowQHs5IIb8Uc
        oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZG+6jTSTGT
        57858Fbc+V0zU9ons1l6krNDPG5sOv8p883G+XM68y57Cx+7Wve70iH1yJoPSn7vTrAr+p2/
        MKlLVYif/yrvet+m/vzF69sX7ZhxZJvqhIRtMo/TXPY4SD251LF7HUO2wKOCiZ4mT/5ecT7o
        qBi2gevQwpxZ0ZKH+GK5j6zTW1Ltr8RSnJFoqMVcVJwIAO/uJZizAgAA
X-CMS-MailID: 20190819235816epcas1p3c84eeeed578b4d7cdf3bdb73a0ff7fa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212557epcas3p1d5dd6c484e6fc1ed9feb619a24c1b745
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212557epcas3p1d5dd6c484e6fc1ed9feb619a24c1b745@epcas3p1.samsung.com>
        <20190811212315.12689-3-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 12. 오전 6:22, Dmitry Osipenko wrote:
> There is no real need to keep interrupt always-enabled, will be nicer
> to keep it disabled while governor is inactive.
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 47 ++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index a27300f40b0b..8be6a33beb9c 100644
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
> -	if (IS_ERR(tegra->devfreq)) {
> -		err = PTR_ERR(tegra->devfreq);
> +	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> +				     "tegra_actmon", NULL);
> +	if (IS_ERR(devfreq)) {
> +		err = PTR_ERR(devfreq);
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

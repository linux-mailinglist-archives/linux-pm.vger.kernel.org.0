Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2758EF560
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfKEGIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:08:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKEGIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:08:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA568ADZ075972;
        Tue, 5 Nov 2019 00:08:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572934090;
        bh=Lj8BuL9H7FwKRGUfF3Cm96AZFzlChHbAeMHo+XORVoY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ErOLakDQbiDbOLj3bzCsc+GL6gKpscJhlH5/6IAu5lSYNGJbdQJ72jRR8cXMkX8Np
         /zLi02UkEswhjGZxWaeFYeieseEHoPmWXr+9WKXBjPOaUZySYrxrkD93RsCEHfuM/1
         JZ/KYzCCocAosFZyuySaxAHiaHuhJwY6pCScF14I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA568A60059425;
        Tue, 5 Nov 2019 00:08:10 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 00:07:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 00:07:55 -0600
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5686kK089087;
        Tue, 5 Nov 2019 00:08:07 -0600
Subject: Re: [PATCH -next] thermal: ti-soc-thermal: Remove dev_err() on
 platform_get_irq() failure
To:     YueHaibing <yuehaibing@huawei.com>, <edubezval@gmail.com>,
        <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191102075654.36700-1-yuehaibing@huawei.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <655d95c2-20d2-e03f-539e-32fbe69da9fc@ti.com>
Date:   Tue, 5 Nov 2019 11:38:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102075654.36700-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/11/19 1:26 PM, YueHaibing wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 2fa78f7..89c3ba7 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -787,10 +787,9 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
>   	int ret;
>   
>   	bgp->irq = platform_get_irq(pdev, 0);
> -	if (bgp->irq < 0) {
> -		dev_err(&pdev->dev, "get_irq failed\n");
> +	if (bgp->irq < 0)
>   		return bgp->irq;
> -	}
> +
>   	ret = request_threaded_irq(bgp->irq, NULL,
>   				   ti_bandgap_talert_irq_handler,
>   				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> 

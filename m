Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E881CF4DA
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELMxC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:53:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgELMxC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 08:53:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BFDB30E;
        Tue, 12 May 2020 05:53:02 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02C73F71E;
        Tue, 12 May 2020 05:52:59 -0700 (PDT)
Subject: Re: [PATCH v3] memory/samsung: reduce protected code area in IRQ
To:     Bernard Zhao <bernard@vivo.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200512123149.40162-1-bernard@vivo.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <99adbca2-7f8f-b255-8538-8819f83d1991@arm.com>
Date:   Tue, 12 May 2020 13:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200512123149.40162-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/12/20 1:31 PM, Bernard Zhao wrote:
> This change will speed-up a bit this IRQ processing and there
> is no need to protect return value or printing.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

LGTM

Acked-by: Lukasz Luba <lukasz.luba@arm.com>


> ---
> Changes since v1:
> *change release lock before the if statement.
> *revert dmc->df->lock mutex lock to protect function
> exynos5_dmc_perf_events_check
> 
> Changes since v2:
> *Improve subject and commit message
> 
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1238888/
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 22a43d662833..25196d6268e2 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1346,15 +1346,13 @@ static irqreturn_t dmc_irq_thread(int irq, void *priv)
>   	struct exynos5_dmc *dmc = priv;
>   
>   	mutex_lock(&dmc->df->lock);
> -
>   	exynos5_dmc_perf_events_check(dmc);
> -
>   	res = update_devfreq(dmc->df);
> +	mutex_unlock(&dmc->df->lock);
> +
>   	if (res)
>   		dev_warn(dmc->dev, "devfreq failed with %d\n", res);
>   
> -	mutex_unlock(&dmc->df->lock);
> -
>   	return IRQ_HANDLED;
>   }
>   
> 

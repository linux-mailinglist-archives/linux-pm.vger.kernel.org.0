Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3C23B8EB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHDKkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:40:11 -0400
Received: from foss.arm.com ([217.140.110.172]:42368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgHDKkL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 06:40:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD2121FB;
        Tue,  4 Aug 2020 03:40:10 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503063F718;
        Tue,  4 Aug 2020 03:40:09 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC] memory: exynos5422-dmc: Document mutex scope
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200724180857.22119-1-krzk@kernel.org>
Message-ID: <3522860a-8158-6e71-9d65-01d0e0c15f0d@arm.com>
Date:   Tue, 4 Aug 2020 11:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200724180857.22119-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7/24/20 7:08 PM, Krzysztof Kozlowski wrote:
> Document scope of the mutex used by driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> It seems mutex was introduced to protect:
> 1. setting actual frequency/voltage,
> 2. dmc->curr_rate (in exynos5_dmc_get_cur_freq()).
> 
> However dmc->curr_rate in exynos5_dmc_get_status() is not protected. Is
> it a bug?

The callback get_dev_status() from devfreq->profile, which here is the
exynos5_dmc_get_status() should be already called with devfreq->lock
mutex hold, like e.g from simple_ondemand governor or directly
using update_devfreq exported function:
update_devfreq()
   ->get_target_freq()
     devfreq_update_stats()
         df->profile->get_dev_status()

The dmc->curr_rate is also used from sysfs interface from devfreq.
The local dmc lock serializes also this use case (when the HW freq
has changed but not set yet into curr_rate.


> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 93e9c2429c0d..0388066a7d96 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -114,6 +114,7 @@ struct exynos5_dmc {
>   	void __iomem *base_drexi0;
>   	void __iomem *base_drexi1;
>   	struct regmap *clk_regmap;
> +	/* Protects curr_rate and frequency/voltage setting section */
>   	struct mutex lock;
>   	unsigned long curr_rate;
>   	unsigned long curr_volt;
> 

I assume this missing comment for the lock was required by some scripts.
In this case LGTM:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

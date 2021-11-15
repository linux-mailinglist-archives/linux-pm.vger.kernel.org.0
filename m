Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3256545016B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhKOJdz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 04:33:55 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40074 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhKOJdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 04:33:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UwcO0OZ_1636968655;
Received: from 30.21.164.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UwcO0OZ_1636968655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 17:30:55 +0800
Message-ID: <cd7d5131-1677-cf3a-cd78-b5df93443a60@linux.alibaba.com>
Date:   Mon, 15 Nov 2021 17:31:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] power: supply: core: Use library interpolation
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20211113233750.1763820-1-linus.walleij@linaro.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211113233750.1763820-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

On 2021/11/14 7:37, Linus Walleij wrote:
> The power supply core appears to contain two open coded
> linear interpolations. Use the kernel fixpoint arithmetic
> interpolation library function instead.
> 
> Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for your patch :)

> ---
> Chunyan: The sc27xx fuel gauge seems to be the only driver
> using this, so it'd be great if you could test this to make
> sure it works as intended.
> ---
>   drivers/power/supply/power_supply_core.c | 55 ++++++++++++------------
>   1 file changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index fc12a4f407f4..038e35ea7fbe 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -21,6 +21,7 @@
>   #include <linux/power_supply.h>
>   #include <linux/property.h>
>   #include <linux/thermal.h>
> +#include <linux/fixp-arith.h>
>   #include "power_supply.h"
>   
>   /* exported for the APM Power driver, APM emulation */
> @@ -783,26 +784,24 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>   int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
>   				    int table_len, int temp)
>   {
> -	int i, resist;
> +	int i, high, low;
>   
>   	for (i = 0; i < table_len; i++)
>   		if (temp > table[i].temp)
>   			break;
>   
> -	if (i > 0 && i < table_len) {
> -		int tmp;
> -
> -		tmp = (table[i - 1].resistance - table[i].resistance) *
> -			(temp - table[i].temp);
> -		tmp /= table[i - 1].temp - table[i].temp;
> -		resist = tmp + table[i].resistance;
> -	} else if (i == 0) {
> -		resist = table[0].resistance;
> -	} else {
> -		resist = table[table_len - 1].resistance;
> -	}
> -
> -	return resist;
> +	/* The library function will deal with high == low */
> +	if (i > 0)
> +		high = i - 1;

If the index 'i' is equal with 'table_len', table[table_len] is invalid, 
so the original logic will just return 'table[table_len - 1].resistance' .

Otherwise looks good to me.

> +	else
> +		high = i; /* i.e. i == 0 */
> +	low = i;
> +
> +	return fixp_linear_interpolate(table[low].temp,
> +				       table[low].resistance,
> +				       table[high].temp,
> +				       table[high].resistance,
> +				       temp);
>   }
>   EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
>   
> @@ -821,24 +820,24 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
>   int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
>   				int table_len, int ocv)
>   {
> -	int i, cap, tmp;
> +	int i, high, low;
>   
>   	for (i = 0; i < table_len; i++)
>   		if (ocv > table[i].ocv)
>   			break;
>   
> -	if (i > 0 && i < table_len) {
> -		tmp = (table[i - 1].capacity - table[i].capacity) *
> -			(ocv - table[i].ocv);
> -		tmp /= table[i - 1].ocv - table[i].ocv;
> -		cap = tmp + table[i].capacity;
> -	} else if (i == 0) {
> -		cap = table[0].capacity;
> -	} else {
> -		cap = table[table_len - 1].capacity;
> -	}
> -
> -	return cap;
> +	/* The library function will deal with high == low */
> +	if (i > 0)
> +		high = i - 1;
> +	else
> +		high = i; /* i.e. i == 0 */
> +	low = i;
> +
> +	return fixp_linear_interpolate(table[low].ocv,
> +				       table[low].capacity,
> +				       table[high].ocv,
> +				       table[high].capacity,
> +				       ocv);
>   }
>   EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
>   
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8950B453DBD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 02:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhKQBf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 20:35:28 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51108 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhKQBf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 20:35:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UwwJKOo_1637112748;
Received: from 30.21.164.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UwwJKOo_1637112748)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Nov 2021 09:32:28 +0800
Message-ID: <6919ca6d-0952-fbef-bdfc-f9e93fa17707@linux.alibaba.com>
Date:   Wed, 17 Nov 2021 09:33:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4] power: supply: core: Use library interpolation
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20211116230233.2167104-1-linus.walleij@linaro.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211116230233.2167104-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

On 2021/11/17 7:02, Linus Walleij wrote:
> The power supply core appears to contain two open coded
> linear interpolations. Use the kernel fixpoint arithmetic
> interpolation library function instead.
> 
> Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

LGTM. Thanks :)
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> ChangeLog v3->v4:
> - Fix the code to really provide the same x index for both
>    datapoints at the end of the table. Thanks again Baolin!
> ChangeLog v2->v3:
> - Actually implement the code as I say. Missed one occurence.
> ChangeLog v1->v2:
> - Break the table loop at table_len - 1 so we don't index
>    past the end of the table. (Thanks Baolin!)
> 
> Chunyan: The sc27xx fuel gauge seems to be the only driver
> using this, so it'd be great if you could test this to make
> sure it works as intended.
> ---
>   drivers/power/supply/power_supply_core.c | 61 ++++++++++++------------
>   1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index fc12a4f407f4..2907b84ceea9 100644
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
> @@ -783,26 +784,25 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>   int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
>   				    int table_len, int temp)
>   {
> -	int i, resist;
> +	int i, high, low;
>   
> -	for (i = 0; i < table_len; i++)
> +	/* Break loop at table_len - 1 because that is the highest index */
> +	for (i = 0; i < table_len - 1; i++)
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
> +	if ((i == 0) || (i == (table_len - 1)))
> +		high = i;
> +	else
> +		high = i - 1;
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
> @@ -821,24 +821,25 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
>   int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
>   				int table_len, int ocv)
>   {
> -	int i, cap, tmp;
> +	int i, high, low;
>   
> -	for (i = 0; i < table_len; i++)
> +	/* Break loop at table_len - 1 because that is the highest index */
> +	for (i = 0; i < table_len - 1; i++)
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
> +	if ((i == 0) || (i == (table_len - 1)))
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

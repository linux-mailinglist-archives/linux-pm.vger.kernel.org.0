Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58A44527C4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 03:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377764AbhKPCd5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 21:33:57 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41012 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346907AbhKPCbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 21:31:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uwnk6wb_1637029701;
Received: from 30.21.164.20(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uwnk6wb_1637029701)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 10:28:22 +0800
Message-ID: <4cf76c42-2357-c000-86d7-13b2abf5dcbb@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 10:29:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] power: supply: core: Use library interpolation
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20211116003844.2133683-1-linus.walleij@linaro.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211116003844.2133683-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

On 2021/11/16 8:38, Linus Walleij wrote:
> The power supply core appears to contain two open coded
> linear interpolations. Use the kernel fixpoint arithmetic
> interpolation library function instead.
> 
> Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Break the table loop at table_len - 1 so we don't index
>    past the end of the table. (Thanks Baolin!)
> 
> Chunyan: The sc27xx fuel gauge seems to be the only driver
> using this, so it'd be great if you could test this to make
> sure it works as intended.
> ---
>   drivers/power/supply/power_supply_core.c | 59 ++++++++++++------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index fc12a4f407f4..2983466a4914 100644
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
> +	if (i > 0)
> +		high = i - 1;
> +	else
> +		high = i; /* i.e. i == 0 */
> +	low = i;
> +
> +	return fixp_linear_interpolate(table[low].temp,
> +				       table[low].resistance,
> +				       table[high].temp,
> +				       table[high].resistance,
> +				       temp);
Thanks for your patch, and overall looks good to me. But I still think 
we should not do interpolation if the temperature is larger than the 
maximum value of the table, we can just return the maximum value of the 
table instead. Something like below untested code, how do you think?

--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -783,26 +783,27 @@ void power_supply_put_battery_info(struct 
power_supply *psy,
  int power_supply_temp2resist_simple(struct 
power_supply_resistance_temp_table *table,
                                     int table_len, int temp)
  {
-       int i, resist;
+       int i, high, low;

         for (i = 0; i < table_len; i++)
                 if (temp > table[i].temp)
                         break;

-       if (i > 0 && i < table_len) {
-               int tmp;
-
-               tmp = (table[i - 1].resistance - table[i].resistance) *
-                       (temp - table[i].temp);
-               tmp /= table[i - 1].temp - table[i].temp;
-               resist = tmp + table[i].resistance;
-       } else if (i == 0) {
-               resist = table[0].resistance;
-       } else {
-               resist = table[table_len - 1].resistance;
-       }
-
-       return resist;
+       if (i == table_len)
+               return table[table_len - 1].resistance;
+
+       /* The library function will deal with high == low */
+       if (i > 0)
+               high = i - 1;
+       else
+               high = i; /* i.e. i == 0 */
+       low = i;
+
+       return fixp_linear_interpolate(table[low].temp,
+                                      table[low].resistance,
+                                      table[high].temp,
+                                      table[high].resistance,
+                                      temp);
  }

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
> +	/* Break loop at table_len - 1 because that is the highest index */
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

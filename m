Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93312450266
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhKOK13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 05:27:29 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41295 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237566AbhKOK1D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 05:27:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UwcmVR2_1636971842;
Received: from 30.21.164.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UwcmVR2_1636971842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 18:24:02 +0800
Message-ID: <cd74a6c0-b9c9-c174-dc14-29ea30c64bcc@linux.alibaba.com>
Date:   Mon, 15 Nov 2021 18:24:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] power: supply: core: Break capacity loop
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20211114231207.1877495-1-linus.walleij@linaro.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211114231207.1877495-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2021/11/15 7:12, Linus Walleij wrote:
> We should not go on looking for more capacity tables after
> we realize we have looked at the last one in
> power_supply_find_ocv2cap_table().
> 
> Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the battery OCV capacity table")
> Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/power/supply/power_supply_core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 038e35ea7fbe..885c92dc0379 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -852,6 +852,10 @@ power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
>   		return NULL;
>   
>   	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
> +		/* Out of capacity tables */
> +		if (!info->ocv_table[i])
> +			break;
> +
>   		temp_diff = abs(info->ocv_temp[i] - temp);
>   
>   		if (temp_diff < best_temp_diff) {
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAE31ED13
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhBRRO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 12:14:29 -0500
Received: from mail.manjaro.org ([176.9.38.148]:40322 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhBROyS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 09:54:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 18BD93E60861;
        Thu, 18 Feb 2021 15:53:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CbrTc1Qv79oS; Thu, 18 Feb 2021 15:53:29 +0100 (CET)
Subject: Re: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
To:     Martin Ashby <martin@ashbysoft.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>
References: <20210218124250.128008-1-martin@ashbysoft.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <52cbdca7-feb2-6d6f-fa53-c36848587577@manjaro.org>
Date:   Thu, 18 Feb 2021 15:53:27 +0100
MIME-Version: 1.0
In-Reply-To: <20210218124250.128008-1-martin@ashbysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

thanks for the patch. Now everything is looking good.

Just one small thing for the future: Please version your patches. Even 
when the patch subject changes. It helps everyone to distinguish clearly 
between different versions of a patch.

> CHARGE_NOW is expected by some user software (such as waybar)
> instead of 'CAPACITY', in order to correctly calculate remaining battery
> life.
> 
> Signed-off-by: Martin Ashby <martin@ashbysoft.com>
> ---
>   drivers/power/supply/cw2015_battery.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
> index 0146f1bfc..aa1f1771b 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -511,6 +511,11 @@ static int cw_battery_get_property(struct power_supply *psy,
>   			val->intval = 0;
>   		break;
>   
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		val->intval = cw_bat->battery.charge_full_design_uah;
> +		val->intval = val->intval * cw_bat->soc / 100;
> +		break;
> +
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>   		if (cw_battery_valid_time_to_empty(cw_bat) &&
>   		    cw_bat->battery.charge_full_design_uah > 0) {
> @@ -542,6 +547,7 @@ static enum power_supply_property cw_battery_properties[] = {
>   	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>   	POWER_SUPPLY_PROP_CHARGE_FULL,
>   	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
>   	POWER_SUPPLY_PROP_CURRENT_NOW,
>   };
>   
> 

Reviewed-by: Tobias Schramm <t.schramm@manjaro.org>
Tested-by: Tobias Schramm <t.schramm@manjaro.org>

Cheers,
Tobias

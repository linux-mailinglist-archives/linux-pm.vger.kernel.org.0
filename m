Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8D366FB0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbhDUQFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 12:05:08 -0400
Received: from muru.com ([72.249.23.125]:57252 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235921AbhDUQFI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 12:05:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 921DB80F7;
        Wed, 21 Apr 2021 16:05:56 +0000 (UTC)
Date:   Wed, 21 Apr 2021 19:04:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     zhuguangqing83@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Carl Philipp Klemm <philipp@uvos.xyz>
Subject: Re: [PATCH v2] power: supply: cpcap-battery: fix invalid usage of
 list cursor
Message-ID: <YIBNDrHlwqn5hrl2@atomide.com>
References: <20210421143650.16045-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421143650.16045-1-zhuguangqing83@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

* zhuguangqing83@gmail.com <zhuguangqing83@gmail.com> [210421 14:38]:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
> 
> Fix invalid usage of a list_for_each_entry in cpcap_battery_irq_thread().
> Empty list or fully traversed list points to list head, which is not
> NULL (and before the first element containing real data).
> 
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---
> v2:
>   - Modify commit message and code as suggested by Sebastian.

Thanks looks OK to me. Looks like there's no flag we need to set there when
the entry is found, so this should do for the check.

Hmm I wonder if this just might fix the issue where booting with a USB
charger connected can hang..

Reviewed-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/power/supply/cpcap-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
> index 6d5bcdb9f45d..a3fc0084cda0 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -786,7 +786,7 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
>  			break;
>  	}
>  
> -	if (!d)
> +	if (list_entry_is_head(d, &ddata->irq_list, node))
>  		return IRQ_NONE;
>  
>  	latest = cpcap_battery_latest(ddata);
> -- 
> 2.17.1
> 

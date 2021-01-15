Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC832F7C79
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 14:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbhAONYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 08:24:45 -0500
Received: from muru.com ([72.249.23.125]:45008 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbhAONYo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 08:24:44 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5197F805C;
        Fri, 15 Jan 2021 13:24:22 +0000 (UTC)
Date:   Fri, 15 Jan 2021 15:24:17 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: cpcap-charger: Fix power_supply_put
 on null battery pointer
Message-ID: <YAGXgWeWvy/0FyqN@atomide.com>
References: <20210115131524.71339-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115131524.71339-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Colin King <colin.king@canonical.com> [210115 13:15]:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the pointer battery is null there is a null pointer
> dereference on the call to power_supply_put.  Fix this by only
> performing the put if battery is not null.
> 
> Addresses-Coverity: ("Dereference after null check")
> Fixes: 4bff91bb3231 ("power: supply: cpcap-charger: Fix missing power_supply_put()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Oopsie, thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>


>  drivers/power/supply/cpcap-charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
> index 823d666f09e0..641dcad1133f 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -300,8 +300,9 @@ cpcap_charger_get_bat_const_charge_voltage(struct cpcap_charger_ddata *ddata)
>  				&prop);
>  		if (!error)
>  			voltage = prop.intval;
> +
> +		power_supply_put(battery);
>  	}
> -	power_supply_put(battery);
>  
>  	return voltage;
>  }
> -- 
> 2.29.2
> 

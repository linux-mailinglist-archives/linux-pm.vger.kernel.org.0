Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BBB18E224
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCUOrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 10:47:14 -0400
Received: from muru.com ([72.249.23.125]:32876 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgCUOrO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Mar 2020 10:47:14 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 97DA6810E;
        Sat, 21 Mar 2020 14:48:00 +0000 (UTC)
Date:   Sat, 21 Mar 2020 07:47:10 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arthur Demchenkov <spinal.by@gmail.com>
Cc:     Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>,
        sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 03/15] power: supply: cpcap-battery: Fix battery low
 status reporting
Message-ID: <20200321144710.GV37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315151206.30909-3-spinal.by@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315151206.30909-3-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur Demchenkov <spinal.by@gmail.com> [200315 15:15]:
> If we hit battery low once, we should stick on reporting it until the
> charger is connected. This way low->counter_uah will be updated
> properly, and that will allow us to get more accurate charge_full value.
> 
> Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
> ---
>  drivers/power/supply/cpcap-battery.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
> index 52f03a2662a5..8a58ad943960 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -421,11 +421,14 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
>  static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
>  {
>  	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
> +	static bool is_low;
>  
> -	if (state->current_ua && state->voltage <= 3300000)
> -		return true;
> +	if (state->current_ua > 0 && (state->voltage <= 3300000 || is_low))
> +		is_low = true;
> +	else
> +		is_low = false;
>  
> -	return false;
> +	return is_low;
>  }

Please set up bitmask in ddata for unsigned int battery_low:1; instead of
using a static variable here. If we ever had two instances of cpcap on the
same device the static variable here would not work :)

Regards,

Tony


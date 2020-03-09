Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05E17EC67
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 00:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCIXGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 19:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIXGL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 19:06:11 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0D92146E;
        Mon,  9 Mar 2020 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583795170;
        bh=9BVVycSfpPDRZx0dw2o2wut/V1EucDmySGq7rPC2jrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnVMp4ASBSODGCmZ3WK2Rz1kanMf4TsjqcusgAggwMPCM65hs7a9vmbTHzeiwRR60
         IO4SMdCaP78MKOwgQrNqijBzP+7jOH4ZASuSI7d2vXvY2pFa8X5yvHltXnbpHHj3jq
         pmyUi0LTrsFrdTJ4oXi32RATyuPzI4w6xVrWPyRo=
Received: by pali.im (Postfix)
        id 67F9BBE0; Tue, 10 Mar 2020 00:06:08 +0100 (CET)
Date:   Tue, 10 Mar 2020 00:06:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: bq27xxx_battery: Silence
 deferred-probe error
Message-ID: <20200309230608.aur2iddomzrdw4pq@pali>
References: <20200308215143.27823-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200308215143.27823-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 09 March 2020 00:51:43 Dmitry Osipenko wrote:
> The driver fails to probe with -EPROBE_DEFER if battery's power supply
> (charger driver) isn't ready yet and this results in a bit noisy error
> message in KMSG during kernel's boot up. Let's silence the harmless
> error message.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Hello Dmitry! This change make sense, it is really not an error when
bq27k device registration is deferred. You can add my:

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/power/supply/bq27xxx_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 195c18c2f426..664e50103eaa 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1885,7 +1885,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  
>  	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(di->bat)) {
> -		dev_err(di->dev, "failed to register battery\n");
> +		if (PTR_ERR(di->bat) == -EPROBE_DEFER)
> +			dev_dbg(di->dev, "failed to register battery, deferring probe\n");
> +		else
> +			dev_err(di->dev, "failed to register battery\n");
>  		return PTR_ERR(di->bat);
>  	}
>  

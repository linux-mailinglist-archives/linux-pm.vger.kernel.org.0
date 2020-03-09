Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA517E09D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCIMwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 08:52:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56882 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCIMwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 08:52:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 029CpxOA012547;
        Mon, 9 Mar 2020 07:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583758319;
        bh=J/GfNup1LbUZmzynPCLejvsNC0QrUORNG+Rvtweybn0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dBopjlb1HaIwBaw1TQwj0v5NuTqCLZgs6UnQLgTxJYosKuHNXUyNZ2uHd8M4Wk8xA
         BrtOGFBSHMiTccdV4W5BhD7woUMHzVeMYY9zEHE9ZL0UHPMCDAupnQzfec+O0UhNPb
         vnH6//EB6fWZaxEr8XWheZYeWW0n8aDWyBt6bY1g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 029CpxZ8022346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Mar 2020 07:51:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Mar
 2020 07:51:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Mar 2020 07:51:59 -0500
Received: from [10.250.77.18] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 029CpwtI045259;
        Mon, 9 Mar 2020 07:51:58 -0500
Subject: Re: [PATCH v1] power: supply: bq27xxx_battery: Silence deferred-probe
 error
To:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200308215143.27823-1-digetx@gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <7493a430-905e-baf4-1265-a6b3eb31f79f@ti.com>
Date:   Mon, 9 Mar 2020 08:51:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200308215143.27823-1-digetx@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/8/20 5:51 PM, Dmitry Osipenko wrote:
> The driver fails to probe with -EPROBE_DEFER if battery's power supply
> (charger driver) isn't ready yet and this results in a bit noisy error
> message in KMSG during kernel's boot up. Let's silence the harmless
> error message.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---


Reviewed-by: Andrew F. Davis <afd@ti.com>


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
> 

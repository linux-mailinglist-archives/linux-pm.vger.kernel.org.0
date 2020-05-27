Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D65A1E34AF
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725271AbgE0BYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 21:24:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53710 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0BYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 21:24:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04R1OeNe063851;
        Tue, 26 May 2020 20:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590542680;
        bh=ADdbGb/hIBjYZiW4ec9QCkuMgaagk2p6/g+owkkLpUA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=RX2mmeg7ubG+IMbmQBaha0GNc/WJk/VMEX/58PNCKR2ZGK6I/dpduz+TFtCWMcUis
         OI3v1xX0S40zey47iTCjeaoSk527MAqQ4EpMxNqdVz3YXAF8LIHUwr7s02Yr9568yc
         q+a1YrHQ6hQgF9B12xY8JDftowLp8lFDrENe+JMA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04R1Oen7069277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 20:24:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 20:24:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 20:24:40 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04R1OdmM119336;
        Tue, 26 May 2020 20:24:39 -0500
Subject: Re: [PATCH 1/2] power: supply: bq27xxx_battery: Notify about all
 battery changes
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20200525141200.17199-1-krzk@kernel.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
Date:   Tue, 26 May 2020 21:24:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525141200.17199-1-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/25/20 10:11 AM, Krzysztof Kozlowski wrote:
> All battery related data could be important for user-space.  For example
> time-to-full could be shown to user on the screen or health could be
> monitored for any issues.  Instead of comparing few selected old/new
> values, just check if anything changed in the cache.
> 


At least some value will change every time we poll the battery, are we
okay with having power_supply_changed() called every time?

Andrew


> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 942c92127b6d..33c26d42cd02 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1612,12 +1612,10 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  			di->charge_design_full = bq27xxx_battery_read_dcap(di);
>  	}
>  
> -	if ((di->cache.capacity != cache.capacity) ||
> -	    (di->cache.flags != cache.flags))
> +	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0) {
>  		power_supply_changed(di->bat);
> -
> -	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
>  		di->cache = cache;
> +	}
>  
>  	di->last_update = jiffies;
>  }
> 

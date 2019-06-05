Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE73136136
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfFEQ0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:26:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43488 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFEQ0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:26:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x55GQ3FR089735;
        Wed, 5 Jun 2019 11:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559751963;
        bh=EMqHxFFz2e3EAXX4FcyZTIL/l3V900zRWLYvMEpJ64w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F8yhHcp0oL89eOxepuEfzj7a55hSXsRPHIpMlTCG4AI4XqxC1tOZ/T9JmmWdtV6ez
         FEUnTxsEb9QFC2g9eQPbNg4AaPNz9F/D1NVYkVarhLMxTDzIfHCZOyoDswsCTBjxcl
         dKkuz8ITQ1qdOr8IINCZ87Sw5s/LcDJqJ1q1UJdI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x55GQ3n1070809
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 11:26:03 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 11:26:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 11:26:02 -0500
Received: from [10.250.67.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x55GQ2Xx012525;
        Wed, 5 Jun 2019 11:26:02 -0500
Subject: Re: [PATCH v3 2/2] power: supply: ucs1002: Add HWMON interface
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <linux-pm@vger.kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
 <20190605072323.21990-3-andrew.smirnov@gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <d9d8b0c4-e9f4-5a92-3832-3449153f807d@ti.com>
Date:   Wed, 5 Jun 2019 12:26:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605072323.21990-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/5/19 3:23 AM, Andrey Smirnov wrote:
> Expose current sensors found on UCS1002 via HWMON.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>   drivers/power/supply/ucs1002_power.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> index 677f20a4d76f..a4b6b37549cf 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
>   		return ret;
>   	}
>   
> +	ret = devm_power_supply_add_hwmon_sysfs(info->charger);

Could this be added to the core power supply framework on registering so 
all devices get this, vs each driver having to add this line?

Andrew

> +	if (ret) {
> +		dev_err(dev, "Failed to add hmwon attributes: %d\n", ret);
> +		return ret;
> +	}
> +
>   	ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regval);
>   	if (ret) {
>   		dev_err(dev, "Failed to read pin status: %d\n", ret);
> 

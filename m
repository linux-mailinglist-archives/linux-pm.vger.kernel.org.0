Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2D23120C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbgG1S4s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 14:56:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38682 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgG1S4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 14:56:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SIukBo042254;
        Tue, 28 Jul 2020 13:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595962606;
        bh=TsBj4IyXyiAC4vsRIW7YyeVgfCcS4eXV9QnjvdxD88E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MeAMExUNGridwucgq9A9A8v3aBYvEJlze23Bzj7tKfJtGmoR136GXiDn/V4spyTCZ
         t/Cw46I3hVP+uun5EGolqwOe3tGigNwhDhUkQSkRp6Yf5wihgZqzIf0YP6Tphz2Xfp
         bl3lCeC6mi6rkOYxD0Tc4/IZNz/x/sjuyEFNxu4s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06SIukBP000847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 13:56:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 13:56:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 13:56:45 -0500
Received: from [10.250.35.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SIujXk051016;
        Tue, 28 Jul 2020 13:56:45 -0500
Subject: Re: [PATCH v4 2/4] power: supply: bq27xxx_battery: Add the BQ27561
 Battery monitor
To:     Sebastian Reichel <sre@kernel.org>
CC:     <afd@ti.com>, <pali@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
References: <20200728141113.31518-1-dmurphy@ti.com>
 <20200728141113.31518-2-dmurphy@ti.com>
 <20200728181755.6bkhp7j3cqtpooof@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7035eebd-0324-6cf0-1de7-75eb4524cb94@ti.com>
Date:   Tue, 28 Jul 2020 13:56:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728181755.6bkhp7j3cqtpooof@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 7/28/20 1:17 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Jul 28, 2020 at 09:11:11AM -0500, Dan Murphy wrote:
>> Add the Texas Instruments BQ27561 battery monitor.  The register address
>> map is laid out the same as compared to other devices within the file.
>> The battery status register has differing bits to determine if the
>> battery is full, discharging or dead.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/power/supply/bq27xxx_battery.c     | 68 +++++++++++++++++++++-
>>   drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>>   include/linux/power/bq27xxx_battery.h      |  1 +
>>   3 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 942c92127b6d..654d38bcd7e0 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -43,6 +43,7 @@
>>    * http://www.ti.com/product/bq27411-g1
>>    * http://www.ti.com/product/bq27441-g1
>>    * http://www.ti.com/product/bq27621-g1
>> + * https://www.ti.com/lit/gpn/bq27z561
> Applying this failed, because I applied a patch converting the
> http urls to https. I would have fixed this silently, but it made
> me notice the chip name is bq27z561 instead of simply bq27561.
>
> You named it without the 'z' everywhere, is there a reason?
> Searching for bq27561 basically only finds your patches and
> you decided not to drop the z for the bq28z610.

At the time I was working on the BQ27750 as well and that has no letters 
in it so I was following that part number.

I will add the z in and rebase so the patch applies cleanly

Dan

>
> -- Sebastian

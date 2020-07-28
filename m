Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40643230BFD
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgG1OEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 10:04:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58244 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgG1OEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 10:04:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SE4D6C110713;
        Tue, 28 Jul 2020 09:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595945053;
        bh=XRCyFICfAbzoSRKBaeClzmOc5bpzSUxQPEJq6VvvJi8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LdI8BzQj93XvNZkZ4d4oESBsQm56cgloU20cB8l7PycNEa3+0aQqKRs0t3l667Hdv
         OnvPzyHESd0qTXUbz4bDMZFJKl8zP3o2HbwYRvOEPxHN2qGnV5UuopVDlI8HDPchXP
         QOo5hNE1gGSE2sqqHtxkJaNbzO32ABIypk1bDxfM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06SE4Dvx057786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 09:04:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 09:04:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 09:04:13 -0500
Received: from [10.250.35.192] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SE4D1n101658;
        Tue, 28 Jul 2020 09:04:13 -0500
Subject: Re: [PATCH v3 2/4] power: supply: bq27xxx_battery: Add the BQ27561
 Battery monitor
To:     Sebastian Reichel <sre@kernel.org>
CC:     <afd@ti.com>, <pali@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
References: <20200721163206.25438-1-dmurphy@ti.com>
 <20200721163206.25438-2-dmurphy@ti.com>
 <20200727223646.vjnkyrmipwin3pj6@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bc31b9d8-d114-e776-84fd-e05a014b74eb@ti.com>
Date:   Tue, 28 Jul 2020 09:04:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727223646.vjnkyrmipwin3pj6@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 7/27/20 5:36 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Jul 21, 2020 at 11:32:04AM -0500, Dan Murphy wrote:
>> Add the Texas Instruments BQ27561 battery monitor.  The register address
>> map is laid out the same as compared to other devices within the file.
>> The battery status register has differing bits to determine if the
>> battery is full, discharging or dead.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
> Looks mostly good to me, but
>
> [...]
>
>> @@ -1710,6 +1769,13 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>>   		else
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>> +	} else if (di->opts & BQ27561_O_BITS) {
>> +		if (di->cache.flags & BQ27561_FLAG_FC)
>> +			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
>> +		else if (di->cache.flags & BQ27561_FLAG_DIS_CH)
>> +			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> Shouldn't this be checking for FLAG_FDC instead of FLAG_DIS_CH?

Yes.

Dan


> -- Sebastian

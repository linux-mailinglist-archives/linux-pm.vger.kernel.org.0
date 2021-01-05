Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613662EB625
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 00:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAEX1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 18:27:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37964 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAEX1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 18:27:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 105NR8ch057044;
        Tue, 5 Jan 2021 17:27:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609889228;
        bh=Km5CbpCjxLmK9wY5OvYyeRmL6BqdoqFVQADK+YJyQvI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E+FoVCKVqp7RAVWeRNfUv/dzWd5R0TH5Hzuh5leREsnFryBJJRPQbTXXM/eOm4Yqt
         0jCXwZW8vNjQfK7GbaUbMQQdG608sERqP47EsjZwZQCehnUeVr+XkJ6/Kx5A5Xzyz/
         mhS6mM6jrAfJqpt6AJMiekOnZiwqPKuG27VHL1sI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 105NR8bO010852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jan 2021 17:27:08 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 Jan
 2021 17:27:08 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 Jan 2021 17:27:08 -0600
Received: from [10.250.36.125] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 105NR8ss063291;
        Tue, 5 Jan 2021 17:27:08 -0600
Subject: Re: [EXTERNAL] Re: [PATCH v9 2/2] power: supply: bq256xx: Introduce
 the BQ256XX charger driver
To:     Sebastian Reichel <sre@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>
References: <20210105202949.14677-1-r-rivera-matos@ti.com>
 <20210105202949.14677-3-r-rivera-matos@ti.com>
 <20210105212631.2meujp37e5jqp7eu@earth.universe>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <430133d5-6a30-8cfd-2483-f4b849bf90bd@ti.com>
Date:   Tue, 5 Jan 2021 17:27:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105212631.2meujp37e5jqp7eu@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian,

On 1/5/21 3:26 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Jan 05, 2021 at 02:29:49PM -0600, Ricardo Rivera-Matos wrote:
>> The BQ256XX family of devices are highly integrated buck chargers
>> for single cell batteries.
>>
>> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>>
>> v9 - resolves two warnings issued by kernel test robot
> changelog needs to be below --- btw.
> (so that git am does not pick it up :))
ACK
>
>> ---
>> [...]
>> +	ret = bq256xx_parse_dt(bq, psy_cfg, dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read device tree properties%d\n", ret);
>> +		return ret;
>> +	}
>> [...]
> If you want to change psy_cfg, you need to pass it by reference
> and not by value (i.e. use &psy_cfg here and a pointer as argument
> of bq256xx_parse_dt). Providing psy_cfg like this creates a copy
> of the struct.
ACK, understood.
>
> Did you runtime test this version? It should crash when accessing
> the properties because of psy_cfg.drv_data being NULL.
ACK, I did not, my mistake. v10 will get tested on the actual hardware.
>
>> [...]
>> +	ret = bq256xx_power_supply_init(bq, psy_cfg, dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register power supply\n");
>> +		return ret;
>> +	}
> Here it's also better to just provide the address of psy_cfg
> (but not strictly necessary).
>
> -- Sebastian
Thanks,
Ricardo

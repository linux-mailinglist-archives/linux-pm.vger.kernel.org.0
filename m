Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA529E9FA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgJ2LFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:05:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52892 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgJ2LFa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:05:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SFS63u018155;
        Wed, 28 Oct 2020 10:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603898886;
        bh=7Y8IMlS8Rjtuh3Bt1F7fB0E0fJme1LZMMGNHEg4TuLg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DVdwOLiQSHX8V2LbMdZpX1FpOyCsAW5KZ3ASa9hYMNNop9pOupI2YuvIMR/56/qqX
         E/ur3zV5VA5hCtC7sTzPB5F5nxCZTC5ZwuDJn3Tr8bfQvFESJgsjsaEE+F/NKteV2F
         dQ8hCFXxrMxuqYxkyTiPKMZ852rn/jEosvs7tzZI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SFS6qn039511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 10:28:06 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 10:28:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 10:28:06 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SFS47m046337;
        Wed, 28 Oct 2020 10:28:04 -0500
Subject: Re: [PATCH] opp: fix bad error check logic in the opp helper register
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201028141357.10345-1-t-kristo@ti.com>
 <20201028145405.ucfepzt6xoxro6fi@vireshk-i7>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <febd30f4-62b4-ad9c-9cd9-09841af140bf@ti.com>
Date:   Wed, 28 Oct 2020 17:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028145405.ucfepzt6xoxro6fi@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/10/2020 16:54, Viresh Kumar wrote:
> On 28-10-20, 16:13, Tero Kristo wrote:
>> The error check is incorrectly negated causing the helper to never
>> register anything. This causes platforms that depend on this
>> functionality to fail always with any cpufreq transition, and at least
>> TI DRA7 based platforms fail to boot completely due to warning message
>> flood from _generic_set_opp_regulator complaining about multiple
>> regulators not being supported.
>>
>> Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/opp/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 2483e765318a..4ac4e7ce6b8b 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1930,7 +1930,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
>>   		return ERR_PTR(-EINVAL);
>>   
>>   	opp_table = dev_pm_opp_get_opp_table(dev);
>> -	if (!IS_ERR(opp_table))
>> +	if (IS_ERR(opp_table))
>>   		return opp_table;
>>   
>>   	/* This should be called before OPPs are initialized */
> 
> A similar fix is already pushed in linux-next for this.

Ah ok, good to hear. Just checked linux-next and I see the fix also, 
sorry for the noise.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

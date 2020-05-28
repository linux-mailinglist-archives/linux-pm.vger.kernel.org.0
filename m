Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235EB1E6E8B
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436967AbgE1WUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 18:20:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59984 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436963AbgE1WUb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 18:20:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SMKTWT072526;
        Thu, 28 May 2020 17:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590704429;
        bh=sFhoRUjpWpckGrIRZv0+gAaF+mAJGjBievnYGInopm0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CWN6ATmsTh6iS7yRGcONHV1AhmI+iBsdZouAi7ufk9stba20ea6zvOVNTHaEvinLg
         CwyjQ+JYfcdgMXS7hmPI0HyzFj77exF3yLFK7tIlzfDooECfqjNFdJminm5tTcYcmb
         gFPF6kspDzrwOfJYSHXcKWVScLlPn8TcBzHBOszM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SMKTUG124478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 17:20:29 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 17:20:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 17:20:28 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SMKSTr035317;
        Thu, 28 May 2020 17:20:28 -0500
Subject: Re: [PATCH v11 4/4] power: supply: bq25150 introduce the bq25150
To:     "Andrew F. Davis" <afd@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <dmurphy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>
References: <20200528140546.25260-1-r-rivera-matos@ti.com>
 <20200528140546.25260-5-r-rivera-matos@ti.com>
 <95fcf5ae-cf49-4618-08cc-da7487450e53@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <5792b63e-37cc-7110-4767-df300385eb7b@ti.com>
Date:   Thu, 28 May 2020 17:20:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <95fcf5ae-cf49-4618-08cc-da7487450e53@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/28/20 9:43 AM, Andrew F. Davis wrote:
> On 5/28/20 10:05 AM, Ricardo Rivera-Matos wrote:
>> +static int bq2515x_set_precharge_current(struct bq2515x_device *bq2515x,
>> +					int val)
>> +{
>> +	int ret;
>> +	unsigned int pchrgctrl;
>> +	unsigned int icharge_range;
>> +	unsigned int precharge_reg_code;
>> +	u16 precharge_multiplier = BQ2515X_ICHG_RNG_1B0_UA;
>> +	u16 precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_1875_UA;
>
> Why u16? looks like it gets promoted everywhere it's used anyway.
ACK
>
>
>> +
>> +	ret = regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL, &pchrgctrl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	icharge_range = pchrgctrl & BQ2515X_ICHARGE_RANGE;
>> +
>> +	if (icharge_range) {
>> +		precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_3750_UA;
>> +		precharge_multiplier = BQ2515X_ICHG_RNG_1B1_UA;
> This is a little hard to read when we have a default value overwritten
> in an if, it basically hides the else logic, suggest:
>
>
> if (icharge_range) {
> 	precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_3750_UA;
> 	precharge_multiplier = BQ2515X_ICHG_RNG_1B1_UA;
> } else {
> 	precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_1875_UA;
> 	precharge_multiplier = BQ2515X_ICHG_RNG_1B0_UA;
> }
ACK. I originally had it as an if/else deal, but I got feedback it was 
too verbose. It will stay verbose.
>
>
>> +	}
>> +	if (val > precharge_max_ua || val < BQ2515X_ICHG_MIN_UA)
>> +		return -EINVAL;
>> +
>> +	precharge_reg_code = val / precharge_multiplier;
>> +
>> +	ret = bq2515x_set_charge_disable(bq2515x, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(bq2515x->regmap, BQ2515X_PCHRGCTRL,
>> +				BQ2515X_PRECHARGE_MASK, precharge_reg_code);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return bq2515x_set_charge_disable(bq2515x, 0);
>> +}
> [snip]
>
>> +
>> +static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
>> +{
>> +	int i = 0;
>> +	unsigned int array_size = ARRAY_SIZE(bq2515x_ilim_lvl_values);
>> +
>> +	if (val >= bq2515x_ilim_lvl_values[array_size - 1]) {
>
> Isn't this check the same as is done in first iteration of the below loop?
>
> Andrew
ACK
>
>
>> +		i = array_size - 1;
>> +	} else {
>> +		for (i = array_size - 1; i > 0; i--) {
>> +			if (val >= bq2515x_ilim_lvl_values[i])
>> +				break;
>> +		}
>> +	}
>> +	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
>> +}
>> +

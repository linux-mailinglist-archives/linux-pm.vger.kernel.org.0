Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC74D1D9DAA
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgESRQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 13:16:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50204 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 13:15:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JHFvlQ117977;
        Tue, 19 May 2020 12:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589908557;
        bh=u9MuVS5Z4dEpCImA8CLdh3VAMXKG5b1PtenlLbgYx2g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eedoNQJ/IZO+PCGyrR4V9EMeFcv//9WuIGa85xRrnU2sywB5fwYjoanqbE5bJv9Fe
         5ZkVbdjqr0PV5NCl0+TopWps5TvTyuSEigO338o2blSOnKsEFfQFmSTCmOh/NsyPiv
         Qg+oPTrZJsRufSQz8Jj/lFqeLByzVAL3HwnmBglM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04JHFv5C028049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 12:15:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 12:15:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 12:15:57 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JHFujx097330;
        Tue, 19 May 2020 12:15:57 -0500
Subject: Re: [PATCH v7 3/3] power: supply: bq25150 introduce the bq25150
To:     "Andrew F. Davis" <afd@ti.com>, Dan Murphy <dmurphy@ti.com>,
        <sre@kernel.org>
CC:     <sspatil@android.com>, <linux-pm@vger.kernel.org>,
        <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200519141916.28282-1-dmurphy@ti.com>
 <20200519141916.28282-4-dmurphy@ti.com>
 <50b9ca3f-36e8-d13b-672c-5e72b6158869@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <1eaa381f-0c05-8bcf-ce30-96104ddd9080@ti.com>
Date:   Tue, 19 May 2020 12:15:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <50b9ca3f-36e8-d13b-672c-5e72b6158869@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/19/20 9:46 AM, Andrew F. Davis wrote:
> On 5/19/20 10:19 AM, Dan Murphy wrote:
>> +static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
>> +{
>> +	int i;
>> +
>> +	if (val > BQ2515X_ILIM_MAX || val < BQ2515X_ILIM_MIN)
>> +		return -EINVAL;
> Clamp to these limits, not reject. Or better, modify the below loop so
> it clamps to the highest or lowest value in bq2515x_ilim_lvl_values[],
> then drop these #defines.
>
>> +
>> +	for (i = 0; i < ARRAY_SIZE(bq2515x_ilim_lvl_values); i++) {
>> +		if (val == bq2515x_ilim_lvl_values[i])
>> +			break;
>> +
>> +		if (val > bq2515x_ilim_lvl_values[i - 1] &&
> Index out of bounds for the i = 0 case.
>
>> +		    val < bq2515x_ilim_lvl_values[i]) {
>> +			if (val - bq2515x_ilim_lvl_values[i - 1] <
>> +			    bq2515x_ilim_lvl_values[i] - val) {
> You are still missing the case where the value is closer to the [i]
> element, you check that it is between [i-1] and [i], but only chose
> [i-1] when it is closer to that than [i] but equal and greater case is
> missing.
>
> Given this sets input current limits, would instead always rounding down
> be the safer option?
>
> Andrew
ACK. I am going to rewrite that altogether.
>
>> +				i = i - 1;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
>> +}

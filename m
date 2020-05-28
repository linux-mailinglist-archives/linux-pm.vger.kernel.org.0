Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418D11E6444
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgE1OnL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 10:43:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36406 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgE1OnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 10:43:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SEh7Cx105543;
        Thu, 28 May 2020 09:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590676987;
        bh=8w7N6d8TeqStNOG9atDqyPq6+qdBCR//aeinIO2X+Bc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nXOHM8aFVxfRCKrDNQMs7+g6idWLEaku57TGsddMo56tKxQaeilmM3y/ubxHpDAeU
         78cvR+qBxkuZ2m8Q/hnrYPMlUKelnAQYCZEyr3IeHeRTv7mVNYyxpUELRZux9BLzd5
         KIRvvEwkQTmANPZyqcGZxa1pkh8008jYxKT/Nl3o=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SEh7DQ052484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 09:43:07 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 09:43:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 09:43:07 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SEh6Um003235;
        Thu, 28 May 2020 09:43:06 -0500
Subject: Re: [PATCH v11 4/4] power: supply: bq25150 introduce the bq25150
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <dmurphy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>
References: <20200528140546.25260-1-r-rivera-matos@ti.com>
 <20200528140546.25260-5-r-rivera-matos@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <95fcf5ae-cf49-4618-08cc-da7487450e53@ti.com>
Date:   Thu, 28 May 2020 10:43:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528140546.25260-5-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/28/20 10:05 AM, Ricardo Rivera-Matos wrote:
> +static int bq2515x_set_precharge_current(struct bq2515x_device *bq2515x,
> +					int val)
> +{
> +	int ret;
> +	unsigned int pchrgctrl;
> +	unsigned int icharge_range;
> +	unsigned int precharge_reg_code;
> +	u16 precharge_multiplier = BQ2515X_ICHG_RNG_1B0_UA;
> +	u16 precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_1875_UA;


Why u16? looks like it gets promoted everywhere it's used anyway.


> +
> +	ret = regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL, &pchrgctrl);
> +	if (ret)
> +		return ret;
> +
> +	icharge_range = pchrgctrl & BQ2515X_ICHARGE_RANGE;
> +
> +	if (icharge_range) {
> +		precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_3750_UA;
> +		precharge_multiplier = BQ2515X_ICHG_RNG_1B1_UA;

This is a little hard to read when we have a default value overwritten
in an if, it basically hides the else logic, suggest:


if (icharge_range) {
	precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_3750_UA;
	precharge_multiplier = BQ2515X_ICHG_RNG_1B1_UA;
} else {
	precharge_max_ua = BQ2515X_PRECHRG_ICHRG_RNGE_1875_UA;
	precharge_multiplier = BQ2515X_ICHG_RNG_1B0_UA;
}


> +	}
> +	if (val > precharge_max_ua || val < BQ2515X_ICHG_MIN_UA)
> +		return -EINVAL;
> +
> +	precharge_reg_code = val / precharge_multiplier;
> +
> +	ret = bq2515x_set_charge_disable(bq2515x, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(bq2515x->regmap, BQ2515X_PCHRGCTRL,
> +				BQ2515X_PRECHARGE_MASK, precharge_reg_code);
> +	if (ret)
> +		return ret;
> +
> +	return bq2515x_set_charge_disable(bq2515x, 0);
> +}

[snip]

> +
> +static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
> +{
> +	int i = 0;
> +	unsigned int array_size = ARRAY_SIZE(bq2515x_ilim_lvl_values);
> +
> +	if (val >= bq2515x_ilim_lvl_values[array_size - 1]) {


Isn't this check the same as is done in first iteration of the below loop?

Andrew


> +		i = array_size - 1;
> +	} else {
> +		for (i = array_size - 1; i > 0; i--) {
> +			if (val >= bq2515x_ilim_lvl_values[i])
> +				break;
> +		}
> +	}
> +	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
> +}
> +

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACA2E8E6D
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbhACV1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jan 2021 16:27:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55676 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbhACV1w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jan 2021 16:27:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 103LQFho079029;
        Sun, 3 Jan 2021 15:26:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609709175;
        bh=LzUKQIdtUxP3VT9n+rTF31A9EZWe/TWaIB53rZGrNTY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DPB+qve0s8heRhSIjLgjb8mCzQS6nrRBZtS6gnhzNNrkacXzb2GgmodhGi0xfG3iq
         +MPyv5QRvPf5RwejlcdO/t45mDVZgcFNyrL8cr+yzfG6ycFnRXAxJke3+BPHJgb4P8
         zYpmkA1vvOafGis9PDkzcXfNVtHCnvt14AK2SLEY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 103LQE4v016396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Jan 2021 15:26:14 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 3 Jan
 2021 15:26:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 3 Jan 2021 15:26:14 -0600
Received: from [10.250.79.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 103LQEGo126039;
        Sun, 3 Jan 2021 15:26:14 -0600
Subject: Re: [EXTERNAL] Re: [PATCH v7 2/2] power: supply: bq256xx: Introduce
 the BQ256XX charger driver
To:     Sebastian Reichel <sre@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>
References: <20201230230116.29697-1-r-rivera-matos@ti.com>
 <20201230230116.29697-3-r-rivera-matos@ti.com>
 <20210103012610.exkkwoqz3745bh2u@earth.universe>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <a31160cd-6023-236b-ff6f-4c9703bf937d@ti.com>
Date:   Sun, 3 Jan 2021 15:26:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210103012610.exkkwoqz3745bh2u@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 1/2/21 7:26 PM, Sebastian Reichel wrote:
> Hi Ricardo,
>
> On Wed, Dec 30, 2020 at 05:01:16PM -0600, Ricardo Rivera-Matos wrote:
>> The BQ256XX family of devices are highly integrated buck chargers
>> for single cell batteries.
>>
>> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>>
>> v5 - adds power_supply_put_battery_info() and devm_add_action_or_rest() calls
>>
>> v6 - implements bq256xx_remove function
>>
>> v7 - applies various fixes
>>
>>     - implements clamp() API
>>
>>     - implements memcmp() API
>>
>>     - changes cache_type to REGACHE_FLAT
>>
>>     - changes bq256xx_probe to properly unregister device
>>
>> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>> ---
> Thanks, looks mostly good now.
Cool :)
>
>>   drivers/power/supply/Kconfig           |   11 +
>>   drivers/power/supply/Makefile          |    1 +
>>   drivers/power/supply/bq256xx_charger.c | 1747 ++++++++++++++++++++++++
>>   3 files changed, 1759 insertions(+)
>>   create mode 100644 drivers/power/supply/bq256xx_charger.c
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 44d3c8512fb8..87d852914bc2 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -618,6 +618,17 @@ config CHARGER_BQ25890
>>   	help
>>   	  Say Y to enable support for the TI BQ25890 battery charger.
>>   
>> +config CHARGER_BQ256XX
>> +	tristate "TI BQ256XX battery charger driver"
>> +	depends on I2C
>> +	depends on GPIOLIB || COMPILE_TEST
>> +	select REGMAP_I2C
>> +	help
>> +	  Say Y to enable support for the TI BQ256XX battery chargers. The
>> +	  BQ256XX family of devices are highly-integrated, switch-mode battery
>> +	  charge management and system power path management devices for single
>> +	  cell Li-ion and Li-polymer batteries.
>> +
>>   config CHARGER_SMB347
>>   	tristate "Summit Microelectronics SMB347 Battery Charger"
>>   	depends on I2C
> Please rebase to current power-supply for-next branch, Kconfig and
> Makefile diff does not apply because of one additional BQ device.
ACK
>
>> [...]
>> +static void bq256xx_usb_work(struct work_struct *data)
>> +{
>> +	struct bq256xx_device *bq =
>> +			container_of(data, struct bq256xx_device, usb_work);
>> +
>> +	switch (bq->usb_event) {
>> +	case USB_EVENT_ID:
>> +		break;
>> +
> spurious newline, please remove!
ACK
>
>> +	case USB_EVENT_NONE:
>> +		power_supply_changed(bq->charger);
>> +		break;
>> +	default:
>> +		dev_err(bq->dev, "Error switching to charger mode.\n");
>> +		break;
>> +	}
>> +}
>> +
>> [...]
>> +static int bq256xx_hw_init(struct bq256xx_device *bq)
>> +{
>> +	struct power_supply_battery_info bat_info = { };
>> +	int wd_reg_val = BQ256XX_WATCHDOG_DIS;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
>> +		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>> +		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>> +			wd_reg_val = i;
>> +	}
>> +	ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
>> +				 BQ256XX_WATCHDOG_MASK, wd_reg_val <<
>> +						BQ256XX_WDT_BIT_SHIFT);
>> +
>> +	ret = power_supply_get_battery_info(bq->charger, &bat_info);
>> +	if (ret) {
>> +		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
>> +
>> +		bat_info.constant_charge_current_max_ua =
>> +				bq->chip_info->bq256xx_def_ichg;
>> +
>> +		bat_info.constant_charge_voltage_max_uv =
>> +				bq->chip_info->bq256xx_def_vbatreg;
>> +
>> +		bat_info.precharge_current_ua =
>> +				bq->chip_info->bq256xx_def_iprechg;
>> +
>> +		bat_info.charge_term_current_ua =
>> +				bq->chip_info->bq256xx_def_iterm;
>> +
>> +		bq->init_data.ichg_max =
>> +				bq->chip_info->bq256xx_max_ichg;
>> +
>> +		bq->init_data.vbatreg_max =
>> +				bq->chip_info->bq256xx_max_vbatreg;
>> +	} else {
>> +		bq->init_data.ichg_max =
>> +			bat_info.constant_charge_current_max_ua;
>> +
>> +		bq->init_data.vbatreg_max =
>> +			bat_info.constant_charge_voltage_max_uv;
>> +	}
>> +
>> +	ret = bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_iindpm(bq, bq->init_data.iindpm);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_ichg(bq,
>> +				bat_info.constant_charge_current_max_ua);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_iprechg(bq,
>> +				bat_info.precharge_current_ua);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_vbatreg(bq,
>> +				bat_info.constant_charge_voltage_max_uv);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	ret = bq->chip_info->bq256xx_set_iterm(bq,
>> +				bat_info.charge_term_current_ua);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	power_supply_put_battery_info(bq->charger, &bat_info);
>> +
>> +	return 0;
>> +
>> +err_out:
>> +	return ret;
> please return error code directly instead of adding this useless
> goto.
ACK
>
>> [...]
> -- Sebastian
Ricardo

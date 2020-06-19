Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C70201C34
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbgFSUPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgFSUO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 16:14:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311FC06174E;
        Fri, 19 Jun 2020 13:14:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so1806808wrm.2;
        Fri, 19 Jun 2020 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l2KDOHP052iTti00EwboGu6+IGyh079lBg2oOG84tKk=;
        b=cf9ezeKC7/0IEzqeY7ogB6p5fwgnx3ut8wEbDhHan0Ipcbi2GlWTlN/OabL9653+Iq
         E9LK2vfr/i4YwjZ1bBUkoJ6xKIjrynk2kCfEBVKKC6KKIt+MLL4VecPYIsaYlaNvl10u
         E7Nm4XutpSdgujLhEJTEjymCg4nxqY2oyQc670syHI2Iqi/TWAX+kMFpOZF3ox7WBwhs
         P2pSIZYKlxfSiKSkBhcO07kTEoZDj/XUY0q069VWe+NJwNV7xXJKnRQqX0S03uGqS/Vs
         k6Zgaid55tS3tsrr+nd/n/fQjfls5U8YhGV7vtz+Lw/yeJyhrejtgQbXsCSdLSRFBJjE
         0YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l2KDOHP052iTti00EwboGu6+IGyh079lBg2oOG84tKk=;
        b=BsksJQQFx27OmWTWMJ+hllOGfXhmYU+VS5wNCw3Dgpf/k9pzcNNsHOIHDRrupryIej
         VatqBvaT+oge1lEzjAHzIHyFUljhg/GWaz8QHJ5h1ID+7NibmQQoYcpPaJvJTGoNdE3A
         A23k8iRfgWdieHfq+L0FonIIy4qRQ1Zqv7FgHSlWuWMvc6onU8ZPB+0DFn7WVUv9whqg
         rvxPAg7JciLj+rnmS/6HPe2C/LVHNXZk7Td174pHFNqizmft8AhZVNGWpby1ZZf5Gk/x
         e85bl1HPcBi6oTrMe8eRaU//zv9NIlZJJgqpxsfKmETFuhUtBZ8AY+lcwXkNBVnnstv/
         hgjA==
X-Gm-Message-State: AOAM530lMBbinxetu68jXtS/mFpB+0qgO5EyAA3FnkJOxEEfe8I22GW1
        WBxlW3gH8nUj9RLXpvC3Azc=
X-Google-Smtp-Source: ABdhPJyxiU1pUKWBKiICQUz5KSzsaIdFf9jpCmQWC1+r4is9u5t8fRHeIePLZsSJDXvTi9SoGKxXAg==
X-Received: by 2002:adf:c382:: with SMTP id p2mr5732423wrf.283.1592597697430;
        Fri, 19 Jun 2020 13:14:57 -0700 (PDT)
Received: from [192.168.86.31] ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id c16sm8460541wrx.4.2020.06.19.13.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 13:14:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] power: supply: max17040: Support compatible
 devices
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20200618101340.2671020-1-iskren.chernev@gmail.com>
 <20200618101340.2671020-2-iskren.chernev@gmail.com>
 <20200619161304.z4k522rjdewmhija@earth.universe>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <dee9f0b3-4c41-9c47-3cd8-49f071e82466@gmail.com>
Date:   Fri, 19 Jun 2020 23:14:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619161304.z4k522rjdewmhija@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/19/20 7:13 PM, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Jun 18, 2020 at 01:13:40PM +0300, Iskren Chernev wrote:
>> The max17040 fuel gauge is part of a family of 8 chips that have very
>> similar mode of operations and registers.
>>
>> This change adds:
>> - compatible strings for all supported devices and handles the minor
>>   differences between them;
>> - handling for devices reporting double capacity via maxim,double-soc;
>> - handling for setting rcomp, a compensation value for more accurate
>>   reading, affected by battery chemistry and operating temps;
>> - suppot for SOC alerts (capacity changes by +/- 1%), to prevent polling
>>   every second;
>> - redo i2c read/writes via regmap
>
> Please split this into multiple patches as described in
> Documentation/process/submitting-patches.rst:
>
> 3) Separate your changes
> ------------------------
>
> Separate each **logical change** into a separate patch.

So I did some cleanup on the existing code (unified function interfaces,
introduced regmap, and other small things). Can this be one commit?

> Thanks,
>
> -- Sebastian
>
>> The datasheets of the supported devices are linked [0] [1] [2] [3].
>>
>> [0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
>> [1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
>> [2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
>> [3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>> v1: https://lkml.org/lkml/2020/6/8/683
>>
>> changes in v2:
>> - make max17040_family static
>> - fix rcomp len check
>> - implement maxim,skip-reset
>> - reword Kconfig text
>>
>>  drivers/power/supply/Kconfig            |  11 +-
>>  drivers/power/supply/max17040_battery.c | 466 +++++++++++++++++-------
>>  2 files changed, 338 insertions(+), 139 deletions(-)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 44d3c8512fb8d..69e9eaa100d9f 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -368,9 +368,14 @@ config BATTERY_MAX17040
>>      tristate "Maxim MAX17040 Fuel Gauge"
>>      depends on I2C
>>      help
>> -      MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
>> -      in handheld and portable equipment. The MAX17040 is configured
>> -      to operate with a single lithium cell
>> +      Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
>> +      (Li+) batteries in handheld and portable equipment, including
>> +      max17040, max17041, max17043, max17044, max17048, max17049, max17058,
>> +      max17059.  It is also included in some batteries like max77836.
>> +
>> +      Driver supports reporting SOC (State of Charge, i.e capacity),
>> +      voltage and configurable low-SOC wakeup interrupt. For certain models
>> +      a SOC change interrupt is also supported.
>>
>>  config BATTERY_MAX17042
>>      tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>> index 48aa44665e2f1..1244982cacacb 100644
>> --- a/drivers/power/supply/max17040_battery.c
>> +++ b/drivers/power/supply/max17040_battery.c
>> @@ -15,193 +15,342 @@
>>  #include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/power_supply.h>
>> +#include <linux/of_device.h>
>>  #include <linux/max17040_battery.h>
>> +#include <linux/regmap.h>
>>  #include <linux/slab.h>
>>
>>  #define MAX17040_VCELL    0x02
>>  #define MAX17040_SOC    0x04
>>  #define MAX17040_MODE    0x06
>>  #define MAX17040_VER    0x08
>> -#define MAX17040_RCOMP    0x0C
>> +#define MAX17040_CONFIG    0x0C
>> +#define MAX17040_STATUS    0x1A
>>  #define MAX17040_CMD    0xFE
>>
>>
>>  #define MAX17040_DELAY        1000
>>  #define MAX17040_BATTERY_FULL    95
>> +#define MAX17040_RCOMP_DEFAULT  0x9700
>>
>> -#define MAX17040_ATHD_MASK        0xFFC0
>> +#define MAX17040_ATHD_MASK        0x3f
>> +#define MAX17040_ALSC_MASK        0x40
>>  #define MAX17040_ATHD_DEFAULT_POWER_UP    4
>> +#define MAX17040_STATUS_HD_MASK        0x1000
>> +#define MAX17040_STATUS_SC_MASK        0x2000
>> +#define MAX17040_CFG_RCOMP_MASK        0xff00
>> +
>> +enum chip_id {
>> +    ID_MAX17040,
>> +    ID_MAX17041,
>> +    ID_MAX17043,
>> +    ID_MAX17044,
>> +    ID_MAX17048,
>> +    ID_MAX17049,
>> +    ID_MAX17058,
>> +    ID_MAX17059,
>> +};
>> +
>> +/* values that differ by chip_id */
>> +struct chip_data {
>> +    u16 reset_val;
>> +    u16 vcell_shift;
>> +    u16 vcell_mul;
>> +    u16 vcell_div;
>> +    u8  rcomp_bytes;
>> +    u8  has_low_soc_alert;
>> +    u8  has_soc_alert;
>> +};
>> +
>> +static struct chip_data max17040_family[] = {
>> +    [ID_MAX17040] = {
>> +        .reset_val = 0x0054,
>> +        .vcell_shift = 4,
>> +        .vcell_mul = 1250,
>> +        .vcell_div = 1,
>> +        .rcomp_bytes = 2,
>> +        .has_low_soc_alert = 0,
>> +        .has_soc_alert = 0,
>> +    },
>> +    [ID_MAX17041] = {
>> +        .reset_val = 0x0054,
>> +        .vcell_shift = 4,
>> +        .vcell_mul = 2500,
>> +        .vcell_div = 1,
>> +        .rcomp_bytes = 2,
>> +        .has_low_soc_alert = 0,
>> +        .has_soc_alert = 0,
>> +    },
>> +    [ID_MAX17043] = {
>> +        .reset_val = 0x0054,
>> +        .vcell_shift = 4,
>> +        .vcell_mul = 1250,
>> +        .vcell_div = 1,
>> +        .rcomp_bytes = 1,
>> +        .has_low_soc_alert = 1,
>> +        .has_soc_alert = 0,
>> +    },
>> +    [ID_MAX17044] = {
>> +        .reset_val = 0x0054,
>> +        .vcell_shift = 4,
>> +        .vcell_mul = 2500,
>> +        .vcell_div = 1,
>> +        .rcomp_bytes = 1,
>> +        .has_low_soc_alert = 1,
>> +        .has_soc_alert = 0,
>> +    },
>> +    [ID_MAX17048] = {
>> +        .reset_val = 0x5400,
>> +        .vcell_shift = 0,
>> +        .vcell_mul = 625,
>> +        .vcell_div = 8,
>> +        .rcomp_bytes = 1,
>> +        .has_low_soc_alert = 1,
>> +        .has_soc_alert = 1,
>> +    },
>> +    [ID_MAX17049] = {
>> +        .reset_val = 0x5400,
>> +        .vcell_shift = 0,
>> +        .vcell_mul = 625,
>> +        .vcell_div = 4,
>> +        .rcomp_bytes = 1,
>> +        .has_low_soc_alert = 1,
>> +        .has_soc_alert = 1,
>> +    },
>> +    [ID_MAX17058] = {
>> +        .reset_val = 0x5400,
>> +        .vcell_shift = 0,
>> +        .vcell_mul = 625,
>> +        .vcell_div = 8,
>> +        .rcomp_bytes = 1,
>> +        .has_low_soc_alert = 1,
>> +        .has_soc_alert = 0,
>> +    },
>> +    [ID_MAX17059] = {
>> +        .reset_val = 0x5400,
>> +        .vcell_shift = 0,
>> +        .vcell_mul = 625,
>> +        .vcell_div = 4,
>> +        .rcomp_bytes = 1,
>> +        .has_low_soc_alert = 1,
>> +        .has_soc_alert = 0,
>> +    },
>> +};
>>
>>  struct max17040_chip {
>>      struct i2c_client        *client;
>> +    struct regmap            *regmap;
>>      struct delayed_work        work;
>>      struct power_supply        *battery;
>>      struct max17040_platform_data    *pdata;
>> +    struct chip_data        data;
>>
>> -    /* State Of Connect */
>> -    int online;
>> -    /* battery voltage */
>> -    int vcell;
>>      /* battery capacity */
>>      int soc;
>>      /* State Of Charge */
>>      int status;
>> +
>>      /* Low alert threshold from 32% to 1% of the State of Charge */
>>      u32 low_soc_alert;
>> +    /* some devices return twice the capacity */
>> +    bool quirk_double_soc;
>> +    /* resetting causes some devices to show inaccurate reading */
>> +    bool quirk_skip_reset;
>> +    /* higher 8 bits for 17043+, 16 bits for 17040,41 */
>> +    u16 rcomp;
>>  };
>>
>> -static int max17040_get_property(struct power_supply *psy,
>> -                enum power_supply_property psp,
>> -                union power_supply_propval *val)
>> +static int max17040_reset(struct max17040_chip *chip)
>>  {
>> -    struct max17040_chip *chip = power_supply_get_drvdata(psy);
>> -
>> -    switch (psp) {
>> -    case POWER_SUPPLY_PROP_STATUS:
>> -        val->intval = chip->status;
>> -        break;
>> -    case POWER_SUPPLY_PROP_ONLINE:
>> -        val->intval = chip->online;
>> -        break;
>> -    case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> -        val->intval = chip->vcell;
>> -        break;
>> -    case POWER_SUPPLY_PROP_CAPACITY:
>> -        val->intval = chip->soc;
>> -        break;
>> -    default:
>> -        return -EINVAL;
>> -    }
>> -    return 0;
>> +    return regmap_write(chip->regmap, MAX17040_CMD, chip->data.reset_val);
>>  }
>>
>> -static int max17040_write_reg(struct i2c_client *client, int reg, u16 value)
>> +static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
>>  {
>> -    int ret;
>> -
>> -    ret = i2c_smbus_write_word_swapped(client, reg, value);
>> -
>> -    if (ret < 0)
>> -        dev_err(&client->dev, "%s: err %d\n", __func__, ret);
>> +    level = 32 - level;
>> +    return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
>> +            MAX17040_ATHD_MASK, level);
>> +}
>>
>> -    return ret;
>> +static int max17040_set_soc_alert(struct max17040_chip *chip, bool enable)
>> +{
>> +    return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
>> +            MAX17040_ALSC_MASK, enable ? MAX17040_ALSC_MASK : 0);
>>  }
>>
>> -static int max17040_read_reg(struct i2c_client *client, int reg)
>> +/* Returns true if alert cause was SOC change, not low SOC */
>> +static bool max17040_handle_soc_alert(struct max17040_chip *chip)
>>  {
>> -    int ret;
>> +    bool ret = true;
>> +    u32 data;
>>
>> -    ret = i2c_smbus_read_word_swapped(client, reg);
>> +    regmap_read(chip->regmap, MAX17040_STATUS, &data);
>>
>> -    if (ret < 0)
>> -        dev_err(&client->dev, "%s: err %d\n", __func__, ret);
>> +    if (data & MAX17040_STATUS_HD_MASK) {
>> +        // this alert was caused by low soc
>> +        ret = false;
>> +    }
>> +    if (data & MAX17040_STATUS_SC_MASK) {
>> +        // soc change bit -- deassert to mark as handled
>> +        regmap_write(chip->regmap, MAX17040_STATUS,
>> +                data & ~MAX17040_STATUS_SC_MASK);
>> +    }
>>
>>      return ret;
>>  }
>>
>> -static void max17040_reset(struct i2c_client *client)
>> +static int max17040_set_rcomp(struct max17040_chip *chip, u16 rcomp)
>>  {
>> -    max17040_write_reg(client, MAX17040_CMD, 0x0054);
>> +    u16 mask = chip->data.rcomp_bytes == 2 ?
>> +        0xffff : MAX17040_CFG_RCOMP_MASK;
>> +
>> +    return regmap_update_bits(chip->regmap, MAX17040_CONFIG, mask, rcomp);
>>  }
>>
>> -static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
>> +static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
>>  {
>> -    int ret;
>> -    u16 data;
>> -
>> -    level = 32 - level;
>> -    data = max17040_read_reg(client, MAX17040_RCOMP);
>> -    /* clear the alrt bit and set LSb 5 bits */
>> -    data &= MAX17040_ATHD_MASK;
>> -    data |= level;
>> -    ret = max17040_write_reg(client, MAX17040_RCOMP, data);
>> +    struct chip_data *d = &chip->data;
>>
>> -    return ret;
>> +    return (vcell >> d->vcell_shift) * d->vcell_mul / d->vcell_div;
>>  }
>>
>> -static void max17040_get_vcell(struct i2c_client *client)
>> +static int max17040_get_vcell(struct max17040_chip *chip)
>>  {
>> -    struct max17040_chip *chip = i2c_get_clientdata(client);
>> -    u16 vcell;
>> +    u32 vcell;
>>
>> -    vcell = max17040_read_reg(client, MAX17040_VCELL);
>> +    regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
>>
>> -    chip->vcell = (vcell >> 4) * 1250;
>> +    return max17040_raw_vcell_to_uvolts(chip, vcell);
>>  }
>>
>> -static void max17040_get_soc(struct i2c_client *client)
>> +static int max17040_raw_soc_to_percent(struct max17040_chip *chip, u16 soc)
>>  {
>> -    struct max17040_chip *chip = i2c_get_clientdata(client);
>> -    u16 soc;
>> +    int shift = 8;
>>
>> -    soc = max17040_read_reg(client, MAX17040_SOC);
>> +    if (chip->quirk_double_soc)
>> +        shift += 1;
>>
>> -    chip->soc = (soc >> 8);
>> +    return soc >> shift;
>>  }
>>
>> -static void max17040_get_version(struct i2c_client *client)
>> +static int max17040_get_soc(struct max17040_chip *chip)
>>  {
>> -    u16 version;
>> +    u32 soc;
>>
>> -    version = max17040_read_reg(client, MAX17040_VER);
>> +    regmap_read(chip->regmap, MAX17040_SOC, &soc);
>>
>> -    dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
>> +    return max17040_raw_soc_to_percent(chip, soc);
>>  }
>>
>> -static void max17040_get_online(struct i2c_client *client)
>> +static void max17040_get_version(struct max17040_chip *chip)
>>  {
>> -    struct max17040_chip *chip = i2c_get_clientdata(client);
>> +    u32 version;
>>
>> -    if (chip->pdata && chip->pdata->battery_online)
>> -        chip->online = chip->pdata->battery_online();
>> -    else
>> -        chip->online = 1;
>> +    regmap_read(chip->regmap, MAX17040_VER, &version);
>> +
>> +    dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
>>  }
>>
>> -static void max17040_get_status(struct i2c_client *client)
>> +static int max17040_get_online(struct max17040_chip *chip)
>>  {
>> -    struct max17040_chip *chip = i2c_get_clientdata(client);
>> +    return chip->pdata && chip->pdata->battery_online ?
>> +        chip->pdata->battery_online() : 1;
>> +}
>>
>> +static int max17040_get_status(struct max17040_chip *chip)
>> +{
>>      if (!chip->pdata || !chip->pdata->charger_online
>>              || !chip->pdata->charger_enable) {
>> -        chip->status = POWER_SUPPLY_STATUS_UNKNOWN;
>> -        return;
>> +        return POWER_SUPPLY_STATUS_UNKNOWN;
>>      }
>>
>> +    if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
>> +        return POWER_SUPPLY_STATUS_FULL;
>> +
>>      if (chip->pdata->charger_online()) {
>>          if (chip->pdata->charger_enable())
>> -            chip->status = POWER_SUPPLY_STATUS_CHARGING;
>> +            return POWER_SUPPLY_STATUS_CHARGING;
>>          else
>> -            chip->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +            return POWER_SUPPLY_STATUS_NOT_CHARGING;
>>      } else {
>> -        chip->status = POWER_SUPPLY_STATUS_DISCHARGING;
>> +        return POWER_SUPPLY_STATUS_DISCHARGING;
>>      }
>> +}
>> +
>> +static int max17040_get_property(struct power_supply *psy,
>> +                enum power_supply_property psp,
>> +                union power_supply_propval *val)
>> +{
>> +    struct max17040_chip *chip = power_supply_get_drvdata(psy);
>>
>> -    if (chip->soc > MAX17040_BATTERY_FULL)
>> -        chip->status = POWER_SUPPLY_STATUS_FULL;
>> +    switch (psp) {
>> +    case POWER_SUPPLY_PROP_STATUS:
>> +        val->intval = max17040_get_status(chip);
>> +        break;
>> +    case POWER_SUPPLY_PROP_ONLINE:
>> +        val->intval = max17040_get_online(chip);
>> +        break;
>> +    case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +        val->intval = max17040_get_vcell(chip);
>> +        break;
>> +    case POWER_SUPPLY_PROP_CAPACITY:
>> +        val->intval = max17040_get_soc(chip);
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +    return 0;
>>  }
>>
>> +
>>  static int max17040_get_of_data(struct max17040_chip *chip)
>>  {
>>      struct device *dev = &chip->client->dev;
>> +    struct chip_data *data = &max17040_family[
>> +        (enum chip_id) of_device_get_match_data(dev)];
>> +    int rcomp_len;
>> +    u8 rcomp[2];
>>
>>      chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
>>      device_property_read_u32(dev,
>>                   "maxim,alert-low-soc-level",
>>                   &chip->low_soc_alert);
>>
>> -    if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
>> +    if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
>> +        dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
>>          return -EINVAL;
>> +    }
>> +
>> +    chip->quirk_double_soc = device_property_read_bool(dev,
>> +                               "maxim,double-soc");
>> +    chip->quirk_skip_reset = device_property_read_bool(dev,
>> +                               "maxim,skip-reset");
>> +    rcomp_len = device_property_count_u8(dev, "maxim,rcomp");
>> +    chip->rcomp = MAX17040_RCOMP_DEFAULT;
>> +    if (rcomp_len == data->rcomp_bytes) {
>> +        device_property_read_u8_array(dev, "maxim,rcomp",
>> +                          rcomp, rcomp_len);
>> +        chip->rcomp = rcomp_len == 2 ?
>> +            rcomp[0] << 8 | rcomp[1] :
>> +            rcomp[0] << 8;
>> +    } else if (rcomp_len > 0) {
>> +        dev_err(dev, "maxim,rcomp has incorrect length\n");
>> +        return -EINVAL;
>> +    }
>>
>>      return 0;
>>  }
>>
>> -static void max17040_check_changes(struct i2c_client *client)
>> +static void max17040_check_changes(struct max17040_chip *chip)
>>  {
>> -    max17040_get_vcell(client);
>> -    max17040_get_soc(client);
>> -    max17040_get_online(client);
>> -    max17040_get_status(client);
>> +    chip->soc = max17040_get_soc(chip);
>> +    chip->status = max17040_get_status(chip);
>> +}
>> +
>> +static void max17040_queue_work(struct max17040_chip *chip)
>> +{
>> +    queue_delayed_work(system_power_efficient_wq, &chip->work,
>> +               MAX17040_DELAY);
>>  }
>>
>>  static void max17040_work(struct work_struct *work)
>> @@ -214,35 +363,42 @@ static void max17040_work(struct work_struct *work)
>>      /* store SOC and status to check changes */
>>      last_soc = chip->soc;
>>      last_status = chip->status;
>> -    max17040_check_changes(chip->client);
>> +    max17040_check_changes(chip);
>>
>>      /* check changes and send uevent */
>>      if (last_soc != chip->soc || last_status != chip->status)
>>          power_supply_changed(chip->battery);
>>
>> -    queue_delayed_work(system_power_efficient_wq, &chip->work,
>> -               MAX17040_DELAY);
>> +    max17040_queue_work(chip);
>> +}
>> +
>> +static void max17040_stop_work(void *data)
>> +{
>> +    struct max17040_chip *chip = data;
>> +
>> +    cancel_delayed_work_sync(&chip->work);
>>  }
>>
>>  static irqreturn_t max17040_thread_handler(int id, void *dev)
>>  {
>>      struct max17040_chip *chip = dev;
>> -    struct i2c_client *client = chip->client;
>>
>> -    dev_warn(&client->dev, "IRQ: Alert battery low level");
>> +    if (!(chip->data.has_soc_alert && max17040_handle_soc_alert(chip)))
>> +        dev_warn(&chip->client->dev, "IRQ: Alert battery low level\n");
>> +
>>      /* read registers */
>> -    max17040_check_changes(chip->client);
>> +    max17040_check_changes(chip);
>>
>>      /* send uevent */
>>      power_supply_changed(chip->battery);
>>
>> -    /* reset alert bit */
>> -    max17040_set_low_soc_alert(client, chip->low_soc_alert);
>> +    /* reset low soc alert bit */
>> +    max17040_set_low_soc_alert(chip, chip->low_soc_alert);
>>
>>      return IRQ_HANDLED;
>>  }
>>
>> -static int max17040_enable_alert_irq(struct max17040_chip *chip)
>> +static int max17040_setup_irq(struct max17040_chip *chip)
>>  {
>>      struct i2c_client *client = chip->client;
>>      unsigned int flags;
>> @@ -256,6 +412,13 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
>>      return ret;
>>  }
>>
>> +static const struct regmap_config max17040_regmap = {
>> +    .reg_bits    = 8,
>> +    .reg_stride    = 2,
>> +    .val_bits    = 16,
>> +    .val_format_endian = REGMAP_ENDIAN_BIG,
>> +};
>> +
>>  static enum power_supply_property max17040_battery_props[] = {
>>      POWER_SUPPLY_PROP_STATUS,
>>      POWER_SUPPLY_PROP_ONLINE,
>> @@ -277,6 +440,8 @@ static int max17040_probe(struct i2c_client *client,
>>      struct i2c_adapter *adapter = client->adapter;
>>      struct power_supply_config psy_cfg = {};
>>      struct max17040_chip *chip;
>> +    enum chip_id chip_id;
>> +    bool enable_irq = false;
>>      int ret;
>>
>>      if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>> @@ -287,38 +452,63 @@ static int max17040_probe(struct i2c_client *client,
>>          return -ENOMEM;
>>
>>      chip->client = client;
>> +    chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
>>      chip->pdata = client->dev.platform_data;
>> -    ret = max17040_get_of_data(chip);
>> -    if (ret) {
>> -        dev_err(&client->dev,
>> -            "failed: low SOC alert OF data out of bounds\n");
>> -        return ret;
>> +    chip_id = (enum chip_id) id->driver_data;
>> +    if (client->dev.of_node) {
>> +        ret = max17040_get_of_data(chip);
>> +        if (ret)
>> +            return ret;
>> +        chip_id = (enum chip_id) of_device_get_match_data(&client->dev);
>>      }
>> +    chip->data = max17040_family[chip_id];
>>
>>      i2c_set_clientdata(client, chip);
>>      psy_cfg.drv_data = chip;
>>
>> -    chip->battery = power_supply_register(&client->dev,
>> -                &max17040_battery_desc, &psy_cfg);
>> +    chip->battery = devm_power_supply_register(&client->dev,
>> +                    &max17040_battery_desc, &psy_cfg);
>>      if (IS_ERR(chip->battery)) {
>>          dev_err(&client->dev, "failed: power supply register\n");
>>          return PTR_ERR(chip->battery);
>>      }
>>
>> -    max17040_reset(client);
>> -    max17040_get_version(client);
>> +    if (!chip->quirk_skip_reset) {
>> +        max17040_reset(chip);
>> +    }
>> +    max17040_get_version(chip);
>> +    max17040_set_rcomp(chip, chip->rcomp);
>>
>>      /* check interrupt */
>> -    if (client->irq && of_device_is_compatible(client->dev.of_node,
>> -                           "maxim,max77836-battery")) {
>> -        ret = max17040_set_low_soc_alert(client, chip->low_soc_alert);
>> +    if (client->irq && chip->data.has_low_soc_alert) {
>> +        ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
>>          if (ret) {
>>              dev_err(&client->dev,
>>                  "Failed to set low SOC alert: err %d\n", ret);
>>              return ret;
>>          }
>> +        enable_irq = true;
>> +    }
>> +
>> +    if (client->irq && chip->data.has_soc_alert) {
>> +        ret = max17040_set_soc_alert(chip, 1);
>> +        if (ret) {
>> +            dev_err(&client->dev,
>> +                "Failed to set SOC alert: err %d\n", ret);
>> +            return ret;
>> +        }
>> +        enable_irq = true;
>> +    } else {
>> +        /* soc alerts negate the need for polling */
>> +        INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
>> +        ret = devm_add_action(&client->dev, max17040_stop_work, chip);
>> +        if (ret)
>> +            return ret;
>> +        max17040_queue_work(chip);
>> +    }
>>
>> -        ret = max17040_enable_alert_irq(chip);
>> +    if (enable_irq) {
>> +        ret = max17040_setup_irq(chip);
>>          if (ret) {
>>              client->irq = 0;
>>              dev_warn(&client->dev,
>> @@ -326,19 +516,6 @@ static int max17040_probe(struct i2c_client *client,
>>          }
>>      }
>>
>> -    INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
>> -    queue_delayed_work(system_power_efficient_wq, &chip->work,
>> -               MAX17040_DELAY);
>> -
>> -    return 0;
>> -}
>> -
>> -static int max17040_remove(struct i2c_client *client)
>> -{
>> -    struct max17040_chip *chip = i2c_get_clientdata(client);
>> -
>> -    power_supply_unregister(chip->battery);
>> -    cancel_delayed_work(&chip->work);
>>      return 0;
>>  }
>>
>> @@ -349,10 +526,13 @@ static int max17040_suspend(struct device *dev)
>>      struct i2c_client *client = to_i2c_client(dev);
>>      struct max17040_chip *chip = i2c_get_clientdata(client);
>>
>> -    cancel_delayed_work(&chip->work);
>> -
>>      if (client->irq && device_may_wakeup(dev))
>>          enable_irq_wake(client->irq);
>> +    if (client->irq && chip->data.has_soc_alert)
>> +        // disable soc alert to prevent wakeup
>> +        max17040_set_soc_alert(chip, 0);
>> +    else
>> +        cancel_delayed_work(&chip->work);
>>
>>      return 0;
>>  }
>> @@ -362,11 +542,12 @@ static int max17040_resume(struct device *dev)
>>      struct i2c_client *client = to_i2c_client(dev);
>>      struct max17040_chip *chip = i2c_get_clientdata(client);
>>
>> -    queue_delayed_work(system_power_efficient_wq, &chip->work,
>> -               MAX17040_DELAY);
>> -
>>      if (client->irq && device_may_wakeup(dev))
>>          disable_irq_wake(client->irq);
>> +    if (client->irq && chip->data.has_soc_alert)
>> +        max17040_set_soc_alert(chip, 1);
>> +    else
>> +        max17040_queue_work(chip);
>>
>>      return 0;
>>  }
>> @@ -381,16 +562,30 @@ static SIMPLE_DEV_PM_OPS(max17040_pm_ops, max17040_suspend, max17040_resume);
>>  #endif /* CONFIG_PM_SLEEP */
>>
>>  static const struct i2c_device_id max17040_id[] = {
>> -    { "max17040" },
>> -    { "max77836-battery" },
>> -    { }
>> +    { "max17040", ID_MAX17040 },
>> +    { "max17041", ID_MAX17041 },
>> +    { "max17043", ID_MAX17043 },
>> +    { "max77836-battery", ID_MAX17043 },
>> +    { "max17044", ID_MAX17044 },
>> +    { "max17048", ID_MAX17048 },
>> +    { "max17049", ID_MAX17049 },
>> +    { "max17058", ID_MAX17058 },
>> +    { "max17059", ID_MAX17059 },
>> +    { /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, max17040_id);
>>
>>  static const struct of_device_id max17040_of_match[] = {
>> -    { .compatible = "maxim,max17040" },
>> -    { .compatible = "maxim,max77836-battery" },
>> -    { },
>> +    { .compatible = "maxim,max17040", .data = (void *) ID_MAX17040 },
>> +    { .compatible = "maxim,max17041", .data = (void *) ID_MAX17041 },
>> +    { .compatible = "maxim,max17043", .data = (void *) ID_MAX17043 },
>> +    { .compatible = "maxim,max77836-battery", .data = (void *) ID_MAX17043 },
>> +    { .compatible = "maxim,max17044", .data = (void *) ID_MAX17044 },
>> +    { .compatible = "maxim,max17048", .data = (void *) ID_MAX17048 },
>> +    { .compatible = "maxim,max17049", .data = (void *) ID_MAX17049 },
>> +    { .compatible = "maxim,max17058", .data = (void *) ID_MAX17058 },
>> +    { .compatible = "maxim,max17059", .data = (void *) ID_MAX17059 },
>> +    { /* sentinel */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, max17040_of_match);
>>
>> @@ -401,7 +596,6 @@ static struct i2c_driver max17040_i2c_driver = {
>>          .pm    = MAX17040_PM_OPS,
>>      },
>>      .probe        = max17040_probe,
>> -    .remove        = max17040_remove,
>>      .id_table    = max17040_id,
>>  };
>>  module_i2c_driver(max17040_i2c_driver);
>> --
>> 2.27.0
>>


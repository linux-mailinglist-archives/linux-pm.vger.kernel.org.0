Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ACE43B182
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhJZLxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 07:53:09 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56742 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235554AbhJZLxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 07:53:09 -0400
Received: from [79.2.93.196] (port=34448 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mfKyZ-004slB-G4; Tue, 26 Oct 2021 13:50:43 +0200
Subject: Re: [PATCH 2/2] power: supply: max77976: add Maxim MAX77976 charger
 driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211004130732.950512-1-luca@lucaceresoli.net>
 <20211004130732.950512-2-luca@lucaceresoli.net>
 <20211025220256.tlsfosmuclbioj5m@earth.universe>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <d8f6daba-4cb5-002e-9d3f-16825bf8c96b@lucaceresoli.net>
Date:   Tue, 26 Oct 2021 13:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025220256.tlsfosmuclbioj5m@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 26/10/21 00:02, Sebastian Reichel wrote:
[...]
>> +config CHARGER_MAX77976
>> +	tristate "Maxim MAX77976 battery charger driver"
>> +	depends on REGMAP_I2C
> 
> needs to be selected as pointed out by Randy.

Yes, fix ready for v2.

>> +static int max77976_get_health(struct max77976 *chg, int *val)
>> +{
>> +	unsigned int regval;
>> +	int err;
>> +
>> +	err = regmap_field_read(chg->rfield[BAT_DTLS], &regval);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	switch (regval) {
>> +	case MAX77976_BATTERY_BATTERY_REMOVAL:
>> +		*val = POWER_SUPPLY_HEALTH_DEAD;
>> +		break;
> 
> I suppose the charger is still able to power the system when
> there is no battery, so it's not dead.

Correct.

> I think this should
> either report POWER_SUPPLY_HEALTH_GOOD or introduce a new
> POWER_SUPPLY_HEALTH_NO_BATTERY.

Introducing POWER_SUPPLY_HEALTH_NO_BATTERY seems to be the correct way.
I'll add a patch for that.

>> +	case MAX77976_BATTERY_PREQUALIFICATION:
>> +	case MAX77976_BATTERY_LOW_VOLTAGE:
> 
> Not sure what prequalification is, but at least low voltage seems
> like a candidate to either introduce a new health property, or
> report an unspecified failure instead of HEALTH_GOOD.

Prequalification is defined in the datasheet [0] as: "A valid adapter is
present and the battery voltage is low: V_BATT < V_TRICKLE" (page 57).
The battery is charged at a very low current (300 mA) until voltage goes
above V_trickle (3.1 V).

[0] https://datasheets.maximintegrated.com/en/ds/MAX77975-MAX77976.pdf

This state probably very short-lived as I don't normally observe it even
when connecting a completely discharged battery.

To the best of my understanding, in this state the charger is charging
slowly to ensure the battery is good while staying safe. Perhaps this
should return POWER_SUPPLY_HEALTH_UNKNOWN then.

Low voltage is defined as: "A valid adapter is present and the battery
voltage is lower than the minimum system regulation level but higher
than prequalification voltage: V_TRICKLE < V_BATT < V_SYSMIN. V_SYS is
regulated at least equal to V_SYSMIN".

In this state the battery is not fully charged but it is OK, as
confirmed by the definition of bit BAT_OK in the CHG_INT_OK register
(0x12): "The battery is okay. BAT_DTLS = 0x03,0x04 or 0x07", value 0x04
being MAX77976_BATTERY_LOW_VOLTAGE.

So I think I should change PREQUALIFICATION to report
POWER_SUPPLY_HEALTH_UNKNOWN and leave LOW_VOLTAGE as is. Does it sound
correct?

>> +static const struct power_supply_desc max77976_psy_desc = {
>> +	.name			= MAX77976_DRIVER_NAME,
>> +	.type			= POWER_SUPPLY_TYPE_BATTERY,
> 
> Incorrect type. TYPE_BATTERY is for fuel gauges. Looks like max77976
> is supposed to be used with USB, so:
> 
> .type = POWER_SUPPLY_TYPE_USB,

Even though this charger is definitely a USB-oriented one, it is not
restricted to USB. E.g. I'm using it without any USB. Should I use
POWER_SUPPLY_TYPE_USB anyway?

>> +/* --------------------------------------------------------------------------
>> + * Entry point
>> + */
>> +
>> +static int max77976_detect(struct max77976 *chg)
>> +{
>> +	struct device *dev = &chg->client->dev;
>> +	unsigned int id, ver, rev;
>> +	int err;
>> +
>> +	err = regmap_read(chg->regmap, MAX77976_REG_CHIP_ID, &id);
>> +	if (err)
>> +		return dev_err_probe(dev, err, "cannot read chip ID\n");
>> +
>> +	if (id != MAX77976_CHIP_ID)
>> +		return dev_err_probe(dev, -ENXIO, "unknown model ID 0x%02x\n", id);
>> +
>> +	err = regmap_field_read(chg->rfield[VERSION], &ver);
>> +	if (!err)
>> +		err = regmap_field_read(chg->rfield[REVISION], &rev);
>> +	if (err)
>> +		return dev_err_probe(dev, -ENXIO, "cannot read version/revision\n");
>> +
>> +	dev_info(dev, "detected model MAX779%02x ver %u rev %u", id, ver, rev);
>> +
>> +	return 0;
>> +}
> 
> missing newline

Ouch.

-- 
Luca

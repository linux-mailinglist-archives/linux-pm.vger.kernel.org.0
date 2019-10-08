Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65365CF10D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfJHDJp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 7 Oct 2019 23:09:45 -0400
Received: from hermes.aosc.io ([199.195.250.187]:53710 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbfJHDJp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Oct 2019 23:09:45 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0EA728355D;
        Tue,  8 Oct 2019 03:09:41 +0000 (UTC)
Date:   Tue, 08 Oct 2019 11:09:34 +0800
In-Reply-To: <CAGb2v65MPG=zbKtQk1oXq+TYP=0fPBXEj0fcGA=6mCD2+Smmpg@mail.gmail.com>
References: <20191002112545.58481-1-icenowy@aosc.io> <20191002112545.58481-3-icenowy@aosc.io> <CAGb2v65MPG=zbKtQk1oXq+TYP=0fPBXEj0fcGA=6mCD2+Smmpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 2/2] power: supply: axp20x_usb_power: add applied max Vbus support for AXP813
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
CC:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <A6B1EF32-5CDE-4AAE-A7DA-F9A636BE7BF3@aosc.io>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



于 2019年10月8日 GMT+08:00 上午12:07:05, Chen-Yu Tsai <wens@csie.org> 写到:
>Hi,
>
>On Wed, Oct 2, 2019 at 7:27 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>> AXP813 PMIC has two Vbus maximum value settings -- one is the default
>> value, which is currently the only supported one; the other is the
>> really applied value, which is set according to the default value if
>the
>> BC detection module detected a charging port, or 500mA if no charging
>> port is detected.
>>
>> Add support for reading and writing of the really applied Vbus
>maxmium
>> value. Interestingly it has a larger range than the default value.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  drivers/power/supply/axp20x_usb_power.c | 132
>+++++++++++++++++++++++-
>>  1 file changed, 129 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/axp20x_usb_power.c
>b/drivers/power/supply/axp20x_usb_power.c
>> index 5f0a5722b19e..905668a2727f 100644
>> --- a/drivers/power/supply/axp20x_usb_power.c
>> +++ b/drivers/power/supply/axp20x_usb_power.c
>
>[...]
>
>> @@ -354,6 +451,9 @@ static int axp20x_usb_power_set_property(struct
>power_supply *psy,
>>                                                                
>val->intval);
>>                 return axp20x_usb_power_set_current_max(power,
>val->intval);
>>
>> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +               return
>axp20x_usb_power_set_input_current_limit(power, val->intval);
>> +
>
>So I think there are two things that should be adjusted.
>
>First, we should be using POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT for all
>PMICs.
>As far as the sysfs documents go, CURRENT_MAX is read-only, and should
>refer to
>the hard limit the hardware can support, i.e. maximum power ratings.
>INPUT_CURRENT_LIMIT and INPUT_VOLTAGE_LIMIT are for configurable upper
>and lower
>limits respectively.
>
>Sebastian, is my understanding of this correct?
>
>We already use INPUT_CURRENT_LIMIT for the AXP813 in the axp20x-ac
>driver, and
>it would be nice to have both drivers expose the same attributes.
>
>Second, since the value set in register 0x35 is the one that actually
>has an
>effect, as opposed to just being a default, we should just use that
>one.

However, that default value is also important, otherwise users will
get dropped back to 500mAh each time they re-insert USB jack.

Is there a property to export the default value?

BTW, if possible, apply patch 1 first, because it can raise current to 1.5A
in the default situation.

>
>Could you restructure the series based on what I described, with a new
>patch 1
>switching from CURRENT_MAX to INPUT_CURRENT_LIMIT, and then this patch
>as patch 2?
>And both patches should have Fixes tags and possibly CC stable so they
>get backported
>for people that are using stable kernels? And then the original patch
>2 as patch 3.
>
>ChenYu
>
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -365,7 +465,8 @@ static int axp20x_usb_power_prop_writeable(struct
>power_supply *psy,
>>                                            enum power_supply_property
>psp)
>>  {
>>         return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
>> -              psp == POWER_SUPPLY_PROP_CURRENT_MAX;
>> +              psp == POWER_SUPPLY_PROP_CURRENT_MAX ||
>> +              psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
>>  }
>>
>>  static enum power_supply_property axp20x_usb_power_properties[] = {
>> @@ -386,6 +487,15 @@ static enum power_supply_property
>axp22x_usb_power_properties[] = {
>>         POWER_SUPPLY_PROP_CURRENT_MAX,
>>  };
>>
>> +static enum power_supply_property axp813_usb_power_properties[] = {
>> +       POWER_SUPPLY_PROP_HEALTH,
>> +       POWER_SUPPLY_PROP_PRESENT,
>> +       POWER_SUPPLY_PROP_ONLINE,
>> +       POWER_SUPPLY_PROP_VOLTAGE_MIN,
>> +       POWER_SUPPLY_PROP_CURRENT_MAX,
>> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>> +};
>> +
>>  static const struct power_supply_desc axp20x_usb_power_desc = {
>>         .name = "axp20x-usb",
>>         .type = POWER_SUPPLY_TYPE_USB,
>> @@ -406,6 +516,16 @@ static const struct power_supply_desc
>axp22x_usb_power_desc = {
>>         .set_property = axp20x_usb_power_set_property,
>>  };
>>
>> +static const struct power_supply_desc axp813_usb_power_desc = {
>> +       .name = "axp20x-usb",
>> +       .type = POWER_SUPPLY_TYPE_USB,
>> +       .properties = axp813_usb_power_properties,
>> +       .num_properties = ARRAY_SIZE(axp813_usb_power_properties),
>> +       .property_is_writeable = axp20x_usb_power_prop_writeable,
>> +       .get_property = axp20x_usb_power_get_property,
>> +       .set_property = axp20x_usb_power_set_property,
>> +};
>> +
>>  static int configure_iio_channels(struct platform_device *pdev,
>>                                   struct axp20x_usb_power *power)
>>  {
>> @@ -487,10 +607,16 @@ static int axp20x_usb_power_probe(struct
>platform_device *pdev)
>>                 usb_power_desc = &axp20x_usb_power_desc;
>>                 irq_names = axp20x_irq_names;
>>         } else if (power->axp20x_id == AXP221_ID ||
>> -                  power->axp20x_id == AXP223_ID ||
>> -                  power->axp20x_id == AXP813_ID) {
>> +                  power->axp20x_id == AXP223_ID) {
>>                 usb_power_desc = &axp22x_usb_power_desc;
>>                 irq_names = axp22x_irq_names;
>> +       } else if (power->axp20x_id == AXP813_ID) {
>> +               usb_power_desc = &axp813_usb_power_desc;
>> +               irq_names = axp22x_irq_names;
>> +
>> +               /* Enable USB Battery Charging specification
>detection */
>> +               regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
>> +                                  AXP813_BC_EN, AXP813_BC_EN);
>
>This seems like a duplicate of
>
>>         } else {
>>                 dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
>>                         axp20x->variant);
>> --
>> 2.21.0
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> To view this discussion on the web, visit
>https://groups.google.com/d/msgid/linux-sunxi/20191002112545.58481-3-icenowy%40aosc.io.

-- 
使用 K-9 Mail 发送自我的Android设备。

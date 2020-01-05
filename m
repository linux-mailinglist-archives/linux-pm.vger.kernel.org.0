Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB8130955
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 18:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAERry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 12:47:54 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47033 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgAERry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 12:47:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AE5C75D9;
        Sun,  5 Jan 2020 12:47:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 05 Jan 2020 12:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=e
        AIzG6BE28y2J69mx9B796bBuUAd67pkMdQXZJ/2kB0=; b=BLGL9J1TIHOU2+3NU
        +uBQZPXApr8+EvTaVkw1rX+FnqIMhpWRuuggv0MbMbLIqK6sx8yEo9YdraeUusuU
        6UB8e3y/7oLuHaCD8ajpN76sSfOhE33j7/Y5JL4L4irekDDy69vhWYVc5EmegWzO
        WK7FeFgTTbCzsmNBylP/ysdpSImInkgG0mJx0yGR+3WkRUzCShV6CjGg7hgWEasm
        PbD6QRPq4hI+Fd7MXm8Vcv937SUHfG1to5s+WlVqH7qxyE+SS7pbK/wEvALncOmv
        UVDp3JBzIWr/Qoahk3CWKbFUB+bCWXtEW+EcWiWly5WEE+Ks9vjsNzGfoM/r+kLK
        1qkGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=eAIzG6BE28y2J69mx9B796bBuUAd67pkMdQXZJ/2k
        B0=; b=Wfr6EvI8ffs2zkJj/CMcdZGGFG372GtrNU1lteh9hxHu78AQl4q26L008
        v160FxynM4b1hd6r0D5VUWWBm8wErM7GmcnaVOx3+H0DqyjZuJcxxe43pW5fDINd
        vVEGSLDvHk8imZqlxNPE9N7UolpXVXL2u575Toc9Cb3wr9vbtP+tTH7m1gZjWaP8
        UpMicl93BnMOXu7ZsgG40MEWPTox+bcc11ddIlxPjkFxTUYf+A29UdXz9QBGHMLE
        bpkpZpF3kaUYHafqT7z/ukN5/bNoYhr6PKz+2XczdIFLAxzopya/Aug7Eh81AlEF
        O1ZZHsZJ27E7eAR7nj6tTMeMrux4A==
X-ME-Sender: <xms:RyESXnUB3WyicUnL8IX30wUhwsPnICpoKuOu9sXGrewXmEZRPH-chA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    fkphepjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    rghmuhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:RyESXpgCfFiVOTkjiTSr7UQbi--GXiM7Mu6vyzJzpqe0brUaqtNbbA>
    <xmx:RyESXlS0IGMwIp4tBOATq5nDvbFXXuxfLua0y0xXeFmTwgLhiMceWg>
    <xmx:RyESXty-Z4JsgISIJFZKfgzEVbvA-m7wucDV61L1JkpM-jXX9XO0Jw>
    <xmx:SCESXuywb8GSjCPS17TbxgIeFSArW3A6ecPvn6-dxuwE9TR5PP0Fng>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2738630602DB;
        Sun,  5 Jan 2020 12:47:51 -0500 (EST)
Subject: Re: [linux-sunxi] [PATCH v2 7/9] power: supply: axp20x_usb_power:
 Allow offlining
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200105012416.23296-1-samuel@sholland.org>
 <20200105012416.23296-8-samuel@sholland.org>
 <CAGb2v67esqWZnKa8QNQAp8w-fhN+hM=zO9kUdzO9vFgr0FbfEQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f0c5e260-dcc3-2744-21cd-305e4534f2be@sholland.org>
Date:   Sun, 5 Jan 2020 11:47:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v67esqWZnKa8QNQAp8w-fhN+hM=zO9kUdzO9vFgr0FbfEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/5/20 4:40 AM, Chen-Yu Tsai wrote:
> On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> AXP803/AXP813 have a flag that enables/disables the USB power supply
>> input. Allow control of this flag via the ONLINE property on those
>> variants.
>>
>> It may be necessary to offline the USB power supply input when using
>> the USB port in OTG mode, or to allow userspace to disable charging.
> 
> Any idea how the former would be implemented? AFAIK this isn't allowed
> right now.

Pinephone currently has AXP N_VBUSEN/DRIVEVBUS floating, so the hardware doesn't
automatically disable the VBUS path when enabling the boost regulator driving
it. This doubles the current draw from the battery.

The USB PHY driver would need to call:

    union power_supply_propval val = { .intval = false };
    power_supply_set_property(data->vbus_power_supply,
                              POWER_SUPPLY_PROP_ONLINE, &val);

or similar to set VBUS offline in sun4i_usb_phy_power_on(), and set it back
online in sun4i_usb_phy_power_off().

> As for disabling charging, wouldn't it make more sense to disable the
> charger?

Yes, I see now that there's a bit at 33H[7] for this. I don't see an obvious
property to hook it up to, though. Maybe POWER_SUPPLY_PROP_CHARGE_TYPE ==
POWER_SUPPLY_CHARGE_TYPE_NONE?

> Either way, these are not directly related to the changes. I'm just curious.
> 
>> When the USB VBUS input is disabled via the PATH_SEL bit, the VBUS_USED
>> bit in PWR_INPUT_STATUS is cleared, so there is no change needed when
>> getting the property.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  drivers/power/supply/axp20x_usb_power.c | 27 +++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
>> index 2d7272e19a87..68443f264dff 100644
>> --- a/drivers/power/supply/axp20x_usb_power.c
>> +++ b/drivers/power/supply/axp20x_usb_power.c
>> @@ -29,6 +29,9 @@
>>
>>  #define AXP20X_USB_STATUS_VBUS_VALID   BIT(2)
>>
>> +#define AXP20X_VBUS_PATH_SEL           BIT(7)
>> +#define AXP20X_VBUS_PATH_SEL_OFFSET    7
>> +
>>  #define AXP20X_VBUS_VHOLD_uV(b)                (4000000 + (((b) >> 3) & 7) * 100000)
>>  #define AXP20X_VBUS_VHOLD_MASK         GENMASK(5, 3)
>>  #define AXP20X_VBUS_VHOLD_OFFSET       3
>> @@ -263,6 +266,16 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>>         return 0;
>>  }
>>
>> +static int axp813_usb_power_set_online(struct axp20x_usb_power *power,
>> +                                      int intval)
>> +{
>> +       int val = !intval << AXP20X_VBUS_PATH_SEL_OFFSET;
>> +
>> +       return regmap_update_bits(power->regmap,
>> +                                 AXP20X_VBUS_IPSOUT_MGMT,
>> +                                 AXP20X_VBUS_PATH_SEL, val);
>> +}
>> +
>>  static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>>                                             int intval)
>>  {
>> @@ -344,6 +357,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
>>         struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
>>
>>         switch (psp) {
>> +       case POWER_SUPPLY_PROP_ONLINE:
>> +               return axp813_usb_power_set_online(power, val->intval);
>> +
> 
> I would add a comment here pointing to the next change as to why there's
> only an axp813-specific callback used here.

I'll add this for v3.

>>         case POWER_SUPPLY_PROP_VOLTAGE_MIN:
>>                 return axp20x_usb_power_set_voltage_min(power, val->intval);
>>
>> @@ -363,6 +379,17 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
>>  static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
>>                                            enum power_supply_property psp)
>>  {
>> +       struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
>> +
>> +       /*
>> +        * Both AXP2xx and AXP8xx have a VBUS path select flag.
>> +        * On AXP2xx, setting the flag enables VBUS (ignoring N_VBUSEN).
>> +        * On AXP8xx, setting the flag disables VBUS (ignoring N_VBUSEN).
>> +        * So we only expose the control on AXP8xx where it is meaningful.
>> +        */
>> +       if (psp == POWER_SUPPLY_PROP_ONLINE)
>> +               return power->axp20x_id == AXP813_ID;
>> +
>>         return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
>>                psp == POWER_SUPPLY_PROP_CURRENT_MAX;
>>  }
>> --
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 


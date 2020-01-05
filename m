Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32313095B
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAER7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 12:59:00 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38861 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbgAER7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 12:59:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 956575E0;
        Sun,  5 Jan 2020 12:58:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 05 Jan 2020 12:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=5
        ksL3g3kVn59kPSAr7oEd6xtiyAbogKcN6cXvlEk9x8=; b=GrxTZ/zXMKEHM2pzy
        rn2CcueRok9IgoBb/NH9QRxd3YqkoHDFbB6wM7wcGTUD9sMgUasN7qr6OPsx+WzG
        sNY8DZpFaSLuCEQ6mXx8AoKYdjTIYhTpi25O5/5WHVfZcD/tQOTEXaSFJUM3Fc5N
        /nM/pDtiVlTpEDLOAkyfzaUxcZFpCSZo1/+MkTPeUVflUxEQzNCesIdUjPRXvcEa
        6MZNZuQ/ZDE/FKgO0vFOYmJT7EyJt8KDaxpnuG/nf5hNCuazLYrMME8YWtcvyOTu
        fEdlCCpzrH73BqAHx7j4n/A39SP1OneKFRCMUWY48vSxWtwHgrcGr8Y8H1bAC6jZ
        bIv9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=5ksL3g3kVn59kPSAr7oEd6xtiyAbogKcN6cXvlEk9
        x8=; b=Zkxo5zg59vo+JXgtpS6Y/6tCaGHzPlflfkeyax1Kt3jONGvyy33jXBxor
        cBPhAr59NzQGN5m9FoCVvdvHy1820kOq/SChtCPUJQ3JQ2liZU5vJMeTd8XRzdaE
        o1IuVfKEbCSHI4ZR2hoPoh00Ro9dVO1ScnfuzIVnB5QwIbrCkR6i/RZD61Zm/q/K
        giB6G0ukwsVnpD9g9nTnrVikn32kwoqNhOsHRx34zjenbWeVmfetrtR843kaAOo+
        4CgyL2hNNWrLkl5OfC9jFQCQd3EYHITL61hJKSESGydKmC8D20v/D/t7JXNURNtJ
        Ck6jaw6YQz9Oo/E7enxGlhKX3A/WA==
X-ME-Sender: <xms:4SMSXn6vVndzRJt8fNYYY-S8T5_IjkldE16fnU7nLJFVfixCXCy4Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegkedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    fkphepjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    rghmuhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4SMSXhLi4F65BgNTlWtvnjj1xkn2UDUl2emx031BMFmXRDC_hRggKA>
    <xmx:4SMSXpdaHzcQmCc0iO4X_4td8oSg6sDE8xshNjLUafgEYjLhDPbZEQ>
    <xmx:4SMSXsdF8Ce4GqPs91Lt0en_QkmypJ4IRTC98gC4njyWWesmmq4zYg>
    <xmx:4iMSXqpcmZ92drsb3oaUoB0bbvzKjItu4fTHvuMlUNu3GyRoJK2_FA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6080C30602DB;
        Sun,  5 Jan 2020 12:58:57 -0500 (EST)
Subject: Re: [linux-sunxi] [PATCH v2 6/9] power: supply: axp20x_usb_power: Use
 a match structure
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200105012416.23296-1-samuel@sholland.org>
 <20200105012416.23296-7-samuel@sholland.org>
 <CAGb2v67rudw=3x9QBxeSqmMN-Qrt4+=3VD0u6H7JeS4KT8caqg@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f40d7523-9eac-619c-1621-42b35c6cefbc@sholland.org>
Date:   Sun, 5 Jan 2020 11:58:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v67rudw=3x9QBxeSqmMN-Qrt4+=3VD0u6H7JeS4KT8caqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/5/20 4:34 AM, Chen-Yu Tsai wrote:
> On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> Instead of ad-hoc variant ID checks throughout the code, let's start
>> moving the variant-specific details to a match structure. This allows
>> for future flexibility, and it better matches the other axp20x power
>> supply drivers.
> 
> You should probably mention that there are still parts of the code
> where ID matching is done.

Will do for v3.

>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  drivers/power/supply/axp20x_usb_power.c | 91 ++++++++++++++++---------
>>  1 file changed, 60 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
>> index dd3f3f12e41d..2d7272e19a87 100644
>> --- a/drivers/power/supply/axp20x_usb_power.c
>> +++ b/drivers/power/supply/axp20x_usb_power.c
>> @@ -405,6 +405,50 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
>>         .set_property = axp20x_usb_power_set_property,
>>  };
>>
>> +static const char * const axp20x_irq_names[] = {
>> +       "VBUS_PLUGIN",
>> +       "VBUS_REMOVAL",
>> +       "VBUS_VALID",
>> +       "VBUS_NOT_VALID",
>> +       NULL
>> +};
>> +
>> +static const char * const axp22x_irq_names[] = {
>> +       "VBUS_PLUGIN",
>> +       "VBUS_REMOVAL",
>> +       NULL
>> +};
>> +
>> +struct axp_data {
>> +       const struct power_supply_desc  *power_desc;
>> +       const char * const              *irq_names;
>> +       enum axp20x_variants            axp20x_id;
>> +};
>> +
>> +static const struct axp_data axp202_data = {
>> +       .power_desc     = &axp20x_usb_power_desc,
>> +       .irq_names      = axp20x_irq_names,
>> +       .axp20x_id      = AXP202_ID,
>> +};
>> +
>> +static const struct axp_data axp221_data = {
>> +       .power_desc     = &axp22x_usb_power_desc,
>> +       .irq_names      = axp22x_irq_names,
>> +       .axp20x_id      = AXP221_ID,
>> +};
>> +
>> +static const struct axp_data axp223_data = {
>> +       .power_desc     = &axp22x_usb_power_desc,
>> +       .irq_names      = axp22x_irq_names,
>> +       .axp20x_id      = AXP223_ID,
>> +};
>> +
>> +static const struct axp_data axp813_data = {
>> +       .power_desc     = &axp22x_usb_power_desc,
>> +       .irq_names      = axp22x_irq_names,
>> +       .axp20x_id      = AXP813_ID,
>> +};
>> +
>>  static int configure_iio_channels(struct platform_device *pdev,
>>                                   struct axp20x_usb_power *power)
>>  {
>> @@ -440,12 +484,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>>         struct power_supply_config psy_cfg = {};
>>         struct axp20x_usb_power *power;
>> -       static const char * const axp20x_irq_names[] = { "VBUS_PLUGIN",
>> -               "VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
>> -       static const char * const axp22x_irq_names[] = {
>> -               "VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
>> -       const char * const *irq_names;
>> -       const struct power_supply_desc *usb_power_desc;
>> +       const struct axp_data *axp_data;
>>         int i, irq, ret;
>>
>>         if (!of_device_is_available(pdev->dev.of_node))
>> @@ -456,15 +495,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>>                 return -EINVAL;
>>         }
>>
>> +       axp_data = of_device_get_match_data(&pdev->dev);
>> +
>>         power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
>>         if (!power)
>>                 return -ENOMEM;
>>
>> -       platform_set_drvdata(pdev, power);
>> -       power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
>> -                                                               &pdev->dev);
>> -
>>         power->regmap = axp20x->regmap;
>> +       power->axp20x_id = axp_data->axp20x_id;
>> +
>> +       platform_set_drvdata(pdev, power);
> 
> Not sure why this needs to be reordered.

It doesn't necessarily; moving the call to platform_set_drvdata() matches the
order in axp20x_ac_power, which makes it easier to compare the two probe
functions. I can drop it for v3 if you prefer.

>>         if (power->axp20x_id == AXP202_ID) {
>>                 /* Enable vbus valid checking */
>> @@ -481,18 +521,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>>
>>                 if (ret)
>>                         return ret;
>> -
>> -               usb_power_desc = &axp20x_usb_power_desc;
>> -               irq_names = axp20x_irq_names;
>> -       } else if (power->axp20x_id == AXP221_ID ||
>> -                  power->axp20x_id == AXP223_ID ||
>> -                  power->axp20x_id == AXP813_ID) {
>> -               usb_power_desc = &axp22x_usb_power_desc;
>> -               irq_names = axp22x_irq_names;
>> -       } else {
>> -               dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
>> -                       axp20x->variant);
>> -               return -EINVAL;
>>         }
>>
>>         if (power->axp20x_id == AXP813_ID) {
>> @@ -504,17 +532,18 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>>         psy_cfg.of_node = pdev->dev.of_node;
>>         psy_cfg.drv_data = power;
>>
>> -       power->supply = devm_power_supply_register(&pdev->dev, usb_power_desc,
>> +       power->supply = devm_power_supply_register(&pdev->dev,
>> +                                                  axp_data->power_desc,
>>                                                    &psy_cfg);
>>         if (IS_ERR(power->supply))
>>                 return PTR_ERR(power->supply);
>>
>>         /* Request irqs after registering, as irqs may trigger immediately */
>> -       for (i = 0; irq_names[i]; i++) {
>> -               irq = platform_get_irq_byname(pdev, irq_names[i]);
>> +       for (i = 0; axp_data->irq_names[i]; i++) {
>> +               irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
>>                 if (irq < 0) {
>>                         dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
>> -                                irq_names[i], irq);
>> +                                axp_data->irq_names[i], irq);
>>                         continue;
>>                 }
>>                 irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> @@ -522,7 +551,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>>                                 axp20x_usb_power_irq, 0, DRVNAME, power);
>>                 if (ret < 0)
>>                         dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
>> -                                irq_names[i], ret);
>> +                                axp_data->irq_names[i], ret);
>>         }
>>
>>         INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
>> @@ -544,16 +573,16 @@ static int axp20x_usb_power_remove(struct platform_device *pdev)
>>  static const struct of_device_id axp20x_usb_power_match[] = {
>>         {
>>                 .compatible = "x-powers,axp202-usb-power-supply",
>> -               .data = (void *)AXP202_ID,
>> +               .data = &axp202_data,
>>         }, {
>>                 .compatible = "x-powers,axp221-usb-power-supply",
>> -               .data = (void *)AXP221_ID,
>> +               .data = &axp221_data,
>>         }, {
>>                 .compatible = "x-powers,axp223-usb-power-supply",
>> -               .data = (void *)AXP223_ID,
>> +               .data = &axp223_data,
>>         }, {
>>                 .compatible = "x-powers,axp813-usb-power-supply",
>> -               .data = (void *)AXP813_ID,
>> +               .data = &axp813_data,
>>         }, { /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
>> --
>> 2.23.0
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 


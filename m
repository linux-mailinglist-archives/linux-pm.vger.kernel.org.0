Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04861ED050
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2019 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKBS6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Nov 2019 14:58:22 -0400
Received: from gateway36.websitewelcome.com ([192.185.184.18]:11239 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfKBS6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Nov 2019 14:58:22 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Nov 2019 14:58:21 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 2A8A0400E1BB4
        for <linux-pm@vger.kernel.org>; Sat,  2 Nov 2019 12:21:09 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id QxtJizc4iBnGaQxtKiclPv; Sat, 02 Nov 2019 13:12:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+g5tAwaZ2CLSWMBxol++9wXqEbouJExOmuVPL3x8TsE=; b=D6Oa+bKBQztv7UHbHDkomFfesI
        heZLMjcWlKncM00SjWaLDKEkEmiTgXK646CmZbVYIYAoCNFt4LXpToc9haNc6pqk0IPF4tDQKIGDB
        ztbwyyGemxm2qi9W41huTvrs1pnRaVdQOhqIgPyjufbxy8L8WWTj5XzW6XEyfuwr4CAK8O1u18XY5
        3FEPzuR51IPEwIGN2gOmrvEFR9WDEKok93hgxlCQ/iGrCWR8fAxYwoSfVpHPY1i3Rpf1BU3vPfEjp
        LUxTL1ccnernMXttw2mDEyndlbRwuTCaib6hAH8MtNu0ebtZZ6YiDf1+zed0la7mPNVjdUSCDZS+s
        sjol9v9A==;
Received: from [191.31.198.254] (port=58308 helo=[192.168.15.3])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iQxtJ-003Nkf-Bk; Sat, 02 Nov 2019 15:12:49 -0300
Subject: Re: [PATCH v4 3/4] power: supply: max17040: Config alert SOC low
 level threshold from FDT
From:   Matheus Castello <matheus@castello.eng.br>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-4-matheus@castello.eng.br> <20191101152755.GC28931@pi3>
 <c18ab487-6242-4ac2-b2c2-ef78c899521a@castello.eng.br>
Message-ID: <4acd4bcf-4488-01f2-cacc-0170c33e20c2@castello.eng.br>
Date:   Sat, 2 Nov 2019 15:12:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c18ab487-6242-4ac2-b2c2-ef78c899521a@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.198.254
X-Source-L: No
X-Exim-ID: 1iQxtJ-003Nkf-Bk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.3]) [191.31.198.254]:58308
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 8
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Em 11/1/19 1:52 PM, Matheus Castello escreveu:
> 
> 
> Em 11/1/19 12:27 PM, Krzysztof Kozlowski escreveu:
>> On Thu, Oct 31, 2019 at 03:41:33PM -0300, Matheus Castello wrote:
>>> For configuration of fuel gauge alert for a low level state of charge
>>> interrupt we add a function to config level threshold and a device tree
>>> binding property to set it in flatned device tree node.
>>>
>>> Now we can use "maxim,alert-low-soc-level" property with the values from
>>> 1% up to 32% to configure alert interrupt threshold.
>>>
>>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>>> ---
>>>   drivers/power/supply/max17040_battery.c | 88 +++++++++++++++++++++----
>>>   1 file changed, 74 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/max17040_battery.c 
>>> b/drivers/power/supply/max17040_battery.c
>>> index 75459f76d02c..802575342c72 100644
>>> --- a/drivers/power/supply/max17040_battery.c
>>> +++ b/drivers/power/supply/max17040_battery.c
>>> @@ -29,6 +29,9 @@
>>>   #define MAX17040_DELAY        1000
>>>   #define MAX17040_BATTERY_FULL    95
>>>
>>> +#define MAX17040_ATHD_MASK        0xFFC0
>>> +#define MAX17040_ATHD_DEFAULT_POWER_UP    4
>>> +
>>>   struct max17040_chip {
>>>       struct i2c_client        *client;
>>>       struct delayed_work        work;
>>> @@ -43,6 +46,8 @@ struct max17040_chip {
>>>       int soc;
>>>       /* State Of Charge */
>>>       int status;
>>> +    /* Low alert threshold from 32% to 1% of the State of Charge */
>>> +    u32 low_soc_alert_threshold;
>>>   };
>>>
>>>   static int max17040_get_property(struct power_supply *psy,
>>> @@ -99,6 +104,22 @@ static void max17040_reset(struct i2c_client 
>>> *client)
>>>       max17040_write_reg(client, MAX17040_CMD, 0x0054);
>>>   }
>>>
>>> +static int max17040_set_low_soc_threshold_alert(struct i2c_client 
>>> *client,
>>> +    u32 level)
>>> +{
>>> +    int ret;
>>> +    u16 data;
>>> +
>>> +    level = 32 - level;
>>> +    data = max17040_read_reg(client, MAX17040_RCOMP);
>>> +    /* clear the alrt bit and set LSb 5 bits */
>>> +    data &= MAX17040_ATHD_MASK;
>>> +    data |= level;
>>> +    ret = max17040_write_reg(client, MAX17040_RCOMP, data);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static void max17040_get_vcell(struct i2c_client *client)
>>>   {
>>>       struct max17040_chip *chip = i2c_get_clientdata(client);
>>> @@ -115,7 +136,6 @@ static void max17040_get_soc(struct i2c_client 
>>> *client)
>>>       u16 soc;
>>>
>>>       soc = max17040_read_reg(client, MAX17040_SOC);
>>> -
>>>       chip->soc = (soc >> 8);
>>>   }
>>>
>>> @@ -161,6 +181,24 @@ static void max17040_get_status(struct 
>>> i2c_client *client)
>>>           chip->status = POWER_SUPPLY_STATUS_FULL;
>>>   }
>>>
>>> +static int max17040_get_of_data(struct max17040_chip *chip)
>>> +{
>>> +    struct device *dev = &chip->client->dev;
>>> +    struct device_node *np = dev->of_node;
>>> +    int ret = 0;
>>> +
>>> +    if (of_property_read_u32(np, "maxim,alert-low-soc-level",
>>> +            &chip->low_soc_alert_threshold)) {
>>
>> Please align the line break with line above. checkpatch --strict might
>> give you hints about this.
>> >> +        chip->low_soc_alert_threshold = 
>> MAX17040_ATHD_DEFAULT_POWER_UP;
>>> +    /* check if low_soc_alert_threshold is between 1% and 32% */
>>
>> The comment looks misleading here, like it belongs to previous block.
>> Maybe put it inside else if {} block?
>>
>>> +    } else if (chip->low_soc_alert_threshold <= 0 ||
>>> +            chip->low_soc_alert_threshold >= 33){
>>
>> Missing space before {.
>>
>>> +        ret = -EINVAL;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static void max17040_check_changes(struct i2c_client *client)
>>>   {
>>>       max17040_get_vcell(client);
>>> @@ -192,6 +230,10 @@ static irqreturn_t max17040_thread_handler(int 
>>> id, void *dev)
>>>       /* send uevent */
>>>       power_supply_changed(chip->battery);
>>>
>>> +    /* reset alert bit */
>>> +    max17040_set_low_soc_threshold_alert(client,
>>> +        chip->low_soc_alert_threshold);
>>
>> Unless the continuation exceeds 80 character limit, please align it with
>> previous line.
>>
>>> +
>>>       return IRQ_HANDLED;
>>>   }
>>>
>>> @@ -216,6 +258,7 @@ static int max17040_probe(struct i2c_client *client,
>>>       struct i2c_adapter *adapter = client->adapter;
>>>       struct power_supply_config psy_cfg = {};
>>>       struct max17040_chip *chip;
>>> +    int ret;
>>>
>>>       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>>>           return -EIO;
>>> @@ -226,6 +269,12 @@ static int max17040_probe(struct i2c_client 
>>> *client,
>>>
>>>       chip->client = client;
>>>       chip->pdata = client->dev.platform_data;
>>> +    ret = max17040_get_of_data(chip);
>>> +    if (ret) {
>>> +        dev_err(&client->dev,
>>> +            "failed: low SOC alert OF data out of bounds\n");
>>> +        return ret;
>>> +    }
>>>
>>>       i2c_set_clientdata(client, chip);
>>>       psy_cfg.drv_data = chip;
>>> @@ -242,20 +291,31 @@ static int max17040_probe(struct i2c_client 
>>> *client,
>>>
>>>       /* check interrupt */
>>>       if (client->irq) {
>>> -        int ret;
>>> -        unsigned int flags;
>>> -
>>> -        dev_info(&client->dev, "IRQ: enabled\n");
>>> -        flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
>>> -        ret = devm_request_threaded_irq(&client->dev, client->irq, 
>>> NULL,
>>> -                        max17040_thread_handler, flags,
>>> -                        chip->battery->desc->name,
>>> -                        chip);
>>> -
>>> -        if (ret) {
>>> -            client->irq = 0;
>>> +        if (of_device_is_compatible(client->dev.of_node,
>>> +            "maxim,max77836-battery")) {
>>
>> Alignment.
>>
>>> +            ret = max17040_set_low_soc_threshold_alert(client,
>>> +                chip->low_soc_alert_threshold);
>>
>> Ditto.
>>

I am working to fix the alignments issues using the checkpath strict and 
I have a doubt. Here for example if I fix the check "Alignment should 
match open parenthesis" it will pass the 80 characters limit and will 
show me a warning.

>>> +            if (ret) {
>>> +                dev_err(&client->dev,
>>> +                    "Failed to set low SOC alert: err %d\n",
>>> +                    ret);
>>> +                return ret;
>>> +            }
>>> +
>>> +            dev_info(&client->dev, "IRQ: enabled\n");
>>> +            ret = devm_request_threaded_irq(&client->dev,
>>> +                client->irq, NULL, max17040_thread_handler,
>>> +                (client->flags | IRQF_ONESHOT),
>>
>> This looks unrelated. Befor ethis were IRQF_TRIGGER_FALLING |
>> IRQF_ONESHOT, now you use client->flags. There is no reason why this
>> commit should change >
> 
> I am using client->flags here to not overwrite the flag passed in device 
> tree. Let me know what you think about it: if I should leave it as in 
> the previous commit, or should I modify the previous commit too.
> 
>>> +                chip->battery->desc->name, chip);
>>
>> This breaks alignment which was here before.
>>

The same here.
How to proceed in this case?

Best Regards,
Matheus Castello

>> Best regards,
>> Krzysztof
>>
>>
> 
> Thanks for the review i will work on it.
> 
>>> +
>>> +            if (ret) {
>>> +                client->irq = 0;
>>> +                dev_warn(&client->dev,
>>> +                    "Failed to get IRQ err %d\n", ret);
>>> +            }
>>> +        } else {
>>>               dev_warn(&client->dev,
>>> -                "Failed to get IRQ err %d\n", ret);
>>> +                "Device not compatible for IRQ");
>>>           }
>>>       }
>>>
>>> -- 
>>> 2.24.0.rc2
>>>

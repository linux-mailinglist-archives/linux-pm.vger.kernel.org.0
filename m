Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBBEDD5D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 12:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfKDLFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 4 Nov 2019 06:05:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45085 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfKDLFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 06:05:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id b5so1938024eds.12;
        Mon, 04 Nov 2019 03:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=82Y+8lvkmODTXZfIxvOLUD6KLkdYBYM4N45xnXT7cGM=;
        b=cnfZOjLhGxkogFnx6z24sA/R4WPzBkpW7+jaIJDyPmjuGuews94elHo6+LYw4JFPIZ
         7VWGDHcsaDOSzbC6XQujcpv1v6s4/3v7Sr+VLuzu+3rSFEjX54vDonVo74ZLUgd3HhiH
         uVWgEg298mSfq8f1WKfPAp/ELtRipQak7ZDzTLn8dNK7tXk7vCOOvZsEp0Xu+IffSDuk
         Abu0b2m30sUJ0RSRsfZgW5sX/PXhjaWzKHjMDl3kL0BXIPmUmTebNncYSmDuV2XeA4EP
         AGId447DL3McLGnnjEDKIj4yox92g4SqqHE+hvVTk58W2+W6t7qC7Oh7UtzwzQGqyOdC
         HbJg==
X-Gm-Message-State: APjAAAWanRhGS68tsT8wETx0orLtkGeQR3jgAKc/giihz64zfr9EQRVz
        oAGj6zBX3Z9RUdqorzWflDo=
X-Google-Smtp-Source: APXvYqzRu3QjLIaQW+1GGHUm1InQweyS031HWvyusQQe0eog2OzqeXH/r8xEukjNzVGEbdWu6V6T9Q==
X-Received: by 2002:aa7:d40b:: with SMTP id z11mr594423edq.142.1572865499955;
        Mon, 04 Nov 2019 03:04:59 -0800 (PST)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id a102sm869102edf.46.2019.11.04.03.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 03:04:59 -0800 (PST)
Date:   Mon, 4 Nov 2019 12:04:57 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Message-ID: <20191104110457.GB30857@pi3>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-4-matheus@castello.eng.br>
 <20191101152755.GC28931@pi3>
 <c18ab487-6242-4ac2-b2c2-ef78c899521a@castello.eng.br>
 <4acd4bcf-4488-01f2-cacc-0170c33e20c2@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4acd4bcf-4488-01f2-cacc-0170c33e20c2@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 02, 2019 at 03:12:44PM -0300, Matheus Castello wrote:
> 
> 
> Em 11/1/19 1:52 PM, Matheus Castello escreveu:
> > 
> > 
> > Em 11/1/19 12:27 PM, Krzysztof Kozlowski escreveu:
> > > On Thu, Oct 31, 2019 at 03:41:33PM -0300, Matheus Castello wrote:
> > > > For configuration of fuel gauge alert for a low level state of charge
> > > > interrupt we add a function to config level threshold and a device tree
> > > > binding property to set it in flatned device tree node.
> > > > 
> > > > Now we can use "maxim,alert-low-soc-level" property with the values from
> > > > 1% up to 32% to configure alert interrupt threshold.
> > > > 
> > > > Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> > > > ---
> > > >   drivers/power/supply/max17040_battery.c | 88 +++++++++++++++++++++----
> > > >   1 file changed, 74 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/power/supply/max17040_battery.c
> > > > b/drivers/power/supply/max17040_battery.c
> > > > index 75459f76d02c..802575342c72 100644
> > > > --- a/drivers/power/supply/max17040_battery.c
> > > > +++ b/drivers/power/supply/max17040_battery.c
> > > > @@ -29,6 +29,9 @@
> > > >   #define MAX17040_DELAY        1000
> > > >   #define MAX17040_BATTERY_FULL    95
> > > > 
> > > > +#define MAX17040_ATHD_MASK        0xFFC0
> > > > +#define MAX17040_ATHD_DEFAULT_POWER_UP    4
> > > > +
> > > >   struct max17040_chip {
> > > >       struct i2c_client        *client;
> > > >       struct delayed_work        work;
> > > > @@ -43,6 +46,8 @@ struct max17040_chip {
> > > >       int soc;
> > > >       /* State Of Charge */
> > > >       int status;
> > > > +    /* Low alert threshold from 32% to 1% of the State of Charge */
> > > > +    u32 low_soc_alert_threshold;
> > > >   };
> > > > 
> > > >   static int max17040_get_property(struct power_supply *psy,
> > > > @@ -99,6 +104,22 @@ static void max17040_reset(struct i2c_client
> > > > *client)
> > > >       max17040_write_reg(client, MAX17040_CMD, 0x0054);
> > > >   }
> > > > 
> > > > +static int max17040_set_low_soc_threshold_alert(struct
> > > > i2c_client *client,
> > > > +    u32 level)
> > > > +{
> > > > +    int ret;
> > > > +    u16 data;
> > > > +
> > > > +    level = 32 - level;
> > > > +    data = max17040_read_reg(client, MAX17040_RCOMP);
> > > > +    /* clear the alrt bit and set LSb 5 bits */
> > > > +    data &= MAX17040_ATHD_MASK;
> > > > +    data |= level;
> > > > +    ret = max17040_write_reg(client, MAX17040_RCOMP, data);
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > >   static void max17040_get_vcell(struct i2c_client *client)
> > > >   {
> > > >       struct max17040_chip *chip = i2c_get_clientdata(client);
> > > > @@ -115,7 +136,6 @@ static void max17040_get_soc(struct
> > > > i2c_client *client)
> > > >       u16 soc;
> > > > 
> > > >       soc = max17040_read_reg(client, MAX17040_SOC);
> > > > -
> > > >       chip->soc = (soc >> 8);
> > > >   }
> > > > 
> > > > @@ -161,6 +181,24 @@ static void max17040_get_status(struct
> > > > i2c_client *client)
> > > >           chip->status = POWER_SUPPLY_STATUS_FULL;
> > > >   }
> > > > 
> > > > +static int max17040_get_of_data(struct max17040_chip *chip)
> > > > +{
> > > > +    struct device *dev = &chip->client->dev;
> > > > +    struct device_node *np = dev->of_node;
> > > > +    int ret = 0;
> > > > +
> > > > +    if (of_property_read_u32(np, "maxim,alert-low-soc-level",
> > > > +            &chip->low_soc_alert_threshold)) {
> > > 
> > > Please align the line break with line above. checkpatch --strict might
> > > give you hints about this.
> > > >> +        chip->low_soc_alert_threshold =
> > > MAX17040_ATHD_DEFAULT_POWER_UP;
> > > > +    /* check if low_soc_alert_threshold is between 1% and 32% */
> > > 
> > > The comment looks misleading here, like it belongs to previous block.
> > > Maybe put it inside else if {} block?
> > > 
> > > > +    } else if (chip->low_soc_alert_threshold <= 0 ||
> > > > +            chip->low_soc_alert_threshold >= 33){
> > > 
> > > Missing space before {.
> > > 
> > > > +        ret = -EINVAL;
> > > > +    }
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > >   static void max17040_check_changes(struct i2c_client *client)
> > > >   {
> > > >       max17040_get_vcell(client);
> > > > @@ -192,6 +230,10 @@ static irqreturn_t
> > > > max17040_thread_handler(int id, void *dev)
> > > >       /* send uevent */
> > > >       power_supply_changed(chip->battery);
> > > > 
> > > > +    /* reset alert bit */
> > > > +    max17040_set_low_soc_threshold_alert(client,
> > > > +        chip->low_soc_alert_threshold);
> > > 
> > > Unless the continuation exceeds 80 character limit, please align it with
> > > previous line.
> > > 
> > > > +
> > > >       return IRQ_HANDLED;
> > > >   }
> > > > 
> > > > @@ -216,6 +258,7 @@ static int max17040_probe(struct i2c_client *client,
> > > >       struct i2c_adapter *adapter = client->adapter;
> > > >       struct power_supply_config psy_cfg = {};
> > > >       struct max17040_chip *chip;
> > > > +    int ret;
> > > > 
> > > >       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> > > >           return -EIO;
> > > > @@ -226,6 +269,12 @@ static int max17040_probe(struct i2c_client
> > > > *client,
> > > > 
> > > >       chip->client = client;
> > > >       chip->pdata = client->dev.platform_data;
> > > > +    ret = max17040_get_of_data(chip);
> > > > +    if (ret) {
> > > > +        dev_err(&client->dev,
> > > > +            "failed: low SOC alert OF data out of bounds\n");
> > > > +        return ret;
> > > > +    }
> > > > 
> > > >       i2c_set_clientdata(client, chip);
> > > >       psy_cfg.drv_data = chip;
> > > > @@ -242,20 +291,31 @@ static int max17040_probe(struct
> > > > i2c_client *client,
> > > > 
> > > >       /* check interrupt */
> > > >       if (client->irq) {
> > > > -        int ret;
> > > > -        unsigned int flags;
> > > > -
> > > > -        dev_info(&client->dev, "IRQ: enabled\n");
> > > > -        flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> > > > -        ret = devm_request_threaded_irq(&client->dev,
> > > > client->irq, NULL,
> > > > -                        max17040_thread_handler, flags,
> > > > -                        chip->battery->desc->name,
> > > > -                        chip);
> > > > -
> > > > -        if (ret) {
> > > > -            client->irq = 0;
> > > > +        if (of_device_is_compatible(client->dev.of_node,
> > > > +            "maxim,max77836-battery")) {
> > > 
> > > Alignment.
> > > 
> > > > +            ret = max17040_set_low_soc_threshold_alert(client,
> > > > +                chip->low_soc_alert_threshold);
> > > 
> > > Ditto.
> > > 
> 
> I am working to fix the alignments issues using the checkpath strict and I
> have a doubt. Here for example if I fix the check "Alignment should match
> open parenthesis" it will pass the 80 characters limit and will show me a
> warning.

Indeed which is a hint that the code readabiltiy is affected by long
function name + two indentations + long variable name. You can split it
to different function (covering the IRQ case) which will reduce one
indentation.

Alternatively do not align it but add few more tabs before chip->:
		ret = max17040_set_low_soc_threshold_alert(client,
						chip->low_soc_alert_threshold);
Renaming low_soc_alert_threshold to something shorter can help as well
(soc_alert seems enough descriptive).


Best regards,
Krzysztof


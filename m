Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E34AB132
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiBFS0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 13:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiBFS0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 13:26:04 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 10:26:02 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27510C06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644171961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhLw3hXmLLPUfYVSxNooij004YEdn4Gmv5Im5DrUYIs=;
        b=G/slwai9XxQ4qwnumFfqqfiQeVH9tCe+AGGhvhsRBu7f7nW18L/4EG+pdDEk6U/FQD26mU
        pKFpJZzdC/Lmo3PosP8tI31q/Ktn3AHzGoVzzFkpsj2w7UijgLratZSjqwD6VMlU45y7am
        jh1izcLgh3NUg1B8gAE6YO4o48M4cZ8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-UCaKvr5sNkm-BjA7hMTaww-1; Sun, 06 Feb 2022 13:19:05 -0500
X-MC-Unique: UCaKvr5sNkm-BjA7hMTaww-1
Received: by mail-ed1-f71.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso418729edf.7
        for <linux-pm@vger.kernel.org>; Sun, 06 Feb 2022 10:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=lhLw3hXmLLPUfYVSxNooij004YEdn4Gmv5Im5DrUYIs=;
        b=BucspSN+VZPWFxcmHGokYL/+emxFKNaBxylhmkgohD9F1G/UjXlJqY7B+Q6KbYGOtV
         qj1//r5Yn3SPLKMAadI2vPStNKfbwQY3twCoOC45/s7eEeZwrnJ5QnrzS6dFcmI2ExuP
         J44iPRC1lhHeV9bA7QvudYAkac3sV/3poYVfX6F0dgwSeC3e8xbRekQpQp6sfQcMFhBL
         MbApWxwCIFsbBLQXxfaBMa1nadruTjfVmtckzb7ka0y/h6C4I7lkZjOEhw3dzv5PnJcY
         P3jzXEbhCzSGkTPbzhOTtvQI2NPPbC7JcxgJTswS8sYfvUccgWm98MoEDCGniVPQVwJU
         ZuWw==
X-Gm-Message-State: AOAM530OULP0s71LsN0dm9Mk56yQ4RnNwlLHMBt+nBs/3TEhPJob69nv
        tYLiOE8u+ZLMqVAF0ZLJ0pvYg4Tc9FJ7RjdGQIIG7PUSBbYG3fpUGOAP5qGheqoJ3h6aEifQhID
        esTa0echA1lda0AYvtWA=
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr9850083ede.182.1644171544398;
        Sun, 06 Feb 2022 10:19:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFdGtstmkhqKhdF8gOjB+7sqibnMlVm8pjAeOcqwu0okDfC7HsxvZ6FPmJ8zqJNL0Ew+AdTQ==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr9850071ede.182.1644171544219;
        Sun, 06 Feb 2022 10:19:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id qb30sm2793439ejc.27.2022.02.06.10.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 10:19:03 -0800 (PST)
Message-ID: <f4cfc27e-7dbf-8dab-71fd-bad1172b31fd@redhat.com>
Date:   Sun, 6 Feb 2022 19:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 8/8] power: supply: ug3105_battery: Add driver for uPI
 uG3105 battery monitor
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
References: <20220131155730.309513-1-hdegoede@redhat.com>
 <20220131155730.309513-9-hdegoede@redhat.com>
 <20220201233335.henx5x53i4azbsdy@earth.universe>
Content-Language: en-US
In-Reply-To: <20220201233335.henx5x53i4azbsdy@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Thank you for the review and thank you for merging the axp288-fuel-gauge
and the bug bq25890 series.

On 2/2/22 00:33, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Jan 31, 2022 at 04:57:30PM +0100, Hans de Goede wrote:
>> Add a new battery driver for the uPI uG3105 battery monitor.
>>
>> Note the uG3105 is not a full-featured autonomous fuel-gauge. Instead it
>> is expected to be use in combination with some always on microcontroller
>> reading its coulomb-counter before it can wrap (must be read every 400
>> seconds!).
>>
>> Since Linux does not monitor coulomb-counter changes while the device is
>> off or suspended, the coulomb counter is not used atm.
>>
>> So far this driver is only used on x86/ACPI (non devicetree) devs
>> (also note there is no of_match table). Therefor there is no devicetree
>> bindings documentation for this driver's "upi,rsns-microohm" property
>> since this is not used in actual devicetree files and the dt bindings
>> maintainers have requested properties with no actual dt users to
>> _not_ be added to the dt bindings.
>>
>> The property's name has been chosen so that it should not need to be
>> changed if/when devicetree enumeration support gets added later, as it
>> mirrors "maxim,rsns-microohm" from the "maxim,max17042" bindings.
> 
> Except the vendor prefix being incorrect; please use this one:
> 
> $ grep -i upi Documentation/devicetree/bindings/vendor-prefixes.yaml
>   "^upisemi,.*":
>     description: uPI Semiconductor Corp.

Ah I didn't realize there already was a vendor prefix for uPI,
will fix for v2.

<snip>

> +static int ug3105_read_word(struct i2c_client *client, u8 reg)
>> +{
>> +	int val;
>> +
>> +	val = i2c_smbus_read_word_data(client, reg);
>> +	if (val < 0)
>> +		dev_err(&client->dev, "Error reading reg 0x%02x\n", reg);
>> +
>> +	return val;
>> +}
> 
> can we use regmap instead? :)

That would be tricky, since some registers are 8 bit, where as
others are 16 bit. Where as the i2c-regmap code assumes a fixed
register-size.

Also I don't really see much added value for this driver to use
the regmap abstraction, so I believe it would be better to
just keep this as is and I'm going to keep this as is for v2.

<snip>

>> +static int ug3105_probe(struct i2c_client *client)
>> +{
>> +	struct power_supply_config psy_cfg = {};
>> +	struct device *dev = &client->dev;
>> +	u32 curr_sense_res_uohm = 10000;
>> +	struct power_supply *psy;
>> +	struct ug3105_chip *chip;
>> +	int ret;
>> +
>> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->client = client;
>> +	mutex_init(&chip->lock);
>> +	ret = devm_delayed_work_autocancel(dev, &chip->work, ug3105_work);
>> +	if (ret)
>> +		return ret;
>> +
>> +	psy_cfg.drv_data = chip;
>> +	psy = devm_power_supply_register(dev, &ug3105_psy_desc, &psy_cfg);
>> +	if (IS_ERR(psy))
>> +		return PTR_ERR(psy);
>> +
>> +	ret = power_supply_get_battery_info(psy, &chip->info);
>> +	if (ret)
>> +		return ret;
> 
> this allocates data, so you need to call power_supply_put_battery_info()
> when chip->info is no loner required.

ug3105_work() and ug3105_get_property() both use the info, so it
is needed until the driver gets unbound; and since the memory allocated
by power_supply_get_battery_info() is allocated using devm_kmalloc
it will get freed on driver-unbind automatically.

So AFAICT there is no need to call power_supply_put_battery_info()
(which uses devm_kfree() internally to avoid the memory being free-ed
a second time on driver unbind).

Regards,

Hans


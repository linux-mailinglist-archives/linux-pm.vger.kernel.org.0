Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B25FAD9A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Oct 2022 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJKHi6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJKHi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 03:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE37D1F8
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665473935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+omRR0NMF7scNdbRm9dq1ut5HJA5A7ZYYiKI02v194=;
        b=Av260s8gaRyLgq9hX9HNYhJym7acf851RRkF14SHqtaJAplW8p7RHxK9GvNkd5rAdcxdhx
        k0joUDhVZxIo5EGyWa6VwfGvvzTKIki8rMPs4Q3xP5CI3X9qB0N0/8epxhP/Gr00IVnlS4
        A4XQ7GCSOJe6pWoTX6az/xbjX2ESnaE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-raZVJyv9Obydk1Zs7yWQUw-1; Tue, 11 Oct 2022 03:38:54 -0400
X-MC-Unique: raZVJyv9Obydk1Zs7yWQUw-1
Received: by mail-ej1-f69.google.com with SMTP id gn33-20020a1709070d2100b00787e6fbcb72so5447891ejc.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 00:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+omRR0NMF7scNdbRm9dq1ut5HJA5A7ZYYiKI02v194=;
        b=nN6+aH91EBEzOcK1wWXV9TsSSIHsZZNXDpJUIlOdJAB/MczBNITuOCJ7iQ3Y21Ki8p
         i2cOYiTQRWopO6LM7hsHhLNIdj9Lf35oif0HX7J1Sff1vOrOppA07GxqZ3sduwAXOKFM
         cm1BSMlt6BLek2ngE0w69HIyB7Pgx+uQ7F+1qz2P9/HVgqX7S0frXkdMPeS5iT3ZL+v+
         i3/1t/+MyoEa4foHb1EtYKNZV+1h/+pS2mRJlt1VWhIe8fTbukofqpzgf4yMb2wBMHyd
         u86TadCLBaU9W8YV6+CBE90hVtxTsPqwSL+lrH4sDJ8jXSvk9OZVRInlXa4rS5H0OcoJ
         Rutg==
X-Gm-Message-State: ACrzQf3vhrgrn3Qtrc7OWpIX5QQdywZzVyn0RozwkE5sptO4oA2mfTq+
        18OTLQtL8uwjpEbN3w7cv7yHnc+uuIVS3Ds1oELlou8hNbWXe2IcJ1w8d73/8r6Z6gAWFrRUdFi
        ITmQsxSeSOMBRYVn8dsg=
X-Received: by 2002:a17:907:a0c6:b0:787:8250:f90e with SMTP id hw6-20020a170907a0c600b007878250f90emr18315463ejc.8.1665473932962;
        Tue, 11 Oct 2022 00:38:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ckMK39+of2f9ITqihz+kTlT9fCbYZI0dJaoK2ga1C4haAYRZuXum0oV7uFLPdqSfeESE7BA==
X-Received: by 2002:a17:907:a0c6:b0:787:8250:f90e with SMTP id hw6-20020a170907a0c600b007878250f90emr18315453ejc.8.1665473932751;
        Tue, 11 Oct 2022 00:38:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b0073d7b876621sm6462986ejc.205.2022.10.11.00.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:38:52 -0700 (PDT)
Message-ID: <e26abfe6-850a-32e5-fa2e-5dd633c72a62@redhat.com>
Date:   Tue, 11 Oct 2022 09:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] power: supply: bq25890: Add CC voltage to ADC
 properties
To:     Marek Vasut <marex@denx.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <Y0NUbeUae01t+UGa@qmqm.qmqm.pl>
 <dde63fea-04eb-c438-27d3-fe6ff5c174bc@redhat.com>
 <c528ae92-26bd-e6a9-a406-93a077d2fab7@denx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c528ae92-26bd-e6a9-a406-93a077d2fab7@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/10/22 21:22, Marek Vasut wrote:
> On 10/10/22 15:50, Hans de Goede wrote:
>> Hi,
> 
> Hi,
> 
> [...]
> 
>>> Though I think there is no proper property
>>> for the VSYS value that is currently occupying VOLTAGE_NOW - this
>>> might be better modelled as a separate regulator maybe?
>>
>> Ack, see above.
> 
> We already do have a regulator in the bq25890 driver. The regulator is used as a switch to toggle OTG boost mode (supply from battery to VBUS), but I don't see any users of this functionality, and I cannot imagine how this would be modeled in DT. (Hans, can you clarify?)

Ah, with the Ack I meant ack for the "I think there is no proper property for the VSYS value" I did not meant to ack the regulator bit, I don't directly see how having registering a regulator device for Vsys would be useful, sorry. As mentioned in my original email I believe that just adding a new property for Vsys makes the most sense.

Note the OTG regulator is useful to enable/disable 5V boost output when used with e.g. a micro-usb connector and that micro-usb connector is used with an micro-USB OTG host-mode cable / dongle.

> There is the usb_work (usb_register_notifier()) which triggers workqueue which does the same, toggles OTG boost mode, but this is only used in case a valid USB PHY is found. I didn't find any users of this either.

This is used, but the use is hidden away pretty well I admit. Some X86 tablets from the Cherry Trail era have ACPI tables where the charging / fuel-gauge ICs are not handled in ACPI (as they typically are on x86) so we need to do it ourselves.

Specifically the charger IC is connected to a special I2c bus of the PMIC (which itself is an i2c-device so we have an i2c-attached i2c-controller, crazy ...) the driver for this special PMIC embedded i2c-controller is also responsible for instantiating the charger chip i2c-client and this setup uses the OTG regulator device, see: drivers/i2c/busses/i2c-cht-wc.c specifically these bits:

/********** Xiaomi Mi Pad 2 charger IC settings  **********/
static struct regulator_consumer_supply bq2589x_vbus_consumer = {
        .supply = "vbus",
        .dev_name = "cht_wcove_pwrsrc",
};

static const struct regulator_init_data bq2589x_vbus_init_data = {
        .constraints = {
                .valid_ops_mask = REGULATOR_CHANGE_STATUS,
        },
        .consumer_supplies = &bq2589x_vbus_consumer,
        .num_consumer_supplies = 1,
};

static struct bq25890_platform_data bq2589x_pdata = {
        .regulator_init_data = &bq2589x_vbus_init_data,
};

static const struct property_entry xiaomi_mipad2_props[] = {
        PROPERTY_ENTRY_BOOL("linux,skip-reset"),
        PROPERTY_ENTRY_BOOL("linux,read-back-settings"),
        { }
};

static const struct software_node xiaomi_mipad2_node = {
        .properties = xiaomi_mipad2_props,
};

static struct i2c_board_info xiaomi_mipad2_board_info = {
        .type = "bq25890",
        .addr = 0x6a,
        .dev_name = "bq25890",
        .swnode = &xiaomi_mipad2_node,
        .platform_data = &bq2589x_pdata,
};

And then the drivers/extcon/extcon-intel-cht-wc.c uses
the vbus regulator to control the 5V out on the micro-USB.

(also note these devices do not instantiate a usb_phy device anywhere, which is why the V5 boost is handled through the regulator framework)

TL;DR: the regulator device for the V5 boost output is used, please don't remove it :)

> Anyway, maybe we can extend the regulator to report VBus and register another one to report VSys, where the VSys one can be plugged e.g. as supply for PMIC in DT ?

I'm not sure if a regulator device for Vsys is really useful, AFAIK Vsys can not be turned off, nor can the voltage level be controlled... 

Regards,

Hans




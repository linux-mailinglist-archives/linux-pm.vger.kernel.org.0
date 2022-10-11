Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F225FAE4C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Oct 2022 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJKIUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJKIU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 04:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F5180E85
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665476422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Js+0scLwQjZnvwBYjPrMKUX50BHu/BIRFqOy/ABYqWg=;
        b=D8mIfWXefGqI9exLwN2XUCVfGYLthCDCmiBd862I7Q8r7fhQrkKtvB3FwA/TUmFE91lJUW
        6brRtMIYBB79TWHato/2EHN2AWc/IokziM4z7SPkMipw2NCXtf/8re9VVRsEbx3bn3xd77
        6wI+RHIzx8pP0ykKPIFYfPPm6+CY75s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-H_SX-K6XNo6_eLrQXNnGcQ-1; Tue, 11 Oct 2022 04:20:21 -0400
X-MC-Unique: H_SX-K6XNo6_eLrQXNnGcQ-1
Received: by mail-ed1-f70.google.com with SMTP id z16-20020a05640235d000b0045c0360bfcfso4230754edc.14
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 01:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js+0scLwQjZnvwBYjPrMKUX50BHu/BIRFqOy/ABYqWg=;
        b=6nFa0SpycXFmBDXwnnOIaBG+CxspbleIlcNIYSk1WUlaoCorGDWulkBSVlZDtjFIC2
         O3F6KTat0+4L8G/OgkmGH32Sm5IzQC3DYVkcsNUSWWOxjONXl5ZoPGWb4NX/z6iZyPIa
         NAJIlTwuw7a9yXVzotWnCA9t8XbIgNoJZ65QHTj1lKMwibmNt82fQmRY/OK5yVNh0WIs
         9W/2wMgLzIpysWcckKvry4hZjou5KaOO5aLH5T/supobHO5VC9GX5kY9B+krQBg3VjP1
         kOfIUdhK+m8wdvfxJLG2qCz1teQGSKIIIkg2QnD2z5SUC/J+1OrUkq2CjvlTtDw79y3t
         4NXg==
X-Gm-Message-State: ACrzQf1b/Uke/ZrojeaHOxsJOwArenuyqIUXgnINWAksH7ZRTs1ihyzm
        DMlG5+Qv9C+65NXw3tdwavsFso+qMa9m444Oi3kUOuIcfkrczlc5vxPUk02QZgef2xuNu7F8HnS
        SzzNj7IZI4mK9si1UeN0=
X-Received: by 2002:a17:907:da7:b0:789:efd0:3995 with SMTP id go39-20020a1709070da700b00789efd03995mr18001819ejc.759.1665476420590;
        Tue, 11 Oct 2022 01:20:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Mbr66TnlcZcVeSkWSiTfCXeWeke4DSc7tXMwW/vyDC9C6XW9cU+yRFS9RVQJUKvdF4p7dIw==
X-Received: by 2002:a17:907:da7:b0:789:efd0:3995 with SMTP id go39-20020a1709070da700b00789efd03995mr18001807ejc.759.1665476420378;
        Tue, 11 Oct 2022 01:20:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d9-20020a50cd49000000b0043bbb3535d6sm8683521edj.66.2022.10.11.01.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:20:19 -0700 (PDT)
Message-ID: <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
Date:   Tue, 11 Oct 2022 10:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-5-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/10/22 23:03, Marek Vasut wrote:
> Pull the regulator registration code into separate function, so it can
> be extended to register more regulators later. Currently this is only
> moving ifdeffery into one place and other preparatory changes. The
> dev_err_probe() output string is changed to explicitly list vbus
> regulator failure, so that once more regulators are registered, it
> would be clear which one failed.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

First of all thank you for your work on this series. Based purely
on reading the commit messages patches 1-4 sound good to me. I will
do a more detailed review tomorrow.

As for patch 5-7 thinking some more about adding a Vsys regulator
just to report the Vsys reading feels wrong to me.

A regulator device's voltage in sysfs is about the value the regulator
is supposed to try and regulate its outputted voltage to, while here
we are talking about an ADC reading of the actual outputted voltage.

This really should *not* be modeled as a regulator if anything the
hwmon interface would be applicable for this ADC reading and
the power_supply core has support for exporting some of
the psy info through hwmon now.

So what should happen for Vsys IMHO is make it a new
POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while adding support
for this new property to the power-supply core, also make the core's
hwmon glue code export this in the registered hwmon device so that
e.g. a sensors applet on the desktop can easily show it (*).

Sorry for the confusion with my ack in the other thread which
only meant to agree with a part of the alinea/sentence I put
the ack under.

Regards,

Hans


*) As part of this the hwmon glue should probably also add
labels (resulting in in#_label sysfs files) to the psy
properties mirrored there so that it is clear which in#_input
value in sysfs represents what. You can simply check this
works as it should by running the "sensors" utility
which will print the labels if labels have been provided.



> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq25890_charger.c | 51 ++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 6cc3c23cd8853..7ab27a9dce14a 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1114,6 +1114,36 @@ static const struct regulator_desc bq25890_vbus_desc = {
>  	.fixed_uV = 5000000,
>  	.n_voltages = 1,
>  };
> +
> +static int bq25890_register_regulator(struct bq25890_device *bq)
> +{
> +	struct bq25890_platform_data *pdata = dev_get_platdata(bq->dev);
> +	struct regulator_config cfg = {
> +		.dev = bq->dev,
> +		.driver_data = bq,
> +	};
> +	struct regulator_dev *reg;
> +
> +	if (!IS_ERR_OR_NULL(bq->usb_phy))
> +		return 0;
> +
> +	if (pdata)
> +		cfg.init_data = pdata->regulator_init_data;
> +
> +	reg = devm_regulator_register(bq->dev, &bq25890_vbus_desc, &cfg);
> +	if (IS_ERR(reg)) {
> +		return dev_err_probe(bq->dev, PTR_ERR(reg),
> +				     "registering vbus regulator");
> +	}
> +
> +	return 0;
> +}
> +#else
> +static inline int
> +bq25890_register_regulator(struct bq25890_device *bq)
> +{
> +	return 0
> +}
>  #endif
>  
>  static int bq25890_get_chip_version(struct bq25890_device *bq)
> @@ -1309,27 +1339,16 @@ static int bq25890_probe(struct i2c_client *client,
>  
>  	/* OTG reporting */
>  	bq->usb_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +
> +	ret = bq25890_register_regulator(bq);
> +	if (ret)
> +		return ret;
> +
>  	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
>  		INIT_WORK(&bq->usb_work, bq25890_usb_work);
>  		bq->usb_nb.notifier_call = bq25890_usb_notifier;
>  		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
>  	}
> -#ifdef CONFIG_REGULATOR
> -	else {
> -		struct bq25890_platform_data *pdata = dev_get_platdata(dev);
> -		struct regulator_config cfg = { };
> -		struct regulator_dev *reg;
> -
> -		cfg.dev = dev;
> -		cfg.driver_data = bq;
> -		if (pdata)
> -			cfg.init_data = pdata->regulator_init_data;
> -
> -		reg = devm_regulator_register(dev, &bq25890_vbus_desc, &cfg);
> -		if (IS_ERR(reg))
> -			return dev_err_probe(dev, PTR_ERR(reg), "registering regulator");
> -	}
> -#endif
>  
>  	ret = bq25890_power_supply_init(bq);
>  	if (ret < 0) {


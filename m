Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489B95FD716
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJMJ3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJMJ3Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 05:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25FB9AC28
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665653354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNMYTdMF1q3OdsUSL5d32UfZepsjWOx8gJwd0yDZzEE=;
        b=AjTaZKkTeV18lebPARDZlyShExx6D8N0wRzXjfzL5k/344Eh3FfjYazBuLv+woSm1lNOIf
        eEFMv6iUI64/5FXIXw37mXXIWP3So/1ZM5qMdWcSFiyqLjOXBR1pKc4CICg6yHZfYTOgGF
        UY0ELfrhWgNrR+ySA9gd2sn6S/XD8FU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-oSAdi_a_Ny6PJoO313RjEw-1; Thu, 13 Oct 2022 05:29:12 -0400
X-MC-Unique: oSAdi_a_Ny6PJoO313RjEw-1
Received: by mail-ed1-f72.google.com with SMTP id m10-20020a056402430a00b0045968bb0874so1086463edc.10
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNMYTdMF1q3OdsUSL5d32UfZepsjWOx8gJwd0yDZzEE=;
        b=PzEJHSX41om275ESjlLrN20WbJTclFVu00t8oTVUkBnTj6cGkTghMvCqHg1xX2NSvB
         MVmcAdsBj8YWuNm1pR63Cz0rixTm9NwVeI7QYHqkEK80Ns4UYG3TU/AH50D26fwsRiU5
         sBjIEY/plbQzkl/SI60VRrDkDwNcRPh03wGLP6j+mnMLIuJcVh4CCcKZXe26tGf974Cd
         ZmTBu8qFvKONW9aUpaj8JXAlQm+85BWHF5oAFNrNZdVfVViwrG8BRKewbSXOQauPVeiX
         W1HHJcZYQ6QWzZf+6YylLKDyp70OhJ1DjphcJhUZI/FrIlITSSUHhbaaL2kAAH2cImiv
         DJ5g==
X-Gm-Message-State: ACrzQf3jdX6NF80pLngUdg5dhasrn0TAG4JRuNgysB1CVZdTDiWOGhoF
        PXkQxPlr3ckdfMH9LgDplZcaIoyVMayee8g4vd8lNXwtmPGV6ezTk1CAu05sqVbgQgZQfWFXTCn
        5UZStio527TH5n5tyjuo=
X-Received: by 2002:a05:6402:190f:b0:45b:d959:e2ae with SMTP id e15-20020a056402190f00b0045bd959e2aemr23366386edz.187.1665653351740;
        Thu, 13 Oct 2022 02:29:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4U+vfTUWXOgmUcIW+y8s7QYPL9foAPFw+MBWkFB/tM6mzM8zNexZStc0v2DymFIOux+yWhGg==
X-Received: by 2002:a05:6402:190f:b0:45b:d959:e2ae with SMTP id e15-20020a056402190f00b0045bd959e2aemr23366375edz.187.1665653351579;
        Thu, 13 Oct 2022 02:29:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7da55000000b0044e01e2533asm12886227eds.43.2022.10.13.02.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 02:29:11 -0700 (PDT)
Message-ID: <87062f5c-4534-c738-7a4b-1b2801c78a7d@redhat.com>
Date:   Thu, 13 Oct 2022 11:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 6/7] power: supply: bq25890: Add get_voltage support to
 Vbus regulator
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-6-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-6-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> The chip is capable of reporting Vbus voltage, add .get_voltage
> implementation to Vbus regulator to report current Vbus voltage.
> This requires for the Vbus regulator to be registered always
> instead of the current state where the regulator is registered
> only in case USB PHY is not found.
> 
> Do not provide Vbus regulator enable/disable ops in case USB PHY
> is present, as they would race with USB PHY notifier which is also
> used to toggle OTG boost mode.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq25890_charger.c | 33 ++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 7ab27a9dce14a..2be5861cfcb66 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1099,38 +1099,57 @@ static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
>  	return bq25890_field_read(bq, F_OTG_CFG);
>  }
>  
> +static int bq25890_vbus_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct bq25890_device *bq = rdev_get_drvdata(rdev);
> +
> +	return bq25890_get_vbus_voltage(bq);
> +}
> +
>  static const struct regulator_ops bq25890_vbus_ops = {
> +	.get_voltage = bq25890_vbus_get_voltage,
> +};
> +
> +static const struct regulator_desc bq25890_vbus_desc = {
> +	.name = "usb_otg_vbus",
> +	.of_match = "usb-otg-vbus",
> +	.type = REGULATOR_VOLTAGE,
> +	.owner = THIS_MODULE,
> +	.ops = &bq25890_vbus_ops,
> +};
> +
> +static const struct regulator_ops bq25890_vbus_boost_ops = {
>  	.enable = bq25890_vbus_enable,
>  	.disable = bq25890_vbus_disable,
>  	.is_enabled = bq25890_vbus_is_enabled,
> +	.get_voltage = bq25890_vbus_get_voltage,
>  };
>  
> -static const struct regulator_desc bq25890_vbus_desc = {
> +static const struct regulator_desc bq25890_vbus_boost_desc = {
>  	.name = "usb_otg_vbus",
>  	.of_match = "usb-otg-vbus",
>  	.type = REGULATOR_VOLTAGE,
>  	.owner = THIS_MODULE,
> -	.ops = &bq25890_vbus_ops,
> -	.fixed_uV = 5000000,
> -	.n_voltages = 1,
> +	.ops = &bq25890_vbus_boost_ops,
>  };
>  
>  static int bq25890_register_regulator(struct bq25890_device *bq)
>  {
>  	struct bq25890_platform_data *pdata = dev_get_platdata(bq->dev);
> +	const struct regulator_desc *desc;
>  	struct regulator_config cfg = {
>  		.dev = bq->dev,
>  		.driver_data = bq,
>  	};
>  	struct regulator_dev *reg;
>  
> -	if (!IS_ERR_OR_NULL(bq->usb_phy))
> -		return 0;
> +	desc = IS_ERR_OR_NULL(bq->usb_phy) ?
> +	       &bq25890_vbus_boost_desc : &bq25890_vbus_desc;

I'm not sure this trickery with 2 separate sets of ops +
2 descs pointing to the different ops is necessary.

The core will only allow calling the enable/disable callbacks
if the regulator constraints (from either platform_data or
from dt) contain something like this (platform_data example):

static const struct regulator_init_data bq2589x_vbus_init_data = {
        .constraints = {
                .valid_ops_mask = REGULATOR_CHANGE_STATUS,
        },
        .consumer_supplies = &bq2589x_vbus_consumer,
        .num_consumer_supplies = 1,
};

AFAIK if the Vboost regulator is not referenced in dt because
it is controller through the usb-phy framework then valid_ops_mask
will be empty, so the 2 sets of ops + 2 descs are not necessary
I believe.

So I believe this can be simplified to just adding
bq25890_vbus_get_voltage to the ops, dropping .fixed_uV and
.n_voltages from the desc, and just completely dropping
the IS_ERR_OR_NULL(bq->usb_phy) check.

Regards,

Hans



>  
>  	if (pdata)
>  		cfg.init_data = pdata->regulator_init_data;
>  
> -	reg = devm_regulator_register(bq->dev, &bq25890_vbus_desc, &cfg);
> +	reg = devm_regulator_register(bq->dev, desc, &cfg);
>  	if (IS_ERR(reg)) {
>  		return dev_err_probe(bq->dev, PTR_ERR(reg),
>  				     "registering vbus regulator");


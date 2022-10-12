Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336E55FCBC1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJLT7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLT7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 15:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C0BEFB2
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665604757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtZt7XzUnjd5O43AVTmt8PsHJ3rbuWGLVHMz7rRTYx4=;
        b=RxgqZfsUNk3o6slgzs6VT5qkYANjdMWvcFmhj4jWTTFOgL4CSwcjWKy0YNFg3dzrD2qNpk
        TOq/QJxeIdZSgwgJSxVYPxUDwZH4bDvxq/1icADgtCiLJPPPJQD+8b+oeQDP6uxoZy/UVx
        llxO5edwojRhum0uFEPBFHftGQVHlw8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-gS7C-DviNpCNHnH3XuMt3A-1; Wed, 12 Oct 2022 15:59:16 -0400
X-MC-Unique: gS7C-DviNpCNHnH3XuMt3A-1
Received: by mail-ej1-f70.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so7843626ejc.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtZt7XzUnjd5O43AVTmt8PsHJ3rbuWGLVHMz7rRTYx4=;
        b=cBsF7ys8hC7gCqlZQDgd+Gd7pC0G5e3i2ml0uHuJ+WN3mC2L73TYJLQhclWGnt8m6b
         toPJpDvBgEl9gaoi2CfgMu1fdR8frQu7V6zV8NaPVNedc92qxpQUTuCF2buFbgzkHRZj
         qm9rSjDHImmKU3LiXD9axNdHOqz/RXx4HPOjDWrQtmVStphubu6pTePqTPVkLqh68OF0
         uw0B8GVoCpW7vj7eMlAvxcR/kU/HVXKQJayERSq2H11cUyTzs1aDnTNK6EwBKB+dtScm
         u1gvAuxNoHkFgMsy/VMoEXmqnVc4FTEuFyi/iI6MVBVWED/8bvHdvdwggyDExmhOWNGh
         Nabw==
X-Gm-Message-State: ACrzQf1MDZOvZQmGyHWcEUAIwLdCBzI5nEwtCpBoCDqwIDUeYsXqIOg+
        b53cOUe44pDlr3a5ignMa6b/c0C1uerI6lLzi6KXwN+8juWHgfsrzjL8kMWbmfd3Vn4kkWYcIAM
        dX/kzn6JQPlpk8UBD7Po=
X-Received: by 2002:a05:6402:5507:b0:452:183f:16d1 with SMTP id fi7-20020a056402550700b00452183f16d1mr29128349edb.96.1665604754463;
        Wed, 12 Oct 2022 12:59:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6+QJ+6MBK5TQq/SyiEwjQ16KVtisQGnVv9+fyHRx/iZp0vnq6Qcjd6Ryik7TPt7PPdg2QVng==
X-Received: by 2002:a05:6402:5507:b0:452:183f:16d1 with SMTP id fi7-20020a056402550700b00452183f16d1mr29128341edb.96.1665604754309;
        Wed, 12 Oct 2022 12:59:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id lh4-20020a170906f8c400b0073d638a7a89sm1787728ejb.99.2022.10.12.12.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:59:13 -0700 (PDT)
Message-ID: <bda8bfb1-833e-469f-8da6-9ea003d4f14c@redhat.com>
Date:   Wed, 12 Oct 2022 21:59:13 +0200
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

As discussed in the other thread I don't really see the
added value of exporting Vsys as a regulator (also see my
latest reply in the other thread).

So I don't plan to review patches 5-7 atm.

Regards,

Hans



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


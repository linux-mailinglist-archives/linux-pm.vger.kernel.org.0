Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA805FD6F4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJMJYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMJYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 05:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28913E29
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665653083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGCT7DAvN9LCwxdxhJw9119Fs6WG0wEr19eeqRjFzmc=;
        b=Mg0JUedEslLlwaEoB/xMvabXBFhsDSQi3YHGlYWHILNo66Q4Jn94lvJMDVbkwiz0QjUy4d
        jnEtsGnzjbU9nr7IBm7eplLyeAWFgz4b+i1cwzeZf98J4Sp4WvJCJrgLsuINNBF4pS31Bs
        dSflKtHUPxd8AO74pW7OUWvLqEXrG+M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-wVIIlKjQPaONSfEc_lU-JQ-1; Thu, 13 Oct 2022 05:24:42 -0400
X-MC-Unique: wVIIlKjQPaONSfEc_lU-JQ-1
Received: by mail-ed1-f71.google.com with SMTP id z16-20020a05640235d000b0045c0360bfcfso1071259edc.14
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGCT7DAvN9LCwxdxhJw9119Fs6WG0wEr19eeqRjFzmc=;
        b=DBTTI9gNi9XKLknoGndIGVxcB8UOh7LESeAuxko7kELPz2qh3eO/YFqNo51Or6MdZd
         LsnpbfjrzxugxioaqZ0yPLTmK2lN2/VpPvfTCN2ryikbLSuHoC991k7SQkxeTT2+slvl
         N8afy1kjwyJJeA7pfAg1lBQnf3EqXWDOPQhM8lTPMgFxHH/t+t4Q0lOivs/b6p0wHvum
         9qA6oUObt8h4l+WvuFvRbGT3sub/4BcDKNfHpLEhYYmNwG7Op89STgyswrR6shgbgDAW
         iNU8jApoGaNWYt7W2ucs1yfHBJkpbioBiF00NO6dSC4e8vw67qBpl6bhDRKFzTF0Ttud
         2N5g==
X-Gm-Message-State: ACrzQf2XzWLzHKuJPuKUbI46dsXygoYEfbC4TnMU+rNRLH1OB4cPRaIo
        J3i1prmMbsuI260zS2EpYHNadhYKu1uC54x/dSjilmm7ibxfOwGTAV9sBD9hPKxqTBct6CWwlx1
        AnoseSO1aAFfldLUE0yM=
X-Received: by 2002:a05:6402:3552:b0:45c:1e45:6f92 with SMTP id f18-20020a056402355200b0045c1e456f92mr17502531edd.4.1665653081285;
        Thu, 13 Oct 2022 02:24:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6532lcVJYRKMM9t0qiOvLpBDOVg0ZMCUMViNKh4CGp8zhZiJCJwLaZjQVRk5Z8MtvHHCMzpg==
X-Received: by 2002:a05:6402:3552:b0:45c:1e45:6f92 with SMTP id f18-20020a056402355200b0045c1e456f92mr17502517edd.4.1665653081112;
        Thu, 13 Oct 2022 02:24:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q26-20020aa7d45a000000b0045b4b67156fsm10906699edr.45.2022.10.13.02.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 02:24:40 -0700 (PDT)
Message-ID: <2e46a972-f1fb-aad4-7b6c-accbec4bff42@redhat.com>
Date:   Thu, 13 Oct 2022 11:24:39 +0200
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
> Pull the regulator registration code into separate function, so it can
> be extended to register more regulators later. Currently this is only
> moving ifdeffery into one place and other preparatory changes. The
> dev_err_probe() output string is changed to explicitly list vbus
> regulator failure, so that once more regulators are registered, it
> would be clear which one failed.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



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


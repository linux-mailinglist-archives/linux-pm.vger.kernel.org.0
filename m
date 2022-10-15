Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0C15FFA82
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJOOTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJOOTk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 10:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3917598
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665843578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzXG4T1FekgjYA6ii230rvfMKQuFPgIqn/SnO5p4iKA=;
        b=BJ2h5QjPl3e7dwWtUtzcxlXrowVxs2bMAZmOTDscrUPQKahplvsgdLFWiTsIqmt261Th+d
        Irn2SBCfIcWCy1imqd0oRNY5gSHLT89h8xK9ynSqPpQJtBI/WoTwHHkeE61lF+zwsg22uJ
        kZw3XiYT9vOkBvqgk900UKVhl/5Hu0I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-1XBDZU0_Mp6IUt4YSyHLuw-1; Sat, 15 Oct 2022 10:19:37 -0400
X-MC-Unique: 1XBDZU0_Mp6IUt4YSyHLuw-1
Received: by mail-ed1-f72.google.com with SMTP id l18-20020a056402255200b0045d2674d1a0so3505500edb.0
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 07:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzXG4T1FekgjYA6ii230rvfMKQuFPgIqn/SnO5p4iKA=;
        b=0YVa8dZTL2gSYQICMDfgBmRbM0q2oh5+Oq8D6ueEuward8f0DNFrGJMqoUN8o1s6Uo
         jclzjir8h4LIAxJXHeOob3PCWE9EKtHhH2utoCG/NaxMTGfvhdh8Jk6/iYqq5zNUkz+H
         C3TWkAxGS36Lkz3EMfUqQs95IO9gqR0iFt8bpcljtoJ1KEes7+wNqDBbgacXVyaSnhg2
         2lpbYeNAaQBMlYc6Zx79mw9DeAxiEREx33Padxl0OlA0BAbOlNlZkNr4DNy0k1vw4Iff
         u3fK4A5dPZ73Y1Hd6BUfjyUCG5UEnTfn00wnzCBJ6uGGOYm4Qago/LHm1O/N0ouR01TO
         4ncA==
X-Gm-Message-State: ACrzQf3M50xtbSJA1bjrt88cCu2q35euBBURs1EFJoNPSyiXDCpbIT0l
        FKXKram+kbZ/2HRT7igecwpL9x9Eg26Nhx3pKOz4h+bu2aotlWn/d4l/9/KoXXVyflQdbXVe1rr
        n2TPiDhZxF0kzJ+ul6XY=
X-Received: by 2002:a17:907:3e87:b0:78d:bb06:9066 with SMTP id hs7-20020a1709073e8700b0078dbb069066mr2179933ejc.387.1665843575508;
        Sat, 15 Oct 2022 07:19:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5i7qfEmxqYdoZRIQOFb/15avlN5t6tXBEST1gqnTuNYcJ7a0PYsRAWoxX01e48oLRZrWGkHA==
X-Received: by 2002:a17:907:3e87:b0:78d:bb06:9066 with SMTP id hs7-20020a1709073e8700b0078dbb069066mr2179913ejc.387.1665843575309;
        Sat, 15 Oct 2022 07:19:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00788c622fa2csm3185627ejf.135.2022.10.15.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 07:19:34 -0700 (PDT)
Message-ID: <9b03f0f3-9d0e-33a5-2a01-9ca45407e1c7@redhat.com>
Date:   Sat, 15 Oct 2022 16:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 6/7] power: supply: bq25890: Add get_voltage support to
 Vbus regulator
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221014172427.128512-1-marex@denx.de>
 <20221014172427.128512-6-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221014172427.128512-6-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/14/22 19:24, Marek Vasut wrote:
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
> V2: Simplify the Vbus regulator registration, quoting Hans:
>     "
>     AFAIK if the Vboost regulator is not referenced in dt because
>     it is controller through the usb-phy framework then valid_ops_mask
>     will be empty, so the 2 sets of ops + 2 descs are not necessary
>     I believe.
>     So I believe this can be simplified to just adding
>     bq25890_vbus_get_voltage to the ops, dropping .fixed_uV and
>     .n_voltages from the desc, and just completely dropping
>     the IS_ERR_OR_NULL(bq->usb_phy) check.
>     "

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/power/supply/bq25890_charger.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index dad98b782a2f8..ad5811304f88a 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1095,10 +1095,18 @@ static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
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
>  	.enable = bq25890_vbus_enable,
>  	.disable = bq25890_vbus_disable,
>  	.is_enabled = bq25890_vbus_is_enabled,
> +	.get_voltage = bq25890_vbus_get_voltage,
>  };
>  
>  static const struct regulator_desc bq25890_vbus_desc = {
> @@ -1107,8 +1115,6 @@ static const struct regulator_desc bq25890_vbus_desc = {
>  	.type = REGULATOR_VOLTAGE,
>  	.owner = THIS_MODULE,
>  	.ops = &bq25890_vbus_ops,
> -	.fixed_uV = 5000000,
> -	.n_voltages = 1,
>  };
>  
>  static int bq25890_register_regulator(struct bq25890_device *bq)
> @@ -1120,9 +1126,6 @@ static int bq25890_register_regulator(struct bq25890_device *bq)
>  	};
>  	struct regulator_dev *reg;
>  
> -	if (!IS_ERR_OR_NULL(bq->usb_phy))
> -		return 0;
> -
>  	if (pdata)
>  		cfg.init_data = pdata->regulator_init_data;
>  


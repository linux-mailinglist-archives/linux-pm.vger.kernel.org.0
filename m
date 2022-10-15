Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609CD5FFA81
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 16:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJOOTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOOTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 10:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128D52FF9
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665843555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcG1pbOVRjmmf36z7x3BzP9vl9ih30saO6WDB1/tMjE=;
        b=fAIUdGNz05Dmow9IKAGuXrPQZ1zW9pqKO+ct2WhefP+AcMF/1XiwYz+lWP4Ym7IS785j/X
        j57Iro3ldbyPmEH/rQmeYSX8N7WJKPGzY2OaFwfW/A8PuezJP5a6IPev6hoyzZ1I+l+RPg
        g4+0+H8STp0Vl7/HxY1dNNINT/i2TbI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-Sa5y6Z-dNcSeHC430H11Og-1; Sat, 15 Oct 2022 10:19:14 -0400
X-MC-Unique: Sa5y6Z-dNcSeHC430H11Og-1
Received: by mail-ed1-f71.google.com with SMTP id w20-20020a05640234d400b0045d0d1afe8eso4472722edc.15
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 07:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcG1pbOVRjmmf36z7x3BzP9vl9ih30saO6WDB1/tMjE=;
        b=01NI/RfwQQFYL6WOr6LitndAoS9+jSuBE6wovS04nn3U9LaalW6rdWmec4cO0hOCRv
         yL6X6M9zVj/BB1laRYoC8UiQYdNeImFQSH539VGCQnsKhBuxzUcZh6w9is6aGKXodg48
         /XJY035zRSqC7Ooh33h9e9TiyndxTbjaruGBr656T35Zrol3liuviB3wgBB//gkKzovy
         /IUsakJWLO5y2s/6d8zqNj+dCUC7w5xsuMz1+0hawRrS/R6XrGgAlCSUJm/AkMPKkfqE
         WpXyI8F0DgdvwrBCF97lD1WeD97+VXYnctuxP9l7CTsCZGpM+spp0EyvMjADDMhHRut4
         gs4Q==
X-Gm-Message-State: ACrzQf3N5oAhYhYrc+ZBwwvMSYiaSRK/8JcrQ7YgEgX3fDcHW10SVIGP
        kw8giH3byCoPoGGNebRdMhxVAancsj1OJrvECIMdgc/2/KtFCCCYKAp62zapAFWtQkYlHeIsZhl
        xD2HgqxL80YhDcDD7MhQ=
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id wt14-20020a170906ee8e00b007304a24f311mr2262460ejb.420.1665843552343;
        Sat, 15 Oct 2022 07:19:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7mjxa/7Sb5G7Ll0PR12E87jCXJVS56LjxewFL0213i2dr18cfkYjvUOCWnZ5et4ImssixcBg==
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id wt14-20020a170906ee8e00b007304a24f311mr2262446ejb.420.1665843552113;
        Sat, 15 Oct 2022 07:19:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id w28-20020a170907271c00b0078d2a2ca930sm3167648ejk.85.2022.10.15.07.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 07:19:11 -0700 (PDT)
Message-ID: <e7459363-aa54-2b7a-c22a-10ac11596e03@redhat.com>
Date:   Sat, 15 Oct 2022 16:19:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/7] power: supply: bq25890: Clean up
 POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221014172427.128512-1-marex@denx.de>
 <20221014172427.128512-3-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221014172427.128512-3-marex@denx.de>
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
> Clean up misuse of POWER_SUPPLY_PROP_VOLTAGE,
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX
> and POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
> and document what exactly each value means.
> 
> The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE content is newly read
> back from hardware, while POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX
> is reported as the maximum value set in DT.
> 
> The POWER_SUPPLY_PROP_VOLTAGE is newly used to report immediate value
> of battery voltage V_BAT, which is what this property was intended to
> report and which has been thus far misused to report the charger chip
> output voltage V_SYS.
> 
> The V_SYS is no longer reported as there is currently no suitable
> property to report V_SYS. V_SYS reporting will be reinstated in
> subsequent patch.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
> V2: Drop the state online check from new POWER_SUPPLY_PROP_VOLTAGE_NOW
>     since the VBAT can be measured even when discharging

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/bq25890_charger.c | 72 ++++++++++++++++----------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 5924b036b1588..050eef2571e8e 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -529,24 +529,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>  		break;
>  
> -	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> -		if (!state.online) {
> -			val->intval = 0;
> -			break;
> -		}
> -
> -		ret = bq25890_field_read(bq, F_BATV); /* read measured value */
> -		if (ret < 0)
> -			return ret;
> -
> -		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> -		val->intval = 2304000 + ret * 20000;
> -		break;
> -
> -	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> -		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
> -		break;
> -
>  	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
>  		val->intval = bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
>  		break;
> @@ -563,15 +545,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		val->intval = bq25890_find_val(ret, TBL_IINLIM);
>  		break;
>  
> -	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
> -		if (ret < 0)
> -			return ret;
> -
> -		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> -		val->intval = 2304000 + ret * 20000;
> -		break;
> -
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:	/* I_BAT now */
>  		/*
>  		 * This is ADC-sampled immediate charge current supplied
> @@ -628,6 +601,51 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
>  		break;
>  
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:	/* V_BAT now */
> +		/*
> +		 * This is ADC-sampled immediate charge voltage supplied
> +		 * from charger to battery. The property name is confusing,
> +		 * for clarification refer to:
> +		 * Documentation/ABI/testing/sysfs-class-power
> +		 * /sys/class/power_supply/<supply_name>/voltage_now
> +		 */
> +		ret = bq25890_field_read(bq, F_BATV); /* read measured value */
> +		if (ret < 0)
> +			return ret;
> +
> +		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> +		val->intval = 2304000 + ret * 20000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:	/* V_BAT user limit */
> +		/*
> +		 * This is user-configured constant charge voltage supplied
> +		 * from charger to battery in second phase of charging, when
> +		 * battery voltage reached constant charge voltage.
> +		 *
> +		 * This value reflects the current hardware setting.
> +		 *
> +		 * The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX is the
> +		 * maximum value of this property.
> +		 */
> +		ret = bq25890_field_read(bq, F_VREG);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = bq25890_find_val(ret, TBL_VREG);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:	/* V_BAT max */
> +		/*
> +		 * This is maximum allowed constant charge voltage supplied
> +		 * from charger to battery in second phase of charging, when
> +		 * battery voltage reached constant charge voltage.
> +		 *
> +		 * This value is constant for each battery and set from DT.
> +		 */
> +		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
> +		break;
> +
>  	case POWER_SUPPLY_PROP_TEMP:
>  		ret = bq25890_field_read(bq, F_TSPCT);
>  		if (ret < 0)


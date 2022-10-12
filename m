Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7055FCBB8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLT4I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLT4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 15:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E0BCB8C
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665604564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+NscCR9NiSc2rsoD0GoyJp8oMpkakkJjksjzEC1GE0=;
        b=QJK5j1lZh+lgv21ngE7W0dqyZoFz3DQ+9U1TqS44zeQiIoXozsO6AKgukdOwHBupW7++xi
        NCawgVuQRZInRzqRUGdu3PZKriEO8tBO1wiOnwH3hrnkmhN1hs++s2GCcckYmDTzBx7nKT
        L/uOWcBkaVbXsitm7+3f/latp0vNRdE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-4LTqC6m_Omq5KXlvXHl4jg-1; Wed, 12 Oct 2022 15:56:03 -0400
X-MC-Unique: 4LTqC6m_Omq5KXlvXHl4jg-1
Received: by mail-ed1-f71.google.com with SMTP id t11-20020a056402524b00b0045cdc3a403dso257869edd.16
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+NscCR9NiSc2rsoD0GoyJp8oMpkakkJjksjzEC1GE0=;
        b=DdyF+m29AN0TLzspDipxNJd9roOgql0x7w4A0Zxk2r+lLNPkNhCW9gNsHfR5VrJ5GU
         J9PFP5KRBdwwT1d2LixiDdFz84DnQYjyoabe883WTwT7I61/BOEtiOv7GZ1hGNhF/gTa
         owI+ZK7ILXzrORprJLSTUj2XPK+AwdDBqd81/1/zoD2gsy0ZAH/R8MqSAGgCmC7rcyew
         yo6ssgRMzuSSpeUg7MDNuuQvOISZLQxmPnrwaPqDFxeCmct7tf6TxfrPJicM7KyHkJj1
         dLq0l8twfsp4AnZKdt1PMO+c+MoWn43NHXUGyTxlf7A9O+KpViYxH0WFVOxIsmxFwfSX
         oejA==
X-Gm-Message-State: ACrzQf0nMcqQBCX4tCvJd5X5RktvV0sZMoNoqIB+ipKfSC1uTrELBxA6
        BlgAY9eYfP/rvjOa6BJHw5kU0WD1e0oVBRP8kA8ORWmRQvCXWXTlXXbzlkNQGme1MTtsqVDnTla
        6T5AcRZpfcNZ6zMYYcXA=
X-Received: by 2002:a05:6402:34d6:b0:45c:ccee:ca94 with SMTP id w22-20020a05640234d600b0045ccceeca94mr2035193edc.342.1665604562075;
        Wed, 12 Oct 2022 12:56:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7zu38/dg/ohWd/JPdA4d7Eh1doM/2I3cy1Pu4PwQRNs1WP0zSTMRYF+/SdFFgnYJpXUqRf+A==
X-Received: by 2002:a05:6402:34d6:b0:45c:ccee:ca94 with SMTP id w22-20020a05640234d600b0045ccceeca94mr2035174edc.342.1665604561826;
        Wed, 12 Oct 2022 12:56:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b0078d9c2c8250sm1794713ejh.84.2022.10.12.12.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:56:01 -0700 (PDT)
Message-ID: <1bbd11c1-20df-d9d2-568c-2c616b6dbd80@redhat.com>
Date:   Wed, 12 Oct 2022 21:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/7] power: supply: bq25890: Clean up
 POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-3-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-3-marex@denx.de>
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
>  drivers/power/supply/bq25890_charger.c | 76 +++++++++++++++++---------
>  1 file changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 5924b036b1588..7632aad8bf0a1 100644
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
> @@ -628,6 +601,55 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
> +		if (!state.online) {
> +			val->intval = 0;
> +			break;
> +		}

I see that this 'if (!state.online) { }' block was also there in the original
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE code, but I wonder why this is here?

Does the bq25890 not support sampling the battery voltage when discharging/
when running from the battery as power-source ?

I would expect the battery voltage sampling to work fine when discharging
too, and this is useful into to have during discharge too. Especially when
there is no fuel-gauge ...

> +
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


Otherwise this looks good to me.

Regards,

Hans


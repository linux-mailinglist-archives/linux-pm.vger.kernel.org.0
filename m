Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3B5FCB9A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLT3y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLT3w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 15:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB69192BC
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665602988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUQ5EM74Iva3zrszvVZVoWrRjRE2Tk67p1JgbD0bsUc=;
        b=Tlsprh/7ryCDinaap88VIqNa/id46f53cJ48/UEdPDZsTHU05JpuR2eFwR4ErA8/pp/0xM
        poA1GB5e7WSqpKtEh36ChBSf0wZ/VoBvTFZGbimrOPWC/VTxs0RYUbTkonQ6tqtuwlp2K3
        chRR5Jf4FUL04Gwg/6opQmBGYOOb2Dc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-Edo32J7TPXOSlABHb7dv-Q-1; Wed, 12 Oct 2022 15:29:47 -0400
X-MC-Unique: Edo32J7TPXOSlABHb7dv-Q-1
Received: by mail-ed1-f69.google.com with SMTP id j20-20020a05640211d400b0045bd72f05d6so9047361edw.11
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUQ5EM74Iva3zrszvVZVoWrRjRE2Tk67p1JgbD0bsUc=;
        b=NljHiY9ufcXiKHiFmVI+Ro8caAWKZzcRjNyOteoR0R7+ZWUPnhQ5jJ/+qV/oZDBvua
         WvnA61ByQ5chjJxaHD7rUo4CIzu4KHWZtlum0xckcStFTvoNksv9iwX0vz9WRbOBLaAy
         e7NdAj77DlmwkvULeDUYOQsoAsU/0+CDLY0xCelm6VkHT+pDxvdPZPHVZy+M6joPo1iH
         Tyc3bO69icmeXmh2E2920fv3AKeyhZpuhBs0mvodexfJB/kAkjnDaHuy3ALWj1Y6FZZI
         JCiCpKje+dJ63qR2f6t01vXbHJGMi0kPfUGFG2oqZMgH5a/YbFA/9IAILIvsG7zV06uO
         43Ww==
X-Gm-Message-State: ACrzQf1cRIa3jf9ZPr5s0FgOK8ro3QTL5UaJxw8mGKPct6sMaeCLWp2v
        /FsnphxS5kCR8z3Jjqcu/diY44B92YHC3yhYqseMpOiSSHx+Pi/gVLOa4NhHiGZwSUWwTrug0Dw
        dTNK7ibZJyQSWPgsh3rI=
X-Received: by 2002:a17:907:6090:b0:78d:1b32:bf81 with SMTP id ht16-20020a170907609000b0078d1b32bf81mr24839975ejc.141.1665602986301;
        Wed, 12 Oct 2022 12:29:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4D3gyPPktTqTRpr1LaOVkkYeNWnmJdczvvpFmLCURefDGNHeP2L3mpcs+MSl1pxzrzQ+wo8w==
X-Received: by 2002:a17:907:6090:b0:78d:1b32:bf81 with SMTP id ht16-20020a170907609000b0078d1b32bf81mr24839961ejc.141.1665602986106;
        Wed, 12 Oct 2022 12:29:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g3-20020a50ee03000000b0045391f7d877sm11792347eds.53.2022.10.12.12.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:29:45 -0700 (PDT)
Message-ID: <16857b3e-7b2a-7462-9907-898f8b4f5f45@redhat.com>
Date:   Wed, 12 Oct 2022 21:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/7] power: supply: bq25890: Clean up
 POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-2-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-2-marex@denx.de>
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
> Clean up misuse of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX and document what
> exactly each value means.
> 
> The POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT content is newly read
> back from hardware, while POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX
> is reported as the maximum value set in DT.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq25890_charger.c | 57 ++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 1298d5720aa4b..5924b036b1588 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -529,22 +529,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>  		break;
>  
> -	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> -		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> -
> -		/* When temperature is too low, charge current is decreased */
> -		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
> -			ret = bq25890_field_read(bq, F_JEITA_ISET);
> -			if (ret < 0)
> -				return ret;
> -
> -			if (ret)
> -				val->intval /= 5;
> -			else
> -				val->intval /= 2;
> -		}
> -		break;
> -
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  		if (!state.online) {
>  			val->intval = 0;
> @@ -604,6 +588,46 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		val->intval = ret * -50000;
>  		break;
>  
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:	/* I_BAT user limit */
> +		/*
> +		 * This is user-configured constant charge current supplied
> +		 * from charger to battery in first phase of charging, when
> +		 * battery voltage is below constant charge voltage.
> +		 *
> +		 * This value reflects the current hardware setting.
> +		 *
> +		 * The POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX is the
> +		 * maximum value of this property.
> +		 */
> +		ret = bq25890_field_read(bq, F_ICHG);
> +		if (ret < 0)
> +			return ret;
> +		val->intval = bq25890_find_val(ret, TBL_ICHG);
> +
> +		/* When temperature is too low, charge current is decreased */
> +		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
> +			ret = bq25890_field_read(bq, F_JEITA_ISET);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (ret)
> +				val->intval /= 5;
> +			else
> +				val->intval /= 2;
> +		}
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:	/* I_BAT max */
> +		/*
> +		 * This is maximum allowed constant charge current supplied
> +		 * from charger to battery in first phase of charging, when
> +		 * battery voltage is below constant charge voltage.
> +		 *
> +		 * This value is constant for each battery and set from DT.
> +		 */
> +		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> +		break;
> +
>  	case POWER_SUPPLY_PROP_TEMP:
>  		ret = bq25890_field_read(bq, F_TSPCT);
>  		if (ret < 0)
> @@ -887,6 +911,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,


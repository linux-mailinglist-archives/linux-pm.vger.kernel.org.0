Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5636D4475E8
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhKGUtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234950AbhKGUtT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636317996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4DIqpGTdWvRNB5tsuZCnliZFF68Qji5Xly3UtINbPc=;
        b=c1JIDbulWFnd01DFEzpEArGMSTtnHGEdtZBJFm0w9EvnZENU4zJOBixYUsOgOdqNYXDVn2
        MTPWNtHhnBvRGjYj6Tt4awX4kjtK5Gdzgw+FkLeLSsZqyIbn6elCVFES5kbFwRXa0Zjq0p
        2J+i5AoXKRh5yrToQxj4zxYwZWKjjXE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-KS1ByG_1Mxev77iRD-E3MQ-1; Sun, 07 Nov 2021 15:46:32 -0500
X-MC-Unique: KS1ByG_1Mxev77iRD-E3MQ-1
Received: by mail-ed1-f69.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso13224979edb.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Nov 2021 12:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y4DIqpGTdWvRNB5tsuZCnliZFF68Qji5Xly3UtINbPc=;
        b=AOzo79aH189CBRoXj2/4P6XRfaUwhKGkHK29fwU0qgIN+RTaPAJZVkngSwNdKiov/H
         ipc3HxT2u3PbqkVKMIA415Jv0BQCOA3coUAuJrxkudjFJyaRF+Zd1f1Wl19klwmdIBk+
         hZgXc9KR1sVFTwCd1b6M+1n097fhKAjX5kcguOBI6Mt6vCvdXqEZzCj+LL0uZUeOdpJe
         XlM5cCXRY66B7abmmNutpFHAXfvaUj6s2B6jE0dZ86zuSR3uXjCHgDnRI3ZI6cnZP7wz
         /aaRWrGZMf70Ci47OtfSH8qUWrCESyfKkbs//x9f0f5DFNddByMvhu0lE98/RLFi8EX3
         3hwQ==
X-Gm-Message-State: AOAM531MPTauUQ1n7ZQD5wor6dxUk8uRUcK2PsybeE+/jIw0Ncggg96Q
        UpteAvpnduaJGFVQqAbQGCq4WdYiDyKh8kqufYHZkotub4XDJga9sXPveqRuTs1kN89s4AODZNy
        TW5400TEuhL0B8Maj3Jk=
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr89769167ejc.179.1636317991332;
        Sun, 07 Nov 2021 12:46:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKIbqOdkscXYajDNG5edvb3cb6535fkJeFN82d1pbwDw+foLziTMygoGer20ovRw2d8G58lw==
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr89769154ejc.179.1636317991172;
        Sun, 07 Nov 2021 12:46:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w25sm32447edv.57.2021.11.07.12.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 12:46:30 -0800 (PST)
Message-ID: <f6d18e80-a7ef-175b-dfa8-5c311c393e0b@redhat.com>
Date:   Sun, 7 Nov 2021 21:46:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] power supply bq25890-charger: Handle temperature
 faults
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-3-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211107202001.54579-3-jekhor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/7/21 21:20, Yauhen Kharuzhy wrote:
> Add debug info about thermal failure to message in
> bq25890_get_chip_state().
> 
> Take into account possible thermal failure when calculating a
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX value as it described in
> datasheet (in cold conditions a current limit is decreased to 20% or 50% of
> ICHG field value depended on JEITA_ISET field).
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Thank you for your patch,

Patch subject prefix should be: "power: supply: bq25890: "


> ---
>  drivers/power/supply/bq25890_charger.c | 33 +++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 1c43555d5bd8..fb2f1578503c 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -95,6 +95,7 @@ struct bq25890_state {
>  	u8 vsys_status;
>  	u8 boost_fault;
>  	u8 bat_fault;
> +	u8 ntc_fault;
>  };
>  
>  struct bq25890_device {
> @@ -384,6 +385,14 @@ enum bq25890_chrg_fault {
>  	CHRG_FAULT_TIMER_EXPIRED,
>  };
>  
> +enum bq25890_ntc_fault {
> +	NTC_FAULT_NORMAL = 0,
> +	NTC_FAULT_WARM = 2,
> +	NTC_FAULT_COOL = 3,
> +	NTC_FAULT_COLD = 5,
> +	NTC_FAULT_HOT = 6,
> +};
> +
>  static bool bq25890_is_adc_property(enum power_supply_property psp)
>  {
>  	switch (psp) {
> @@ -474,7 +483,19 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret = bq25890_field_read(bq, F_JEITA_ISET);
> +		if (ret < 0)
> +			return ret;
> +

You only use the read value if bq->state.ntc_fault == NTC_FAULT_COOL
and i2c reads are somewhat expensive (or at least slow), can you
please move this to inside the
"if (bq->state.ntc_fault == NTC_FAULT_COOL) {" block ?

This is esp. relevant since this condition will normally be false,
so normally this will save us an i2c_read for every read of the
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX property.

>  		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> +
> +		/* When temperature is too low, charge current is decreased */
> +		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
> +			if (ret)
> +				val->intval /= 5;
> +			else
> +				val->intval /= 2;
> +		}
>  		break;
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> @@ -487,6 +508,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> +		ret = bq25890_field_read(bq, F_JEITA_VSET);
> +		if (ret < 0)
> +			return ret;
> +
>  		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
>  		val->intval = 2304000 + ret * 20000;
>  		break;
> @@ -550,7 +575,8 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>  		{F_VSYS_STAT,	&state->vsys_status},
>  		{F_BOOST_FAULT, &state->boost_fault},
>  		{F_BAT_FAULT,	&state->bat_fault},
> -		{F_CHG_FAULT,	&state->chrg_fault}
> +		{F_CHG_FAULT,	&state->chrg_fault},
> +		{F_CHG_FAULT,	&state->ntc_fault}

Copy paste error? Surely the field in the second line must be F_NTG_FAULT ?

>  	};
>  
>  	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
> @@ -561,9 +587,10 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>  		*state_fields[i].data = ret;
>  	}
>  
> -	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT=%d/%d/%d\n",
> +	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
>  		state->chrg_status, state->online, state->vsys_status,
> -		state->chrg_fault, state->boost_fault, state->bat_fault);
> +		state->chrg_fault, state->boost_fault, state->bat_fault,
> +		state->ntc_fault);
>  
>  	return 0;
>  }
> 

Regards,

Hans


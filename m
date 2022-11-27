Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8C639BD1
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 17:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiK0QoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 11:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0QoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 11:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E9ED2F3
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669567391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSVlGUDkUEcEwDWttw4MkL2kOOhkCDRmpFVMtF5XOos=;
        b=eweBxijFGkDZKizT8SN6EnSeB7Df3rtGM2kDnam6vEhP/u6g2CdPqNXp3XSEKHspujvPhH
        R/XXZkOwIUhOJ1XYMHniOpFAwsYzQBZhpPLebG1gXuI+ICX+y3mBNMbKjUVJHwPXECqJYF
        WeNr9BWfKNe+ujj13vvjUOIZht0lMF8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664--ovydaqJNcWQXS9sv7KRAA-1; Sun, 27 Nov 2022 11:43:10 -0500
X-MC-Unique: -ovydaqJNcWQXS9sv7KRAA-1
Received: by mail-ed1-f69.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so5387421edz.21
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 08:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSVlGUDkUEcEwDWttw4MkL2kOOhkCDRmpFVMtF5XOos=;
        b=nbHtc/OtKClhpqOsEfW0pPYDbqhhCUB9dvVIKTr2eXLtdvMvezaQdZXxVfBZHId6xv
         gztC0dUcjVdJ5BAirAaY2FuM+jhztSf6hZXX70vVwV2YMJSx8Uoq8vzBznzWyUitsxaI
         VI7L7+n6GsNPBdK5gseGzwtv0OqVFw9s66teMcS0/Vsm74qxFC0yK9RF1JxRw3ypvcBE
         bpn1QVHCZgl8TY+YJR+/014rXza7LlAhMIrKUPn+wO7LjDut5Xs65cFQ4fL1E8XopWlr
         bcYYLfJsNKpT8TwFDxyydBaX+P9EeEp/Cccd0swyHxV89+nxwnpqun1Fo558I2GezaRv
         niqA==
X-Gm-Message-State: ANoB5pmw0wFFKG4Hr0WNsmS86v/js2/UfUl9UWsKnUbupTFfJXZ9k/gl
        8kYbKkG0TRI66jzTqY9Ld7J/wKlSI3pUQQVqei7xV7J2CJ/e6OYMT7sV4+RKwYFrCbNr7cNucnB
        wD6+zg3++KKQHGACejyE=
X-Received: by 2002:a05:6402:360b:b0:468:f365:dca with SMTP id el11-20020a056402360b00b00468f3650dcamr7819716edb.41.1669567388519;
        Sun, 27 Nov 2022 08:43:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5/f7g4LD+yHn0uf1mLwOAIokXrrDU10GuOpuEPJMKXoC29yRHKwuOZI6NYhEt4OcrNKA3RPg==
X-Received: by 2002:a05:6402:360b:b0:468:f365:dca with SMTP id el11-20020a056402360b00b00468f3650dcamr7819702edb.41.1669567388281;
        Sun, 27 Nov 2022 08:43:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id mj22-20020a170906af9600b007ba705f8f90sm3921651ejb.79.2022.11.27.08.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 08:43:07 -0800 (PST)
Message-ID: <0bb3a66a-17ad-74bd-7d1e-0e1402c6c9dd@redhat.com>
Date:   Sun, 27 Nov 2022 17:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] power: supply: bq25890: Add HiZ mode support
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221126120849.74632-1-marex@denx.de>
 <20221126120849.74632-2-marex@denx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221126120849.74632-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 11/26/22 13:08, Marek Vasut wrote:
> The bq25890 is capable of disconnecting itself from the external supply,
> in which case the system is supplied only from the battery. This can be
> useful e.g. to test the pure battery operation, or draw no power from
> USB port.
> 
> Implement support for this mode, which can be toggled by writing 0 or
> non-zero to sysfs 'online' attribute, to select either offline or online
> mode.
> 
> The IRQ handler has to be triggered to update chip state, as switching
> to and from HiZ mode does not generate an interrupt automatically.
> 
> The IRQ handler reinstates the HiZ mode in case a cable is replugged by
> the user, the chip itself clears the HiZ mode bit when cable is plugged
> in by the user and the chip detects PG bad-to-good transition.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> ---
> V2: - Mix HiZ mode check into POWER_SUPPLY_PROP_STATUS,
>       POWER_SUPPLY_PROP_CHARGE_TYPE, POWER_SUPPLY_PROP_ONLINE
>       read back, so those behave as if the system was offline
>       in case HiZ mode is enabled and cable is plugged in
>     - Cache user HiZ configuration in bq->force_hiz, reinstate
>       the user HiZ configuration in IRQ handler on offline to
>       online transition as the chip clears the HiZ bit on that
>       transition when the cable is replugged.
> ---
>  drivers/power/supply/bq25890_charger.c | 58 +++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 374ab66ba8770..e40c8a94cf2e1 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -95,6 +95,7 @@ struct bq25890_init_data {
>  
>  struct bq25890_state {
>  	u8 online;
> +	u8 hiz;
>  	u8 chrg_status;
>  	u8 chrg_fault;
>  	u8 vsys_status;
> @@ -119,6 +120,7 @@ struct bq25890_device {
>  
>  	bool skip_reset;
>  	bool read_back_init_data;
> +	bool force_hiz;
>  	u32 pump_express_vbus_max;
>  	enum bq25890_chip_version chip_version;
>  	struct bq25890_init_data init_data;
> @@ -487,7 +489,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> -		if (!state.online)
> +		if (!state.online || state.hiz)
>  			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>  		else if (state.chrg_status == STATUS_NOT_CHARGING)
>  			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> @@ -502,7 +504,8 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> -		if (!state.online || state.chrg_status == STATUS_NOT_CHARGING ||
> +		if (!state.online || state.hiz ||
> +		    state.chrg_status == STATUS_NOT_CHARGING ||
>  		    state.chrg_status == STATUS_TERMINATION_DONE)
>  			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
>  		else if (state.chrg_status == STATUS_PRE_CHARGING)
> @@ -522,7 +525,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval = state.online;
> +		val->intval = state.online & !state.hiz;

Please use "&&" instead of "&" here, since these are both 1 bit values the "&"
will also work but "&&" better expresses that this is a boolean compare and you
use "||" in the negated cases above, so using "&&" is consistent with that.

I have fixed this up in my local copy of the patch.

I have also noticed some other issues, which are best addressed with a follow-up
patch.

Once I have run a few final tests I plan to submit a bigger bq25890_charger
patch series, which includes a bugfix to your previous series, as well as
a few follow up patches to this series.

To make things easier for Sebastian, I'm going to include your patches
in my bigger series, making that series look like this:

1. A couple of bug fixes for the current bq25890 code
2. Your patches (this series) with the mentioned small "&" -> "&&" squashed in + my Reviewed-by
3. Some follow up patches from me to this series
4. My recent patches building on top of this series.

This way Sebastian can apply all the patches without conflict,
which I hope makes things easier for him.

Marek, I will Cc you on the entire series.

Regards,

Hans



>  		break;
>  
>  	case POWER_SUPPLY_PROP_HEALTH:
> @@ -676,7 +679,8 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
>  					     const union power_supply_propval *val)
>  {
>  	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> -	int maxval;
> +	struct bq25890_state state;
> +	int maxval, ret;
>  	u8 lval;
>  
>  	switch (psp) {
> @@ -691,6 +695,12 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
>  		return bq25890_field_write(bq, F_IINLIM, lval);
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = bq25890_field_write(bq, F_EN_HIZ, !val->intval);
> +		if (!ret)
> +			bq->force_hiz = !val->intval;
> +		bq25890_update_state(bq, psp, &state);
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -703,6 +713,7 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_ONLINE:
>  		return true;
>  	default:
>  		return false;
> @@ -757,6 +768,7 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>  	} state_fields[] = {
>  		{F_CHG_STAT,	&state->chrg_status},
>  		{F_PG_STAT,	&state->online},
> +		{F_EN_HIZ,	&state->hiz},
>  		{F_VSYS_STAT,	&state->vsys_status},
>  		{F_BOOST_FAULT, &state->boost_fault},
>  		{F_BAT_FAULT,	&state->bat_fault},
> @@ -772,10 +784,11 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>  		*state_fields[i].data = ret;
>  	}
>  
> -	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
> -		state->chrg_status, state->online, state->vsys_status,
> -		state->chrg_fault, state->boost_fault, state->bat_fault,
> -		state->ntc_fault);
> +	dev_dbg(bq->dev, "S:CHG/PG/HIZ/VSYS=%d/%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
> +		state->chrg_status, state->online,
> +		state->hiz, state->vsys_status,
> +		state->chrg_fault, state->boost_fault,
> +		state->bat_fault, state->ntc_fault);
>  
>  	return 0;
>  }
> @@ -792,16 +805,33 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
>  	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
>  		return IRQ_NONE;
>  
> -	if (!new_state.online && bq->state.online) {	    /* power removed */
> +	/* power removed or HiZ */
> +	if ((!new_state.online || new_state.hiz) && bq->state.online) {
>  		/* disable ADC */
>  		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
>  		if (ret < 0)
>  			goto error;
> -	} else if (new_state.online && !bq->state.online) { /* power inserted */
> -		/* enable ADC, to have control of charge current/voltage */
> -		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
> -		if (ret < 0)
> -			goto error;
> +	} else if (new_state.online && !bq->state.online) {
> +		/*
> +		 * Restore HiZ bit in case it was set by user.
> +		 * The chip does not retain this bit once the
> +		 * cable is re-plugged, hence the bit must be
> +		 * reset manually here.
> +		 */
> +		if (bq->force_hiz) {
> +			ret = bq25890_field_write(bq, F_EN_HIZ, bq->force_hiz);
> +			if (ret < 0)
> +				goto error;
> +			new_state.hiz = 1;
> +		}
> +
> +		if (!new_state.hiz) {
> +			/* power inserted and not HiZ */
> +			/* enable ADC, to have control of charge current/voltage */
> +			ret = bq25890_field_write(bq, F_CONV_RATE, 1);
> +			if (ret < 0)
> +				goto error;
> +		}
>  	}
>  
>  	bq->state = new_state;


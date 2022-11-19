Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B60630F05
	for <lists+linux-pm@lfdr.de>; Sat, 19 Nov 2022 14:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKSNuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Nov 2022 08:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiKSNuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Nov 2022 08:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0210548
        for <linux-pm@vger.kernel.org>; Sat, 19 Nov 2022 05:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668865794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+TkOyD5T/zRJr0tf9kmQ7ySGIBDrdmswMSQhex6U8w=;
        b=FgB5pWrBsxTAucFR0m3AJRhX00PwsIvr8wCOYCew/c9ScPnTBHjJdaMWXkDT8h7YmL2295
        b3RNSgUz8uMHbGpH8ztIcZ8AM8wVKtBMoQYEyVT4mBVSQ35/4oDUjtwn8xx+9+vbqaf9i4
        TGHZeLaizzZIENHkUMqaX6WwaeZGWAA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-LWbSgbpiP3StKiLPSZt3vQ-1; Sat, 19 Nov 2022 08:49:52 -0500
X-MC-Unique: LWbSgbpiP3StKiLPSZt3vQ-1
Received: by mail-ej1-f69.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso4679306ejc.4
        for <linux-pm@vger.kernel.org>; Sat, 19 Nov 2022 05:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+TkOyD5T/zRJr0tf9kmQ7ySGIBDrdmswMSQhex6U8w=;
        b=CbE9aGCIWV4Y09IZ5Z/HVtoLYqGOrd1tRxU3z+SgB4XMkit4IcfFSj7rdYG6JQS1CQ
         V3D83zgx3O+x3+HznUA/AeWamysmjO6XHisE3VNeWCqf31U013mmyzrS8XR9M9Z1nzZo
         W+wwz/EWQp3DLbYgE+nnfNaTCHkmBndrwXRzKdEKrKQfLdzSyq6GdZEoaOmRTywLamK2
         X7jYXZXCGLaAyU5OweEWyIhERhj8ENbHIh8K0D3OvN01uq2Xz13Atp/njbRqys0OX/rx
         QHSaSr3XjHCc3diZeKaybKfuo8TLenoLIqOELMTFayWBb8YcPLnGeHJ62qJvtr/j7JE/
         nqrg==
X-Gm-Message-State: ANoB5pk0jMmUQL5KENfqpQZ3bgK+IVC9VzNHlwu5veOIF1xCCWZ2ZABv
        d1h4+tHYktk/HOVHjMmy2ymBs4Ja0MfOoObX6moRmgnkqmOuXmp1lJNp+Ky4jP3uVECBNZ4pmhw
        Uaazj6g5uENIBqcnnOvs=
X-Received: by 2002:a05:6402:5412:b0:460:e19c:15a3 with SMTP id ev18-20020a056402541200b00460e19c15a3mr10116412edb.252.1668865791481;
        Sat, 19 Nov 2022 05:49:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lVUH9CMBF1tOWMmly8Fh+zJ94EbeNbK3hlY+qXxnuiaoGMQh9a+9WeYoraDogXqwzEH31vg==
X-Received: by 2002:a05:6402:5412:b0:460:e19c:15a3 with SMTP id ev18-20020a056402541200b00460e19c15a3mr10116397edb.252.1668865791301;
        Sat, 19 Nov 2022 05:49:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0073d7ab84375sm2920765ejf.92.2022.11.19.05.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 05:49:50 -0800 (PST)
Message-ID: <476fe066-0482-8b9e-99b4-73851cda7199@redhat.com>
Date:   Sat, 19 Nov 2022 14:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] power: supply: bq25890: Factor out chip state update
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221109221504.79562-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/9/22 23:15, Marek Vasut wrote:
> Pull the chip state and ADC conversion update functionality out into
> separate function, so it can be reused elsewhere in the driver. This
> is a preparatory patch, no functional change.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Sebastian Reichel <sre@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index f0362dcb935e9..676eb66374e01 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -454,20 +454,18 @@ static int bq25890_get_vbus_voltage(struct bq25890_device *bq)
>  	return bq25890_find_val(ret, TBL_VBUSV);
>  }
>  
> -static int bq25890_power_supply_get_property(struct power_supply *psy,
> -					     enum power_supply_property psp,
> -					     union power_supply_propval *val)
> +static void bq25890_update_state(struct bq25890_device *bq,
> +				 enum power_supply_property psp,
> +				 struct bq25890_state *state)
>  {
> -	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> -	struct bq25890_state state;
>  	bool do_adc_conv;
>  	int ret;
>  
>  	mutex_lock(&bq->lock);
>  	/* update state in case we lost an interrupt */
>  	__bq25890_handle_irq(bq);
> -	state = bq->state;
> -	do_adc_conv = !state.online && bq25890_is_adc_property(psp);
> +	*state = bq->state;
> +	do_adc_conv = !state->online && bq25890_is_adc_property(psp);
>  	if (do_adc_conv)
>  		bq25890_field_write(bq, F_CONV_START, 1);
>  	mutex_unlock(&bq->lock);
> @@ -475,6 +473,17 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  	if (do_adc_conv)
>  		regmap_field_read_poll_timeout(bq->rmap_fields[F_CONV_START],
>  			ret, !ret, 25000, 1000000);
> +}
> +
> +static int bq25890_power_supply_get_property(struct power_supply *psy,
> +					     enum power_supply_property psp,
> +					     union power_supply_propval *val)
> +{
> +	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> +	struct bq25890_state state;
> +	int ret;
> +
> +	bq25890_update_state(bq, psp, &state);
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:


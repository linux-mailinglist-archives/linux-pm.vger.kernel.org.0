Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF670585E55
	for <lists+linux-pm@lfdr.de>; Sun, 31 Jul 2022 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiGaJwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 Jul 2022 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGaJwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2022 05:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A63E1208C
        for <linux-pm@vger.kernel.org>; Sun, 31 Jul 2022 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659261172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vN5OrKAAyJkFmbiY3RQe8eU4Iggjy4m7Yx0qFRq8wYk=;
        b=d8KQjue90CU/xngV0Hzjp0z0gf/uRvBolByIft9izKqt3TC+cFSkMYpnehQHSjN8+VrKlq
        yxJY1DBL3FuAUxtuzCEZ1tpwO33iC0ZhTQdua7V9PMz//YMbOWG3rqBum9cSgIh49HerVK
        y9M63GiPDGYZaEfpRajNF7ICW5f+ff4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-1zTdtctjMj29p_Ja024mmA-1; Sun, 31 Jul 2022 05:52:50 -0400
X-MC-Unique: 1zTdtctjMj29p_Ja024mmA-1
Received: by mail-ed1-f69.google.com with SMTP id t21-20020a056402525500b0043d267cedc7so3355347edd.2
        for <linux-pm@vger.kernel.org>; Sun, 31 Jul 2022 02:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vN5OrKAAyJkFmbiY3RQe8eU4Iggjy4m7Yx0qFRq8wYk=;
        b=yviOA/xiakXvmSKhbSCSFT0WgVUl6ha7H8/0ly7WDVnx1ouC6H69psUE+GaklcYrXz
         h1Z+XqUrgJaD8fnyZruKP3BrqCZheA6dOqtKWudjG9+amk3spQZO4enzXsy145XZ5Cd0
         cVAjgVlxmbwf85NcANBCgLS6PmUkQGiKnknPOmBYLZ0q7xczL1fYq/GqhGCKhQTZfFZw
         w/tkOsSh5F2lFo7+tULf37NhLGyT12bfzhrVRnPxnliXmBx2Rf1S/KnfkbOJruuuXqMj
         wQzV3aHP5R7B0DBnx1q6yzDEb8BFg55nCc2mX9e6B6lzsVLj6jR6KZ5RgYfWcWT6p/ZE
         qJxg==
X-Gm-Message-State: AJIora/qleSl8uE5acZqYiUGuTV7h+ESzhFUIfEYzDVtGgPXrDOkYO6v
        gQCyGCYi2MtC5CQs8OliEUm0qSO7ZiMSOfljqK92eajm3TXS3N+4JOATmDdXKw/6pYbVkT+NF+s
        5/iFFhwjUAEH9FdTwSlg=
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id mp31-20020a1709071b1f00b0072f56dbcce9mr8489952ejc.605.1659261169168;
        Sun, 31 Jul 2022 02:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+MVH1CIEybs/FCzrEDkq+o/JgPBrsajb4AaFs0IM6ghQVfUxMfNtF8mrFj67fEAfZdLMo6w==
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id mp31-20020a1709071b1f00b0072f56dbcce9mr8489945ejc.605.1659261168973;
        Sun, 31 Jul 2022 02:52:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id e3-20020a1709067e0300b0070efa110afcsm3873449ejr.83.2022.07.31.02.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 02:52:48 -0700 (PDT)
Message-ID: <a28026fb-a69b-3ca5-9851-95e6983b9404@redhat.com>
Date:   Sun, 31 Jul 2022 11:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] power: supply: bq25890: Add support for setting IINLIM
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20220730180630.152098-1-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220730180630.152098-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 7/30/22 20:06, Marek Vasut wrote:
> Let user set input current limit via sysfs. This is useful in case there
> are multiple chargers connected to the device, each of which with its own
> arbitrary maximum current which it can provide, some of which may provide
> more than the default 500mA. In that case, userspace can listen for plug
> events generated by each charger and adjust the current limit accordingly,
> e.g. to permit battery to charge faster.
> 
> Note that the IINLIM is reset every time the bq25890 is disconnected from
> a charger, so the userspace must adjust the limit repeatly on every plug
> event.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq25890_charger.c | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 131ec7d882fe9..e412bcf90b40c 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -613,6 +613,34 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static int bq25890_power_supply_set_property(struct power_supply *psy,
> +					     enum power_supply_property psp,
> +					     const union power_supply_propval *val)
> +{
> +	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> +	u32 lval;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		lval = clamp(val->intval, 100000, 3250000);
> +		lval = DIV_ROUND_UP(lval - 100000, 50000);

I'm not sure DIV_ROUND_UP is the right thing to do here. This means
that when the user e.g. asks for 1040 mA the iinlim will get set to
1050mA so more then which is being requested.

IMHO it would be better to use rounding down, aka standard divide
behavior here.

But even better would be to replace both lval = ... statements
with a single:

	lval = bq25890_find_idx(val->intval, TBL_IINLIM);

which takes care of all this for you and is also what is used
by bq25890_charger_external_power_changed() to set iinlim based
on charger-type-detection done by other chips on the board
(e.g. PMICs / usb-phys Type-C controllers).

Otherwise this looks good to me.

Regards,

Hans



> +		return bq25890_field_write(bq, F_IINLIM, lval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
> +						      enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int bq25890_get_chip_state(struct bq25890_device *bq,
>  				  struct bq25890_state *state)
>  {
> @@ -837,6 +865,8 @@ static const struct power_supply_desc bq25890_power_supply_desc = {
>  	.properties = bq25890_power_supply_props,
>  	.num_properties = ARRAY_SIZE(bq25890_power_supply_props),
>  	.get_property = bq25890_power_supply_get_property,
> +	.set_property = bq25890_power_supply_set_property,
> +	.property_is_writeable = bq25890_power_supply_property_is_writeable,
>  };
>  
>  static int bq25890_power_supply_init(struct bq25890_device *bq)


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7F58658D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiHAHP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHAHP4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 03:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6598B371B6
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659338154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGfuEFFI3KVDBJEn1gHdeFFraIBxS/bPJEZtFk6nOdI=;
        b=LOcNcGeMKebhjWjzZFccCu4Uys6iDPW4hxGRgx1LZWw2131QWc+xFtBc5LBc0z+ktgJ1Vw
        JTfxczEat+fhXDm4lFNfqCxyQQPMyi8pAOE3H37bvd5BXnFf7bWc3dBd8JlpvU7Dpk8S9s
        GEPgksBZuTeDuj88r+yPyUrkPEkfj6k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-QGfjJnImMn2obsVzjYjBQA-1; Mon, 01 Aug 2022 03:15:53 -0400
X-MC-Unique: QGfjJnImMn2obsVzjYjBQA-1
Received: by mail-ej1-f71.google.com with SMTP id sg42-20020a170907a42a00b0072e3fc6cdd1so2614377ejc.13
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 00:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EGfuEFFI3KVDBJEn1gHdeFFraIBxS/bPJEZtFk6nOdI=;
        b=Blpxfbntro0g7z61gRz10we2YQMTGqhmi4bBwZFHnoMfXoufsWbUWrfbSIPyYYGS9k
         Y+Oy1KrBrB513b2HMVLmd8b2uYef8aTtXE0J88AG7+JAh1sbff+sYoHMpJQxhfJiPPbm
         AixaYJhOCSojBb4G8zrQedimGwB096X/pBXkbGeq+DsxeahOW2yp+nVXFGQ4uUpW9wSN
         VKeW8ePXhwfGeK2RVPvHPkm04RMB+3RNhJgBhJ5zG1xCiyixyLwruOS4X730hlQrxLV1
         8hdujZ1tE7fK5FRVHwi8fRjzsKYhfAuLXfyJuvfpcumCpMb5T+wF0KqelFe+Mc9EMJMG
         5wTw==
X-Gm-Message-State: AJIora/36jRNKZ8H/+U2lLT7pLZYugrx782DdIQA7MzMAKAePL8biXM/
        K6j9J6/lfu9aOQFKVvfnIhpecY2H05rMt6zVMLHWuK/TW3FsCVmY3kno43nPtNQAGkvex9pwodM
        JOddEWGMPKrEylhGHO94=
X-Received: by 2002:a17:907:7e94:b0:72b:53d2:c004 with SMTP id qb20-20020a1709077e9400b0072b53d2c004mr11541420ejc.387.1659338152352;
        Mon, 01 Aug 2022 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sblTAldl/UlcZLpTeezY4kJbzsOXkV2mNaTmwsIo3ODc1Qs8aiNkhDOi0F/hF80qheper2ew==
X-Received: by 2002:a17:907:7e94:b0:72b:53d2:c004 with SMTP id qb20-20020a1709077e9400b0072b53d2c004mr11541407ejc.387.1659338152156;
        Mon, 01 Aug 2022 00:15:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s8-20020a1709062ec800b00730560156b0sm1639285eji.50.2022.08.01.00.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 00:15:51 -0700 (PDT)
Message-ID: <b8235890-7878-c982-caf2-1c7a69859f69@redhat.com>
Date:   Mon, 1 Aug 2022 09:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] power: supply: bq25890: Add support for setting IINLIM
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20220801025727.778218-1-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220801025727.778218-1-marex@denx.de>
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

Hi,

On 8/1/22 04:57, Marek Vasut wrote:
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
> V2: Use bq25890_find_idx(val->intval, F_IINLIM) instead of ad-hoc division
> ---
>  drivers/power/supply/bq25890_charger.c | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 131ec7d882fe9..892609f9dd250 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -613,6 +613,33 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static int bq25890_power_supply_set_property(struct power_supply *psy,
> +					     enum power_supply_property psp,
> +					     const union power_supply_propval *val)
> +{
> +	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> +	u8 lval;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		lval = bq25890_find_idx(val->intval, F_IINLIM);
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
> @@ -837,6 +864,8 @@ static const struct power_supply_desc bq25890_power_supply_desc = {
>  	.properties = bq25890_power_supply_props,
>  	.num_properties = ARRAY_SIZE(bq25890_power_supply_props),
>  	.get_property = bq25890_power_supply_get_property,
> +	.set_property = bq25890_power_supply_set_property,
> +	.property_is_writeable = bq25890_power_supply_property_is_writeable,
>  };
>  
>  static int bq25890_power_supply_init(struct bq25890_device *bq)


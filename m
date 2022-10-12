Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96C95FCB98
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJLT2o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJLT2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 15:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53C102DCC
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665602914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyWE0mv5x4Z3MhB6GH4hoFy3XclwwnrEVuqbWE+G4rY=;
        b=AKCVap2Qoa2b3kQnMWK97FBcY6kA+Grmn28bzo9jCeI4ZfFqKaKt2k2GiO4f+7Q/0Oczm3
        s1jq00YG62lqpNRao+k4AeJyzgryDRaxZ40Dd5htquuDzfA0DtFIflHbhjEQvXhaYd6LC6
        htuEulIko1bHAu3nyp5C1pYpvAWJzo4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-8J47HHrFN3mg2TAepQxfrA-1; Wed, 12 Oct 2022 15:28:33 -0400
X-MC-Unique: 8J47HHrFN3mg2TAepQxfrA-1
Received: by mail-ej1-f70.google.com with SMTP id qa14-20020a170907868e00b0078db5ba61bdso4129375ejc.12
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyWE0mv5x4Z3MhB6GH4hoFy3XclwwnrEVuqbWE+G4rY=;
        b=FtGlBUViHzJQDRayl9/QBxwmp3NPkEhC8kYiMn+TlFrhACeYBJKzBeYhRd1f4PcLqo
         ABT5I3OIO8FWqSFa0ThvBAOsFOowmyfzHw0QmW4LRjn6k9BqbOLFwUqEsDnCT2DrxxnM
         UFoadOBQ6hiUQ3lUoHlzk0u3nXO+7MmIuiQPL6xQ/L4P6eyx5vSt+U3JWATgcsTgHXSG
         Q09dVm8Zmt6ekUoe13w0gA96BaSASpEoQ2U8UONldgLUfPCoj41TGpFAl3j80Rcsw+SH
         0HBAKLUdSyjVLrDtso2jxV5M3N+GMSgwoBNhsKGSiCJLIgEBxhFgpAaTvEWt5x7DUVte
         jntQ==
X-Gm-Message-State: ACrzQf0GpEiswxYJNDiwb9ugxonLoobvBQW6o17qw/3L73S/sPSIAZv9
        4aGQlW85gMcviUiqacQyjLS0ENS9rkf1jNoMmBQXdhf9HN8TrCQNEgRw346zr8Z4nv50xDCI8YZ
        Q8yI87QD46pkTe8WinSk=
X-Received: by 2002:a50:ec84:0:b0:459:ae8:8025 with SMTP id e4-20020a50ec84000000b004590ae88025mr28375504edr.321.1665602911513;
        Wed, 12 Oct 2022 12:28:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5rRssdY+V/vUNkq/grvcypjEWfxi5qHh8jl89I3FAL8vlAwj9r68d1/EdCmYcc6aJpiKNz1g==
X-Received: by 2002:a50:ec84:0:b0:459:ae8:8025 with SMTP id e4-20020a50ec84000000b004590ae88025mr28375493edr.321.1665602911359;
        Wed, 12 Oct 2022 12:28:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bq15-20020a056402214f00b00457b5ba968csm11629705edb.27.2022.10.12.12.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:28:30 -0700 (PDT)
Message-ID: <14e52f51-9cfa-4057-92f6-b0d0f21211ca@redhat.com>
Date:   Wed, 12 Oct 2022 21:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/7] power: supply: bq25890: Document
 POWER_SUPPLY_PROP_CURRENT_NOW
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-1-marex@denx.de>
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
> Document that POWER_SUPPLY_PROP_CURRENT_NOW really does refer to ADC-sampled
> immediate battery charge current I_BAT , since the meaning is not clear with
> all the currents which might be measured by charger chips.
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
>  drivers/power/supply/bq25890_charger.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 6020b58c641d2..1298d5720aa4b 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -588,7 +588,14 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		val->intval = 2304000 + ret * 20000;
>  		break;
>  
> -	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:	/* I_BAT now */
> +		/*
> +		 * This is ADC-sampled immediate charge current supplied
> +		 * from charger to battery. The property name is confusing,
> +		 * for clarification refer to:
> +		 * Documentation/ABI/testing/sysfs-class-power
> +		 * /sys/class/power_supply/<supply_name>/current_now
> +		 */
>  		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
>  		if (ret < 0)
>  			return ret;


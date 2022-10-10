Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2547A5F9FAE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJJNzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJJNzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 09:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3766A60
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665410133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tc5aQic8H6+eU3IGncrpCO0n3+KOJF+zPCxhE4rJPAU=;
        b=Dq9TBlN+CJE9ALYAY6bM84ajE+bBvMEIGTYkMEfQ2QAgH4sdXiXncMIn3NF28yg+OssZtn
        969KV84CELepHWtTr7/XUx9UUsgQdP/uOsK2SvBUns3cMrEZGQvrIpZtenu3qwX8rIlC0o
        qOEjjAEAKtWSEpmf2YT87B3xCB9BwWk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-ePAanpiNPfiIk8SrYGoGIg-1; Mon, 10 Oct 2022 09:55:32 -0400
X-MC-Unique: ePAanpiNPfiIk8SrYGoGIg-1
Received: by mail-ej1-f70.google.com with SMTP id du10-20020a17090772ca00b00782e5bc9641so4555382ejc.23
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc5aQic8H6+eU3IGncrpCO0n3+KOJF+zPCxhE4rJPAU=;
        b=wkdVuevhA1+GCSIMR+zoMCt7EURiebn4E58oWBjtulMdlZYGdbcOeIeYFhDspNe0DI
         1ScWB/TaCvfJ+wlYhqsQ+38qraXsX4Ja5FL99BLjCcIHrhnsXkwIIrlz43qFfCRIRyHG
         TIQcXsCM9ca5I7TkxWMs0GTNoGLDlCExkPmjU+hQ8xarAmfSjvvCax0rGhDaN0zF5Zdt
         jKiHLPmY87BqxDjnDyRm/acqQtEiASBydH7mq9+Sal2u8hT4CaNHNrmmERc1W4DPJs0T
         3frY2t7/GLPqfMhr3uBs2ndcbmjaq/Q5XUW8p/x2JNMAuTHfm80FIr7eGTM3hVFOtpKJ
         BVGw==
X-Gm-Message-State: ACrzQf08Y0FjcD7kI7NFRkS6f/CdspZsspqssFT0J4fxUhQA1BqbjX5a
        b3vAG+SHfLL3xaUwxhRwGHVXNzdtOcbIkZqiu5i5XAzGA25l8riHrGYu/fXlegDi5kzowp86U2F
        d/rsBwYXerV7ENLEbJeI=
X-Received: by 2002:a17:907:271a:b0:78d:cdd7:5a23 with SMTP id w26-20020a170907271a00b0078dcdd75a23mr937045ejk.556.1665410131272;
        Mon, 10 Oct 2022 06:55:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5UNlHzjCh7mj/OOM5sVysjJdXCBdhCc/MFVlcRXgMgHwcGQ2qh2AFO9tgv4IQO6OoAHayZ0g==
X-Received: by 2002:a17:907:271a:b0:78d:cdd7:5a23 with SMTP id w26-20020a170907271a00b0078dcdd75a23mr937038ejk.556.1665410131072;
        Mon, 10 Oct 2022 06:55:31 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id o8-20020a50c908000000b004533fc582cbsm7122013edh.21.2022.10.10.06.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 06:55:30 -0700 (PDT)
Message-ID: <ac433eb7-2fcd-78ae-8379-4567528ad837@redhat.com>
Date:   Mon, 10 Oct 2022 15:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] power: supply: bq25890: Add support for setting max CC
 current and voltage
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009192136.106859-1-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221009192136.106859-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/9/22 21:21, Marek Vasut wrote:
> Let user set battery charge current and voltage limit via sysfs. This is
> useful in case the user space needs to reduce charge current to keep the
> system within thermal limits. The maximum charge current and voltage are
> still limited to "ti,charge-current" and "ti,battery-regulation-voltage"
> values to avoid damaging the hardware in case too high values are set by
> user space.

As I have tried to explain in my replies to your other patch-series,
the currently used battery charge current and voltage limits belong in
the POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT resp.
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE properties (which may also
be written to set these).

Where as the _MAX variants of these properties should give the maximum
allowed values as read from devicetree in the "ti,charge-current" and
"ti,battery-regulation-voltage" properties.

Making this work as it should will require first fixing the abuse
of at least POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE which
I mentioned in the other thread.

In case it is not clear, this is a nack for this patch. Sorry that you
have to cleanup this mess, but IMHO it is better to fix the mess now
then to try and hack around it making an even bigger mess.

Regards,

Hans



> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq25890_charger.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index c4c830247e0e0..d48c147c8be81 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -531,7 +531,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> -		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> +		ret = bq25890_field_read(bq, F_ICHG);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = bq25890_find_val(ret, TBL_ICHG);
>  
>  		/* When temperature is too low, charge current is decreased */
>  		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
> @@ -561,7 +565,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		break;
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> -		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
> +		ret = bq25890_field_read(bq, F_VREG);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = bq25890_find_val(ret, TBL_VREG);
>  		break;
>  
>  	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> @@ -619,9 +627,18 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
>  					     const union power_supply_propval *val)
>  {
>  	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> +	int maxval;
>  	u8 lval;
>  
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		maxval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> +		lval = bq25890_find_idx(min(val->intval, maxval), TBL_ICHG);
> +		return bq25890_field_write(bq, F_ICHG, lval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		maxval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
> +		lval = bq25890_find_idx(min(val->intval, maxval), TBL_VREG);
> +		return bq25890_field_write(bq, F_VREG, lval);
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
>  		return bq25890_field_write(bq, F_IINLIM, lval);
> @@ -634,6 +651,8 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
>  						      enum power_supply_property psp)
>  {
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		return true;
>  	default:


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59D5FCBBA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 21:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJLT5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLT5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 15:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F8BCB8C
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665604618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LT8MF9FCK+QYNLsCQf/fJU9s2DdFbKWJbiLVdEAMrwo=;
        b=BLJvSvBcZoLRyoP5mfY44u7jbxX0b/Rqt+E4QqaeTZ1Jw6l+UshQEM3/HwKljZIhpK0vj4
        HKjtyoYOhZQDf+bpbqEJHfu3kzzPMAvBxWW35r/emKfzPBwAWD/3vf11AB7bfemeTvIro/
        PM1g7g46FNP8d+gFvWetzOsv+eoNiWo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-hS1Q4cp3McuviePt96q3iQ-1; Wed, 12 Oct 2022 15:56:57 -0400
X-MC-Unique: hS1Q4cp3McuviePt96q3iQ-1
Received: by mail-ed1-f70.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so14223409eda.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 12:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LT8MF9FCK+QYNLsCQf/fJU9s2DdFbKWJbiLVdEAMrwo=;
        b=fqc2OhfKoN57+qtvgIW8Dj2VFPADhXxN/8aLWuvJnrFROs68rEndjJYHFxagOpGMwl
         2LqAtJ4RK8y4jzqUN9uYgm+/lDb4De7bw/qwJOxoCQMHds+QOqOt2JgGzVUgGn1bI8tQ
         HQ2JsZvK05v8VWrp63FYM4yFWh2H7dLQgdi1Mam3anSgHNVAAPEMHbsNv3UIIym0QpgM
         fBCyLBuH8jWdATUJouo2Bz9g/VlTr8qMHQaPPZeBdChh+I0wXGFZhKlva0nHwtfFajLe
         r07tTljTTgalcCCd9w5cPxlFmJW0vcu4fl51vyTXLxWqMue9xoRuGZK7GqqZR9S9sfbV
         PCRQ==
X-Gm-Message-State: ACrzQf1ZiuGOFY98L7ghF/yFkW2fWCQkn2fTyrp2R88vHYk2AfeeGN+T
        es7vIpnjhjHB1MxjApkpFtBtE/aROp+FgD5SKOwlPOPK8/ZMh/OhNld7SChqr47qMSbH+FPUlWE
        HiWK+p+Ua2c2N1ljuvoU=
X-Received: by 2002:a05:6402:35cd:b0:45c:c4d4:6e11 with SMTP id z13-20020a05640235cd00b0045cc4d46e11mr2505005edc.275.1665604616107;
        Wed, 12 Oct 2022 12:56:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Zhav1nh3keUsq1XxjZazN8xrEolJ8PvSTgukiuHgc9niLnrdm+D6FZzPVfwcGbrJdDYLnqw==
X-Received: by 2002:a05:6402:35cd:b0:45c:c4d4:6e11 with SMTP id z13-20020a05640235cd00b0045cc4d46e11mr2504992edc.275.1665604615893;
        Wed, 12 Oct 2022 12:56:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906219100b0073d71792c8dsm1741514eju.180.2022.10.12.12.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:56:55 -0700 (PDT)
Message-ID: <1be8705a-d249-0f89-1478-145f38780a9a@redhat.com>
Date:   Wed, 12 Oct 2022 21:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/7] power: supply: bq25890: Add support for setting user
 charge current and voltage limit
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-4-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-4-marex@denx.de>
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
> Let user set battery charge current and voltage limit via sysfs. This is
> useful in case the user space needs to reduce charge current to keep the
> system within thermal limits. The maximum charge current and voltage are
> still limited to "ti,charge-current" and "ti,battery-regulation-voltage"
> values to avoid damaging the hardware in case too high values are set by
> user space.
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
>  drivers/power/supply/bq25890_charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 7632aad8bf0a1..6cc3c23cd8853 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -671,9 +671,18 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
>  					     const union power_supply_propval *val)
>  {
>  	struct bq25890_device *bq = power_supply_get_drvdata(psy);
> +	int maxval;
>  	u8 lval;
>  
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		maxval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> +		lval = bq25890_find_idx(min(val->intval, maxval), TBL_ICHG);
> +		return bq25890_field_write(bq, F_ICHG, lval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		maxval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
> +		lval = bq25890_find_idx(min(val->intval, maxval), TBL_VREG);
> +		return bq25890_field_write(bq, F_VREG, lval);
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
>  		return bq25890_field_write(bq, F_IINLIM, lval);
> @@ -686,6 +695,8 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
>  						      enum power_supply_property psp)
>  {
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		return true;
>  	default:


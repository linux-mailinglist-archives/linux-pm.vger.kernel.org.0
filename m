Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46D58658C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiHAHPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHAHPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 03:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38AA5FEC
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659338115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mx+ZbbVB6pls/UcuiG97PGFc5DO7FGUrsbGmEbUqlqo=;
        b=Y48fMYZJzQvL4lH9X89porQj2kTwbvRFu8UW09JuoMArllYrlNe2nwjsuoqCvFX4gn5aNC
        4aS5mMHlU9PQqYFS5QlNQn/sXS6/muGV4zdLPYVt/2dlBr98vIJH7R791TR7eTeFH8bWyl
        qIizaZuJgAkPX8j56s3z/0zMnqSS+f4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-2tkWJgcgOySddlIVk3ifjQ-1; Mon, 01 Aug 2022 03:15:13 -0400
X-MC-Unique: 2tkWJgcgOySddlIVk3ifjQ-1
Received: by mail-ej1-f70.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso2613899ejc.18
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 00:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mx+ZbbVB6pls/UcuiG97PGFc5DO7FGUrsbGmEbUqlqo=;
        b=LmIvXTZQsLLGUHF2d0sAxY/Y80N7c9K5qX/O9kaUit5vhgJCZrJcgSoTZTh7UQsmYf
         AdlSzCSLoprSRQ/FWemUuMyuFobnE4FmbCDddtBNGATukbkVpsAFKPbVYaEei1gMAMqX
         UTLhCxC0BTyal0WPVgq1OUy5DFSbvSxAmNAnvZ1He+HpRGlGwuo+lPTllVbfpK/z27HS
         5uA0fUzN/YnBR7Oyl1iWyNgE9R6c3FqP+mrt3Av/3zThOLkltHX/8xAAS5QHqLxKrX2r
         Txem+VCy0wKRCPE2scEdssaRghO37vu1g1M+vtzafPY1b/gx1r325KGf/rDqisri6LpC
         1Pjg==
X-Gm-Message-State: AJIora/m/8e1W/6mxH4+Rq9wp4Ffd+Fj+wqbG1DvbPTa+wgU+Z0RU+LA
        tPMcvqLy5WVTYiG0O8mrcfeIkN2dTLnXqkaCsdpmn16//hZowcOLazqf33XnYEg7WB5z4RgyKlq
        LP29M0Wn+98KtzYpbnGM=
X-Received: by 2002:a17:907:e91:b0:72f:d76:b22c with SMTP id ho17-20020a1709070e9100b0072f0d76b22cmr10909118ejc.364.1659338112737;
        Mon, 01 Aug 2022 00:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ugrMVwsWTsF1/huvi6St2rg/V2bZAoglFQALZd5XaytezlD2ipaab3iC+du2l8F/jY+2wFPw==
X-Received: by 2002:a17:907:e91:b0:72f:d76:b22c with SMTP id ho17-20020a1709070e9100b0072f0d76b22cmr10909108ejc.364.1659338112572;
        Mon, 01 Aug 2022 00:15:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kz17-20020a17090777d100b007306df330e5sm1491678ejc.12.2022.08.01.00.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 00:15:11 -0700 (PDT)
Message-ID: <f12ca549-ceed-f2e2-ed86-bc2f42933939@redhat.com>
Date:   Mon, 1 Aug 2022 09:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] power: supply: bq25890: Add support for setting IINLIM
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20220730180630.152098-1-marex@denx.de>
 <a28026fb-a69b-3ca5-9851-95e6983b9404@redhat.com>
 <b18944f4-4e87-dfd1-37af-568a8959c57c@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b18944f4-4e87-dfd1-37af-568a8959c57c@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/1/22 05:00, Marek Vasut wrote:
> On 7/31/22 11:52, Hans de Goede wrote:
> 
> [...]
> 
>>> +static int bq25890_power_supply_set_property(struct power_supply *psy,
>>> +                         enum power_supply_property psp,
>>> +                         const union power_supply_propval *val)
>>> +{
>>> +    struct bq25890_device *bq = power_supply_get_drvdata(psy);
>>> +    u32 lval;
>>> +
>>> +    switch (psp) {
>>> +    case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>>> +        lval = clamp(val->intval, 100000, 3250000);
>>> +        lval = DIV_ROUND_UP(lval - 100000, 50000);
>>
>> I'm not sure DIV_ROUND_UP is the right thing to do here. This means
>> that when the user e.g. asks for 1040 mA the iinlim will get set to
>> 1050mA so more then which is being requested.
>>
>> IMHO it would be better to use rounding down, aka standard divide
>> behavior here.
>>
>> But even better would be to replace both lval = ... statements
>> with a single:
>>
>>     lval = bq25890_find_idx(val->intval, TBL_IINLIM);
>>
>> which takes care of all this for you and is also what is used
>> by bq25890_charger_external_power_changed() to set iinlim based
>> on charger-type-detection done by other chips on the board
>> (e.g. PMICs / usb-phys Type-C controllers).
> 
> Nice, fixed in v2, thanks.
> 
> There is one thing which I don't quite understand about this driver though -- shouldn't we implement .external_power_changed() callback and then somehow listen for which charger gets plugged in (like, USB standard one, or 1.5A one or 3A one, or even some adapter), and based on that tweak the IINLIM too ? Or is this more of a userspace kind of policy, so it should be up to userspace to write this sysfs entry as needed ?

There already is an external_power_changed() callback that is what
the bq25890_charger_external_power_changed() function I mentioned is... ?

Regards,

Hans


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889FD5F9F5C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJJN2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJJN2C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 09:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C55C9C9
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665408480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCPy7pK40szEJ2ndhcIw56VXPrmQQVFs3zUbbAc9Lws=;
        b=FrcDBuIthuZ0UAw+Qt0jtiREHimCrH2+XKdXBx46msqoRLAr5/yIVk7gQpnWBreIRG+E5E
        zf3MBamN0H5OgkL5AMsH29lO5aefkzSm1bq0W3Q/x/ceY02WZvmGK1vU+ZI+MeArGoMe3X
        yCaE9sIWQX2ds9XjTK5gk2P+WZtQ8Ss=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-Y0SCNKCTPAmvMiEa9yQ6pg-1; Mon, 10 Oct 2022 09:27:59 -0400
X-MC-Unique: Y0SCNKCTPAmvMiEa9yQ6pg-1
Received: by mail-ed1-f70.google.com with SMTP id w3-20020a056402268300b00459fb0c1d6fso7835127edd.4
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCPy7pK40szEJ2ndhcIw56VXPrmQQVFs3zUbbAc9Lws=;
        b=kqmbOwZ9aaluy8CiS2qYyULFHk2008JQMqxNqOa9JDRYelEia3ZGFWf0evPHtZ7x5R
         Ec+KSVRbDNFMGyIjGcDOYTZUXTDIX/QacifzF1sZT0rz40v75i0d30b3VSidmEMQCAnz
         epOA7+mhvOjQHHcgGIs4EbId5ydNPj/c2sW2oxzliyJyvXhEq5mjKmekD2X3Y2GhC9Dw
         YVoLV9wNToOn1nLvnXRA/bbuAOHxJruJeU/xw/s6vb4m0g1UIyOpeyX96g/PwlqpjfHW
         UlvVuUDOtsYSF8JlHd3SByrL+zpsEZlId7MXpNTUJLWMV3qHECr6MBVhcNwWHm+O6dyU
         beFA==
X-Gm-Message-State: ACrzQf3E/UQHuEYuysRKpM/NrM7escOPabM+4QzAvnd4fvhg4ylTUHo8
        +kizEsnawv+Ie+f6urFedjjW5NYiXUR4J9940P7EQzxH0WCzleDjfqhR8uHQvli4gXyv+ZXD3bT
        MY4Fs+MhBbF6tJAoRRWM=
X-Received: by 2002:a17:907:75c8:b0:78d:b646:e768 with SMTP id jl8-20020a17090775c800b0078db646e768mr4465711ejc.432.1665408477394;
        Mon, 10 Oct 2022 06:27:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6BBT6iG8683y6pNo5Z3Mf1su7dntqdwSWjm8MxqxtwsjEC16WE53fcBYs6iCCt/E8zUwsc9g==
X-Received: by 2002:a17:907:75c8:b0:78d:b646:e768 with SMTP id jl8-20020a17090775c800b0078db646e768mr4465694ejc.432.1665408477197;
        Mon, 10 Oct 2022 06:27:57 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0078194737761sm5358788ejd.124.2022.10.10.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 06:27:56 -0700 (PDT)
Message-ID: <36389281-89dd-8bbf-851b-3b227765c17d@redhat.com>
Date:   Mon, 10 Oct 2022 15:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Rename
 POWER_SUPPLY_PROP_CURRENT_NOW to CC current
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <20221009191839.102686-2-marex@denx.de> <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
 <1da48c09-fe83-c4d7-8d6f-c5e5a7189bc0@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1da48c09-fe83-c4d7-8d6f-c5e5a7189bc0@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/10/22 02:00, Marek Vasut wrote:
> On 10/10/22 00:58, Michał Mirosław wrote:
>> On Sun, Oct 09, 2022 at 09:18:39PM +0200, Marek Vasut wrote:
>>> The POWER_SUPPLY_PROP_CURRENT_NOW property represents, as far as I can tell,
>>> the immediate power supply input current, however, this driver reports the
>>> immediate battery charge current using that property, i.e. content of REG12
>>> ICHGR -- ADC conversion of Charge Current (IBAT). Replace the property with
>>> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which as far as I can tell should
>>> be used to report immediate battery charge voltage.
>>>
>>> This also aligns the behavior of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
>>> with POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, as the former reports IBAT
>>> and the later reports VBAT.
>>
>> I believe this is wrong: CC_CURRENT would be the constant-current charge phase
>> current limit (ICHG in REG04).
>>
>> Documentation/power/power_supply_class.rst mentions that:
>>
>> CONSTANT_CHARGE_CURRENT
>>    constant charge current programmed by charger.
> 
> I think I will wait for the subsystem maintainer to clarify these properties, because right now, this driver seems to be a complete mess in terms of what it reports and through which property. And I'm afraid that is because neither of those properties are clearly documented.

CURRENT_NOW normally is only used in fuel-gauge IC drivers (or in
the fuel-gauge/battery-type power_supply device registered by a MFD device).

When CURRENT_NOW is used on a fuel-gauge / battery type power_supply class
device then CURRENT_NOW indeed should work as mentioned in the commit msg:
"this driver reports the immediate battery charge current using that property"
re-purposing this for reporting "the immediate power supply input current"
seems wrong to me.

For reporting "the immediate power supply input current" IMHO adding
a new POWER_SUPPLY_PROP_INPUT_CURRENT_NOW property would be more
appropriate to go hand in hand with the existing
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT limit.

As for what to do with the existing use of POWER_SUPPLY_PROP_CURRENT_NOW
in the bq25890 driver. I agree that this is a bit confusing, since
charger type ICs really have 2/3 currents which are relevant:

1. The input-current from an external powersupply (if present)
2. The output-current going to the rest of the system
3. The (dis)charge-current flowing to/from the battery

having an attribute simply named "current" is not really helpful,
it is fine (and widely used by userspace) on battery-type power_supply
class devices since there is only the 1 current going into/out-off
the battery.

I see 3 solutions for this for charger style devices:

1. Document that current_now is for the (dis)charge current flowing
into/out-off the attached battery. So basically document what
the bq25890 driver is doing now.

2. Add a new charge_current_now attribute for this and switch
bq25890 over.

3. Don't report the charge-current in the charger driver, since
this is duplicate info with the fuel-gauge driver.

2. has a bit of a risk of breaking userspace, so I'm not
sure if that is a viable option. Given this I have a slight
preference for solution 1.

I hope this helps clarify the confusion surrounding this a bit.

Regards,

Hans


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156595FC38E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJLKMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJLKMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 06:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB78C1493
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665569457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRQ+ImTGfSFU3WN1ipTDwagXeFk4ouGXdEg0u/dNNJo=;
        b=YiKQN2sT0tzZ5Jm4OtaEHmLvUXhmS7FCS7pn72aZ+1Gz6Thg+m3YKdrM+7SEI4A1G83f9r
        LM6+9I84LsAhZ+TM0u/3zWRszSyGpd9e7egZpMKc3tqd2yRE9GHzKRct3ARFJbI3xoKccx
        7U7ztrAyd/mFEO/+miyJU8dyVBkh1ug=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-bTPQIWZGPLqpv4ImI6XvpQ-1; Wed, 12 Oct 2022 06:10:56 -0400
X-MC-Unique: bTPQIWZGPLqpv4ImI6XvpQ-1
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a056402278800b0045c948cc65fso2454473ede.9
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 03:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRQ+ImTGfSFU3WN1ipTDwagXeFk4ouGXdEg0u/dNNJo=;
        b=GBiPJLq+dvYQkxHxhncKC5HWi1ThsPhdKqCntO079hEVFwObGz3KB4N1A0S3eemzRX
         IkwV5s3ELYugZ1LlBX3hfbCR1FrOhS9t2uPlMErzCq9vEjPBCYplYXPK/OQV3HlwGvrp
         ivwOTlj2rYTTr+NaxY/s/h26rxQXFbT2cXVRm27YoKBEBnUdV06E+e3oHXYKqMSZvhEm
         Zw0n5NrBKexRm1zYp6MejGTIjo88KH1YiXhvt/AuySaNg25BIi2NYOND40vX2NIP59Ex
         ibCpxLIyDAmStCMXciQhgr9CXyBlQupmWul5TP+dW2r1c5LTp4QspmS7z8ACjDGPlcM8
         49dA==
X-Gm-Message-State: ACrzQf24N0UhL2e2KPLIZAfSHCGRCARebWytJj8N1VfNBv1wnZD0Ne+3
        ZT/6lZFJsG6zzOEl3VVT8VfnT8N1URUA+Y0Jf87cfYM4cl2/I4SiO+PpyXMyk9r8qy8E0Rx/Waj
        wr9jm0bf0MWFPTCph8Ls=
X-Received: by 2002:a17:907:7e90:b0:78d:50f7:8abd with SMTP id qb16-20020a1709077e9000b0078d50f78abdmr20853315ejc.523.1665569455142;
        Wed, 12 Oct 2022 03:10:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sqvNVsuq95i0Rsfp8hld8ISvegb6oU7ZYzEaDwWh4r47L2ApRrehUFz7cCd71FqO8APPlPQ==
X-Received: by 2002:a17:907:7e90:b0:78d:50f7:8abd with SMTP id qb16-20020a1709077e9000b0078d50f78abdmr20853303ejc.523.1665569454942;
        Wed, 12 Oct 2022 03:10:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o14-20020a50fd8e000000b00459148fbb3csm10860536edt.86.2022.10.12.03.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 03:10:54 -0700 (PDT)
Message-ID: <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
Date:   Wed, 12 Oct 2022 12:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
 <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 10/11/22 18:39, Marek Vasut wrote:
> On 10/11/22 10:20, Hans de Goede wrote:
>> Hi,
> 
> Hi,
> 
>> On 10/10/22 23:03, Marek Vasut wrote:
>>> Pull the regulator registration code into separate function, so it can
>>> be extended to register more regulators later. Currently this is only
>>> moving ifdeffery into one place and other preparatory changes. The
>>> dev_err_probe() output string is changed to explicitly list vbus
>>> regulator failure, so that once more regulators are registered, it
>>> would be clear which one failed.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>
>> First of all thank you for your work on this series. Based purely
>> on reading the commit messages patches 1-4 sound good to me. I will
>> do a more detailed review tomorrow.
>>
>> As for patch 5-7 thinking some more about adding a Vsys regulator
>> just to report the Vsys reading feels wrong to me.
>>
>> A regulator device's voltage in sysfs is about the value the regulator
>> is supposed to try and regulate its outputted voltage to, while here
>> we are talking about an ADC reading of the actual outputted voltage.
>>
>> This really should *not* be modeled as a regulator if anything the
>> hwmon interface would be applicable for this ADC reading and
>> the power_supply core has support for exporting some of
>> the psy info through hwmon now.
>>
>> So what should happen for Vsys IMHO is make it a new
>> POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while adding support
>> for this new property to the power-supply core, also make the core's
>> hwmon glue code export this in the registered hwmon device so that
>> e.g. a sensors applet on the desktop can easily show it (*).
>>
>> Sorry for the confusion with my ack in the other thread which
>> only meant to agree with a part of the alinea/sentence I put
>> the ack under.
> 
> I'm not sure that's all there is to the Vsys regulator, it would let us model the connection between the charger chip and PMIC, where the charger would be the supply and the PMIC the regulator consumer. If the PMIC can determine its input voltage, it might be able to configure itself to some more optimal mode of operation. With the Vsys regulator, the PMIC can determine its voltage. So I think the Vsys regulator would be useful in that scenario (that's how it is wired on my board btw.).

You are right that theoretically there is nothing wrong with
the model of having the charger-IC's Vsys output being
a perent regulator for the PMIC.

As for this being useful to actually have I have my doubts
though. All the PMICs I know automatically select the
optimal mode/parameters for their buck convertors based
on the detected input voltage. So they basically always
work optimally as long as the input voltage is within
their supported range. So having Vsys moduled as
a regulator is only theoretically useful which is not
a good argument for adding this to the kernel in this
way IMHO. 

I believe it is important to go back to the original
problem / question which we are trying to solve / answer
here, which is:

"what is the best way to make the readings from
the Vsys ADC available to userspace?"

Looking at standard Linux userspace (Debian/Fedora/etc.)
all the userspace tools capable of reporting voltages
of various voltage rails inside the system to the user
use the hwmon interface for this. This is also why
the power-supply class core recently got support for
proxying some psy properties to a hwmon class device.

So the way I see it is that if we want to report Vsys to
userspace, that we then clearly need to report it through
the hwmon interface.

And my previous proposal:

make it a new POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while
adding support for this new property to the power-supply core,
also make the core's hwmon glue code export this in
the registered hwmon device.

Still seems the best solution to me here.

Regards,

Hans


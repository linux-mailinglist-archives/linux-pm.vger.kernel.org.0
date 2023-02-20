Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F6169D0F7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Feb 2023 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjBTPxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Feb 2023 10:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjBTPwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2023 10:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDF1EFC2
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676908321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQjD7p/EnYrpHZ+YIa0To+lddLhF7+RLIvX/pUap6eo=;
        b=foFUaIqb52vQtJVr/UsvKoP1gYM0+dmw2q0IhefWU3SLFPgVuqLnctGyxNNKkVzig2G12J
        pLEKJmSNGxdOqFGIY/nfWWdSp6tQOD+S4E57LwK6aRs1HaxrGB8+d8mYA1SCcb2OmpzFdX
        8qJXl8qGiDXfMuxt3dVbAcNcl+VXjM0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-SIrcAdDYNR6B49pLiS4oDA-1; Mon, 20 Feb 2023 10:51:59 -0500
X-MC-Unique: SIrcAdDYNR6B49pLiS4oDA-1
Received: by mail-ed1-f71.google.com with SMTP id r6-20020aa7c146000000b004acd97105ffso2415676edp.19
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 07:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQjD7p/EnYrpHZ+YIa0To+lddLhF7+RLIvX/pUap6eo=;
        b=72PFYiVQ95dIouq99qIwbG5e/MyFyaV1jS2hbxcwaNfUBluNA6A/tvgM82guMAIAcx
         ZvUDG8Vo2Ja6yIdQe05vyr1SsfXERJ3Sj6aI2YiRYMZvreAARPX6sXGZyy70kO6l4Hnc
         toZoDQBt7xr4GL4ZBLYiL59CVrHpx6Vx01lXWcKd9X03dWGXy4oehYNX/F9Xh/xvR30i
         ZwCr8QxJs0SiZLG370wAa4fAUhh2jPgAHK8QBe9kJufc8d/DEyJZKcOu78KV735yGEAY
         WDb3WX6vjji1vfLk61YX67GfKroHROxCy0n9xBCLKW1cKTgxfIsCmEpUMxPsd3BpH0Q6
         gqZg==
X-Gm-Message-State: AO0yUKWxFdOSXuM/Dq5EmI7enW2mZJ0I4i0vum0zv2tFhboJQpoqxxzL
        jey5gUr0XtvIi0i1+ya9zpLk1L96NSJzkV2dWyNd3kvVLhba7PfKFZGGXNM56yQnXpAqOjjfiOR
        ap3UTJYjIw50RdyZmvQc=
X-Received: by 2002:a17:907:2d0f:b0:879:d438:4d1c with SMTP id gs15-20020a1709072d0f00b00879d4384d1cmr13943978ejc.21.1676908318917;
        Mon, 20 Feb 2023 07:51:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8PwG/VVE8roEybfD/mGFI2/PPKT1z5UIG7Fg4tYfx08r5GlyXiXq+R3Q3bUl28UPaI+eI4aw==
X-Received: by 2002:a17:907:2d0f:b0:879:d438:4d1c with SMTP id gs15-20020a1709072d0f00b00879d4384d1cmr13943948ejc.21.1676908318615;
        Mon, 20 Feb 2023 07:51:58 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060dd400b008be5b97ca49sm3333310eji.150.2023.02.20.07.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 07:51:58 -0800 (PST)
Message-ID: <97e7b76f-dfab-fa45-0eb0-37d632b57aef@redhat.com>
Date:   Mon, 20 Feb 2023 16:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] ACPI: x86: Introduce an
 acpi_quirk_skip_gpio_event_handlers() helper
Content-Language: en-US
To:     Andy Shevchenko <andy@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20230218103235.6934-1-hdegoede@redhat.com>
 <20230218103235.6934-2-hdegoede@redhat.com>
 <Y/N2/+UgH6MRUSOr@smile.fi.intel.com>
 <e61c78ea-e2b8-8c7f-c55f-a500036982a1@redhat.com>
 <Y/OTX2Z6N0ZhLOvW@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y/OTX2Z6N0ZhLOvW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/20/23 16:35, Andy Shevchenko wrote:
> On Mon, Feb 20, 2023 at 04:23:33PM +0100, Hans de Goede wrote:
>> On 2/20/23 14:34, Andy Shevchenko wrote:
>>> On Sat, Feb 18, 2023 at 11:32:33AM +0100, Hans de Goede wrote:
>>>> x86 ACPI boards which ship with only Android as their factory image usually
>>>> have pretty broken ACPI tables, relying on everything being hardcoded in
>>>> the factory kernel image and often disabling parts of the ACPI enumeration
>>>> kernel code to avoid the broken tables causing issues.
>>>>
>>>> Part of this broken ACPI code is that sometimes these boards have _AEI
>>>> ACPI GPIO event handlers which are broken.
>>>>
>>>> So far this has been dealt with in the platform/x86/x86-android-tablets.c
>>>> module, which contains various workarounds for these devices, by it calling
>>>> acpi_gpiochip_free_interrupts() on gpiochip-s with troublesome handlers to
>>>> disable the handlers.
>>>>
>>>> But in some cases this is too late, if the handlers are of the edge type
>>>> then gpiolib-acpi.c's code will already have run them at boot.
>>>> This can cause issues such as GPIOs ending up as owned by "ACPI:OpRegion",
>>>> making them unavailable for drivers which actually need them.
>>>>
>>>> Boards with these broken ACPI tables are already listed in
>>>> drivers/acpi/x86/utils.c for e.g. acpi_quirk_skip_i2c_client_enumeration().
>>>> Extend the quirks mechanism for a new acpi_quirk_skip_gpio_event_handlers()
>>>> helper, this re-uses the DMI-ids rather then having to duplicate the same
>>>> DMI table in gpiolib-acpi.c .
>>>>
>>>> Also add the new ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS quirk to existing
>>>> boards with troublesome ACPI gpio event handlers, so that the current
>>>> acpi_gpiochip_free_interrupts() hack can be removed from
>>>> x86-android-tablets.c .
>>>
>>> I'm wondering if we can teach acpi_gpio_in_ignore_list() to handle this.
>>
>> You mean have it call acpi_quirk_skip_gpio_event_handlers(), or you mean
>> extend the DMI matchs inside drivers/gpio/gpiolib-acpi.c to cover these
>> cases ?
>>
>> These devices with severely broken DSDTs already need a bunch of
>> other acpi handling quirks. So the idea is to re-use the existing
>> quirk mechanism for these to avoid having to have DMI match table
>> entries for a single model in various different places.
> 
> I don't like growing amount of compile dependencies between these modules.
> (Yes, I'm aware about stubs.)

gpiolib-acpi.c already depends on CONFIG_ACPI and is not build when this
is not set. So this does not add any new dependencies. IOW I don't see
the problem here ?

(also for this reason there is no stub for the new
acpi_quirk_skip_gpio_event_handlers() helper)

> Can we maybe move other quirks out from gpiolib-acpi.c to something like
> PDx86 or another existing board files (with quirks)?

I don't really see a clean way to move these.
 
>>> P.S. Why do we lock an IRQ before checking acpi_gpio_in_ignore_list() and
>>>      why do we not free that if the IRQ is in ignore list?
>>
>> The idea was to do the test after other things which can fail, so that
>> if there are other reasons to skip the GPIO we don't do the test +
>> dev_xxx msg.  But you are right, we should either unlock it when ignoring
>> it, or move the acpi_gpio_in_ignore_list() list check up.
>>
>> I guess just moving the check up is better, shall I prepare a patch for this?
> 
> Yes, please.

Ok will do.

Regards,

hans


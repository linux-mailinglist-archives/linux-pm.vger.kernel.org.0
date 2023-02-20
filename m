Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40D69D095
	for <lists+linux-pm@lfdr.de>; Mon, 20 Feb 2023 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjBTPZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Feb 2023 10:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjBTPZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2023 10:25:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247440C8
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676906617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h33QpU2sQY74X3dZjb0I9PsJ55yb0IogyONJ/LA7kLE=;
        b=GUQMd9KaHbqcXTL1skmZbb9NOP0pSoAJ+ATh8Vx0fiN9GVy9Ynb14KQY0VcL1BeFVqv2oM
        +BUqWoJOwVwgZbxWfqAl5S3F417RSe07GH+TysP6zDmE6dcSjpQAHnqvi6UzHILaxemEsc
        wYeU4xs2WlV0Qk4RLEkF1Ol/sV783fw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-850bQ7dVPqe1N9D0eDu90Q-1; Mon, 20 Feb 2023 10:23:36 -0500
X-MC-Unique: 850bQ7dVPqe1N9D0eDu90Q-1
Received: by mail-ed1-f69.google.com with SMTP id ec13-20020a0564020d4d00b004a621e993a8so1807370edb.13
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 07:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h33QpU2sQY74X3dZjb0I9PsJ55yb0IogyONJ/LA7kLE=;
        b=5pCm9HcCCzRncRzhhzEt8sIMNZcwHU4jEMP+tepN4EN1Y83KwS4XwW+1YxaYw2WIiR
         KwR16hfyuk+XaRjRvWC5YHYh7NPag96p2gDmTKT5v778c2RVYAPslBjJsYjcFXjN/HPG
         W/acDO4X0Iy2g5JwPjRhgGJsCVwxI1lWmGEPbZvs8/7youzhMTQCLgkfTz7YKqYQKYqI
         JwU4PqfSjgMC8Wh3qYFtGpMe6OVJojRomzgJ0d/dI7Dfmlg3pu2fogU9OFqsn0CClN3j
         MI11QzuRJ6ES6N1bw/juCiq6VAwteIGwaDcu1mYWSkWTFgdZbrKqrs57SrkFg5FeI9l/
         BeOg==
X-Gm-Message-State: AO0yUKWGIar9elwV6oMmwMxdZtmKi8H3ItWMeD7IGG7l9KbphvZkucNB
        JtNl8PtA1ZFolflcgHDh8xu9/y/sfkKIMjglhfHAaYGiJtP1xEFOW/VMTmil0ksKLdb0zp71yOc
        T5yeAFyeA7YjOTJtuy4M=
X-Received: by 2002:a17:906:a96:b0:8b2:d30:e722 with SMTP id y22-20020a1709060a9600b008b20d30e722mr13207294ejf.3.1676906615666;
        Mon, 20 Feb 2023 07:23:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/is8kiVsIxIrj34LOkdjWIUDUkDTQOPoBW9AUTjP4DjWtW941e8IbkoolO+A/rwDAMUTOcpg==
X-Received: by 2002:a17:906:a96:b0:8b2:d30:e722 with SMTP id y22-20020a1709060a9600b008b20d30e722mr13207270ejf.3.1676906615372;
        Mon, 20 Feb 2023 07:23:35 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090608cf00b008d398a4e687sm1384441eje.158.2023.02.20.07.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 07:23:34 -0800 (PST)
Message-ID: <e61c78ea-e2b8-8c7f-c55f-a500036982a1@redhat.com>
Date:   Mon, 20 Feb 2023 16:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] ACPI: x86: Introduce an
 acpi_quirk_skip_gpio_event_handlers() helper
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
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y/N2/+UgH6MRUSOr@smile.fi.intel.com>
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

On 2/20/23 14:34, Andy Shevchenko wrote:
> On Sat, Feb 18, 2023 at 11:32:33AM +0100, Hans de Goede wrote:
>> x86 ACPI boards which ship with only Android as their factory image usually
>> have pretty broken ACPI tables, relying on everything being hardcoded in
>> the factory kernel image and often disabling parts of the ACPI enumeration
>> kernel code to avoid the broken tables causing issues.
>>
>> Part of this broken ACPI code is that sometimes these boards have _AEI
>> ACPI GPIO event handlers which are broken.
>>
>> So far this has been dealt with in the platform/x86/x86-android-tablets.c
>> module, which contains various workarounds for these devices, by it calling
>> acpi_gpiochip_free_interrupts() on gpiochip-s with troublesome handlers to
>> disable the handlers.
>>
>> But in some cases this is too late, if the handlers are of the edge type
>> then gpiolib-acpi.c's code will already have run them at boot.
>> This can cause issues such as GPIOs ending up as owned by "ACPI:OpRegion",
>> making them unavailable for drivers which actually need them.
>>
>> Boards with these broken ACPI tables are already listed in
>> drivers/acpi/x86/utils.c for e.g. acpi_quirk_skip_i2c_client_enumeration().
>> Extend the quirks mechanism for a new acpi_quirk_skip_gpio_event_handlers()
>> helper, this re-uses the DMI-ids rather then having to duplicate the same
>> DMI table in gpiolib-acpi.c .
>>
>> Also add the new ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS quirk to existing
>> boards with troublesome ACPI gpio event handlers, so that the current
>> acpi_gpiochip_free_interrupts() hack can be removed from
>> x86-android-tablets.c .
> 
> I'm wondering if we can teach acpi_gpio_in_ignore_list() to handle this.

You mean have it call acpi_quirk_skip_gpio_event_handlers(), or you mean
extend the DMI matchs inside drivers/gpio/gpiolib-acpi.c to cover these
cases ?

These devices with severely broken DSDTs already need a bunch of
other acpi handling quirks. So the idea is to re-use the existing
quirk mechanism for these to avoid having to have DMI match table
entries for a single model in various different places.

> P.S. Why do we lock an IRQ before checking acpi_gpio_in_ignore_list() and
>      why do we not free that if the IRQ is in ignore list?

The idea was to do the test after other things which can fail, so that
if there are other reasons to skip the GPIO we don't do the test +
dev_xxx msg.  But you are right, we should either unlock it when ignoring
it, or move the acpi_gpio_in_ignore_list() list check up.

I guess just moving the check up is better, shall I prepare a patch for this?

Regards,

Hans


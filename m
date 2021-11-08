Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6F4498D5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhKHQAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 11:00:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241110AbhKHQAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 11:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636387067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KYz763bboOxbMn20cIS2HzETWIJmR4WwhBPXCqWbVg=;
        b=AtmVuMh0zrIyoQYuerGxzyQJFJ4lBFfUkq2g6rhqHWfVzeMmu1H42avDVasQDMDnfUc5Q4
        If8yJlm/1NZqGe1A9ZGm/oA6QYAc0Ue5sJaUD1wvAr2tDu7QAqkx5licJGsFRz02miFDwG
        uRHqXJ4QaWF7bOQxtfG68keNY1PhxD8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-hVuNsx2QOdOR3BVO6tEYzQ-1; Mon, 08 Nov 2021 10:57:46 -0500
X-MC-Unique: hVuNsx2QOdOR3BVO6tEYzQ-1
Received: by mail-ed1-f70.google.com with SMTP id w13-20020a05640234cd00b003e2fde5ff8aso9557559edc.14
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 07:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8KYz763bboOxbMn20cIS2HzETWIJmR4WwhBPXCqWbVg=;
        b=7/4j2EMmuxlG6fkw+8taz1yZ+HX0C0iNBXPZxYf+C9CRJWeZdSz8vsZpGUQIIkayE/
         qjGRDBocDUgfF4rOpGc21ZUVAglC99Me2u+z2YcawFieOdhZmfqlzSZjvrq0g2Nx8eJD
         qXZVPmSO3eciwlm55ouSlbdY3mUUoFV/KLR5pBo2W4rv/CeRBffy0uWGv8w+uJwbppDT
         4ixXXieCAd6Z9ohqCYahQb5QsSu3P/bFuQZ959K1xOoQxG26n6aWulI/+p71JPBZvOKd
         2dpmN1vqDUtueyW2CIxsy+x5W6MMV/rTVcVK4+V9yQqNmMGE0cjepPVRCo1YvBLNsVjy
         B83A==
X-Gm-Message-State: AOAM532sT0BqBMRFn1SHnqLK2QlEkddpu6tcSNvU40isPrErKBLW4iF2
        AL9iqzfHDySnExZEJYq0t4hcAvu/SF3+wV5lfqx83Odb9Y1fIwwo2vbw/3PDD1a8g+anuwyxKlL
        QzcM1tPyGwg8Ku+w+gJI=
X-Received: by 2002:a17:907:8a12:: with SMTP id sc18mr430348ejc.274.1636387065481;
        Mon, 08 Nov 2021 07:57:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf0iOhJfjaTSwaGCcG/REySSi4fRJPc4StH7NfD4KKXRYX4Nljlyh8cUTGdYWEErdHWc5rDg==
X-Received: by 2002:a17:907:8a12:: with SMTP id sc18mr430325ejc.274.1636387065338;
        Mon, 08 Nov 2021 07:57:45 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id e20sm9389142edv.64.2021.11.08.07.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 07:57:44 -0800 (PST)
Message-ID: <10c9d774-dcae-e80d-e6fa-235410658b84@redhat.com>
Date:   Mon, 8 Nov 2021 16:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 06/13] power: supply: bq25890: Add support for skipping
 initialization
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-7-hdegoede@redhat.com>
 <CAHp75VeO60umiJTAbL+nR==4pP0KkKQQ71yFNdK2SAkJ0rRXug@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeO60umiJTAbL+nR==4pP0KkKQQ71yFNdK2SAkJ0rRXug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/31/21 00:07, Andy Shevchenko wrote:
> On Sat, Oct 30, 2021 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> On most X86/ACPI devices there is no devicetree to supply the necessary
>> init-data. Instead the firmware already fully initializes the bq25890
>> charger at boot.
>>
>> At support for a new "ti,skip-init" boolean property to support this.
>> So far this new property is only used on X86/ACPI (non devicetree) devs,
>> IOW it is not used in actual devicetree files. The devicetree-bindings
>> maintainers have requested properties like these to not be added to the
>> devicetree-bindings, so the new property is deliberately not added
>> to the existing devicetree-bindings.
> 
> With 'ti,' prefix it can be a potential collision in name space, for
> internal properties I would rather use 'linux,' one.

Good point, changed for v2.

> ...
> 
>> +       init->write_cfg = !device_property_read_bool(bq->dev, "ti,skip-init");
>> +       if (!init->write_cfg)
>> +               return 0;
> 
> Why to have double negation here?
> I would rather expect that you will have direct value in the structure
> and do a respective check in the functions.

Because in all places except this one we want to know if we need to
write the cfg to the device, removing the double negation here would
mean adding negation to a init->skip_init check in many places, so this
is cleaner.

Regards,

Hans


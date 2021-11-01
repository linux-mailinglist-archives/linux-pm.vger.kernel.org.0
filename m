Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630BC4420A2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhKATTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 15:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhKATTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 15:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635794200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPxF4UHOaFrwq4ubL6S9n5LY4w6t78aRQ2QSJla2WzE=;
        b=iHQc0ylCsYQHM/YZ7Inan+C4Pk4Fnbh5MG1f3xQEYDQvhBsF4lSefP5cyYx0KPI4IOyyR2
        XK7eQXFkfEjjFgldYSav7JiocdeWItKBlookSjnmvotZENYOKIhpLZ8iaoTc59Er3ZQGoy
        KGLL3G4i6nrTqS7GF2daqNeccs23gY4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-CnmMMeRfO4Gqu4ppOWnuzQ-1; Mon, 01 Nov 2021 15:16:39 -0400
X-MC-Unique: CnmMMeRfO4Gqu4ppOWnuzQ-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640240d400b003dce046ab51so16461377edb.14
        for <linux-pm@vger.kernel.org>; Mon, 01 Nov 2021 12:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vPxF4UHOaFrwq4ubL6S9n5LY4w6t78aRQ2QSJla2WzE=;
        b=J5GeUwfcKikqtvx48XgV0vSnGjq6iuzg3QftE+8/SeCP1daUk42UOWqhy36GGzQc4c
         EiZmTThmBVMZFV7qKhLjasJG3HsZgb/2SfuGb0tz7dzhxsgd2RfYj8wSuSnhrfmZ0IMo
         HoedCP4DcnGatDLaVpXQWvH/oLeMoLNaLnEp/Hq8QVNh7Apkw1pAW8acRDgWvMA7lUWN
         7w8ml3JvRo3tmBmgdLYsiTilAqauurq5Dx/45BS/ZY7DdRFoPEKY9/+nwMRxDTMb3f7M
         SnGIcZOtHSsmncMWhSXxUgKY3n8vt9ikxUGzSOXOEnKFRllpnsqmTO3Yk71DG5KWCOiY
         uljw==
X-Gm-Message-State: AOAM531nN30c66AggvzEjncshwVzy5oDDuS5hCB0o0RIm8pUp/QsxRQ1
        J53OOKtT4a8F/+gNWFp4gRi0l+viNu/OssFKymR0WvWkeBQ9lzso9JP7XJmgxB7LdnDzJjZaVEa
        hKmkeHybyk23FSYjUgoo=
X-Received: by 2002:a17:906:9acb:: with SMTP id ah11mr31873291ejc.305.1635794198471;
        Mon, 01 Nov 2021 12:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqRGooy6XZA1Y8t1ql0dlnn+gjO+gI4KXUs5ozQ5VUAaxbAmo9oSU5aRgIi+dcO44lXRA7hQ==
X-Received: by 2002:a17:906:9acb:: with SMTP id ah11mr31873261ejc.305.1635794198319;
        Mon, 01 Nov 2021 12:16:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h10sm9331056edf.85.2021.11.01.12.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:16:37 -0700 (PDT)
Message-ID: <b3f0d3fe-8038-626e-a68c-b818e6de69da@redhat.com>
Date:   Mon, 1 Nov 2021 20:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/5] gpiolib: acpi: Add a new "ignore" module option
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20211031162428.22368-1-hdegoede@redhat.com>
 <20211031162428.22368-4-hdegoede@redhat.com>
 <CAHp75Vf-EOfF_XfqfWFQZNLp3B03o79xHf4bUrf9x9D9pTrvgw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vf-EOfF_XfqfWFQZNLp3B03o79xHf4bUrf9x9D9pTrvgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/31/21 20:59, Andy Shevchenko wrote:
> On Sun, Oct 31, 2021 at 6:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Add a new "ignore" module option to completely ignore controller@pin combos
>> from _AEI lists.
>>
>> And add a DMI quirk to ignore the interrupt of the BQ27520 fuel-gauge IC
>> on the Xiaomi Mi Pad 2. On this device we use native charger + fuel-gauge
>> drivers because of issues with the ACPI battery implementation. The _AEI
>> listing of the fuel-gauge IRQ is intended for use with the unused ACPI
>> battery implementation and is blocking the bq27xxx fuel-gauge driver
>> from binding.
> 
> I'm wondering if the idea behind this is something relative to
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/sysfs.c

The idea indeed is similar, but there is only one set of GPEs and
the GPIO pin-namespace is per GPIO controller, hence the
controller-name@pin format used, which is also used for the
already existing ignore_wake gpiolib-acpi.c module option and
the patches re-use the existing parsing code.

But since there seems to be agreement that using a board-file to
work around the DSDT deficiencies is the best option this patch
will no longer be needed. It is probably still good to keep it
archived somewhere in case the functionality turns out to be
useful on some other device(s).

Regards,

Hans


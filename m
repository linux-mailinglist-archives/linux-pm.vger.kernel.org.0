Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC1449900
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhKHQGW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 11:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239323AbhKHQGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 11:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636387417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XRwho7+z/7vhTPwvicBMtPsRE4HAHnRBBlx0Po33V4=;
        b=Pjgxay+dl/KE5k8REkqHD4mdxx44RFAZv4Bt74jFZWfaqNjO7Hc2t+OCT4Snq68nfSIUmI
        Al/yN8v2lIeE6nkld7A7gmpVGWvaKQXAMXJDnvEAWgi7S7hmIEPermBzKlLv7mRKgFBeFn
        JX4pQmK0pTR4S8+/Zil23x1SKoxvXbE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-DHGfqpKmP86SUtNcpC1OkA-1; Mon, 08 Nov 2021 11:03:36 -0500
X-MC-Unique: DHGfqpKmP86SUtNcpC1OkA-1
Received: by mail-ed1-f71.google.com with SMTP id w13-20020a05640234cd00b003e2fde5ff8aso9574501edc.14
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 08:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5XRwho7+z/7vhTPwvicBMtPsRE4HAHnRBBlx0Po33V4=;
        b=ED76KN0WSXgMGoePQxZdU2WXwWAuerLsD5IwlBCv2R0bleAferbCfxaTFtcgMOXpfu
         XQ4AVQ3t4Gd4gESTMSLYWfVczMif48rbNrSbPFRBCQAWZMinp8d1BrEadrEbcqCwTDEG
         N3VdWmnjJ8lCPMVq/ZGqKqFk8UJf9wmX5LRIVH625N2LcmmFFlKPxW9/hqXNl/8IO3En
         l3+SEpIp6zFDn4TsobuFAdzbIcbARVVFEyfpoAsdComeZW2rpG4iGQw0vpQY/IkZlRYP
         GoD8j/XGT1k7UcAVY+sI6cbLw3PRYvxqCb6/8oROJqIO6ajcy62WLmDlSVKyvxb3GVjj
         a28w==
X-Gm-Message-State: AOAM53389ZB+RRNKMQnDP1b33sPDu6EGhpXKzbIcH9OJb+j3Ra6JVXJh
        X7Nr2VU5gu5Pb+fXBLqgtcALM8PeBRJbaYRUQTnSTsbcWlrUKiyCezWAK2pJU1/RkEDx9di7LM5
        m/pHFzuSXH8NcvBSdOuc=
X-Received: by 2002:a05:6402:27ca:: with SMTP id c10mr257994ede.53.1636387414895;
        Mon, 08 Nov 2021 08:03:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymMeYJxOKQgUAvb5FkJ7gZggruAOC64UPNaUu/psunGlKIiAZnImk0g/83yscrsQAyHOIfNA==
X-Received: by 2002:a05:6402:27ca:: with SMTP id c10mr257946ede.53.1636387414596;
        Mon, 08 Nov 2021 08:03:34 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id gb2sm8401303ejc.52.2021.11.08.08.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 08:03:34 -0800 (PST)
Message-ID: <bed46b1b-eebe-4b61-1470-6f8428208a7a@redhat.com>
Date:   Mon, 8 Nov 2021 17:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 11/13] i2c: cht-wc: Add support for devices using a
 bq25890 charger
Content-Language: en-US
To:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-12-hdegoede@redhat.com> <YX7ZTXbD0F+n3M36@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YX7ZTXbD0F+n3M36@kunai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/31/21 18:58, Wolfram Sang wrote:
> On Sat, Oct 30, 2021 at 08:28:11PM +0200, Hans de Goede wrote:
>> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
>> in that it is always connected to the I2C charger IC of the board on
>> which the PMIC is used; and the charger IC is not described in ACPI,
>> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>>
>> So far there has been a rudimentary check to make sure the ACPI tables
>> are at least somewhat as expected by checking for the presence of an
>> INT33FE device and sofar the code has assumed that if this INT33FE
>> device is present that the used charger then is a bq24290i.
>>
>> But some boards with an INT33FE device in their ACPI tables use a
>> different charger IC and some boards don't have an INT33FE device at all.
>>
>> Since the information about the used charger + fuel-gauge + other chips is
>> necessary in other places too, the kernel now adds a "intel,cht-wc-setup"
>> string property to the Whiskey Cove PMIC i2c-client based on DMI matching,
>> which reliably describes the board's setup of the PMIC.
>>
>> Switch to using the "intel,cht-wc-setup" property and add support for
>> instantiating an i2c-client for either a bq24292i or a bq25890 charger.
>>
>> This has been tested on a GPD pocket (which uses the old bq24292i setup)
>> and on a Xiaomi Mi Pad 2 with a bq25890 charger.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> In general, fine with me from the I2C side:
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>

Thank you for v2 I've refactored things a bit, enough that I'm going
to drop your Ack, sorry.

>> +	else if (!strcmp(str, "bq24292i,max17047,fusb302,pi3usb30532"))
>> +		board_info = &bq24190_board_info;
>> +	else if (!strcmp(str, "bq25890,bq27520"))
>> +		board_info = &bq25890_board_info;
> 
> Very minor nit: I prefer 'strcmp() == 0' because the above could be read
> as 'if not strcmp()' which is sadly misleading. But I am not strict with
> it.

All the strcmp-s are gone in the refactored version.

Regards,

Hans


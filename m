Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9471F4199
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgFIQ7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 12:59:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731312AbgFIQ7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 12:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591721957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Nv/aSNOsUOuGhVJiOZj/3/GKlddqU08H1NN9MmEgDY=;
        b=jAX1Ehqww+m4Uw2yimEV0D3zi5RwS3VmQ9bBXDNnjhMt0Iyj/Ln+b5UAMjALma/7Kxysip
        CvKMkws4kQssgL3ERnl2v+wKKuHspU4VfQTwEMFNWQ7anpr++rAS4JF5W0TVhdJ9NmpTdv
        UT8M9U/QyMf7xyUaFxnXoJ0nt0Jinmk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-VaQvHoGUOh2jsaW0p0KTyA-1; Tue, 09 Jun 2020 12:59:16 -0400
X-MC-Unique: VaQvHoGUOh2jsaW0p0KTyA-1
Received: by mail-ed1-f72.google.com with SMTP id bs22so8494883edb.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2020 09:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Nv/aSNOsUOuGhVJiOZj/3/GKlddqU08H1NN9MmEgDY=;
        b=ZiOydL5xg/zokSM9kLSbnMI5Cq5trfxThHaEdsi+0zUW8UuvVNvB53hTw0KU9LSL7t
         p70haYNpXmYKBK5QhkXVhZzx17VNY8L5V8IWAUyBrwGsKv21wRczMluo13QdE2iXx+P0
         kEzYx6R+J9/hJ85ZlfqY7eCjoehZAJcikXJrc8wn9gU3ygEgDxUBxwZDZxUiUx+NNfHs
         cn11ahyIHJDb94BLevLSGYnuJ27PtkABK4ZPjAEA+stKTePa6bn+Oa7FQSJ7/2/5hUL9
         o36fYwxQnO4H68tlzT7EbmwxFNiJwtjlpZU+Lbiae89KNGV3gZOfsnV/Fzk2dpDbNU06
         7+xQ==
X-Gm-Message-State: AOAM5311SV8M5YKLM+P1JpMx6Gr3TrSRVV/MxBwm1gjUDy/blk4NZXkd
        mXeYQQ2JpnMHzM6kezN79FRdrdRMee0uyTwvivO+r5REQd23o43xrc9A4zuPEQ0ZMM4dvysKYld
        6zcHTzoYzA/lqybQWCWQ=
X-Received: by 2002:a50:cccc:: with SMTP id b12mr27211509edj.68.1591721954913;
        Tue, 09 Jun 2020 09:59:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuipLwjeopUoSVP0QNjhwtG56JmmHgFoTHfpbJSaHF3XASHeXXW/68XiqF4HC5kgK4xY5cKw==
X-Received: by 2002:a50:cccc:: with SMTP id b12mr27211492edj.68.1591721954676;
        Tue, 09 Jun 2020 09:59:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s2sm13412514ejm.50.2020.06.09.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 09:59:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Mario.Limonciello@dell.com, y.linux@paritcher.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, mjg59@srcf.ucam.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <20200609154938.udo7mn7ka7z7pr6c@pali>
 <20200609164533.qtup47io2aoc5hgl@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <136a06e3-0f00-d252-ebdd-a76c8a575db8@redhat.com>
Date:   Tue, 9 Jun 2020 18:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609164533.qtup47io2aoc5hgl@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 6/9/20 6:45 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jun 09, 2020 at 05:49:38PM +0200, Pali Rohár wrote:
>> On Monday 08 June 2020 20:36:58 Mario.Limonciello@dell.com wrote:
>>> Can you please comment here how you would like to see events like this should come
>>> through to userspace?
>>>
>>> * Wrong power adapter (you have X and should have Y)
>>> * You have plugged a dock into the wrong port
>>> * Fn-lock mode
>>
>> In my opinion, Fn-lock mode is related to input subsystem and should be
>> probably reported via input device. For a user, fn-lock is similar like
>> caps-lock, scroll-lock or num-lock. Also fn-lock is provided by other
>> laptops and therefore I would expect that kernel provide fn-lock state
>> for all laptops (thinkpad / latitude / ...) via same interface. And not
>> via dell-specific interface or general-vendor-message interface.
>>
>> Wrong power adapter sounds like something related to power subsystem.
>> Adding Sebastian to the loop, maybe he can provide some useful ideas
>> about it.
> 
> I'm missing a bit of context. I suppose this is about connecting a
> non-genuine power adapter rejected by the embedded controller?
> Support for that should be hooked into 'drivers/acpi/ac.c' (note:
> so far there is no standard power-supply class property for this).
> Also printing a warning to dmesg seems sensible.

This is not so much about non-genuine as about the adapter having
the wrong wattage. E.g. plugging a 65W adapter in a laptop which
has a 45W CPU + a 35W discrete GPU will not allow the laptop to
really charge while it is in use.

One issue I see with doing this in the power_supply class is that
the charger is represented by the standard ACPI AC adapter stuff,
which does not have this info. This sort of extra info comes from
WMI. Now we could have the WMI driver register a second power_supply
device, but that means having 2 power_supply devices representing
the 1 AC adapter which does not feel right.

I was myself actually thinking more along the lines of adding a
new mechanism to the kernel where the kernel can send messages
to userspace (either with some special tag inside dmesg, or through
a new mechanism) indication that the message should be shown
as a notification (dialog/bubble/whatever) inside the UI.

This could be useful for this adapter case, but e.g. also for
pluging a thunderbolt device into a non thunderbolt capable
Type-C port, a superspeed USB device into a USB-2 only USB
port and probably other cases.

Rather then inventing separate userspace APIs for all these
cases having a general notification mechanism might be
quite useful for this (as long as the kernel does not
over use it).

Regards,

Hans


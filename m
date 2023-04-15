Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1E6E3084
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDOKPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOKPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 06:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71113C1E
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681553699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxAcJ+NKRe6YS4azcC2CWQaIQmOiHTvTa0qA2rj6h/c=;
        b=JWjV/JY5qTohSvfJlPMpgaaWwk55oi7qPbk/kifDk8yMZ2uLaQ226pyZrodSxqusaoNxDb
        XgtAYtkHeS5/pdibtJF9EWUqtV6iiezcKZtNXfPPSyG+UAakMT96DIvgh9JMK73qBG5OVe
        I6yjq3mFIneWu+Ijj/B3v9FsUSZ0QdQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-nfluJewXOKStliCWH1gA7g-1; Sat, 15 Apr 2023 06:14:58 -0400
X-MC-Unique: nfluJewXOKStliCWH1gA7g-1
Received: by mail-ej1-f69.google.com with SMTP id ue7-20020a170907c68700b009339c9c32ffso7474715ejc.5
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 03:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681553696; x=1684145696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxAcJ+NKRe6YS4azcC2CWQaIQmOiHTvTa0qA2rj6h/c=;
        b=Io2R1sJf20AKkxVm9Pbo621wrnKfuJhHAcBdp8xReOBtiCXAVNZu4f+zB21tCZ+e6p
         oOfNKZPkNQqQ1syJfY7imKiQfGtEeb2+rGmWcne1L1rJ39ocjFXb4bf7kMBW5bJ6oeRZ
         Is8wNntnsOc4vy8rTSYrHcTnISCHDFpDayJ197kqsDMWSFYKYVPTHyDBOsEEgBiqWbpG
         0maASvLZmZz9bt/ZhmsezRdTPSCTNsjogUY0yN5S+AojKxugswOGIyVZp7bbm/ABkd4N
         EXWLo8kKZJa61kaP6/j1dWOAKVUP9QSlqArE4yDnLDZnOK7Pv3zYqfg0Gr18Ofn+o15U
         6ODg==
X-Gm-Message-State: AAQBX9c3m8FuFFhYNRMG72rOc8S6Y3LKJ2kQ3jIAKymswcQyLB8NR9xr
        KYFC0YmXd5eX9ATir0KteuPBOts4ZF+CEY7IY4eEO3C1aWY9Y561sbNhW87R9/NiulsAlOlLKj0
        YvtRVgFpdjTyEXCJcHhA=
X-Received: by 2002:a17:906:b202:b0:94e:d688:c36d with SMTP id p2-20020a170906b20200b0094ed688c36dmr1649383ejz.38.1681553696784;
        Sat, 15 Apr 2023 03:14:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmW1F5AL/wTgRS1Sa1xGyOM2Vdh373U3/HmXDEAJ/nH+H/g+0cR0Fbh+aiBZ2uJH3X6C44NA==
X-Received: by 2002:a17:906:b202:b0:94e:d688:c36d with SMTP id p2-20020a170906b20200b0094ed688c36dmr1649372ejz.38.1681553696468;
        Sat, 15 Apr 2023 03:14:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ty25-20020a170907c71900b0092be625d981sm3609301ejc.91.2023.04.15.03.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 03:14:55 -0700 (PDT)
Message-ID: <20bc1db5-61c9-13fd-2425-21025d025b67@redhat.com>
Date:   Sat, 15 Apr 2023 12:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/9] power: supply: bq27xxx/bq25890 status update fixes
Content-Language: en-US, nl
To:     laji Xiao <3252204392abc@gmail.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
References: <20230413095405.71685-1-hdegoede@redhat.com>
 <CALK_TxYc9t_uvMM9MbJyuU6dgcEA5Z_pQrjJgf6qXQbQSkc2Jw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALK_TxYc9t_uvMM9MbJyuU6dgcEA5Z_pQrjJgf6qXQbQSkc2Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/15/23 07:24, laji Xiao wrote:
> The problem on the Ubuntu/Arch Linux/Alpine still exists. Android seems to have no problem

This was tested to successfully fix the userspace lag on a lenovo yoga book
yb1-x90f (Android version) and a yb1-x91f (Windows version).

I guess some extra work may be needed on the mipad2.

Perhaps you can take a look at the problem on the mipad2 yourself
using these patches as guidance ?

Regards,

Hans


> 
> Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> 于 2023年4月13日周四 17:54写道：
> 
>     Hi all,
> 
>     The main goal of this series is to fix userspace sometimes not
>     getting notified in a timely manner of charging <-> discharging
>     status changes, causing e.g. battery status icons to lag
>     and the lagging of updates also effects power_supply_leds.c .
> 
>     While working on this I noticed a number of races surrounding
>     bq27xxx_battery_update(), so patches 1-4 fix those first.
> 
>     Patches 5-9 take care of the status update lagging issues.
> 
>     Regards,
> 
>     Hans
> 
> 
>     Hans de Goede (9):
>       power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
>       power: supply: bq27xxx: Fix I2C IRQ race on remove
>       power: supply: bq27xxx: Fix poll_interval handling and races on remove
>       power: supply: bq27xxx: Add cache parameter to
>         bq27xxx_battery_current_and_status()
>       power: supply: bq27xxx: Move bq27xxx_battery_update() down
>       power: supply: bq27xxx: Ensure power_supply_changed() is called on
>         current sign changes
>       power: supply: bq27xxx: After charger plug in/out wait 0.5s for things
>         to stabilize
>       power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() +
>         schedule()
>       power: supply: bq25890: Call power_supply_changed() after updating
>         input current or voltage
> 
>      drivers/power/supply/bq25890_charger.c     |   3 +
>      drivers/power/supply/bq27xxx_battery.c     | 181 +++++++++++----------
>      drivers/power/supply/bq27xxx_battery_i2c.c |   3 +-
>      include/linux/power/bq27xxx_battery.h      |   4 +
>      4 files changed, 107 insertions(+), 84 deletions(-)
> 
>     -- 
>     2.39.1
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FEB6E6C6C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDRSxk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjDRSxj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 14:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADDE6A61
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681843971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4q26ABv2/Y5RAzDDx8RD/8AFgBKYQFZsCzr/rugvk8=;
        b=FlSsgIxU4ZrQ8kYlGZdShWzrGYO7yVuH40uhnFSi8CdRzdB7SId7AXvV9WNNKRNEI0Stny
        Cy+Yjm2aza2/T+1b/c36kg9Gzplxx6XzmN/STsXLH4n9fMSyezqg3h3zHkDW5+yjrayvK/
        ZcGqI1dXV/UxJZBlNy6nsmVBweCYdv4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-YN9SrawPPOWfgtvIJQPCkw-1; Tue, 18 Apr 2023 14:52:50 -0400
X-MC-Unique: YN9SrawPPOWfgtvIJQPCkw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506b0b75731so928516a12.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 11:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843968; x=1684435968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4q26ABv2/Y5RAzDDx8RD/8AFgBKYQFZsCzr/rugvk8=;
        b=NSRIae7lAdBVDNVT/bBHzmM9Z2WF67TyS47Hh09IhB+dwQ9Vs8lFhIaEV7A7QnkyYV
         DBLp84fon0uEKLOnB2yAI15suOw3rRaueuwv3hx5t0pSx6yuyqQkKNSsIING3cegn+Q9
         oWLc/0hQuBUuZOTMnAFigdr8Wc/X3iw1vRhRzAnw7GH+ESjJVwJHeXH5E466ehpddQVU
         LiebBpQ2yR/U9VBff2kXii4EC9LzHkgiUBBPdtHXdq2mwwYiwDZ2fZqXXY0RzxGb4UKH
         hjCANCDC8lTK1HQyBGzJ+Cwqq1JA7lnnutpCDL56NUB+fnAPIUi54ha8M/LSbKDiI4TF
         Uq2Q==
X-Gm-Message-State: AAQBX9cFE8MAQmpX+ybLtFQAsSW+CsZoMw+aiX0ldzB1FfqTo7zobiol
        qZwDcjlQvgP82VjJGn8JY2fMr8EgiDIlczuYRkDrUcJ+2MVhAAMnigx2vs8geoFbtEeqq5aggCA
        3I1rRvDuuErvkPeWEvLQ=
X-Received: by 2002:aa7:c254:0:b0:506:7695:ed16 with SMTP id y20-20020aa7c254000000b005067695ed16mr3191150edo.40.1681843968739;
        Tue, 18 Apr 2023 11:52:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350bhpWrgNiiVqWrLbEgkWEqxKW66/OXpTa/bs71fA5UhD45v7cY0TRH+LlcsJ/Qy+aeKugb/jA==
X-Received: by 2002:aa7:c254:0:b0:506:7695:ed16 with SMTP id y20-20020aa7c254000000b005067695ed16mr3191140edo.40.1681843968471;
        Tue, 18 Apr 2023 11:52:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7cfc9000000b00506b2af49fbsm1631558edy.81.2023.04.18.11.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 11:52:47 -0700 (PDT)
Message-ID: <c9f28fda-ed4d-f746-241e-589473f44ec9@redhat.com>
Date:   Tue, 18 Apr 2023 20:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/9] power: supply: bq27xxx/bq25890 status update fixes
Content-Language: en-US, nl
To:     laji Xiao <3252204392abc@gmail.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
References: <20230413095405.71685-1-hdegoede@redhat.com>
 <CALK_TxYc9t_uvMM9MbJyuU6dgcEA5Z_pQrjJgf6qXQbQSkc2Jw@mail.gmail.com>
 <20bc1db5-61c9-13fd-2425-21025d025b67@redhat.com>
 <CALK_Txax-vdMVZPJDdQpu1rY+dHhUhr5AxfqJgA+kk3ESKaPSA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALK_Txax-vdMVZPJDdQpu1rY+dHhUhr5AxfqJgA+kk3ESKaPSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/18/23 19:12, laji Xiao wrote:
> Hi,
> 
> I try use the command "watch -n 0.5 cat /sys/class/power_supply/bq27520-0/status", the charging status can be updated normally, although it responds a bit slowly, it takes 1-2 seconds. But at least the charging status can be updated:)

That is good.

> In addition, what is the progress of MI PAD2's sound card?

There is no progress, I have no time to work on this.

The work on the power_supply status issue was the result of other work which I was doing which happened to hit the same issue.

Regards,

Hans



> Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> 于 2023年4月15日周六 18:15写道：
> 
>     Hi,
> 
>     On 4/15/23 07:24, laji Xiao wrote:
>     > The problem on the Ubuntu/Arch Linux/Alpine still exists. Android seems to have no problem
> 
>     This was tested to successfully fix the userspace lag on a lenovo yoga book
>     yb1-x90f (Android version) and a yb1-x91f (Windows version).
> 
>     I guess some extra work may be needed on the mipad2.
> 
>     Perhaps you can take a look at the problem on the mipad2 yourself
>     using these patches as guidance ?
> 
>     Regards,
> 
>     Hans
> 
> 
>     >
>     > Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com> <mailto:hdegoede@redhat.com <mailto:hdegoede@redhat.com>>> 于 2023年4月13日周四 17:54写道：
>     >
>     >     Hi all,
>     >
>     >     The main goal of this series is to fix userspace sometimes not
>     >     getting notified in a timely manner of charging <-> discharging
>     >     status changes, causing e.g. battery status icons to lag
>     >     and the lagging of updates also effects power_supply_leds.c .
>     >
>     >     While working on this I noticed a number of races surrounding
>     >     bq27xxx_battery_update(), so patches 1-4 fix those first.
>     >
>     >     Patches 5-9 take care of the status update lagging issues.
>     >
>     >     Regards,
>     >
>     >     Hans
>     >
>     >
>     >     Hans de Goede (9):
>     >       power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
>     >       power: supply: bq27xxx: Fix I2C IRQ race on remove
>     >       power: supply: bq27xxx: Fix poll_interval handling and races on remove
>     >       power: supply: bq27xxx: Add cache parameter to
>     >         bq27xxx_battery_current_and_status()
>     >       power: supply: bq27xxx: Move bq27xxx_battery_update() down
>     >       power: supply: bq27xxx: Ensure power_supply_changed() is called on
>     >         current sign changes
>     >       power: supply: bq27xxx: After charger plug in/out wait 0.5s for things
>     >         to stabilize
>     >       power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() +
>     >         schedule()
>     >       power: supply: bq25890: Call power_supply_changed() after updating
>     >         input current or voltage
>     >
>     >      drivers/power/supply/bq25890_charger.c     |   3 +
>     >      drivers/power/supply/bq27xxx_battery.c     | 181 +++++++++++----------
>     >      drivers/power/supply/bq27xxx_battery_i2c.c |   3 +-
>     >      include/linux/power/bq27xxx_battery.h      |   4 +
>     >      4 files changed, 107 insertions(+), 84 deletions(-)
>     >
>     >     --
>     >     2.39.1
>     >
> 


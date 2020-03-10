Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51D1806D6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 19:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCJSfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 14:35:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39839 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgCJSfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 14:35:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so2532433wml.4;
        Tue, 10 Mar 2020 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:references:subject:to:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=BP8KnDE8ksYCCumYnD6izjx91RGlwtA9mIE7DSiBL1w=;
        b=Bg8ZawhRAWb9/nGH048hQA604p6+W20zVf5tI3COe1V243ocG8dA8tnxRv5rR6xhip
         WX9APX2WsHXkIF+wZXQ3MUa6hvfwzavQhIVqK6khKECIeFT+5zdxqtaFMm7SggqsnB84
         x1IZJenYvb5IoHeS2G0LONgboYOT2D1Sqry/kXMC4ygvPHZ+uSJamPvAUVwhQvSxE14n
         ayrKrZkJo7DmiobGYSYkSN82Mb6jbh+nBB76g3GqhVCMI6obl/HaOWiaKSDho6UBrhVo
         kk9aiRj1jiwC/E0L6zsvb3NztgtX441tQZmVSWMMfDz3/eGLUxcUSTYKU9eFnOLA/Suu
         nr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:references:subject:to:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=BP8KnDE8ksYCCumYnD6izjx91RGlwtA9mIE7DSiBL1w=;
        b=B6vgFg6WGHBzFE8FvV0p0x+CYmpd2mKnBY8UpdJVfQG1ZttNcVTcwct9noeTita+EN
         gDIHw7p2469mpyfXLjZuOqEbh8kNvzR8D0Wbnt+Qgsy0f/Acr9b6QgroEHPi79n4Oprp
         gfw0bYibiAXwB3QN5bA4sImxQe2ikp3Zp8Nxr+rg4w0v69eemRLjcxdYwECdP2iZq/T8
         yrMCjW1GBCOSvZRreMoyd2TTF6sxnSVgFF4r68oIY7FVI/cJuhgAXhj4eQx0nwHAfqVx
         rhIE5AWil3HbwEZHJqMyvvDqH6+7AfPZzCjX7GGZJ7U8SEVcTo/98iazKEg0MjC37HXP
         V3gw==
X-Gm-Message-State: ANhLgQ3Kz3VhaCgNqUTTY/27L1vjxnveKd/x7ZacuB7pnDFWTb0Ee71g
        kKWXSbIAyID7n33KP6QkPuM=
X-Google-Smtp-Source: ADFU+vtkAttgBxC+gWI3jxWrwynpcJEbtSVVBNY5g2ZLqt52dDSILslqqjPkQRXE8Rb93jiPxuEyqA==
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr3349605wmb.178.1583865332015;
        Tue, 10 Mar 2020 11:35:32 -0700 (PDT)
Received: from supervisor.net28 ([46.53.253.27])
        by smtp.gmail.com with ESMTPSA id x24sm4939861wmc.36.2020.03.10.11.35.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Mar 2020 11:35:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Cc:     "Pavel Machek" <pavel@ucw.cz>,
        "Merlijn Wajer" <merlijn@wizzup.org>,
        "Sebastian Reichel" <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd> <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
 <20200121222547.GA17712@duo.ucw.cz> <20200123160257.GX5885@atomide.com>
 <op.0g8ykrhnhxa7s4@supervisor.net28> <20200310153951.GR37466@atomide.com>
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
To:     "Tony Lindgren" <tony@atomide.com>
Date:   Tue, 10 Mar 2020 21:35:29 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0g90lfcdhxa7s4@supervisor.net28>
In-Reply-To: <20200310153951.GR37466@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi.

>> 1) RFC: power: supply: cpcap-battery: Add helper for rough capacity
>>
>> CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL, 4200000 - 18000, 100)
>>
>> This line seems wrong, because Droid4 full battery is 4.35V, not 4.2V.
>
> Hmm yeah this is now configurable and defaults to 4.2V so we
> should use the confgured value. The reason we default to 4.2V
> now is because we suspect that if left connected to the charger
> at higher than 4.2V the battery ages faster.

1. How to configure this value? I tried:
echo 4350000 > /sys/class/power_supply/battery/constant_charge_voltage

...but it didn't change the fully charged battery voltage.

2. If the value is configurable, it probably shouldn't be hardcoded like
this in the code:
PCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL, 4200000 - 18000, 100)

>> I think the kernel should return  -ENODATA
>> for capacity values until the battery is "calibrated". By "calibration"
>> I mean having high and low counter_uah values initialized with the data
>> collected when the battery went a full charge or discharge cycle (from
>> empty to full or vice versa).
>
> Yes I like this idea. That leaves out the need for poor estimates
> in the kernel.
>
> I guess we should have the following new properties:
>
> POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL
> POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY
>
> And these would be 0 on boot and then userspace can
> update these based on battery data.

My idea is to only have one extra property which will store the delta of
counter values for full and empty battery states. In this case, it's going
to be more accurate than allowing the userspace to store/restore both full
and empty counters.

Some users may have a dual boot setup. In this case restoring full & empty
counters after reboot can make the kernel to report wrong battery
percentage
values.

Let's imagine the following situation:

1. The user charges the battery to the full state and discharges it to be
almost depleted, so the kernel has "calibrated" values for counter_full and
counter_empty.
2. The user decides to reboot to another OS. Let's assume he has a fully
charged battery before doing the reboot.
For example the kernel provides the following values:
POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL = -250000
POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY = 950000
/sys/class/power_supply/battery/charge_counter = -250000
A daemon saves these values to a permanent storage.
3. The user boots another OS, works there for a while, the battery charge
becomes 50%.
4. The user reboots back to our system, we restore the values:
POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL <- -250000
POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY <- 950000
5. /sys/class/power_supply/battery/charge_counter is initialized to 0 or
-250000, it doesn't matter, because in both cases we will get the wrong
battery percentage. We should report 50%, remember? In any case it can't
be calculated to this value.

And here's how I suggest it to be implemented:
1. Same as above
2. Same as above, except the kernel provides a single value that the user
should store between reboots (it's the delta I mentioned above):
POWER_SUPPLY_PROP_CHARGE_FULL = 1200000
3. Same as above
4. The user reboots back to our system, we restore the value:
POWER_SUPPLY_PROP_CHARGE_FULL <- 1200000
5. The kernel reports -ENODATA as battery capacity value until the battery
goes to a reference point (fully charged or almost discharged state).
When the battery is fully charged or discharged, the kernel can immediately
calculate the opposite counter value. And no matter what was the initial
value of /sys/class/power_supply/battery/charge_counter when the system
booted.

Of course, the value of the delta will not be constant, it should be
recalculated over time. The good news is that this value will be changed
slowly over time. That is, it can vary from 2% to 10% per year.

--
Best regards, Spinal

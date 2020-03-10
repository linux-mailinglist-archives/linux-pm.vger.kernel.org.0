Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D617EFC2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 05:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgCJEyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 00:54:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47066 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCJEyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 00:54:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so14070347wrw.13;
        Mon, 09 Mar 2020 21:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=TTolpeApc4hcuaP5gdlfzCqhGG2yLo1kJHkxoRKpwkI=;
        b=ZvXZUCOYrRQhY9xlp2WpwNNhqrKmSymQg3N4dMvLE+P0kXf1x13FYCuUUfgSHFfbuY
         aVI+Dv1yT/fgEUdqnsLLh1D4pzWaCxY2LcrZu+PjZubti0w/5pDZZOdROvnwAAxAtw9w
         wYcdRhwnAm1qCGv1gvNBfD0AWwNRK77jKZXqzejPsGxeW9srzHHJcTsKnmI3E4GsnseK
         6uj3Sb7RR3gwyZTBVtHM9Vweyo1zOUIln1S34eH+tZJKZckOXxqaL8ozAUDPheOhQ+Gb
         FL2P7XLKNEVQ7MOGKRzPVPkiVxds+Z0jBCgnv/RXFpkAxINItBlet7krrOgRmbDHsGWw
         5BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=TTolpeApc4hcuaP5gdlfzCqhGG2yLo1kJHkxoRKpwkI=;
        b=Evja2RGbLmavF6HHY89vhX3Bax9Tk5XV8wCbB/WEE44pLULH7RhOG7G3Q3Lsi0iLBk
         KNsERTfK/2pkL6hDTyOnNtfh3ZUnhO6yleXsHzqCRPYHdyJDJRG0LOR++VYVYCBjHxRs
         NIPYl+ptJRSIUsYXOk72iGrJM+vOeVvCJMKVGHXHS96JVHxGKiFylQI2Cbbjfy520dqz
         hrM5VhK/PuT3EZ3YRmFXIQTAmLcIxiBdK2R4Hiqy8E9kiKW0YzrwKnZeDG2g11qMgSEs
         o9ryjAuPP3WEqJsmP8illrEslTv9m9G4B5qSbB6+LRZRQHgYSUQDptdyjf9DcAUOX9tZ
         rR4w==
X-Gm-Message-State: ANhLgQ1YgrfhAkgwLCtomTHmqQTSiIZIoxkF5pvYOb0wCrQTb0QrZcOr
        0G64j+BQ3o81AUnaWZ/Px7yEIcGxjbULTQ==
X-Google-Smtp-Source: ADFU+vsQfMsN6oc4GuUjRG+/XnPvdtd3hiPDv1maYV+NluQ5PRKs5GsQ/DeKC7y4zhPsXqqjxboAmA==
X-Received: by 2002:a5d:5511:: with SMTP id b17mr829241wrv.198.1583816059567;
        Mon, 09 Mar 2020 21:54:19 -0700 (PDT)
Received: from supervisor.net28 ([46.53.253.27])
        by smtp.gmail.com with ESMTPSA id 19sm2524463wma.3.2020.03.09.21.54.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 21:54:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Pavel Machek" <pavel@ucw.cz>, "Tony Lindgren" <tony@atomide.com>
Cc:     "Merlijn Wajer" <merlijn@wizzup.org>,
        "Sebastian Reichel" <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd> <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
 <20200121222547.GA17712@duo.ucw.cz> <20200123160257.GX5885@atomide.com>
Date:   Tue, 10 Mar 2020 07:54:17 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0g8ykrhnhxa7s4@supervisor.net28>
In-Reply-To: <20200123160257.GX5885@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Tony.

I used the kernel with the patch serieas applied for a while.

What I expected from the userspace perspective was having
/sys/class/power_supply/battery/capacity undefined until
kernel calculates more or less accurate values for it.

Until then, the userspace should estimate percentage on its own
using voltage and current values provided by the kernel.
Like it's already done with bq27200 on Nokia N900.

Right now the values which the kernel provides with
/sys/class/power_supply/battery/capacity after a system boot
are confusing.

The user can see the battery plugin doesn't change its gauge
gradually like it was done with previous kernel versions.
Sometimes it gets suddenly empty, sometimes it changes from empty
to half full. And it always reports "battery full" in advance -
when the battery is being charged with relatively high current.

The following part of mail dedicated to what I think should be fixed
in the commits.

1) RFC: power: supply: cpcap-battery: Add helper for rough capacity

CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL, 4200000 - 18000, 100)

This line seems wrong, because Droid4 full battery is 4.35V, not 4.2V.

2.1) RFC: power: supply: cpcap-battery: Implement capacity percentage

val->intval = (ddata->config.info.charge_full_design - delta) * 100;
val->intval /= ddata->config.info.charge_full_design;

IMHO, charge_full_design should never be used in battery charge
percentage calculations. Li-ion batteries loose their capacity
with age. Therefore such calculations are likely to always be wrong.

I'd prefer to have the full charge value to be dynamically calculated by
the kernel with a formula like this:
charge_full = high->counter_uah - low->counter_uah;

This which will give us accurate estimation for the battery charge, esti-
mated time left on the battery and so on. It would be good, if we allow
the userspace to store the full charge value between reboots and to feed
it to the kernel after, so it could start providing accurated data faster:
the battery should only go full or empty once and we are ready.

I'd like to mention explicitly: I think the kernel should return -ENODATA
for capacity values until the battery is "calibrated". By "calibration"
I mean having high and low counter_uah values initialized with the data
collected when the battery went a full charge or discharge cycle (from
empty to full or vice versa).

--
Best regards, Spinal

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7183D3ADA33
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhFSNua (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Jun 2021 09:50:30 -0400
Received: from mail.manjaro.org ([176.9.38.148]:51718 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233286AbhFSNu3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Jun 2021 09:50:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 1B5013FA0483;
        Sat, 19 Jun 2021 15:48:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YRilaY05TDd7; Sat, 19 Jun 2021 15:48:15 +0200 (CEST)
Subject: Re: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
To:     Paul Fertser <fercerpav@gmail.com>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Martin Ashby <martin@ashbysoft.com>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
References: <20210218124250.128008-1-martin@ashbysoft.com>
 <20210618123017.GA10695@home.paul.comp>
 <8390c743-e4a4-bf1d-457e-2bfdcf9143d2@manjaro.org>
 <20210619102155.GC14960@home.paul.comp>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <84e6a4f2-7eaa-c606-d5e7-b15da91b24be@manjaro.org>
Date:   Sat, 19 Jun 2021 15:48:12 +0200
MIME-Version: 1.0
In-Reply-To: <20210619102155.GC14960@home.paul.comp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Paul,

Am 19.06.21 um 12:21 schrieb Paul Fertser:
...
> After reading the datasheet for the gauge I'm rather disappointed. Not
> using a shunt resistor for real current measurements and instead
> relying on some magic doesn't make any sense in my book.

I felt similarly when reading it for the first time. However, by now some
more well known manufacturers have started offering similar products [1].
It seems the manufacturers are relying on internal resistance of the 
battery to measure current draw.
In general it seems to work pretty well in the Pine64 Pinebook Pro for 
about two years now.

> So to sum up, what you can get from the chip itself:
> 
> 0. Battery voltage; pretty accurate.
> 
> 1. Its idea of current state of charge; this is percentage relative to
> the charge_full; I'd expect that to be reasonably accurate for not too
> worn-out batteries.
> 
> 2. Its idea of the remaining run time; involves secret magic to
> somehow guess the current; I'd expect this to be relatively
> inaccurate, would be interesting to learn how this performs for your
> real life loads.
> 

That is one of the characteristics I find very surprising. Even after 
over a year of use the remaining runtime estimation still seems to be 
pretty accurate. Maybe I got lucky but it works remarkably well :)

> That's it. We can't learn charge_full and current_now.
> 
> 
> Your driver code always reports charge_full equal to
> charge_full_design which is plain incorrect IMHO. It's just wrong and
> misleading, as after e.g. 2 years of usage the battery might lose half
> its capacity; and people are used to get real data from power_supply
> subsystem to be able to judge about battery health and performance.

It most definitely is. I'm not really happy with reporting them either.
However it seems that a lot of battery widgets get very confused if 
those stats are not reported.
Thus I went for some level of guestimation there. Please feel free to 
remove them and test whether all the usual battery monitoring tools 
still work. I'll be more than happy to remove them if it is not a 
problem anymore.

> Now you're also using the same value to calculate the current
> reported. But the CW2015 datasheet says that SOC is relative to the
> full capacity, not full design capacity, so the current you report
> might get wildly inaccurate too. Same about charge_now that Martin
> added: you just can't rely on unknown values when doing calculations.
> 
> 
> If I was using this driver I would certainly prefer it to _not_ report
> any grossly inaccurate guessimations. So I propose to remove
> POWER_SUPPLY_PROP_CHARGE_FULL, POWER_SUPPLY_PROP_CHARGE_NOW and
> POWER_SUPPLY_PROP_CURRENT_NOW altogether since they can't be
> meaningfully obtained from anywhere. Please do not fool userspace into
> thinking they have some information when in fact it's pulled out of
> thin air.
> 
> I'm not the authority here so it would be nice to hear the opinion of
> the subsystem maintainers, adding Sebastian to Cc. Ready to be proven
> wrong :)

Neither am I. The supported parameters were mostly chosen based on the 
Android
reference code provided to me by CellWise and user feedback (battery 
applet compatibility). I'd hate breaking the latter.

Cheers,
Tobias

[1] https://www.ti.com/lit/ds/symlink/bq27621-g1.pdf

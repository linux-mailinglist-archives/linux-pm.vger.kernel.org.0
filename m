Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C010A1BF
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfKZQPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 11:15:44 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:43348 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfKZQPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 11:15:44 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Mpsn1mr7z1bwH;
        Tue, 26 Nov 2019 11:15:41 -0500 (EST)
Date:   Tue, 26 Nov 2019 08:15:39 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0jR8OQVOniR++NJeDukDn9Bgp+DZtvmSCF_d0pH1LDr6w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911260759220.6292@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
 <alpine.DEB.2.21.1911251155440.2817@hp-x360n> <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com> <alpine.DEB.2.21.1911251502490.13123@hp-x360n> <CAJZ5v0jR8OQVOniR++NJeDukDn9Bgp+DZtvmSCF_d0pH1LDr6w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:

> > BTW, I've got breaking it down to a science now:

> > - Let the battery drain pretty well down (< ~80%)
> > - Boot the kernel I wish to test, while still on battery
> > - Intiate a suspend/resume, which will come back OK
> > - Initiate another suspend
> > - Plug in the charger. If I have my power meter in, I see it do the PD
> >   negotiation (it'll start off at 20V/150mA, then it'll PD ramp up to
> >   a full 2.5-2.75A @20v to charge the battery)
> > - Try to resume. It'll be totally dead and I have to long-power-button
> >   to get it back

Huh. So ... I run bleeding edge and grab Linus' tip as it's pushed; I'd
seen some changes to workqueues in last night's merge. Personally, I feel
that if workqueues were AFU the kernel would be a hot mess, but at this
point since there's one in the path of acpi_ec_flush_work() called from
acpi_s2idle_sync() and I'm kinda desperate at this point for at least
something to help fix this, I put your 2nd patch back in earnest (uncommented
out acpi_ec_flush_work() from acpi_s2idle_sync()) and added a pair of
WARN_ON(1)s (which should dump to pstore- or is that "BUG_ON()"?) around
the spin_lock/unlock in acpi_ec_query_flushed().

Who knows if this is a race condition, the extra (slight) overhead of the
output of the WARN_ON, or just dumb luck but it ... here I go, tempting
fate ... seems to be working. I drained the battery to 75% and ran the
procedure a couple of times yesterday, and so far, so good.

Of course, I'll have to give it the "car ride test" (and I'll be damned if
I know why that brings this bug out so consistently that flipping it around
on its axes randomly for a while does), but I'm hopeful (and again, a public
announcement is usually guaranteed to make it break).

Stay tuned, again,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

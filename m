Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9CA1091BA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKYQV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 11:21:57 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:55632 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfKYQV5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 11:21:57 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MC3Q6f4fznl0;
        Mon, 25 Nov 2019 11:21:54 -0500 (EST)
Date:   Mon, 25 Nov 2019 08:21:53 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911250812070.3858@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com> <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
 <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:

> OK, but with sleep_no_lps0, does it also hang during resume or not?

It never goes to sleep, is what I'm saying. Screen goes dark, but the machine
seems to never go into sleep states.

> In that case whatever happens in acpi_s2idle_wake() can be ruled out,
> because on your system that function effectively is a NOP with
> ec_no_wakeup.  I don't expect the test below to add anything new to
> what we know already.

> > >         acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
> > >         acpi_ec_flush_work();
> > >         acpi_os_wait_events_complete(); /* synchronize Notify handling */

> So, as stated above, this test is not likely to be conclusive.

I dunno ... did you see my other E-mail? Other than power-charge events
waking up my laptop (and not going to sleep while plugged in), it hasn't
hung up in several resume attempts, and doing power changes while asleep
just wakes it up (be it charger being plugged in, or charger removed).

Maybe this is expected behavor with those lines commented out, but at least
I know now that it's possible to suspend and successfully resume under my
standard workflow on a later-model kernel.

> I'll send you a patch to try for that.

I see that's in your next E-mail. I'll try it out shortly.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

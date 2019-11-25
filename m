Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFD10890E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 08:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYHR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 02:17:58 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:60300 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYHR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 02:17:58 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Lyzl6wRBz1KC3;
        Mon, 25 Nov 2019 02:17:55 -0500 (EST)
Date:   Sun, 24 Nov 2019 23:17:54 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <alpine.DEB.2.21.1911242140010.3858@hp-x360n>
Message-ID: <alpine.DEB.2.21.1911242308340.3858@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com> <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
 <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com> <alpine.DEB.2.21.1911242140010.3858@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sun, 24 Nov 2019, Kenneth R. Crudup wrote:

> Huh- so this is encouraging- I've removed these lines, and while I haven't
> been able to kill it yet (give me time :)) what DOES happen now is I get
> wakeups from sleep on POWER events- charger connect (and disconnect)- and
> now I wonder if this is somehow related to the issue of the suspend not
> resuming if the machine is charging?

Also, the system will not suspend if the charger is attached; it's kind of
like the "sleep_no_lps0=1" behavior (BTW, neither "sleep_no_lps0" nor
"ec_no_wakeup" have been modified from the defaults of "0" while those lines
have been deleted).

I've done 14 suspend cycles according to /sys/power/suspend_stats/success so far,
and while none of them have been for more than an hour or so, the laptop is cold
when I do resume it. I can't tell what the power draw is any more 'cause it
won't sleep while an external charger is connected- which I can live with if
it means the laptop doesn't get stuck in that intermediate suspend state
where it draws > 3x more current than the lowest idle state.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

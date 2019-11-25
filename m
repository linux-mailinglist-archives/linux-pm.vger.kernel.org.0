Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13E7108875
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 06:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbfKYFuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 00:50:17 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:35975 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfKYFuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 00:50:17 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Lx2b0jPYz1Hsv;
        Mon, 25 Nov 2019 00:50:14 -0500 (EST)
Date:   Sun, 24 Nov 2019 21:50:13 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911242140010.3858@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com> <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
 <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sun, 24 Nov 2019, Rafael J. Wysocki wrote:

> Well, because you identified 56b991849 as the first bad commit, the
> following three lines of code in drivers/acpi/sleep.c are likely to be
> the source of the problem:
>
>         acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
>         acpi_ec_flush_work();
>         acpi_os_wait_events_complete(); /* synchronize Notify handling */

Huh- so this is encouraging- I've removed these lines, and while I haven't
been able to kill it yet (give me time :)) what DOES happen now is I get
wakeups from sleep on POWER events- charger connect (and disconnect)- and
now I wonder if this is somehow related to the issue of the suspend not
resuming if the machine is charging?

Are we masking out any events, perhaps?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

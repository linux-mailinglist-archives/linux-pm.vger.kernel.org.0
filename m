Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE9107E03
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2019 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfKWKYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Nov 2019 05:24:36 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:46612 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfKWKYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Nov 2019 05:24:36 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47KqD12j3MzlGL;
        Sat, 23 Nov 2019 05:24:33 -0500 (EST)
Date:   Sat, 23 Nov 2019 02:24:32 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 22 Nov 2019, Rafael J. Wysocki wrote:

> BTW, is the ec_no_wakeup=1 workaround still effective?

OK, I was wrong the first time, at least from the new Linus' tip (as of
merge commit 2027cabe6af anyway). So I did some testing, and I now have a matrix:

If "sleep_no_lps0" == 1, the machine never goes fully to sleep; the power
light stays on and the backlight goes off, but if I have external monitors
connected they're still showing dmesg activity. This is independent of the
state of "ec_no_wakeup".

If "ec_no_wakeup" == 1, the system *at times* will go to sleep and never return
(i.e. no power light comes on, it's totally unresponsive until I do a hard
reset with a power-button long-press) whether I'm plugged in or not.
This is new behavior.

If "ec_no_wakeup" == 0, the system goes fully to sleep and either of the
power button, lid opening or hitting a key resumes the laptop, but if I'm
plugged in and actually charging when I suspend (and I suspect if I plug
it in during suspend) it never returns, as in the case above.

Help! What can I do to return to the behavior of right before the s0 rework?

Where in the code could I start looking to try to find out where the machine
goes dead?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

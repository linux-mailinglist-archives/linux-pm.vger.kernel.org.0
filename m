Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFEAB707B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 03:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfISBXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 21:23:55 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:59246 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbfISBXv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 21:23:51 -0400
X-Greylist: delayed 1076 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 21:23:51 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 46YdvS179czDS7
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 21:05:56 -0400 (EDT)
Received: from [192.168.128.0] (71-136-136-204.lightspeed.sntcca.sbcglobal.net [71.136.136.204])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46YdvQ5NsLzv2C;
        Wed, 18 Sep 2019 21:05:54 -0400 (EDT)
Date:   Wed, 18 Sep 2019 18:05:53 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     rafael.j.wysocki@intel.com
cc:     linux-pm@vger.kernel.org
Subject: Help me help you debug what seems to be an EC resume issue
Message-ID: <alpine.DEB.2.21.1909181742470.2771@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


I have a 2019-era HP Spectre X360 13". I generally like it, but it's plagued
with "Modern Suspend" (s2idle) instead of a genuine S3, and as such I'm doing
whatever I (and you and Linux' PM) can to keep the power consumption down during
"suspend" (for now, "rfkill block all" before suspending, and removing the
XHC[I] as a wakeup source via "/proc/acpi/wakeup" during boot).

I bought one of those USB-C inline power meters and I can tell when the system
is burning more power than "normal" - on a full-charged battery during s2idle
it draws ~30-50 mA @ 20v, and if I see more than that I know something is amiss,
even though the laptop (and dmesg) think it's fully suspended.

I'm running the tip of Linus' tree as of now (b60fe990c6b07) and it's got
your latest PM/s2idle fixes in it. Before these commits, I used to set
"acpi.ec_no_wakeup=1" because the orientation sensor (at least, and probably
other things) would wake up the laptop (then immediately suspend), which
I'm sure was using up battery while I'm just walking around.

I've turned off "ec_no_wakeup" for testing and the good news is the orientation
sensor doesn't cause the laptop to draw more power when shaking it.

However:

- Randomly, it'll draw 250-300 mA when suspended, vs. the 30-50 mA
- Randomly, if left suspended, nothing other than a hard power off will get
  it back (and I can't be sure, but I think current consumption can be normal
  when it suspends, but this seems to only happen if I've unplugged the
  charger after suspending (so no power meter)).

I have pstore set up to catch BUG_*/oopses and save them away on boots, but
nothing comes thru, so I'm guessing it's just hanging somewhere either on
suspend or resume.

What can I do to diagnose where it's getting hung up? It appears my normal
"ec_no_wakeup=1" case has no such issues, but I wouldn't mind being able to
resume via the lid switch again.

Thanks,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

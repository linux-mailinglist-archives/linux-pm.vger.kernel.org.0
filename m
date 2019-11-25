Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B30109486
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKYULS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 15:11:18 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:59828 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYULR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 15:11:17 -0500
Received: from hp-x360n (50-76-61-131-ip-static.hfc.comcastbusiness.net [50.76.61.131])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MJ81483Mz1nFh;
        Mon, 25 Nov 2019 15:11:13 -0500 (EST)
Date:   Mon, 25 Nov 2019 12:11:12 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
Message-ID: <alpine.DEB.2.21.1911251155440.2817@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 25 Nov 2019, Kenneth R. Crudup wrote:

> I'll keep testing it (and the best way to get something to break is to
> proclaim it's "fixed" :)

... grumble ...!

So, put the laptop to sleep, put it in my bag[1], then head off to go work.
Get to where I'm working, plug in the power meter, it's now drawing 150mA
while idle ...  uh oh. Sure enough, open the lid, hit some keys, dead. Had
to do a long- power-button reset to get it back up again. I note that it's
now charging (I may not have allowed the battery to drain enough for the
charging circuit think the battery's discharged enough to begin a charge
cycle before).

I'm going to go back to the original patch (the three removed lines) for now
(which may not do any better long-term, but I'll have to at least try.

[1] - I can let it sit idle at home and it'll be OK, but when I put it in
my bag and go somewhere it always seems to be the trigger for failed resumes
I have no idea why.

BTW, what was different about your 2nd patch (the addition of acpi_s2idle_sync()
to the resume cycle) was I was getting WMI power events captured during
resume in the EC blocked/unblocked path, which hadn't happened before:

-----
Nov 25 10:16:56 hp-x360n kernel: [ 4418.792164] PM: suspend entry (s2idle)
Nov 25 10:16:56 hp-x360n kernel: [ 4418.801869] Filesystems sync: 0.009 seconds
Nov 25 10:17:29 hp-x360n kernel: [ 4418.802615] Freezing user space processes ... (elapsed 0.002 seconds) done.
Nov 25 10:17:29 hp-x360n kernel: [ 4418.805200] OOM killer disabled.
Nov 25 10:17:29 hp-x360n kernel: [ 4418.805201] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
Nov 25 10:17:29 hp-x360n kernel: [ 4418.806127] printk: Suspending console(s) (use no_console_suspend to debug)
Nov 25 10:17:29 hp-x360n kernel: [ 4418.817183] [drm] GuC communication disabled
Nov 25 10:17:29 hp-x360n kernel: [ 4419.296506] ACPI: EC: interrupt blocked
*** Nov 25 10:17:29 hp-x360n kernel: [ 4440.111494] hp_wmi_notify(): event_id 0x20001, event_data 0x00000000
*** Nov 25 10:17:29 hp-x360n kernel: [ 4440.111496] hp_wmi: Unknown event_id - 131073 - 0x0
*** Nov 25 10:17:29 hp-x360n kernel: [ 4440.198013] hp_wmi_notify(): event_id 0x03, event_data 0x00000000
Nov 25 10:17:29 hp-x360n kernel: [ 4449.527844] ACPI: EC: interrupt unblocked
Nov 25 10:17:29 hp-x360n kernel: [ 4451.118846] intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)
Nov 25 10:17:29 hp-x360n kernel: [ 4451.126383] usb usb3: root hub lost power or was reset
Nov 25 10:17:29 hp-x360n kernel: [ 4451.126384] usb usb4: root hub lost power or was reset
Nov 25 10:17:29 hp-x360n kernel: [ 4451.127298] [drm] GuC communication enabled
Nov 25 10:17:29 hp-x360n kernel: [ 4451.127400] i915 0000:00:02.0: GuC firmware i915/kbl_guc_33.0.0.bin version 33.0 subm
ission:disabled
Nov 25 10:17:29 hp-x360n kernel: [ 4451.127401] i915 0000:00:02.0: HuC firmware i915/kbl_huc_ver02_00_1810.bin version 2.
0 authenticated:yes
Nov 25 10:17:29 hp-x360n kernel: [ 4452.229576] OOM killer enabled.
Nov 25 10:17:29 hp-x360n kernel: [ 4452.229577] Restarting tasks ... done.
Nov 25 10:17:29 hp-x360n auto-rotate[15448]: normal
Nov 25 10:17:29 hp-x360n kernel: [ 4452.256340] thermal thermal_zone7: failed to read out thermal zone (-61)
Nov 25 10:17:29 hp-x360n systemd-udevd[18777]: Process '/usr/sbin/tlp auto' failed with exit code 4.
Nov 25 10:17:29 hp-x360n systemd-udevd[18777]: Process '/usr/sbin/tlp auto' failed with exit code 4.
Nov 25 10:17:29 hp-x360n systemd-sleep[18673]: System resumed.
Nov 25 10:17:29 hp-x360n kernel: [ 4452.313345] PM: suspend exit
----

(best I can tell, event_id 0x20001 is a charger unplug event and event_id 0x03 is a charger plug event).

BTW, is ther any way to determine if this is an issue with some other driver? I'd think I'd be getting BUG_ON()s
if that were it, though.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

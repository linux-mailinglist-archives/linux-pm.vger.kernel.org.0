Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA225686B
	for <lists+linux-pm@lfdr.de>; Sat, 29 Aug 2020 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgH2OvN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 29 Aug 2020 10:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2OvM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Aug 2020 10:51:12 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] New: CPU stuck at 800 MHz at any load
Date:   Sat, 29 Aug 2020 14:51:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tg@gmplib.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-209069-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209069

            Bug ID: 209069
           Summary: CPU stuck at 800 MHz at any load
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.8.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: tg@gmplib.org
        Regression: No

Environment 1:
  OS:     GNU/Linux/Xen Gentoo 17.1 (ker=5.8.5 xen=4.12.3)
  mbd:    Supermicro X10SLH-F-O S1150 µATX (BIOS 3.3 2020-06-13)
  cpu:    Intel HWL X4 3600MHz (Xeon E3-1271v3, ECC)
  memory: 8192MB SDRAM DDR3L-1600 ECC (Samsung M391B1G73QH0-YK0Q)
  memory: 8192MB SDRAM DDR3L-1600 ECC (Samsung M391B1G73QH0-YK0Q)
  memory: 8192MB SDRAM DDR3L-1600 ECC (Samsung M391B1G73QH0-YK0Q)
  memory: 8192MB SDRAM DDR3L-1600 ECC (Samsung M391B1G73QH0-YK0Q)
  disk:   SATA SSD 2.5" 120GB Samsung SM863
  case:   Supermicro CSE-510T-203B

Environment 2. Almost identical, but with this cpu:
  cpu:    Intel BWL X4 3400MHz LLC=6M+128M (Xeon E3-1285Lv4)

I upgraded from 5.4.48 to 5.8.x for various versions of x to finally reach x =
5. Now, the systems get stuck at what is displayed as 800 MHz in /proc/cpuinfo.

When booted to run Xen, the problem goes away. When booting the (Xen
Dom0-capable) kernel without Xen, the clock gets stuck at 800 MHz at any load.

It's certainly not just a problem with /proc/cpuinfo's displayed frequency; the
systems are really, really sluggish.

A similarly configured Skylake system does NOT exhibit the same problem. (The
motherboard of that system is Supermicro X11SSM.) Similarly configured Sandy
Bridge and Westmere systems also do not exhibit this problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.

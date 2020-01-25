Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7ED149840
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jan 2020 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAYXjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 25 Jan 2020 18:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAYXjy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Jan 2020 18:39:54 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 206307] New: AMD Ryzen CPU frequency monitoring subsystem is
 insufficient
Date:   Sat, 25 Jan 2020 23:39:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206307-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206307

            Bug ID: 206307
           Summary: AMD Ryzen CPU frequency monitoring subsystem is
                    insufficient
           Product: Power Management
           Version: 2.5
    Kernel Version: All
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

These are the features which are available under Windows but not possible under
Linux in any shape or form:

1) You cannot set the desired CPU frequency except for predefined values (in my
case 3600000 2800000 2200000Hz). In Windows you can set any desired frequency
between base and boost.

2) time_in_state is extremely coarse and shows neither boost, nor CPU sleep. At
least with Intel CPUs there's an additional CPU frequency MAX + 100KHz which
indicates boost. There's no such thing for AMD Ryzen CPUs.

3) Reported frequencies values in /proc/cpuinfo and
/sys/devices/system/cpu/cpufreq/policy*/cpuinfo_cur_freq are again limited to
the predefined values.

/cpu/cpufreq/policy*/scaling_cur_freq contains a lot more varied values but
again, CPU sleeping or boosting are not reported.

-- 
You are receiving this mail because:
You are the assignee for the bug.

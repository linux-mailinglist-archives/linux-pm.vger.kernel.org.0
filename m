Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD515C3B0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 16:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgBMPng convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 Feb 2020 10:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgBMP1x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:53 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 206517] New: scaling_cur_freq very different from
 cpuinfo_cur_freq on Acer Predator Helios 500 PH517-61-R0GX
Date:   Thu, 13 Feb 2020 15:27:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bero@lindev.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206517-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206517

            Bug ID: 206517
           Summary: scaling_cur_freq very different from cpuinfo_cur_freq
                    on Acer Predator Helios 500 PH517-61-R0GX
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.5.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: bero@lindev.ch
        Regression: No

On an Acer Predator Helios 500 PH517-61-R0GX, scaling_cur_freq values can vary
greatly from cpuinfo_cur_freq:

$ sudo cat /sys/devices/system/cpu/*/cpufreq/cpuinfo_cur_freq
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
3200000
$ cat /sys/devices/system/cpu/*/cpufreq/scaling_cur_freq 
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955
548955

Unfortunately, the performance I'm seeing on this box while compiling stuff
makes me think scaling_cur_freq is reporting correctly and cpuinfo_cur_freq is
telling lies.

This might be related to bug 203035

-- 
You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB415D356
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgBNICs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 14 Feb 2020 03:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgBNICs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Feb 2020 03:02:48 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 206517] scaling_cur_freq very different from cpuinfo_cur_freq
 on Acer Predator Helios 500 PH517-61-R0GX
Date:   Fri, 14 Feb 2020 08:02:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: trenn@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-206517-137361-xlq1JVTple@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206517-137361@https.bugzilla.kernel.org/>
References: <bug-206517-137361@https.bugzilla.kernel.org/>
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

Thomas Renninger (trenn@suse.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |trenn@suse.de

--- Comment #1 from Thomas Renninger (trenn@suse.de) ---
Best use:
cpupower monitor

You can also measure workloads, e.g. when compiling something:

cpupower monitor make

Not sure what distro you are using and what the name of the package or whether
cpupower is packaged there... The sources, even it's userspace is part of the
kernel git repo:
tools/power/cpupower

-- 
You are receiving this mail because:
You are the assignee for the bug.

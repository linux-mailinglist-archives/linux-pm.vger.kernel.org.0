Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21D31C4FC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 02:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBPBlx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 20:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPBlw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 20:41:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D67964DCF
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613439672;
        bh=wVBso4+bjcI4u2tSV/0JIRsTrgCESTFNWplCfSLzLZg=;
        h=From:To:Subject:Date:From;
        b=K5S+mSdh1JhWqBct9B1IMVBCtZaPgoBYXqFjwC6k5JNpuys0GWr4xCesCoUH2RscQ
         l+3Iy9jW5m/nQ7yJQ379Wh10HckpiJCbznoM9whwuY6JXEOdzfLVpKxRrYp+WRyHA0
         uEKVqrLO1Zfd2vLlyxSuztZfRY0LHa6xlR++G5SRXy+xBPkt5iYMYfxLIYKEB+DePU
         NAj5Ucqn5ytnRqiztG0LanyGe/ldbLW766E0olLMlE+0nECfWXZTzu1M18KsBvZ8nP
         Iw/JZNhsqLJYuZUiOkUk3X7eLVefXtLHLf5bs3gdEbSXHW2y1TXD00lqsKbZqnGNIn
         WbHMM3tKvt9Ew==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3D200653BC; Tue, 16 Feb 2021 01:41:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211791] New: AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Date:   Tue, 16 Feb 2021 01:41:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: me@rin.cat
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-211791-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211791

            Bug ID: 211791
           Summary: AMD CPU /proc/cpuinfo reported max potential boost
                    frequency instead of actual operating frequency
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.11.0
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: me@rin.cat
        Regression: No

Created attachment 295305
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295305&action=3Dedit
/proc/cpuinfo log

Overview:
    The /proc/cpuinfo reported wrong operating frequency, where my AMD 3900X
shows over 6 GHz when idle.
    This may be caused by the 5.11 AMD CPU frequency / CPPC fix.

Steps to Reproduce:=20
    cat /proc/cpuinfo
    or
    lscpu

Actual Results:
    Reported operating frequency far beyond actual. (Over 6 GHz)

Expected Results:
    Reported actual operating frequency.

Build Date & Hardware:
    Build 2021-02-15 on Gentoo
    CPU: AMD Ryzen 9 3900X 12-Core Processor
    AMD AGESA: ComboAM4PIV2 1.2.0.0
    CPPC: enabled

Additional Information:
    /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq reported correct
frequency.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

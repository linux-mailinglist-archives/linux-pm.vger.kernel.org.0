Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E892E9F3E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 22:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbhADVCZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 4 Jan 2021 16:02:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhADVCY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 16:02:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 67146216C4
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 21:01:44 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5CFAA82574; Mon,  4 Jan 2021 21:01:44 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Mon, 04 Jan 2021 21:01:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: currojerez@riseup.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210993-137361-OpwQMZByhM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210993-137361@https.bugzilla.kernel.org/>
References: <bug-210993-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210993

Francisco Jerez (currojerez@riseup.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |currojerez@riseup.net

--- Comment #5 from Francisco Jerez (currojerez@riseup.net) ---
O_o, that's really weird.  I guess this could also be some sort of
electromagnetic interference (E.g. with your soundcard?  Does the problem occur
with the loudspeakers turned off?), or an issue with your PSU.

The apparent frequency dropping below scaling_min_freq might be an artifact of
how the busy frequency of a CPU thread is calculated: It should approximate the
ratio of executed clock cycles to the time it spent in C0 state, which can
deviate from its actual working frequency if the processor enters and exits
some C1+ state repeatedly since the transition may have some significant
latency.  According to your turbostat log the CPU cores that report a busy
frequency below scaling_min_freq seem to be handling quite a few interrupts
which is consistent with that explanation.  It doesn't necessarily indicate a
power management bug.

Does disabling some specific idle state (e.g via
/sys/devices/system/cpu/cpu*/cpuidle/state*/disable) have any effect on the
noise?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

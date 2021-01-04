Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD22EA0A6
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 00:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbhADXUw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 4 Jan 2021 18:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADXUw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 18:20:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B07F52253D
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 23:20:11 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9EA5C808E2; Mon,  4 Jan 2021 23:20:11 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Mon, 04 Jan 2021 23:20:11 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210993-137361-OTofshG0eM@https.bugzilla.kernel.org/>
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

--- Comment #7 from Francisco Jerez (currojerez@riseup.net) ---
(In reply to Karol Herbst from comment #6)
>
> > Does disabling some specific idle state (e.g via
> > /sys/devices/system/cpu/cpu*/cpuidle/state*/disable) have any effect on the
> > noise?
> 
> disabling all except state0 stops the noise.

Ah that makes sense, that sounds like the culprit might be a noisy power supply
coupled to the oscillation of the processor's current draw caused by repeated
C-state transitions.  If that's the case you may be able to tweak the latency
parameters to make sure the oscillation frequency is outside the audible range,
though I'm not sure if it would make sense to upstream such a change since it
will likely come at an energy cost (Though I would expect the cost to be minor
as long as the processor can still reach the deepest sleep state in the steady
state while idle, might be a good trade-off in your specific case if this is
particularly annoying to you).

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

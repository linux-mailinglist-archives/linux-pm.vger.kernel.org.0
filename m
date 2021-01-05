Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6C22EA644
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 09:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbhAEIB2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 5 Jan 2021 03:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbhAEIB2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Jan 2021 03:01:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2354822582
        for <linux-pm@vger.kernel.org>; Tue,  5 Jan 2021 08:00:48 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1F415816C5; Tue,  5 Jan 2021 08:00:48 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Tue, 05 Jan 2021 08:00:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: karolherbst@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210993-137361-g2w3R7IjlF@https.bugzilla.kernel.org/>
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

--- Comment #9 from Karol Herbst (karolherbst@gmail.com) ---
(In reply to Zhang Rui from comment #8)
> (In reply to Karol Herbst from comment #3)
> > Created attachment 294493 [details]
> > turbostat output
> > 
> > first three data sets are "idle", next two are finger on the touchpad, last
> > ones are "idle" again.
> > 
> > min clock set to 2.4GHz
> 
> "Sadly the scaling_min_freq property is ignored outright and only matters as
> long as the CPU stays idle, but as long as one core gets some load, another
> one drops below scaling_min_freq"
> 
> I didn't observe this from the turbostat output attached, because the system
> is idle.
> Can you please attach the turbostat output when the cpu frequency drops
> below scaling_min_freq?

it does in the output, just only one core per entry, and then only in the
entries in the middle.

e.g. line 122

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

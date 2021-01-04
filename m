Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6E2E9E6B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbhADT6m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 4 Jan 2021 14:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADT6m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 14:58:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 53B3321919
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 19:58:01 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 40069816C5; Mon,  4 Jan 2021 19:58:01 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Mon, 04 Jan 2021 19:58:01 +0000
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
Message-ID: <bug-210993-137361-waUS9FSkuF@https.bugzilla.kernel.org/>
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

--- Comment #4 from Karol Herbst (karolherbst@gmail.com) ---
(In reply to Zhang Rui from comment #2)
> (In reply to Karol Herbst from comment #0)
> > One thing I noticed with my i7-10850H CPU is, that if there are cores with
> > huge differences in their frequencies (e.g. one at 900 MHz another at 4.9
> > GHz) some electrical becomes noticable.
> > 
> > The noise can be reduced by limiting the available range the CPUs frequency
> > can be scaled to. Sadly the scaling_min_freq property is ignored outright
> > and only matters as long as the CPU stays idle, but as long as one core
> gets
> > some load, another one drops below scaling_min_freq, so I couldn't test if
> > limiting the lower bound even helps.
> 
> Usually, if we didn't take Pe into account, the CPU frequency should not
> drop below scaling_min_freq. This sounds like a bug to me.
> please give turbostat output when this happens.
> 
> > 
> > Putting one core at max load with stress -c 1 effectively eliminates all
> > noise.
> 
> please give turbostat output when this happens.
> 

attached below.

> > 
> > This issue is even more annoying on my laptop as it generally runs with the
> > fans turned off.
> > 
> > intel_pstate is used in active mode, but putting it in passive mode,
> > disabling HWP or even using the ACPI freq scaling didn't really change
> > anything in this regard. The powersave governor and default
> > energy_performance_preference is used.
> > 
> > Is there anything else which could be done to mitigate the problem? Just
> > putting a finger on the touchpad makes the noise quite noticeable as cores
> > get scaled to the max.
> > 
> I'd prefer this is the fan noise rather than CPU electrical noise.

Well, the fans are off, so it has to be something else. It might be something
related to the CPU, but the noise it noticeable and doesn't sound like a fan at
all.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

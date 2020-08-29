Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD22569A1
	for <lists+linux-pm@lfdr.de>; Sat, 29 Aug 2020 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgH2SHn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 29 Aug 2020 14:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgH2SHm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Aug 2020 14:07:42 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load
Date:   Sat, 29 Aug 2020 18:07:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209069-137361-2QXh3OE3UC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209069-137361@https.bugzilla.kernel.org/>
References: <bug-209069-137361@https.bugzilla.kernel.org/>
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

--- Comment #7 from Torbjörn Granlund (tg@gmplib.org) ---
bugzilla-daemon@bugzilla.kernel.org writes:

  intel_cpufreq CPU frequency driver (intel_pstate in passive mode), userspace
  governor with a setspeed of 0.8GHz. So, you are getting what you asked for.

I will gladly confess my ignorance about this.

But...I've maintained these systems for a long time, and gradually upgraded
the kernels (as well as the user space).  The CPU_FREQ_GOV_USERSPACE
setting was inherited from some old default, and indeed is used by many
older kernels.

Only 5.8.x suddenly make Haswell and Broadwell run at 800 MHz.  Skylake is
not affected by this at all.  With 5.4.x, the systems run at their nominal
frequencies.

If this is a desired change in kernel behaviour, then many people might
see their systems slow down radically.

-- 
You are receiving this mail because:
You are the assignee for the bug.

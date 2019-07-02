Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C55D9AD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 02:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGCAuc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 2 Jul 2019 20:50:32 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:58154 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbfGCAub (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 20:50:31 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7F9C82897C
        for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2019 22:21:56 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7370D26E47; Tue,  2 Jul 2019 22:21:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 120561] powernow_k8 causes kernel panic during block device
 write access
Date:   Tue, 02 Jul 2019 22:21:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kr@sognnes.no
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-120561-137361-0AcZvXB5la@https.bugzilla.kernel.org/>
In-Reply-To: <bug-120561-137361@https.bugzilla.kernel.org/>
References: <bug-120561-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=120561

kr@sognnes.no changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #3 from kr@sognnes.no ---
It seems this bug was caused by the kernel misidentifying the number of
available PowerNow states on certain AMD CPUs, and was thus very CPU-specific. 

As of right now, none of the currently supported kernels (4.4.184, 4.9.184,
4.14.131, 4.19.56, and 5.1.15) have any issues with the particular AMD CPU on
the system that originally exhibited the problem.

The newer kernels all report significantly fewer power states, and the ondemand
governor can now be enabled without issue.

-- 
You are receiving this mail because:
You are the assignee for the bug.

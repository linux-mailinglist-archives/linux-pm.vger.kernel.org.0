Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0D2FDE72
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 02:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbhAUBF5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 20 Jan 2021 20:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391919AbhAUBDn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 20:03:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E4C7C23787
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 01:03:02 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CF3FF80950; Thu, 21 Jan 2021 01:03:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Thu, 21 Jan 2021 01:03:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ggherdovich@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-211305-137361-YAzU7eGWyi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211305-137361@https.bugzilla.kernel.org/>
References: <bug-211305-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211305

--- Comment #4 from Giovanni Gherdovich (ggherdovich@suse.cz) ---
Created attachment 294797
  --> https://bugzilla.kernel.org/attachment.cgi?id=294797&action=edit
plot of PELT root runqueues utilization

The PELT utilization for root runqueues of the bad kernel is half what was on
the good kernel (~450 vs ~825).

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

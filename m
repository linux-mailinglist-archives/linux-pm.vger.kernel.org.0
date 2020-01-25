Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C732149843
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jan 2020 00:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAYXxE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 25 Jan 2020 18:53:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgAYXxE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Jan 2020 18:53:04 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 206307] AMD Ryzen CPU frequency monitoring subsystem is
 insufficient
Date:   Sat, 25 Jan 2020 23:53:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206307-137361-O6U6ig5eAe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206307-137361@https.bugzilla.kernel.org/>
References: <bug-206307-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206307

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
I really don't know who to CC to this bug report, so I'd be glad if you could
CC the relevant people.

I am perfectly aware that Ryzen CPUs can change their frequency millions of
times per seconds. I hope that still allows to aggregate data and manage the
CPU the way we want (and the way it's already possible under Windows).

-- 
You are receiving this mail because:
You are the assignee for the bug.

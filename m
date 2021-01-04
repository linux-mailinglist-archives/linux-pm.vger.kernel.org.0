Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB192E9E5E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbhADTzZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 4 Jan 2021 14:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbhADTzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 14:55:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D1DCA21919
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 19:54:44 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C35F6808E2; Mon,  4 Jan 2021 19:54:44 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Mon, 04 Jan 2021 19:54:44 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-210993-137361-73gdaCchyc@https.bugzilla.kernel.org/>
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

--- Comment #3 from Karol Herbst (karolherbst@gmail.com) ---
Created attachment 294493
  --> https://bugzilla.kernel.org/attachment.cgi?id=294493&action=edit
turbostat output

first three data sets are "idle", next two are finger on the touchpad, last
ones are "idle" again.

min clock set to 2.4GHz

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

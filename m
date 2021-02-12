Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971E331A522
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhBLTNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 14:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhBLTNS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Feb 2021 14:13:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AD92164EA6
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613157157;
        bh=pmCnfVzgDr1ZbVZwyzApc1KNBAHVQ2uyUY1kkMaiciw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QC2byF9kOE3dVLYwGNbAxp385Nu8Rq8gqTrbj1wnQ46Ryu/g8gXICuCvFbimt9faF
         krb+u2YCkXdB1SDIKjvNpFbxTdnDn9G+g/jedOIbGWAOfob1UEmJD6pa0Rn7NLbkSh
         /kh3HKF6ZNa/pQnjX31Me8Vs/3NqPLdqKrc0QW86dKwFcg9x+L8CcWcyOWYbUimBw9
         JVjnIQRm9Zwev9jG2GMqyboOA5N5OfnExtsADRkfmn4c8OZ22Qm4U/gJ5vo2W1YdP1
         +2IE4g6qS5+k5Dt3Eu/sS15FRaPQQ5svBLffR1TjQHsmBT/99gpyVVP+V92whnpnR6
         6pn0cP1Lqh1uA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9EDD66535C; Fri, 12 Feb 2021 19:12:37 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Fri, 12 Feb 2021 19:12:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjw@rjwysocki.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-211305-137361-D09EeFlSnU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211305-137361@https.bugzilla.kernel.org/>
References: <bug-211305-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211305

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rjw@rjwysocki.net

--- Comment #8 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
Created attachment 295255
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295255&action=3Dedit
cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known

Attached is a tentative fix on top of commit 3c55e94c0ade ("cpufreq: ACPI:
Extend frequency tables to cover boost frequencies").

Please give it a go and report back.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3B31BCB8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 16:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhBOPd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 10:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhBOPdE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 10:33:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 21CD864EAE
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613403033;
        bh=dFgCQ7SX+Jrs9VI1Oud3a1xiN+oJDr1OplN0pr44898=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dTVqF4P7CgMe+gzx18FnFUqKnj3QK6TJmJ5OodDFIASuRapGGnYn77qeU+S++4Wzy
         mkwbdn+sRRTn8chrix8GYd0cuM9j6MMJkU+eOrqBfcvMpKzKZXjbTa6jBTJGx4RCph
         JUtoRzbcxzKnGf28JNqI1gC3HMDZo9LU9/+6+yZ1nVOsIrIc5VeNub77Xoa7sgJjrF
         7unEqwIpmX4KgFOObv+AAr6ZHTx8xY95gvQM9/C/AF996Y8No7BoTUT71EtXcOsbPA
         9KYrljmDgoCDfix+OyV2UB8fx4SEX7nq/OPwQurcw4P8IWYwSenFEh4LXfbH16Sq/G
         FZlSALuL/SxAA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 098B260180; Mon, 15 Feb 2021 15:30:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 15:30:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjw@rjwysocki.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-211305-137361-ksch1E5Y69@https.bugzilla.kernel.org/>
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
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #18 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
OK, thanks for testing!

Let me post the last patch for verification.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

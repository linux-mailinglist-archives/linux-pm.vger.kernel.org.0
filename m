Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D967D31BA9E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhBONz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 08:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBONz0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 08:55:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 07843600CF
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613397286;
        bh=bUmuTpqhwJQLbKtvDwwp+AjJMA/5G8JQ0780TpmRa50=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NC8FtGfrNUSVjHrOJwjjWmhzNsL2GYYTYBsUqSM23rlsa71/uLitnq/DiAZnXVpIR
         Sv/FVanAXW/ilAHYqJ4KGWYIlQ1hKYNM2Jr2ocpm3VAXEsskB98/d/0mn2WYvpRwWo
         S/BaWimrfV+HSAo6zUSwxCXhm4olRvfLF/vY0raPmv717ar9QAGsEFbDAARndUK3gx
         5tvWOE0hyb/wPQxcIxF5XUfu/vZF4/3A2w1o/X9S1UFiotVeX0+WrcIu0WwelX2XiY
         ymg5wBQUZXYvgjG3m1XK2lGgPxsVMwTgjUVtXGRQoa4UCy941rMnOGBSKx5ydBTpeX
         reoqDjL1nbFlQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EF73E60249; Mon, 15 Feb 2021 13:54:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 13:54:45 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-nuKM0T3Af0@https.bugzilla.kernel.org/>
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

--- Comment #13 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
(In reply to Matt McDonald from comment #11)
> Oh, I can also add that the previous patch that was turned down and repla=
ced
> with this patchset doesn't cause this issue, cpu frequency and frequency
> reporting work as expected with that patch, and I'm able to boost up to
> 4750MHz under full load and 5GHz under single-core load.

So what do you see in /proc/cpuinfo and scaling_cur_freq with commits
3c55e94c0ade and d11a1d08a082 reverted?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

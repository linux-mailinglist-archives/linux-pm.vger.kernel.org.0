Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26EB31A474
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 19:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhBLSUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 13:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhBLSUV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Feb 2021 13:20:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E15164E9A
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613153981;
        bh=nS+EBZ3b9rAC+u5eF/cqX/glse2QcQCoJ8/1EXQUum8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OGRhOJzbVUKVYf/Ffkhrr3rizKQZlgTuYyA5D914owbszeeJA1bT3comgQRcrinK3
         8yPvFogxYBsvW1qGpOpRWN8C9VpWYWb+vYKKWzzw1qXqs52meFAIiYwljUr61yceEl
         XgriXCR1x8xbnIV2JsKabcxbM6j0ayTegwtub40ZOd4+hCdZbWxtG+YodNnU1wMbyH
         b9+DORduLdOASVz5+ZYmeCp5A2DTkToKNa7PDnKnYh0kEx1Ao83dOQxF5NCZEIFKQ2
         08jzREL9iR+BI6bqduot/fZYituYX7U/fLISwZ0JJrFoVuYSomQ2GWu57qFd1ZrjEd
         gn+xQKSfAgW8Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 425176535E; Fri, 12 Feb 2021 18:19:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Fri, 12 Feb 2021 18:19:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rafael@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-BtumZX0djC@https.bugzilla.kernel.org/>
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

--- Comment #7 from rafael@kernel.org ---
On Fri, Feb 12, 2021 at 6:29 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D211305
>
> Matt McDonald (gardotd426@gmail.com) changed:
>
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |gardotd426@gmail.com
>
> --- Comment #6 from Matt McDonald (gardotd426@gmail.com) ---
> So, the replacement patch from Rafael causes Zen 3 frequency reporting to=
 be
> ALL jacked up.
>
> Before the patch, core frequencies in /proc/cpuinfo as well as using tools
> like
> nmon seemed accurate. After testing Rafael's patch, my core frequencies a=
re
> all
> up around 6 GHz (!), and even external tools like Geekbench report my 580=
0X's
> BASE clock as 6.0 GHz (https://browser.geekbench.com/v5/cpu/6466982)
>
> I'm sure this isn't intended behavior.

If the reported frequencies are like that all the time, then it isn't.

What is there in scaling_cur_freq in sysfs if the system is idle?

> The patch was merged like yesterday into
> the mainline kernel, so should I file an actual bug report?

It doesn't particularly matter, because I have seen this comment from you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

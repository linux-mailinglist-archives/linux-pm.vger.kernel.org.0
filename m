Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6573D31A39D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 18:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhBLR3Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 12:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhBLR3T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Feb 2021 12:29:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8315064E6C
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613150919;
        bh=GeVGFXphTTdLby8zpPMKj4QkRqCUC4u5uxfU70HRzog=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eDqfwS7yScoeQO0QiC/ESgh7n58JcuO63ra3I+xB8CkU+o9Za9bC06viGfIft2dYX
         sGoAXeSoFZyFd6wIaYpKI3LsUpmHJt9a3Z/FpokcbiccV3Vl0F2LXEW47hCeNFesqB
         W8cwSVfWQ61qp+5UTXvVgDlJFYZ6w9gW/r0gpeheL/cFWmLQQIqz7lsSThc4s559MX
         ugKaVryRU/Qu3rK04IUDuGHQwK6olZF+DxezzRnZl1C+Bii7QhVFMYQnFC8+0dahIb
         IhXzzVEiLADZpSawRBocW8VkxEo+4Un8XY0fIzWWe8KMzypmfLGuz+aRiaaUlwL1Hj
         0B+MpvPTVNJvA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 741EC6532D; Fri, 12 Feb 2021 17:28:39 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Fri, 12 Feb 2021 17:28:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gardotd426@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211305-137361-xxZGwJzw8e@https.bugzilla.kernel.org/>
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

Matt McDonald (gardotd426@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gardotd426@gmail.com

--- Comment #6 from Matt McDonald (gardotd426@gmail.com) ---
So, the replacement patch from Rafael causes Zen 3 frequency reporting to be
ALL jacked up.=20

Before the patch, core frequencies in /proc/cpuinfo as well as using tools =
like
nmon seemed accurate. After testing Rafael's patch, my core frequencies are=
 all
up around 6 GHz (!), and even external tools like Geekbench report my 5800X=
's
BASE clock as 6.0 GHz (https://browser.geekbench.com/v5/cpu/6466982)

I'm sure this isn't intended behavior. The patch was merged like yesterday =
into
the mainline kernel, so should I file an actual bug report?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

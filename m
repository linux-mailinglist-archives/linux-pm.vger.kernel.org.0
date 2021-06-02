Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8431E3980C3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 07:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFBFr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 01:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhFBFr1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Jun 2021 01:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EF01161360
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 05:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622612745;
        bh=2O4I5eXlkd+r1+sTSA00V63BfXGb5wOyr3ZT6R7hWFQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EJZd9qwhooCxBMcTs37hQOTkxokc4ZkbDaAHClQsKVL2uM6UC6ZSQk7ZiHCymYjeU
         Mj4n/bSDHFVm67NHS4onL1eP2BDzli27lmvUoUgHhsL8lCCFeYZo9qr90RwcgNScXp
         ikhWAH92LMH5DA9TEYPT5P/1kmUbat61TLtpWkATEqm+3cr8+7QK2pGpReVphOlBbK
         2Vr5EIHneq9gf4l39wyTbbSPMDuF9iILqhW8dp6+382ImU2V/CEUguVOte8GNxgvbw
         WM1cG1XK+Sit+YD9sFc140BV21oDH6+6bjc6dJ2FpP3IDjS9EEVuWus4oVt75RpJ8A
         uugbn4IeCszfA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E22BE611AB; Wed,  2 Jun 2021 05:45:44 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Wed, 02 Jun 2021 05:45:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: intel_pstate
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210993-137361-IEqMREexhK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210993-137361@https.bugzilla.kernel.org/>
References: <bug-210993-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210993

--- Comment #11 from Zhang Rui (rui.zhang@intel.com) ---
We haven't done such things in kernel before.
Compared with the noise, the frequency/performance is one of the indicators
that many people care about and are always measuring/monitoring.

For people who has a strong requirement of limited noise, they can use the =
tips
you mentioned above.

As this is not a software bug, I tends to close it.
What do you think?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

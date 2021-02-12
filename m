Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99B731A735
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 23:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBLWAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 17:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBLWAl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Feb 2021 17:00:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 325B364E95
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613167201;
        bh=t9/PRQVTzndHB4OB7AbzU3BTJodpN5Ech+eAPAIAp4o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HnLTL4SLiEZyQ2IqBlA7qYb8RZysTzjwOg/Ui+681fXxTBgyKRyP0PV06C9wtVgnv
         d4mYcBs5T96nmu7BIyg8BmDbwdAthMLEnUlBSTov8PFg82bsU6orf0Eu3Yj9fEuGsX
         4EwohAXbI3Lxmmcd30lPGJdZRUsCDfExy9jyKNsLxtCD1KAcF3tZPm8C8iUGHtlckU
         9gTXn+XzxFYJB9oSxDf1rJIK4HRqcLwULgCzmlPgWOTjEO7rQduXDCyJXp57FqKaMW
         3Cpi0LzME/JVprqDD19MmQ35lGnFfCDomThitar/ssOyGy9LFCWAuzi3Wp4lvnYGWK
         lo0kVxOQ5DGDA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 258D66532D; Fri, 12 Feb 2021 22:00:01 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Fri, 12 Feb 2021 22:00:00 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-NeU87X4D09@https.bugzilla.kernel.org/>
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

--- Comment #11 from Matt McDonald (gardotd426@gmail.com) ---
Oh, I can also add that the previous patch that was turned down and replaced
with this patchset doesn't cause this issue, cpu frequency and frequency
reporting work as expected with that patch, and I'm able to boost up to 475=
0MHz
under full load and 5GHz under single-core load.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

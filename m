Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779B731A625
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBLUk0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 15:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhBLUk0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Feb 2021 15:40:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8657F64E01
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613162385;
        bh=Q8hVgRcLeMRBWn3864+7NfX8G2z8Y58rzs6uN34WOgA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X3ZZYq4Mnk9jMXohZmfrktBiazYFjo79uAh9b/9J3ujU033BusJqeC+wTPPXgcg97
         fVcSn2QYjgT7sH8qRilD17fpfEvmKhBd6jF+HexzBsuWK5/uWIlYcyD2NJazMxhV9z
         E3iGiqIK7OUZXnNL/LGp16Fu5/NEdoSU9c1y2tjNEmfbEho4pEM7DPf3+IVwCnZ9KS
         rutEiOZOmv24ZmjX0fzD5TEZ+094GgMwl2tEr8XlOMP/fCbgUlXw9q6B0RtThFg4GT
         t6acrJZAnknH4nvVuzirurw7pkQ65x80uGgvq9H6OpK2LBGpLl+WBD1JRcz23XcVd0
         i9SiEQMCpxeIw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 71F736532D; Fri, 12 Feb 2021 20:39:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Fri, 12 Feb 2021 20:39:45 +0000
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
Message-ID: <bug-211305-137361-6cba3lSw8Z@https.bugzilla.kernel.org/>
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

--- Comment #9 from Matt McDonald (gardotd426@gmail.com) ---
Comment on attachment 295255
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295255
cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known

Yeah sure thing, I'm building now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

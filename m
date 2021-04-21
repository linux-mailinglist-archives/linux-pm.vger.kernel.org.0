Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2136638D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 04:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhDUCRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 22:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233824AbhDUCRN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 22:17:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F17C861418
        for <linux-pm@vger.kernel.org>; Wed, 21 Apr 2021 02:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618971401;
        bh=tqEUn9WQsIVK+xhpQN6Tn8Y8itTJjdDYNU4hd5agE7c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bBXrTr0ekTsb39oeP6Awehm9pst/j7f/dUYbWDHuboXjtayukNxthp4XYlCSjT+TA
         2ZpcgGQ1CD6DhG/8gJzZ2LvElz2dZNMqBoC6zjO7i6djHJEv4tcB8TbbmOThdlBDwr
         QROuWnFreL72qpf7w5Q3OaAKjG+941+cXrxgNrtvxICngAI3mEzKRpYmPrhHCUMDZ5
         iXP1uQ2labD50GGPZm95pBPn6mYtLddXyrt1R+EwFPNhPZvCqu4jVa3sYHUTnvSH/M
         1GoTBQuG0b6QoBxq6DxCwTeAvHUtgYdIuLdtM1QlT30xoi0wvXUyAGFSNPen9NtbWO
         4dQyWrHcsKtuw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EB0D76113B; Wed, 21 Apr 2021 02:16:40 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load - Xeon E3-1271v3 HSW
Date:   Wed, 21 Apr 2021 02:16:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution short_desc
Message-ID: <bug-209069-137361-RJzUHUDg0D@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209069-137361@https.bugzilla.kernel.org/>
References: <bug-209069-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209069

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX
            Summary|CPU stuck at 800 MHz at any |CPU stuck at 800 MHz at any
                   |load                        |load - Xeon E3-1271v3 HSW

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

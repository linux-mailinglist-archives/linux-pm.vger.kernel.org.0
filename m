Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD7339D9B
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCMKld (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Mar 2021 05:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhCMKlV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Mar 2021 05:41:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3C09564F1D
        for <linux-pm@vger.kernel.org>; Sat, 13 Mar 2021 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615632081;
        bh=ySib2wRXNl+sxCpbNA6psO6GS+2DG9C1xprqmqlgTYA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=njAHB2YGL2HDRnqMf1md5Pyo/Y4Cw5TblCK8L/GswO97+DGfSocN5zKKuYzARkjEp
         m80Uic9URco+wpRQIPpXJzOLXRTvpCAp/SACFYtir/xON667IyJJSTECwoIFjBq/ZA
         OWS9FT6ftIxzmq8RXvAwVVaEs/gum1bbdgg/rfLlvQTQW/v/5op36RidYSTQbRqaAD
         YCGZnfe3iEip6oxbXua1KlPw4GOzBv3cWmxfnW9ve1KkEqSm3tiCRwXp6AMjSIr50g
         KgLNopqMRxW4vcnc6nB1BXoJbF8BAAmGRYGn+AYUpKyR8Z+zS84xVzIV6ExeZA2P2c
         terHQPLr0B1xA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 22D4F6525D; Sat, 13 Mar 2021 10:41:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211791] AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Date:   Sat, 13 Mar 2021 10:41:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: josh@sobo.red
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211791-137361-jJD9wJiapI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211791-137361@https.bugzilla.kernel.org/>
References: <bug-211791-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211791

Joshua (josh@sobo.red) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |josh@sobo.red

--- Comment #2 from Joshua (josh@sobo.red) ---
I'm still having an issue with frequencies being reported incorrectly. Here=
's a
thread for reference:
https://bbs.archlinux.org/viewtopic.php?pid=3D1961500#p1961500

I've updated to kernel version 5.11.6. If I watch /proc/cpuinfo, that seems=
 to
be reporting somewhat accurately now. However, lscpu and most everything el=
se
is still reporting inaccurately.

~ =E2=86=92 uname -r
5.11.6-arch1-1
~ =E2=86=92 lscpu | grep MHz
CPU MHz:                         3400.000
CPU max MHz:                     7228.3198
CPU min MHz:                     2200.0000
~ =E2=86=92 geekbench --sysinfo | grep -E "Processor Information|Name|Base =
Frequency"
Processor Information
  Name                          AMD Ryzen 9 5950X
  Base Frequency                6.92 GHz

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

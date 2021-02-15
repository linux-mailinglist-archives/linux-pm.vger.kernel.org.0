Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDB31BBF4
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 16:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBOPLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 10:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhBOPKM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 10:10:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4FC4564E40
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613401770;
        bh=R+Mg0mj3Fm3npgYidz9CygM+EdZZaouETFTiMHtluq8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MoMXrgQLYbd7bdH1sw6iRjvwRhFNyVmyGh/kjUsCjl5ku9C7gENdjO3o2hztLZQTj
         GOa9PQgLmOeRvEluQrtnHevG+ZdqbH9SV5rjFuWVVw0hx0G/nuoLgCsadkKXC4/4fO
         hPSgQ/VRykE9IYkKhCJ0isluqDS2l1c9VRbxsLfst8unmlqA8Rv8uXb6iIgDthI84n
         l4ETZEPZTp3uOygCyyDayOW8WJZuOZBoXBXwC9mxRUdqNW2pa1pT7eiRD/nUP0xRYn
         mm4VHOg7RhlkEy79XB1gGNQlstzGWRUOg4Z8M4/WkAp4Ysq6YmxScjxZcTQ05OEfo4
         gfYiX6YwrKkKA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3A31660249; Mon, 15 Feb 2021 15:09:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 15:09:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gardotd426@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-G1GnIh19eR@https.bugzilla.kernel.org/>
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

--- Comment #17 from Matt McDonald (gardotd426@gmail.com) ---
That does seem to have fixed it:

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
4854354
3823787
3647266
4016171
3576030
3974600
3816628
3590646
3919312
3626692
3618178
3597246
4367040
3599805
3837612
3874146

cat /proc/cpuinfo | grep MHz
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 4193.751
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000

sudo cpupower frequency-info
[sudo] password for matt:
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 2.20 GHz - 6.00 GHz
  available frequency steps:  3.80 GHz, 2.80 GHz, 2.20 GHz
  available cpufreq governors: performance schedutil
  current policy: frequency should be within 2.20 GHz and 3.80 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: 3.80 GHz (asserted by call to hardware)
  boost state support:
    Supported: yes
    Active: no
    Boost States: 0
    Total States: 3
    Pstate-P0:  1000MHz
    Pstate-P1:  700MHz
    Pstate-P2:  500MHz


Everything is back to how it should be, only now with assumingly better
schedutil performance (I'll run some benchmarks later). No 6.0GHz reporting=
 and
no being stuck at 2.20GHz. CPU performance under the "performance" governor=
 is
back to where it should be, and I'm boosting up to 4.9-5.0 in single core a=
nd
4.8 all-core.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8756031BA9A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 14:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBONx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 08:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhBONxi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 08:53:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BFDF364E31
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 13:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613397177;
        bh=HeMdjhIupbUvPdtiNDeXuPIKot+6CsuOdv65EiQj9T0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qAmeIuCYEA2dEzhrtsUJxWmPdjnoKrG2PC2+0qhotglfFG24Af3cHCrqJW7sLT/cj
         0iqL8zRNhU/MG80ipcE4/6Dj+SOzmT4gNUQ7Q50nH5QetHuf01QVQfK2IzOZEBebRM
         dFbz4rzKuS6c/kehJD9N59PSY/1uoWwG4eiZODHy4WZ3xBgho/B/UU6v4nOafkSoA3
         lW/gFXJdeVT7RIL6iCLPm8jnSWcFzyh0tPTOoKPvs7gEUH7r2OxyXlnaxfzhFN+1NW
         quHp8oGu/eFQK0lQw9EkxLkrENescRQgbYi0WoBOoQ85SGfHABKf9wD2VCYlG6lJS3
         tliS+n3KiXY0g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id ACEB560249; Mon, 15 Feb 2021 13:52:57 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 13:52:57 +0000
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
Message-ID: <bug-211305-137361-sa2Cz0HFA6@https.bugzilla.kernel.org/>
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

--- Comment #12 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
(In reply to Matt McDonald from comment #10)
> Okay so that's *way* worse.=20
>=20
> Everything's limited and locked to 2.2GHz. And yes, it's actually running=
 at
> 2.2GHz, it's not misreporting. My Geekbench score was less than a third of
> what it should be
>=20
> cat /proc/cpuinfo | grep MHz
> cpu MHz               : 2200.000
> cpu MHz               : 2200.088
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2199.982
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000
> cpu MHz               : 2200.000

This actually doesn't mean that the CPUs are running at the given frequency.

>=20
>  cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> 2199680
> 2199981
> 2195932
> 2199979
> 2195634
> 2198726
> 2199437
> 2195587
> 2197662
> 2198924
> 2198856
> 2195535
> 2196402
> 2199234
> 2199880
> 2195064

And so this.

> analyzing CPU 0:
>   driver: acpi-cpufreq
>   CPUs which run at the same hardware frequency: 0
>   CPUs which need to have their frequency coordinated by software: 0
>   maximum transition latency:  Cannot determine or is not supported.
>   hardware limits: 2.20 GHz - 6.00 GHz
>   available frequency steps:  3.80 GHz, 2.80 GHz, 2.20 GHz
>   available cpufreq governors: performance schedutil
>   current policy: frequency should be within 2.20 GHz and 2.20 GHz.
>                   The governor "schedutil" may decide which speed to use
>                   within this range.
>   current CPU frequency: 2.20 GHz (asserted by call to hardware)
>   boost state support:
>     Supported: yes
>     Active: no
>     Boost States: 0
>     Total States: 3
>     Pstate-P0:  1000MHz
>     Pstate-P1:  700MHz
>     Pstate-P2:  500MHz
>=20
>=20
> Both schedutil and performance governors had no effect.=20
>=20
> But I do see in that cpupower output that it says the hardware limits hap=
pen
> to be 2.20GHz to 6.0GHz.

That's as expected.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

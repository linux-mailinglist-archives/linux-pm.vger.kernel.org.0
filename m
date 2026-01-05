Return-Path: <linux-pm+bounces-40170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09971CF1897
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 02:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8263007FD9
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D5534CDD;
	Mon,  5 Jan 2026 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="redehPp/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE765661
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767574990; cv=none; b=AFNb9AsAPmIk7ROjgA2gYyWWCW8DLNdPJn+Bfum0AIz6hAhcbsnsetzJcRVIUe4m1eeE2N/j/jq7IjwfFYboEbeWcQ3P2b6ru0jQuXw2S953VQGC1gEnjzFWwQfmvUE8yxsSVnr/NZR39HA+BpeEzpwHKi46IwAgovP3mqgvMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767574990; c=relaxed/simple;
	bh=kwm3G2fLzFqFMHjR9cZ2r0wrcBCGXGNq4Z1nnTCCG/Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SPbjdVh+Jfy+Lilx3LrqrbiNWiM8Ej5sbjrLnP0xt0z4EZ1UmVzkDoTfw7JtC6Yf1TCeNFCiPYlCERJRxD8rfKWRhAoSDvApAU4sYXPdj3eRwlolfFkmgFlbGV7SrP8g0Ro6SetkYv6mgj83i92Yxwj/NPk74mbGM0yrB5HYij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=redehPp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D6EC19423
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 01:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767574988;
	bh=kwm3G2fLzFqFMHjR9cZ2r0wrcBCGXGNq4Z1nnTCCG/Y=;
	h=From:To:Subject:Date:From;
	b=redehPp/WiV1C+GLTd0Wx2laIdg6G9lZ6MrRN6jwHIYEHc8Ua5uehiuwt8n4Uw4Me
	 sJzDln1Whin7NuvzBLdQDJBin+nVNKOyysGExU/hnWF63CxJZDWtpqKu5PfPRyFKI6
	 TWUhJpINyN9IqWBYUxuJ2vQFZhyPO6tPre4RGUnQ3zqZITTWYMciUykt89z+QFy7Um
	 ZY+bLiJ3QqLxHtCszCH4qhYNBL3SF4SD0EgLUW7StMKdpSu/p4dY4EzMBnDxrPpi7z
	 JkQ36DT5kfcIDdDK6tyRfc1tFloHGhfEBC9iz8TO1STNRx049DFDRieCP2PhwwXmWx
	 ORjXkG/kVIbyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ECE2AC4160E; Mon,  5 Jan 2026 01:03:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] New: hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Mon, 05 Jan 2026 01:03:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpeisach@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220946-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220946

            Bug ID: 220946
           Summary: hibernation seems to be broken after commit
                    bb31fef0d03ed17d587b40e3458786be408fb9df on
                    v6.19.0-rc4
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: jpeisach@ubuntu.com
        Regression: No

Created attachment 309127
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309127&action=3Dedit
dmesg (successful hibernation after reverting commit, the cpufreq errors st=
ill
appear)

Overview:
Hibernation appears to be broken after commit
bb31fef0d03ed17d587b40e3458786be408fb9df - I built v6.19.0-rc4 (build info
provided). My goal was to originally figure out amd_pstate errors in dmesg,
while reverting the commit seemed to fix hibernation, it did not fix the er=
ror.
Regardless, I think there is some relation, so I put it under cpufreq
component.

Steps to Reproduce:
- Build kernel from v6.19.0-rc4 release tag. I did this at around 00:00 UTC=
 on
05 January. Config attached. Install modules and all.
- Boot, and try to suspend. Will not work (displays were off, but my CPU fan
and keyboard/mouse lights stayed on, meaning suspend did not complete.
- Force reboot. You can test on a backup kernel version (I used 6.17.0-8) a=
nd I
did not experience issues.
- Revert the aforementioned commit.
- Rebuild, reinstall, reboot.
- Hibernation works as expected.

Hardware:
Motherboard: ASRock X570M Pro4
CPU: Ryzen 5 3600
GPU: Radeon RX 6700 XT

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


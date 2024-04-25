Return-Path: <linux-pm+bounces-7069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A000C8B1ED4
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D087E1C21656
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B385942;
	Thu, 25 Apr 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYvH0hCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87285937
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039927; cv=none; b=cGEgRnVmXQEXQgmYvZo7Ai2su3TaTZ1UXokWmuWM8dJo7dRRBvxhIEwMKVb/Rl+1Tfw12trfQvrqnQf07dlS0xhTlYO5w7N2BG9NqRx9DFEr23VMsL/y/kuB35gLamGvzOXiAUE3ljo4cOJuV9dmBYVNR0juRwyo8xWp6AOg8cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039927; c=relaxed/simple;
	bh=qZE1iGhj1f0rEJ7Ct5vd/1PwaRKAn8uJxnLooKSp8Zo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGfPCwhDjtBtRA1QgzU6HZRmyEbRrQxfBTx0HWgUZzjYEMzpsrbD7CM5bSxiA1YlxCxyzqYevcFYcxHB9+fGN775VBp/OwZvF+/E8EL8tsmj+r+XwXUJfqhqWE8NddSXYe8IeefZZW33lQD5Kqzu1NtoPaaX/KWz1ZYSBTYd3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYvH0hCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33417C113CC
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714039927;
	bh=qZE1iGhj1f0rEJ7Ct5vd/1PwaRKAn8uJxnLooKSp8Zo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EYvH0hCsDVpx6QzuZMlweKBQ6oUDgZyx0f7X6JNtAMCFBxSFDWF8b+zLmwkTee9TA
	 refMjbkZKQH0ADgF0NpIRjmz5u3TLNxfDuTqHnYvTc1X0I1Ymwq4/oR0EEmY+kgnuE
	 VsOfWq5/j74KcwT3oRnaKxirn4FaNNBK9xv0dh3zd43NyiVu+LDfB1SoUpInPbc+Gj
	 tvKezQNZqcBJ0I3hlNXMEjRXv6ziMwY6nsJTKqR79gw86l48hDBFoP4T1Xk+eQcFLW
	 t0v0uBuhzSfW01t8yZPaF6UYP//VVg9FugOYfDvXtkuv4KSeE6K7bEO1XJNNHiFl2X
	 MeQfsMrk8mLtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 23B9FC433E5; Thu, 25 Apr 2024 10:12:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Thu, 25 Apr 2024 10:12:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-elUO9ZYdPb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #6 from Gaha (gahabana@gmail.com) ---
hi, I've applied patches to 6.9.0-rc5 and built kernel with those.
With kernel command line being either "passive", "guided" or "active" resul=
t is
the same - single core never goes above 4.35Ghz. with 6.8 kernel it does go=
 all
the way to 5.1Ghz.

here is the output of lscpu -ae when running Geekbench (during single core
load) and it is the same with 'cat /dev/zero > /dev/null' . As for the 'tbe=
nch
-t 100 2' - on my ubuntu system tbench is part of diskbench. If you were
referring to tbench as part of kernel testing suite
(https://docs.kernel.org/6.8/admin-guide/pm/amd-pstate.html) - i tried buil=
ding
it, it produces errors as scripts are looking for amd-pstate driver not
amd-pstate-epp driver etc...

However, am 100% certain that frequencies never boost above 4.35Ghz.(went b=
ack
to 6.8.7 kernel and all is good).

Here is the (hopefully useful output) showing that new 'cpp_boost' flag is
there etc as well as lspci -ae outputs during single core loading:

zh@muc:~/kselftest/amd-pstate$ cat /sys/devices/system/cpu/amd_pstate/cpb_b=
oost
1
zh@muc:~/kselftest/amd-pstate$ cat
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver
amd-pstate-epp

zh@muc:~$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4350.0000 400.0000  400.0000
  1    0      0    1 1:1:1:0          yes 4350.0000 400.0000 4309.2700
  2    0      0    2 2:2:2:0          yes 4350.0000 400.0000 2416.1770
  3    0      0    3 3:3:3:0          yes 4350.0000 400.0000  400.0000
  4    0      0    4 4:4:4:0          yes 4350.0000 400.0000 1722.2209
  5    0      0    5 5:5:5:0          yes 4350.0000 400.0000  400.0000
  6    0      0    6 6:6:6:0          yes 4350.0000 400.0000  400.0000
  7    0      0    7 7:7:7:0          yes 4350.0000 400.0000  400.0000
  8    0      0    0 0:0:0:0          yes 4350.0000 400.0000 1480.4850
  9    0      0    1 1:1:1:0          yes 4350.0000 400.0000 4307.9858
 10    0      0    2 2:2:2:0          yes 4350.0000 400.0000 1751.6750
 11    0      0    3 3:3:3:0          yes 4350.0000 400.0000 1722.3180
 12    0      0    4 4:4:4:0          yes 4350.0000 400.0000  400.0000
 13    0      0    5 5:5:5:0          yes 4350.0000 400.0000  400.0000
 14    0      0    6 6:6:6:0          yes 4350.0000 400.0000  400.0000
 15    0      0    7 7:7:7:0          yes 4350.0000 400.0000  400.0000

Are there any other tests i could run to help figure out root cause of prob=
lem
with 6.9 kernel ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


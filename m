Return-Path: <linux-pm+bounces-7220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBB8B435F
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 02:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAF01F22165
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD825777;
	Sat, 27 Apr 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoFF8hvd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD4C383A1
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178997; cv=none; b=URn7UjEXszKPdbEhuKJfexYivq6JUvQZQyKMovqC00R9MkHeXy0MNH4XfRPKUVPaPkEQBn+uZVOFNaQFOMQkXig0ibO4u0mp1nfHMRcZJ4maK4qsXwHdqRi3O5d0LZ9+Eh7fr1HLAfxEFOscjdP0m283VmJfxOdrGEW0dqhgsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178997; c=relaxed/simple;
	bh=3nVDGwA/Mryal/Xyr2gjfWV7jKa/fXb9v2d5U6La7jc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9sphgqqfrvM5uzf9X9NVR8l+Par7jnL8yUGmDCVL+gHqMp8lT+61RX9Wmk8QJtE3eGouiQ6VK1x6zb6org/xfGQTGMNYTdeyvpzFjGV7sO+CMfxD9omwoc2XrMsVHW8m3n7gWaiv8VwLBAbGmIbd0P2dya5xxT4bYkLoSY6i58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoFF8hvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CDBBC2BD11
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 00:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714178997;
	bh=3nVDGwA/Mryal/Xyr2gjfWV7jKa/fXb9v2d5U6La7jc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YoFF8hvdpD1ajlE02l6e1TdL0Hs3pqQgrzld2chMhyG9QPT9QN+1HQ7N8cr5LI12N
	 tbKYj8jlQJmVWvdVxSTi+OjYXkrGYj5pXY5xpKm2uCTFA5WYh0JkevZydL4JQQ0N0U
	 rr2FHLW4vXrpaGSfXYf1Klonr3ON6j2QlDUcQrVIw9+Sdw7jkcKMLFnwobqXkwiL3t
	 hk7OwxcGe6ampm85zVwgVXZ7Mb1t6i6gOEDkGW+iQ8ALk86iEiofMCTV95ilqPlUWV
	 qiGeKhAdOCi7pPSXGB+KK+YXV2RaahOxBTqZOQKG/GKO3OjQs5Rb6Mg08zDNHe7Jsp
	 RfsLh3ipA+sKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 03380C53B50; Sat, 27 Apr 2024 00:49:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Sat, 27 Apr 2024 00:49:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-CUheeez6Cl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #22 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi Andrei,

I saw the pstate passive mode driver was loaded on your system, how do you
check the pstate dricer loaded or not?

# sudo  cpupower frequency-info
you could use cpupower to see if the driver loaded gernerally.=20


[Fr Apr 26 19:20:02 2024] amd_pstate: AMD CPPC shared memory based
functionality is supported.


root@fedora:/sys/devices/system/cpu/cpu0/cpufreq# grep -R .
amd_pstate_highest_perf:166
scaling_min_freq:550000
scaling_available_governors:conservative ondemand userspace powersave
performance schedutil=20
scaling_governor:schedutil
cpuinfo_max_freq:5084000
boost:0
amd_pstate_lowest_nonlinear_freq:1743000
amd_pstate_max_freq:5084000
related_cpus:0
scaling_cur_freq:2880470
scaling_setspeed:<unsupported>
affected_cpus:0
scaling_max_freq:5084000
cpuinfo_transition_latency:20000
scaling_driver:amd-pstate<<<<<<<<<<<<<<<<<<<<<<<<<
cpuinfo_min_freq:550000

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


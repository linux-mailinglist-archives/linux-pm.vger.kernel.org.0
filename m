Return-Path: <linux-pm+bounces-7119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4828B27BE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28741F226E3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AD14EC50;
	Thu, 25 Apr 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlOsV+Wx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFF14E2FA
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067515; cv=none; b=eWUzA9B5/CScmu7m02LXlCOzYbsEQ1v7iXroTU7WU4e1NzTxRQ0mX2BNGAgMMDsufDXPoW9XlVO2xkkZ9Kbda8l31svALWafsWETR2pGFjSPZmkO5CSuOTLieZNtt+xgjmLdqSaYu/+w6r0xtYWBS4oEbyrBDAi5EFsBizhLnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067515; c=relaxed/simple;
	bh=cVvCIiDR/Q3mf0IHHn3xkzZSkXG4/oqDwODqikYqnpU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCPQcfgLFicGbmRfAa6cYuwmmaXVHQ4EXvZ00+oqxYX4u1BhDZ2b9hfowki255XnNLRjK/SyEcaUAUm7mEDArgptW2FN2ZYvZIInBDQ7PxH2tw48ScR6N9kZyj9/6sYOgJxXWXLwbb+aI8HuqCK89r74LIY4fbNgwQNBOHp52/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlOsV+Wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 475A0C113CE
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714067515;
	bh=cVvCIiDR/Q3mf0IHHn3xkzZSkXG4/oqDwODqikYqnpU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HlOsV+Wxn8vHnRuGEIWwXtrT/6NVNPScNYmo+H5oeA2ElDXee5jF14hO31G26MAhz
	 q+Mt2Z42jwMRZGUA0US5DTcg7K24STah3PjGxHyCLBMNzBJ/YDnognjrbGkH1AfV2b
	 T3KuXQBlhu4wZUl3QD/l2nnzRBP8pWo86AQBWBcQ+Mh5t/N/iPbibpjQg9NqZYFk83
	 XNWP8RlKzvUwvXjQ8+XXY+BEaHKRjz9lyj9V5oypYdLxrxvmsmYLUIxrRjQBZbztYW
	 p7jnwC93qTfXI9g49hdYswzXVjXeqEnfHAX6eQd4l1bIKfItP+VamF2HpRPloB+L27
	 MI0P/sLsYZFsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 32000C433E3; Thu, 25 Apr 2024 17:51:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 17:51:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218705-137361-4rw9oWs2Yb@https.bugzilla.kernel.org/>
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

xiaojian.du@amd.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xiaojian.du@amd.com

--- Comment #16 from xiaojian.du@amd.com ---
From the dmesg log:
......
[Do Apr 25 17:18:53 2024] device-mapper: uevent: version 1.0.3
[Do Apr 25 17:18:53 2024] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01)
initialised: dm-devel@redhat.com
[Do Apr 25 17:18:53 2024] amd_pstate: AMD CPPC **shared memory** based
functionality is supported
[Do Apr 25 17:18:53 2024] amd_pstate: policy_max =3D5084000, policy_min=3D5=
50000
[Do Apr 25 17:18:53 2024] amd_pstate: set_policy: cpuinfo.max 5084000
policy->max 5084000
[Do Apr 25 17:18:53 2024] amd_pstate: policy_max =3D5084000, policy_min=3D5=
50000
[Do Apr 25 17:18:53 2024] amd_pstate: set_policy: cpuinfo.max 5084000
policy->max 5084000
[Do Apr 25 17:18:53 2024] amd_pstate: policy_max =3D5084000, policy_min=3D5=
50000
[Do Apr 25 17:18:53 2024] amd_pstate: set_policy: cpuinfo.max 5084000
policy->max
......

R9-5950X is ZEN3 Arch CPU and has half support for CPPC.
Would you try to use "amd_pstate=3Dpassive" in the grub config?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


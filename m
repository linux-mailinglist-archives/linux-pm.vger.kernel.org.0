Return-Path: <linux-pm+bounces-7569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7158BDDD7
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318A71F2207D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A814D708;
	Tue,  7 May 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLWQxG62"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139714D703
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073236; cv=none; b=qYp3kO8DzbQeP1egI7sNF3DahUF2YtC8DtKrw3rqjSaqH4XYcpKlWTeiAsm+pwDo3Mcfutd/54c3T5BHw61F8MLZLGLO+oC1LuBqNvfcYmxoWJBuJFMLIbjX9EHPW4VXoglCGtNa8/7hKHLp6fM0ZvVoeYdoDUXnyhbKOXfJZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073236; c=relaxed/simple;
	bh=4fFf/5sezMB15RfvktBY+uCcfcbHLTtHBSYkMQACz6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFUrW4UsPYuJSVnA7VbRNBb0kPtUXKuWB3ygs9Xt4F1M7zAlsU93EqA/2tL6uBK0w9YttMExTx+Qtgz8qFhg2h56Fn0Q1M7/QucnraXF7vXbLgHDYjL1hgNAhM5TiAxEi6iU1FMky0SSfWhwgbd/qnOjmRn6y4uAUhKE2npUums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLWQxG62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45E1CC3277B
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715073236;
	bh=4fFf/5sezMB15RfvktBY+uCcfcbHLTtHBSYkMQACz6k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eLWQxG62pCfDdR0ceE3QWOnH6gwDSR6WL3eHuwDniI9/QQomW1VNPQfd791ElMXMf
	 athSHpG47kNnk3N2gDc2k/VTlgmYbiZvtJsTzHX6ZfFfcyBgP9sR4QOJB6ybX4F4jL
	 RaydIOZPDMWAuQ/vuuBEebueXKNvEOrvkrkVJptLPi0j7K7IpIMleAP6W8rarou7/b
	 qJKtGRyHpvijpCVF5EI9MNG8L2LaTV/dwk72W1JnpajAgOxXeDHcVsSVODkwEhGp1+
	 uHYFW4qzAGERL0bvz5f54J1UsVQUDMSaP7aAcFSBe/ZXoWm5p92+hIYDFdAdAzrO1P
	 GAcF3YusFhxtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3A392C53B6B; Tue,  7 May 2024 09:13:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 09:13:56 +0000
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
Message-ID: <bug-218759-137361-RZHKP8Jkyc@https.bugzilla.kernel.org/>
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

--- Comment #20 from Gaha (gahabana@gmail.com) ---
hi,=20
   i tried applying the batch to linux rcX tree and i can not get it to app=
ly
the patch. Have tried v6.9-rc7, -rc6 , -rc5 and -rc1 - all fail with the sa=
me
msg:

zh@muc:~/git/linus-kernel$ git am
./20240507_perry_yuan_amd_pstate_driver_fixes_and_improvements.mbx
Applying: cpufreq: amd-pstate: optimiza the initial frequency values
verification
error: patch failed: drivers/cpufreq/amd-pstate.c:873
error: drivers/cpufreq/amd-pstate.c: patch does not apply
Patch failed at 0001 cpufreq: amd-pstate: optimiza the initial frequency va=
lues
verification
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

should I apply this to a different 'base' kernel code ?

Will post file as a result of 'git am --show-current-patch=3Ddiff' as well =
if it
helps:

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


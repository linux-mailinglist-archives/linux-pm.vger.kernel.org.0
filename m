Return-Path: <linux-pm+bounces-7574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C48BDFC3
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E83B1C23256
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD275150997;
	Tue,  7 May 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK2eH05Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5314F9C3
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077752; cv=none; b=WbUrciE+MthOjcK3gpkX07pk0Pl2ASJpAWhf/2WvyRD2nRfYr1pS0Appi4fqwHfTzIQoP55jtINW14cWlWqMkspsOb+yopFNVB+/IU7F7dw2LwuIH8JsjpPu7ZeQQSJjGpoj9XgSTcfdQo4iOfO6imVqatynBSebNrQwVNXlclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077752; c=relaxed/simple;
	bh=6UUvgvpfxNniBcoVWD3rzNsr0SZq1LVMUkA92x+ycPU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqFcx21XFYKY34ZRrF62xs2y/qViCBzS5h1KW7HKygipYPt3Src4MUPbwip+NX/QnbL1O40BaUPmglNO9i6VlGnr9RD1sW7Qxa5zfTwLTb5hpU3sLUQdQf1jn+Bdz3mKx9t4e0CDTRW7J7aGo/mplFYsZ4m+FsaQXdHoh1jK0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK2eH05Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AF02C2BBFC
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715077752;
	bh=6UUvgvpfxNniBcoVWD3rzNsr0SZq1LVMUkA92x+ycPU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gK2eH05Q6FQJD2OPgO6epuO/80IqhWponMqtaZEb3Y0qxSHULpEVK5KM+0PIL8LEg
	 i40iojfCtTUNvVBujkrrxMxWTwKhImWZT/GhUG5PzkEP+NxzdH93qtsN3ayeRhkQiN
	 KZ3V3iEWMDffrPXn9OWpSeQ6SFEJn59UfMTS+9tVm1tq/8SBSu06ludEbc/BxIYEW/
	 izQhZoN4FFrBovxWXGBQmvgoUZBlA1E3FQNDg7tLHe/U+AM3V5Lv71JMoMOK38NY9G
	 25UPUTu3I0knPGIwjbF8rb+QIqbaMVrOPDn1HDfO4z1FbS/7ozohgDlG20j1zpLPbN
	 LLYPZdk+60q7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ECEB7C16A72; Tue,  7 May 2024 10:29:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 10:29:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-CK84b1V4YH@https.bugzilla.kernel.org/>
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

--- Comment #22 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Perry Yuan(AMD) from comment #19)
> https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.com/

Correct me if I'm wrong, but from Mario's earlier comment, the number of
patches, and number of changed lines this does sounds like this won't be
applied for 6.9 this late; there are no Fixes or stable tags either.

So what's the plan to prevent this regression from entering 6.9? Do we know
which commit caused this? Can we revert that one and reapply it for 6.10
(together with these changes, once reviewed).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


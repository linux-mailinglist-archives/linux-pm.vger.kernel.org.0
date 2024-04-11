Return-Path: <linux-pm+bounces-6265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483D8A0DF7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93921F2165B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC2145B3E;
	Thu, 11 Apr 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anQCiZCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722F145B2C
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830177; cv=none; b=pkZxPzBabdTYvH8+me1qzfEXbkUpu1Zo2z+RuqdfFnT0+QP+IkdVdUHAwjQV0r9CchYqz13Ghp29dFXYSFoZ/sXXgZwxYqj+9IdNyUz/r+9rUgwrE933ztKtKCKm5VL5mimPRDn6ivS8JkWUZQZ5qzQhFjMAXf/nfFRjBa3sYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830177; c=relaxed/simple;
	bh=tGIGvBdIpJJCPuBU6Avyu7pOlxqce/Bm6cKzp5CzPoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORIeA/7KYvB/NPX68SZdccIrzG8vfJR7SQGBKNNQ5gkyOwkzh0SrdlaFmKLSjGpGGh6AupRKaIjxzfj19wPUvpczY2qPV/kTaEhnnKtpwplpStXHSZ5GkaSgYee6jPLoEQ3/a0tmzRdBVDmt7GFgbv/THEyI/zaDMpS4xTShcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anQCiZCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB303C433F1
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712830176;
	bh=tGIGvBdIpJJCPuBU6Avyu7pOlxqce/Bm6cKzp5CzPoY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=anQCiZCRe7PRZAhqf0go1IBCvZQEwNwTVW65ngODGpcMhR5biq606florH4I4ow16
	 s3ORD36Q/kgYeLurya2cEfzLgxw4yYkbAlhADrspMxL4ByaiNJNWKLmWNDjyXFdlum
	 +bb4nhInTBwxOe5EQEoc+Ie9RLu9534HVx0BaxHmUlxqDfTsfZVzZKAoJmsURrtjcn
	 gqJ/XFSA+00y07J6XWU4UOXgtKdG6tEduFIto28aLsWhW7tSGqlh/i58MXHxmCNzSK
	 4cg0aPZmucRbp+AR3O7FVR/4tV1eYvMZEOQJFaOON/pAQPGq2RWWAW73tHSIxqMr3o
	 fJf4bb84eH8VA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BE46AC53BDA; Thu, 11 Apr 2024 10:09:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 10:09:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-kuXiBpl2Cw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #33 from al0uette@outlook.com ---
(In reply to xiaojian.du from comment #32)
> On another Phoenix/7840H APU platform, the BIOS also doesn't provide SMU
> option.
> In Win11, Hwinfo64 shows only one line info of CPPC:
> "=E6=A0=B8=E5=BF=83=E6=80=A7=E8=83=BD=E9=A1=BA=E5=BA=8F=EF=BC=88CPPC=EF=
=BC=89=EF=BC=9A  2, 4, 7, 6, 8, 3, 5, 1"
> But in Ubuntu 22.04.4 OS, "lscpu" command shows CPPC flag truly.

Thank you for your explanation. So I guess I can only wait asus to fix it?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


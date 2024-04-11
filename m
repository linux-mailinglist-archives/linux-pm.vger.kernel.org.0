Return-Path: <linux-pm+bounces-6264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3EA8A0C0D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2C71C214DD
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497D14388B;
	Thu, 11 Apr 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIxacRne"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8F142642
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826913; cv=none; b=jZ8IdTRa5kf0X0lmVLXs0qUWFdRBGWjOtFnz87MkgeTPIaTDuqjoFiXwP1apRsDvdU81+/nCW+3rTo2MyvoVBTrfYPFGM4rPPz7veZ1O91eTLu5k1zAbHO/XaCITqpCiHoB7IS/fO+rZnmMIlWnx40YnhleZ4ykhByF7kZihGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826913; c=relaxed/simple;
	bh=hD1YMNjNc2t5v07KFdKWxJK39jo7ixg/x4crAILLk+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGA0UWRv99EVnbKz4UV2J5gWLPR/djA5+kjPlsGQA7T3RWWsBdfXJrykuKUuXvk5oyxbmdy/BVpQRP1/cjRRkKASGctlg/fwZZWCWSa2Ztb49aZXgqWZeMyqeKZPDIwD7P9o3eQtfhoXPXa0mriq9t1PTd+Sdd3J8AUIsadGMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIxacRne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15846C43390
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 09:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712826913;
	bh=hD1YMNjNc2t5v07KFdKWxJK39jo7ixg/x4crAILLk+U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qIxacRnefDt00WzIajGPrko8QfkfXa0N9cfoQGIGuETT074O9Mt0mnyCDbawQZIBF
	 44MXw2yziOpXeInpRTJojb+/O0T9ZhT54/3r9SoLDl2eZNqRH/HTxvTxpSdDv+KD6I
	 8NOm2lBLwMyvUhFAYeB2MI5vKub24xW8a9fqcho/0YtB9hDrIHd7QvMUrYdnRMrIvm
	 TUwHB6pnGbdWf4noVq2kMKWmKwblCNXvg/rMqi2dJN8qUmCNB04fRHYZ4F3KLVWG8q
	 2UmreUqpVtHQJjs9B0UIX+GMPYU+FpgFu+FMHtILKJ2/GwSy85PPCIzezBXU143Spb
	 AF8nJmr2VqZww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07FB5C53BD9; Thu, 11 Apr 2024 09:15:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 09:15:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-4w9fpB9Qai@https.bugzilla.kernel.org/>
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

--- Comment #32 from xiaojian.du@amd.com ---
On another Phoenix/7840H APU platform, the BIOS also doesn't provide SMU
option.
In Win11, Hwinfo64 shows only one line info of CPPC:
"=E6=A0=B8=E5=BF=83=E6=80=A7=E8=83=BD=E9=A1=BA=E5=BA=8F=EF=BC=88CPPC=EF=BC=
=89=EF=BC=9A  2, 4, 7, 6, 8, 3, 5, 1"
But in Ubuntu 22.04.4 OS, "lscpu" command shows CPPC flag truly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


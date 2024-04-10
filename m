Return-Path: <linux-pm+bounces-6146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CF89EAD9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6847F2850AB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9FC8F44;
	Wed, 10 Apr 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUVvWftQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08E3A1D8
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730577; cv=none; b=cmXSBSkDLHT4kzGu1p8fzUjtZHUTMNdbM688g0RArHOdmCfMls3p8pPuAE+yGX/JbFpf0jjqNTnPgkC0W6/YsplMqyaEpc0TOcjTh+iF57nq1ZpmeUoAxxAGxksNSAdagvR4HSoADZA0+6BHu4c+Zf5IPqiIczegM6c8LVUtb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730577; c=relaxed/simple;
	bh=fziLX4c3bOykJIccGk2hXBc/pSBexNJ5OQQtlqdfpg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVlj400GMNG3PbdO/qWuHchFUNGpkuYhXEQ//BcYf5y6mzL9WZyFWBqGBKbNxpgD9v2mo2YyuOaqOSRZldpqyeol/lciaGFWR5WNCfvpU9olarZG3sZGRVJ2F6d78zJcORci4PuLOWugzXe9BemZMphOAPUkyrO2dyHO98qJINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUVvWftQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 082A4C433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712730577;
	bh=fziLX4c3bOykJIccGk2hXBc/pSBexNJ5OQQtlqdfpg8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sUVvWftQwQ3FbM5/6j7YnuwHhB+CvSWJ6tmhuBA7R5kHT5Obcqj7mtUcWthTRcykr
	 Y6uCx8yHfoMNaNU+B0qO2btVuRpgyLiM1ZAR5lIyxdef/sc8ojgcP/2h6OkViIBcdw
	 kcSU5HlK0nDcpKzDaoVYDpUDLsf3zrx9y917ZqI17uheB/Pqi+trSTj9phpLmnsyCs
	 KwP5ndY9rCqv8TNqEpYYAvHV0H80ajdAniOtlSu1tJH5d+EWQBeVI/daMmG8R2nufV
	 uEW7+Tx8UijUpk+xMVt8AJaekENVNbF53SzRHQ1TE+GflK26MpTkPB43S3UDqoEGzP
	 /gLYeesAapiXw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E938AC53BD9; Wed, 10 Apr 2024 06:29:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:29:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-4mmeni4qnQ@https.bugzilla.kernel.org/>
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

--- Comment #12 from al0uette@outlook.com ---
[  107.095506] rdmsr[3791]: segfault at fffffffffffffff2 ip 00000000004019e=
e sp
00007ffd3b1558f0 error 5 in rdmsr[401000+1000] likely on CPU 2 (core 2, soc=
ket
0)
[  107.095526] Code: 89 44 24 08 31 c0 48 89 e6 e8 ee f6 ff ff 85 c0 74 40 =
8d
58 ff 0f 1f 80 00 00 00 00 48 8b 04 24 4c 63 e3 31 f6 ba 0a 00 00 00 <4a> 8=
b 3c
e0 48 83 c7 13 e8 b5 f6 ff ff 89 ef 89 c6 e8 fc fa ff ff

This part is already included in my output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


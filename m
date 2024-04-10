Return-Path: <linux-pm+bounces-6131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A825389E879
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485661F23833
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BE9476;
	Wed, 10 Apr 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttMUFcZw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029D9473
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720166; cv=none; b=cnFIwQsiYqJooshVEe/NuXgC3S3lmCBMi/XJtfux9TOkob8fjfPTemC8yGWwTa+h/avucl/AJysgjhdQKQ5pbQ857q6uXQ7oHVRLqrqUpnifKr5z/r3/mpHGqmcHNydVyj+bvJ0nd0Fpq4o9amp7K/hxhO/3gKDKojgx0ksecv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720166; c=relaxed/simple;
	bh=rJ/3Ngc/BOYqG2adure5tsI1tVJ53D4h7T4RBYY0L/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQxTd4Auog1KAR1ZX0XLHnkfVVAzTWfa3of0zkhSg9U9e+h+e9byIA/4aIVyZ98UVmrdnSKSdkl8uWSYYm8Wdr/ScRgk65Mhunu7yxSwTdaa0s9cur0KFjG/I1mGHa9uKZ03TxGXDvh/aSHdzgN9hz8D8unZrmc7iDjhrddVONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttMUFcZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E31DC433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 03:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712720165;
	bh=rJ/3Ngc/BOYqG2adure5tsI1tVJ53D4h7T4RBYY0L/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ttMUFcZwbvJxgtFAbaZ12iml+hRIExRsoRS5NMIOERTD00ecIlG8cTozk+2BM3rSm
	 2D1WaBDvPCfEGM8W9FSBvrGqKaajTN+KiWmIiGTNy+bn6+/rrkUSeE1/klOrRRHTdQ
	 QR9BTtdWxwJqG89SBbhhJwZlosbHr5OPCqxv22t9TJ3a07cNOaX1WiqpD5a/RDe1ZJ
	 fK+wYJigT2vlf0K6GKtU+JS1CigNn+MlYZPSR1KS9LqBFd+fZPjHDe01rL1vDAs+q1
	 LCEU+Mongbci1mbnXa7AFf+yGn3VmRgtCZBg3Fg4ksl3BeQiqkkqPsW2fJhgMukWzO
	 U3+Ry1FEUYiDw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 57C80C53BD9; Wed, 10 Apr 2024 03:36:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 03:36:05 +0000
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
Message-ID: <bug-218686-137361-rzJTbRGBud@https.bugzilla.kernel.org/>
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

--- Comment #1 from al0uette@outlook.com ---
can anyone take a look at this issue?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-13861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460197086A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530D61C20D9D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C715C147;
	Sun,  8 Sep 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndcRf4BD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8600167296
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725809630; cv=none; b=Zf7plH4Il7NXmOqrkzkVQObbV6+iFf7svICsPsUam9+tgqmNw/sfC780pC+IRcyMsJHFEDC6ASWBaV7cxXXrTZmG8+cRkZVl7VDSupaPnpIgrgyumu6b4mPH0R6moXwr2+hB2zeMnK68Z79zgbm688XA9OVtykE4ZASUFCM5peY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725809630; c=relaxed/simple;
	bh=GMdhjPCXZDzKHP6s3SaeZCG+FMTSqnD5qDl3dDOXCGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGq4L8jV/4biyhCq7nYmN6yYjyJia0LGFpOL5s8f9r7LJkJ+vP8bdEQ6v9fbt+emFaR81sj5t7K805QgAjTSUm12KnlVWE/XC1nUJ5Lxh82aBFiN9fT8CTNLhTV6jq7vWb/VvATkjjI3lvTP4hq/lRLgJr7Fy0iAm8GEumTvfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndcRf4BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F9F5C4CECE
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725809629;
	bh=GMdhjPCXZDzKHP6s3SaeZCG+FMTSqnD5qDl3dDOXCGQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ndcRf4BDvHlVfcz40bVMMnxqB8pc+9GbfyEd1wEm60cWtuEywVlT9+0sKzKBdL9mq
	 IjxVBNCZjxiOdXA7wKPclyH5nHbAhe0iw5+EGo/fnSxJdFp4dT3iyI7WvgaEnjWpO1
	 j8OULAwf2K/vHVGsUNifDTycdP00YWcp986sHk1kwzu9PtvLtp+Kcc2I/pEbYShGtx
	 vJj4RoZGJp2m2VH0phz/Zs8LNrxh+9i1SF7493pvLSbhpXS5gcuIIAjJ22IE3gHtQv
	 LijQe0PS2BQgkdeNe9I9213Zf2Ww5uiM0uQ9diN1pn59H4dzAgKRWjZdK4QFH1bRdI
	 EA/OIDY1Gh64w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 595D8C53BC8; Sun,  8 Sep 2024 15:33:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sun, 08 Sep 2024 15:33:48 +0000
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
Message-ID: <bug-218686-137361-t04myhilEj@https.bugzilla.kernel.org/>
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

--- Comment #80 from al0uette@outlook.com ---
Just found that pcc_ss_id =3D=3D 1 is also because many element in _CPC is
Functional Fixed Hardware

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


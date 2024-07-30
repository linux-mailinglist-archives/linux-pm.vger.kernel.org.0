Return-Path: <linux-pm+bounces-11690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FABA941F13
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97B81F246AB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C57189522;
	Tue, 30 Jul 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzdW7+Vk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB807184547
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362215; cv=none; b=qRlphH8icRKSEe6iPRILCZ4LPVh8wVCJITIFWLM4JpbGAx1buD+s0th1P3jkV95iiLjPIuYbLFbQO7TxAq/Df8CBne+xyXMtxrB6LJPrGYnTxnm5JG+W6nIwJND2P9SDT1Qk4Yt/gEFH6x1F2SWJvxHGE5M+pypzZjqBY29LH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362215; c=relaxed/simple;
	bh=JvyDQFnZYgVodhqs9kLo5JgNbcgxvI+YSkVfA1gh418=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iuvhGE4U/1r6PuupJyQS878Bd4GTD7HGUNGj07gxAj/a6zO1xmjXLnj4rjzBgWnDzSGqLrDsbnjaMzDur6mMZstc0OIwjQOaRLXEVljsAlU1q/ieADcc0XhKtm7P0fCdhQy2bYDqWG1ASTp+1Q/8d7eEv7sVOCpvatl5x+zUPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzdW7+Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4291FC32782
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722362215;
	bh=JvyDQFnZYgVodhqs9kLo5JgNbcgxvI+YSkVfA1gh418=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZzdW7+Vk7d6AZvO7kcko8UX9TyxhsHhPS9v9mpJRFl4uCRqBREL9gGiOdRt4/HG2W
	 Vc9YzD583e9LO0zG+7eUmPUHbUT50gmyTJT4grrEWQ/g9uz/X+Adkh18ejhUmXs3Ke
	 Y/lSpCvkbT5uWrBLfD+Pu67Hz0rEXdEcR1efjdH6ZvWtwl5LnVKdKihHQx9M6GlkoM
	 rnrTgLjaL3AGDRTH9Z2mUKxX+RO3Sbp3zdRoEG/BOG7Qsar6OUcdycxt2KRo2AAQPH
	 WZYMswAf0AbiajtIj+nx98guDTYB5nA3LXoYYEsyK4FFTmfN8tZe8wYsA9/GQJD5Z9
	 Lnw5xZTULY+eQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 394D8C53B7F; Tue, 30 Jul 2024 17:56:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Tue, 30 Jul 2024 17:56:55 +0000
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
Message-ID: <bug-219110-137361-2HU4tw9onH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

xiaojian.du@amd.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xiaojian.du@amd.com

--- Comment #1 from xiaojian.du@amd.com ---
So you do one suspend cycle on your device?
I think CPU power status is reset after one suspend cycle.
Yes, it should be a function to restore CPU power register status and gover=
nor
status after s3/s4/s2idle.
For you case, i think add one more shell script will fix this problem, you
know, you are setting cpu enegy policy during booting, then your can add one
same action during suspend, any chance for this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-6765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F28AC67C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658D81C219C2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0104F605;
	Mon, 22 Apr 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMoWpQ2q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4174F5FD
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773628; cv=none; b=MEsK32sIdOr98AY3DusJoYuUa+bNqypJRmziNf46fv9BWC9Z5KL/n+aKoDKoj0jsFd90wJF5ZdDp/ggPMrxNUq+EAG315msZuqX+0B+6duOrK8F/5ZkSDiMC3Nk4tXW63SoQVk8zvP9LjGfuh4MeW+r7XcQmrAzYkicG/5R8y5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773628; c=relaxed/simple;
	bh=9oIm+W33jqpWoKLFSc64rVlviue4pwsLZ+rUF66xgjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/aR0DwT0mRfabLFvhTfgMBOTQIMgENdhMg9gemOMftsz9M0ml4LWu/xGcgml5Pm7HU+jo5I2IjmO5EYOJMBsGXxvzQJv+WKcnLy2p40t8Eb6THSv9PTD7fAzje0xuJXAmgEgunJeRCBEWhjH197E45StQO3rESdM38U43Emxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMoWpQ2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62158C2BD11
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773628;
	bh=9oIm+W33jqpWoKLFSc64rVlviue4pwsLZ+rUF66xgjU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mMoWpQ2qhfssp5APVjQHoPBh+J5Qyc683h7nGppqPT6iIhA2OjW5VlY3F7pKIKnpo
	 hX1QrmE04bBN/IQqoLrQpjOnogjag2xPEyRmxuHyk79jIEUtpVTWzcHbNrmiHH3nYq
	 QXro0XacFv2hYPm8ASbrXDkuVcwhKS4u15W44V0praeLLYSjH8TopUGXt1Cq2oA/4t
	 OK8ZpgmvfrM4BJVi//qsdVYTE4HgTEcj3CvvgTZFfsxkVKPHgKynEdO7HwY/aoHxNZ
	 fUkDfBxLG4t1+rjI6l+9VmhZFDaIjdKMzE/9hS97GNeN4fqXluP4EFGECdT1yyEqvX
	 6x+VtDXLSC9vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5B948C433E3; Mon, 22 Apr 2024 08:13:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Mon, 22 Apr 2024 08:13:48 +0000
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
Message-ID: <bug-218759-137361-JUI4YDOGVY@https.bugzilla.kernel.org/>
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

--- Comment #2 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi There,
Could you run the script to capture the CPPC capabilities to check the deta=
il?

Perry

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


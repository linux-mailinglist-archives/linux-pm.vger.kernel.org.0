Return-Path: <linux-pm+bounces-7579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085078BE1E4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF86E1F26233
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F015ADB8;
	Tue,  7 May 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWqp2Xnx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C32158DDD
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084389; cv=none; b=mvjLd0EUnTPmGhw64tzLFWxv6VbSNFmuurD7fEbLIXgWRT18kkMBddimeeJsL2cfAhCR0fNo08+I8L33h8f3lLAJE9zXAiew02OOkjlSBA4JPYP1VJXBZqsG0Lh1OZ5iVIBqu7YLP4KuIPzbT6O2/50VIs+n9FvWB+UGYs8nIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084389; c=relaxed/simple;
	bh=1QgfU3g1ZO/6qGDL+wx2JjS+pQS2c765fxVwThkB50w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmQKKyWzTJcMnNEWQGHv/lggRP3X9/oEFrRrDdd5Rhl1CakJ+I+6M1EmnPNdLAvTHkL14idEOHWX9ScJXwwxY/glFOu8JMBbfEfhFQ1OJhvS2qZnZk3B1vMCrRRCKMUOxO3T65b6T3N99buk5CE1nUiq6oD3KxS5yNi8qnCNEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWqp2Xnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81AE5C4AF63
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715084388;
	bh=1QgfU3g1ZO/6qGDL+wx2JjS+pQS2c765fxVwThkB50w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AWqp2Xnxph3GOV+8U7UxOAbRPfGrkHR2+a/6TkDLVrI2TYCxJFeFxt1EVSM5q6mq4
	 3VUSLzR9f+NoB28UQZHgUFLmfga4N/tcuc/BZJALPhfQtt1lBDldMo7OoVChb6yzpZ
	 7WhXaM8qtgxAusCMv0hw1O/Nz65emmYTWHCJyQR4vq29mHdS8cRvdnkc4x2KnflQHg
	 MU64Y2zy+NYTw/e6DnR4h8KbR8aEDmVQrMHnEO1uB/avJpoyk98sygVE7JUHmEYUWe
	 L58DTM/cdC1RLRmQaRC2b0sH9yo89oScFQmi+Erq0xyq+9vpJFLhjYQOB0GezN96ut
	 xkg0DGk73rePg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 75C84C16A72; Tue,  7 May 2024 12:19:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 12:19:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-4ULN6TxSk7@https.bugzilla.kernel.org/>
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

--- Comment #24 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
It's one patch in the series that was added to the series that helps, but a=
 lot
of this code is intertwined. I'll look whether it can move to front of the
series if reordered.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


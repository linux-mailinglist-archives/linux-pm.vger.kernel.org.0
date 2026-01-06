Return-Path: <linux-pm+bounces-40336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44232CFB382
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 23:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1193308A430
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165FD2E8B71;
	Tue,  6 Jan 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC/95652"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469C2E88B0
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737418; cv=none; b=FNruN2p/44bPt5SrKdUN+cm/zeYEfWMHdqnXu3J19wIP01XmN3FlOgUIan5rX31BUSug3NRfuuFHeQyIjQqJLnM5rEWilBNEN459hS5TiSos1+5FjumX6ySJtotdunTvFIKSR1rLLHzRqf7U6n377zteVxF/LHf1qMSZYIk9iuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737418; c=relaxed/simple;
	bh=gGRCh0rumfXmrPwGDmyOOTIWiS7ucGwhkp+ocWyh0IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=enS3/t4mJDiyuf+xnVUH3scgDI8kLdBJ3pPRYpT8sw5Bv2vNKOrbYjer67c2qZrsfA459v5mKkAANZEkHopLUL+HH6LVh/ZADWXVRN3/cuEzWSWBMa9Ac/regxNx+Q1mB0PZsVK566fZaLAXTkImx1YzURJE8tb66J1bqYqcnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC/95652; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72F57C19421
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737417;
	bh=gGRCh0rumfXmrPwGDmyOOTIWiS7ucGwhkp+ocWyh0IE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gC/95652Cv3TNLBgXHZRsL9J5E/g9TkBpczsrtpjju/k+YdM3pTm8ZThl3m7ZNOmY
	 Uqn8PnUroqxvhc1O1gM35v8oNF4lxUymf5Rbm9AlyVEPd4cgLu7hBsu5Zmid5vF8/R
	 DhV0fMZRuSWFpd6+oMKWJ8kOVk70v8lNB1RsRftOqWDf17x0/BXgNuo7WCxhcyDvuc
	 H8GIYcttddTVFSOGfhJkk5+eVof+cq35e0EuKZmmkesqpb9xd/rRjhcSd12qlSQpUH
	 WyVYj3gVK/BHSWZzi+0z0W2egGyUGueUzXkp+oWDddjmbGaF0fm5pprgqFtDO3qr3j
	 xqDHanqVXhjlw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C2D6C4160E; Tue,  6 Jan 2026 22:10:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Tue, 06 Jan 2026 22:10:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpeisach@ubuntu.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220946-137361-bABBr66RIT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220946-137361@https.bugzilla.kernel.org/>
References: <bug-220946-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220946

--- Comment #6 from Joshua Peisach (jpeisach@ubuntu.com) ---
Created attachment 309135
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309135&action=3Dedit
dmesg (successful hibernation WITH commit - proving bug is
resolved/unreproducible)

Sorry about the trouble.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


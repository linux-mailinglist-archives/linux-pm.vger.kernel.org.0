Return-Path: <linux-pm+bounces-40171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D61CF189A
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 02:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1F23008182
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 01:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4A1AB6F1;
	Mon,  5 Jan 2026 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+WBDi81"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D25478D
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767575107; cv=none; b=Pj8etpYHQ/O4eD3+5C6izNpVAA4PEXIR+Akc5OgaTEol/inMN93UOZnaZCa7XVaK7PtituwE0X/6x3TaDAi3vu8kPfmtXtbkx8lFTON/+ejeXNSOA5lchkTR2gaENu7AKUkmvO/Pueo5SBIjt9k581dCyJGWmsI9NXeP1RH58y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767575107; c=relaxed/simple;
	bh=HO6qmUtN3WUh6st1fs3qWF1W6QkrmrGbzEsZgAjS838=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmn4sfumgqCj3TWjof0kCt4CGx6XSNxn5MyQ9vIlCBXoobQMeJx/SbTf/hZZZ5I1LnbtitoyYQe9y/LXaJTeVBQwPQVSISJHJbWas/rPoy1PlCdhsCwjmRcoKz+5ysli/nxRqc/FGv8Jd6pu8luBZO2PuFu+ML1ISHoTGsQe3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+WBDi81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA76FC19421
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767575103;
	bh=HO6qmUtN3WUh6st1fs3qWF1W6QkrmrGbzEsZgAjS838=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t+WBDi81U4zy0tlESDb8L9Q5YWrVTsiKHgrgL6E3O8952/FpXq6bmAT9ckpYdE3By
	 G20eAJAjjoSnLFaM27usiFGwkcuFkv/MHxXnrlxyF4w1Np19yzbodcUf4Iy0ENMSQp
	 2/L1HCts3c6dAdWNkn7A4h5B9VSFvIG/uHKUFsEq0JWOJ/n6YXZRugwgaZoXkpVL+A
	 bvP5OD0aAWdsJJd9jvJDSqf5L82XYkh7GafuOgA6pGp893con54Ml1sEZYruN4bmgL
	 MEI7Rne3warpBl+ssjiC+mQBsd1RZxiAjcgHL9jPQjyjP/uF4WTYytSCIfI9/QAKBk
	 MQPeRyl2ZjWrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9E284C41613; Mon,  5 Jan 2026 01:05:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Mon, 05 Jan 2026 01:05:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpeisach@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220946-137361-38wo8Gb69t@https.bugzilla.kernel.org/>
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

--- Comment #1 from Joshua Peisach (jpeisach@ubuntu.com) ---
Created attachment 309128
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309128&action=3Dedit
config file used to build

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


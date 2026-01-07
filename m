Return-Path: <linux-pm+bounces-40344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E06CFB920
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 02:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7C3306116A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 01:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E4D23EA84;
	Wed,  7 Jan 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJyYfDiG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05651FF1AE
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748165; cv=none; b=BpTMO5XmdtRN3bLMQAhI9e17zzmU+IqXubEDYWkcps6e3qmKuu6QFZbhY+pJp2pIGcNovh9CWjbrfeJokc1hpYveflhhFQJuwqfBAqfsdxU/KtdOSXLRsqrDIOE7YKchAUP8wCgXeSNTQqOBA0JjxNoaNml/Tvc7nwak7WfU7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748165; c=relaxed/simple;
	bh=2e68gwnZ78oKI3Q4CCGW6l3LWmYCfPZTZ228X6XtLLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UeClDcrfEQGZ02nX87DNO1Sc0zZ+Timnsnhl0ph9+kod7ILD9acm6OPPROML2LWZcLfSE6JCJPuic13BGKSLU4Y6mUmchL0GdW+oSPTGYdqHCRxd5hBqg32aOkF+iTFn3ZHX4czpc7cPSofOkuHwbweP0uRkcgYJAGDT8TSKT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJyYfDiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DFB5C16AAE
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748165;
	bh=2e68gwnZ78oKI3Q4CCGW6l3LWmYCfPZTZ228X6XtLLo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZJyYfDiG7sJjP2ejS3lzd3p0xShJLG6n2JtO3gXtpOsv+BBCRmXwQvWst11Yf0455
	 c1J/6ojzu3uJUkdPNJb2LZNElZnGyJ4+T5He3ZcNL9WXhgrwDKw10XAa4F4UPlP/dm
	 DnmLnLYyyup0Cq/CKZGGPslyjXPzBUwCZzXJb0VSSpLWQAkzHFc6pOGojADuMMpg33
	 HHR+Rt6IXeGMLtoN0nXD6DpTpsrm2Upga/nUc5RoVTYS5xPyXrKDA3SiG8KIIPmDu+
	 Qt/u0jDh7iN9/9QZQDR4uQFonzQFP4L8bqo14vzjqstNE5+yejj1ro5jXdeWe01gQq
	 JlGoy+3JW+RlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 20780C433E1; Wed,  7 Jan 2026 01:09:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Wed, 07 Jan 2026 01:09:24 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220946-137361-5itnPRetj1@https.bugzilla.kernel.org/>
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

--- Comment #8 from Joshua Peisach (jpeisach@ubuntu.com) ---
BIOS update fixed that.

Sorry for the false report. But it's good to have a fully up to date system
before getting into kernel hacking...

Thanks again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


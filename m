Return-Path: <linux-pm+bounces-7226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54D8B4670
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3678B285E80
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666F04EB41;
	Sat, 27 Apr 2024 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBJL7uN6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E63E47F
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224356; cv=none; b=kM0SzUmyYVQet63UXMK8u/n2XdGmAyVXF3dIryerKcp3xzSdqY8fo5YszuHrKSkR489Qp+GrNA6KgNq/gp4HcCAHIX2mJdSNQPHZLez72O/quc60QJPSXniJsYDa0Tub0utbkQNZXM7KrakBtPDJHYEWjZVbDT+A7ClM5zk9F0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224356; c=relaxed/simple;
	bh=Vtz/gngFKrXXj+pQ3up0bxi9iiUhYs+JvuLGnhvWQzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cincLIHEvaX8TwKM0bVmT6JpIqEGoe0VdM5fars4ttsEQbRPqRjiyDFglErZCx6T8t/ZNh02UhUZImtmjEBQotg0OEX9OfOkAdYJHsEd6CVSJy1qNJVN1y75NAGZGcS2ArF4VaXhk+EN/EL5ZprI5EqyAuLzhNLs5E/AGzU4c24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBJL7uN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0A7FC2BD11
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714224355;
	bh=Vtz/gngFKrXXj+pQ3up0bxi9iiUhYs+JvuLGnhvWQzA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VBJL7uN6DkMCX0XEL/8bg5wyJCI0YScdyLMWRFDlDpC+zSQ4WJPZjFV/++dQ+2Atj
	 NsJepUwKN9P6wm3bjVgUUAL4aiX8/+ZJSwI7PXVQZpuAE+R4vJu2HNpt4qMuchs2oO
	 u6Q+l0qBHpmRUyWfOzDvkqJuuTgMXYMFvgq6OuwhEZefVVZ5J6S4OE1bTQylA8o8aW
	 ptNY/h8gm6W+x0Hdq7fFwNVQNENsPzPu/X2eDsbus+rsEgk46d4n1QgFY+vZQK02EB
	 wNptQJlDUrCRzjOxOXOLfHv1kHNhGboNY6DBKyq7Kxpw9+cPOfUfnTZYzBrtjJVW5/
	 1UfFn8X6xkYBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B28E7C53B50; Sat, 27 Apr 2024 13:25:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Sat, 27 Apr 2024 13:25:55 +0000
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
Message-ID: <bug-218705-137361-GFh8AomA7F@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #24 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi Andrei=EF=BC=8C

"pstate did not load automatically for me on this system as long as I remem=
ber
(across Debian or Fedora with kernels 6.x)."

Ok, I thought your system cannot load pstate driver, not the problem is sim=
ple
to resolve.

Have you configured the kernel config to enable the default mode 3(EPP) or =
set
to disabled?

Could you check your kernel config if you have enabled the AMD pstate drive=
r?

Here is my kernel config option, you can update config if you have not enab=
led
it to default 3.=20

# grep -rsn  AMD_PSTATE .config
693:CONFIG_X86_AMD_PSTATE=3Dy
694:CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
695:# CONFIG_X86_AMD_PSTATE_UT is not set

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


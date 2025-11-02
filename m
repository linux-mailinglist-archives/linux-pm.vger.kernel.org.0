Return-Path: <linux-pm+bounces-37253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81DC2908E
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 15:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5684E2357
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D41ACEDA;
	Sun,  2 Nov 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP453L6s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D191E555
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095237; cv=none; b=sxRCqB7QLSgGhkIYryInNViHV80KfQnWPSqh17e1Tnbg4BDyaDy522V0xk3lgLl9cLDTsdPzK88gcsQTV5X3rzzJJ8nk9b18CUVmQFo1kx6yGe7yHnYgY+76xTTFzCpYhkbYKReD8h/VmJWr310vYfgFP9hgE0zRAgsfAQZ5jRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095237; c=relaxed/simple;
	bh=BrVzzLd9SkCDa8z+dtFP1J16e1Wf88nr2ARQWxfi6Mc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HbyDb90fWRttd3h28smzTu7d+bNWlOPBXp79cOYrfwnlzfqzQ6k2dLobM+Q9q4k2luFcbBry6tJiUR+fAs7LTTaPrC0hB8H6gNaut2FtIO9tLwcGgl0TnCSxGjGkaxs4AZlMd4GozFoRD/xFlz/ippcJm6URW2XQtTCYAr4QN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP453L6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5E05C4CEF7
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 14:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762095236;
	bh=BrVzzLd9SkCDa8z+dtFP1J16e1Wf88nr2ARQWxfi6Mc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kP453L6sBasJP15zHilaVnJcRKa2g0ihEtOI7H3t9jv9J22s0idbPNNBbk87A18g6
	 gvNFCjhnCbBnuwMYGAHG0Dwelf45daLca1aWFOYjI0x1j6e9V3q7cJ+IHLaJ8HVboy
	 WAivRFyBx/UeSvk3M5ZxSCayVfscYv8aKElbD+hDPQF8qxlZu4BpP5/TEh2JFrUp8H
	 +V9FK3yyGD4WrlZ7rH8GB9sMsC3GlQtE2ejtYV35u8U1mzZQVfLiURg3GJZ4pCJwzn
	 9jHEibhB2B3ev763n+xo6neH0gkSU1tXl1bbLH/0o3UTfzFHkzmpng7XySlQ0+YHz+
	 pfZFAYU3Fdliw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AD00BC433E1; Sun,  2 Nov 2025 14:53:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sun, 02 Nov 2025 14:53:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-2s9GqPZ63K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #9 from Chris Harris (chris.harris79@gmail.com) ---
3 follow-up) The patch does not fix the issue.
- Applied patch to v6.11 source, verified with grep, built and installed
- Booted with amd_pstate=3Dpassive + nosmt=3Dforce
- Confirmed nosmt in effect: lscpu shows 'Thread(s) per core =3D 1'
- Result: Driver still falls back to acpi-cpufreq
- Error: "amd_pstate: the _CPC object is not present in SBIOS or ACPI disab=
led"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


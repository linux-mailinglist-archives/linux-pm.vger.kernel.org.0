Return-Path: <linux-pm+bounces-13920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939C972696
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 03:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B12F1C21BA2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDCF7345B;
	Tue, 10 Sep 2024 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVxo3e5W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31C3EA86
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931364; cv=none; b=Fi7H+2SIOj7/p41ZT0tzDB8RIegoEczRXI5ENhUEWHKPTrEJdoIkEJ2DaRjux9OwWVwgKFPkjBPqf0XSKZfeW9/B1k5hPkV1Fk6yC8pPPj0RPjWwU2OUhR/AF7QbckjaQto0e4ECOcTyTUy9sMqIIGx4hGPRBso/zmLgFaDqKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931364; c=relaxed/simple;
	bh=+yMvX6gE4yPOlKP3/YTQe3e8hcJFMzLWfsqWyzkq0Ew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ax4SYjlAv9dK1O214iXqqyk6psJtXm7bY8yt43k3hQe786DtXtIZEcfU3n6v9R99EpwvUp01PcLkU9irH/++x9xBywqp6YvIM3g7VVDXHoyfzfz4LaDt+WPjTm0DBX7CKV8tSVxLXgztE0FiS8eJtsXuhQwKxuZlB1munT3FzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVxo3e5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95BB4C4CED1
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 01:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725931363;
	bh=+yMvX6gE4yPOlKP3/YTQe3e8hcJFMzLWfsqWyzkq0Ew=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SVxo3e5WLlRfART5BDHRrAJq1t0OHF1ryKDrSjTPAWU4PRRJdykSN7e4dntVmtWvi
	 T/Fh7WFLhxZjtjKyFSHheTP7lMgYZudkNJNPMWQeGO24WcNnnTtBpEZSnlI8AEYtfD
	 85e1EvZlCZwY7/MQ1Me/AYbLY6yBgceGcRtU5J7TANVKCsz5p71tE46K0mf/1GreCY
	 e7EzvpyBXLL7JMeL/xHsASzfs1fD+lMCoSOqhiisJw1gdLuwPtA7Z/GxZEI8qsMgvR
	 MPGfpR9HevLmqU7ng2Mg96/OKOQ009iqpc6wSOLIIDfAu+r0VaygNCQhyYxg5tEb/m
	 svTE7snA64TIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 90484C53BB8; Tue, 10 Sep 2024 01:22:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 10 Sep 2024 01:22:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-OzhtOwhq1u@https.bugzilla.kernel.org/>
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

--- Comment #95 from al0uette@outlook.com ---
(In reply to al0uette from comment #94)
> (In reply to Mario Limonciello (AMD) from comment #88)
> > Created attachment 306844 [details]
> > opt EPP register writes from FFH (v3)
> >=20
> > I'll re-open this bug to see if we come up with something that is
> > upstreamable.
> >=20
> > Someone did some testing on another bug report and found a problem.
> > Here is an updated version.
> >=20
> > Can you please share the kernel log with this in place as well as the
> > cpupower output?
>=20
> v3 doesn't work for me either, it shows device or resource busy

Sorry, I made a mistake, it works fine, the reason it didn't work is that I
mistakenly switched scaling_governor to performance

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


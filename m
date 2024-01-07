Return-Path: <linux-pm+bounces-1921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC2A8262B0
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jan 2024 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897FCB21B73
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jan 2024 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F166AAD;
	Sun,  7 Jan 2024 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FliQfu62"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3156FD3
	for <linux-pm@vger.kernel.org>; Sun,  7 Jan 2024 02:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F215C433C8
	for <linux-pm@vger.kernel.org>; Sun,  7 Jan 2024 02:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704595102;
	bh=171R3Ruw8EnXzJlUOrVsYNypbFNvTD1JugFkOwaZVDw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FliQfu62HevYFBIXJKpn6lUGfaR4RhqBEN+FWNG5T0oBhnqNjGSYlqG+7wRgL64Pv
	 gilsNndaYzupfRzhntpp/tIh/uBRSW32/0tXI4d9VVgjwr4VkJy2SM1d7Zxl3UhyuF
	 LOZuEGSf2PCyhkYBFlPiabfYouIYceuvop0n6mqgEGIXdxm9vfTESZIiyBQdyal4Gk
	 eHKg8E2WhUPKBd5EKmC5GJLEFCkRawxXXxnhn7AH8mLE66UU0ru8eyKv9lri5BZde4
	 o8gNg987Rhzts46Il/LMEzsvXPlIaZkV763U+qL/plYECfod0oB9x9ticO1KZgayAz
	 XwmHiW5Raafbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 370C4C53BD2; Sun,  7 Jan 2024 02:38:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sun, 07 Jan 2024 02:38:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: voidpointertonull+kernelorgbugzilla@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-6meJ5tFyQ0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #14 from Pedro (voidpointertonull+kernelorgbugzilla@gmail.com) =
---
Got back to a more recent kernel and found out that apparently the issue is
sillier than expected.
It's not the first change that's failing, but when setting a new frequency
limit, the previous limit gets applied instead.

So for example after a fresh boot:
- Set 4.0 GHz -> Nothing changes
- Set 4.5 GHz -> 4.0 GHz limit gets applied
- Set 4.3 GHz -> 4.5 GHz limit gets applied
- Set 4.3 GHz -> Nothing changes because it's already supposed to be 4.3 GHz
- Set 4.2 GHz -> 4.3 GHz limit gets applied

Way better than nothing, but it's surely odd this way.
Good to know its quirk though, earlier I just thought it was simply not rea=
lly
reliable, but explicitly working around its silly issue makes it useful.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


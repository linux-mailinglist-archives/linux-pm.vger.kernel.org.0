Return-Path: <linux-pm+bounces-2406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D88183326D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 03:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C81C2110A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 02:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7CA53;
	Sat, 20 Jan 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZdWut/e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF4A52
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705717447; cv=none; b=tx/YeNJbcumhL1jEAy89DnIpx4RZus1gDJ8wnPkTdJTUl12nvTbQ0hBv21KoLaPdm3L4O41XY17R3Fn+o5Kn5u8tsNPAfHISSX5u3bV+VYIq3/k7h5cPRWGkK4IfmceB6Kcco+mup4icdHIxikwEcACoNnhqNGa5y/obzeLWl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705717447; c=relaxed/simple;
	bh=IdplboFUowpV1MNU8XbUKLcTkjxMH/aH/stjMiFsZFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIto5akpexm++jtwNfxcVj/yTX9r6xIrnvZ/eZPd0ONRWsN/L9fdsVICrN05LegEKG2XTf796j6fzZc3Xvg+2b0v0/hQfJ4OzO6olVqQwxO5kx12D1BgQ4odtJqNZ+3D0Jb6lrPIobpX3jHhXmhkaiIDJISYhbB8bRa6HwmAL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZdWut/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B0CFC43394
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705717447;
	bh=IdplboFUowpV1MNU8XbUKLcTkjxMH/aH/stjMiFsZFw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LZdWut/e2/ZOK2wt7p5M6tEygVCas2SbaYaMfDbTa1udqQO5xujqFwd1ROqG4vqrb
	 TbdeNhyOMKOOkzj2J7V/+zDYf603xfdnEHeRIqVGHd0/D0tSjWxnOwM8zoPIT1l21N
	 LPiGBgtPbn0LXWllHFLd7bIkikQFe2ExhLOaVzSk0Y40j/3aO7rSHHQCzv3E+SoP4f
	 pAEm/nR3UzRBbDyNCpSrJfYsOjS1dE+v2xgVtemYR5QKPgSf+r8h8nsul8ebRaMOtB
	 TJfgCEfzShiZU+sO+B0UAkzcdrnmuRk3HyqQlLCGIDqcG3CMbwJ7Q4eC58Wh6sRPvd
	 cFBjHCMfGpvhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EA26BC53BC6; Sat, 20 Jan 2024 02:24:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 20 Jan 2024 02:24:06 +0000
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
Message-ID: <bug-217931-137361-FxyAhybdK8@https.bugzilla.kernel.org/>
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

--- Comment #35 from Pedro (voidpointertonull+kernelorgbugzilla@gmail.com) =
---
Bah, tried to test #33 first based on emails, but found out the hard way th=
at
deb packaged kernel installation stopped properly replacing the previous ke=
rnel
at some point so I was testing nothing, and the comment is gone anyway.

(In reply to Mario Limonciello (AMD) from comment #34)
> Can you guys please test this:
>=20
> https://lore.kernel.org/linux-pm/20240119113319.54158-1-mario.
> limonciello@amd.com/T/#u

This one seems to be a winner, the frequency limit seems to be updated
correctly after applying the changes (by hand).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-22184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D237A37C7C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 08:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E440B168035
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12418DB12;
	Mon, 17 Feb 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuQCZm39"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531515382E
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778491; cv=none; b=NALKOGPPt1YJKBurplWHAoXFMV+Qtfn26+ffiLZCAmjgAd+icEJhMCe09QTnbgWrrgdVw/B/38pYk8vTeDXvaNc6a78RegHQRaE09JWjwrvfJbMykoCKV3/g8hslvReHycBfCX0pyDGED4EcUP5Y7nc5fdXlmZhjPijKwNk06uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778491; c=relaxed/simple;
	bh=eo2LvtVznHxqS0YjGJhLHPVfzmcr/GElrpZG+J3XaLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Udk39SF48i+0gks84PPjLPEAiuOdX8g/Av6QfVBR9Or+Wnp6K25yQ2HLa/oonNMM3Nr4AYPXNQlgSpdJqj6NVjB6k3DLpYO3rF5auP9DOlkr1JfraX7V+aPzORG9cmio+ztiyETnPKvQt3bFwrjnxYreSRzp6ed7OPgA79HKvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuQCZm39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E8DAC4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739778491;
	bh=eo2LvtVznHxqS0YjGJhLHPVfzmcr/GElrpZG+J3XaLI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZuQCZm39ywAROUM1I9yjGUxPC2KhajRNINJuL7je7zeC86gY1cdhfqO00hDS0Ihr6
	 aL+zpRAR7i4g/Uk3VN4Wgag7Da/S0KDojX8khRLMRi0oqaeT29jNpU/Ik2ON0Bn8fY
	 HAqv9Jv0+wPABXWYB9Us297E2YJHHsXFUf4QDY9qr6fbWEGbQ4R2ozJyZF632R1lyt
	 9QCDGDU6FEnpRKvQThBy1Jm5Ou2whc/6m8W1by19rudOpW7fBSvBAc9D4bYHZodnAV
	 vumKquVSG4Gd6AidcOjWnOVybBBvSJWkX+p3xDwx577VDh7j3tP0sfZaFU1STqHS+5
	 VhPwYMPHLB+sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 03BF1C41606; Mon, 17 Feb 2025 07:48:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 07:48:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-2YwhNyw90K@https.bugzilla.kernel.org/>
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

--- Comment #64 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Miroslav Pavleski from comment #63)
> amd_pstate still is going haywire, testing on mainline 6.14.0-rc2. Upon
> fresh boot, both active and passive drivers seem to adhere to
> scaling_max_freq. Passive definitely.=20
>=20
> After S3 sleeping the machine, it goes haywire, even boosting CPUs (ignor=
ing
> boost flag) and going above the set limits. It is really frustrating on a
> notebook machine, heating up and draining battery too fast, without some
> significant workload, making it unusable as a portable.

What's your CPU/APU?

>=20
> I went back to acpi_cpufreq and the machine is much more well-behaved, ev=
en
> though the minimal frequencies are much higher.

acpi_cpufreq's minimum reported frequencies shouldn't affect your power
consumption.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


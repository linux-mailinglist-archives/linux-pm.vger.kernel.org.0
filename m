Return-Path: <linux-pm+bounces-2407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44DD8332DE
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 06:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC2A1C21395
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9315D5;
	Sat, 20 Jan 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/qPsdEC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05423137D
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705729718; cv=none; b=r2Op40cJOsJJBeO6OoGdKhT9WQ9W8pkC703dzVnphBQkj33N9Kg0di9RXpE9gGZNBsZuGOzf7Fo6Ge4fBGLAp1aIyVVT8azycXA8L6puj2zWY2bMmvjNKZJygWfi/flv23CQFS+MlGHCuENOdJ2c0HvCkP2HN7HOo2NzDK8uAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705729718; c=relaxed/simple;
	bh=w/vJ3qWRBycU4bKjbcKu/cRFZ2wl4FBQ7zdmlfATcgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reHUXsLblirAv8CVCwzlSYoOtmMOJplhRwrq30duge3IeetC6cy/9fgwQ8jDGYR/gTKX7tqO4AhAxylc42P/ODUILEtGwBZ6eqel+ss7N5uY2SKr/ztboJ1AuZ/LzD8PQz2txEPBzVJ1JJf2KbUPPG9QaOo08djZGecPOCwtDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/qPsdEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BB4C433A6
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 05:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705729717;
	bh=w/vJ3qWRBycU4bKjbcKu/cRFZ2wl4FBQ7zdmlfATcgY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h/qPsdECY/gpRL+HwDbznX2iP8L0tD/8v0oVBVRqhtBe/iFlnxrlpCffzbhAC4MdH
	 VMLWpsVHAdxfepn/x8BrkoEpagHy36SRQinzPs0D6Jwmoi076Vzg6Nwqcsp38y5f9O
	 EeVDNFmSZwpQGmyPVePKRPQx+hfJymhtbJqoZ4mJcaPWzm8sjMbNRXRE9OaEnv+TPY
	 5BgWZ+nImS1KHo+4QUmxKkrwwW6cOK5SBHocKKvdq8wyrTTO4W/QVKEmuT0SyzVLJk
	 DuXXgR9oMi1QaDOmONoZ2ikIQmwdBdV2ZrgZ7QoMvaY7mMiLh0zs1Q7PyRKAwpfl1M
	 1cmK3vuLsv+8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B45D6C53BD2; Sat, 20 Jan 2024 05:48:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 20 Jan 2024 05:48:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-W6uEPnyak5@https.bugzilla.kernel.org/>
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

--- Comment #36 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
(In reply to Pedro from comment #30)
> Recommending reproducing the issue without using that at all first, it's
> going to keep on getting the blame until it's proven not to interfere.

So I shutdown the PC and started it, disabled any scripts that might trigger
`ryzenadj` beforehand. There were no suspend/resume cycles since booting.

About 4 hours later, the CPU was stuck at 400MHz.


(In reply to Mario Limonciello (AMD) from comment #32)
> As I mentioned in the other issue, to rule out a kernel bug we may want to
> look at the output of these MSRs while the issue happened.  If those are
> correct for what has been programmed to scaling_max_freq, then we may be
> dealing with a firmware bug.
>=20
> #define MSR_AMD_CPPC_CAP1             0xc00102b0
> #define MSR_AMD_CPPC_ENABLE           0xc00102b1
> #define MSR_AMD_CPPC_CAP2             0xc00102b2
> #define MSR_AMD_CPPC_REQ              0xc00102b3
> #define MSR_AMD_CPPC_STATUS           0xc00102b4

MSRs before:

    0xc00102b0:  ba46290fba46290f
    0xc00102b1:  1
    0xc00102b2:  0
    0xc00102b3:  a6a6
    0xc00102b4:  0

MSRs while forced underclock:

    0xc00102b0:  ba46290fba46290f
    0xc00102b1:  1
    0xc00102b2:  0
    0xc00102b3:  e0e
    0xc00102b4:  0


(In reply to Mario Limonciello (AMD) from comment #34)
> Can you guys please test this:
>=20
> https://lore.kernel.org/linux-pm/20240119113319.54158-1-mario.
> limonciello@amd.com/T/#u

I'll give this a go.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


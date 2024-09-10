Return-Path: <linux-pm+bounces-13917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC9972654
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 02:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC4D1F22263
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 00:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7254658;
	Tue, 10 Sep 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO+9/z3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A06A01E
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929372; cv=none; b=kOkwTzQv0wRYkLVi16mKkmMVhVefREGtfijKmO4u0OWDsCoK4Qon8O3BwK/VdCfWib4tJgQVG6fW0ojEeg4zbYMJlJmtP4kfxhL4e7NEFknYA7AqK8Pvi7tECi8r5y13Zg+rA4H2aQH4mWuHJ6vsBxewoc+QwooY8s2UqbIirLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929372; c=relaxed/simple;
	bh=KUn9qJ9XNFNKbTJ636Rc7pZzBGVnHcGFh2A7Tg2zzqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOCV8GBPXFXS7t5N5EOQGXHbrYR5b0n5hthUgnbbuejDgpbWggrLNh3LTYuIl439cM3RmMnWrOlYqPndoBOTSQZBs10sS0dgddP16IKyni8AEH0XyJc9040NOgVIb1A936MZLsZBwATJsNh7L27QiSKHpZ1HFrkMriR/qSsXTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO+9/z3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D35EC4CED0
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725929372;
	bh=KUn9qJ9XNFNKbTJ636Rc7pZzBGVnHcGFh2A7Tg2zzqs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HO+9/z3sywR8g3aacgOUIMzxvsUYdWHTCnWIpgbPnuu53CAAqZC1ksKPNMkGBsFNt
	 59pBKBwG72hKPO7d4YesueAD9zhy+hYwUvddE6hw4HRUzDehVOI6rRtt9nfCfTC5jz
	 D1y/5tbvPBuC+9DbUgsDSPAFTYCqkwMXN0AznUGIQy1jTDTSSsA9gKopw/ep6kUabU
	 OcuIGY1FTjo+O4Ldl1RD+YEpuxFl6q4wMbsGhADnwGBM4gCZnpxqfzb1NGwyf6GXD9
	 z1jpDUZkqNrXvUlzb/jYEiFKJPi3kALWpeROHy3yVNGeF+2UmiFrEuzBlRfYSTNgeA
	 fwWP4vtfaMJKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 24ACFC53BB8; Tue, 10 Sep 2024 00:49:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 10 Sep 2024 00:49:31 +0000
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
Message-ID: <bug-218686-137361-JNGf2Cx8zI@https.bugzilla.kernel.org/>
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

--- Comment #93 from al0uette@outlook.com ---
(In reply to derp from comment #90)
> There's no ideal diagnostic tool for that, as for frequencies they are se=
en
> as something like that, but it was probably the same or very close without
> CPPC
>=20
> (I wouldn't mind if all of these somehow got to 400Mhz instead of 1400Mhz
> though)
>=20
> cat /proc/cpuinfo|grep MHz|sort
> cpu MHz         : 1395.796
> cpu MHz         : 1396.448
> cpu MHz         : 1397.373
> cpu MHz         : 1397.388
> cpu MHz         : 1397.403
> cpu MHz         : 1397.414
> cpu MHz         : 1397.434
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
> cpu MHz         : 400.000
>=20
> the main difference can be seen in amdgpu_top, which for some reason trea=
ts
> CPU cores as GPU cores
> it can show mW per Core, and even when frequency stays at 1400, the mW po=
wer
> assigned to these cores is much much smaller, as well as total "GFX" power
> which is the total APU power, I guess
>=20
> "GFX" is now about 700 mW and "SoC" about 400mW when idle
>=20
> power savings are about 1W for system idle and low-power activities

Strangely, the gfx power almost always stays above 2000mw for me, the lowest
value it can go is about 1600mw, but it can only stay there for just 1 seco=
nd.
Is it because our cpu are different? But even though my power consumption is
higher than you, it's still better than acpi-cpufreq and the cpu temperatur=
e is
significantly lower than acpi-cpufreq

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


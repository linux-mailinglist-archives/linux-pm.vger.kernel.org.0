Return-Path: <linux-pm+bounces-16619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A49B3A5D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 20:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B11528247F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 19:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712EF18F2FD;
	Mon, 28 Oct 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8c/ayiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AA18F2DA
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143368; cv=none; b=DpiojyJiEebuepLMj2q5en9zxYdRgHemqLAg3DBpi8sG3fyDvm0+APpH/kmbkdmQGBpV+sMP/2ifH+oYhqKm5HozLNb2DaARhYv/DbJhXVv+TDOf1NegrDNU6RQdOLYrldJJRe4wwp/8F/km9hDV8GD+BKItGUzrZF6rxWgA4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143368; c=relaxed/simple;
	bh=CbObgP7IIl3aP9ALobbAUxvjEB1cz2+fRVVHoiOBfqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B10SQr9r/hhF8F1c/wPGTh9tL1UnmyzkdFcTR/Fg9T0L0hEh8jrM6NBD1Mm+NlTRbUQlKWkXV49NBabfOXmPOOmkHO5Aw192naOBUHTeUt7mCup+Cf1jhNV4wQQsGtLr3L7RkvFy2bhKbQRbMTg9YxVQaNKr7XJ3AASFgxA+YH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8c/ayiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D48F5C4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730143367;
	bh=CbObgP7IIl3aP9ALobbAUxvjEB1cz2+fRVVHoiOBfqI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e8c/ayizQc3ANtzuvT9bwsC7f5FomUgvJ9FXM62BbX+NOCiNlFv9d6XJJLjigGuzh
	 ODg6zPAkvjVbRGfNU+C4laK+QDjc8ayak0MAegNnaP4rMO6yvH0ZhbMhYgqrNiNmO0
	 e4jTJCB5VtYgBAD8we3lPHt3IESwQISWB0KJBXZ3+D/yRCeG3ey5pi+8mBS/BshPul
	 d9AFRKh9cO5D6IgLTqNuDk3vFPfbcMSQhq9K52s1OEwThqi8/7Xj/UnPlAZsnnv/7J
	 E/W+e7ucxdoR/m8pR90WYu05Yq64GvL5Ixom0c2vjoKhUUCo7osjaQV9RzdmByDRqJ
	 iLXDnlm0pS9lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C3266C53BBF; Mon, 28 Oct 2024 19:22:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 19:22:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-4mb9M1Qiuu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #10 from Ivan Shapovalov (intelfx@intelfx.name) ---
(In reply to Mario Limonciello (AMD) from comment #5)
> It looks like this message is being emitted specifically from the calls in
> amd_set_max_freq_ratio().
>=20
> You system is a shared memory design not a MSR design.
> "[  +0.000016] amd_pstate: AMD CPPC shared memory based functionality is
> supported"

I assumed that all Zen 3 desktop parts are ACPI CPPC-based rather than
MSR-based? That's why I mentioned Vermeer in both my original mail and this=
 bug
report.

> This looks like the calltrace:
> amd_set_max_freq_ratio
> ->amd_get_boost_ratio_numerator
> ->->amd_detect_prefcore
> ->->->amd_get_highest_perf
> ->->->->cppc_get_highest_perf
> ->->->->->cppc_get_perf
>=20
> The first error you see is "No CPC descriptor for CPU:1" which comes from
> cppc_get_perf().
>=20
> Can you please share your acpidump?  It sure seems like a BIOS bug to me.

There is also an interesting observation, that at some point *after* this
warning we get a pr_debug() from the end of amd_detect_prefcore(), which
indicates that the latter is called again and this error does not happen
anymore:

```
Oct 28 17:13:08 kernel: ACPI CPPC: CPPC v2 _OSC not acked
Oct 28 17:13:08 kernel: ACPI CPPC: Parsed CPC struct for CPU: 0
Oct 28 17:13:08 kernel: ACPI CPPC: TX completed. CMD sent:0, ret:0
Oct 28 17:13:08 kernel: ACPI CPPC: TX completed. CMD sent:0, ret:0
Oct 28 17:13:08 kernel: ACPI CPPC: No CPC descriptor for CPU:1
Oct 28 17:13:08 kernel: Could not retrieve highest performance (-19)
<...>
Oct 28 17:13:08 kernel: amd_pstate: AMD CPPC shared memory based functional=
ity
is supported
Oct 28 17:13:08 kernel: ACPI CPPC: TX completed. CMD sent:0, ret:0
Oct 28 17:13:08 kernel: ACPI CPPC: TX completed. CMD sent:0, ret:0
Oct 28 17:13:08 kernel: AMD CPPC preferred core is supported (highest perf:
0xe7)
```

It's even more interesting that the debug logs from the amd-pstate flow you
described earlier appear to be interleaved with debug logs from
acpi_cppc_processor_probe():

```
Oct 28 17:13:08 kernel: ACPI CPPC: CPPC v2 _OSC not acked
Oct 28 17:13:08 kernel: ACPI CPPC: Parsed CPC struct for CPU: 0
Oct 28 17:13:08 kernel: ACPI CPPC: TX completed. CMD sent:0, ret:0
Oct 28 17:13:08 kernel: ACPI CPPC: TX completed. CMD sent:0, ret:0
Oct 28 17:13:08 kernel: ACPI CPPC: No CPC descriptor for CPU:1
Oct 28 17:13:08 kernel: Could not retrieve highest performance (-19)
Oct 28 17:13:08 kernel: Monitor-Mwait will be used to enter C-1 state
Oct 28 17:13:08 kernel: ACPI CPPC: CPPC v2 _OSC not acked
Oct 28 17:13:08 kernel: ACPI CPPC: Parsed CPC struct for CPU: 1 <-- THIS
```

I'm not familiar with control flow in these subsystems, but isn't it possib=
le
that we are simply racing with ACPI (and thus CPPC) subsystem initializatio=
n?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


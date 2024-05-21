Return-Path: <linux-pm+bounces-8015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65868CA8E9
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8B1F216ED
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5014F217;
	Tue, 21 May 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoUTJCf0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DB179BD
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276486; cv=none; b=Lx9mRh8T9oFtoX5qx+xaKQ/yKgznVnlm00ri2szTpZnUPdKO+3b2xpfaWKMjTSYzvdp1fO2DMZJcP8EEv26TncUxrrPsbEko9ehjCrVmtwxTv1HM9tw+v/AQasQpM8yW3IlFjAnOYY+HhmnyUM+t7MojV37cBBo/bM+nCJ4wS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276486; c=relaxed/simple;
	bh=rBasFPBW5J/MJijGBrhK1ZaxPm5hHJKKqEsPJvY6dPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uwh7NrweHhrKBSIzlzOsM0L5FkSB1vnia5F43cEcKVp6AaykFH+Kt9Wp2DbB8rGv3ca5ceyKI/+zzymc3BwJvyGiW/XkKiARSPYsUU5PoUrl1/XmOWKhU/KKHO2drllrbaakcppfALU7DLQYbtz/17BlHG//AgiTxDbnf+2Dc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoUTJCf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C31C4AF08
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276485;
	bh=rBasFPBW5J/MJijGBrhK1ZaxPm5hHJKKqEsPJvY6dPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aoUTJCf0np7K8jhfx7KKu466IwvFoDZ8Pn/SE/ULmxKSk0FbLfE1D4XUlJu0fwO37
	 aQHycOHhPqCZgOrcAFtbYPIl8n9egnH+aPaFCLMFj87SATv2HSFiPgLCJFU++I6phv
	 hl9Mr0GvYAZuVy/J+rkQVTmFFbAGw3nKWbZfH+zORgVrcIRRYE481AY+Eui22SfaHf
	 nB+TwgkKQE1n95moykO4kqJcFkUdJ7soRqYCR4bCVMgHT1H1iwAScEB7WTRsxERTjr
	 x11HDxRoKe6OVJ0RrQTy80dqJ0fKl+azUt2x+dC8Txi7xg39zCsetQnTgPQTItmKa0
	 UbiHcd9fhVgFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 742F3C53BB7; Tue, 21 May 2024 07:28:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Tue, 21 May 2024 07:28:05 +0000
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
Message-ID: <bug-218865-137361-GBjLfMaa6u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

--- Comment #4 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Matthew Stapleton from comment #0)
> I recently deployed a custom kernel build with X86_AMD_PSTATE_DEFAULT_MODE
> set to 1 (Disabled) to a newer AMD system: AMD Ryzen 3 4100 that supports
> cppc and got a NULL pointer reference crash so I had to add
> amd_pstate=3Dactive on that system to get it to boot.  The same kernel bo=
ots
> fine on older AMD systems that don't support cppc.
>=20
> The kernel is 6.6.22
>=20
> This is what I think is happening when no amd_pstate parameter has been
> specified although I haven't tested a patch yet:
> in function: amd_pstate_init the cppc_state starts as AMD_PSTATE_UNDEFINE=
D.
>=20
> On older systems that don't support CPPC, !boot_cpu_has(X86_FEATURE_CPPC)
> tests true so "driver load is disabled, boot with specific mode to enable
> this" is printed and -ENODEV is returned.
>=20
> On the newer systems that support CPPC , it goes on to "ret =3D
> amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);" .  Then
> amd_pstate_set_driver sees AMD_PSTATE_DISABLE , prints "driver is explici=
tly
> disabled" , doesn't assign a driver to current_pstate_driver, but still
> returns 0.  So then the switch statement in amd_pstate_init breaks and th=
en
> I suspect it crashes at "current_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;" just below the switch statement.
>=20
> If this is the case, maybe adjusting amd_pstate_set_driver to return -ENO=
DEV
> if cppc_state =3D=3D AMD_PSTATE_DISABLE might fix the problem.
>=20
> Here is some of the crash output (manually typed from a photo):
> amd_pstate: driver is explicitly disabled
> BUG: kernel NULL pointer deference, address: 0000000000000050
> ...
> ? __die+0x1a/0x60
> ? page_fault_oops+0x17c/0x4a0
> ? _prb_read_valid+0x263/0x2e0
> ? exc_page_fault+0x33f/0x610
> ? prb_read_valid+0x12/0x20
> ? asm_exc_page_fault+0x22/0x30
> ? amd_pstate_init+0x90/0x260
> ? amd_pstate_param+0xb0/0xb0
> do_one_initcall+0x82/0x2c0
> kernel_init_freeable+0x1af/0x260
> ? rest_init+0xb0/0xb0
> kernel_init+0x11/0x1b0
> ret_from_fork+0x2b/0x40
> ? rest_init+0xb0/0xb0
> ret_from_fork_asm+0x11/0x20

Could you try the patch lately posted while I am trying to find a system to
reproduce?
https://lore.kernel.org/lkml/9b31fbcdfd4e4f00c3302f45e655aa43589b224c.17153=
56532.git.perry.yuan@amd.com/

I have changed the mode selection code a bit, it will be great if you can h=
elp
to try this on your system,  if the issue still can be reproduced, I will n=
eed
to chang the patch accordingly.
thanks.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-8005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B28CA553
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 02:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2C1C20BDF
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAA610C;
	Tue, 21 May 2024 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXGgjmsI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45C4C6F
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250503; cv=none; b=EhM80nHvlpf58pUF06XNjd7tdkRsVwgrsDxEvGsLVmIChHGUpN3EDFZObwd5RsbPgYBcsdyGZJv9kRZiZS7CFGCYdnrq5A47QqaOOk73BYyczc0RrZTHFIlgryNmWTA8p+KhmgLMxjAOBnW8tCh0GH0Lr7s/kLfHty/X+8ExaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250503; c=relaxed/simple;
	bh=0M13J1fsB0IxtZMqyEz0k+rznpF6508Ob59scroHeOc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Lw97VT0WkYfFJLerdEx4iQBWLOmeHnZI4IqQJaB436mvYzp5tetUFL1doxK+crZyhx3V2k0XWfnwZf9NemprJg7JPQCWhZzP0IWjsq/PVOPGAwT3YsW3eOlgYGCFFITjOfYVfGmc8QOotLj/1yrttSkamNQQxw46qM9hqdjwKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXGgjmsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C4E4C32786
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716250503;
	bh=0M13J1fsB0IxtZMqyEz0k+rznpF6508Ob59scroHeOc=;
	h=From:To:Subject:Date:From;
	b=qXGgjmsIVTD2nXADYp2WdFYcX0ZVNxOVxUQW9tq34IGZAioJa08A+EuaE6QGumu24
	 7LqtZbYJZXycrHj6UdfrD9+L87eg5si9t8w9y30zU68eA3PRJmzrzYJUqipFMJ0u3n
	 eavJ442KzNqtq5E/q+QmddInaKDEygcfJsK1bBf23tX7dFprBvlh5lqiUzkp7e+s2X
	 EEcoyzz3VziPEQx/hB8X+7pdPW42xHdOjO9cVTKTb+0BSN2bq6FfzUW8Ju1ruJvzmR
	 w6VT7P0/6wxv9/W9NVwnEXtgGQ9fajCCI27n9yIQKMMNhVKD0l1qYhqYxtPXKMD2rY
	 gno58ABB8Qsfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D6D3C53BB0; Tue, 21 May 2024 00:15:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] New: NULL pointer reference if amd_pstate=disabled on a
 AMD CPU that supports CPPC
Date: Tue, 21 May 2024 00:15:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218865-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 218865
           Summary: NULL pointer reference if amd_pstate=3Ddisabled on a AMD
                    CPU that supports CPPC
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: matthew4196@gmail.com
        Regression: No

I recently deployed a custom kernel build with X86_AMD_PSTATE_DEFAULT_MODE =
set
to 1 (Disabled) to a newer AMD system: AMD Ryzen 3 4100 that supports cppc =
and
got a NULL pointer reference crash so I had to add amd_pstate=3Dactive on t=
hat
system to get it to boot.  The same kernel boots fine on older AMD systems =
that
don't support cppc.

The kernel is 6.6.22

This is what I think is happening when no amd_pstate parameter has been
specified although I haven't tested a patch yet:
in function: amd_pstate_init the cppc_state starts as AMD_PSTATE_UNDEFINED.

On older systems that don't support CPPC, !boot_cpu_has(X86_FEATURE_CPPC) t=
ests
true so "driver load is disabled, boot with specific mode to enable this" is
printed and -ENODEV is returned.

On the newer systems that support CPPC , it goes on to "ret =3D
amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);" .  Then
amd_pstate_set_driver sees AMD_PSTATE_DISABLE , prints "driver is explicitly
disabled" , doesn't assign a driver to current_pstate_driver, but still ret=
urns
0.  So then the switch statement in amd_pstate_init breaks and then I suspe=
ct
it crashes at "current_pstate_driver->adjust_perf =3D amd_pstate_adjust_per=
f;"
just below the switch statement.

If this is the case, maybe adjusting amd_pstate_set_driver to return -ENODE=
V if
cppc_state =3D=3D AMD_PSTATE_DISABLE might fix the problem.

Here is some of the crash output (manually typed from a photo):
amd_pstate: driver is explicitly disabled
BUG: kernel NULL pointer deference, address: 0000000000000050
...
? __die+0x1a/0x60
? page_fault_oops+0x17c/0x4a0
? _prb_read_valid+0x263/0x2e0
? exc_page_fault+0x33f/0x610
? prb_read_valid+0x12/0x20
? asm_exc_page_fault+0x22/0x30
? amd_pstate_init+0x90/0x260
? amd_pstate_param+0xb0/0xb0
do_one_initcall+0x82/0x2c0
kernel_init_freeable+0x1af/0x260
? rest_init+0xb0/0xb0
kernel_init+0x11/0x1b0
ret_from_fork+0x2b/0x40
? rest_init+0xb0/0xb0
ret_from_fork_asm+0x11/0x20

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


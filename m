Return-Path: <linux-pm+bounces-16625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2879B3C9C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA11C22154
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2611E0DD9;
	Mon, 28 Oct 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk2VjB4m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AF1D2796
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150553; cv=none; b=OTNJrsrD/yqME7PbhCb3GmV+W+n7+jihw6+YJdnHAwvWRXbO9cyMrflrfabXj0uqL7xTZlXna6ZpwVyY9sxeq5XZqibMpCORyIZzZeuCyk/MzDB8LylU3ZGwkYghsIGZcDWUYsSHnjNh3/saSGAre604IQ6ZjnsLMOKYFmZ0SZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150553; c=relaxed/simple;
	bh=tA26OVakOS/adYZniWL2Ukr7f1MGHO3o7Owvx6xjbgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwffIN2qQVjeR3/JxjTBnrp6VZuZZbRhH3ssjx+FIi0zNlTw5FvZp5+SBCmQNxamKsrfHkHW8dWbP85PM0t0G7gwyOd2t2OnC+pdVuLAGoJwQp4+udVzScumyNQ8ILbWMi7Qy1KwTT1kIqWc93dzSrEk3YVrinSN9C7oLKwVtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk2VjB4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04793C4CECD
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730150553;
	bh=tA26OVakOS/adYZniWL2Ukr7f1MGHO3o7Owvx6xjbgM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Jk2VjB4m0SwE6YgfhX72hkZrn4iX3lBk5+drvrqhupSUSQhxHehMqfJW3mvAycpg2
	 DX0tq5+qXbuCuL1AyXAOPe1S5u7dQV+A5RNXC762Kg+49s7IRmm+IKaIL667KbUueJ
	 DU0NahGTfz1pSMD0hZX/xtECjEMVNvz7Ai3jmtwhhwlUrUyCHXg34FMVVcBBNRclHF
	 fWEhXwVFVqiolnw3WzdDAoPiQF2OUS/808F/egE27jpwAW2lEZUeXSd93Ej3MCzed9
	 LvPKMmqcxOx9PdhSc6qQkb2XTqbRoAo+EpvTfvklqJUBwpao46DFtNu8Tw33qo0Axh
	 MqRupvBOqq3qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EBDE3C53BC8; Mon, 28 Oct 2024 21:22:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 21:22:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-017Y0xZOCm@https.bugzilla.kernel.org/>
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

--- Comment #13 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> I suspect the answer is yes.

Actually; no it should be new, but it's because the frequency calculation w=
as
wrong before.

I found a system with shared mem and I have a theory what's going on is that
frequency invariance is attempting to get setup before all CPUs have probed.

Before the preferred cores code frequency invariance would be calculated fr=
om
the first CPU only as _CPC is probed.  But with preferred cores code in pla=
ce
you need ALL _CPC values present to know whether you have preferred cores or
not.

I added some dump stack calls to acpi_cppc_processor_probe when the struct =
is
parsed:

ACPI CPPC: Parsed CPC struct for CPU: 0
CPU: 0 UID: 0 PID: 23 Comm: cpuhp/0 Not tainted 6.12.0-rc5-00026-g0c7b88322=
6dd
#268
Hardware name: LENOVO 30E1S68903/1046, BIOS S07KT5BA 01/26/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x60/0x80
 acpi_cppc_processor_probe+0x9fc/0xe50
 acpi_soft_cpu_online+0x69/0x160
 ? __pfx_acpi_soft_cpu_online+0x10/0x10
 cpuhp_invoke_callback+0x308/0x4c0
 ? srso_return_thunk+0x5/0x5f
 ? __pfx_smpboot_thread_fn+0x10/0x10
 cpuhp_thread_fun+0x131/0x210
 smpboot_thread_fn+0x187/0x220
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Then I added one to the error sequence.

ACPI CPPC: No CPC descriptor for CPU:1
CPU: 0 UID: 0 PID: 23 Comm: cpuhp/0 Not tainted 6.12.0-rc5-00026-g0c7b88322=
6dd
#268
Hardware name: LENOVO 30E1S68903/1046, BIOS S07KT5BA 01/26/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x60/0x80
 cppc_get_perf+0x127/0x1c0
 amd_get_highest_perf+0x5e/0x80
 amd_detect_prefcore+0x7a/0x130
 amd_get_boost_ratio_numerator+0x28/0x90
 init_freq_invariance_cppc+0xad/0x140
 acpi_cppc_processor_probe+0x7ce/0xe50
 acpi_soft_cpu_online+0x69/0x160
 ? __pfx_acpi_soft_cpu_online+0x10/0x10
 cpuhp_invoke_callback+0x308/0x4c0
 ? srso_return_thunk+0x5/0x5f
 ? __pfx_smpboot_thread_fn+0x10/0x10
 cpuhp_thread_fun+0x131/0x210
 smpboot_thread_fn+0x187/0x220
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Could not retrieve highest performance (-19)

You can see that in both cases the code runs on CPU0.  So it's trying to get
values that won't be initialized until CPU1 is ready.

I think this will help "prevent" the error from coming up:

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 5e9325273a9fb..a21c26d1fe65a 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -190,7 +190,7 @@ int amd_detect_prefcore(bool *detected)
                break;
        }

-       for_each_present_cpu(cpu) {
+       for_each_online_cpu(cpu) {
                u32 tmp;
                int ret;

But it's going to probably break preferred cores detection, so it's not a
correct solution.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


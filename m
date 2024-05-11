Return-Path: <linux-pm+bounces-7740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8248C331C
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD731C20A75
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54271CA9E;
	Sat, 11 May 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgajwqdw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778051C6B2;
	Sat, 11 May 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715451768; cv=none; b=GR/b+zJ7tC+jMXEmYlI3P9i01KSMVdRGQ8pJm1ncPBx3VxrbROBbmNpZHYGfJXhXSgT+QlYhTMUdfl85KY8PzGG6uuAD/nwXKRcRVUK/iLNXAAYMzvAK26K16u/h8uPVtmaVBVSaUXDZ1VZuldGCf/SP/lnyf4qHrJgxHJOLy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715451768; c=relaxed/simple;
	bh=waBiqpVY4okCKgPx8H2XpUP16xIzo+kJ+6F408ry6sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m4haQW0jxQCtCN4S8y/7gf9g/OqLZKoVJOtBbvr2wuC1lo1NrzeR6yzijeQs7c9pR1AsL5ZMvxnOntodUgRzqi4btYL/6YxwS0wNW/1y127JIRGIeJHccdgo5OOSQlG+tc7lRf6TTDReK5gvgy+RrhgZziRpECt5+q4jU91IS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgajwqdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0933C2BBFC;
	Sat, 11 May 2024 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715451768;
	bh=waBiqpVY4okCKgPx8H2XpUP16xIzo+kJ+6F408ry6sE=;
	h=From:To:Cc:Subject:Date:From;
	b=jgajwqdwi1eAbcu6oEbQMP9Mq1f4RrxQn3fEwRiVXmtZKvIoxC0NB+F6rP9LpkzBT
	 PC0ONMoHPA8QEG1AvwlNoEgR3Q4crw58gYsue/UEljBRpuCGf0hC42e+JVmMYuiSmF
	 CaGLxMIjoO0ADqdF7gpL8LsnTn/7YqruDJLZXt6ZRbwt1/iFXA39rmmZ+HPf5MCkvO
	 ZPadjKeg/t2iGY5CFL532ofkPs5DbFiDa2Cly60cd9iZ7/Bnwq3IjIvMIaBB+wI0nC
	 1Z/SiZRsKn3WAKVBA1pohVq0ROLxx3rqM+oXyP/8Wbp/KnjE+a8BXmdm24aUdhoZmI
	 ijklolw36X3wg==
From: Kalle Valo <kvalo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
    regressions@lists.linux.dev,
    Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [regression] suspend stress test stalls within 30 minutes
Date: Sat, 11 May 2024 21:22:43 +0300
Message-ID: <87o79cjjik.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I have a weird problem with suspend. Somewhere around v6.9-rc4 or so (not sure
exactly) I started seeing that our ath11k Wi-Fi driver suspend tests to
randomly fail. I have been investigating this for some time and now it
looks like it's somehow related to CPU_MITIGATIONS Kconfig option and
nothing to do with wireless.

The simplified test case I have is to run suspend and resume in loop
like this (Wi-Fi modules are not loaded):

for i in {1..400}; do echo "rtcwake test $i" > /dev/kmsg; rtcwake -m mem -s 10; sleep 10; done

If CPU_MITIGATIONS is enabled I usually see suspend stalling within 30
minutes. If I disable CPU_MITIGATIONS using menuconfig I don't see the bug.

When the bug happens in the kernel.log I see this and suspend stalls:

[  361.716546] PM: suspend entry (deep)
[  361.722558] Filesystems sync: 0.005 seconds
[  624.222721] kworker/dying (2519) used greatest stack depth: 22240 bytes left
[  633.897857] loop0: detected capacity change from 0 to 8

And if I don't do anything for several minutes nothing happens. What is
really strange is that once I run 'sudo shutdown -h now' then suspend
somehow immediately unstalls and continues with suspend, like this:

[  847.631147] Freezing user space processes
[  847.649590] Freezing user space processes completed (elapsed 0.016 seconds)
[  847.650710] OOM killer disabled.
[  847.651799] Freezing remaining freezable tasks
[  847.654618] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  847.663757] printk: Suspending console(s) (use no_console_suspend to debug)
[  847.710060] e1000e: EEE TX LPI TIMER: 00000011
[  847.852370] ACPI: EC: interrupt blocked
[  847.899416] ACPI: PM: Preparing to enter system sleep state S3
[  847.933433] ACPI: EC: event blocked
[  847.933437] ACPI: EC: EC stopped
[  847.933441] ACPI: PM: Saving platform NVS memory
[  847.933817] Disabling non-boot CPUs ...

And now the system goes into suspend state as it should. And if I press
the power button on the device then the system resumes and after that
shuts down (as expected because I run the shutdown command). This
behaviour is consistent, I see it every time the suspend bug happens.

The test setup is a several years old Intel NUC x86 system, more info
below.

Any recommendations how should I debug this further? I tried to bisect
this earlier but that failed, most likely because I hadn't yet realised
that this is related to CPU_MITIGATIONS and might have messed up the
.config settings during bisect.

Kalle

DMI: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021

Ubuntu 20.04.6 LTS (GNU/Linux 6.9.0-rc7+ x86_64)

systemd 245.4-4ubuntu3.23 running in system mode. (+PAM +AUDIT +SELINUX
+IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS
+ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2
default-hierarchy=hybrid)

I verified that I see this on latest commit from Linus' tree:

cf87f46fd34d Merge tag 'drm-fixes-2024-05-11' of https://gitlab.freedesktop.org/drm/kernel

Here's the diff between broken and working .config:

$ diffconfig broken.config works.config 
-CALL_PADDING y
-CALL_THUNKS y
-CALL_THUNKS_DEBUG n
-HAVE_CALL_THUNKS y
-MITIGATION_CALL_DEPTH_TRACKING y
-MITIGATION_GDS_FORCE y
-MITIGATION_IBPB_ENTRY y
-MITIGATION_IBRS_ENTRY y
-MITIGATION_PAGE_TABLE_ISOLATION y
-MITIGATION_RETHUNK y
-MITIGATION_RETPOLINE y
-MITIGATION_RFDS y
-MITIGATION_SLS y
-MITIGATION_SPECTRE_BHI y
-MITIGATION_SRSO y
-MITIGATION_UNRET_ENTRY y
-PREFIX_SYMBOLS y
 CPU_MITIGATIONS y -> n


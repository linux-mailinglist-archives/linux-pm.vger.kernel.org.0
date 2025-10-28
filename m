Return-Path: <linux-pm+bounces-36995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0EC17614
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 00:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C931A2695F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 23:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8C307AF0;
	Tue, 28 Oct 2025 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKCngEWo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034C2C15A8
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694643; cv=none; b=VWF3NtkuyYXbbNDJmkObSTvrZJwstMVunW/Y+KzYpDpJ+TB81YPQ4PnrJxigq8smWdLFfidqSF0iJAM9GpUFTfwsLNGRED+DwSoRkDBQH+TtXIIHIJZwvbRQ0JgD77HZX4ut28rD/aV9GNiSm8nA3xuY2guoJNBRKUZP5DsPSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694643; c=relaxed/simple;
	bh=AWECh2OxHra3/PlA8PXFbZQ7bGQzWb8i9TX7i9CFy78=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=djzEVIXoCunNYBNXP83dcFYhfYCQHl2ARx3PuY3pTPYM35407BBpJjGwZvkYp0Lj+G48m0bH3rdVkjy2fuUX66Mqzr88zOCy7n/y+HDSU8PSBpVnCjbUuhgQn/CbR4LGGHCrBn4OX7fIByKTbGYApBsdlvIf8e8XsRRfaYm9TWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKCngEWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9278FC4CEFD
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761694642;
	bh=AWECh2OxHra3/PlA8PXFbZQ7bGQzWb8i9TX7i9CFy78=;
	h=From:To:Subject:Date:From;
	b=gKCngEWoECxdflM5ZuhghoVSiQAIDdOYPoU5iDW3vbO6q2EvfEeeV4b+aGw+zyc54
	 +rj4qA43aIW8RBSE2LGt2YriWd7zMrxeAwH03VzNZD6wTwSJ/kmvjRqpvBOVIZgvSU
	 OTQFNMuKwJ7xZqvS5cRxm2DZPtkjeggIiYx3PFwnNMUbzj4w4acpHsZjJbzOHx2pZX
	 EGvcXXOCcrUG1D1uVOD3hFJc5NMVipdJ5n/+wxCmd/DCGdwAoHGC2hmhFNJ+V2uIsO
	 aBnbG3rE0kOo24R/ibhx5xbe+2GM0h2ti9gy2N2pBYdsZ2oEEBnLU9FGJ7MN7Ivgbf
	 g1XJ9pBvoDb2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 88FB3C41613; Tue, 28 Oct 2025 23:37:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] New: [REGRESSION] AMD P-State fails with "_CPC object
 is not present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 28 Oct 2025 23:37:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression attachments.created
Message-ID: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

            Bug ID: 220715
           Summary: [REGRESSION] AMD P-State fails with "_CPC object is
                    not present" on AMD Zen 4 between 6.10 and 6.11
           Product: Power Management
           Version: 2.5
    Kernel Version: 6.17.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: chris.harris79@gmail.com
                CC: mario.limonciello@amd.com
        Regression: Yes

Created attachment 308864
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308864&action=3Dedit
acpidump, dmesg with current kernel (6.17), dmesg with a last working kernel

This bug was initially reported to linux-pm@vger.kernel.org and I was asked
by Mario Limonciello to open this bugzilla and provide additional debug dat=
a.

SUMMARY
-------
The AMD P-State driver fails to initialize on AMD Zen 4 processors starting
with kernel 6.11.0, returning "_CPC object is not present in SBIOS or ACPI
disabled"
error. The same hardware works correctly with kernel 6.10.0 and earlier.

The regression was introduced between 6.10.0 and 6.11.0.

REGRESSION INFORMATION
----------------------
- Regression: Yes
- Last working kernel: 6.10.14
- First broken kernel: 6.11.0
- Still broken in: 6.17.5, 6.18.0-rc3

ATTACHMENTS PROVIDED
--------------------
1. acpidump.txt - ACPI table dump (same across all kernels)
2. dmesg-6.10.14-061014-generic.txt - dmesg from WORKING kernel
3. dmesg-6.17.5-061705-generic.txt - dmesg from BROKEN kernel
4. system-info-6.10.14.txt - Additional system info from working kernel
5. system-info-6.17.5.txt - Additional system info from broken kernel
tarball: amd-pstate-debug-all.tar.gz

HARDWARE TESTED
---------------
Reproduced on multiple AMD Zen 4 systems:

System 1 (primary testing - multiple identical units tested):
- CPU: AMD EPYC 4484PX 12-Core Processor
- Motherboard: Supermicro H13SRE-F (Version 1.01)
- System: Supermicro AS-3015MR-H10TNR
- BIOS: American Megatrends International, LLC. v2.4 (04/29/2025, Revision
5.35)

System 2 (additional confirmation):
- CPU: AMD Ryzen 9 7950X 16-Core Processor
- Motherboard: Supermicro H13SRD-F (Version 1.00)
- System: Supermicro AS-3015MR-H8TNR
- BIOS: American Megatrends International, LLC. v1.2a (07/10/2024, Revision
5.32)

Both systems exhibit identical behavior with the regression.
CPPC confirmed enabled in BIOS by vendor.

Note: This issue likely affects all AMD Zen 4 processors and possibly other=
 AMD
generations with CPPC support.

REGRESSION TEST RESULTS
-----------------------
Working (amd-pstate loads successfully):
- 6.8.0-84-generic (Ubuntu 24.04)
- 6.8.0-86-generic (Ubuntu 24.04)
- 6.9.0-060900-generic (Ubuntu mainline)
- 6.10.0-061000-generic (Ubuntu mainline)
- 6.10.14-061014-generic (Ubuntu mainline) <- LAST WORKING (latest 6.10.x)

Broken (falls back to acpi-cpufreq with _CPC error):
- 6.11.0-061100-generic (Ubuntu mainline) <- FIRST BROKEN
- 6.12.0-061200-generic (Ubuntu mainline)
- 6.13.0-061300-generic (Ubuntu mainline)
- 6.14.0-061400-generic (Ubuntu mainline)
- 6.16.7-061607-generic (Ubuntu mainline)
- 6.17.1-061701-generic (Ubuntu mainline)
- 6.17.5-061705-generic (Ubuntu mainline)
- 6.18.0-061800rc3-generic (Ubuntu mainline RC)
- 6.17.1-1-cachyos-server-lto (Arch Linux)

ERROR MESSAGE
-------------
[    4.508125] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled

STEPS TO REPRODUCE
------------------
1. Boot with kernel parameter: amd_pstate=3Dpassive
2. Check driver: cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
   Expected: amd-pstate
   Actual: acpi-cpufreq
3. Check dmesg: dmesg | grep "_CPC"
   Shows: "the _CPC object is not present in SBIOS or ACPI disabled"

KERNEL CONFIGURATION
--------------------
All tested kernels have identical AMD P-State configuration:
CONFIG_ACPI_CPPC_LIB=3Dy
CONFIG_X86_AMD_PSTATE=3Dy
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
CONFIG_X86_AMD_PSTATE_UT=3Dm

TESTING ENVIRONMENT
-------------------
- Tested with vanilla kernels from Ubuntu mainline PPA
- No additional modules or patches
- Kernel not tainted
- Reproduced on both Ubuntu 24.04 and Arch Linux distributions

IMPACT
------
This regression prevents affected AMD systems from using the optimized AMD
P-State
driver, forcing fallback to generic acpi-cpufreq with approximately 5-10%
performance loss for server and desktop workloads. Confirmed on both AMD EP=
YC
4484PX
and Ryzen 9 7950X (Zen 4), likely affecting all Zen 4 processors and possib=
ly
other
AMD generations that support CPPC/ACPI P-States.

BISECTION RESULTS
-----------------
Through systematic testing of Ubuntu mainline kernels, I've identified the
exact
regression window:

- Last working version: 6.10.14-061014-generic (all 6.10.x versions work)
- First broken version: 6.11.0-061100-generic

The regression was introduced during the 6.11 merge window. All 6.10.x vers=
ions
work correctly (tested 6.10.0 through 6.10.14), while all 6.11+ versions fa=
il.
The issue persists through all subsequent versions tested up to 6.18.0-rc3.

The regression appears to be in ACPI _CPC object detection/parsing, as the =
same
BIOS/hardware combination works with the entire 6.10.x series but fails with
6.11+.

ADDITIONAL INFORMATION
----------------------
The same ACPI tables and BIOS work correctly with 6.8, 6.9, and 6.10 kernel=
s,
confirming
this is not a firmware issue but a kernel regression in CPPC/ACPI handling.

From working system (6.10.14):
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
amd-pstate
- No error messages, driver loads successfully

From broken system (6.17.5):
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
acpi-cpufreq
$ dmesg | grep amd_pstate
[    0.714133] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled

I've tested on multiple systems with identical results. I'm available
for testing patches or providing additional debugging information as needed.

I can perform git bisect between 6.10 and 6.11 if required to identify
the specific commit that introduced this regression.

Thank you for your attention to this regression.

Chris Harris


Keywords:
amd-pstate
cpufreq
ACPI
_CPC
Zen4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


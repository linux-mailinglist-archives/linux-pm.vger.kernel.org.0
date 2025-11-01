Return-Path: <linux-pm+bounces-37247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCB3C287BC
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 21:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 052F34E155F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E22257849;
	Sat,  1 Nov 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJMrWxzR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA911210F59
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028536; cv=none; b=EAFk5qxx5MHWcRUWs9SVtpt2DNpQ9D49rxDTme5jxU/XWcn/VHaVdyiie+MK5PWqBPjr7aH6fSV1lQ9tu85zFZMaZEbDPz2mBpi22wfjg8G8ttz5XPV9sZ3RCtZpuxPzwLLXnx3Judi0JCZL9eqHDby2QeBJGxsWW5Hih17Zkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028536; c=relaxed/simple;
	bh=P80wJm9oSb9BEkejM8tdA3m1EZ8UczWegX3LoxmZHQ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7ewBNySjCjTSP6l08QKFN9+jhpRPRHQHZyQFWOM/hL0g1QDyFsYnacntQLYyOJfM3OKxnxPVJvMLoDP6UaEDqUEm4j0G4SC1lpC77NnpckQ2GvQWkOFOM7+6r/HhhhKG3mJvkVwqCVfPOGNrJWZe1mjbrv54hvY5pZzbcJIy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJMrWxzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E368C4CEFB
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762028536;
	bh=P80wJm9oSb9BEkejM8tdA3m1EZ8UczWegX3LoxmZHQ4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZJMrWxzRBv8tVdh+pGslYEDhdL2NMof6VYAJaiqW0k0yQS/xGGPnQxDVGOJHu91+B
	 zS4be2QFApO9oy8PSVuTGsaGcO/cUeu0543Q/IIBkA9sDMmbNj0xtWbQJtDzmI/ela
	 uyOv3kZ/RPhFijhpgpk+wOd6zy0OTQcrPvM39f4QOKEAu7HmtSSWoBEDGeUkYMpjiZ
	 OWG06oWk8gKqSQsDXeJ+hZqJBFcAL93m43dh9uIiPH/4MrjKubv22eoJtYhiV9+2MD
	 d9br1dYJzZKiPmT2MX2lYrGyy6ooG1HUTnHnG+9ayW1Kjd41OufY6ALstigbdS9IV3
	 ffccHOQ4ooKdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 502F4C41616; Sat,  1 Nov 2025 20:22:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sat, 01 Nov 2025 20:22:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220715-137361-D7WozRRvbQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

Chris Harris (chris.harris79@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |catalin.marinas@arm.com

--- Comment #5 from Chris Harris (chris.harris79@gmail.com) ---
BISECT COMPLETE - REGRESSION IDENTIFIED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Mario,

I've completed the git bisect as requested. The regression has been identif=
ied.

RESULT
------
Bisected commit-id: c1385c1f0ba3b80bd12f26c440612175088c664c
Regression introduced: Linux kernel 6.11-rc1

Commit Details:
Author:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:       Wed May 29 14:34:28 2024 +0100
Commit:     Catalin Marinas <catalin.marinas@arm.com>
CommitDate: Fri Jun 28 18:38:27 2024 +0100

Title: ACPI: processor: Simplify initial onlining to use same path for cold=
 and
hotplug

Link:
https://lore.kernel.org/r/20240529133446.28446-2-Jonathan.Cameron@huawei.com

FILES MODIFIED
--------------
 drivers/acpi/acpi_processor.c   |  7 +++----
 drivers/acpi/processor_driver.c | 43 ++++++++++++-------------------------=
----
 include/acpi/processor.h        |  2 +-
 3 files changed, 16 insertions(+), 36 deletions(-)

COMMIT MESSAGE
--------------
    Separate code paths, combined with a flag set in acpi_processor.c to
    indicate a struct acpi_processor was for a hotplugged CPU ensured that
    per CPU data was only set up the first time that a CPU was initialized.
    This appears to be unnecessary as the paths can be combined by letting
    the online logic also handle any CPUs online at the time of driver load.

    Motivation for this change, beyond simplification, is that ARM64
    virtual CPU HP uses the same code paths for hotplug and cold path in
    acpi_processor.c so had no easy way to set the flag for hotplug only.
    Removing this necessity will enable ARM64 vCPU HP to reuse the existing
    code paths.

    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
    Tested-by: Miguel Luis <miguel.luis@oracle.com>
    Reviewed-by: Gavin Shan <gshan@redhat.com>
    Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

ANALYSIS
--------
This commit unified the ACPI processor initialization paths for cold boot
and hotplug scenarios. While intended for ARM64 vCPU hotplug support, it
inadvertently broke AMD P-State CPPC detection on x86 systems.

The commit changed processor_driver.c to use a unified path, which appears
to have altered the initialization timing or sequence such that _CPC ACPI
objects are no longer properly detected on AMD Zen 4 processors during cold
boot.

BISECT TESTING SUMMARY
----------------------
- Total iterations: 13 (plus 2 skipped builds)
- Range tested: v6.10 (working) to v6.11 (broken)
- Test method: Built kernel from source, tested amd-pstate driver loading
- Test hardware: AMD EPYC 4484PX (Zen 4), Supermicro H13SRE-F

Key tested commits:
- 3346c5668577: GOOD (last working)
- c1385c1f0ba3: BAD (first broken) =E2=86=90 THE REGRESSION

IMPACT
------
This regression affects AMD systems using CPPC/AMD P-State:
- AMD EPYC 4484PX confirmed
- AMD Ryzen 9 7950X confirmed
- Likely affects all Zen 4 and potentially other AMD processors with CPPC

Systems fall back to acpi-cpufreq with ~5-10% performance loss.

DYNAMIC DEBUG RESULTS (Comment #2)
-----------------------------------
Enabled dyndbg=3D'file drivers/acpi/cppc_acpi.c +p' as requested.
No additional debug output was generated beyond the standard error message:
"amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled"

This suggests the _CPC detection fails before debug-enabled code paths exec=
ute.

ATTACHMENTS
-----------
1. bisect-complete.log - Full git bisect log showing all tested commits
2. first-bad-commit-full.txt - Complete diff of the regression commit

NEXT STEPS
----------
The commit author (Jonathan Cameron) and ARM64 maintainer (Catalin Marinas)
are CC'd. This appears to be an unintended side effect of ARM64 vCPU
hotplug work affecting x86 AMD P-State initialization.

A potential fix may need to restore separate handling for cold boot vs
hotplug on x86, or adjust the unified path to properly initialize _CPC
objects during cold boot.

Thank you for the guidance on the bisect process. Please let me know if you
need any additional information or testing.

Chris Harris

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82BB386BA6
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhEQUtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 16:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhEQUtt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 16:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1565B611B0
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 20:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621284513;
        bh=d67NDUFWAXkorQCZvFpgOSGP8Mrbs/tYekCm2dGchMo=;
        h=From:To:Subject:Date:From;
        b=aavvm7LhskdjvxRFx5md+ttk37ryYkhzkhTWl1CrhEi0msoJf6pWdfCb8snM/sWiZ
         tzJJC15ViaAjAV9pvdNEoANYit6s/4ssN1s5+8YaUqiR6Uduy9moy8vzmaiamPruuh
         9OASPH45vrzpATyFaFHjkUzAqtiy8OQpKVmPw592pNYZTLLtT0GmlJdVG2ya7g6q01
         5s/wn3KwStcNHfJxm6AXi6KklSpiqw3mIzTYhTrqa1TAL+DwbnPUqZtDHCReZEK7iu
         b1+7Nv7zbKQvOd8V85HCZkOyS9PicvMbWhFt6JToNG97UqqekZRUSbd+SAwkBwE6bi
         ZQb6gfWVHNxLg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 0C10D61176; Mon, 17 May 2021 20:48:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 213115] New: Unable to set the lowest frequency of AMD CPUs via
 cpupower - while kernel 5.12.4 (or 5.3.18) is booted with "nosmt"
Date:   Mon, 17 May 2021 20:48:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: yan.huang@suse.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213115-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213115

            Bug ID: 213115
           Summary: Unable to set the lowest frequency of AMD CPUs via
                    cpupower - while kernel 5.12.4 (or 5.3.18) is booted
                    with "nosmt"
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.12.4
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: yan.huang@suse.com
        Regression: No

(Opening this bug as a junior team member of the SUSE Customer Support)

A SUSE customer wasn't able to set the lowest possible CPU frequency value =
via
cpupower on SUSE Linux Enterprise Desktop 15 SP2 (with the kernel 5.3.18) on
machines with AMD A12-9720P and AMD Ryzen 5 3550H - while they were booted =
with
"nosmt".

The customer said that this was working on the previous SUSE Linux Enterpri=
se
Desktop 15 SP1 (with the kernel 4.12.14).

Just for this purpose, I purchased a laptop Lenovo IdeaPad 3-15ADA05 with A=
MD
Ryzen 3 3250U and was able to replicate the issue - with the kernel 5.3.18 =
(the
default one for SUSE Linux Enterprise Desktop 15 SP2) and the newest stable
kernel 5.12.4.

AMD Ryzen 3 3250U
- https://www.amd.com/en/products/apu/amd-ryzen-3-3250u
- 1st gen Zen
- 2 cores, 4 threads
- base frequency: 2.60 GHz
- boost frequency: 3.50 GHz
- cpupower frequency-info
 -- hardware limits: 1.40 GHz - 2.60 GHz
 -- available frequency steps: 2.60 GHz, 1.70 GHz, 1.40 GHz

Each time, I ran this command and expected the CPU core/thread frequencies =
to
be =3D< 1400 MHz:
modprobe cpufreq_userspace && cpupower frequency-set -g userspace && cpupow=
er
frequency-set -f 1.40GHz && echo 0 > /sys/devices/system/cpu/cpufreq/boost


Default kernel 5.3.18

I. without "nosmt" (ok)
1) initially:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1308.436
> cpu MHz               : 1218.734
> cpu MHz               : 1301.057
> cpu MHz               : 1377.824
2) after running the command:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1394.225
> cpu MHz               : 1391.125
> cpu MHz               : 1352.398
> cpu MHz               : 1356.574

II. with "nosmt" (fail)
1) initially:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1434.860
> cpu MHz               : 1557.750
2) after running the command:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 2068.443
> cpu MHz               : 1921.816


Kernel 4.12.14 - obtained from
https://download.opensuse.org/repositories/Kernel:/SLE15-SP1/standard/x86_6=
4/
(no longer available)

I. without "nosmt" (ok)
1) initially:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1700.000
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000
2) after running the command:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000

II. with "nosmt" (ok)
1) initially:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000
2) after running the command:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000


Kernel 5.12.4 - obtained from
https://download.opensuse.org/repositories/Kernel:/stable/standard/x86_64/

I. without "nosmt" (ok)
1) initially:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000
> cpu MHz               : 2263.054
> cpu MHz               : 1269.757
2) after running the command:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1400.000
> cpu MHz               : 1340.634
> cpu MHz               : 1400.000
> cpu MHz               : 1400.000

II. with "nosmt" (fail)
1) initially:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1494.915
> cpu MHz               : 2600.000
2) after running the command:
> localhost:~ # grep MHz /proc/cpuinfo
> cpu MHz               : 1731.255
> cpu MHz               : 1400.000


I also tested various kernel versions from
http://download.opensuse.org/repositories/home:/tiwai:/kernel:/ - it seems =
that
the issue started in 5.1.x or earlier (I wasn't able to boot every kernel
version).

I opened a SUSE Bugzilla bug bsc#1175231, but it was decided to not pursue a
fix for this corner-case issue at SUSE's level (the solution is to just avo=
id
"nosmt").

The issue should be replicable even on openSUSE Leap 15.2 with the above
mentioned kernels.

It is possible that the issue is limited to the 1st generation of AMD Ryzen
CPUs (and AMD's pre-Ryzen CPUs).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

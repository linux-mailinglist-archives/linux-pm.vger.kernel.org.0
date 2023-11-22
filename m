Return-Path: <linux-pm+bounces-68-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F847F4127
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 10:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3822817AE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD93B7B5;
	Wed, 22 Nov 2023 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QONSvvgK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51843B796
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 09:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB0B3C433C9
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643892;
	bh=u/O0lFPxNR2JQGfOtceCE0YCFKYi8pV+bmNhXtxBV4I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QONSvvgKMApk6VJ7Yby9dawcxJkK6H6ZnukSvgEaChNmjMvNyoQ5cK1O1ByLbdcSk
	 Z9TSl05K1UG9soy6Xo8TBZO76aTM1CE55+GNo7v/+ATWH9O7wjjmPGuk6JS07qBFmW
	 PqhXZtBdwkT8xDTiwjYXk/Hj6H2b974b5qE8h5euGQjbeRJ66+Jgqw2bYh/TwdktlV
	 jJ9iU0oN2DZ4CEvR6mstJ0CQaIfpPX0fOGYXfrhxjvOpAIR2Cyo+KiP6nD35J6Dm2W
	 AKeJwEPoQT72da2rzB8/9CEMGrq/S1EHeN5yNc1grZHOs7lBlDeVDF8+VL0RypGY5q
	 f7uNwttMogStA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A5CDAC53BCD; Wed, 22 Nov 2023 09:04:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 09:04:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-l6lBllBeMd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #10 from Gino Badouri (badouri.g@gmail.com) ---
Hi Perry,

Unfortunately they're not present:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq': No such file or
directory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf': No such file or
directory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf': No such file or
directory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf': No such
file or directory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf': No such file or
directory

But I guess this is expected as the driver still does not load with linux
kernel 6.7.0 rc2:

[    0.640246] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled

But if you look in ssdt7.dsl from the attachment I just posted, you can cle=
arly
see the _CPC entries are present.
They look like:

        Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
        {
            0x17,=20
            0x03,
            ....

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


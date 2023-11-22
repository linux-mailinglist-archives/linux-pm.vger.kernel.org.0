Return-Path: <linux-pm+bounces-64-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A127F40A7
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1C81C2090D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9F18B1A;
	Wed, 22 Nov 2023 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giA/UyJq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077218F42
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D012CC433C8
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643364;
	bh=vdGqqNdTLzxr/WK+eZVrCtXumALQeFz2k4lqk+xMyKY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=giA/UyJqt5Uz+zvJcJOXzalGMn3P2ditDixSJ59l8nZFY9jtVtpcJWPjxG+C5MvoD
	 HMYeh3pVsiCPOdApTRwuf7+nsDdrccR+wk4X8Wr6O/ZccvfDoKz641HKZQUwwQhjdY
	 PmGo1ETmOde4OEOjlFH84g8SqOcgv01ajUkUd+b8v7SExFBNnVLt/AbNGZ0o+T16gE
	 IlENVHd7LAYrvMXnOa8uEVfAAeMG/zXgbL11jiPELCXjVEpvMovRL+uyUs1+lwL5fW
	 7ylhTOXHeh+eq6bJaBj7N/jHoufxkrSQAEDZwIRdkAWr37etcXB4+6iAafXBkgdngy
	 M3VQwjDioAyJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B38A3C53BD1; Wed, 22 Nov 2023 08:56:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 08:56:04 +0000
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
Message-ID: <bug-218171-137361-GTn4tyuGU1@https.bugzilla.kernel.org/>
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

--- Comment #8 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Please try this and see if the files created.=20

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


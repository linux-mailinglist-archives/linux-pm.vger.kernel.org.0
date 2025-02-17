Return-Path: <linux-pm+bounces-22232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC5A38C6E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861D21893E5D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8E219EA0;
	Mon, 17 Feb 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJRn5R4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62771624F9
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820712; cv=none; b=QC43Pb/ag1k/6q/pifzWSmu9DQJKc5L0SqtVjPwujmdHDJ4GzgIBvBS23HiwTAI4P0cm1h7LcG3vSD6c1JKFUd31COHX22edzd8Xhf9/IMDgXn43u1h9c9BGhj7vHVCODT+WHv49Y/J0S0gBQ15einsThde9uIGrTaEOmJ42ysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820712; c=relaxed/simple;
	bh=VmvXoDjoKabMYLTVMM6QvY4I9+LNyWTAErvNbpzvF84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4GQCJjPAvJK6D/+MRnFGcR9eBy4yw3erDFy0/bj6UvPUz1e0a4sRHtZqR6eJuxWorOVdNzuen/Sg2PXOATzzd5P30lf+lXo2QcMLdTv29lyiiOX/nUdV5QF26yhxxvriMx2HIJ06S+7E3/DCP6YfyFO5HYRJfqh9r48YRbvUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJRn5R4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64212C4CEEA
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 19:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739820712;
	bh=VmvXoDjoKabMYLTVMM6QvY4I9+LNyWTAErvNbpzvF84=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HJRn5R4RYhagsw9IN2hILXB2gR0fEVtG3IcyyPp5amOyYDE8EHP5jaoJiUGKXvdp6
	 TO8DYQ8gJDq/QJHuMes8lQQ3o25f2wVRRilMvD8pL1+jEVCXS8PRRnbv7GLIGGruTM
	 bmNyIMrb6GXuo2wb/73DXCw05ts8xgl4qoaOKqqwbhji9jc27RSTSo1Bi+g8Mfb6n8
	 Mg7XK0HWzenc9/pfiXPYRk5LZnxFp8ACZJCQagMIK7cgTHHpY0KRJjCF6L5b6ZVPp8
	 J0SSEVqaE4ZXszyMMVXmrg0I+CWFcZlhcJ7TBuQ2INuV6J8XXFK2fUBHLYV8oVzWNL
	 b7em+7XpZZRDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5BD6EC41612; Mon, 17 Feb 2025 19:31:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 19:31:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217931-137361-jSvNK06BwU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #74 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 307680
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307680&action=3Dedit
patch to invalidate cached CPPC request at suspend

> Mario, just to be clear, I've run all tests now on unmodified system.=20

OK.

> I'm attaching two new s2idle reports run as root. On the second one I've =
set
> manually the /sys/power/pm_debug_messages to 1. Seems the script is rever=
ting
> it to 0 after running.

Both of these reports look good.  It successfully made it down to HW sleep
state and spent a good amount of time there.

This is how s2idle should generally be looking.

> 2025-02-17 20:08:39,757 DEBUG:        Disabling GPIO #8 interrupt for
> suspend.
> 2025-02-17 20:08:39,805 INFO: =E2=97=8B GPIOs active: ['8']

Just want to point this out that this GPIO appears to be active over suspend
and the Linux kernel intentionally ignores it.  It's not in _AEI() or _EVT()
ACPI methods.  It could be a red herring, but do you know what it's connect=
ed
to?  If not; can you share your full acpidump?  I might be able to figure it
out.

> I'm adding the amd_pstate.py reports as
> 2025.02.17_pstate_reports_Miroslav.zip.

I don't see a problem with CPPC enable register here, which is what my
suspicion was.

BUT what I can see is that there is a problem with the values programmed in
MSR_AMD_CPPC_REQ.  You can see comparing the two that all of the values for=
 min
and max and EPP are totally wrong.

This is most likely an amd-pstate bug you're finding.  I think I see the is=
sue.
 Here's a patch against 6.14-rc for you to try.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-22262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB7A38DED
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539D41890BBA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D31226545;
	Mon, 17 Feb 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouTeSSqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19733F7
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827289; cv=none; b=Cuo7AcMmQjkzp5yTkvtCgViG9QG+M1JP9gAqc/GSeHlt7l2TA7Ae8HmZcURULDn2iIB4ktHfAV6FjA3Lz3bgwhRN7AA1bAzPueRI49DhpaosmCNH+WCmbezkuNgtOOxcVB3MRmSXeVs7TcpaXz/rzFyopDFyPpU6YH66pyW+6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827289; c=relaxed/simple;
	bh=nmfPmRHc2Jb5S61L5iIhoW7YgVubbYxiHfKhdaEcXEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGQuvKWiz2sMxkiyXiy/TZFASVl9H/bkGTaWZN+Y5GiDaTvx6HYyiJROhNjOpoMKGUYKCO6J8JbIHUJ6Dj9s6CVM+VWPVoXO5illsgFE2BLqetG30xd75lZF8L09xZfBJT3sFy1atD606OCz0jJoE4cVtHkWTThHmSxLuykWfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouTeSSqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A897C4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739827289;
	bh=nmfPmRHc2Jb5S61L5iIhoW7YgVubbYxiHfKhdaEcXEY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ouTeSSqXfgkac1lnN5LEZiYLazuVYseqAUnKo5CLw5tiAK/ksjTgtpIVz4NkLJniv
	 JPeDv1NQT+m7/088H9nTQ4f9AfYFTXxgRwfTGhsXqphX6YqE+4Ka5ELui1WFZy6X/x
	 65w5IRlVUABQgSV1pOLJuvTgRDmI/6ujbVnbqFu3Ec8OShys37hGvS1QxwL152wJRH
	 MbmbM3i6VH/8Kj75FPYMFNAjIu/Yv+/cdYIV9HbxhqaU9wNYceNQGzEfljClGO6Lvw
	 r8eu0QHlESgQaqkf99cG67fsr4d77tb83XQpuZ89gdonypT/5uQe5oZ5Y0A0PvJ9xO
	 SmcdGcVDHUzlQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 298ACC41606; Mon, 17 Feb 2025 21:21:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 21:21:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217931-137361-ayTCYZGmM7@https.bugzilla.kernel.org/>
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

--- Comment #79 from Miroslav Pavleski (miroslav@pavleski.net) ---
Created attachment 307683
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307683&action=3Dedit
s2idle and pstate reports after patchv2

I applied the second patch to mainline 6.14rc2, rebooted.

- run amd_pstate.py, results in
amd_pstate_report-2025-02-17-patchv2_pre_sleep.txt
- run amd_s2idle.py, system failed to suspend, hard reset, journal in
patchv2_suspend_freeze_journal.txt
- rebooted, run amd_pstate.py again =3D>
amd_pstate_report-2025-02-17-patchv2_pre_sleep_2nd_attempt.txt
- run amd_s2idle.py , succeeded cycling suspend/resume, report in
s2idle_report-2025-02-17_patchv2.txt
- run amd_pstate.py again after resume =3D>
amd_pstate_report-2025-02-17-patchv2_post_resume_2nd_attempt.txt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


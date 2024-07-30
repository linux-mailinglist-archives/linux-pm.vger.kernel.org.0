Return-Path: <linux-pm+bounces-11691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93148941F37
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C445E1C21E93
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727D118A6A4;
	Tue, 30 Jul 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiUQn0lV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EC189BB6
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362961; cv=none; b=MPt5tBvmHDnrY3Sd2KaCr2oaKgZ1cnygCO5e1LGXbNSDInm2p6LAhJPxs4DKrwFmimxVutRJAmPfwJaSG9ATIizInHTdAVmngCuXawtPxi7B96ijYAbcxrPDq+sEy37xNBMbj1Ee+aYwRKXCoKewID+fIAyTJ1ygl2AQY0eC47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362961; c=relaxed/simple;
	bh=BOE3VORB6ia2yrKuWO/Pcmtm7k+QcUKcZkhKb04y7EQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXNsMNvjH2Cotj83CzYoHUSdjvQs+Zqs9AW3EBAMOmrEYd1u1GnWgym48cUnwowNqZyI5vSDXCRdKe28Au8uJilOepH/QO2XDnhVj/Cp4MTPL8uO8Ql6s9yZJUzblF7QFiA4JNRph+yS8TKUthIn9i07iob9ofCJjYCavHlqBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiUQn0lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC0F4C4AF0E
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722362960;
	bh=BOE3VORB6ia2yrKuWO/Pcmtm7k+QcUKcZkhKb04y7EQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jiUQn0lVGHGtnSEEwqglqxRncNm+nwRJW3jVQcZqRC6yYY0N5AJtQXa9NctxO69p2
	 jZHpI8M3UgZ/zLtGmZ8y9kqX2e4InsjqWtNv5R+iAk5HrOoeN/rH94VDN3DUDm7FLY
	 mcoGA2y8ES6hP5fqDLj8nfTtNPxIehKkhnvOVtM8LVYOi05pUDsTUluN7amqwYZmW1
	 8fsUFdctiwq3+T0XB4d6LmMP/d6P1kVsOwd9fDIKK1EhXSFbi488BtsWEGb0Jg37RI
	 s7C6E6XdR4SoN4Q6QKXBMddz4WgK1H50lvz2MUXtmjEgrfNeprOQh3XwWGIxLjQzkU
	 YN7LkUTTc7lVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CA533C53B73; Tue, 30 Jul 2024 18:09:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Tue, 30 Jul 2024 18:09:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-6sEYCVgqop@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to xiaojian.du from comment #1)
> So you do one suspend cycle on your device?

I have to set/restore energy_performance_preference on every resume.

> I think CPU power status is reset after one suspend cycle.
> Yes, it should be a function to restore CPU power register status and
> governor status after s3/s4/s2idle.
> For you case, i think add one more shell script will fix this problem, you
> know, you are setting cpu enegy policy during booting, then your can add =
one
> same action during suspend, any chance for this?

I can certainly do that, but with acpi-cpufreq you didn't have to do that :=
-(

You set performance/powersave/ondemand and it perfectly survives
suspend/resume.

I wonder why amd-pstate cannot. A kernel module can keep this state as a si=
mple
variable and restore the energy preference on resume.

And secondly it's quite misleading that it reports a wrong value after
resuming.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


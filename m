Return-Path: <linux-pm+bounces-25430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C319DA8930B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 06:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745EE3A1EB2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 04:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1B241CA3;
	Tue, 15 Apr 2025 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3dg1VdA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A32417EF
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744691972; cv=none; b=MOz4BomQXPWPpdH5DmwaK94Yjs/mRuI5DBFPdlOD8cE/oR0vDu2MX65kyOBBpvawKxknacKenDp3SJJs7B5bLle6iOO1erhj69bc+pvR5a2yUFVylblCl2CS5dVvNpmgZRxlMPS48BsXItRWtysswSWOLsh2cwgJUrIoM8oK+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744691972; c=relaxed/simple;
	bh=gTusAZf19zJcGcRnAir2VZCqMjME1iHed5kdT9aaHPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QvnnjtGhK4TliH7Pz74Q6+mIEqfHxtnLn4hVbygjCvL8Ja+4ssAco7F4pwK4I6EhyVVeIPfil0qDCthqEPkJQXu0W0PhhdEMEecCvZP7X/p1KLioxt7Q/B8TPIEB846dO4poHbpJG4racxmiCQeztou0kzmO8Ye73+JiiTP1Rfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3dg1VdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71519C4CEE5
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 04:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744691971;
	bh=gTusAZf19zJcGcRnAir2VZCqMjME1iHed5kdT9aaHPg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r3dg1VdAfrdgLDlTo9iIqUe5VU7SRnMD2MSOeo/8AATkRfYlLCAUycDtq4qgfNmFN
	 rWLWofokM19j1QeueldwOXXR4NyUhdf6koZDdIt5JLkfkGZUauXaA/01dXYXmrFMiG
	 tA6dtDZouEHXGv6HrZrS1ZmWP2IWfqQ7QPv5Ko2ERHjE8+QUqa9i0/CYudRFVXkuPP
	 POwhtqwm3DieTlErfU4U4yHdwVZSKFKG8eSqA8qauDBnC2Od8zhAo7qXr9etYRATem
	 vdzyVm6IErJlJ6nv4ozE39gtHXtl+WBCghAj5fo1Cufr7eeaWCs005CYgQihbbvx2/
	 54IeZHdwGbN7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 28333C433E1; Tue, 15 Apr 2025 04:39:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
 not being restored after resume from suspend
Date: Tue, 15 Apr 2025 04:39:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nic.c3.14@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_regression
Message-ID: <bug-220013-137361-lr6gufiGk8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220013-137361@https.bugzilla.kernel.org/>
References: <bug-220013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

Nicholas Chin (nic.c3.14@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |2b16c631832df6cf8782fb1fdc7
                   |                            |df8a4f03f4f16
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


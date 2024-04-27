Return-Path: <linux-pm+bounces-7230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF98B48DD
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FED6B21544
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857C4EB32;
	Sat, 27 Apr 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdV8GTOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDD23A6
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714258736; cv=none; b=cGYZGIVM2OL0eXRVtVjXGBncihTHpXMU46LpIZTMmz7YCOUZpwD37D2SMc1Visxf8Jk6z5xKYKyzDluONsygCmo+p/2SfHkSFmAqz6tp8Fqm+HPUMuGuSV4GmC4tZvQLdjHaVVOmHAcJkN27aJHUgcFoKxaJPEZo+cJS+1v/7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714258736; c=relaxed/simple;
	bh=7RXoeqQyP3/IcKB1JB3PsNxLCxxHenQYpbviNaCkWxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obODg3/U5tREwITciqrnJWnX4bPtbcnTbrgK2jrLOhsC1zLy4xfF+iE+BUhOJRVpXLRBL/T7xGrV0130YmeQKXC7MWfILHtNS9x0FHrFW0UhKOxTKUMSZGeXOSr/mb86JSq9cIXLoMZ/7TVCa66TU0vpEFeXR+F7JniC5BZDswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdV8GTOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A84C2BBFC
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714258736;
	bh=7RXoeqQyP3/IcKB1JB3PsNxLCxxHenQYpbviNaCkWxM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DdV8GTOOMrpkPczqau0a5Eukw8hg6fXPbLY7XvmIARuRiX4k1gO8RFo9SFsPpR8EI
	 dGf9FaoxGCS0fueRozYq2i6h++/26S2WSYAE7HpUMB5loW+0lqkkAmTk1n6ocfXpiL
	 FW11pWjmzSZhCcVdOdWGS2Skwa9BUV+od84RXgajBl61vD46GvydbJKSMBnt5xGAEX
	 v/F+Q92g5FSXcksB2NDhVnRib6g0xvVUk4rqdJ6wWo5NWaNJ5hbT5r5jWmAQ0bk5Lz
	 yeSGH/AE5YDavkxI7B59lfp4LuiO02skW3aolLWmVDchC1wg6IEw8V/Q/WSXptQ37M
	 AlxeJElaWumYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 198F9C53B50; Sat, 27 Apr 2024 22:58:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Sat, 27 Apr 2024 22:58:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-we7xNlZ0rb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #25 from Andrei Amuraritei (andamu@posteo.net) ---
Hi again,

I meant, amd_pstate did not load automatically, without me specifying a ker=
nel
param for it.

The .config values are (Fedora default config):

grep -rsn  AMD_PSTATE /boot/config-6.8.7-200.fc39.x86_64=20
700:CONFIG_X86_AMD_PSTATE=3Dy
701:CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
702:CONFIG_X86_AMD_PSTATE_UT=3Dm

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


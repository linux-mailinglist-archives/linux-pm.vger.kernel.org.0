Return-Path: <linux-pm+bounces-8064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427178CCA69
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 03:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728621C20D8C
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 01:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93617CD;
	Thu, 23 May 2024 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdHi0on1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD46FA8
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428665; cv=none; b=mm/SDOTVYuBSHAzMWnOccmwHAAb+lj7MKqn45MIhuE/RJptCb9ObFM9Yxa46KQxUJNkihyev/UlO20m+jEhmK6fy7IrFRL316Ks0JBhECrTVNI+qylETUDUaqWbxoEHFq+jte5qr5rw9CTE/JvW0J7NfXXWwS3Sx+KM2TYxU7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428665; c=relaxed/simple;
	bh=DQzeDWJ5c1FFAn+XSOT0JhLnTnjLqfATsHiv4Kd6Cwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C90xKeMnaAgngnxhXraApoTiVSWHUJieXjgNrgY88/LVZh5BpNYKbKI8soeumTP+y1FfCimQesZ9/uvcsQwdXMAWE3/lSQQRTmUDVxoG7TYk5rEQ5sAaXbK+xnNzrfRkVtRJUAANjHHdw6Mcj6Ii0pHRL7ORWq/1odRd7wtX5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdHi0on1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4769FC2BD11
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716428665;
	bh=DQzeDWJ5c1FFAn+XSOT0JhLnTnjLqfATsHiv4Kd6Cwc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tdHi0on1mqb8BFLvJqCm7k9VOVzj2MjWpY7ubJCGpH8Gm/m1Yfuoa1mHd+VQMM3Cd
	 8p5mB/0ScOJD0pKdVf8GD/cT/pL3nsbN+mihj8gJof4Zd/XM2HlTmJzvprUk0f2RWV
	 3lYv++Z17ptGPlsP9UUmOLFKbj8oWW28+sVWbhIg8tD9iciRFyqyeeNoJKfTGcXzwK
	 l+UDy6NBYaBOjQXJasNpIw+bBkaq4jL87uc7XVwyMcmfl+1pcvPOK1F7nhXDVQZg90
	 hIyH1ku2cbic+KSbv2RmNjmWP+Nz5z2g64I56TWBHeDPXq4H2g4sF2nDX5stWcJiPq
	 vb76L8jlQF2kA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3813CC53B7F; Thu, 23 May 2024 01:44:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Thu, 23 May 2024 01:44:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218865-137361-av8hb57d5P@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

--- Comment #5 from Matthew Stapleton (matthew4196@gmail.com) ---
Thanks for the patch.

After manually applying just "[PATCH v2 10/10] cpufreq: amd-pstate:
automatically load pstate driver by default" to 6.6.31, the AMD Ryzen 3 4100
system is no longer crashing at bootup with X86_AMD_PSTATE_DEFAULT_MODE set=
 to
1 (Disabled) and when no amd_pstate option is specified.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


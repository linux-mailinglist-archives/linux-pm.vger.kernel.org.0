Return-Path: <linux-pm+bounces-37248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CBC287BF
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 21:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABDC3AAC5C
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 20:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF625D1F5;
	Sat,  1 Nov 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQpgetgp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0718CC13
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028685; cv=none; b=sHxFbsZY9Yb1ymmbW61JUMyyobk9WCHJmcNrzm6WuCqHFxTN7J7fnz0g0d1xQoA78tPVOIh5bY/7avVK2T/d7UH7qPkwxxSGqEFXXlpoEmG36RotiW5k3k/4Py7v3/e584Tr7mMAg1TeAOzT7c6vxdmRr4SrcGuLLmmpHqCqjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028685; c=relaxed/simple;
	bh=sBfFojjk4Gsd7Or389mH/iXAtNYqFPNEbqdUkxzL/Z0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyyG5Wm04hIRyu3NijvFooVPQHldMTSOK10eggOGm0QkjT7zao2SDaXxrQdehrMpyeoxZ0nVVrtU0OWO9e7z0oRDyeBQLPo1Uf396JJ4cbVgKUDPNZvGkdPHVabD9u91WVd9NWjCIh9sDnLtyStebwX49Bw2jTRNlNbvUfVh+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQpgetgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B5AC116B1
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762028685;
	bh=sBfFojjk4Gsd7Or389mH/iXAtNYqFPNEbqdUkxzL/Z0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vQpgetgp65eB/xoyjg6VxgjeYt2I676euFybSz4dAsSj+J6Y6B2S6IvS8dqmYQINE
	 8L5ehZtQMOM8d4su7tqI8E0DEX76bZlEVspGYXK2PPrJKJjS7FeqjJv2MJzT84bpVu
	 YU3kD8fdfPnoz/nVyajrqmfxVk5nr1XFd62mvRRRyhajbwPs5LoMVWrRJvkfGRdJj5
	 NZMw4ELCowFLWpgHZUTwoCa1I65FUS+YttvIj08RSdRVFbhO83oiC/2u65cV8275mA
	 98+ZFntGYVafnbk7T6pgN9xCdYQywmXZnz1ublPsDqi4SEEPzx4x2RVqwbwlH9SH4n
	 zdDgWDSeoXVsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F21C3C41616; Sat,  1 Nov 2025 20:24:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sat, 01 Nov 2025 20:24:44 +0000
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
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_kernel_version
Message-ID: <bug-220715-137361-lQ5eUv3zfu@https.bugzilla.kernel.org/>
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
 Bisected commit-id|                            |c1385c1f0ba3b80bd12f26c4406
                   |                            |12175088c664c
     Kernel Version|6.17.5                      |6.11-rc1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-8012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8238CA8C5
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA45C282227
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903AF41A94;
	Tue, 21 May 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyNfx8Tk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8F179BD
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275901; cv=none; b=OjMycJAJL99D5COhJOe1gIPo7NFmvyvMM1BttfLrjLhxt2Ra6URtyJPcQ9/sEf6GaSExQRE+uBc4Gz7s1qlUAWB3A/cwOJ8/aHuRUn7jMdd17RminBTuJ26lupmcML1BmebLzD5wXpgFFLMgq6raMcACIy67EdH6jxmndix/TDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275901; c=relaxed/simple;
	bh=9L3gEfiyPOON8Om3nPWEz7HEmDXH7JqN24SNVEtZOfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNUxawZggMyJ7lyoM3cNnxTJigXqLE3G5jb8/swLJgMWZmnCCDUMESxwGUaJrGfORN6Lh8kQ4eDeA5IxNpoZfZ/BbpMvzg99FU8CP5fRII28n/10jNsl3jYqOQDwlnc5fSRK80/k7YmwFINiFe5uKGFUjpaI/o9eBGQr+VprJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyNfx8Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C34AC32782
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716275901;
	bh=9L3gEfiyPOON8Om3nPWEz7HEmDXH7JqN24SNVEtZOfY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fyNfx8Tk2rzsOyAQX+RfILQWMfi8CpTQSsc3l2Wbu3moCy7CXk3eQoa1XQvh8tX5h
	 561i8bSleZwpDindUlQbMScOzNPRooSn/Yu6cPMaCV0IAeHzkq+DVKCPswM0TPfFqJ
	 lhT6LzH0+T470b++EbWZYH+nmP6OK8YON4q/FcqT9GycDVowTSiUImtBfhP1mFbGqH
	 UQzDXLw8k1JgKV7yhmdQQUbpP3cigWr8clhWrX1djweWr3dTPhvuMx6OyhylarMN60
	 wQwAwXbr5auD5GUx40o1Zp9Zweu9ixKz+YYuahotpD2rwtvlsGxuLEI1fmua1alBKl
	 98JT/bOQDjUMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3DC58C53BB7; Tue, 21 May 2024 07:18:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Tue, 21 May 2024 07:18:20 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218865-137361-rW1DNCzGAx@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Perry please take a look.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-12901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FFF95F8DD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5388E282540
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8D770F1;
	Mon, 26 Aug 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ6R5VOJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD692B9B0
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696349; cv=none; b=IK2TS90EQDaOve7TxEnNag476lcSLcai3ALppAUrKFFxOABR3iF/m/CXrjWmj3O3Zk95VksnYIsnXqB8nfGpp9xfg+laQztVvODgrTzTrPXaVp9jvHtt0SycHTa/F8f9wC9WxSvVDw7LwmzGN1WNWHBnB0ylRAJSY45YWHmuraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696349; c=relaxed/simple;
	bh=Nt4pt8gKKJt/aS9WpIdAFNlYsaQFRAIt2Y4w8Uw5ckA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELX2U/JCC5lO57xE1tV7FNvoq6XbqiMpggZdzIPOKRXV4c9u7ZN3qTlH5oeFxjK2GQttP9LWOHK3RcY2C2HPEYzlY4e7+ez+gQSiyBBIsC3vcvSNLMdMLMz6Mb+JgjHJ1f7huHqjX5r3M/mzcng81n+P7NmhheM7OETeu98CPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ6R5VOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDA85C8B7BC
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724696346;
	bh=Nt4pt8gKKJt/aS9WpIdAFNlYsaQFRAIt2Y4w8Uw5ckA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LQ6R5VOJjuuvF83tcUlcb5FQWpkSSI3n7E8tdM2LPeR8IdnRkrJqteTgiCWLXuz6e
	 df3LS1YnAEFEdA2QE0SalHircJKWJ2MrKQJlZN5Fla6U88dOiGhewn9jUwzDHJ5TGh
	 wAeQv10ac5I/cmR2d0UZD/B0uSTUus61KJUlrTByFaiWkX8apwWNk9UT3DDyA86s3g
	 PPqrH6CSlmjX7lsfw2d0TMzgzqqbatW4s1wuv0u3Ou+jDTrvwB8A98RYmFd9ss8OcD
	 ZSsn3IW98AYRMzzq95/D1PBnxJHdendVPouh8BYXBbHPE4M9oWk4/gjnugYnFITZqG
	 +O+/JIbHcOjwQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DFFF2C53B7E; Mon, 26 Aug 2024 18:19:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Mon, 26 Aug 2024 18:19:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-VF6LFWfjDm@https.bugzilla.kernel.org/>
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

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
It works, I didn't understand how to use it at first.

Before suspend:

0xc00102b0: c4912a10c4912a10
0xc00102b1: 1
0xc00102b2: 0
0xc00102b3: 800010c4
0xc00102b4: 0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


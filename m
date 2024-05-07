Return-Path: <linux-pm+bounces-7603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A88BEBE7
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451FD1F2501B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C62F16D4F7;
	Tue,  7 May 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBmoY0Yi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661316D33C
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107836; cv=none; b=MUYf9B/ztKwETQt9GMncZNUc60CR1nv2HN2Lf6N3WE3RSu8KPFZfQ0Kz/Nx+0bbAUK+Sa5d1Iv6Vjkr6+vqyfeM/us5UfO9WxLDS2pCnSvErB4Xb+1sXY1F/zV6S2VcMTJwBYs3lWwTpaDfy5ja/05wMABvl/7EMwATZwpkgib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107836; c=relaxed/simple;
	bh=qMethklpFW0+t23LglGlc3baQr+CpEjYxEIzDDEpw0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqAkSOiOXJV0u2Z02KobGVafWqb+R2FoDBeyD/f3ke9hjADM5qreeNDjvNzbue4yYlvd0V8MRkfzZzM0KJk0nmxFCfBPcLJDQkL/wlKRGDHDyCy4syPsuzOHfZs5G5aLYx4xAccSHQ+FWutQ+tXMyq6Qy6ZEWLr8648NlHly+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBmoY0Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB114C2BBFC
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715107835;
	bh=qMethklpFW0+t23LglGlc3baQr+CpEjYxEIzDDEpw0M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vBmoY0Yi2QagxR04NsWWOLSbqIAt8bIbJyI83JyveCJ+tCDjU4rsPaIP5DUx1Qx84
	 99H0d12PpfJPH9zIRIzjnBDdy6qz6v1B6Y7HAKfbdX0D/5aTqna9crET1DxeDvDj87
	 5U+thiJF/XfWIKn4Vgw/ZJzXpbGVPi2ZRsbtY0u6BI2g1EUgVHDJXBE5hSzZ8SJh1/
	 qkIoon/InlLnfMpGoaO795/AGYNQpLoaY/rPlJxyKzSXvO1jiX1rqd4lp7LOZ3ZWQv
	 RPSyzCfR3yEYoO0qbNFICTUllfY25iG0JX+PXF7M9t36tdDaxWgR93RCZqTWuw+pjO
	 pY1qKFEHyworA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B9B23C53B6B; Tue,  7 May 2024 18:50:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 18:50:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-720oa9x4lX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #33 from Gaha (gahabana@gmail.com) ---
hi Mario - FANTASTIC job - Thank you :) !
Applied to -rc7 - recompiled - all good.
When running single core tasks on my Ryzen 7840HS single core does go to al=
most
5.1GHz as it used to... Geekbench scores are great.
I tried only with 'amd_pstate=3Dactive' as kernel parameter - should i test=
 with
'guided' and/or 'passive' , or it is a waste of time as this fix addressed =
all
scenarios ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


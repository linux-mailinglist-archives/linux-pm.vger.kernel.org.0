Return-Path: <linux-pm+bounces-7051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFD8B1A4F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 07:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F711C20E78
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 05:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9073F9F5;
	Thu, 25 Apr 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="key9fC8i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1E23CE
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022838; cv=none; b=SS+Yxz/BbDfHodEMyEHMB3ISBhD+izvNeR8YjEbuJ0gWpMJPCwRvfwiXRcnWM9KOzvcCr35O6t/NQ9WH4dUo4yOpdenKaQ3RQsKbDgVTa6+nut8zyi+8S0e4MxRF32EVAHYYQ63eyUWscK0W3/c8jVzEIhzViak6JPfmf2HG0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022838; c=relaxed/simple;
	bh=dthRDeMjJJl16jRsUABgL5ZP0VkIdI1IohtfBr8nl3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvy1t5h8BArrwkWeUg8WGJ1797EyIkn5DAptX+b0HqNvCsr9Hayf6KSPAd+Pokkf36aT4YdjCZrn9Co8XJ45VMaKH/XNK2e+rTzcvt86pcQzVz3sL8/bUV/lX5z/FzH7Z4g6b72Fzy81asYl+2XXitFqyiOIoGnHe+bRE4G1Svo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=key9fC8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A0D8C2BBFC
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 05:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714022838;
	bh=dthRDeMjJJl16jRsUABgL5ZP0VkIdI1IohtfBr8nl3I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=key9fC8iKPJcnWHf/gRjGBRNWJ/2Jl891kywmsMLpBRDWs0I8/mWOxUuVmeBdcr39
	 KLH+P2R9oq8d+lI1X30IBK/E+7b4ckMmv0f3yqVw8b9ix5JpJw7txPk0jisJaWPZI3
	 9wYyc8o0tFJq2isZyXmV1lufebLI1kQh/lb6A5MayITjEhwBWNXEFx+58Ej0I3zTZS
	 OuEL3RdRCTf0W7eq6BIX6HdIP993+2CqNN11B86Ya3YR0NkB2nTg31IBTOpKNnHO+Y
	 DuB/uXuEcWEEUPzbYQtPw+dvKo4NuhpVvMqPbPRJ4g63A8gLiCtDj45f5j5BqllOMe
	 YyXdsLMHKNRIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 15191C16A72; Thu, 25 Apr 2024 05:27:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 05:27:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-0cNwClLgdF@https.bugzilla.kernel.org/>
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

--- Comment #8 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
BTW, which kernel version you used?
Have you added "amd_pstate=3Dactive" to command line?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


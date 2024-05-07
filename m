Return-Path: <linux-pm+bounces-7588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A28BE49E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C1BB23C5B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544315E7F8;
	Tue,  7 May 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMpWjB04"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7615E1FD
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088270; cv=none; b=ThWLyo1jFda559x1uPPUCTctiCItQfSvWQDRcSAGAzys2J2Zv9KR1202Xf068PF5Fz9rXiViW/Pe+W9naubkCSgxNyRZObleGGpZgIdthD5VHmG7X8iP8Cl2K32H27gJdLcmbNwqy0eM+gcunIGhVoXl4qt0+/AoAt9KdS3RBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088270; c=relaxed/simple;
	bh=Ej0bCjWfRWz06C0g+X9t3THhxGzdHtVca462/BcC/t0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eyN/u8Ad76OtI+QwsE1GyEkg76ZnMLwVnbIiPE3SK7Qv83xCY8HUEYGeykn+Juk4cA/+druGPUtbzsYFe0G76wZTipTikaiO7anWb7kbd0srF61/cFajIC1sTerH5TM3RNvf8EcRYoOKZEoyyQC3US9tEDCFO0M2QB37YaAbTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMpWjB04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40447C4AF63
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088270;
	bh=Ej0bCjWfRWz06C0g+X9t3THhxGzdHtVca462/BcC/t0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fMpWjB04wD3MyLFGdre8okHMiqClJz6XyV7GLCTmCsY6IkBMtyohsBR/dNpcE+FUB
	 hX500WNtfK+xaSaC66ouyYgQ3KJ/BUraRA+CLCB2gptThkqjXxL76vrVhpDrQXMCB4
	 tiMkB3jG6tZSu+zrnlnCDaW5ywP3+sEcFBDSC7gPh17mE1Oy7VZCWnvPkzVblOJw6W
	 00rEwA1b+qh85Jg1VcbilGKMXdsemGXPIyqlC1XJ8siD9p19ZvnQXIVQAFotEEOgBL
	 Y9IGAt6LU8ZXXRAUMhpWi5ojZUEaeLyTwpZKewgvEHKpECVyS23+B2VuNoqqtxjXay
	 lDQeAuu4wfiDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3945EC53B6C; Tue,  7 May 2024 13:24:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 13:24:30 +0000
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
Message-ID: <bug-218759-137361-XrRHXZUiYA@https.bugzilla.kernel.org/>
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

--- Comment #30 from Gaha (gahabana@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #28)
> Everything should be based off the bleeding-edge branch for linux-pm which
> is code headed to 6.10.

Thank you Mario - not so simple for not-kernel-developers :( Appreciate the
response and clarity though :)=20

Was hoping to be able to test and report but will need to wait a month or s=
o i
guess for 6.10-rc1 to be able to do that. Pity 6.9 will limit single core
performance on loads of AMD Ryzen CPUs ... unless Perry manages to address =
that
issue w/o requiring all the other patches ... still not clear which change =
from
6.8 to 6.9 caused this to go 'wrong'

Thank you all !

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


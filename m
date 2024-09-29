Return-Path: <linux-pm+bounces-14905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF8989715
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 21:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87741C20A90
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BB54F8C;
	Sun, 29 Sep 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBTNOj50"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE32B9BC
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727638155; cv=none; b=DMruSIe9tDHFJHPYvSFbAK3vyiYr2rZuEQLzPZ7GDUS5X5NIMcctm1upbG7+D5/XwbA0sW2DgaMmRX0x8OfD1GwCyYwCYaf+ZjITXLnoK1yrz0P84ybt2sBEnFrrM3ztXoYN/Hsw6y2DSUUqgzuztRheu1ZK3u22T0WsdB31fzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727638155; c=relaxed/simple;
	bh=Q8cno5lfrpetC3xGew4+4YHkqJJ7dzS7Egkogg9TOfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXqF1vyN/Jl97gQrw08fiANB2xV+PO3LPGgFCGGuhSeyKFeF4viU49nvr0Bs3vEL/wxfpJpylBKtu9ROD4ww6R5ICzw8lHYuXG8FIAudrz1DjVOXkELU82pSz4KAcu2NN3pfVN29RMtxXYaQBUIgdlAdu63Yjd4GRssSHLLUHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBTNOj50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D77C4CECD
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727638155;
	bh=Q8cno5lfrpetC3xGew4+4YHkqJJ7dzS7Egkogg9TOfE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MBTNOj50fWkWrvpF+l2wedBL42QaWLovVTlitOavtxlh8uaXHRxoENi13TgE6QRED
	 SCCibXv6pg5vabZygLuS+fbRkugXAyoZr0CexYCrUSymXcsPZrYN3eq83xa/7nA7dk
	 ai14A78qRDXciwSgkCIcEJ0soYQqn1yxF/dVXkD1wVzQM9sRRJMC1I3SrJp5pLy+eA
	 KBOajBSC+frVnKDeEiIiMnXhXH03Cf5SMT5bPAL0aDXA7+x9dlY/C5b/EAAxMQRCpn
	 Juthi0Ll4f99n9rMgwWrmL2Oyu/GIsO96cXig3c4MP9VG8p6v62LnstAY+Z8x+E5aN
	 h1MVWsfyprM7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2B02BC53BC9; Sun, 29 Sep 2024 19:29:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Sun, 29 Sep 2024 19:29:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-IXkEwtfrc7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #5 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you please provide a kernel log with dynamic debugging turned on for
drivers/cpufreq/amd-pstate.c so I can understand what it is doing with your
hardware?

Just a guess with no messages but it's very possible that because 6.11 does=
n't
have c3e093efbc6cac7bf9dc531dcb751b86daaa65b0 an error is being masked.

Perhaps you can try to add that commit and see if it changes?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


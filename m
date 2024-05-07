Return-Path: <linux-pm+bounces-7606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C018BEC0D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 20:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3A51C21979
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC45E16D9DD;
	Tue,  7 May 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayfn0d4Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9316C84E
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108277; cv=none; b=Rz/oykKuZb6iYRXF8urSl0qOoxDBusIrMrZ+ahYcDavmR7VOX8EAdQuz975W7AFsWGGFtRDO6/k7kY98kjXukZYHEZLjD0al/phuX9B4CfTuFBmn1SdQn97GT0gXWSlNtdx/LkcM+YpAWw6Mj9kxx13jUZkocolGM3cAD7waLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108277; c=relaxed/simple;
	bh=k2AoWh8ROQADU1QnYwBZ8gFT3W9qfGQ3+UO2V0WJcHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/u30SyXoGXBqVomcGrampgCadhy6QoJWakYfkHsHmG4QS97WhDgB9M0C7w4ykBOSU8wv6qPgb3pV+d0AS3Ot9/apBtUEizc3Hi0IKHvv4t1JIsgKtQNzYjH9bHxtNCf1dQMGH+3yCaTItX+nmFbsBenqR3ucaZ2kk8/5fHrKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayfn0d4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 959D5C4AF18
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715108277;
	bh=k2AoWh8ROQADU1QnYwBZ8gFT3W9qfGQ3+UO2V0WJcHs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ayfn0d4Yli8Rli5VzsTtWxzBtSc/WHVLLQ/xj8Zd7wP0EPusQwyqqxQy+LGTeFxkf
	 N0vcKRygFV0xWJkkobIOrVDKufT0B84PJDwpNt6WuuyxQRBLlBn2j5jy3pS2gXrU1R
	 /qbsUByLAoSVWDRy2lr+9CB7A1C1Ltpu4G0aqA7VmxoX+AsJp3eYWQWGyfsRVBGnqT
	 gagz0knP+d/FdSsoPVKhDUl1kkJmdEx/z/hYAINcKq/RS/IgyGDBv0Ai4xLC7ysXCq
	 olRPYt6ItaMfU766hHKiqa/vmP+fl3AXfPd7cC1ydBjOq0s+BjjTFM/M3EIluuGU0a
	 bUU0c5YAovDJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8E50DC53B6D; Tue,  7 May 2024 18:57:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 18:57:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-1zRuroBpdF@https.bugzilla.kernel.org/>
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

--- Comment #34 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Great! It should apply equally to all modes.  If there is a regression with=
 any
other mode it should be a different root cause.

If you feel comfortable doing so please add a "Tested-by" tag publicly on t=
he
link I posted, instructions at bottom of the page.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


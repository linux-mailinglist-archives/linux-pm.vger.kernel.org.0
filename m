Return-Path: <linux-pm+bounces-13970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0A974225
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2021F22C7E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57381A2C04;
	Tue, 10 Sep 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mog8aBPC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168416F27F
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992919; cv=none; b=Apnqg6ADZ7tsnHLn2d+VawTkcsGhyI5THdmzR94g0tAeCkvNacaM2Sb50W+4GBpx0gb7zJ/hGvfY8n++L1fLcb+4/94oEnaq5XxNpBXixjTsuCiCbP5Q/PVZb1EDlFbuyGCpNHrzO2GLl9Z+A+//MO1YRJr/w8p4Y6Tq7VpJFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992919; c=relaxed/simple;
	bh=Wx0nFvKCLucPLZg9UYw0/RpbmgyY8JgHAkFQXGGZCSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HA0ahOyv4MQ061xyZg0sRQ1bcZj36Wmw2oxC7clWjiuZ4wv0z7rMAS00bBB/fjfR9fTTnhIBUIo4y0jY/lOlqJqDlchTy2thnyIjnk3LEf67hE3qfDVHqQEeBjIHFnUCf/1ct0bnD++OsOelsjTvcx6k1+801D/P67NepWnZiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mog8aBPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BCAEC4CED2
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725992919;
	bh=Wx0nFvKCLucPLZg9UYw0/RpbmgyY8JgHAkFQXGGZCSc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mog8aBPCNrhyEEl4XEktcnE1iyrTRkTBGJ7twtBqlX/0syUa8xy3njEfoN9Fbdss6
	 P5DaDa9mJc7Yg8opelyJzkp20oqeX4KGju4pOE1TirVz2LipAqM2+vZRqH9wns1Ga8
	 1QWVQy5xxgqQ8wgBn5K+TE08j8QKHvWpJj1oCnJT5LpQzfXcud79hmfM2wKdT8NkF7
	 mv4eF388GvxdS+tKab8x+J9X6yXsJq0KysnT1PRXuD9/WVV8TvnZwgpQDTDHa5VPKP
	 /lsxyE4ru6DVRTSlYxd7u7NXNPM9zfx35JVHmFD/L50JQpJxTLfUcRNi0gkzZaHFK8
	 UgLB2Lu5jBvyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 341C5C53BBF; Tue, 10 Sep 2024 18:28:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 10 Sep 2024 18:28:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218686-137361-GqUzCEfg4f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #96 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
I submitted it for review:=20
https://lore.kernel.org/linux-acpi/20240910031524.106387-1-superm1@kernel.o=
rg/

Rafael accepted that patch for 6.12, so we'll see this solution in 6.12-rc1.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


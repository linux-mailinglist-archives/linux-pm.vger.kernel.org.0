Return-Path: <linux-pm+bounces-6223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918889FC7D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2228E7E9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F2179644;
	Wed, 10 Apr 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLpbw9Ly"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843391791FB
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765288; cv=none; b=nRuudagh9w7NBO3f01aXwWzwt2TXRFAaibrlV/JY9MIRAHzntyQHpKPfuFwr9vY16h5T0okx2eASroAE9Uk7E6r+PvlDJ9dPj5Dwm4nhej0PhGMx2sQVWOigDdIHmscQbqNmnGbTkLSqmCbTjVVjpJnEdzWP0hz3izSW1eV3slk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765288; c=relaxed/simple;
	bh=1oyNBwADwsj3pc9LEqW8/oUb9mcGaoQswCyC+xHqoV8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4kT4je5PGtDKnnJflVy95t8tHFhDy/uaqZ/i5pZUKL8clXga2gi960m4GsZZQ+sA4e2YPrN5+1e64Z6gVmxbqHucS9ml5BcMphc5SxToCGazGiItNYN6THwgCgFmJAwQbSs46860zXAmxsn9bT9admmGc1QirVsP8grqFRtPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLpbw9Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 652C8C43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712765288;
	bh=1oyNBwADwsj3pc9LEqW8/oUb9mcGaoQswCyC+xHqoV8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qLpbw9Lyl5ZfJpucq26TWsngZPY4f0bzXLZIXT3XnegEqHAJUfX/rZE52UlPpAqlv
	 IwpIYnmmb7tGGIaoUU70V3DUdc6ufSFk5jq65gES5JRXJQt2SXIB9xMoTvyiHbscor
	 f4E0AUY2MGp27knOkbsJ4MShzFBIHr7gZiU7vavmczrclwa0JeTPyTUUdj/iA6eC3a
	 wTX0ktrF7z7tuWJLZR7zqJnvf8tNBHYiaA133aZrPpmQjAqUy2Q6pLfW50fsEPk2Rw
	 IxKsiEhEaYauHlqiA5lA3wqmYZ1m/ZFsbYaYXVSFprwtA5mMviSg4tWMVKg0MFfWVO
	 wi0Y3hDBeeozQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5BA26C53BD3; Wed, 10 Apr 2024 16:08:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 16:08:08 +0000
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
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218686-137361-2YfcpWROUu@https.bugzilla.kernel.org/>
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
             Status|NEW                         |RESOLVED
         Resolution|---                         |DOCUMENTED

--- Comment #24 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
As this is caused by a BIOS issue that we can't do anything about in Linux,
closing the issue.

FWIW if you're getting resistance from ASUS in fixing it you can try to
reproduce it in Windows.  AFAICT HWinfo64 will report whether CPPC is worki=
ng
or not.

https://www.hwinfo.com/forum/threads/how-does-hwinfo-query-the-cppc-preferr=
ed-cores-data.7927/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


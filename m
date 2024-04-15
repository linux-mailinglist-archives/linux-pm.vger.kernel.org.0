Return-Path: <linux-pm+bounces-6431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A45C8A5702
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C58B217E6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CD7F492;
	Mon, 15 Apr 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmHyvz8T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AF79DD5
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197079; cv=none; b=Qsno9sEMFJ0PtubU4m1VxL8fkeFztm1imUjhN0vu5hdosLs1kEPehfCxRX2NRBO8bHJ1O5sxq73JfGdUXuq2O8bdb8GH2fIDwldc6DWui4X8izCB9jc1BcEuNkSpFG9hOvnXFXf9THGYGfIXYUNto9Q9IbKXJ1oENnH5NtqPkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197079; c=relaxed/simple;
	bh=VpZ8TsoXpwmvg5aumACxBv08vLlFN4yhsgUe+2rDsB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+ShEl6CCnFftlgFDozALEp+zTDDvX/Lcy6mrvOyJY50d3y3/HWtRx/6sCT83mILfiwiv+4IsG+hYluV8Z5dfIBAWG6oflnBrEdjYIEIVtv1tFgxE3CWOrmymTTGrttZlJO30d+2eQTvOmpLstgdjxXMH1GLRjv2BasBDQP3QgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmHyvz8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54239C2BD11
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197079;
	bh=VpZ8TsoXpwmvg5aumACxBv08vLlFN4yhsgUe+2rDsB4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EmHyvz8TmViMz3zEU0jFOhegIoyrrTPgNm38N2oqtX8XZ9SHWHL1PK/RlCK/Ofhsk
	 fcsBXNmyKeQnN5JtlAUyZw/nTIrsqrtc4AM3xo8OkXQcRswRAU7xDqYf2CmddmGn33
	 rjxuf7DyRTHV62dI8sOgwbonRKtOiCmnGps9nIZTKtzmDgccPeKV6ct6SSlUX2FpR1
	 4ndQAqeDqmtVVY8P45kwYFurCiJYV3NahFhYzF3Kzhbb1wYDs9rQDBTz5EE41x2J85
	 mJgUKZRpelUswmMxOY3ux/GPX27R/w9Y9Glr8xoTD5vQgiGHUcTyBqSMIaG0n0AJEs
	 4VRKH2WljpH5A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B4E8C433E3; Mon, 15 Apr 2024 16:04:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Mon, 15 Apr 2024 16:04:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nielsenb@jetfuse.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218705-137361-MeK3poibur@https.bugzilla.kernel.org/>
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

Brandon Nielsen (nielsenb@jetfuse.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nielsenb@jetfuse.net

--- Comment #2 from Brandon Nielsen (nielsenb@jetfuse.net) ---
Looking at the source[0] I think this is by design.

I am not sure what the current roadmap for enablement looks like, but I am =
also
awaiting it.

[0] -
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/cpufreq/amd-pstate.c#n55

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


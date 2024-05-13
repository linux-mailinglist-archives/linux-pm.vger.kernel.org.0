Return-Path: <linux-pm+bounces-7765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622DF8C475B
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C20F281168
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE22EAF9;
	Mon, 13 May 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL206RVn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A84436B
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627086; cv=none; b=dIHAy8lfIgkzBpaDasZzO74xVQZV1+hmdMD0ZV/pl6tjz9biQgnpbGjEWA3yRizNZV+ERWJTtgt22z1pH5028bPyQMCpgHR/raLF2Joz9RwTj+rUQ9twpD4yz332FDlxxQhD+5REhYogYclWtCE2+RsCSMFpdA9/90rr35S7rnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627086; c=relaxed/simple;
	bh=JHXZuB1f/MxXj06RRqRl7ws4VR3R99Uw2Qb8blU4KmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5DybAd/VbrKJeerzj4nBKNrwUq4mx+ppKWq4JaHIbxpGlsj2eZDCpeGCtR2j+eZNOs4LsS47vJpDA/1MGZDkGbDVwEGSfmDe1AbIVx1ZrVz0OLheEdFDNM3Iik9MxKhrNmD6cyStLDP2M+m/GI83/pBr2RqYprJCrMTzpwjzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL206RVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18267C4AF07
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715627086;
	bh=JHXZuB1f/MxXj06RRqRl7ws4VR3R99Uw2Qb8blU4KmU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sL206RVn0Op6sKVu8fojSUTjkfjbcsm1p0OW9yM9JB9FZyELspGmqMDlif1dcsnau
	 IBBIxMJV40oa9uDfmA0aPSKpxrJ7Zc3t87CFm02jre3evIKKO5pHjiDOaxWFFm80Gs
	 gNMur2wEWmMc/qTLuo0Hrv5Ui+58jQE/ke3B45B56j550MKyDowf3ywAYEOnWbdSgP
	 S+lOfYEYRCzHaDQtqqP2RHTpRx7+917wY2g0o00P+eNdDQ9gC34uM8l8S6hOwGo2y/
	 l43F8Wol33pinxVSE4Q03/vZoARchqHY2d6xN2r6Lb+hNfx2GoN+J5Lsq4zVoNAD4E
	 3yhU0zR8EjlYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0B9E1C53B7F; Mon, 13 May 2024 19:04:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Mon, 13 May 2024 19:04:45 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-Wt7KoEN3eB@https.bugzilla.kernel.org/>
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

--- Comment #28 from Brandon Nielsen (nielsenb@jetfuse.net) ---
(In reply to Perry Yuan(AMD) from comment #27)
> Hi, Please try this patchset for the issue
>=20
> https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.com/

I see the same issue on my 5800x3d and Gigabyte X570S Aorus Elite and would
like to test this fix. What kernel does this patchset apply to? I get confl=
icts
on both 6.9 and linux-next.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


Return-Path: <linux-pm+bounces-6149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3E89EB43
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AB1B260A5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301D413A3E5;
	Wed, 10 Apr 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f19jIcX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DA13A25D
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731645; cv=none; b=fZCfLONhJdMLPBYYRABKYChDNTYDcQ2vaak58SPoH4JpAOafWLoRdhlrcsIE3Gxmsnc/VNuSOG171K7UsoqoWLS4erw2HiPYyVPh/Uj1rVkxC5Z/VU3Fv1DTKr8d0LhFk+8mqVlcz+ZcMKdguxNNgvUYBdG8Sfm8I935MWgEvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731645; c=relaxed/simple;
	bh=60QsJWC8iin/WWjeGqDInzEII9t9xuM+nZ+bS1pHEhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0X7D2Et7PcjwUHrbKxp7qFLbMrkBFmUsZuogbYNv6jVJU9Socf/oom9vNL+AVViNl5016UGsUMc+GvQJP7DofhIfLV9FzICcILcoN0tdWtPJC+H6U9mpvOb+rfebQLNaLpuxEZMi9mYMFeY+Dkhd8G/swSlYtGPuOL/rVkDHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f19jIcX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99B49C43394
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712731644;
	bh=60QsJWC8iin/WWjeGqDInzEII9t9xuM+nZ+bS1pHEhI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f19jIcX8adNymwUMTTh7hPR+ghPpj2mtU8F0bEX7P73jwM37MRZj5FOOUZ+k5o1Yl
	 81zQCAVOOQJR5xsS3eBIFxiZvJB12dWA2/cYwp415HGJF+0YhXulHCcYlkcdGC7yNb
	 SI6YzhmPcVt2w+1cpodIUQ4Rrr6b15PjJL4tnQMKkc6/NgF6J4fI2DJA4aUe75O9D1
	 jzrX2kUQY7BhdWGnuJ1X+aGCG5Q0TkmqiRdBeMfEErQGdo9LC43AN6lE/sOy1oFyJT
	 06dMYTlKep3khQMFfMKIroHZn5ppt4QtRnbxEiKFuEi8ZJ++1IAu+V/cBqu37saJKm
	 iT018m4ufWuPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 814C3C53BD3; Wed, 10 Apr 2024 06:47:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:47:24 +0000
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
Message-ID: <bug-218686-137361-qdfNCZLDjU@https.bugzilla.kernel.org/>
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

--- Comment #15 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Could you check the BIOS setting for the CPPC enablement?

1. boot into BIOS
2. turn on the CPPC "CBS =E2=80=94 SMU Feature =E2=80=94 Enable CPPC"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


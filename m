Return-Path: <linux-pm+bounces-8139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3F8CFB2B
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8885F1C209EA
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A643EA72;
	Mon, 27 May 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYAWEohI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713A4503C
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798093; cv=none; b=BEExGHcVaFWbxgnwq/V5J7QFuQvPBf4DvqXktIIuf5j0e3FhdZjkOa/SPNJfZgq5jVgtpfF2te6FC5Q8hWHOwaElw4pDsc6CvDoC5aNtfBOzpDwO+N91iwqFxMABTw2lpPs2iI6dF7InxpHx4a4CjLNbKOk3/1Z1fzjvH5DCeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798093; c=relaxed/simple;
	bh=n3PLn/rnLdw/D5xMobrAmXwmRQtHLVxqA2SrB3hgP7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQdRduxe6U9Qlsp1IoylKfgeBjEGhzCYQjytWeHNbIzvYVBM0UTnwe0ThUmXguDM0TewK7mRpDw2BaQ+mIUtZtpkbAI5vd5HvpWGfreMm7cl45ZktuWfJ7aeTF5huviKTg+qprSExBXmZLStMePpoFkm3beU4H+J8Vct9XltG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYAWEohI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BDC9C4AF09
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716798093;
	bh=n3PLn/rnLdw/D5xMobrAmXwmRQtHLVxqA2SrB3hgP7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aYAWEohICLZkcLhpXzhSNXw8pQvDE2NNMQ0ADoliHoowj/cvmILstcrv8oCzs+DF2
	 dP0QkGoUVZdWPE2hkwq9qVeLTz4A2jsxLPZCQta22EoE2fapzRKdbQJSMjJpXafE4B
	 iIlSceXgEc5Cny1pp+k0jcDP+64zA6oJgKHQ8xpAM4BWteZURpnsc7k8qnBBINMWew
	 y2mH81a8eogilAr+yI93yBJ7R3fj7lxaZbhNF7M8y3TtJufO+ysZco8YQPOkSwOhKd
	 OM6CIm5/lyRGVkvU+DVH5R816Kh8tRJK0h9h54XntK/yTrMIer3XIn/rxAgxBJvSR2
	 FwoZNutM/3dSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4CD40C53BA7; Mon, 27 May 2024 08:21:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 27 May 2024 08:21:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-6Sdean6n3V@https.bugzilla.kernel.org/>
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

--- Comment #53 from xiaojian.du@amd.com ---
(In reply to Dacian B from comment #52)
> Hello Perry, Mike,
>=20
> So, i've stumbled upon this thread regarding the amd-pstate driver and af=
ter
> hours of bashing my head against the wall, i can confirm that i face a
> similar issue, but in my case its even worse since i use a chinese laptop
> (so bios updates are kinda out of the question...).
> I dont want to upset anyone, but to me at least AMD kinda dropped the ball
> on this CPPC thing, since it should (at least in my opinion) be enabled by
> default and not up to the vendors.
> I will be following this thread if anything comes up...
>=20
> Kind regards D

Yeah, totally understand you, but vendors has their process to release their
production BIOS, it takes time.
Like, you know, diff vendors will cut off their BIOS fucntions to deploy on
diff models of baseboard.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


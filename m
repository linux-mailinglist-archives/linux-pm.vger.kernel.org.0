Return-Path: <linux-pm+bounces-1660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E281FAC1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 20:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BB4B218A8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E3101E9;
	Thu, 28 Dec 2023 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mobS9IS1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3562101E1
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 19:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41A7BC433CA
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703791666;
	bh=9xgff5Irv25aNXBIwGB1CPnG4bLRqyMk462D+9srbA4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mobS9IS1LfxO9GdZi1RQBMs+mLlFsxf98om7vd3oItt/cEtXfufO3U84X938reRbS
	 8hB3Mupqt3a7h4bQ8zNJDQhZ/MgzH8osEpyn3kHjrXW3/G8SXKLOco4MM5liSbwOcC
	 JLWvOOelxMWxKePaUMUH54jzLFnqLZIwavq1bACcOtcCuBs6CGhjgc/7TpwahVf9fy
	 SfaX4IXRxGrfUzChlPdBI6hnILdF64szHjD76CVfrCnl/b8AUoY8vMon/SAEqAZ3/l
	 ui2eWhlFOJDi8NyNbl/78vVDetbJQCnaNNvbn6Pfqaw61w+4oCzGU/BOa5dadYMYfe
	 JEtIK4GSYqh+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3142DC53BD4; Thu, 28 Dec 2023 19:27:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 28 Dec 2023 19:27:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-WxEatKQgdF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #13 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
=EF=BB=BFHello,

Thank you for reaching out. I am currently in OOO until 12/29
response will be delayed.

Best regards,
Perry Yuan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


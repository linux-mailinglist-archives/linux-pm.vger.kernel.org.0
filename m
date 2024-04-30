Return-Path: <linux-pm+bounces-7322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161598B6ADA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 08:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BE9281A4E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56614A9D;
	Tue, 30 Apr 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElIpOFpq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782E1863B
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459734; cv=none; b=swuI3VNXSiOn/28c1QJ3rsG9z6EF3am3iPS+gduEiK3KzOCvmz/vxmH1JdC5l+03rOB+EnuU/Qw81flYe/0XvRkFscULrkPS2vjuGN2ZfR+Co5LPnGiNrXGwYjwweRpmCASeYYWzDDh+QWjGgF/dk2Yn/0SVJ5W0cLPC1T/+grA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459734; c=relaxed/simple;
	bh=XTF/wZmMzEbbxECv1IzcwPozETrfB7qhtCYqqueL6G8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNJVQ8ivBM3azb4SD1zSyZ669UVd7Xk+039PQvh8HLFE1KFGkI/T5M004k6DtJN9JYTvQB1ROAOEtSkX0DKrG9hSkpWMQGQfC2MkExpRpGB2iLC7oPaHWOstF//i59dCHe9I+16NKHrHLCOk/zj820+OsyJPWJAILVXmPuf3cYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElIpOFpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D544C4AF19
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714459734;
	bh=XTF/wZmMzEbbxECv1IzcwPozETrfB7qhtCYqqueL6G8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ElIpOFpq/wNPTAGaKEj4LrWoZhJZIxJEx/nzWsQ/gqMNTO0wq0ukrQ1z87ODhZ7rY
	 9ayxyHIneY8rJm1x/uQxnaANprwenOwu5fRyAX/vP9HeBEyEETTVuPr5/4/vQzAUPm
	 hkyFhKg0LIWjd0nbH4mRm3akVo2lOaeg9TomvjDUmqGF480J70IwOBXk4gQifMBdnt
	 z2Om0t5RoqFhonoOQ3ecSQAsVWJc9GbCrIHVGJuNbOs/6v7YF6ij7QVBVOBlHWERWs
	 i6QFr9uwRrr1C3tcsUeKXwMvTw4KhQscEu2zwrLU77On4zaCbX56tEExp5wdToG7Em
	 tgkZEgBCyDkFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F1180C53B6D; Tue, 30 Apr 2024 06:48:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Tue, 30 Apr 2024 06:48:53 +0000
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
Message-ID: <bug-218705-137361-ar7RzHDzDL@https.bugzilla.kernel.org/>
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

--- Comment #26 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Andrei Amuraritei from comment #25)
> Hi again,
>=20
> I meant, amd_pstate did not load automatically, without me specifying a
> kernel param for it.
>=20
> The .config values are (Fedora default config):
>=20
> grep -rsn  AMD_PSTATE /boot/config-6.8.7-200.fc39.x86_64=20
> 700:CONFIG_X86_AMD_PSTATE=3Dy
> 701:CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
> 702:CONFIG_X86_AMD_PSTATE_UT=3Dm
>=20
> Thanks.

Thank you help to share the info, I have found the root cause, working on t=
he
fix patch, will send it out after we finish the testing.


Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


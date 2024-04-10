Return-Path: <linux-pm+bounces-6151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996989EB46
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53FEB22941
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2B273FE;
	Wed, 10 Apr 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRk/mH56"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EC8C15
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731912; cv=none; b=moR8Uk0pdXUJZAqYLJxs1aUmqC/y68LG5B8RUDACuokys5M8o1djj/4ujMjK84BU+rEHaMaSEJcUmLj7l+2nAPMV83i8t5OSwOaVf95Rqj4L4sdmp5iDCNvb4l6kzWQQ3tGsJ3/SdhdOE9ZMcJyKjCLrH0qV8sa8lZ9mXm/ihM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731912; c=relaxed/simple;
	bh=4NRlpygfrjfkbN+KnrUP5WwJ062KLBneyBxZ50A0XcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZxaGnFABnU6xDmAHgLRV6IX2HuQeTUYpu4puwN0fre8TcSDDQmoL5IYJBc+2neTwzPFM8QRXH2p5NnjacRvPIMVPMV1km4FAoMK7hFJrcdkIaWpFPzdqTM3EjRDvsvodojFjvGNpjpisauv/O4+R0hR7eYpHXTolOghJs3llhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRk/mH56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88E86C433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712731911;
	bh=4NRlpygfrjfkbN+KnrUP5WwJ062KLBneyBxZ50A0XcI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MRk/mH56M+XEOkIzjp3QTAhtFVCbDyOID7Qjx37I9i4n58oOtH8tzFpHuDULW9lEr
	 rU35vQeCn3HwB/5yD1McHfNdILjfCI6xoB9qlXeZ4QQu9iXAHk3XhKc6gJyQpLf1RL
	 SCI2ML04X90cH1r7Bqa9SPhoWGP75JrONgu9NPc3ZZQb1I2i8cBmF7Zjxp6/u4wxvc
	 SGJb8fs5gm26vfE1FymrAUVmbEGBYlmjfp5M77lTl8X+gkv2Bes4ysTk4Csi1n26f5
	 ytfz9ehrR+RAlNxpWsFhIU+0w5FXT8EuQUeGdNMHGESLgtdr2jA4m/dr64bG6RAU+u
	 UYRyaoosXliWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A696C53BD3; Wed, 10 Apr 2024 06:51:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:51:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-dO7FMctNaJ@https.bugzilla.kernel.org/>
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

--- Comment #17 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #14)
> (In reply to al0uette from comment #13)
> > (In reply to Perry Yuan(AMD) from comment #10)
> > > =EF=BC=83=E3=80=80sudo apt install msr-tools
> > > =EF=BC=83=E3=80=80sudo rdmsr 0xc00102b3 -a
> > > please try this to capture the msr values.
> >=20
> > It turns out that the segfault is cause by my distribution/kernel versi=
on.
> I
> > changed to archlinux with 6.9.0-rc2 and got all zeros after executing r=
dmsr
>=20
> Got it, I will get one same CPU system to check the issue.=20
> thanks for the issue reporting.
>=20
>=20
> Perry.

Thank you too for your response. I got zero response from nvidia guys after
reporting a bug to them ;)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


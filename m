Return-Path: <linux-pm+bounces-13891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE79971BE0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE69A1C23224
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE01BB684;
	Mon,  9 Sep 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5I7Yunl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80E1BB683
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890056; cv=none; b=I1TFNGzO3sMY+yvfc9AdUGUoeMVuq/6QyImK08eRNF+4hmz0Y9Qpzz9QpDZE/+i/VK1sm3hBV92jMxpfPVaoMsq6ovph+JesF1S9EnaO1CmAFA99pxNPI4C84G65Sd/+Q9UeNg0zBYPcjsAapaog7yj8HUt8FL7VwK45/yXIB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890056; c=relaxed/simple;
	bh=EJryZm6Lx9L2wlc0u0TH8gCBbwhnfwPu2FFDtzFwQAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UaGtMGCzeE+gPOZ3EqDsiLU6y+WEPvTGYyyEZ2fQQCSBifxWSzaeRFapTDWGLVLb7x3iyQmeqmq9PxVqha7nO9CXaQRXj0LeiC88L2/J7HbgTzFQgl2Uw7TvT9oOuYOBUCjGNaJOONsuqXpoFgiY4OfGpor5SMiXDtDj3/6nEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5I7Yunl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D5BDC4CECF
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725890056;
	bh=EJryZm6Lx9L2wlc0u0TH8gCBbwhnfwPu2FFDtzFwQAQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p5I7YunlUZ2/tjGtfKopCutod+MLvBx5GjN+PjyIDk00mNFzZvxsCGGbPGVn4POzh
	 9l4MT+jJIqP0telx2sI0eT7HOCuFxdgniQBCtXNxitAhKCyLcaehMy9gYbIXOqrX05
	 8SE8nhIrcYggOW9tHXbzJQjKROyyki3eLa6dj8JWBwMdjOQuxPwOlSnK91D3+NoN0r
	 7s8oeF6zEfIF9cenQF8UDI6gF6yUuV7MXVyA4BnL95SdZdc9XJXBT1tfT+mq7Giz0o
	 4EfgoV/A7xVCLVF0/IzafqfXM4JLeJ2ZuTlzWMpCdjdQSTupLcuVyBk4CrFGFXjjoB
	 /R9x4D1LOUC+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 067A1C53BC8; Mon,  9 Sep 2024 13:54:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 13:54:15 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-TW4ZtzRI49@https.bugzilla.kernel.org/>
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

--- Comment #83 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
@al0uette@outlook.com:

Very interesting observation.  I did double check the ACPI spec and found t=
his.

'''
Starting with ACPI Specification 6.2, all _CPC registers can be in PCC, Sys=
tem
Memory, System IO, or Functional Fixed Hardware address spaces. OSPM support
for this more flexible register space scheme is indicated by the =E2=80=9CF=
lexible
Address Space for CPPC Registers=E2=80=9D _OSC bit.
'''

So yes I do think this 'direction' is OK to go, but it probably needs an ex=
tra
check on the ACPI 6.2 version.  Something like this:

if (acpi_gbl_FADT.header.revision > 6 ||=20
   (acpi_gbl_FADT.header.revision =3D=3D 6 && acpi_gbl_FADT.minor_revision =
>=3D 2))

Can you please spin your patch to add that and a proper commit message and =
then
post it to the linux-acpi mailing list?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


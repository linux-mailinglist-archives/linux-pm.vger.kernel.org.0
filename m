Return-Path: <linux-pm+bounces-11808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB82944AC2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 14:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F3E1F21323
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E90187FF8;
	Thu,  1 Aug 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gme98ZNj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB616DC20
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513753; cv=none; b=l/NCNYqh0nytdwADGElYfyw0rg5eox3UcNJ3JOY2RE5fNVY900OjnBGBFd6mzU39j9TDT806RJM9CPO/C4dsM6HDq95r+GT323V32mXnHHaeLXtwX5hxRGkvEy5ODcToQrC/uHFOXUFH4z2/ApmLYaS4ZhMZarP0C3rX+cTzBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513753; c=relaxed/simple;
	bh=1xtfP63wEUgRE6xxx0Ka20cUQfzt2Jq4cuPC3+Tf/lA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtCW2ccPOhjNL30WK7XD9aqtvK82tdUz3iuXhihF6YOQhNmgnrrRjGxtbb0Ylpp4NThMa4KoNHzNlmpbmQFhqzlBJMJovNz/57s2IAy6BtSAWp8TTgNHwBGHdHKAp5L5JhEuuhFT2pYdJK6rIbjE4VrX+kWdZlL/ELaqA2/B3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gme98ZNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CD23C4AF0F
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722513753;
	bh=1xtfP63wEUgRE6xxx0Ka20cUQfzt2Jq4cuPC3+Tf/lA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Gme98ZNjRPSbL7n0Vwpb5hT6SJYgXU9mpIYYBGVP3NfheIcvVgU1bIZ8REtM57MfP
	 2Axm92PXLQuewxyTkGgj2N92mA/mruAaiktXLqaSbplbzT0GkqJxmFMnLkrkont4FV
	 gAkC7ea7LDA0QUh5JHCO9Nm94MdhNKtrq7Zw5WT9pCikWl0dqw5LATj+JxRt/JKkoi
	 Eun9JHfoOwhYH1EgVu+rIC+s8TpxEKlSIpZukAgDJlG2XEd+hAJ15hpJ3l3pSvuIJb
	 H/Go46IpAQCqr1zNC2oxt6N62zIoPB3yjiL56/vCDFXail7YtMR/rjB4HbvWFMq2L8
	 /cIdawRKJBerw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E915C53BB9; Thu,  1 Aug 2024 12:02:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 01 Aug 2024 12:02:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-vMh9w06wxc@https.bugzilla.kernel.org/>
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

--- Comment #68 from Chema (chemasanchezgarabito@gmail.com) ---
(In reply to Perry Yuan(AMD) from comment #67)
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/
> programmer-references/55901_B1_pub_053.zip=20
>=20
> Page 120.
>=20
> CPUID_Fn80000008_EBX [Extended Feature Extensions ID EBX]=20=20
> Bit 27 CPPC. Read-only. Reset: 1. Collaborative Processor Performance
> Control.
>=20
> sudo cpuid -l 0x80000008 -r
> CPU 0:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
>=20
> Bit 27 =3D 0, that means BIOS didn`t enable CPPC capability, OS cannot de=
tect
> the CPPC flag on the system,=20
>=20
> you can check lscpu output,
>=20
> #lscpu |grep cppc.
>=20
> Windows maybe don`t depends on this CPUID bit, but Linux detect the CPUID
> and set cppc flag at kernel booting. no cppc flag, amd-pstate driver cann=
ot
> load so far.

Ok, I understand, so ASUS is not doing it in the standard way.

I have contacted  them and I am waiting for a response, but being more shou=
ld
bring more attention, I don't know if you Perry could do something special =
to
contact them an press them in some way, as I am aware that they only support
windows officially, I (and I think all of use in this thread) would be very
thankful to you.

Also in the case that they didn't want to make the change, what solution we
could potentially create, I have done system development a few times, I don=
't
know if it is possible to create some kind of driver of module for the kern=
el
that modified this behaviour.

Also, if all the others in this thread with the same problem could contact =
ASUS
to write a ticket, may catch their attention to this matter.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


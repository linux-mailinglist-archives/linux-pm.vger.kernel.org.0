Return-Path: <linux-pm+bounces-8142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641558CFD73
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963D11C20DF3
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B013AA40;
	Mon, 27 May 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBZFHekt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEF13AA3F
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803297; cv=none; b=XdmUUl664BM7QFADJ+H2L1k2ydwOWabfytjfEnw7w5G+ru3IQ10Mn4nrIUqVQgxOzhOOVy/RQzT+Hv+2POeyeSBFUDnOI/poHHQd6vnMM+ajM0m26javlcH1ZINDRQDQpk5JbNkOhJ/HpiOmezeIa6gTNbwGWZIIFaz7B8muyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803297; c=relaxed/simple;
	bh=5iE6+oLhQWQ6NgwNmh/g3DkzUmG1PVOGMba8fbh3a6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SE97d+FU1iA1OsV9Ox66ZFQD2MBZMXGkJ/7HjrozAB+PSkylDpDJATAZHRMHls9kx88tl/Ukn/nS1nl/WOWlLHSdHYK4tVai6E5ZsiyLCEwfFHMTWXx1l2H/+GgxIanSD1hn6DVMfWKhx4SXRomDy+eFcAqHQN6dw9MZIONrvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBZFHekt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21DF6C4AF09
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716803297;
	bh=5iE6+oLhQWQ6NgwNmh/g3DkzUmG1PVOGMba8fbh3a6g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SBZFHektYJgftUtwdwjbAMJPSp8SeNad6ha16nnjBncxvzI8rrBCRAdWGL/WIUXmI
	 QypBvYxdIK3HXSlNLpCn/6doIxBGNc8r+8075EwLC+002UkJjKEzxGuXIHH5ClC6Qx
	 vlIni8GqiSQAIChX7nNJMnur/cyzvBDHmvr27OS/Zgx/nDnMW9cNiXv1F3eW81UeKM
	 QmHGvWsb+9g8EI3ij+FVc6nO5f8Xn8jnwLWv3x7g1+e36vBIvigGJWiV3/7ItL8zVO
	 tnVDSSc64+lZ7qoQB8Ygkwfdkk3ZRc9jcVZ2R1upgdJPtWWldMq7WKOtM1AHlMSLg0
	 epdJZGflacPbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 146E2C53BB7; Mon, 27 May 2024 09:48:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 27 May 2024 09:48:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-VR8huyBRtm@https.bugzilla.kernel.org/>
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

--- Comment #54 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Mike from comment #51)
> Hi Perry,
>=20
> As requested:
>=20
> sudo rdmsr 0xc00102b3 -a
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
>=20
>=20
> sudo rdmsr 0xc00102b0 -a
> e295290f
> dc95290f
> e895290f
> d695290f
> c495290f
> ca95290f
> e895290f
> d095290f
> e295290fe295290f
> dc95290fdc95290f
> e895290fe895290f
> d695290fd695290f
> c495290fc495290f
> ca95290fca95290f
> e895290fe895290f
> d095290fd095290f
>=20
> sudo rdmsr 0xc00102b1 -a
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> 1
> sudo cpuid -l 0x80000008 -r
> CPU 0:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 1:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 2:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 3:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 4:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 5:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 6:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 7:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 8:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 9:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 10:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 11:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 12:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 13:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 14:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 15:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000


Fn80000008_EBX bit27[CPPC] =3D 0, so the CPPC function is also disabled on =
your
system now.

We have requested vendors internally to update BIOS which enables CPPC by
default, to speed up the process, I suggested users like you to submit cust=
omer
support tickets to vendors, it probably makes the release timer earlier.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


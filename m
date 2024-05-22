Return-Path: <linux-pm+bounces-8048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657868CC3E8
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 17:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213CC281078
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0D446AE;
	Wed, 22 May 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgZy3ikJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DF4437C
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390780; cv=none; b=MwtSwSt6at5Zgud+XAX5tJ+vV47qlwFBMrTRBIcHj25LQ4g07zgTcHa7gP7pi/qzeFOqPFqknipPTVnyk4wtoPxRJRf0O6HDgiOFrtBtPkzAPWu6/VwQrZcicb2SrvWS+Dd1zu9N8kG+lnTjGVs1ey0f14pQuSGXu3jeVyA1IaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390780; c=relaxed/simple;
	bh=u34fvU9lw1XDPDX3xG5vp9WEgOa77wBVXI5KicKfmyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sw05/c9Qsd3i9nAf4c0pJ77nw3Kj7vOXyKKATBxSxrFYOAC6CgImmS+BDYiDc1YWllmTXMkL8v4GMis6ufZBGaUDDk/FWK3Woqgq9zMBGGGFEFuEZ8fPQvfJQ6z1PatTzUdYGxxfzH2YDNTnPYfcGMWq7UNA2E8G9JJGb15qOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgZy3ikJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 344C2C4AF08
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716390780;
	bh=u34fvU9lw1XDPDX3xG5vp9WEgOa77wBVXI5KicKfmyE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CgZy3ikJ16/Y/iwbtvnetx7xcwxtm6x60sdeJmORKgKa9hTEIgwny25z2iYxYcgvy
	 VonXa3Pyog0N6hSvjzki5YlsHB8JqbqlJLu3jnK4RMXm1sP8Nz9eMz9ALSNC/ydbZ/
	 TSzM4/1fKYwHOHNSKBjj8scDrE4H3o9N6opggYMBTatkZrMbY7F3SniqSRYFY1cpjS
	 yMSErku4n02aAoXKptkrI+kd2zxttU1Flx5DG79fYMPSeQQyG4TkTiamwkq4zF861N
	 1vRWH4xHS3QDqCjOp/yrlyS+2LOAEtC2Cc8NvN/ceOxUWPA341g4dFJ29vJYnPbaZw
	 lD+kppzluJTmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 23155C53BB8; Wed, 22 May 2024 15:13:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 22 May 2024 15:12:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike.stokes85@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-GDHnhNxJbf@https.bugzilla.kernel.org/>
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

--- Comment #51 from Mike (mike.stokes85@gmail.com) ---
Hi Perry,

As requested:

sudo rdmsr 0xc00102b3 -a
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0


sudo rdmsr 0xc00102b0 -a
e295290f
dc95290f
e895290f
d695290f
c495290f
ca95290f
e895290f
d095290f
e295290fe295290f
dc95290fdc95290f
e895290fe895290f
d695290fd695290f
c495290fc495290f
ca95290fca95290f
e895290fe895290f
d095290fd095290f

sudo rdmsr 0xc00102b1 -a
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
sudo cpuid -l 0x80000008 -r
CPU 0:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 1:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 2:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 3:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 4:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 5:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 6:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 7:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 8:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 9:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 10:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 11:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 12:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 13:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 14:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 15:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=


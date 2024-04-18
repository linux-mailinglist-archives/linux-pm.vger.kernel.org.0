Return-Path: <linux-pm+bounces-6632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DB8A952F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767291F22CCF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17290158209;
	Thu, 18 Apr 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRcD6P8b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5293156894
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429673; cv=none; b=IokHpZZVkW6MHxTV1xyXse1Wyl4E4Ll/vduVh4aHBEj9oJbY009liTqYWvkf4uPq/LPGO4ScrH5DdbfJM2MfHOKAFIQYybybuixaxRtjiGFxVJYBED3Par/hHutBkv9QZlzXDpfFDH+sauR2C2FcYJFiN5vphAupkjiA39ptf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429673; c=relaxed/simple;
	bh=A8vf59LuUNEdxd2lASf8muLULiWxLddGemiR+V8Rlug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvnQRO/RS/PUoizXJiOJ0Ja5VaLdgq/N2m2VkpeJlfhL5LfrU5WE+Ca7pjo09jLrcU3mzJl41p+0kg48WPpbXgpKZx9KQpfPGpqGzAorDcdUIH0Vw2r8R6kxHrQ5Y7myQp1cTtQ9hr8wO6IkZcUryJTUd4r3nHLJkwDyx+XwHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRcD6P8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A605C32781
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713429672;
	bh=A8vf59LuUNEdxd2lASf8muLULiWxLddGemiR+V8Rlug=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kRcD6P8bJ5vsANba4p5xOEZ1jMXcQqNhENGkacDrHApH6mcakhRFzzY/7xvOOqcbs
	 JETkD6JgOvz/V4JsVoI7v9rxY4dJx4daZgubzCCa12nM6Vhl31jsACnzzSA3vOAn91
	 qsVquPQBMeSwwvDREYJFKR4ZqWdwNsygzeQUGskAmV7JDoGdd/Gk5UA+hLzmTtLirO
	 bjxumskt+tbxbnH8RPq7Uafbq9Eflh6mfQ3dcl0JtZ8cNsjI6is53X3CZiMFJ2uNQX
	 Sh3TKjgZNNSsfABuOo4j0C4oUtLfTAOvALzGLKKfkDDPYY5jdXN7/JtmpQx3BBhDOI
	 5pFjifYH1tmPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7AAE0C433E5; Thu, 18 Apr 2024 08:41:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 18 Apr 2024 08:41:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-FJmDO8W5s0@https.bugzilla.kernel.org/>
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

--- Comment #41 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #40)
> (In reply to al0uette from comment #39)
> > (In reply to Perry Yuan(AMD) from comment #38)
> > > Hi,
> > >=20
> > > sudo apt install cpuid
> > > sudo cpuid -l 0x80000008 -r
> > >=20
> > > Please help to provide this output.=20
> > >=20
> > > Perry.
> >=20
> > Here's the output:=20
> >=20
> > CPU 0:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 1:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 2:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 3:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 4:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 5:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 6:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 7:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 8:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 9:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 10:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 11:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 12:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 13:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 14:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
> > CPU 15:
> >    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> > edx=3D0x00010000
>=20
> thanks to share the info, I have been checking with internal teams for th=
is
> issue.  will update here if I got any progres.
>=20
> Perry.

Thank you for your help :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

